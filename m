Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E12DE7B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 17:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgLRQ4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 11:56:47 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:36911 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgLRQ4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:56:47 -0500
Received: by mail-qk1-f171.google.com with SMTP id h4so2599747qkk.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Dec 2020 08:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yaBBAbGLKdluEqjZFx34KEUi8ofQZG/+np5+h4GIa6c=;
        b=mOYQQlz+FcVq975LKvMrQi/BHsp7zQgfkleXJy64iBTqVLcjSmBDN2D4nKG3SzlYu0
         +/NdowMp8F8pK/SVvsqhLGY4bv/MA4kQqXgojrskNjWL6j81ibXp1K9KEP/A50K5hj6r
         PH7zHhoJlgWIz1OQK9taH4RQaxrW69zmlrq1GBiHvmRhISOA1hpqNzLjGDhgdJVFRLJI
         1SaEJVV9Qdx7LeKB3l51AjwGHsv0jyDX3NUbegiHV0EhoYXxrHVKg6dEMwmGlASmCJC2
         Rd8lMEb4E3Zme4k7UkWaIXiuXX5fkUoBb0VY8mCCMt+fEgJG8wpQBn58RpKih9ih/PUK
         qWWw==
X-Gm-Message-State: AOAM531+vY2kwurlmfjU/1j+q1kvybjkBsm13rPSw7mqoAeLa6cmfsbs
        knud9BeHmoC13z49O9lS9TXRdQ==
X-Google-Smtp-Source: ABdhPJxybrVhqHdYVYr5VwjthPE0ZimLDokwRVqSQkLIMADGno6iywcAn14NOKO6tp+AHiHim9LYaQ==
X-Received: by 2002:a37:9b95:: with SMTP id d143mr5416730qke.215.1608310559472;
        Fri, 18 Dec 2020 08:55:59 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id n9sm5396865qti.75.2020.12.18.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 08:55:58 -0800 (PST)
Date:   Fri, 18 Dec 2020 11:55:51 -0500
From:   Jeffrey Layton <jlayton@kernel.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        willy@infradead.org, jack@suse.cz, neilb@suse.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/3] overlayfs: Check writeback errors w.r.t upper in
 ->syncfs()
Message-ID: <20201218165551.GA1178523@tleilax.poochiereds.net>
References: <20201216233149.39025-1-vgoyal@redhat.com>
 <20201216233149.39025-4-vgoyal@redhat.com>
 <20201217200856.GA707519@tleilax.poochiereds.net>
 <20201218144418.GA3424@redhat.com>
 <20201218150258.GA866424@tleilax.poochiereds.net>
 <20201218162819.GC3424@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218162819.GC3424@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:28:19AM -0500, Vivek Goyal wrote:
> On Fri, Dec 18, 2020 at 10:02:58AM -0500, Jeff Layton wrote:
> > On Fri, Dec 18, 2020 at 09:44:18AM -0500, Vivek Goyal wrote:
> > > On Thu, Dec 17, 2020 at 03:08:56PM -0500, Jeffrey Layton wrote:
> > > > On Wed, Dec 16, 2020 at 06:31:49PM -0500, Vivek Goyal wrote:
> > > > > Check for writeback error on overlay super block w.r.t "struct file"
> > > > > passed in ->syncfs().
> > > > > 
> > > > > As of now real error happens on upper sb. So this patch first propagates
> > > > > error from upper sb to overlay sb and then checks error w.r.t struct
> > > > > file passed in.
> > > > > 
> > > > > Jeff, I know you prefer that I should rather file upper file and check
> > > > > error directly on on upper sb w.r.t this real upper file.  While I was
> > > > > implementing that I thought what if file is on lower (and has not been
> > > > > copied up yet). In that case shall we not check writeback errors and
> > > > > return back to user space? That does not sound right though because,
> > > > > we are not checking for writeback errors on this file. Rather we
> > > > > are checking for any error on superblock. Upper might have an error
> > > > > and we should report it to user even if file in question is a lower
> > > > > file. And that's why I fell back to this approach. But I am open to
> > > > > change it if there are issues in this method.
> > > > > 
> > > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > > ---
> > > > >  fs/overlayfs/ovl_entry.h |  2 ++
> > > > >  fs/overlayfs/super.c     | 15 ++++++++++++---
> > > > >  2 files changed, 14 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > > > > index 1b5a2094df8e..a08fd719ee7b 100644
> > > > > --- a/fs/overlayfs/ovl_entry.h
> > > > > +++ b/fs/overlayfs/ovl_entry.h
> > > > > @@ -79,6 +79,8 @@ struct ovl_fs {
> > > > >  	atomic_long_t last_ino;
> > > > >  	/* Whiteout dentry cache */
> > > > >  	struct dentry *whiteout;
> > > > > +	/* Protects multiple sb->s_wb_err update from upper_sb . */
> > > > > +	spinlock_t errseq_lock;
> > > > >  };
> > > > >  
> > > > >  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> > > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > > index b4d92e6fa5ce..e7bc4492205e 100644
> > > > > --- a/fs/overlayfs/super.c
> > > > > +++ b/fs/overlayfs/super.c
> > > > > @@ -291,7 +291,7 @@ int ovl_syncfs(struct file *file)
> > > > >  	struct super_block *sb = file->f_path.dentry->d_sb;
> > > > >  	struct ovl_fs *ofs = sb->s_fs_info;
> > > > >  	struct super_block *upper_sb;
> > > > > -	int ret;
> > > > > +	int ret, ret2;
> > > > >  
> > > > >  	ret = 0;
> > > > >  	down_read(&sb->s_umount);
> > > > > @@ -310,10 +310,18 @@ int ovl_syncfs(struct file *file)
> > > > >  	ret = sync_filesystem(upper_sb);
> > > > >  	up_read(&upper_sb->s_umount);
> > > > >  
> > > > > +	/* Update overlay sb->s_wb_err */
> > > > > +	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
> > > > > +		/* Upper sb has errors since last time */
> > > > > +		spin_lock(&ofs->errseq_lock);
> > > > > +		errseq_check_and_advance(&upper_sb->s_wb_err, &sb->s_wb_err);
> > > > > +		spin_unlock(&ofs->errseq_lock);
> > > > > +	}
> > > > 
> > > > So, the problem here is that the resulting value in sb->s_wb_err is
> > > > going to end up with the REPORTED flag set (using the naming in my
> > > > latest set). So, a later opener of a file on sb->s_wb_err won't see it.
> > > > 
> > > > For instance, suppose you call sync() on the box and does the above
> > > > check and advance. Then, you open the file and call syncfs() and get
> > > > back no error because REPORTED flag was set when you opened. That error
> > > > will then be lost.
> > > 
> > > Hi Jeff,
> > > 
> > > In this patch, I am doing this only in ->syncfs() path and not in
> > > ->sync_fs() path. IOW, errseq_check_and_advance() will take place
> > > only if there is a valid "struct file" passed in. That means there
> > > is a consumer of the error and that means it should be fine to
> > > set the sb->s_wb_err as SEEN/REPORTED, right?
> > > 
> > > If we end up plumbming "struct file" in existing ->sync_fs() routine,
> > > then I will call this only if a non NULL struct file has been 
> > > passed in. Otherwise skip this step. 
> > > 
> > > IOW, sync() call will not result in errseq_check_and_advance() instead
> > > a syncfs() call will. 
> > > 
> > 
> > It still seems odd and I'm not sure you won't end up with weird corner
> > cases due to the flag handling. If you're doing this in the new
> > f_op->syncfs, then why bother with sb->s_wb_err at all? You can just do
> > this, and avoid the overlayfs sb altogether:
> > 
> > if (errseq_check(&upper_sb->s_wb_err, file->f_sb_err)) {
> > 	/* Upper sb has errors since last time */
> > 	spin_lock(&file->f_lock);
> > 	errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> > 	spin_unlock(&file->f_lock);
> > }
> > 
> > That's simpler than trying to propagate the error between two
> > errseq_t's. You would need to sample the upper_sb->s_wb_err at
> > open time in the overlayfs ->open handler though, to make sure
> > you're tracking the right one.
> 
> IIUC, you are suggesting that when and overlay file is opened (lower or
> upper), always install current upper_sb->s_wb_err in f->f_sb_err.
> IOW, overide following VFS operations.
> 
> f->f_sb_err = file_sample_sb_err(f);
> 
> In ovl_open() and ovl_dir_open() with something like.
> 
> f->f_sb_err = errseq_sample(upper_sb->s_wb_err); 
> 
> And then ->sync_fs() or ->syncfs(), can check for new errors w.r.t upper
> sb?
> 
> if (errseq_check(&upper_sb->s_wb_err, file->f_sb_err)) {
> 	/* Upper sb has errors since last time */
> 	spin_lock(&file->f_lock);
> 	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> 	spin_unlock(&file->f_lock);
> }
> 
> I guess I can try this. But if we don't update ovl_sb->s_wb_err, then
> question remains that how to avoid errseq_check_and_advance() call
> in SYSCALL(sycnfs). That will do more bad things in this case.
> 
> This will lead back to either creating new f_op->syncfs() where fs
> is responsible for writeback error checks (and not vfs). Or plumb
> "struct file" in exisitng ->sync_fs() and let filesystems do
> error checks (instead of VFS). This will be somewhat similar to your old
> proposal here.
> 
> https://lore.kernel.org/linux-fsdevel/20180518123415.28181-1-jlayton@kernel.org/
> 
> So advantage of updating ovl_sb->s_wb_err is that it reduces the
> churn needed in ->sync_fs() and moving errseq_check_and_advance()
> check out of vfs syncfs().
> 

Correct.

The patch we're discussing here _does_ add a f_op->syncfs, which is why
I was suggesting to do it that way.

> > 
> > > > 
> > > > >  
> > > > > +	ret2 = errseq_check_and_advance(&sb->s_wb_err, &file->f_sb_err);
> > > > >  out:
> > > > >  	up_read(&sb->s_umount);
> > > > > -	return ret;
> > > > > +	return ret ? ret : ret2;
> > > > >  }
> > > > >  
> > > > >  /**
> > > > > @@ -1903,6 +1911,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > >  	if (!cred)
> > > > >  		goto out_err;
> > > > >  
> > > > > +	spin_lock_init(&ofs->errseq_lock);
> > > > >  	/* Is there a reason anyone would want not to share whiteouts? */
> > > > >  	ofs->share_whiteout = true;
> > > > >  
> > > > > @@ -1975,7 +1984,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > >  
> > > > >  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> > > > >  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > > > > -
> > > > > +		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
> > > > 
> > > > This will mark the error on the upper_sb as REPORTED, and that's not
> > > > really that's the case if you're just using it set s_wb_err in the
> > > > overlay. You might want to use errseq_peek in this situation.
> > > 
> > > For now I am still looking at existing code and not new code. Because
> > > I belive that new code does not change existing behavior instead
> > > provides additional functionality to allow sampling the error without
> > > marking it seen as well as provide helper to not force seeing an
> > > unseen error.
> > > 
> > > So current errseq_sample() does not mark error SEEN. And if it is
> > > an unseen error, we will get 0 and be forced to see the error next
> > > time.
> > > 
> > > One small issue with this is that say upper has unseen error. Now
> > > we mount overlay and save that value in sb->s_wb_err (unseen). Say
> > > a file is opened on upper and error is now seen on upper. But
> > > we still have unseen error cached in overlay and if overlay fd is
> > > now opened, f->f_sb_err will be 0 and it will be forced to see
> > > err on next syncfs().
> > > 
> > > IOW, despite the fact that overlay fd was opened after upper sb had
> > > been marked seen, it still will see error. I think it probably is
> > > not a big issue.
> > > 
> > 
> > Good point. I was thinking about the newer code that may mark it
> > OBSERVED when you sample at open time.
> > 
> > Still, I think working with the overlayfs sb->s_wb_err is just adding
> > complexity for little benefit.  Assuming that writeback errors can only
> > happen on the upper layer, you're better off avoiding it.
> 
> If I want to avoid ovl_sb->s_wb_err updation, I will have to move
> ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> check in individual filesystems. And it will still not be same. Because
> currently after ->sync_fs() call, __sync_blockdev() is called and
> then we check for writeback errors. That means, I will have to
> move __sync_blockdev() also inside ->sync_fs().
> 
> Something like.
> 
> fs_sync_fs()
> {
> 	ret = do_fs_specific_sync_stuff();
> 	ret2 = __sync_blockdev();
> 	ret3 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> 	if (ret) {
> 		return ret;
> 	else
> 		return ret2 ? ret2 : ret3;
> }
> 
> Does not look pretty.
> 


If adding a new f_op approach isn't acceptable, then this is quite a bit
more difficult, and you'll need to plumb the error through from
->sync_fs to the syncfs syscall wrapper somehow.

That's the main reason I'm advocating for a new f_op. It's a lot more
straightforward, and I think it'll be less error-prone over the long
haul.

-- Jeff
