Return-Path: <linux-fsdevel+bounces-31153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C42992842
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFED628320B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928AC18E776;
	Mon,  7 Oct 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ITqaZTu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EE41C69
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293751; cv=none; b=GhNCAnCLJhM3HjOFULvNPcb1w1xXAJ1jXqX4h02i/rDFdo1ZkdZpmNg2WceCFs/E7tRsfuz88nQh/FAxFtS74e8nJaOOcCPW5wWNFKFiB50DEkgWQHPsWmVQ94NcV4qO9wRQ9KP8I+QeLtKbqecX2lHveoVwM8NOSroolxnhXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293751; c=relaxed/simple;
	bh=ydF8lF38rAmGhScUh/RtIg6V3+bQn2AeCpckOHdptvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkimTSW9b1qiagRGIP4WLFfjtuIBEqOKpsqo1MnwLyUOGRtwcclEDdMKrh6QSOaxe2ElFPTU0ihVJI+/O0Ta6rSuH9y5FQLFSK+2jQEeFeJidj2zxuWo6ttN2UwPtMiRRRjvJ6cYTplKCfa4srM6gSpsoYqlVvJsMnc8X6qBiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ITqaZTu4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9932aa108cso314802066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728293747; x=1728898547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydF8lF38rAmGhScUh/RtIg6V3+bQn2AeCpckOHdptvU=;
        b=ITqaZTu4stNIbJvVvP6/HcguHhR7qGj5Sja8pTioFyvFDDNQR/o1EuDRsCtSGFxGWE
         oGmGM5iKCqpIfPWSPRRIjsdmjX18dmy28PW5VD82ixO+ZuDTUcZwOQt6v5ccSUKJsH0X
         YL6gdY6jSZ7GIBHil5DD3Kx6tfZ4H7K1G9PNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728293747; x=1728898547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydF8lF38rAmGhScUh/RtIg6V3+bQn2AeCpckOHdptvU=;
        b=DVEWpFVO51mCjvGLcvSPs29BG8YppnzMC+Wa55bXOzemOV0l1GB7kgmOtLcJDbDVYw
         dw9mPsTIrbdnnL8XEdjrKNxrJ6SIhk8ZylTJ68PCiTkMoDHkkiRBIcvKjKMI6LnxgI7y
         Q62qq78SM8+mB6D/rerI505kHgnOfRKF/0sDnxJyDDrRgaZsQEW5YjCBcR2KDLHkUag6
         iiJFI89hfknu4INqRE1/uAPPpZyGHvMAd4fkL92JKCwKI8ZhxuwwxE+uRKPP5Y4y6VQv
         WwkhnT0Kpta3PhuHbCsn6Nb7ponhyF9t+QAhbj9FgkBijGohEK20Tms3XWbQs+4SF303
         D+uA==
X-Forwarded-Encrypted: i=1; AJvYcCU7tjb1xfaLF8QiWurkL7mZGuHVWEyLc+baWDj0S1mCI1u1crF+w4mPYgMV+PAn8u4wA9S4qTL0RBiBYh/4@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHfbkE/tSviWAITDrSPneeIc36a5tXatC+Xs5oeCiNV77PRtk
	Q7cVRwT9rd0k8catdB5hIHclAEhJst3uV96umiKN3glYM7sZsTamjCbCuGM6mkGCROBXI2XZUq3
	nBjLVD+zq8EUGM3rL8+ZOp1q8iosCPSxz68wesg==
X-Google-Smtp-Source: AGHT+IErPVGCMGFqIZdxLaJ2eEyfuqp0nHUfhDVQMtXzhNgbQ8KQIXrcWB0ozU2jOJlbpAmPSkjoQTLk6hbwUUR1ULY=
X-Received: by 2002:a17:907:2cc7:b0:a99:4b18:8465 with SMTP id
 a640c23a62f3a-a994b188543mr370743666b.58.1728293746920; Mon, 07 Oct 2024
 02:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com>
In-Reply-To: <20241006082359.263755-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 11:35:35 +0200
Message-ID: <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Stash overlay real upper file in backing_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Oct 2024 at 10:24, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Hi all,
>
> This is v2 of the code to avoid temporary backing file opens in
> overlayfs, taking into account Al's comments on v1 [1].
>
> Miklos,
>
> The implementation of ovl_real_file_path() helper is roughly based on
> ovl_real_dir_file().
>
> do you see any problems with this approach or any races not handled?
> Note that I did have a logical bug in v1 (always choosing the stashed
> upperfile if it exists), so there may be more.

Stashing the upper file pointer in the lower file's backing struct
feels like a layering violation.

Wouldn't it be cleaner to just do what directory files do and link
both upper and lower backing files from the ovl file?

Thanks,
Miklos

