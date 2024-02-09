Return-Path: <linux-fsdevel+bounces-10897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B34A84F2DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A94B21AD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8F367E61;
	Fri,  9 Feb 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="h0MIEdmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DF657B0
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472763; cv=none; b=nNMwNU58lKWwm6dSPkmyN/IW3DGJHhEjzyd8s+kdQ/yXXGD5QmeT9j7ZYBUhKK2zcYcnuI9L2q7pVxmmk+V1Df7UcvHAjPVge6y+MW7mFj0FHACvkmio9aRmH5oW3LasJhGfoIa0gxNWRV96NOept7D14/Mh0OVdOpmoLlFS4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472763; c=relaxed/simple;
	bh=j+63TQgTp0o0F+YeWyh0P7cIV8dj/P6FBesycyrQGqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jeow+9/ndgoYbEUM/CcL+f0bHbHJzmv3wqEJya61cbi4QD6kz+4RUbWf1YrEsUX5F99gDbzw88kKZbGFdzYK6lg7mDQAMS7bykxwD/8WpmgeyFjdsdFtG5jZ7UJIqhyZOxVXw5kc0IiX6d7ZifvulFSXAS0BGH3yl6pZdcEpIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=h0MIEdmG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1139440a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707472759; x=1708077559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TeGf8RX3AstO74B1MHdG4l6d6qMxtzkXYlSkKjjyYo8=;
        b=h0MIEdmGM1M8QfUlL1R3VLT53SwJB7WpLkWUvpuE+o6u6GjdEPdux7RzAnVkGZRLyD
         QDc1Pc5pGj3TSNF8qGsagtsHJlh05s0g6NOVlYqPs9V8lXuK6bOdx31lGrCY1ANC1OEd
         4D2id87zHg01qsW0lJf+7jLF1EUC2qyKQzPDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707472759; x=1708077559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeGf8RX3AstO74B1MHdG4l6d6qMxtzkXYlSkKjjyYo8=;
        b=GpyWJfAojlKS1314PmUZtfOj24h/Cu4IYcNuLvdi8KxrMlKQvY8diFkADn5Un+b+dp
         ikrYmg/ZX6kyF6kb08A3YLSdBNxvhcxtJFd9OnpqD/qGXMvggvHZUnPTZ2ffVodhonAM
         6BWSJi3b4MBOz7Ue8D6Gt9gc0BlCjhsG0XZ6Wzb3FBzF3yHTRwELUXV6wI4RxD2T6lYz
         JpHTgxu4ekmE48s1w5ujOFu+21Ti6rHbNXJjvBRgt7nxc99kiRMoUSBDuU3Q2C8ER0+V
         0t2fFkHW8mAavKpInH268+kyI4NVs2LUDxUi8Oe46S0sR2KMmMoCn9mNt30y1dYyI8aM
         fZuw==
X-Forwarded-Encrypted: i=1; AJvYcCVtgNzJLr2vt4LtaXkyOgSOTXuXCxPturhbWaAfZACGmWTcZL87RqB//tKxsRixPaRuP/CMoNVy/zFse+gQcCqyAV5GNW86Ki1qc73KCA==
X-Gm-Message-State: AOJu0YyRmRw772AcR8371SsNSiXz4d4cgrXsyATl9E2BhaBu4xU6OZ9j
	Ch4mqDFUg9wt83tVotQf5ZavwxCW4QI/80NSncMG8zRx6/d4vMnDnLzB9fWmTH7o0QZT4jSTQMB
	072NE/9RCPLTNfFM2m3MfQyGFRuw1DSFeE7RLpQ==
X-Google-Smtp-Source: AGHT+IGbg+DAycHWI6mWZR5QpnuDFuxaWK5K61zA1Ndpnpk7LziHDLtW/o4Zpx29FrEQNo4ss/2wnxwNFaVvMkB+8hw=
X-Received: by 2002:a17:906:4918:b0:a3b:c2bb:d73e with SMTP id
 b24-20020a170906491800b00a3bc2bbd73emr692999ejq.6.1707472758693; Fri, 09 Feb
 2024 01:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-7-amir73il@gmail.com>
In-Reply-To: <20240208170603.2078871-7-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Feb 2024 10:59:07 +0100
Message-ID: <CAJfpegv4uX1pVNNkPdiko9Eo_jzjpiHrmKfwn7Y-r1E-9ucc8Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] fuse: break up fuse_open_common()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:

> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1034,8 +1034,6 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
>  /**
>   * Send OPEN or OPENDIR request
>   */
> -int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
> -

Comment above declaration needs to be removed as well.

Thanks,
Miklos

