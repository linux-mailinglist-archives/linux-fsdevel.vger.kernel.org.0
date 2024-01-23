Return-Path: <linux-fsdevel+bounces-8526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B4838B8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29D9281E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2E5A780;
	Tue, 23 Jan 2024 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaTwoId1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219895A114;
	Tue, 23 Jan 2024 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005086; cv=none; b=kW8WBjBBUNaZ0ER/zd78dspI8ionYONYoRD9q53rnkfcczC4wwZuOMUqiUMRIs3pfQF/U1w1fK13GxaHv5+SUF92uok96lqBnAgsnLNdwFyceFGC2MorYXWeFS7MjyEAaVjocDnL2RBkX0jDFNwoLPUJWTO4pSF/Kofof4Qv+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005086; c=relaxed/simple;
	bh=WocHufAiUaZjReqsrp5whihmyJjsiJ8uRBnMqDdhU7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5NZPuEapwlp/69OgSB/t5oztqe91W2pN61KbjHhwNi59vffjTrF0ZQ70sUU3BdqEQGAJoWhTDDlAc5Z3aEpFB8YVF9Ug2/AhTsj/MyDaThiFFf6NrG2Do2hjPNBLnL+5Q5KB0e5pksKlWTt3wcqTZBxUx2oUpReXgFJCDHcUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaTwoId1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso3247166276.3;
        Tue, 23 Jan 2024 02:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706005084; x=1706609884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ML8IM+jixvlyJE555VIg0qTnvh/t9z8es3yOaphFcA=;
        b=PaTwoId1EXkU+/dfSugToV+/2Lf+8EhCswOPibnRHOe5sGtvw1RoconC0pfgBfPtZg
         80X5pn65f7//6WLBeUp7jEb9qo6gif8q+j2cJ1dGJj/Z4yiCN89DnMJfEFv42Al6k6II
         RSNjU6+gmPNgYowSOTmV3LaQaSMkMvMMTGkb9Z6yW2zwULe0CXUocxz9kRV1SVEXjzVp
         HATyPTnahUaAEqDCs7YEqBImpq4RejgxAS9hhFbNhg5hYzRh6PEU9rI/zFPXXTv5D1za
         1z5E1LrzsMIbVTG0Sy0qv9XKkHu3MnKAYE92adZIUul/7tmMk7oZv7ubq7XMzBLRSSg5
         zbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706005084; x=1706609884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ML8IM+jixvlyJE555VIg0qTnvh/t9z8es3yOaphFcA=;
        b=kc8SxQzEovKlJs5/pfB74ac2Zj+STgcQysbN/l8aluPY25Abs2yvBYmMbTHDUtWhLt
         IOKHMpy+8eudfb17n1cfykxzgBCRLBsYQu2Rx1rki+Hf/uo56ZQQqE4jo/zigHjibVEg
         hv/rmRLaQV1deTtnH8BcUC+C7Cp3JsEhujV+bHijBNjT8RgPEkdmckmnN+iUmI6m06ca
         iT2U55o3YypVXl7EMI2j/ep3v+I8vZ5qGid7FFav8B1dep7lUJZisl+SAwrx21QeweCX
         J+E05Ka4OwUrt39W4uJAMZ8gbD/yameOwlp6f/jm7HEWAADkmSxxRY4wdE2XGReQTpfh
         TK5g==
X-Gm-Message-State: AOJu0YwvsXGcfo9CSgxuNf6TbxqrDEekBCk1aoxlDZtF8rpidkHSz0Vt
	gXaNww8plYgN6/EPqZ+y3V/8hUbxMabTsBeskmYdDrPIavds6LCKDniPelM6Mt3lflbOlGjEPt0
	K6ve6YCSSnW462rVZFMvNJN3vN8Q=
X-Google-Smtp-Source: AGHT+IGD2eYr7M/fJubLG8/zYPtjd719l6RQj4yfa/hKUGiMVCuWwXTeFPh6XgHhmaZjtZusNZxMNWeymM6zkia34ok=
X-Received: by 2002:a5b:a4a:0:b0:dc2:3e3e:add3 with SMTP id
 z10-20020a5b0a4a000000b00dc23e3eadd3mr3112767ybq.4.1706005083954; Tue, 23 Jan
 2024 02:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123093701.94166-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20240123093701.94166-1-jefflexu@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Jan 2024 12:17:52 +0200
Message-ID: <CAOQ4uxgna=Eimk4KHUByk5ZRu7NKHTPJQukgV9GE_DNN_3_ztA@mail.gmail.com>
Subject: Re: [RFC] fuse: disable support for file handle when
 FUSE_EXPORT_SUPPORT not configured
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 11:37=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> I think this is more of an issue reporter.
>
> I'm not sure if it's a known issue, but we found that following a
> successful name_to_handle_at(2), open_by_handle_at(2) fails (-ESTALE,
> Stale file handle) with the given file handle when the fuse daemon is in
> "cache=3D none" mode.
>
> It can be reproduced by the examples from the man page of
> name_to_handle_at(2) and open_by_handle_at(2) [1], along with the
> virtiofsd daemon (C implementation) in "cache=3D none" mode.
>
> ```
> ./t_name_to_handle_at t_open_by_handle_at.c > /tmp/fh
> ./t_open_by_handle_at < /tmp/fh
> t_open_by_handle_at: open_by_handle_at: Stale file handle
> ```
>
> After investigation into this issue, I found the root cause is that,
> when virtiofsd is in "cache=3D none" mode, the entry_valid_timeout is
> configured as 0.  Thus the dput() called when name_to_handle_at(2)
> finishes will trigger iput -> evict(), in which FUSE_FORGET will be sent
> to the daemon.  The following open_by_handle_at(2) will trigger a new
> FUSE_LOOKUP request when no cached inode is found with the given file
> handle.  And then the fuse daemon fails the FUSE_LOOKUP request with
> -ENOENT as the cached metadata of the requested inode has already been
> cleaned up among the previous FUSE_FORGET.
>
> This indeed confuses the application, as open_by_handle_at(2) fails in
> the condition of the previous name_to_handle_at(2) succeeds, given the
> requested file is not deleted and ready there.  It is acceptable for the
> application folks to fail name_to_handle_at(2) early in this case, in
> which they will fallback to open(2) to access files.
>
>
> As for this RFC patch, the idea is that if the fuse daemon is configured
> with "cache=3Dnone" mode, FUSE_EXPORT_SUPPORT should also be explicitly
> disabled and the following name_to_handle_at(2) will all fail as a
> workaround of this issue.

This will probably regress NFS export of (many) fuse servers that do
not have FUSE_EXPORT_SUPPORT, even though you are right to point
out that those NFS exports are of dubious quality.

Not only can an NFS client get ESTALE for evicted fuse inodes, but it
can also get a completely different object for the same file handle
if that fuse server was restarted and re-exported to NFS.

>
> [1] https://man7.org/linux/man-pages/man2/open_by_handle_at.2.html
>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2a6d44f91729..9fed63be60fe 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1025,6 +1025,7 @@ static struct dentry *fuse_get_dentry(struct super_=
block *sb,
>  static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>                            struct inode *parent)
>  {
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
>         int len =3D parent ? 6 : 3;
>         u64 nodeid;
>         u32 generation;
> @@ -1034,6 +1035,9 @@ static int fuse_encode_fh(struct inode *inode, u32 =
*fh, int *max_len,
>                 return  FILEID_INVALID;
>         }
>
> +       if (!fc->export_support)
> +               return -EOPNOTSUPP;
> +
>         nodeid =3D get_fuse_inode(inode)->nodeid;
>         generation =3D inode->i_generation;
>

If you somehow find a way to mitigate the regression for NFS export of
old fuse servers (maybe an opt-in Kconfig?), your patch is also going to
regress AT_HANDLE_FID functionality, which can be used by fanotify to
monitor fuse.

AT_HANDLE_FID flag to name_to_handle_at(2) means that
open_by_handle_at(2) is not supposed to be called on that fh.

The correct way to deal with that would be something like this:

+static const struct export_operations fuse_fid_operations =3D {
+       .encode_fh      =3D fuse_encode_fh,
+};
+
 static const struct export_operations fuse_export_operations =3D {
        .fh_to_dentry   =3D fuse_fh_to_dentry,
        .fh_to_parent   =3D fuse_fh_to_parent,
@@ -1529,12 +1533,16 @@ static void fuse_fill_attr_from_inode(struct
fuse_attr *attr,

 static void fuse_sb_defaults(struct super_block *sb)
 {
+       struct fuse_mount *fm =3D get_fuse_mount_super(sb);
+
        sb->s_magic =3D FUSE_SUPER_MAGIC;
        sb->s_op =3D &fuse_super_operations;
        sb->s_xattr =3D fuse_xattr_handlers;
        sb->s_maxbytes =3D MAX_LFS_FILESIZE;
        sb->s_time_gran =3D 1;
-       sb->s_export_op =3D &fuse_export_operations;
+       if (fm->fc->export_support)
+               sb->s_export_op =3D &fuse_export_operations;
+       else
+               sb->s_export_op =3D &fuse_fid_operations;
        sb->s_iflags |=3D SB_I_IMA_UNVERIFIABLE_SIGNATURE;
        if (sb->s_user_ns !=3D &init_user_ns)
                sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;

---

This would make name_to_handle_at() without AT_HANDLE_FID fail
and name_to_handle_at() with AT_HANDLE_FID to succeed as it should.

Thanks,
Amir.

