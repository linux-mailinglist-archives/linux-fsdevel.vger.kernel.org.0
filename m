Return-Path: <linux-fsdevel+bounces-61121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E6B555CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D385C5207
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175932A81F;
	Fri, 12 Sep 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xw+CDHx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EBA31A06F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700336; cv=none; b=uFM+XUeQe5T+XKNvBwh2h9ndFOza7an4b02JxDwPElmBy1LdxQHe1eeLVx6cQuyEsOLgYEhbQYDdsk0ZBDmsueCxCbDBRfv7w/vKqvmoCZKRmlkjdMQMdYCJ/CGqihzBWaoOaP43CLuniqu9fxWcbTTHTsP/ilxKbFAcu8mplyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700336; c=relaxed/simple;
	bh=N/wqAgrO/zhmnFI1nBfWgzHwsyg/LF9jTsJtR4dZsQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc18RixLhPX1RTnvvIAD5XYhMazlvVXdnFnMrkKv8cL0HMoskhHMkfvPsYiVAvJO8OmjKux7p5/STGIlyicXEiPUZAXQaDiAouWklk/QjyPkczbQ6PpZZf8byJle7BsHtifwEBzskXHhGmYxMOpUWeaR6YPhIMiWBDE6ZnPINH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xw+CDHx9; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-407ec3048a0so23209535ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757700333; x=1758305133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcFeJ72WbA74ff5cvPiISFqof9IGfX60h7xEGQwxob0=;
        b=xw+CDHx9lfX/c9sPgkJ8vT2/2jJBIOgxTKLQzE4uLHCr2+MUa91gFgUY5x+8z/KrwI
         596uQ9w0zBj48zHff6+o0dLqpYaIZzj6B08w7sToYgGWWRCHnA6ZmB/7FLeZcq0TsXMN
         Wkl4M2XQeJFmf4SGF08o3blV0AxBWTn+kYK8MhSziCwJLXfWg7rqC/PcTERSWh5OVneB
         C+8MjbbMUPjJpwX7uQHIhTnWxWaaJZeIvHcXLOl3CYSQqMuu0XjIhnx3FbmYQM3slDw0
         oQ4IKm6f+aa3c8lWSO6YdmjK43pIOxbo9W38as7kK4Dw5Y3Xc3AIYDRnDvuOBHlwSwLc
         VzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757700333; x=1758305133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcFeJ72WbA74ff5cvPiISFqof9IGfX60h7xEGQwxob0=;
        b=B5tyWlH/jZzMW7Q1kyHB/+A7VkVPMT0DJ0WQiYtgxdzr5eD0C00q/QAj7CYVkZtSzf
         UUsbha4uQgJRzZeOVJ3x7h1Xw+Y+JhP6pUc+UKe/UGRHkTEvGNmNg4o4sL6Yvl2J5FQ+
         y2yhfPUfyvrIz7zBQjUbiH/3SweYcqdXyRv8PtTjU8EbahgqPjuwk4QywMTPRKlgF7sg
         rmcWNZMIuSgU8c+Z7p/cMlMkZw9XcZFRmbUX5MrykmatlpIx9m32dJHmfH/csA0iXJoe
         pNpjU7K862IkKda4mGGvpCSJUx/8VqVHqmaelNey5d+G0wKc4dqJpUw17/jAWMCouS4M
         8vgg==
X-Forwarded-Encrypted: i=1; AJvYcCW9IkKBh1LYxE5uWgzHG6NJfMJgkPPHfnFi/1QwMUWguam+NvALlGjbvfaVYsJWdP4uiz28etwxhCbHUAv9@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFA0EgcdUshvvTV4tEW6Avg34pyTwvmbf2FHm8Oe0kRl8OLzS
	ZdPtWtO5JhJk+rcFPuejeM18xCcghczNloCe5vYg5jKbBNsXCXnduc3Wb0nrPYFOuQ==
X-Gm-Gg: ASbGnctjFbU6FdDD6B9lYSgxbIuzVtiJveWDVcsOYuYpD5UCZivLOQPvzAje4qZAMlN
	0C0u4I9Mrdp5tp8MzKfxczEGlIuVNRwv9Rag52AxIboIxXN65MpvXPcUapT08t2xmMTFo6xyaeZ
	RFiLGIlOpNztyAJuk5HY7Yqst5x6D2fFFTlG5HuHM7QLquoINxVqZZieFA5EE5K9b/6us88BMcb
	AIOwTKaab0LJXVWtG6z8MXJvw1Qlj+XMWCiqG+mgRKhjTy6at1ytJVjAhp17sKep+CIamBXO2Mr
	L+ycxHs4uTC3cu3th9v4lhhcAK7UF9cck744EDLG+V/eD6fDbuYeAyPdKX3w4gYXB+b95YutCVj
	Tc04Yc7MSWeB/Ep0YcROrZw9es/B5M5Isu6xyNuVg3WeKZtYC4i3UYvxFt20+R9GnGYXPcQrumg
	==
X-Google-Smtp-Source: AGHT+IGJCURFvMxoZWZd20cUZQaAwt7BOfCiB9UePZcFNpGBu6mZoPeVrn4XW3nB4SQJl2xpLBtXNA==
X-Received: by 2002:a05:6e02:e11:b0:421:bb6:fc6a with SMTP id e9e14a558f8ab-4210bc6491cmr47318185ab.2.1757700333029;
        Fri, 12 Sep 2025 11:05:33 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3067bb9sm1854661173.39.2025.09.12.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:05:32 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:05:28 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: Replace strcpy() with strscpy() in find_link()
Message-ID: <mv6ck735oa4ix7emkjtgt3cwrbhyizina4tady26nzx6otbvi2@ngewjjf6ahdf>
References: <20250912064724.1485947-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912064724.1485947-1-thorsten.blum@linux.dev>

Hi,

On Fri, Sep 12, 2025 at 08:47:24AM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  init/initramfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 097673b97784..6745e3fbc7ab 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -108,7 +108,7 @@ static char __init *find_link(int major, int minor, int ino,
>  	q->minor = minor;
>  	q->ino = ino;
>  	q->mode = mode;
> -	strcpy(q->name, name);
> +	strscpy(q->name, name);
>  	q->next = NULL;
>  	*p = q;
>  	hardlink_seen = true;
> -- 
> 2.51.0
> 
>

Thanks
Justin

