Return-Path: <linux-fsdevel+bounces-55434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E630FB0A5DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 16:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADAE189C4E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E81221287;
	Fri, 18 Jul 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noeL11wq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE0D14F9D6
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847837; cv=none; b=kUHAPLp9AxBhqem8hBqGpSzEFCY+qMuCs9tU4sOG8P+qnpW20mO8hF3iO3Z+5zblVbAjWQkbGAjLeVMfR5YpSJRk/XsFu9Pyvt9lMdlNP4BQpZYukskWh77vbt2zvMyCiwxA+8QPZfgee6TVJtxNTBpEtKSeEGYQ3BjMBpmXwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847837; c=relaxed/simple;
	bh=NY/e3VzIfKsf0YhP6gw92NcsqMqrw9XsxzVIG4H5sCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBrBksAHpVzQCS+7bSCAfKvGoCdux2tAmHUnc8PMrUZmA/gW4hbvmVTVEi/VAd2vOM4eP9anJwVQnCqG9UkoyrqExFLVJHrfKK+xJ6jke927TarbUdXdBcUhUB+y72TfdHmGwkHhhsf8mBrhbqi/aUizjCYzix1Ud5Tl8FzDnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noeL11wq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aec5a714ae9so223861066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752847833; x=1753452633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkN9aPcvYz/qb6vFGZxfCAAVlQx6qI5OlpQ02L5C/QI=;
        b=noeL11wqXr9on86Pjx9oeZFCTGj1d2zU67AfxSdpgnzwX2tSBGOesUzokYLdHbHHfh
         jPhY9qmaljl6PqepmwIrljqP2GhZyF/r8Eaj5MbEyGepTnKO2agKA6VeJUYesCPAJQaN
         K9fxQmtiU1VLLNQMgbXSbu8Bb7FVj82uMumiMQbeMMxG9atbhvWuwtLEqk5FvLKt1BgS
         +ls/QSzqemWuUGzixokqhB3n76VK6gpqKdWAiNOfW3V9JECqNnmFSnO2yhTUBBB51fqc
         hrz4qQ84Uq5R4zoDy0jT782uWApbUptQd0XGUVl+JHwYLAPQHOtks8bzIjEUgMkmrPmp
         Yfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847833; x=1753452633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkN9aPcvYz/qb6vFGZxfCAAVlQx6qI5OlpQ02L5C/QI=;
        b=cAefkc2SA/CiA/Y04Fz7/3ASbIV55UYfTB8EpFexVWkxCdZrZ/3nRCTbZIvPRXuPgq
         SpR8N76/3Vi3/hCsNU538LihxNb0rpPKl46PF+rt8SibA+GrHYslyJVnCIFHMFGx+vyp
         /cmCNkdtHSgewIfFeO6R8oq879jBJV94Ryav/dfIWIXagfPHW6FjkcNC8n12hXqRZAT3
         di0UJHRUdbouh0NTm/wPCUKUh1rkI4rpakUWob86mt+LxbjDLWJzQOol9TyOlRZtMQdh
         hUukHQ5TIP9cxSl+gQZoin0IU3qVbaamje9EKgSr21b/yLn+nM86SXTkh6q1io4po4PF
         u8YA==
X-Forwarded-Encrypted: i=1; AJvYcCUR7f8g1JVqSoDM9InKZl80i5JycIGX1O0Cyn9xx/KdqX/UEl4r3sDCUnMwiKFohGwrUO9CqvXy0WQ6WbTx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cMUARHijm642GgYBBShFioii9Cm9wcD8n0TPGRTSBo+Lrll/
	ubgSHDS4sGRIwE161h6thcvh0ZP+cjyinSr4XbtkJvGAGh7X6bw7Xv1Zqezw0Q0j3/k0grIPUyJ
	Vcth8EJWqzqmBPu1qAw3mhOiF9WrZNp0=
X-Gm-Gg: ASbGnctsRJbSElZj+EzmadazHWXTFvGrTxVs77iQAHYoJ12e51kKztk5d6yJgcxpB3+
	Kp5RdnP4mFL+Q84+/R1YytL1SBI1gQZ7h1KhJc/AurXmUgUSvh1L3MW6RQ/tkpikxyyA3uLDYT1
	17JND2pLBsKfDhsyR9yfpuMMaoKB8H+peDluVkfRQ8L0GRzrI9AIGgaO2Msj1uZtBo3fmShnx33
	6Wg5OI=
X-Google-Smtp-Source: AGHT+IFIcP07/Xkkjnspxakw8Pqn2XLoqcwH1MuNdXUc8oXRztvqzeWBk/GU8gCc1pLwTX4q8bEIqx1t3YwOcTh4zjo=
X-Received: by 2002:a17:907:86ab:b0:ade:6e3:7c4 with SMTP id
 a640c23a62f3a-ae9c99884edmr1081901466b.23.1752847832688; Fri, 18 Jul 2025
 07:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs> <175279459857.714161.8213814053864249949.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459857.714161.8213814053864249949.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Jul 2025 16:10:18 +0200
X-Gm-Features: Ac12FXzimVqGddF1wlh4iIUG_pcKe4WT29hqe_IQ9ZX6gh4Txh8GhwpkpOU7PPA
Message-ID: <CAOQ4uxjM6A1DpB+r+J6NU3Zj7zhGmh4138RFS8c3T6hL067fcQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] libfuse: add a reply function to send FUSE_ATTR_*
 to the kernel
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:36=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Create new fuse_reply_{attr,create,entry}_iflags functions so that we
> can send FUSE_ATTR_* flags to the kernel when instantiating an inode.
> Servers are expected to send FUSE_IFLAG_* values, which will be
> translated into what the kernel can understand.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_common.h   |    3 ++
>  include/fuse_lowlevel.h |   87 +++++++++++++++++++++++++++++++++++++++++=
++++--
>  lib/fuse_lowlevel.c     |   69 ++++++++++++++++++++++++++++++-------
>  lib/fuse_versionscript  |    4 ++
>  4 files changed, 146 insertions(+), 17 deletions(-)
>
>
> diff --git a/include/fuse_common.h b/include/fuse_common.h
> index 66c25afe15ec76..11eb22d011896c 100644
> --- a/include/fuse_common.h
> +++ b/include/fuse_common.h
> @@ -1210,6 +1210,9 @@ struct fuse_iomap {
>  /* is append ioend */
>  #define FUSE_IOMAP_IOEND_APPEND                (1U << 15)
>
> +/* enable fsdax */
> +#define FUSE_IFLAG_DAX                 (1U << 0)
> +
>  #endif /* FUSE_USE_VERSION >=3D 318 */
>
>  /* ----------------------------------------------------------- *
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index 1b856431de0a60..07748abcf079cf 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -240,6 +240,7 @@ struct fuse_lowlevel_ops {
>          *
>          * Valid replies:
>          *   fuse_reply_entry
> +        *   fuse_reply_entry_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -299,6 +300,7 @@ struct fuse_lowlevel_ops {
>          *
>          * Valid replies:
>          *   fuse_reply_attr
> +        *   fuse_reply_attr_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -334,6 +336,7 @@ struct fuse_lowlevel_ops {
>          *
>          * Valid replies:
>          *   fuse_reply_attr
> +        *   fuse_reply_attr_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -364,7 +367,7 @@ struct fuse_lowlevel_ops {
>          * socket node.
>          *
>          * Valid replies:
> -        *   fuse_reply_entry
> +        *   fuse_reply_entry_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -380,7 +383,7 @@ struct fuse_lowlevel_ops {
>          * Create a directory
>          *
>          * Valid replies:
> -        *   fuse_reply_entry
> +        *   fuse_reply_entry_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -429,7 +432,7 @@ struct fuse_lowlevel_ops {
>          * Create a symbolic link
>          *
>          * Valid replies:
> -        *   fuse_reply_entry
> +        *   fuse_reply_entry_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -477,7 +480,7 @@ struct fuse_lowlevel_ops {
>          * Create a hard link
>          *
>          * Valid replies:
> -        *   fuse_reply_entry
> +        *   fuse_reply_entry_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -969,6 +972,7 @@ struct fuse_lowlevel_ops {
>          *
>          * Valid replies:
>          *   fuse_reply_create
> +        *   fuse_reply_create_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -1315,6 +1319,7 @@ struct fuse_lowlevel_ops {
>          *
>          * Valid replies:
>          *   fuse_reply_create
> +        *   fuse_reply_create_iflags
>          *   fuse_reply_err
>          *
>          * @param req request handle
> @@ -1435,6 +1440,23 @@ void fuse_reply_none(fuse_req_t req);
>   */
>  int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e);
>
> +/**
> + * Reply with a directory entry and FUSE_IFLAG_*
> + *
> + * Possible requests:
> + *   lookup, mknod, mkdir, symlink, link
> + *
> + * Side effects:
> + *   increments the lookup count on success
> + *
> + * @param req request handle
> + * @param e the entry parameters
> + * @param iflags       FUSE_IFLAG_*
> + * @return zero for success, -errno for failure to send reply
> + */
> +int fuse_reply_entry_iflags(fuse_req_t req, const struct fuse_entry_para=
m *e,
> +                           unsigned int iflags);
> +
>  /**
>   * Reply with a directory entry and open parameters
>   *
> @@ -1456,6 +1478,29 @@ int fuse_reply_entry(fuse_req_t req, const struct =
fuse_entry_param *e);
>  int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
>                       const struct fuse_file_info *fi);
>
> +/**
> + * Reply with a directory entry, open parameters and FUSE_IFLAG_*
> + *
> + * currently the following members of 'fi' are used:
> + *   fh, direct_io, keep_cache, cache_readdir, nonseekable, noflush,
> + *   parallel_direct_writes
> + *
> + * Possible requests:
> + *   create
> + *
> + * Side effects:
> + *   increments the lookup count on success
> + *
> + * @param req request handle
> + * @param e the entry parameters
> + * @param iflags       FUSE_IFLAG_*
> + * @param fi file information
> + * @return zero for success, -errno for failure to send reply
> + */
> +int fuse_reply_create_iflags(fuse_req_t req, const struct fuse_entry_par=
am *e,
> +                            unsigned int iflags,
> +                            const struct fuse_file_info *fi);
> +
>  /**
>   * Reply with attributes
>   *
> @@ -1470,6 +1515,21 @@ int fuse_reply_create(fuse_req_t req, const struct=
 fuse_entry_param *e,
>  int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
>                     double attr_timeout);
>
> +/**
> + * Reply with attributes and FUSE_IFLAG_* flags
> + *
> + * Possible requests:
> + *   getattr, setattr
> + *
> + * @param req request handle
> + * @param attr the attributes
> + * @param attr_timeout validity timeout (in seconds) for the attributes
> + * @param iflags       set of FUSE_IFLAG_* flags
> + * @return zero for success, -errno for failure to send reply
> + */
> +int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
> +                          unsigned int iflags, double attr_timeout);
> +
>  /**
>   * Reply with the contents of a symbolic link
>   *
> @@ -1697,6 +1757,25 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char=
 *buf, size_t bufsize,
>                               const char *name,
>                               const struct fuse_entry_param *e, off_t off=
);
>
> +/**
> + * Add a directory entry and FUSE_IFLAG_* to the buffer with the attribu=
tes
> + *
> + * See documentation of `fuse_add_direntry_plus()` for more details.
> + *
> + * @param req request handle
> + * @param buf the point where the new entry will be added to the buffer
> + * @param bufsize remaining size of the buffer
> + * @param name the name of the entry
> + * @param iflags       FUSE_IFLAG_*
> + * @param e the directory entry
> + * @param off the offset of the next entry
> + * @return the space needed for the entry
> + */
> +size_t fuse_add_direntry_plus_iflags(fuse_req_t req, char *buf, size_t b=
ufsize,
> +                                    const char *name, unsigned int iflag=
s,
> +                                    const struct fuse_entry_param *e,
> +                                    off_t off);
> +
>  /**
>   * Reply to ask for data fetch and output buffer preparation.  ioctl
>   * will be retried with the specified input data fetched and output
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index d26043fa54c036..568db13502a7d7 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -102,7 +102,8 @@ static void trace_request_reply(uint64_t unique, unsi=
gned int len,
>  }
>  #endif
>
> -static void convert_stat(const struct stat *stbuf, struct fuse_attr *att=
r)
> +static void convert_stat(const struct stat *stbuf, struct fuse_attr *att=
r,
> +                        unsigned int iflags)
>  {
>         attr->ino       =3D stbuf->st_ino;
>         attr->mode      =3D stbuf->st_mode;
> @@ -119,6 +120,10 @@ static void convert_stat(const struct stat *stbuf, s=
truct fuse_attr *attr)
>         attr->atimensec =3D ST_ATIM_NSEC(stbuf);
>         attr->mtimensec =3D ST_MTIM_NSEC(stbuf);
>         attr->ctimensec =3D ST_CTIM_NSEC(stbuf);
> +
> +       attr->flags     =3D 0;
> +       if (iflags & FUSE_IFLAG_DAX)
> +               attr->flags |=3D FUSE_ATTR_DAX;
>  }
>
>  static void convert_attr(const struct fuse_setattr_in *attr, struct stat=
 *stbuf)
> @@ -438,7 +443,8 @@ static unsigned int calc_timeout_nsec(double t)
>  }
>
>  static void fill_entry(struct fuse_entry_out *arg,
> -                      const struct fuse_entry_param *e)
> +                      const struct fuse_entry_param *e,
> +                      unsigned int iflags)
>  {
>         arg->nodeid =3D e->ino;
>         arg->generation =3D e->generation;
> @@ -446,14 +452,15 @@ static void fill_entry(struct fuse_entry_out *arg,
>         arg->entry_valid_nsec =3D calc_timeout_nsec(e->entry_timeout);
>         arg->attr_valid =3D calc_timeout_sec(e->attr_timeout);
>         arg->attr_valid_nsec =3D calc_timeout_nsec(e->attr_timeout);
> -       convert_stat(&e->attr, &arg->attr);
> +       convert_stat(&e->attr, &arg->attr, iflags);
>  }
>
>  /* `buf` is allowed to be empty so that the proper size may be
>     allocated by the caller */
> -size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
> -                             const char *name,
> -                             const struct fuse_entry_param *e, off_t off=
)
> +size_t fuse_add_direntry_plus_iflags(fuse_req_t req, char *buf, size_t b=
ufsize,
> +                                    const char *name, unsigned int iflag=
s,
> +                                    const struct fuse_entry_param *e,
> +                                    off_t off)
>  {
>         (void)req;
>         size_t namelen;
> @@ -468,7 +475,7 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *b=
uf, size_t bufsize,
>
>         struct fuse_direntplus *dp =3D (struct fuse_direntplus *) buf;
>         memset(&dp->entry_out, 0, sizeof(dp->entry_out));
> -       fill_entry(&dp->entry_out, e);
> +       fill_entry(&dp->entry_out, e, iflags);
>
>         struct fuse_dirent *dirent =3D &dp->dirent;
>         dirent->ino =3D e->attr.st_ino;
> @@ -481,6 +488,14 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *=
buf, size_t bufsize,
>         return entlen_padded;
>  }
>
> +size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
> +                             const char *name,
> +                             const struct fuse_entry_param *e, off_t off=
)
> +{
> +       return fuse_add_direntry_plus_iflags(req, buf, bufsize, name, 0, =
e,
> +                                            off);
> +}
> +
>  static void fill_open(struct fuse_open_out *arg,
>                       const struct fuse_file_info *f)
>  {
> @@ -503,7 +518,8 @@ static void fill_open(struct fuse_open_out *arg,
>                 arg->open_flags |=3D FOPEN_PARALLEL_DIRECT_WRITES;
>  }
>
> -int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
> +int fuse_reply_entry_iflags(fuse_req_t req, const struct fuse_entry_para=
m *e,
> +                           unsigned int iflags)
>  {
>         struct fuse_entry_out arg;
>         size_t size =3D req->se->conn.proto_minor < 9 ?
> @@ -515,12 +531,18 @@ int fuse_reply_entry(fuse_req_t req, const struct f=
use_entry_param *e)
>                 return fuse_reply_err(req, ENOENT);
>
>         memset(&arg, 0, sizeof(arg));
> -       fill_entry(&arg, e);
> +       fill_entry(&arg, e, iflags);
>         return send_reply_ok(req, &arg, size);
>  }
>
> -int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
> -                     const struct fuse_file_info *f)
> +int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
> +{
> +       return fuse_reply_entry_iflags(req, e, 0);
> +}
> +
> +int fuse_reply_create_iflags(fuse_req_t req, const struct fuse_entry_par=
am *e,
> +                            unsigned int iflags,
> +                            const struct fuse_file_info *f)
>  {
>         alignas(uint64_t) char buf[sizeof(struct fuse_entry_out) + sizeof=
(struct fuse_open_out)];
>         size_t entrysize =3D req->se->conn.proto_minor < 9 ?
> @@ -529,12 +551,18 @@ int fuse_reply_create(fuse_req_t req, const struct =
fuse_entry_param *e,
>         struct fuse_open_out *oarg =3D (struct fuse_open_out *) (buf + en=
trysize);
>
>         memset(buf, 0, sizeof(buf));
> -       fill_entry(earg, e);
> +       fill_entry(earg, e, iflags);
>         fill_open(oarg, f);
>         return send_reply_ok(req, buf,
>                              entrysize + sizeof(struct fuse_open_out));
>  }
>
> +int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
> +                     const struct fuse_file_info *f)
> +{
> +       return fuse_reply_create_iflags(req, e, 0, f);
> +}
> +
>  int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
>                     double attr_timeout)
>  {
> @@ -545,7 +573,22 @@ int fuse_reply_attr(fuse_req_t req, const struct sta=
t *attr,
>         memset(&arg, 0, sizeof(arg));
>         arg.attr_valid =3D calc_timeout_sec(attr_timeout);
>         arg.attr_valid_nsec =3D calc_timeout_nsec(attr_timeout);
> -       convert_stat(attr, &arg.attr);
> +       convert_stat(attr, &arg.attr, 0);
> +
> +       return send_reply_ok(req, &arg, size);
> +}
> +
> +int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
> +                          unsigned int iflags, double attr_timeout)
> +{
> +       struct fuse_attr_out arg;
> +       size_t size =3D req->se->conn.proto_minor < 9 ?
> +               FUSE_COMPAT_ATTR_OUT_SIZE : sizeof(arg);
> +
> +       memset(&arg, 0, sizeof(arg));
> +       arg.attr_valid =3D calc_timeout_sec(attr_timeout);
> +       arg.attr_valid_nsec =3D calc_timeout_nsec(attr_timeout);
> +       convert_stat(attr, &arg.attr, iflags);
>
>         return send_reply_ok(req, &arg, size);
>  }

I wonder why fuse_reply_attr() is not implemented as a wrapper to
fuse_reply_attr_iflags()?

FWIW, the flags field was added in minor version 23 for
FUSE_ATTR_SUBMOUNT, but I guess that doesn't matter here.

Thanks,
Amir.

