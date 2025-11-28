Return-Path: <linux-fsdevel+bounces-70112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60921C90E41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 06:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BB13AB1DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13E022FE0A;
	Fri, 28 Nov 2025 05:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM0M1keb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59654654
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764308054; cv=none; b=ofmSr2Wmiym9E4rthWoyA7ZyTG1u3dvqZlrR7OZMHk5h8GZNJGxH/OY2svXz2hcb830ZYd+XpE4P2rodS6A9j+bJIEFdABcjz65LxQ7M3W0u9zaUhFXrXpQCHqOnx6C2tTva5adEDMMNolPMyrkh1dnqutUAscQqeCYGWauA1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764308054; c=relaxed/simple;
	bh=sa0yobJ3/xOiEKam9L/7i3Ew1+KU/pnvaTsLpolO1Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo+fqU+RevcKkm8IKcQz7oaDuLSGVC2Jpb8PgViYr8FDg2MpLB1p4IKGDPpeG9b831HHd5z34Y3IK2M2K/2tvA1nlcVxasA7wXJGd6GMeVv4xbYsJKoL3aCknjsfFeOmlHhTwe067aC6uXDr/o/s8tiar5u1mS/rq4i5Wcnseuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM0M1keb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5957c929a5eso2264335e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 21:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764308050; x=1764912850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXGQQ12LZv2IbcgQLCwgXv95tjMGJr8FCi/i5aj7uMs=;
        b=LM0M1kebSe9q/MZUaL0uwitiSE1/2tBMb6d7n+watVQWXsc3uLI3s7Nkjtni4r3FHc
         Zj4idtG2fIpzhuXoBC1g4oh5+FMh0962zBTJVfvZF1VLfjm0fdtC/Vio1a3Qjb1W1c01
         0MajmWgnrHZxzNE7M32HiFbdHF73ivdFHv2oL04OQCQpJ2DRYHQrNucg9clqc0jr7SJb
         dTHkk2Kzszf+VmrKQQuos8tEFq53EzdU7soG3yqPikCFYudCctLcr7AAkBWonG++fPd+
         vTt4+BlChu6mQ43Eseu/RAlg92qGEMRd2xZiv3rwLl+2EhVIZZz4TLGANi2zeMHi8ZAD
         ORZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764308050; x=1764912850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXGQQ12LZv2IbcgQLCwgXv95tjMGJr8FCi/i5aj7uMs=;
        b=qu/Y2pJhUWFtkRieASDnoNCK1d4yZsxg4Lh86t/6goFOR7Cy/LMcMTBdeMyDd/vomk
         Vk2wdHdzhZWmTQTG/qkfk6V4P6HEvej3Ia8saGgm8VQhS35Lm/p0mtEf+VDIQE8ud9Nf
         ytfwcVnBdzmc2knOsbJ2X3Irp68I2U6l5fsh0mhBvQ66DT9w2VKXdS517g+AL7auePql
         qXt1iUyc6kS6rA2P/ICHSYY+a6bhSLA7zJuYCGTTFPgC+A1Yza1steyQhGRjfUjJETcd
         9iq68ZJxU04fBMY9L/eGA03ILBvh8LEUi5J0QJRhAFA0m2NarcWdg0izm1XHWHgLasM9
         rnog==
X-Gm-Message-State: AOJu0YxDccLuATAGstZCzn0sDMtiPvHmAKpv9d6rTlrG1iOZySWgWhVK
	3WLpRCvRRUyWtgEtOR/U1yyRfe4KewMaVzSYQYzIi59fGsn2iZfmjDjfDQ6eoOES0I+dft0JSE2
	kY69Q1iSwxncWZ/xCe7IzcDchdiDN/OM=
X-Gm-Gg: ASbGnctmP0k10TpHLKFkUal2NDF+MEJGu6icXpTCUrbvQql5Ey1xtv4w7SdRWKULBQs
	mmZ4Z0JLHoGhS9k9gRvHu4QsYLcLxDyprR0CiU+p6vdIrc0mwRn6PdW9JnSBUM18rAtPplGAq0+
	JOe8ZM7cCApzn463/Er4pBFqeu+VKoALtyK0j2OFdzgQKw90lc0wbUJNtPHJgtSX6qBpI7jjJba
	Z0EQ27N6nqR5Yb4Ct02bvHVb+T2cx4rhV5hIMoTTAmrI9Awy3NLVzYzApuLvKMc3iC5RiGkI2SQ
	8xAfk1k=
X-Google-Smtp-Source: AGHT+IEG9RQbOAeUmJl1Lr6WvF/4WXTpY/ouX2PkfxxkG9l/JrT7RoO0dilopnjeGbODZUnXTaFSRbLyzHupcSdY9Hk=
X-Received: by 2002:ac2:4bc1:0:b0:595:7fed:aae9 with SMTP id
 2adb3069b0e04-596b505fc7dmr4205137e87.12.1764308050166; Thu, 27 Nov 2025
 21:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128045541.672456-1-rdunlap@infradead.org>
In-Reply-To: <20251128045541.672456-1-rdunlap@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 28 Nov 2025 14:33:53 +0900
X-Gm-Features: AWmQ_blcRSyN6BH8CxW3RxTWHtH2A1R5HFRBcev7vqdthexLjC1Z-NEhAHEeeR8
Message-ID: <CAKFNMokjF6RdQLn35fxzaVBkfv_dkwLfTEnHg9aBOG7RH-aA0A@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: convert nilfs_super_block to kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Viacheslav Dubeyko <slava@dubeyko.com>, 
	linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 1:55=E2=80=AFPM Randy Dunlap wrote:
>
> Eliminate 40+ kernel-doc warnings in nilfs2_ondisk.h by converting
> all of the struct member comments to kernel-doc comments.
>
> Fix one misnamed struct member in nilfs_direct_node.
>
> Object files before and after are the same size and content.
>
> Examples of warnings:
> Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member 's_rev_leve=
l'
>  not described in 'nilfs_super_block'
> Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member
>  's_minor_rev_level' not described in 'nilfs_super_block'
> Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member 's_magic'
>  not described in 'nilfs_super_block'
> Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member 's_bytes'
>  not described in 'nilfs_super_block'
> Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member 's_flags'
>  not described in 'nilfs_super_block'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: Viacheslav Dubeyko <slava@dubeyko.com>
> Cc: linux-nilfs@vger.kernel.org

I didn't notice that. I'll grab this. Thank you!

Ryusuke Konishi

> ---
>  include/uapi/linux/nilfs2_ondisk.h |  163 ++++++++++++++++-----------
>  1 file changed, 97 insertions(+), 66 deletions(-)
>
> --- linux-next-20251127.orig/include/uapi/linux/nilfs2_ondisk.h
> +++ linux-next-20251127/include/uapi/linux/nilfs2_ondisk.h
> @@ -133,73 +133,104 @@ struct nilfs_super_root {
>
>  /**
>   * struct nilfs_super_block - structure of super block on disk
> + * @s_rev_level:               Revision level
> + * @s_minor_rev_level:         minor revision level
> + * @s_magic:                   Magic signature
> + * @s_bytes:                   Bytes count of CRC calculation for
> + *                               this structure.  s_reserved is excluded=
.
> + * @s_flags:                   flags
> + * @s_crc_seed:                        Seed value of CRC calculation
> + * @s_sum:                     Check sum of super block
> + * @s_log_block_size:          Block size represented as follows:
> + *                               blocksize =3D 1 << (s_log_block_size + =
10)
> + * @s_nsegments:               Number of segments in filesystem
> + * @s_dev_size:                        block device size in bytes
> + * @s_first_data_block:                1st seg disk block number
> + * @s_blocks_per_segment:      number of blocks per full segment
> + * @s_r_segments_percentage:   Reserved segments percentage
> + * @s_last_cno:                        Last checkpoint number
> + * @s_last_pseg:               disk block addr pseg written last
> + * @s_last_seq:                        seq. number of seg written last
> + * @s_free_blocks_count:       Free blocks count
> + * @s_ctime:                   Creation time (execution time of newfs)
> + * @s_mtime:                   Mount time
> + * @s_wtime:                   Write time
> + * @s_mnt_count:               Mount count
> + * @s_max_mnt_count:           Maximal mount count
> + * @s_state:                   File system state
> + * @s_errors:                  Behaviour when detecting errors
> + * @s_lastcheck:               time of last check
> + * @s_checkinterval:           max. time between checks
> + * @s_creator_os:              OS
> + * @s_def_resuid:              Default uid for reserved blocks
> + * @s_def_resgid:              Default gid for reserved blocks
> + * @s_first_ino:               First non-reserved inode
> + * @s_inode_size:              Size of an inode
> + * @s_dat_entry_size:          Size of a dat entry
> + * @s_checkpoint_size:         Size of a checkpoint
> + * @s_segment_usage_size:      Size of a segment usage
> + * @s_uuid:                    128-bit uuid for volume
> + * @s_volume_name:             volume name
> + * @s_c_interval:              Commit interval of segment
> + * @s_c_block_max:             Threshold of data amount for the
> + *                               segment construction
> + * @s_feature_compat:          Compatible feature set
> + * @s_feature_compat_ro:       Read-only compatible feature set
> + * @s_feature_incompat:                Incompatible feature set
> + * @s_reserved:                        padding to the end of the block
>   */
>  struct nilfs_super_block {
> -/*00*/ __le32  s_rev_level;            /* Revision level */
> -       __le16  s_minor_rev_level;      /* minor revision level */
> -       __le16  s_magic;                /* Magic signature */
> -
> -       __le16  s_bytes;                /*
> -                                        * Bytes count of CRC calculation
> -                                        * for this structure. s_reserved
> -                                        * is excluded.
> -                                        */
> -       __le16  s_flags;                /* flags */
> -       __le32  s_crc_seed;             /* Seed value of CRC calculation =
*/
> -/*10*/ __le32  s_sum;                  /* Check sum of super block */
> -
> -       __le32  s_log_block_size;       /*
> -                                        * Block size represented as foll=
ows
> -                                        * blocksize =3D
> -                                        *     1 << (s_log_block_size + 1=
0)
> -                                        */
> -       __le64  s_nsegments;            /* Number of segments in filesyst=
em */
> -/*20*/ __le64  s_dev_size;             /* block device size in bytes */
> -       __le64  s_first_data_block;     /* 1st seg disk block number */
> -/*30*/ __le32  s_blocks_per_segment;   /* number of blocks per full segm=
ent */
> -       __le32  s_r_segments_percentage; /* Reserved segments percentage =
*/
> -
> -       __le64  s_last_cno;             /* Last checkpoint number */
> -/*40*/ __le64  s_last_pseg;            /* disk block addr pseg written l=
ast */
> -       __le64  s_last_seq;             /* seq. number of seg written las=
t */
> -/*50*/ __le64  s_free_blocks_count;    /* Free blocks count */
> -
> -       __le64  s_ctime;                /*
> -                                        * Creation time (execution time =
of
> -                                        * newfs)
> -                                        */
> -/*60*/ __le64  s_mtime;                /* Mount time */
> -       __le64  s_wtime;                /* Write time */
> -/*70*/ __le16  s_mnt_count;            /* Mount count */
> -       __le16  s_max_mnt_count;        /* Maximal mount count */
> -       __le16  s_state;                /* File system state */
> -       __le16  s_errors;               /* Behaviour when detecting error=
s */
> -       __le64  s_lastcheck;            /* time of last check */
> -
> -/*80*/ __le32  s_checkinterval;        /* max. time between checks */
> -       __le32  s_creator_os;           /* OS */
> -       __le16  s_def_resuid;           /* Default uid for reserved block=
s */
> -       __le16  s_def_resgid;           /* Default gid for reserved block=
s */
> -       __le32  s_first_ino;            /* First non-reserved inode */
> -
> -/*90*/ __le16  s_inode_size;           /* Size of an inode */
> -       __le16  s_dat_entry_size;       /* Size of a dat entry */
> -       __le16  s_checkpoint_size;      /* Size of a checkpoint */
> -       __le16  s_segment_usage_size;   /* Size of a segment usage */
> -
> -/*98*/ __u8    s_uuid[16];             /* 128-bit uuid for volume */
> -/*A8*/ char    s_volume_name[80]       /* volume name */
> -                       __kernel_nonstring;
> -
> -/*F8*/ __le32  s_c_interval;           /* Commit interval of segment */
> -       __le32  s_c_block_max;          /*
> -                                        * Threshold of data amount for
> -                                        * the segment construction
> -                                        */
> -/*100*/        __le64  s_feature_compat;       /* Compatible feature set=
 */
> -       __le64  s_feature_compat_ro;    /* Read-only compatible feature s=
et */
> -       __le64  s_feature_incompat;     /* Incompatible feature set */
> -       __u32   s_reserved[186];        /* padding to the end of the bloc=
k */
> +/*00*/ __le32  s_rev_level;
> +       __le16  s_minor_rev_level;
> +       __le16  s_magic;
> +
> +       __le16  s_bytes;
> +       __le16  s_flags;
> +       __le32  s_crc_seed;
> +/*10*/ __le32  s_sum;
> +
> +       __le32  s_log_block_size;
> +       __le64  s_nsegments;
> +/*20*/ __le64  s_dev_size;
> +       __le64  s_first_data_block;
> +/*30*/ __le32  s_blocks_per_segment;
> +       __le32  s_r_segments_percentage;
> +
> +       __le64  s_last_cno;
> +/*40*/ __le64  s_last_pseg;
> +       __le64  s_last_seq;
> +/*50*/ __le64  s_free_blocks_count;
> +
> +       __le64  s_ctime;
> +/*60*/ __le64  s_mtime;
> +       __le64  s_wtime;
> +/*70*/ __le16  s_mnt_count;
> +       __le16  s_max_mnt_count;
> +       __le16  s_state;
> +       __le16  s_errors;
> +       __le64  s_lastcheck;
> +
> +/*80*/ __le32  s_checkinterval;
> +       __le32  s_creator_os;
> +       __le16  s_def_resuid;
> +       __le16  s_def_resgid;
> +       __le32  s_first_ino;
> +
> +/*90*/ __le16  s_inode_size;
> +       __le16  s_dat_entry_size;
> +       __le16  s_checkpoint_size;
> +       __le16  s_segment_usage_size;
> +
> +/*98*/ __u8    s_uuid[16];
> +/*A8*/ char    s_volume_name[80]       __kernel_nonstring;
> +
> +/*F8*/ __le32  s_c_interval;
> +       __le32  s_c_block_max;
> +
> +/*100*/        __le64  s_feature_compat;
> +       __le64  s_feature_compat_ro;
> +       __le64  s_feature_incompat;
> +       __u32   s_reserved[186];
>  };
>
>  /*
> @@ -449,7 +480,7 @@ struct nilfs_btree_node {
>  /**
>   * struct nilfs_direct_node - header of built-in bmap array
>   * @dn_flags: flags
> - * @dn_pad: padding
> + * @pad: padding
>   */
>  struct nilfs_direct_node {
>         __u8 dn_flags;

