Return-Path: <linux-fsdevel+bounces-4811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6708041C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 23:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF71C20433
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF213C46A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WRb+46fT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C7CB
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 14:14:54 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce5a0c37cfso945484b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 14:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701728094; x=1702332894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o7NAHp/MgTm9SnzSWNXfFwt/FdMVpyaPo3ZgisLjz/I=;
        b=WRb+46fTXqd5sRdJUueaTb020qZkOMghj3gRWtOIcX5OORMR1f759TGn9hNrPjV1fa
         jOF6uUinAkleHsKcOr7UPmTJsnAat8VVbMua8PRWX9RjEaOIHU3OEvjP2NQBBdR/NKDy
         Y3tF22aS/ES5WNGUohCppwFUSxUXyz7R2FD2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728094; x=1702332894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7NAHp/MgTm9SnzSWNXfFwt/FdMVpyaPo3ZgisLjz/I=;
        b=lnPcroYgGwcqgWcNGJF5dzc1CsbqKgM6ZIFsxebuGphoileCdhZY3Ax1CKase6pg2T
         2Dx+zDd/OrMdL2woyzRZo58n+SLTDvE16EEH2OZyM7b7hM2f1jRbIpEfFOZ+VtbKwN/p
         0Hd5W9oiWfilffZhcHT1rSi6u8PkPl5LoxVfGt1Z/Yfr60w5HUydp13WY+hcLU7vM+Y+
         iJzxCIsC6yRUDGLJiFuIp+Iw5favn47LFcsHEgFaEAYqAwb2nTwYLzWTmQ3psYnKz/GV
         oL+bJWzOCt0UsaF2+b2NmMQzmLwyxv2lAK510At+cBHQUzMxjABiBhOcgMgpKTaWkDsN
         0OCg==
X-Gm-Message-State: AOJu0YwfhjGIXk/+yS4soa9j6P35rpIV74L+SoMR4w4b5XL2BLaAJY6s
	06J/7DHRncMCdXPzrwfELDoRIA==
X-Google-Smtp-Source: AGHT+IEkvdihAqbNhlhSGxMupjG8dnFLuD0j5JoZv99BA2GbgcxonJ/mSfL3Y7TTC0ZNcKA4UdPv0g==
X-Received: by 2002:a05:6a21:1cb0:b0:18f:97c:9276 with SMTP id sf48-20020a056a211cb000b0018f097c9276mr1608801pzb.91.1701728093815;
        Mon, 04 Dec 2023 14:14:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a8d8500b002867adefbd4sm4108188pjo.48.2023.12.04.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:14:52 -0800 (PST)
Date: Mon, 4 Dec 2023 14:14:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 08/18] stackleak: don't modify ctl_table argument
Message-ID: <202312041414.441475830B@keescook>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-8-7a5060b11447@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-8-7a5060b11447@weissschuh.net>

On Mon, Dec 04, 2023 at 08:52:21AM +0100, Thomas Weiﬂschuh wrote:
> In a future commit the proc_handlers will change to
> "const struct ctl_table".
> As a preparation for that adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Looks good -- thanks for catching the table-modification cases.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

