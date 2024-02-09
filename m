Return-Path: <linux-fsdevel+bounces-10906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8899E84F33E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FB4281FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881DA67E84;
	Fri,  9 Feb 2024 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qtl21Pkg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C24664C3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474112; cv=none; b=ZAeJ1GzKdax4V176J9EbPKCDD451/n5c1HVL0PI4JGbNM2o26wzbMV5B8iR9UPUK6L9+4BvF3clJNp+Bnwq6BFN9soN/4WPHklCGH9dxige5YXIaNMAzNJXkmYDh41lU8tSRdfrV9/RFDeJXd4Ute66Ly2Uh0fWadv7NjAf83l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474112; c=relaxed/simple;
	bh=RQA6aHp6gauJxAt5T7KUQdrJmxHHFwntw5X53uabkb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXRh5Hhyw6cDmNSyPljWEuN0u8ypDJ2qE/X+7Bw6HB3el0LlVXbaGWbr9sVBCTy+nrHUOAEek4b3u8UDcavG2Z511abkl5veDtOEUoJbG1aiJGQaEyahS0OSN6yZ2c8Tk7ckLAyU+YCDKbPj36CjaSt+uQb4Ht+nozrwFNIYafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qtl21Pkg; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3832ef7726so90065166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707474108; x=1708078908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvBL22YhgSFVRz9yydmXKe0xWtygvR12EWhM+0j2odE=;
        b=qtl21PkgLlQKw6Mz8xnFHHZcniLq53K/J6zl4WxHCCEQdPABYg98eL009lKE+GGG8D
         sB4qqFBhq3kw+8foD/n+bHSt4dnHEroyHahEMhpLeImOLLzJrBQLiSqI406NpqL3TBnQ
         CoHsqffsZ2bU3/DUpuWgNA5eM3aHtc340zNRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707474108; x=1708078908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvBL22YhgSFVRz9yydmXKe0xWtygvR12EWhM+0j2odE=;
        b=ROpX1xnwge3NowHUqtA+uU9ihXAa2FUiK/nYE4pqvKaz2FicXi2aV+9NxGU49Sm4ic
         X/xHR0S4M4PKqGQ87H5BNyAdXliRAQn/usuBAkRjCH2qmwJArubD46nB6HBSiWwwhJFb
         0cO/8ovcwogvdmoUmZoWT79Ww0zd8Q4FoQ6JFPEM8IZIXJQ7av4wA9gbTBeYmut+JhD9
         R1BlDg5UtEeadwFZWIhJ93zhvAx1cEgsgFGDf0DMQBNNUbRrCGMYa+SbfVFueB17aWti
         I/PNUCTR8LFt0SkrSQOYCwB2/qLr/ktk9ddNA02W/6NHGLsJEfZ9Bb0Oj7iPp5zJoUlT
         0LQg==
X-Gm-Message-State: AOJu0YyMpT45S3T+KomJDXxZWX5GBiZSnn6m5r4ysLigwQKRFZ+6FIT+
	TqPrdZPTP3oypcdZtjJEo7jC1OUUAae5h+4DUxVdck3w4tr0rtKPKeEFu1kEGzNp884fnEYZpbK
	h9MnT6UwWVHyvdAa83y14/MRgJqnf+OvSbZg8NQ==
X-Google-Smtp-Source: AGHT+IE3/bcM9OP0HZttZfQUm3sWrNCvfJM4/1g5xAc2YSftWevtvQOA832tJD3C/LXP4dSFGMwRDiVqmHWx2DGCtIU=
X-Received: by 2002:a17:906:28c9:b0:a38:2664:b65 with SMTP id
 p9-20020a17090628c900b00a3826640b65mr739078ejd.34.1707474108030; Fri, 09 Feb
 2024 02:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-9-amir73il@gmail.com>
In-Reply-To: <20240208170603.2078871-9-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Feb 2024 11:21:36 +0100
Message-ID: <CAJfpeguUBet0zCdESe7dasC7YpCEC816CMMRF_s1UYmgU=Ja=w@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] fuse: introduce inode io modes
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:

> We use an internal FOPEN_CACHE_IO flag to mark a file that was open in
> caching mode. This flag can not be set by the server.
>
> direct_io mmap uses page cache, so first mmap will mark the file as
> FOPEN_DIRECT_IO|FOPEN_CACHE_IO (i.e. mixed mode) and inode will enter
> the caching io mode.

I think using FOPEN_CACHE_IO for this is wrong.  Why not just an internal flag?

> +/* No more pending io and no new io possible to inode via open/mmapped file */
> +void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
> +{
> +       if (!ff->io_opened)
> +               return;
> +
> +       /* Last caching file close exits caching inode io mode */
> +       if (ff->open_flags & FOPEN_CACHE_IO)
> +               fuse_file_cached_io_end(inode);

The above is the only place where io_opened is checked without a
WARN_ON.   So can't this be incorporated into the flag indicating
whether caching is on?

Thanks,
Miklos

