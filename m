Return-Path: <linux-fsdevel+bounces-4812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC828041C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 23:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D827B20AF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831413C470
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MHkl++BA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D97101
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 14:17:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d06819a9cbso16869645ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 14:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701728228; x=1702333028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFGpzU5KwhNmr20zuJNlExzeMs3xxo7WpAsEm8UJ2O4=;
        b=MHkl++BA9bNNxE03haUv5jX4phvwJSFojRNF0vrQiUp9gCuRK0sGZWbzCJS16xRI2Q
         z9G12BrxasH7B+BArcwnXU9inz8mPoCQYTBhvVSVwkYcabqRNj3Z2laLK5fI10rGju4O
         qnkvq+Ce+DwQmSlhzuVT6QcEHVMfM8Bh9uWcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728228; x=1702333028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFGpzU5KwhNmr20zuJNlExzeMs3xxo7WpAsEm8UJ2O4=;
        b=KpF/WNrlfzwAjCy6F3+Fh00UnaQWt0uA6z5PLR46Lc2kW2uZjXy0rXbd/7ZU7JD4qc
         uAzsxAn1bd3syj24GnyiWKhIYWDRQqgeSXEvbvNq/fySWvPOF0L4e9XjVySue3kmrukx
         gCOxIM3DuHN9ws3ahuFZIdY5od/enj6NE5hXE1gqBWJetOhATv/engkAK8e+3YHPkWLO
         OPBiiB1MuAUJDOt11icXTRaRlfvy5cVHBFiB9B+OrdJ2hjzyzcIAXdvLIf0BKkKEbXam
         fRNfjHIH9EFAMIb2A5M39LmZ7k6dQ+kxSu0l0Y4IzEmSBZk3Jh8Ee6Lw5WZL32dpYzXy
         TnHw==
X-Gm-Message-State: AOJu0YwmBGhW6VBXXCyhCPgVkZJLUWipWqj58kdaIPKCosBNvljKbAbO
	b6XgHu90NZUZjhZCigT6dyo7JUONo0roZAuQi9w=
X-Google-Smtp-Source: AGHT+IGhVQvjJ/un+BNNpI81xkQ/mxT2N3RFluRNHrDTDZt40pDlkYkg5OMdQ3g5vmIN6SN8Nk525w==
X-Received: by 2002:a17:902:a585:b0:1d0:6ffd:ae15 with SMTP id az5-20020a170902a58500b001d06ffdae15mr2071582plb.124.1701728228199;
        Mon, 04 Dec 2023 14:17:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b001cf5d4f8f26sm7124981pln.248.2023.12.04.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:17:07 -0800 (PST)
Date: Mon, 4 Dec 2023 14:17:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/18] sysctl: treewide: constify the ctl_table
 argument of handlers
Message-ID: <202312041416.9336746D3@keescook>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>

On Mon, Dec 04, 2023 at 08:52:25AM +0100, Thomas Weiﬂschuh wrote:
> In a future commit the sysctl core will only use
> "const struct ctl_table". As a preparation for that adapt all the proc
> handlers.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Kees Cook <keescook@chromium.org> # security/*

-- 
Kees Cook

