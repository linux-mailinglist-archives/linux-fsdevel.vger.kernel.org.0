Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC96812C286
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfL2NTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 08:19:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfL2NTq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 08:19:46 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7133F20748;
        Sun, 29 Dec 2019 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577625586;
        bh=Uvs+Fo1+JPdzN0Tz8dPt06V4gWYWykuZzmBlGbxYL20=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z8CrBqYRqykNjlDeKRR0PI0Lv5GBww+zRJhtlXkMVq+dPcH2Exh/lUm+7l78iQQ3h
         mhXAWCNVGUke9+QQqw4SlFjkzXQGDpsB16eNFbrTQG9KeiEjIEY3EYjHVXk6aFU2I2
         HQDIO/HGjIXIT7F76koPsYMG83Z5AXfC+1DilRO0=
Message-ID: <52abe8f14c6ef1db9c9a3327f4c1f941318945d6.camel@kernel.org>
Subject: Re: [PATCH] locks: print unsigned ino in /proc/locks
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Sun, 29 Dec 2019 08:19:44 -0500
In-Reply-To: <CAOQ4uxgJZORnBoGe=UA3j=8sfBeccv07vQes0Q9RjSVXKGrKhw@mail.gmail.com>
References: <20191222184528.32687-1-amir73il@gmail.com>
         <2f6dbf1777ae4b9870c077b8a34c79bf8ed8a554.camel@kernel.org>
         <CAOQ4uxgJZORnBoGe=UA3j=8sfBeccv07vQes0Q9RjSVXKGrKhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-23 at 04:58 +0200, Amir Goldstein wrote:
> On Mon, Dec 23, 2019 at 3:17 AM Jeff Layton <jlayton@kernel.org> wrote:
> > On Sun, 2019-12-22 at 20:45 +0200, Amir Goldstein wrote:
> > > An ino is unsigned so export it as such in /proc/locks.
> > > 
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > > 
> > > Hi Jeff,
> > > 
> > > Ran into this while writing tests to verify i_ino == d_ino == st_ino on
> > > overlayfs. In some configurations (xino=on) overlayfs sets MSB on i_ino,
> > > so /proc/locks reports negative ino values.
> > > 
> > > BTW, the requirement for (i_ino == d_ino) came from nfsd v3 readdirplus.
> > > 
> > > Thanks,
> > > Amir.
> > > 
> > >  fs/locks.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 6970f55daf54..44b6da032842 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -2853,7 +2853,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> > >       }
> > >       if (inode) {
> > >               /* userspace relies on this representation of dev_t */
> > > -             seq_printf(f, "%d %02x:%02x:%ld ", fl_pid,
> > > +             seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
> > >                               MAJOR(inode->i_sb->s_dev),
> > >                               MINOR(inode->i_sb->s_dev), inode->i_ino);
> > >       } else {
> > 
> > My that is an old bug! I think that goes back to early v2.x days, if not
> > v1.x. I'll queue it up, and maybe we can get this in for v5.6.
> 
> I suppose you meant for v5.5?
> I'd be happy if we can also mark it for stable (sorry I did not).
> Reason is that I have xfstests depending on it, which test overlay
> fixes that are marked for stable.
> 

Oh! I didn't realize the urgency. It's been in -next for a week or so
now, so I think it's probably safe enough. I'll send a PR soon, after I
give it a bit more testing.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

