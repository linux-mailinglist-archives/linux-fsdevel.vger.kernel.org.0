Return-Path: <linux-fsdevel+bounces-42353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC91A40D06
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 07:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2433E3BDF73
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 06:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80D1C84CC;
	Sun, 23 Feb 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibrKHq+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE74414
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740293436; cv=none; b=r4ooYHB6bsxL1dYiZmedrUHl81VQ/zG6o4THqpU5IhC2Bk+vuOIdW37vxKX0Pk8BQknKi4ssdraT2j/r+06jq6WdkIulTmPdSDmCaoQYNA3RN4hIYphtdXp7a/qTsmu/9mKfMpLvpfvfTa8ok2eY1dc2tC6FtT7DJwawTx3yX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740293436; c=relaxed/simple;
	bh=X4gBsmTFheL1g1VDai03X2QgBygcr2dhlM+cqOJPvLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXENPZXGX1Lt34POZ3IIgOqa2v2n9n+iAS6tLe7OIYnr8s1ZSxHQ4D84o+e1hGW8EPtz/RvKikCUtReyAABVKWWeH8MUtb6t2fIIhlkQIMPmYEd/vJAqyDAiu8cPdAsEDwAOKx1UG8DmxDRxksZQyNHaKzVwpjQuuVjbf73t7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibrKHq+u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2212222d4cdso132415ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2025 22:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740293433; x=1740898233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAjQhgFCAvazkcxHXaqcPpr/zXx43UFV7tJcDXX1GrU=;
        b=ibrKHq+uY0yeVtPKtlF2CdBnR2u1NFEpRP5vd/XjdWCxXTBGuAYPXX5IStl1S4JyuJ
         Hfgw3RhuIUdPp/H4K2gCJTSAJKy9f2NgGA5YidtAG0LZm9OEMVQzQK5BtOluTs87wxHU
         kzODfHh+F2JWzgzGoLVV2xtsNWwklIWByVboHiZz+Dfwv4a/MCaEdhfM36XPWpPkVVVJ
         T5hbbwmzB575MMFkJNKYskOLnJLJMYyIKOBVE7kcgrinhT3BkZYuoKyOA/WDOg6yazpB
         nXJDBs8SsAmcYun5rylsME4kLq5vVb4UVgqmNYLwPhFnB/CzXc0u5WGjf5o/hqWTg6dv
         iSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740293433; x=1740898233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAjQhgFCAvazkcxHXaqcPpr/zXx43UFV7tJcDXX1GrU=;
        b=hxfgackOhK6Jbwp4IAwhjlhCKhC8wKgEl5NtE/RBWJ4r5XpZHKoZwsIez+agIGP1Ga
         H99LRqx26Pyg24HOkdtgQ0FKoDSF3dWWOEZRMjjaGpCKm3ah30MCq3crdqP2/192N4im
         d50bXd1hMCErdTl1Rt7UNJ6JbWZ1pENwnKpDGGrM/1Upb72aLlF0uO0ngRVEQh1lZrIu
         02QJqGhfmaBDfwYEBuMZbroGy0NoMl1/uNxr2yIh3NLEezLbJWM8BBMxN5EWhMpb3swu
         WjTYRQoHFOyA+sNFT975hua/MhVfERN9jg/Zh8VSx0W8LAWyCixj9Bg1Co2d3C+WmESK
         25Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUU25NnndlTBYkZGeJzu0O5SFoh9zsOU2Wr1ZLQII913xJEmXUXSDepD7okIjSriXog/uN7LjAB36fbJESL@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+p6uet2wjmqpdB0DQfYAEAk2deibyI50jvz908lCbngGtRY3
	NYGNE7u5oqiiCSb++K/MakODSNXWW8Ybfq5XLhPXBx4Fi62tnHi2RC1Popox4b94w3CDkcsBlXo
	q7WloQ+3/5prrEuisIRLrRFoXnQcUYlvFfnPc
X-Gm-Gg: ASbGnctm9JBZqwdGufqDsPGx3bBiixvo2fpXMGE1im+xM4+D0LMdn7/kQPkfbQJpgqm
	juoTGgA/Z1qVZqioKBErEVSZz4G1SKaQy8XKywIykfkvD+2YtlMRlJ40HrlaT+necVBt1Zin0yA
	pwlzfDAgkzmy4UD+AFrJETFMafDKzoyTItHT831F1v
X-Google-Smtp-Source: AGHT+IHVYi8iaU7BeYmSMQQrxxaWS0KVqzhEfbSePn/tIQFWGf2DalaykOIaz7u6p/clAgVIxzuN51GHDSKrxR8SxNA=
X-Received: by 2002:a17:903:2f92:b0:21f:9f4:4a03 with SMTP id
 d9443c01a7336-2226cc1f362mr1571585ad.21.1740293433159; Sat, 22 Feb 2025
 22:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <87wmdhgr5x.fsf@gmail.com>
In-Reply-To: <87wmdhgr5x.fsf@gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Sat, 22 Feb 2025 22:50:21 -0800
X-Gm-Features: AWEUYZmd4NF7Ki1t7ZQard-ShzflDbSERfMEEeXjd54_75CVs6CUuIv_qUVWVMQ
Message-ID: <CAC_TJvf+RNjrurRYjaAWbg4fcOfc7uSDr3W_74WCUoaoB+34hQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 9:58=E2=80=AFPM Ritesh Harjani <ritesh.list@gmail.c=
om> wrote:
>
> Kalesh Singh <kaleshsingh@google.com> writes:
>
> > Hi organizers of LSF/MM,
> >
> > I realize this is a late submission, but I was hoping there might
> > still be a chance to have this topic considered for discussion.
> >
> > Problem Statement
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Readahead can result in unnecessary page cache pollution for mapped
> > regions that are never accessed. Current mechanisms to disable
> > readahead lack granularity and rather operate at the file or VMA
>
> From what I understand the readahead setting is done at the per-bdi
> level (default set to 128K). That means we don't get to control the
> amount of readahead pages needed on a per file basis. If say we can
> control the amount of readahead pages on a per open fd, will that solve
> the problem you are facing? That also means we don't need to change the
> setting for the entire system, but we can control this knob on a per fd
> basis?
>
> I just quickly hacked fcntl to allow setting no. of ra_pages in
> inode->i_ra_pages. Readahead algorithm then takes this setting whenever
> it initializes the readahead control in "file_ra_state_init()"
> So after one opens the file, we can set the fcntl F_SET_FILE_READAHEAD
> to the preferred value on the open fd.
>
>
> Note: I am not saying the implementation could be 100% correct. But it's
> just a quick working PoC to discuss whether this is the right approach
> to the given problem.

Hi Ritesh,

Thank you  for sharing the patch. I think the per=E2=80=91file approach is =
in
the right direction. However, for this case, we=E2=80=99d like to stop the
read ahead once we hit a certain boundary(s) -- somewhat like Kent
described. Rather than changing the readahead size for the entire
file, imagine that there are certain sections of the file where we
don't want the readahead to "bleed" into; for instance, ELF segment
alignment padding regions; or across different resource boundaries in
a zipped apk.

  --Kaelsh

>
> -ritesh
>
>
> <quick patch>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> fcntl: Add control to set per inode readahead pages
>
> As of now readahead setting is done in units of pages at the bdi level.
> (default 128K).
> But sometimes the user wants to have more granular control over this
> knob on a per file basis. This adds support to control readahead pages
> on an open fd.
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/btrfs/defrag.c           |  2 +-
>  fs/btrfs/free-space-cache.c |  2 +-
>  fs/btrfs/relocation.c       |  2 +-
>  fs/btrfs/send.c             |  2 +-
>  fs/cramfs/inode.c           |  2 +-
>  fs/fcntl.c                  | 44 +++++++++++++++++++++++++++++++++++++
>  fs/nfs/nfs4file.c           |  2 +-
>  fs/open.c                   |  2 +-
>  include/linux/fs.h          |  4 +++-
>  include/uapi/linux/fcntl.h  |  2 ++
>  mm/readahead.c              |  7 ++++--
>  11 files changed, 61 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 968dae953948..c6616d69a9af 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -261,7 +261,7 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_inf=
o *fs_info,
>         range.len =3D (u64)-1;
>         range.start =3D cur;
>         range.extent_thresh =3D defrag->extent_thresh;
> -       file_ra_state_init(ra, inode->i_mapping);
> +       file_ra_state_init(ra, inode);
>
>         sb_start_write(fs_info->sb);
>         ret =3D btrfs_defrag_file(inode, ra, &range, defrag->transid,
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index cfa52ef40b06..ac240b148747 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -373,7 +373,7 @@ static void readahead_cache(struct inode *inode)
>         struct file_ra_state ra;
>         unsigned long last_index;
>
> -       file_ra_state_init(&ra, inode->i_mapping);
> +       file_ra_state_init(&ra, inode);
>         last_index =3D (i_size_read(inode) - 1) >> PAGE_SHIFT;
>
>         page_cache_sync_readahead(inode->i_mapping, &ra, NULL, 0, last_in=
dex);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index bf267bdfa8f8..7688b79ae7e7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3057,7 +3057,7 @@ static int relocate_file_extent_cluster(struct relo=
c_control *rc)
>         if (ret)
>                 goto out;
>
> -       file_ra_state_init(ra, inode->i_mapping);
> +       file_ra_state_init(ra, inode);
>
>         ret =3D setup_relocation_extent_mapping(rc);
>         if (ret)
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7254279c3cc9..b22fc2a426e4 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5745,7 +5745,7 @@ static int send_extent_data(struct send_ctx *sctx, =
struct btrfs_path *path,
>                         return err;
>                 }
>                 memset(&sctx->ra, 0, sizeof(struct file_ra_state));
> -               file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping)=
;
> +               file_ra_state_init(&sctx->ra, sctx->cur_inode);
>
>                 /*
>                  * It's very likely there are no pages from this inode in=
 the page
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index b84d1747a020..917f09040f6e 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -214,7 +214,7 @@ static void *cramfs_blkdev_read(struct super_block *s=
b, unsigned int offset,
>         devsize =3D bdev_nr_bytes(sb->s_bdev) >> PAGE_SHIFT;
>
>         /* Ok, read in BLKS_PER_BUF pages completely first. */
> -       file_ra_state_init(&ra, mapping);
> +       file_ra_state_init(&ra, mapping->host);
>         page_cache_sync_readahead(mapping, &ra, NULL, blocknr, BLKS_PER_B=
UF);
>
>         for (i =3D 0; i < BLKS_PER_BUF; i++) {
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 49884fa3c81d..277afe78536f 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -394,6 +394,44 @@ static long fcntl_set_rw_hint(struct file *file, uns=
igned int cmd,
>         return 0;
>  }
>
> +static long fcntl_get_file_readahead(struct file *file, unsigned int cmd=
,
> +                             unsigned long arg)
> +{
> +       struct inode *inode =3D file_inode(file);
> +       u64 __user *argp =3D (u64 __user *)arg;
> +       u64 ra_pages =3D READ_ONCE(inode->i_ra_pages);
> +
> +       if (copy_to_user(argp, &ra_pages, sizeof(*argp)))
> +               return -EFAULT;
> +       return 0;
> +}
> +
> +
> +static long fcntl_set_file_readahead(struct file *file, unsigned int cmd=
,
> +                             unsigned long arg)
> +{
> +       struct inode *inode =3D file_inode(file);
> +       u64 __user *argp =3D (u64 __user *)arg;
> +       u64 ra_pages;
> +
> +       if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
> +               return -EPERM;
> +
> +       if (copy_from_user(&ra_pages, argp, sizeof(ra_pages)))
> +               return -EFAULT;
> +
> +       WRITE_ONCE(inode->i_ra_pages, ra_pages);
> +
> +       /*
> +        * file->f_mapping->host may differ from inode. As an example,
> +        * blkdev_open() modifies file->f_mapping.
> +        */
> +       if (file->f_mapping->host !=3D inode)
> +               WRITE_ONCE(file->f_mapping->host->i_ra_pages, ra_pages);
> +
> +       return 0;
> +}
> +
>  /* Is the file descriptor a dup of the file? */
>  static long f_dupfd_query(int fd, struct file *filp)
>  {
> @@ -552,6 +590,12 @@ static long do_fcntl(int fd, unsigned int cmd, unsig=
ned long arg,
>         case F_SET_RW_HINT:
>                 err =3D fcntl_set_rw_hint(filp, cmd, arg);
>                 break;
> +       case F_GET_FILE_READAHEAD:
> +               err =3D fcntl_get_file_readahead(filp, cmd, arg);
> +               break;
> +       case F_SET_FILE_READAHEAD:
> +               err =3D fcntl_set_file_readahead(filp, cmd, arg);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 1cd9652f3c28..cee84aa8aa0f 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -388,7 +388,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount =
*ss_mnt,
>         nfs_file_set_open_context(filep, ctx);
>         put_nfs_open_context(ctx);
>
> -       file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mappin=
g);
> +       file_ra_state_init(&filep->f_ra, filep->f_mapping->host);
>         res =3D filep;
>  out_free_name:
>         kfree(read_name);
> diff --git a/fs/open.c b/fs/open.c
> index 0f75e220b700..466c3affe161 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -961,7 +961,7 @@ static int do_dentry_open(struct file *f,
>         f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
>         f->f_iocb_flags =3D iocb_flags(f);
>
> -       file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
> +       file_ra_state_init(&f->f_ra, f->f_mapping->host);
>
>         if ((f->f_flags & O_DIRECT) && !(f->f_mode & FMODE_CAN_ODIRECT))
>                 return -EINVAL;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 12fe11b6e3dd..77ee23e30245 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -678,6 +678,8 @@ struct inode {
>         unsigned short          i_bytes;
>         u8                      i_blkbits;
>         enum rw_hint            i_write_hint;
> +       /* Per inode setting for max readahead in page_size units */
> +       unsigned long           i_ra_pages;
>         blkcnt_t                i_blocks;
>
>  #ifdef __NEED_I_SIZE_ORDERED
> @@ -3271,7 +3273,7 @@ extern ssize_t iter_file_splice_write(struct pipe_i=
node_info *,
>
>
>  extern void
> -file_ra_state_init(struct file_ra_state *ra, struct address_space *mappi=
ng);
> +file_ra_state_init(struct file_ra_state *ra, struct inode *inode);
>  extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
>  extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsiz=
e);
>  extern loff_t generic_file_llseek(struct file *file, loff_t offset, int =
whence);
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 6e6907e63bfc..b6e5413ca660 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -60,6 +60,8 @@
>  #define F_SET_RW_HINT          (F_LINUX_SPECIFIC_BASE + 12)
>  #define F_GET_FILE_RW_HINT     (F_LINUX_SPECIFIC_BASE + 13)
>  #define F_SET_FILE_RW_HINT     (F_LINUX_SPECIFIC_BASE + 14)
> +#define F_GET_FILE_READAHEAD   (F_LINUX_SPECIFIC_BASE + 15)
> +#define F_SET_FILE_READAHEAD   (F_LINUX_SPECIFIC_BASE + 16)
>
>  /*
>   * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 2bc3abf07828..71079ae1753d 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -136,9 +136,12 @@
>   * memset *ra to zero.
>   */
>  void
> -file_ra_state_init(struct file_ra_state *ra, struct address_space *mappi=
ng)
> +file_ra_state_init(struct file_ra_state *ra, struct inode *inode)
>  {
> -       ra->ra_pages =3D inode_to_bdi(mapping->host)->ra_pages;
> +       unsigned int ra_pages =3D inode->i_ra_pages ? inode->i_ra_pages :
> +                               inode_to_bdi(inode)->ra_pages;
> +
> +       ra->ra_pages =3D ra_pages;
>         ra->prev_pos =3D -1;
>  }
>  EXPORT_SYMBOL_GPL(file_ra_state_init);
>
> 2.39.5

