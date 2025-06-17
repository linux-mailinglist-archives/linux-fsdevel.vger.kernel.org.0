Return-Path: <linux-fsdevel+bounces-51969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA879ADDC37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6DF17A767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D742EAB80;
	Tue, 17 Jun 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MopxW7TR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8548F54;
	Tue, 17 Jun 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188180; cv=none; b=YDJ8sOsGov64LdkBESbNsHMbEG+VYS6n7vjUlkSJQRU9OzkjR0mQbLFap8CVfbmkhoy7bmmK+zUWBlKp9WA3JLqgtZP8mvnc94gPfihuCySq2ao7K9XAhZ71OlNshDzGLaEdDLFzsG4mcmMg+h4tnDBrvBe2Dzc3yisodEXlTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188180; c=relaxed/simple;
	bh=FfaUNO8KpPoc0RWyB1GbfrG8lv9MFVQR/RiQ8i11xlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9/729bRkBdHeblTzFws4m4RbE0NL4fDxbBysBnjkciO614AmLXKvBJMOIanNx7MZJFFnr5+2maHssITo0cEd3LDMIDkNXMQkhLIB1r72QrnXMkIOiUecBBQ1pa/9B/dYzEJemLE4umm9e34YcMuTC+lvCpycfIrR5Rtu6sVqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MopxW7TR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a43e277198so45548901cf.1;
        Tue, 17 Jun 2025 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188178; x=1750792978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTuPRhZ2hLfje0TtF5tXPw4TxRM1c2w1EC3x9NIb01o=;
        b=MopxW7TR4k2LchI9/QNRrpMmW3ftufwNl8bHIkhbiu5WIaCOgqUpTJA0VmJLe42Bmm
         kbcSpEwur6Jaa/4Roy4IzkZhqDic+QFq9vJH00RWZBO8uglcdMHs/LnusKQuHfsQ9Wd4
         3eaqxlafTaA9HF1xo5PRb6RC70K4W8Mj7nPdZ2dLclaSq4JsdGSbTXoZK8bVfAnXsqNA
         Fy3cnlz4ZFk71UxETVR2udjzIrWte8nWFe1Wpjmgcg4NCJMYURmHWPIDU9q4daXi9V6+
         a8eNtsw3LqM5lHoZTQABeYyDa3GqdXrOVtShZJ7WYrBVlRBGvEopisU9V8oJgPnrqwN7
         LQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188178; x=1750792978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTuPRhZ2hLfje0TtF5tXPw4TxRM1c2w1EC3x9NIb01o=;
        b=J2mb5Y7u4/ySZMPEQif/yBPQV5vwpC7e8Z9LNYisNGk89cYx8GbWSUevwQ7P0kD1Uf
         71Lgb8LOXflIP8XUPu56xULn+2QV1y59jXi+L1MlCAXYteFuXIPGGs5IIGqK1AzfqcB5
         rpMUI3aqLwO11V73dN6oiiGj0bq+vKtArC9ykhx6lmCWYA/9sS0TZI01nsVXcn6e4Kqv
         Aa7s+vC8zc5faM0ORxFz81YB0SuuJnE00ipMx7JPORcCReqMb7/cHXvG8izMME9Npnqn
         cg6/IOr3t7zgziILdBffCCig8PNwXzHfCLNx9yzjT/+ALC/E3tF9uKOYRHI8g7+IwPik
         8J5A==
X-Forwarded-Encrypted: i=1; AJvYcCVZKqgy5gw1aNYjIe8hjEj1CNSS93wSZE9hUep6MZLCETQlTYPGd9hfLZRlzlVhs9rDgwNB+gw/dRN6@vger.kernel.org, AJvYcCWCey6JOOehbtGmI35bv2+b/229/f2TGE0bwgESM9rWjPDk3T1pUgMV0zMEgCU/7d9Vx6FUxU+HB5yBtdzO4A==@vger.kernel.org, AJvYcCWYuDPcowY0WGXp8pT3lrpJ6s9rzzybFvHXfuDqgrG+uGR6Fi3oCD6IQ3+ULp2sdX7J7xDnTbZrQgG9EQ==@vger.kernel.org, AJvYcCWvVrfB/ZzmFigQd9x+WbV2jBPkxGVC4g8yv5HkDfnyEJMLyjb3JsCEr8NGhK+Fj/FHbgyCnhZUXwhP@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKcg/NUdHIZXohihNt7C7POOFvVWv+sZ9NSThCM09DepC3VP6
	RXOxoWnJB7F8rqk8fHXcCt5XoF+DDzrfHtj0UucOiMEwAETKk1QUZ4MbZIr74/o4oq1r9pNN617
	9OxIVXKBJLP1Rh2Po/UwUIGVp7iFXFZo=
X-Gm-Gg: ASbGncviUOjCo9d7bXtN1g7NbcVCknMnthq1Ss8v2IAtFxGJrDVWNREx3fvC/tUXqfp
	ABuYm/U31P2d31xTn+0lupIGmptiIwFp0TdJLl+YTs+pVoKyQNc62G5mXHBRW3OndIsjpN0UN1O
	WFX6/cjUNEJO/6PeJia1Lg+CPKJjBbBfQQzNfSZVjDgroYY10Y5xyKAdSXIUk+U9txR7mvXQ==
X-Google-Smtp-Source: AGHT+IHRdI3/f0y0wG23sczG3px7bi68sqYFlEBf1JzYzdrdRrmEOwVECbVEbOweo6w8hQnxNrazxSmbQ0I0Ii7zvmw=
X-Received: by 2002:ac8:5813:0:b0:4a7:1460:f1bf with SMTP id
 d75a77b69052e-4a73c4be974mr274238361cf.13.1750188177475; Tue, 17 Jun 2025
 12:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-5-hch@lst.de>
In-Reply-To: <20250617105514.3393938-5-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 12:22:46 -0700
X-Gm-Features: AX0GCFvfh7aYL5wq83zSBRZKADreiQZ79xGR92zC7vIzmrKoqBPJnWJXwA3DLRk
Message-ID: <CAJnrk1bgWwmE8XeYe4gRrYCZFwTsn5JT3Aw7B+morrOLiZowFg@mail.gmail.com>
Subject: Re: [PATCH 04/11] iomap: hide ioends from the generic writeback code
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
> one to facilitate non-block, non-ioend writeback for use.  Rename
> the submit_ioend method to writeback_submit and make it mandatory so

I'm confused as to whether this is mandatory or not - afaict from the
code, it's only needed if wpc->wb_ctx is also set. It seems like it's
ok if a filesystem doesn't define ops->writeback_submit so long as
they don't also set wpc->wb_ctx, but if they do set
ops->writeback_submit but don't set wpc->wb_ctx then they shouldn't
expect ->writeback_submit() to be called. It seems like there's a
tight interdependency between the two, it might be worth mentioning
that in the documentation to make that more clear. Or alternatively,
just always calling wpc->ops->writeback_submit() in iomap_writepages()
and having the caller check that wpc->wb_ctx is valid.

> that the generic writeback code stops seeing ioends and bios.
>
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM

> ---
>  .../filesystems/iomap/operations.rst          | 16 +---
>  block/fops.c                                  |  1 +
>  fs/gfs2/bmap.c                                |  1 +
>  fs/iomap/buffered-io.c                        | 91 ++++++++++---------
>  fs/xfs/xfs_aops.c                             | 60 ++++++------
>  fs/zonefs/file.c                              |  1 +
>  include/linux/iomap.h                         | 19 ++--
>  7 files changed, 93 insertions(+), 96 deletions(-)
>
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentati=
on/filesystems/iomap/operations.rst
> index b28f215db6e5..ead56b27ec3f 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -285,7 +285,7 @@ The ``ops`` structure must be specified and is as fol=
lows:
>   struct iomap_writeback_ops {
>      int (*writeback_range)(struct iomap_writepage_ctx *wpc,
>                 struct folio *folio, u64 pos, unsigned int len, u64 end_p=
os);
> -    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> +    int (*writeback_submit)(struct iomap_writepage_ctx *wpc, int error);
>   };
>
>  The fields are as follows:
> @@ -307,13 +307,7 @@ The fields are as follows:
>      purpose.
>      This function must be supplied by the filesystem.
>
> -  - ``submit_ioend``: Allows the file systems to hook into writeback bio
> -    submission.
> -    This might include pre-write space accounting updates, or installing
> -    a custom ``->bi_end_io`` function for internal purposes, such as
> -    deferring the ioend completion to a workqueue to run metadata update
> -    transactions from process context before submitting the bio.
> -    This function is optional.
> +  - ``writeback_submit``: Submit the previous built writeback context.

It might be helpful here to add "This function must be supplied by the
filesystem", especially since the paragraph above has that line for
writeback_range()

>
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 063e18476286..047100f94092 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -391,8 +391,7 @@ sector_t iomap_bmap(struct address_space *mapping, se=
ctor_t bno,
>  /*
>   * Structure for writeback I/O completions.
>   *
> - * File systems implementing ->submit_ioend (for buffered I/O) or ->subm=
it_io
> - * for direct I/O) can split a bio generated by iomap.  In that case the=
 parent
> + * File systems can split a bio generated by iomap.  In that case the pa=
rent
>   * ioend it was split from is recorded in ioend->io_parent.
>   */
>  struct iomap_ioend {
> @@ -416,7 +415,7 @@ static inline struct iomap_ioend *iomap_ioend_from_bi=
o(struct bio *bio)
>
>  struct iomap_writeback_ops {
>         /*
> -        * Required, performs writeback on the passed in range
> +        * Performs writeback on the passed in range

Is the reasoning behind removing "Required" that it's understood that
the default is it's required, so there's no need to explicitly state
that?

