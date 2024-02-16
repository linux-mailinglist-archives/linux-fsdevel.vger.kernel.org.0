Return-Path: <linux-fsdevel+bounces-11896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B085880D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 22:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E309B2DAAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E542914601E;
	Fri, 16 Feb 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fr+cdO3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DD145B03
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118513; cv=none; b=Km0bBpUYYJHrlgw9U/ohGR1arItCwTFHfnqaj+HpDPz4EAlEEs5f+Drpeak88aE8OvO44mkYICAAgOrzfZqZ+8jwsUnUFxWtLRrDKLWgNVN7yvPJyDP01HGyWyh5RPsS3x+thmuB2e9KJiQR4LdwWLslILwroJRloacFd6ybchE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118513; c=relaxed/simple;
	bh=8RkIdklDyDDa8h8JrnVfHzosWxPgtS0o2uyCwRZpqro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpmn2BzufD8imnsWwkDp1k/Qlen9O4V79iBxa52nJMr1BtsOkcopWWkIvVIWQqoyGLteWxWfqP6EBffIYCMXv1+T/sbES/AUhIMJ71ZbD65TCWd4x19Do4uq5P0X7t9PQlWsYG1Igatl2GSP/AN5EghIxKQdJLn46Iqov8YgpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fr+cdO3g; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d95d67ff45so20754565ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 13:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708118510; x=1708723310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtsFfzG8a5Y4gKlVc4iSnotBnYQWJOU2Pi/S9waSvFY=;
        b=fr+cdO3gU2g2Jzz9eIVWQCdnY7kih0gn2m0N+DsRcYsxRG2umJf0xApOZ7Jo8QmZeU
         yUR3nlJ8Wc2erGfOAhoNPfE152p9DdMVPywICl2KAVuqUJIDNfUT+ymcvH2f4IWu2oey
         Ty7+54DGru9WZ9ap4H+jYpm3yS7LBSrlnwbMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118510; x=1708723310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtsFfzG8a5Y4gKlVc4iSnotBnYQWJOU2Pi/S9waSvFY=;
        b=hcgcRmKG7r7mVdpCOc08chyupS5mqHQE4lcYfKlmSayJnMtfNl5ps4DXrR16gvS3c8
         9acv8rHd5EMR2wn+ck6STlbdM2j/x9p541UlHmrfRqzmLUs575daS6BQ7pNOI+J1i69Q
         KizkGJd47zGdorRwHesN22ffAitdGnqGzjQFFxym+4bA9VCTPfMm1jBueBwndB46elN/
         6fQVPgqD3hzb1JfY0Nfg41OKxqzy4gHVSxYWVj9vMb8YrtLcSmnnwp9hYjqZbkfpDqZu
         uDa7EN/bXBIN7fiZ2Zsrn57qN2lSXSIA7El93cgoK3IWgu8ysCqFBwpRVPT2QAEUsFBP
         nItA==
X-Forwarded-Encrypted: i=1; AJvYcCVouGkG9c+vi6KtHwflTJYD4dcBMoHYA1y04akECwCIJRniJulcsY/ml48BPN7bBubrPG9DR+vBzPKAus+LSfHp5IOFG/aiMwQMY6oRsw==
X-Gm-Message-State: AOJu0YwdhHqsVWWm6/ievLrnmeVW6h1OwXixcYovI44afRUJ4XyOVOJf
	GdFwTtIckc/hw+AGLIaKCts8a14M2rlPikmb1+CZ6qDyx2F2BI4dGKFfwkehIA==
X-Google-Smtp-Source: AGHT+IHTg+sL3pxx87dFYUZnA4CdOFoi6N++WUXNc0EriN4rhXpqlCmCapRn7SKh0gVSuZ2EqKK3rw==
X-Received: by 2002:a17:902:784e:b0:1d9:ba26:effc with SMTP id e14-20020a170902784e00b001d9ba26effcmr5713961pln.51.1708118510303;
        Fri, 16 Feb 2024 13:21:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y12-20020a170903010c00b001d974ffa1fcsm292574plc.173.2024.02.16.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:21:49 -0800 (PST)
Date: Fri, 16 Feb 2024 13:21:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] fs/select: rework stack allocation hack for clang
Message-ID: <202402161321.B0B1D6F@keescook>
References: <20240216202352.2492798-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216202352.2492798-1-arnd@kernel.org>

On Fri, Feb 16, 2024 at 09:23:34PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A while ago, we changed the way that select() and poll() preallocate
> a temporary buffer just under the size of the static warning limit of
> 1024 bytes, as clang was frequently going slightly above that limit.
> 
> The warnings have recently returned and I took another look. As it turns
> out, clang is not actually inherently worse at reserving stack space,
> it just happens to inline do_select() into core_sys_select(), while gcc
> never inlines it.
> 
> Annotate do_select() to never be inlined and in turn remove the special
> case for the allocation size. This should give the same behavior for
> both clang and gcc all the time and once more avoids those warnings.
> 
> Fixes: ad312f95d41c ("fs/select: avoid clang stack usage warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

