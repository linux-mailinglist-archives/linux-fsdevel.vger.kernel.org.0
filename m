Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC32DB1D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 17:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgLOQsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 11:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731217AbgLOQr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608050792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvoLfPDS3GPj2oJUm//iV65orCWI3rrZ866PIW/DZco=;
        b=fg5b9iq4k/9vRJo1I/yyQTxJ+PhtxH7c0EP10fh5hTBcIHGJWiMiR5MSpwiOgKn0V8wkW9
        Ec1wpkibg5nquYyhdpaxwVEkEny36YBUs/onZ3kW+t47YB19ARhMCMNRPDaN6BOGV+aUZf
        PvpP0mohgSQPomTf2kZDTf8iV7coxC4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-OxAuev2qPNezvDptQ0c22A-1; Tue, 15 Dec 2020 11:44:01 -0500
X-MC-Unique: OxAuev2qPNezvDptQ0c22A-1
Received: by mail-qt1-f198.google.com with SMTP id i1so14700663qtw.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yvoLfPDS3GPj2oJUm//iV65orCWI3rrZ866PIW/DZco=;
        b=Y33N8+gk4n2v+/uPvdTzteG21gd9vXiLldBpHwykG7uW47gwlWC60sXzBhxAWz7nlP
         RGPNXtg4Qh9MUmn/DT4JLf+QOPIM2ijO33lDO7fnW5p/oYoUKHc0t05dJghH6EtGMG0B
         aBXLpffpFA4hYQoiWAW8DurwtRvdB8WoDAki9xySYAj8rmSJiU+zIGHsz1K6xZj0Ku7s
         Lp2dNIBWgJuvODfVImshjBi/6qSzahvqmicj2ccgMRTmvADMA+Fp6oOqKDiE7kIlm59m
         Ja3uv/cBawVjFPwkKSsd+kltKkun53CUT1yHB61P+tMNMADvII/28iVSBE6McV9xzMUn
         ySFg==
X-Gm-Message-State: AOAM530ylXc6ZD5CmCpRRt9MJDKt/fxxw0GJt7NIuiJiEGKw1f2tYidG
        Hfd20uLs8UP1nYTL2sJOF8tb93fXBktNzxocDUM+DVMDbQIK0o6FlMkTN2xK67FJdlI0t+9xmsY
        HFuuRrQPGrnv8kuTz5OtsOg3A6g==
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr38461082qvu.22.1608050640249;
        Tue, 15 Dec 2020 08:44:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMy1c5wQ24dBIZOGEhHnUL92nLjKe4utbF/3+yoD7VULpdYcfqRgLGG8zxEf2n+2LL7W+org==
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr38461064qvu.22.1608050640026;
        Tue, 15 Dec 2020 08:44:00 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id 17sm16625931qtu.23.2020.12.15.08.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:43:58 -0800 (PST)
Message-ID: <882fa590d1e77a43ff5b1d705d6f7551e309eadf.camel@redhat.com>
Subject: Re: [RFC PATCH v2 2/2] overlayfs: propagate errors from upper to
 overlay sb in sync_fs
From:   Jeff Layton <jlayton@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Date:   Tue, 15 Dec 2020 11:43:57 -0500
In-Reply-To: <20201215163058.GC63355@redhat.com>
References: <20201214221421.1127423-1-jlayton@kernel.org>
         <20201214221421.1127423-3-jlayton@kernel.org>
         <20201215163058.GC63355@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-12-15 at 11:30 -0500, Vivek Goyal wrote:
> On Mon, Dec 14, 2020 at 05:14:21PM -0500, Jeff Layton wrote:
> > Peek at the upper layer's errseq_t at mount time for volatile mounts,
> > and record it in the per-sb info. In sync_fs, check for an error since
> > the recorded point and set it in the overlayfs superblock if there was
> > one.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/overlayfs/ovl_entry.h |  1 +
> >  fs/overlayfs/super.c     | 19 ++++++++++++++-----
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index 1b5a2094df8e..f4285da50525 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -79,6 +79,7 @@ struct ovl_fs {
> >  	atomic_long_t last_ino;
> >  	/* Whiteout dentry cache */
> >  	struct dentry *whiteout;
> > +	errseq_t errseq;
> >  };
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 290983bcfbb3..3f0cb91915ff 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -264,8 +264,16 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> >  	if (!ovl_upper_mnt(ofs))
> >  		return 0;
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > -	if (!ovl_should_sync(ofs))
> > -		return 0;
> > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > +
> > +	if (!ovl_should_sync(ofs)) {
> > +		/* Propagate errors from upper to overlayfs */
> > +		ret = errseq_check(&upper_sb->s_wb_err, ofs->errseq);
> > +		if (ret)
> > +			errseq_set(&sb->s_wb_err, ret);
> > +		return ret;
> > +	}
> > +
> 
> I have few concerns here. I think ovl_sync_fs() should not be different
> for volatile mounts and non-volatile mounts. IOW, if an overlayfs
> user calls syncfs(fd), then only difference with non-volatile mount
> is that we will not call sync_filesystem() on underlying filesystem. But
> if there is an existing writeback error then that should be reported
> to syncfs(fd) caller both in case of volatile and non-volatile mounts.
> 
> Additional requirement in case of non-volatile mount seems to be that
> as soon as we detect first error, we probably should mark whole file
> system bad and start returning error for overlay operations so that
> upper layer can be thrown away and process restarted.
> 

That was the reason the patch did the errseq_set on every sync_fs
invocation for a volatile mount. That should ensure that syncfs always
returns an error. Still, there probably are cleaner ways to do this...

> And final non-volatile mount requirement seems to that we want to detect
> writeback errors in non syncfs() paths, for ex. mount(). That's what
> Sargun is trying to do. Keep a snapshot of upper_sb errseq on disk
> and upon remount of volatile overlay make sure no writeback errors
> have happened since then. And that's where I think we should be using
> new errseq_peek() and errseq_check(&upper_sb->s_wb_err, ofs->errseq)
> infracture. That way we can detect error on upper without consuming
> it upon overlay remount.
> 
> IOW, IMHO, ovl_sync_fs(), should use same mechanism to report error to
> user space both for volatile and non-volatile mounts. And this new
> mechanism of peeking at error without consuming it should be used
> in other paths like remount and possibly other overlay operations(if need
> be). 
> 
> But creating a special path in ovl_sync_fs() for volatile mounts
> only will create conflicts with error reporting for non-volatile
> mounts. And IMHO, these should be same.
> 
> Is there a good reason that why we should treat volatile and non-volatile
> mounts differently in ovl_sync_fs() from error detection and reporting
> point of view.
> 

Fair enough. I'm not that well-versed in overlayfs, so if you see a
better way to do this, then that's fine by me. I just sent this out as a
demonstration of how you could do it. Feel free to drop the second
patch.

I think the simplest solution to most of these issues is to add a new
f_op->syncfs vector. You shouldn't need to propagate errors to the ovl
sb at all if you add that. You can just operate on the upper sb's
s_wb_err, and ignore the one in the ovl sb.

> >  	/*
> >  	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
> >  	 * All the super blocks will be iterated, including upper_sb.
> > @@ -277,8 +285,6 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> >  	if (!wait)
> >  		return 0;
> >  
> > 
> > 
> > 
> > -	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > -
> >  	down_read(&upper_sb->s_umount);
> >  	ret = sync_filesystem(upper_sb);
> >  	up_read(&upper_sb->s_umount);
> > @@ -1945,8 +1951,11 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> >  
> > 
> > 
> > 
> >  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> >  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > -
> >  	}
> > +
> > +	if (ofs->config.ovl_volatile)
> > +		ofs->errseq = errseq_peek(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
> > +
> >  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
> >  	err = PTR_ERR(oe);
> >  	if (IS_ERR(oe))
> > -- 
> > 2.29.2
> > 
> 

-- 
Jeff Layton <jlayton@redhat.com>

