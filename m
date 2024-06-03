Return-Path: <linux-fsdevel+bounces-20819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67208D836D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141DF1C2529E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08312D1FE;
	Mon,  3 Jun 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ALQo40WM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37912D1E9
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419850; cv=none; b=tw8ZeMM5ENSXMMO4WAhRv9iLNZJ7X5ymPe7BxO9VgJ3DUax6A+LIM3vhZuoSx/N1RH5Rot5PoP7r6iUVEL4GkgxyGQdh3CFtnYeZ08f2j2cVRAZA8yvb1C6jbQnSXBkdEG4xVZ6QZrzBlUu5GPS6qsDXITFRSSTycRsJ6aX0rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419850; c=relaxed/simple;
	bh=Rals/CP7tbWqqzx2WQO7x6pmmeRrT5/se01mRjoKuQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCBw3BJXuHckKvorAtLvu18GvgsY5b+87aBpNwa+daSzoBgHcEsquXVdTxEk0B5Sj49cCs9dySrhNNEHARLO6S++JhNphN3a8YEGdAz/TrS0pYl2mWCtdiHoDzXNUVjC6sTXYYrxOmt8Ax7+HSi/CutHqiDVOvbovmpyqd/6qsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ALQo40WM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a68b0fbd0so624885a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717419846; x=1718024646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=49OESm76Z/Z8z3R0ZypRHVq8YKgiiaQdEqJqdkxp7Tc=;
        b=ALQo40WMTVtK7tq1IGgrdhVDGI+GhFKS/+1rzE49gyEL/keMUBHotg36MiF8iY8NVF
         IiV1PYtQjnJDN+iEByZvCJ/2BTGULlMPZhQNxLWHZGjAq1rNfkxwPofLTMyz/ksx/V7Z
         grre45nCPOZEVWLyqZo9t5ZnsmPVQTyyBI7q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419846; x=1718024646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49OESm76Z/Z8z3R0ZypRHVq8YKgiiaQdEqJqdkxp7Tc=;
        b=ZZ+ISjRbkYP+2+piBgX1nJ8Xvy8k94qPC+8TKLTJCjmhQyrPtURIx6Wxux1VeZkUjR
         rzzsTf6UEb9VgFD+i7Y+7A2ZEAwU6YOpaK3Rwtop8JX+TdOO+UUU3/u2N96MlKUAI5eq
         wE3o7Tt85reNNlY2Hq3Wb2RKJi6UwzQIcU5Nv2TgKJNi7Ln4kFxy9jWmfUBWn3jN68Y0
         FY7RkSTIfDK2D97YZuY4+Eqs5gNXYnacW33xqxDuwWnrnYleY0FgyMok00bTx9Yi6NFO
         WVivlPl959lf+DrdeWpzMxAXv06eZlCbUkkmA8PwnLdpleVo3BQ7mTJ/Unk/aOtADmxv
         YvNg==
X-Forwarded-Encrypted: i=1; AJvYcCVjvFt+VXQj3Qr7+Kx7VJSP6l3hmiYNM7k6OAK0g+koYjttF1tCUbnyWOSoznG6q7KSmBHRglHlrn9kjDEAReyrZ4EGRBJm63qxG6ZbLA==
X-Gm-Message-State: AOJu0Yz1+SLZWg8c1ywA4Dm90oXXr2BHLn6FK2BFlrOuOlRhk4H+/nDE
	/rEBHKJz+qO8l3oEGrSfWkOqEmfBbNoz/+KqraqYjYedqDg1iAlVdyPpAxri1nJk2Of5O2aD+8C
	IvThHYdkgLigOpwmAbw/aRRc3T1W+80Tv3r/YnYDsD3sHWslb
X-Google-Smtp-Source: AGHT+IH9M5f7CO3x0YtJBWgh8m2H+XEl3CULxKABq0Okvu75Eo408ZAttDqMsWQvu5mnL+zRwKCPvuJGrhFQBxcymMc=
X-Received: by 2002:a17:906:3917:b0:a5a:2d30:b8c1 with SMTP id
 a640c23a62f3a-a681fa6a8dbmr567806766b.14.1717419845953; Mon, 03 Jun 2024
 06:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com> <20240529-fuse-uring-for-6-9-rfc2-out-v1-5-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-5-d149476b1d65@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Jun 2024 15:03:54 +0200
Message-ID: <CAJfpegs4ATQXyUEEsV+s3Zh_iSfyAEpAOdOfw_5iL=_uNjHQWQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 05/19] fuse: Add a uring config ioctl
To: Bernd Schubert <bschubert@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 20:01, Bernd Schubert <bschubert@ddn.com> wrote:

> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1079,12 +1079,79 @@ struct fuse_backing_map {
>         uint64_t        padding;
>  };
>
> +enum fuse_uring_ioctl_cmd {
> +       /* not correctly initialized when set */
> +       FUSE_URING_IOCTL_CMD_INVALID    = 0,
> +
> +       /* Ioctl to prepare communucation with io-uring */
> +       FUSE_URING_IOCTL_CMD_RING_CFG   = 1,
> +
> +       /* Ring queue configuration ioctl */
> +       FUSE_URING_IOCTL_CMD_QUEUE_CFG  = 2,
> +};

Is there a reason why these cannot be separate ioctl commands?

Thanks,
Miklos

