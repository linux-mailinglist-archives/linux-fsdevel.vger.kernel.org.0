Return-Path: <linux-fsdevel+bounces-50110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2110BAC83F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 00:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BEB1BC261A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 22:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5921CFEC;
	Thu, 29 May 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI2otdb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74115E97;
	Thu, 29 May 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748556928; cv=none; b=Q/2mfu1EHsBZmc+CA34Jnj+7aFGIiNR6ITojz6jlA0jlpwIRsjY8YclSe6qRUl9NBgX3V2wt89mQ24DwoWm41PwR20r2e477iMxWx0z0voQmxs/lobGbSjrnDMDRGXfJCksDP8gLouDpx5VvwKaPHi3Iq09MIvZDh5AGRt+TRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748556928; c=relaxed/simple;
	bh=dIulJ4txXtjAQ6LgiYZMkbwzSzmRk7QUXbfpzkD7P4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZZqF8JlmhbpWwNNzhXrrtmHzBDGzYIM3gli6Rpx/XG9RZl1heEFsE9tqbMcsJK9LlRbfchsKLs7lJ4P4yRu/haFstaZxu7RdiUl6/EBbsle/yi14GvZzEcpak0P1DoSfFanf60ONYUNaRnnjtJBh5vlgGQEQx0GZrC8wSGkXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI2otdb+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-48d71b77cc0so16501551cf.1;
        Thu, 29 May 2025 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748556925; x=1749161725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWiC5pBeYgApx7Kk+W3LliDKol1zpXNRHfgQZdX2NKo=;
        b=AI2otdb+Txa21R7/ynGK1F0C3Hx3qGvvvK5Hxi3U7ZaO7QVu93zqF1Y+8Y5PP8SY3M
         LkK2MFCTQUth0/xCsRdo7zJicV8sx/U1ZJc7ECDPHmBki86TdbW+pYV/oY7wVkJb5Niu
         HAXhXvieWf1tdwVhXwvBYin5hc6l8eFjnJ79STtNQvDJHTzqCkgcKjrpSoWBPfXWWxZW
         oZ0sAv0JfAHY3Zk6Es+Q34zWS73w4d+8vibEYIPNHMPzVa3URIfP6zXu9pPWzRAG06xD
         y19DHHSVMTuL77JwHKO/3wDo4Kczo2sl6rUqVefHgNwWj+vTuCFcZQ7LqSrjhYeSKBL/
         hVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748556925; x=1749161725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWiC5pBeYgApx7Kk+W3LliDKol1zpXNRHfgQZdX2NKo=;
        b=bqc8zTgCO5uIA1VjhxZ6vVeA3SVItNpECoRbbL/l6Px+NaDIGF3weoKfntLWmFIL5Z
         1rTO/wjIeL0QVt6A4Wbutv+N0iXLTOxN5XCpYMb5EmQz9i0SlAzoLXVmiIiPQhZ6iRyd
         4oN2DG60+2kfJph4HBG9Sz28vClvEueNNRIWVyFolQAwa0kXKqTXIhZTzrtklz1TQU+0
         El+0OQFgW40yte8Z/qbyv9LkXiCwGS/5sOmEUEX3LCNEbm4n7NPe0yZjt3xXDWYVfZsc
         s5bHm7/vYaohIh2ECm8Qe0Swb6giS6x7LGDcp9bCd39oo+UffzM7qMWnoiWbRJcYkzP1
         tbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/nCGRHLWqO57qCmHMAu5qs1SKzIKCuBNJYO6W5t/npsq9jUina5V0cOiYav2ug2PdzbeuwZrGtPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCc8nmS9jA5T8ZMcYW/5TjBflZLUiV8N+kCYTYCJ6Use79Dz53
	tp+1BA0ITLYkXW5Mqs2XU5vZqsVQhgKgYeRaXIRUO6NLCBfLXnUyEkttJg/Irmhi2hGqINToh8s
	DhO9T0lJhDTcyTwvr2JnWpCDcmnTVw5g=
X-Gm-Gg: ASbGncudns0WBszRzMKqw/h7S16VPmXRCbCGSvksJsh04uomg4LR8ioB1HtRRGFEejx
	0FEQZMCtAyd756J1+7ZsBNYQIY7EJxpEpDOWo5TxEh3hDDd372zcwt1XvqZne1Gz77J7JFVoaQ/
	28/mqZmFYh0GJoLGR6hd64ET8NP/kLW/2n/flZfGY2CnTRHLIIUlGOe1rizI4=
X-Google-Smtp-Source: AGHT+IEEGfkN1L91/XRzJnWrskxNRgmCYPLJ0g/y292xwfbtxt2lPRjc0pUX5eIgdrz7T9SuRrApbNVMA15zWowHDHs=
X-Received: by 2002:a05:622a:4d09:b0:4a4:22a1:dab8 with SMTP id
 d75a77b69052e-4a44001f7fdmr24032511cf.11.1748556925049; Thu, 29 May 2025
 15:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs> <174787195629.1483178.7917092102987513364.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195629.1483178.7917092102987513364.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 29 May 2025 15:15:13 -0700
X-Gm-Features: AX0GCFvHuJXWwmCSxxFAofe4-kh74qIPd2rzDm2lWuaDtQW3rBB11W5TkD6amKQ
Message-ID: <CAJnrk1ZEtXoMKXMjse-0RtSLjaK1zfadr3zR2tP4gh1WauOUWA@mail.gmail.com>
Subject: Re: [PATCH 03/11] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:03=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Implement functions to enable upcalling of iomap_begin and iomap_end to
> userspace fuse servers.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |   38 ++++++
>  fs/fuse/fuse_trace.h      |  258 +++++++++++++++++++++++++++++++++++++++=
++
>  include/uapi/linux/fuse.h |   87 ++++++++++++++
>  fs/fuse/Kconfig           |   23 ++++
>  fs/fuse/Makefile          |    1
>  fs/fuse/file_iomap.c      |  280 +++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/inode.c           |    5 +
>  7 files changed, 691 insertions(+), 1 deletion(-)
>  create mode 100644 fs/fuse/file_iomap.c
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index d56d4fd956db99..aa51f25856697d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -895,6 +895,9 @@ struct fuse_conn {
>         /* Is link not implemented by fs? */
>         unsigned int no_link:1;
>
> +       /* Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations *=
/
> +       unsigned int iomap:1;
> +
>         /* Use io_uring for communication */
>         unsigned int io_uring;
>
> @@ -1017,6 +1020,11 @@ static inline struct fuse_mount *get_fuse_mount_su=
per(struct super_block *sb)
>         return sb->s_fs_info;
>  }
>
> +static inline const struct fuse_mount *get_fuse_mount_super_c(const stru=
ct super_block *sb)
> +{
> +       return sb->s_fs_info;
> +}
> +

Instead of adding this new helper (and the ones below), what about
modifying the existing (non-const) versions of these helpers to take
in const * input args,  eg

-static inline struct fuse_mount *get_fuse_mount_super(struct super_block *=
sb)
+static inline struct fuse_mount *get_fuse_mount_super(const struct
super_block *sb)
 {
        return sb->s_fs_info;
 }

Then, doing something like "const struct fuse_mount *mt =3D
get_fuse_mount(inode);" would enforce the same guarantees as "const
struct fuse_mount *mt =3D get_fuse_mount_c(inode);" and we wouldn't need
2 sets of helpers that pretty much do the same thing.

>  static inline struct fuse_conn *get_fuse_conn_super(struct super_block *=
sb)
>  {
>         return get_fuse_mount_super(sb)->fc;
> @@ -1027,16 +1035,31 @@ static inline struct fuse_mount *get_fuse_mount(s=
truct inode *inode)
>         return get_fuse_mount_super(inode->i_sb);
>  }
>
> +static inline const struct fuse_mount *get_fuse_mount_c(const struct ino=
de *inode)
> +{
> +       return get_fuse_mount_super_c(inode->i_sb);
> +}
> +
>  static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
>  {
>         return get_fuse_mount_super(inode->i_sb)->fc;
>  }
>
> +static inline const struct fuse_conn *get_fuse_conn_c(const struct inode=
 *inode)
> +{
> +       return get_fuse_mount_super_c(inode->i_sb)->fc;
> +}
> +
>  static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
>  {
>         return container_of(inode, struct fuse_inode, inode);
>  }
>
> +static inline const struct fuse_inode *get_fuse_inode_c(const struct ino=
de *inode)
> +{
> +       return container_of(inode, struct fuse_inode, inode);
> +}
> +
>  static inline u64 get_node_id(struct inode *inode)
>  {
>         return get_fuse_inode(inode)->nodeid;
> @@ -1577,4 +1600,19 @@ extern void fuse_sysctl_unregister(void);
>  #define fuse_sysctl_unregister()       do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP)
> +# include <linux/fiemap.h>
> +# include <linux/iomap.h>
> +
> +bool fuse_iomap_enabled(void);
> +
> +static inline bool fuse_has_iomap(const struct inode *inode)
> +{
> +       return get_fuse_conn_c(inode)->iomap;
> +}
> +#else
> +# define fuse_iomap_enabled(...)               (false)
> +# define fuse_has_iomap(...)                   (false)
> +#endif
> +
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index ca215a3cba3e31..fc7c5bf1cef52d 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -64,6 +64,29 @@ config FUSE_PASSTHROUGH
>
>           If you want to allow passthrough operations, answer Y.
>
> +config FUSE_IOMAP
> +       bool "FUSE file IO over iomap"
> +       default y
> +       depends on FUSE_FS
> +       select FS_IOMAP
> +       help
> +         For supported fuseblk servers, this allows the file IO path to =
run
> +         through the kernel.

I have config FUSE_FS select FS_IOMAP in my patchset (not yet
submitted) that changes fuse buffered writes / writeback handling to
use iomap. Could we just have config FUSE_FS automatically opt into
FS_IOMAP here or do you see a reason that this needs to be a separate
config?


Thanks,
Joanne
> +
> +config FUSE_IOMAP_BY_DEFAULT
> +       bool "FUSE file I/O over iomap by default"
> +       default n
> +       depends on FUSE_IOMAP
> +       help
> +         Enable sending FUSE file I/O over iomap by default.
> +
> +config FUSE_IOMAP_DEBUG
> +       bool "Debug FUSE file IO over iomap"
> +       default n
> +       depends on FUSE_IOMAP
> +       help
> +         Enable debugging assertions for the fuse iomap code paths.
> +
>  config FUSE_IO_URING
>         bool "FUSE communication over io-uring"
>         default y

