Return-Path: <linux-fsdevel+bounces-4810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266FB8041C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 23:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D684B280B95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC913C465
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kZlZspSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38919FF
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 14:12:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d05212a7c5so18473165ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 14:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701727958; x=1702332758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5w+w40k8reyqU3pjVynIeZmpGAhXy9mRn2YDUbDK6o=;
        b=kZlZspSLgzRFo2AIXtG6F/y5aA8ezGQOCsKYoHAcJ1v2zCpqJbuMDedfbiBy2Tu9C4
         xBMU8TyxnQa10i2a3GeTUsj8z8gBH5CsQc5+0e0MN03zF+Lw9pyPk9VdbFQ2ukoFbHyD
         BrYOBrSlcnLeWbKJmccJ3x7v8xeQbXe2+w3IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727958; x=1702332758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5w+w40k8reyqU3pjVynIeZmpGAhXy9mRn2YDUbDK6o=;
        b=DwmNj4Cx08Nuuc8serNy60T0brwrWV00jiJwjmIcenrdFuWs6QPJe1wrhbBcDlhxws
         0mmkHtnEogQ0pv5APUP8iOirrzGsW/AikDMXv36mQOFIMDCUAylIHX135016rD3Qi3ho
         SoF7ii/pCGWciumujzy0QiZsXjUV6sJZRtWcrbb7wW/btnFVhjaAQZfYMCaUYZ83wLZu
         de11Q5te+ftiUt/rf1XfqU7uJzLdwQz+YoihKEgGLNU5uQRr7QqiaAAc7imzgEAybMst
         BdZrNxi2dSaXLhj4hAaOERH1hBQrAd1bZwTQAwok/Rm5rpZR1/JaKlxGaZfOeU0YE4a5
         0AZA==
X-Gm-Message-State: AOJu0Yx1cldGM/+0yjrb05WNd4dbjaOvKpqBQ3LjsJyN8nsK8U8K1JkE
	Eslrus06koUBRt0ecQDu8yKqDA==
X-Google-Smtp-Source: AGHT+IHM5ek9ahZA4zDcV16QXDzsz49v7j1xdOQOO23qiKhgCK2UxX5VuXi5Txfj8ada4KvlaWZx7w==
X-Received: by 2002:a17:902:b210:b0:1d0:6ffd:8346 with SMTP id t16-20020a170902b21000b001d06ffd8346mr1942760plr.81.1701727957671;
        Mon, 04 Dec 2023 14:12:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b001cfc4d8eddesm8876332plg.180.2023.12.04.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:12:36 -0800 (PST)
Date: Mon, 4 Dec 2023 14:12:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] seccomp: constify ctl_table arguments of
 utility functions
Message-ID: <202312041412.7D0EAC47E@keescook>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-5-7a5060b11447@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-5-7a5060b11447@weissschuh.net>

On Mon, Dec 04, 2023 at 08:52:18AM +0100, Thomas Weiﬂschuh wrote:
> In a future commit the proc_handlers themselves will change to
> "const struct ctl_table". As a preparation for that adapt the internal
> helpers.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

