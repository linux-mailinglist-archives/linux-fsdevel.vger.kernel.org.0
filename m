Return-Path: <linux-fsdevel+bounces-13671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10C872B4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 00:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E543EB2565F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 23:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838112DDA3;
	Tue,  5 Mar 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWQNwmko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23012DD9C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682735; cv=none; b=R2/JaDHT7cY4vUeFTMjeXE3BVUB60M02xyfBofx4qLLdohBHq8eJbOV/oLTXTAhQdBj6O5k1ptLtXgvxjwQegx1GYn1ZpInZcQpmdXDaVSp+kK5po11miSOM++Wbb8hXoktkhqeDQhmV5NuCU1iYgkwKJnZX/jd+BPR5Z0K4IxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682735; c=relaxed/simple;
	bh=jad1ZTuPBnQnVhyAUaIXJ0sj2KmNN+XpvGPh1Z8NAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIE9RL6FEKg9xmEUInQgd0XBzrZnIzuwS5c9QVRVwoGB+wmA/7Wls8+TSMP9dxDI82w57eOYDv6gqZYwhyzBkYvNiLzPkkchisXLLmRD0o/nV7ppbLbSvnI+uGmb5vaIYsyjj9cI8IqEBXuWSxCG8G9/+KykfWJ9DJcitTTNUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hWQNwmko; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc5d0162bcso54397945ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 15:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709682733; x=1710287533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyoc6sqBdOY+7wLmmpdaiPXTvskeQaEAskb3Q12WvtU=;
        b=hWQNwmkoP6X9trL+mOxnNbMVV5ZgU4F4xTCcdQhzKJqixqNrhe/FaY7XPOdBZH3Wfl
         sZ6wD2ubgEZpJnJNcab0ofM/vJ4mW3tPl+Eojwwm/m7YFpU6nE63s6Yi2AQqYGPU7tk0
         KIfQUPpcg0mZ8Bd8PXd+LPnMZvYWnhgE6gu7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709682733; x=1710287533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyoc6sqBdOY+7wLmmpdaiPXTvskeQaEAskb3Q12WvtU=;
        b=lK/uQxlJmZGB/gO1NT3TlT6KTh4iPyhsuzkaGJEs0a4RuthAlaXT4Fe8cVq170mqoY
         F7rkG9HgJQcLSwpFJQzlyvTaX2f3ksksTDOoQ6ueCUTs9v0YhWpE4o9tr2jrAQ+F/9jU
         P4C9O6HJL3wkIuurHGnoKFb/MBmEkWAqvY0SAY7UZZ/9t74UdYRkurFJiMC7955nqAKQ
         Go9ONF5941CzKxirJc87ajxspaKJ6k2xSH2JIGTG/ehrI7PMk98Pn5gmmn1vP1D8s09Y
         fmkcQwg0/lGxjkDymkdllpdGf+Xy5tCKpTI4lL+SD2F4prLg4GbO9vwq/dNoqJiGutwE
         zGbg==
X-Forwarded-Encrypted: i=1; AJvYcCWtZxGX9qbxhBDWPbqfaz3OJ9zlh9MT6Qa1IMBiXNHWaf8dmPomnBmljGyl4Ape5dOCI1osG/6rA89A9sm+CBrCt4ujSrBR4H5ZfVY/MA==
X-Gm-Message-State: AOJu0YyV9WTwuaisF8hawm7Eypdf3+QYgECDMoJTVPP47ju19oB8i9Z7
	zU5ixIB5UaLZrCmXk9wfEI8mXV6xOGDYs2AZ0usH0Kyz/9Ak/oHEMxfjT6M3Bg==
X-Google-Smtp-Source: AGHT+IHSAi/R0Z+FnSnYEll+Jdzr9evRXwkkfto2W7u2LIJBRhmtHvsvuWPYgTohLmHE92SmGPwJxg==
X-Received: by 2002:a17:902:a514:b0:1d9:7095:7e3c with SMTP id s20-20020a170902a51400b001d970957e3cmr3152769plq.57.1709682733364;
        Tue, 05 Mar 2024 15:52:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b001da105d6a83sm11089065pls.224.2024.03.05.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:52:12 -0800 (PST)
Date: Tue, 5 Mar 2024 15:52:12 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fsnotify: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <202403051548.045B16BF@keescook>
References: <ZeeaRuTpuxInH6ZB@neat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeeaRuTpuxInH6ZB@neat>

On Tue, Mar 05, 2024 at 04:18:46PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently a local structure `f` that is using a flexible
> `struct file_handle` as header for an on-stack place-holder for the
> flexible-array member `unsigned char f_handle[];`.
> 
> struct {
> 	struct file_handle handle;
> 	u8 pad[MAX_HANDLE_SZ];
> } f;

This code pattern is "put a flex array struct on the stack", but we have
a macro for this now:

DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ);

And you can even include the initializer:

_DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ,
	     = { .handle_bytes = MAX_HANDLE_SZ });

I think this would be a simpler conversion.

Also, this could use a __counted_by tag...

I need to improve the DEFINE_FLEX macro a bit, though, to take advantage
of __counted_by.

-- 
Kees Cook

