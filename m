Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348884B97B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 15:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfFSNNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 09:13:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:59574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbfFSNNZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:13:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E275EAFFE;
        Wed, 19 Jun 2019 13:13:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 90CA91E434D; Wed, 19 Jun 2019 15:13:23 +0200 (CEST)
Date:   Wed, 19 Jun 2019 15:13:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: update connector fsid cache on add mark
Message-ID: <20190619131323.GH27954@quack2.suse.cz>
References: <20190619103444.26899-1-amir73il@gmail.com>
 <20190619125345.GG27954@quack2.suse.cz>
 <CAOQ4uxgYpB0ei4cTwD0C_XVi=fM1_eOO=taNBvgFgLiks1+7SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgYpB0ei4cTwD0C_XVi=fM1_eOO=taNBvgFgLiks1+7SQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 19-06-19 16:04:04, Amir Goldstein wrote:
> On Wed, Jun 19, 2019 at 3:53 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 19-06-19 13:34:44, Amir Goldstein wrote:
> > > When implementing connector fsid cache, we only initialized the cache
> > > when the first mark added to object was added by FAN_REPORT_FID group.
> > > We forgot to update conn->fsid when the second mark is added by
> > > FAN_REPORT_FID group to an already attached connector without fsid
> > > cache.
> > >
> > > Reported-and-tested-by: syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com
> > > Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Jan,
> > >
> > > This fix has been confirmed by syzbot to fix the issue as well as
> > > by my modification to Matthew's LTP test:
> > > https://github.com/amir73il/ltp/commits/fanotify_dirent
> >
> > Thanks for the fix Amir. I somewhat don't like the additional flags field
> > (which ends up growing fsnotify_mark_connector by one long) for just that
> > one special flag. If nothing else, can't we just store the flag inside
> > 'type'? There's plenty of space there...
> 
> I didn't think it mattered in the grand scheme of things, but

Well, the connector size usually isn't a huge concern but there can be lots
of connectors when someone watches large number of files so I prefer not to
waste space unnecessarily.

> I did consider:
> -        unsigned int type;      /* Type of object [lock] */
> +        unsigned short type;      /* Type of object [lock] */
> +#define FSNOTIFY_CONN_FLAG_HAS_FSID    0x01
> +       unsigned short flags;     /* flags [lock] */
> 
> I think it makes sense.
> Let me know if you want me to resend of if you can fix on commit.

Yes, this is even less intrusive than what I had in mind. I'll apply this
change on commit. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
