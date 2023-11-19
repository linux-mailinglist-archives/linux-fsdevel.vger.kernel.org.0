Return-Path: <linux-fsdevel+bounces-3135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A87F04A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 08:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95387280F0A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FAA3D6A;
	Sun, 19 Nov 2023 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ITaB51ms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A956C0;
	Sat, 18 Nov 2023 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=qRPxow4Lin+yP6p/mxJL+iQeukHr6XnYHzoDv2UvIm0=; b=ITaB51msH99gvORJbc7gSiA60v
	wCHPPZweYyt2URrh+hVEQs46TgJaGpbb3Pj6PEPjY5mRU9H0CYp8b+unFuydOECRJM7lpt0vuuA0l
	7+2hOM8P//19WS5Eo73Bcl4+uYuWA5bmKuSXKqVTQGgTlWPaeuqzKYjeM9nb6isQr5HHtNZJUo1Qa
	Epu/lg7lFvBaV7f6xUcdMOnTxfN/u4keTFiLXqITQITCeRW3pr5MQ3NTYagi9N7aYSHPtSIIdZ9tb
	Rh7mWHuGeGsSEtfrZ2zvYLyXJ0umxvyJyUFTpu9PUO11hXYR2KtxdckqAgcV0iDxq7HPSSokobQzM
	nJaiEZWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r4cCi-000AMW-2N;
	Sun, 19 Nov 2023 07:26:52 +0000
Date: Sun, 19 Nov 2023 07:26:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][overlayfs] do we still need d_instantiate_anon() and
 export of d_alloc_anon()?
Message-ID: <20231119072652.GA38156@ZenIV>
References: <20231111080400.GO1957730@ZenIV>
 <CAOQ4uxhQdHsegbwdqy_04eHVG+wkntA2g2qwt9wH8hb=-PtT2A@mail.gmail.com>
 <20231111185034.GP1957730@ZenIV>
 <CAOQ4uxjYaHk6rWUgvsFA4403Uk-hBqjGegV4CCOHZyh2LSYf4w@mail.gmail.com>
 <CAOQ4uxiJSum4a2F5FEA=a8JKwWh1XhFOpWaH8xas_uWKf+29cw@mail.gmail.com>
 <20231118200247.GF1957730@ZenIV>
 <CAOQ4uxjFrdKS3_yyeAcfemL-8dXm3JDWLwAmD9w3bY90=xfCjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjFrdKS3_yyeAcfemL-8dXm3JDWLwAmD9w3bY90=xfCjw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 19, 2023 at 08:57:25AM +0200, Amir Goldstein wrote:
> On Sat, Nov 18, 2023 at 10:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sun, Nov 12, 2023 at 09:26:28AM +0200, Amir Goldstein wrote:
> >
> > > Tested the patch below.
> > > If you want to apply it as part of dcache cleanup, it's fine by me.
> > > Otherwise, I will queue it for the next overlayfs update.
> >
> > OK...  Let's do it that way - overlayfs part goes into never-rebased branch
> > (no matter which tree), pulled into dcache series and into your overlayfs
> > update, with removal of unused stuff done in a separate patch in dcache
> > series.
> >
> 
> Sounds good.
> 
> > That way we won't step on each other's toes when reordering, etc.
> > Does that work for you?  I can put the overlayfs part into #no-rebase-overlayfs
> > in vfs.git, or you could do it in a v6.7-rc1-based branch in your tree -
> > whatever's more convenient for you.
> 
> I've reset overlayfs-next to no-rebase-overlayfs, as it  had my version
> with removal so far.
> 
> For the final update, I doubt I will need to include it at all, because
> the chances of ovl_obtain_alias() colliding with anything for the next
> cycle are pretty slim, but it's good that I have the option and I will
> anyway make sure to always test the next update with this change.

OK...  Several overlayfs locking questions:
ovl_indexdir_cleanup()
{
	...
	inode_lock_nested(dir, I_MUTEX_PARENT);
	...
		index = ovl_lookup_upper(ofs, p->name, indexdir, p->len);
		...
                        err = ovl_cleanup_and_whiteout(ofs, dir, index);

with ovl_cleanup_and_whiteout() moving stuff between workdir and parent of index.
Where do you do lock_rename()?  It's a cross-directory rename, so it *must*
lock both (and take ->s_vfs_rename_mutex as well).  How can that possibly
work?

Similar in ovl_cleanup_index() - you lock indexdir, then call
ovl_cleanup_and_whiteout(), with the same locking issues.

Another fun question: ovl_copy_up_one() has
        if (parent) {
                ovl_path_upper(parent, &parentpath);
                ctx.destdir = parentpath.dentry;
                ctx.destname = dentry->d_name;

                err = vfs_getattr(&parentpath, &ctx.pstat,
                                  STATX_ATIME | STATX_MTIME,
                                  AT_STATX_SYNC_AS_STAT);
                if (err)
                        return err;
        }
What stabilizes dentry->d_name here?  I might be missing something about the
locking environment here, so it might be OK, but...

