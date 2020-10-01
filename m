Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B77727FD3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbgJAKYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 06:24:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgJAKYV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:24:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52B34AC2F;
        Thu,  1 Oct 2020 10:24:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 136F41E12EF; Thu,  1 Oct 2020 12:24:19 +0200 (CEST)
Date:   Thu, 1 Oct 2020 12:24:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/3] fanotify: define bit map fields to hold response
 decision  context
Message-ID: <20201001102419.GF17860@quack2.suse.cz>
References: <2745105.e9J7NaK4W3@x2>
 <20201001101219.GE17860@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001101219.GE17860@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-10-20 12:12:19, Jan Kara wrote:
> On Wed 30-09-20 12:12:28, Steve Grubb wrote:
> > This patch defines 2 bit maps within the response variable returned from
> > user space on a permission event. The first field is 3 bits for the context
> > type. The context type will describe what the meaning is of the second bit
> > field. The default is none. The patch defines one additional context type
> > which means that the second field is a rule number. This will allow for the
> > creation of 6 other context types in the future if other users of the API
> > identify different needs. The second field is 10 bits wide and can be used
> > to pass along the data described by the context. Neither of these bit maps
> > are directly adjacent and could be expanded if the need arises.
> > 
> > To support this, several macros were created to facilitate storing and
> > retrieving the values. There is also a macro for user space to check that
> > the data being sent is valid. Of course, without this check, anything that
> > overflows the bit field will trigger an EINVAL based on the use of
> > of INVALID_RESPONSE_MASK in process_access_response().
> > 
> > Signed-off-by: Steve Grubb <sgrubb@redhat.com>
> 
> So how likely do you find other context types are or that you'd need to
> further expand the information passed from userspace? Because if there are
> decent changes the expansion will be needed then I'd rather do something
> like:
> 
> struct fanotify_response {
> 	__s32 fd;
> 	__u16 response;
> 	__u16 extra_info_type;
> };
> 
> which is also backwards compatible and then userspace can set extra_info_type
> and based on the type we'd know how much more bytes we need to copy from
> buf to get additional information for that info type. 
> 
> This is much more flexible than what you propose and not that complex to
> implement, you get type safety for extra information and don't need to use
> macros to cram everything in u32 etc. Overall cleaner interface I'd say.
> 
> So in your case you'd then have something like:
> 
> #define FAN_RESPONSE_INFO_AUDIT_RULE 1
> 
> struct fanotify_response_audit_rule {
> 	__u32 rule;
> };

Now I realized we need to propagate the extra information through fanotify
permission event to audit - that can be also done relatively easily. Just
add '__u16 extra_info_type' to fanotify_perm_event and 'char
extra_info_buf[FANOTIFY_MAX_RESPONSE_EXTRA_LEN]' for now for the data. If
we ever grow larger extra info structures, we can always change this to
dynamic allocation but that will be only internal fanotify change,
userspace facing API can stay the same.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
