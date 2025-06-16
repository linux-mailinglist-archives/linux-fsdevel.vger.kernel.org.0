Return-Path: <linux-fsdevel+bounces-51820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C217ADBD08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 00:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6E718921E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835B223DF6;
	Mon, 16 Jun 2025 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix8z4crj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B651282EE;
	Mon, 16 Jun 2025 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113686; cv=none; b=CpTiBJDj1F6sZewbLIS+wUvknZPAo80pMcysLQC3prW4/4MnkW9ahLxe943gVt2loTtbQXtSAg8C4SoaKUWhqsiFlonKXF44uclimOr6dTQqPXisYuGiSBbm+F831GoKwXpjQyBLPqjFsoYm/j8oXYwrc5jOubTthdakpfmlgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113686; c=relaxed/simple;
	bh=inPAqPrOtDNVaozV1C1i+2LoqHXKY7Bds7t8a+M8nXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcT5NtKkKQZp4s5yRXhclLgRzV/6KDzImf1dz6sSErGVBVCRTiEDP3xzoTrf2f9qi2nZV2qdEaxA/3ozDpiJUBdkcGo2Arm1qygecxUd4ytj5Z200DusVE0m7GoRCoP9xej8ewNBqoVXWAugc+CHRxDDJElFpVnV8CVNfAVPnzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix8z4crj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f6d52af7so55378151cf.1;
        Mon, 16 Jun 2025 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750113684; x=1750718484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WL/UMQqitgkRFF+lKPomLCl0TVFnS09W2kKVqIDwx0=;
        b=Ix8z4crjl4foco5/6mRbAxo4LXBDeKh7ghq+X+zO/n5sc37ySiT+MF6aoAV5XMuimK
         y4oFi8GrjAbSaL49wJFuGlSIzLzhMI12vJFIdADw09mAGxQtbz9X2ORAoBLFrwRLIZ67
         mKCqZYDApgEAG10KmsI0EVdYfXdiooPHie4Vwq+sCjOIdhy8aRhlzj3lXc0REAjmLDM7
         NGluVij4abX9VL4ZqeMe0tsPowvIwy7CuyWdnB7SBzYc5v6E7wNCDgyC5KEj6XpKQrkk
         A0PZakELG0D7R+K5mMnAApeT4b3zGr7hnLTIbVrQBr8Vl+xqGGA3inuO2h81Sbo7xhl8
         IqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113684; x=1750718484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WL/UMQqitgkRFF+lKPomLCl0TVFnS09W2kKVqIDwx0=;
        b=deM/qh3pPSBSno6AKB1sKG1n10cXmJsaVvVjTQDh/JEa5v4fsw1S/04pjXbKrNS2sK
         igcgsnQrxxvLtCJAs/Ycn/ygTPqRZWDri5baR6zcDD/L4xLKLcRC4FJ9Zueg5PzwKLTf
         OKqBK31/UMCbq6jn/hsziVd2Z21h/swlQD+l0T8hT0TZ0NXJOvzVUkxI0BOGHdJpYigr
         Nf3RPKZkhiONm2kfBF++r3RfCqo7StreUV0Z1OiMWV7/q7UzF7gNgdqd3ipF9t3hDiIL
         LvoueGfmUo2V4HE4JBwGjRfCrElD0RWGWQ5hmuOvXwxmC/hLcolFHmbTfYAjV+4cKFHK
         4l8g==
X-Forwarded-Encrypted: i=1; AJvYcCVXvvuHfkZwC1o3vSsAWYKkgY4Ms0WyqefYRJS3NlNCrJeY4sbYhR8Dt5WHWws8eayP0SM7nlIfxvHB@vger.kernel.org, AJvYcCVj1JQlgeX2io3/kucOyqpgR1V1zJIgt88Hhky0492nW80DvBcD5pv/OuEBO73s5Qwel+uTUTs9WaPqTA==@vger.kernel.org, AJvYcCWel7zErZMjRnNs21uMb/x0xf2BLVD3fnoeeMIqdWOUQ3orI1N/7P5vJt6pCqIL1P8HKfAwitMRrxL8@vger.kernel.org, AJvYcCX9muv9NJEpdmCH3Yv9qntrroNe9yfAPT3A0Dx60eAuSwirsJAbGCf/qFV2V60libIPk8ipa+WyVZeviZO59g==@vger.kernel.org
X-Gm-Message-State: AOJu0YypLeqzq7dWzjvFpWT1a635+GZLeCRQHW/dJeKuMa1l44mxacTK
	JrOPS4Fw0lfPLl1tJRaH8jXkhTdSSIzCGJxsKadzhVV/qG4qJFet1PaH/IN9amf13J8jq5mj/b4
	DYDZKA/BONgBclX2livfuTfgbOVbn834=
X-Gm-Gg: ASbGncsKYYdO4+9QmphaRVYEzrwGy2f1Zc9N1TEEVlUhy4J8FTxnrW0jmZNd3uVpZb6
	ycPuUWfa9HfkDRV99UsYJMnesiwft7pxtsBXnOULQxebAk5befHN1Cin7VtR+fse4dcC70BKyXf
	/pWFv33H7W2wS8qP5IJPeNAXEUEsy8JqQa38rp31oRWJvNlroRr8O8AKnh6/c=
X-Google-Smtp-Source: AGHT+IHuAxsCbrWGwkw03dlSUJn9epjHOdMLKt5Zl0+G9NRpBomRwzlIH5uUAOsyo8GUgH47FEvUywiYSWAAGhG2bZY=
X-Received: by 2002:a05:622a:109:b0:48c:5c4d:68e7 with SMTP id
 d75a77b69052e-4a73c51f8f9mr162394071cf.6.1750113683870; Mon, 16 Jun 2025
 15:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616125957.3139793-1-hch@lst.de> <20250616125957.3139793-4-hch@lst.de>
In-Reply-To: <20250616125957.3139793-4-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Jun 2025 15:41:12 -0700
X-Gm-Features: AX0GCFtR--XxkERzvr8gwSYWc2aadVeMWoTPlaX86qB2gMy2QR5Xm4BOVPYXx5c
Message-ID: <CAJnrk1bFxRj=CF7g0YswktsPS=2oSBuHX6T3cyvTRRJjuAFyfw@mail.gmail.com>
Subject: Re: [PATCH 3/6] iomap: refactor the writeback interface
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Replace ->map_blocks with a new ->writeback_range, which differs in the
> following ways:
>
>  - it must also queue up the I/O for writeback, that is called into the
>    slightly refactored and extended in scope iomap_add_to_ioend for
>    each region
>  - can handle only a part of the requested region, that is the retry
>    loop for partial mappings moves to the caller
>  - handles cleanup on failures as well, and thus also replaces the
>    discard_folio method only implemented by XFS.
>
> This will allow to use the iomap writeback code also for file systems
> that are not block based like fuse.
>
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          |  23 +--
>  block/fops.c                                  |  16 +-
>  fs/gfs2/bmap.c                                |  14 +-
>  fs/iomap/buffered-io.c                        |  93 +++++------
>  fs/iomap/trace.h                              |   2 +-
>  fs/xfs/xfs_aops.c                             | 154 ++++++++++--------
>  fs/zonefs/file.c                              |  20 ++-
>  include/linux/iomap.h                         |  20 +--
>  8 files changed, 170 insertions(+), 172 deletions(-)
> diff --git a/block/fops.c b/block/fops.c
> index 3394263d942b..2f41bd0950d0 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -537,22 +537,26 @@ static void blkdev_readahead(struct readahead_contr=
ol *rac)
>         iomap_readahead(rac, &blkdev_iomap_ops);
>  }
>
> -static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
> -               struct inode *inode, loff_t offset, unsigned int len)
> +static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
> +               struct folio *folio, u64 offset, unsigned int len, u64 en=
d_pos)
>  {
> -       loff_t isize =3D i_size_read(inode);
> +       loff_t isize =3D i_size_read(wpc->inode);
> +       int error;
>
>         if (WARN_ON_ONCE(offset >=3D isize))
>                 return -EIO;
>         if (offset >=3D wpc->iomap.offset &&
>             offset < wpc->iomap.offset + wpc->iomap.length)
>                 return 0;

I'm not acquainted with the block io / bio layer so please do ignore
this if my analysis here is wrong, but AFAICT we do still need to add
this range to the ioend in the case where the mapping is already
valid? Should this be "return iomap_add_to_ioend(wpc, folio, offset,
end_pos, len)" instead of return 0? It seems like otherwise too, with
the new logic in iomap_writeback_range() function that was added,

   ret =3D wpc->ops->writeback_range(wpc, folio, pos, rlen, end_pos);
   if (WARN_ON_ONCE(ret =3D=3D 0))
        return -EIO;

returning 0 here would always result in -EIO.


> -       return blkdev_iomap_begin(inode, offset, isize - offset,
> -                                 IOMAP_WRITE, &wpc->iomap, NULL);
> +       error =3D blkdev_iomap_begin(wpc->inode, offset, isize - offset,
> +                       IOMAP_WRITE, &wpc->iomap, NULL);
> +       if (error)
> +               return error;
> +       return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
>  }
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 11a55da26a6f..5e832fa2a813 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
>
> -static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
> -               struct folio *folio, u64 pos, u64 end_pos, unsigned dirty=
_len,
> +static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> +               struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
>                 bool *wb_pending)
>  {
> -       int error;
> -
>         do {
> -               unsigned map_len;
> -
> -               error =3D wpc->ops->map_blocks(wpc, wpc->inode, pos, dirt=
y_len);
> -               if (error)
> -                       break;
> -               trace_iomap_writepage_map(wpc->inode, pos, dirty_len,
> -                               &wpc->iomap);
> -
> -               map_len =3D min_t(u64, dirty_len,
> -                       wpc->iomap.offset + wpc->iomap.length - pos);
> -               WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +               ssize_t ret;
>
> -               switch (wpc->iomap.type) {
> -               case IOMAP_INLINE:
> -                       WARN_ON_ONCE(1);
> -                       error =3D -EIO;
> -                       break;
> -               case IOMAP_HOLE:
> -                       break;
> -               default:
> -                       error =3D iomap_add_to_ioend(wpc, folio, pos, end=
_pos,
> -                                       map_len);
> -                       if (!error)
> -                               *wb_pending =3D true;
> -                       break;
> -               }
> -               dirty_len -=3D map_len;
> -               pos +=3D map_len;
> -       } while (dirty_len && !error);
> +               ret =3D wpc->ops->writeback_range(wpc, folio, pos, rlen, =
end_pos);
> +               if (WARN_ON_ONCE(ret =3D=3D 0))
> +                       return -EIO;
> +               if (ret < 0)
> +                       return ret;

Should we also add a warn check here for if ret > rlen?

> +               rlen -=3D ret;
> +               pos +=3D ret;
> +               if (wpc->iomap.type !=3D IOMAP_HOLE)
> +                       *wb_pending =3D true;
> +       } while (rlen);
>

