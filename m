Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0403C14FB34
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 03:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBBCIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 21:08:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41595 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgBBCIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 21:08:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so2488465pfa.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 18:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ziz1vcIA0cAuMmJDEwXsJ9Bf+GwAVEVzYmI7RK7+MZ4=;
        b=Pr8JtpStIwbiJ/6vwi5Qc3vnBfkwjBuz5vHLmhAZH+swoWIDP0i/Wxx8L7qA9a8puM
         lr/swYhMeosVMWHXuWWSNtr7zs3La9Tj5672HbaySWn4HFPyw7LiZwHxIDmjcGnakcdG
         ucaDAPePBH8YFOJMkWH/qtl+5/mI2pIIIU82R0Mgkx8msFXimEpYk3uSdH3XN024mcpA
         gu0mGgFlV2/WhtRMCKig+lJrCK/w2oJN3HOG9s1xg0DcVgNLkd2fLsxgZjuecr7jdUcM
         97FkdVxDKpKZ95aOcbmNeCvMarylJ5QM9TCLC0SU9nbyJsoROoZHsacckpXIIpBO/u03
         0aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ziz1vcIA0cAuMmJDEwXsJ9Bf+GwAVEVzYmI7RK7+MZ4=;
        b=He29XUte8MRB+mDXu8XUEDNGpatirucobojyc1aSW4LqeTbJbIGLzJ2KE12bj9fTmO
         ND+44mxusQ7PRa7F/ao9CULYPS/QcosspQ/g0EN/5YcbjBikdLQsIgdlxN2onHMkGUi0
         SjybuJUVg5RCZBzk3fUfZr8fEMp/49aweySsxFaeYc5s8KE+ve2FFSHW9ZiunzDXz2O6
         h/RBJHSliDIYxsSCJiNKB1eESa3rVP1tZKj9aMKvJbqnzM7g9o2JM79RwBhy1fY5HPwR
         PbhIAr+hgMxqK7eyByH96sMByrFDLWsfkeZvtBniK0HDxXTgIQ2jNO6R9TNjfcJ44Ko1
         8IiQ==
X-Gm-Message-State: APjAAAXigOu5nw79XR4/KCjUvDMsgHULbMtNpknmwZPiXmewbWU/MISZ
        AfulghPSOStmnIRpUx1IXWbjvXzesjE=
X-Google-Smtp-Source: APXvYqyiatYxbdWLfqpS/HL3rq1Xco0Tw4wdLUDE/iDENt3UAjmp4AT0xM2WSDwtSrZ9kQn0GVL4jg==
X-Received: by 2002:a63:447:: with SMTP id 68mr4946255pge.97.1580609299875;
        Sat, 01 Feb 2020 18:08:19 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z18sm15516600pfk.19.2020.02.01.18.08.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Feb 2020 18:08:19 -0800 (PST)
Date:   Sun, 2 Feb 2020 10:08:17 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fuse: fix inode rwsem regression
Message-ID: <20200202020817.GA14887@cqw-OptiPlex-7050>
References: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
 <668fc86f-4214-f315-9b41-40368ba91022@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668fc86f-4214-f315-9b41-40368ba91022@fastmail.fm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 02, 2020 at 12:09:50AM +0100, Bernd Schubert wrote:
> 
> 
> On 2/1/20 6:49 AM, qiwuchen55@gmail.com wrote:
> > From: chenqiwu <chenqiwu@xiaomi.com>
> > 
> > Apparently our current rwsem code doesn't like doing the trylock, then
> > lock for real scheme.  So change our direct write method to just do the
> > trylock for the RWF_NOWAIT case.
> > This seems to fix AIM7 regression in some scalable filesystems upto ~25%
> > in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")
> > 
> > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > ---
> >  fs/fuse/file.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index ce71538..ac16994 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1529,7 +1529,13 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  	ssize_t res;
> >  
> >  	/* Don't allow parallel writes to the same file */
> > -	inode_lock(inode);
> > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > +		if (!inode_trylock(inode))
> > +			return -EAGAIN;
> > +	} else {
> > +		inode_lock(inode);
> > +	}
> > +
> >  	res = generic_write_checks(iocb, from);
> >  	if (res > 0) {
> >  		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> > 
> 
> 
> I would actually like to ask if we can do something about this lock
> altogether. Replace it with a range lock?  This very lock badly hurts
> fuse shared file performance and maybe I miss something, but it should
> be needed only for writes/reads going into the same file?
>
I think replacing the internal inode rwsem with a range lock maybe not
a good idea, because it may cause potential block for different writes/reads
routes when this range lock is owned by someone. Using internal inode rwsem
can avoid this range racy.
