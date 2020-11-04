Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE702A63B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 12:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKDLzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 06:55:20 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25308 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729647AbgKDLyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:54:36 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604490844; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=geXj8u/m7Ws6zbELpHVN95/G7vnpUUW/TLt//xuLM06R9QwOAO3d6J789fng2gBaum9KPfa47QZPqkrLofIOi9dEr9q2SGI8PH59rFHonc7CF9HcHSBmkgHR8n1F/+NsVMgRz87Zbrof1aLInZVGH0PYpfJQG+FVFue1RkT+7bM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604490844; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=HjbaZP/VD3k0TwNvh+V6Jl8V603qjIGXZ3A46Nl+JPQ=; 
        b=qSb24Fj+dgYXOMz4xc6Q7KpCigCQPO9EWFPTyaq8DXlJYX3num7P77GoO7ZzQAKN0bO3LB7ZcZ0gdWvvSVfxWdHeHSKx2W/u6TtV5tpOwT1kqjQJYMAgellWO0AfMa0uRlikC43JSpeXNvzbMp53tqkOXoM01j6j8PwDGeXesYg=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604490844;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=HjbaZP/VD3k0TwNvh+V6Jl8V603qjIGXZ3A46Nl+JPQ=;
        b=UeW0OJMd8zjV3QHJV37JRvwMVqTE8Yw8HFuMIml+MbUx2pr4IyQFCevwppNttXux
        mzBf1J9Xo4fs/JwzpPOtObYBW/GItttsT7vmSeToGbQBZYYFTBhMqN8DCRFs2QmC5eL
        7MPW0Fy2LN7W1lBKY3IqpdRVvIh5HX9x3YGL5SEE=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604490843017826.2109278233713; Wed, 4 Nov 2020 19:54:03 +0800 (CST)
Date:   Wed, 04 Nov 2020 19:54:03 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "cgxu519" <cgxu519@mykernel.net>,
        "charliecgxu" <charliecgxu@tencent.com>
Message-ID: <175931b5387.1349cecf47061.3904278910555065520@mykernel.net>
In-Reply-To: <20201102173052.GF23988@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-6-cgxu519@mykernel.net> <20201102173052.GF23988@quack2.suse.cz>
Subject: Re: [RFC PATCH v2 5/8] ovl: mark overlayfs' inode dirty on shared
 writable mmap
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2020-11-03 01:30:52 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Sun 25-10-20 11:41:14, Chengguang Xu wrote:
 > > Overlayfs cannot be notified when mmapped area gets dirty,
 > > so we need to proactively mark inode dirty in ->mmap operation.
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  fs/overlayfs/file.c | 4 ++++
 > >  1 file changed, 4 insertions(+)
 > >=20
 > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
 > > index efccb7c1f9bc..cd6fcdfd81a9 100644
 > > --- a/fs/overlayfs/file.c
 > > +++ b/fs/overlayfs/file.c
 > > @@ -486,6 +486,10 @@ static int ovl_mmap(struct file *file, struct vm_=
area_struct *vma)
 > >          /* Drop reference count from new vm_file value */
 > >          fput(realfile);
 > >      } else {
 > > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE) &&
 > > +            vma->vm_flags & (VM_WRITE|VM_MAYWRITE))
 > > +            ovl_mark_inode_dirty(file_inode(file));
 > > +
 >=20
 > But does this work reliably? I mean once writeback runs, your inode (as
 > well as upper inode) is cleaned. Then a page fault comes so file has dir=
ty
 > pages again and would need flushing but overlayfs inode stays clean? Am =
I
 > missing something?
 >=20

Yeah, this is key point of this approach, in order to  fix the issue I expl=
icitly set=20
I_DIRTY_SYNC flag in ovl_mark_inode_dirty(), so what i mean is during write=
back
we will call into ->write_inode() by this flag(I_DIRTY_SYNC) and at that pl=
ace
we get chance to check mapping and re-dirty overlay's inode. The code logic
like below in ovl_write_inode().

    if (mapping_writably_mapped(upper->i_mapping) ||
         mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
                 iflag |=3D I_DIRTY_PAGES;=20




Thanks,
Chengguang
