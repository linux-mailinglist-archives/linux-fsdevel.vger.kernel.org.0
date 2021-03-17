Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762A833F440
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 16:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhCQPsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 11:48:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhCQPsc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615996110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFzgiixZLTNF8UXp0HGJleycevWtLybmoska9MxLJ9k=;
        b=kdd6Rd1ITt9SgPEZiQlUAFhsLvUIYWkL7gw9A/kOgOEIOj0GpgVGkoaefxz2Evlt+KKkWv
        dmqGiLGzQgMsYTMEak/KLi54kMUFwpAdgeQKVcesMzGdB0vn1ZjV9fa7fqNr4mhUjYpquf
        Kf8ufL0gufZdKndFQcta/Ijfv2slBYY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93326ACA8;
        Wed, 17 Mar 2021 15:48:30 +0000 (UTC)
Date:   Wed, 17 Mar 2021 16:48:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFIkzX4d3Kpmnl8a@dhcp22.suse.cz>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
 <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
 <YFIFY7mj65sStba1@kroah.com>
 <YFIVwPWTo48ITkHs@dhcp22.suse.cz>
 <YFIYrMVTC42boZ/Z@kroah.com>
 <YFIeVLDsfBMa7fHW@dhcp22.suse.cz>
 <YFIikaNixD57o3pk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIikaNixD57o3pk@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-03-21 16:38:57, Greg KH wrote:
> On Wed, Mar 17, 2021 at 04:20:52PM +0100, Michal Hocko wrote:
> > On Wed 17-03-21 15:56:44, Greg KH wrote:
> > > On Wed, Mar 17, 2021 at 03:44:16PM +0100, Michal Hocko wrote:
> > > > On Wed 17-03-21 14:34:27, Greg KH wrote:
> > > > > On Wed, Mar 17, 2021 at 01:08:21PM +0100, Michal Hocko wrote:
> > > > > > Btw. I still have problems with the approach. seq_file is intended to
> > > > > > provide safe way to dump values to the userspace. Sacrificing
> > > > > > performance just because of some abuser seems like a wrong way to go as
> > > > > > Al pointed out earlier. Can we simply stop the abuse and disallow to
> > > > > > manipulate the buffer directly? I do realize this might be more tricky
> > > > > > for reasons mentioned in other emails but this is definitely worth
> > > > > > doing.
> > > > > 
> > > > > We have to provide a buffer to "write into" somehow, so what is the best
> > > > > way to stop "abuse" like this?
> > > > 
> > > > What is wrong about using seq_* interface directly?
> > > 
> > > Right now every show() callback of sysfs would have to be changed :(
> > 
> > Is this really the case? Would it be too ugly to have an intermediate
> > buffer and then seq_puts it into the seq file inside sysfs_kf_seq_show.
> 
> Oh, good idea.
> 
> > Sure one copy more than necessary but it this shouldn't be a hot path or
> > even visible on small strings. So that might be worth destroying an
> > inherently dangerous seq API (seq_get_buf).
> 
> I'm all for that, let me see if I can carve out some time tomorrow to
> try this out.
> 
> But, you don't get rid of the "ability" to have a driver write more than
> a PAGE_SIZE into the buffer passed to it.  I guess I could be paranoid
> and do some internal checks (allocate a bunch of memory and check for
> overflow by hand), if this is something to really be concerned about...

Yes this is certainly possible and it will needs some way to address. My
point was that we shouldn't cripple seq_file just because the API allows
for an abuse. Sysfs needs to find a way to handle internal PAGE_SIZE
buffer assumption in any case.
-- 
Michal Hocko
SUSE Labs
