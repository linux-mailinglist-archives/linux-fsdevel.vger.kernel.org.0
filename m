Return-Path: <linux-fsdevel+bounces-12638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2186216A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 02:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A883BB23788
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA51870;
	Sat, 24 Feb 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hDTytCMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE04138A
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736687; cv=none; b=kimuxIBe2HZ3rJxH+lxKZFznQ2eYJAy5kbcKT7CeZxTW96+WHb2kDgMKovLEQl+GHrMuRd0FjXLjzf/925AWpmpOutQ0U2N1SCjM482R0Dy8Q365z/enNonLWlYvq7TEnccsjJIOj3S1wmwnPGNMSaWYI11/RXQFbSvZS6TPmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736687; c=relaxed/simple;
	bh=czByRd1ZtLG1ytyTx6JHZ0MsK0WUs6+OU6X2ecDmaiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXqKe1yldB3gw3U0bfqb/Bcn4Kw69mf9GWb3LFXVigDaXuNNN4Uk4eWn7mN/QAj4/qXAvRfmRPTnK5m4Mna40DXa4TGicgKjV67V6XP+vjEMCdbkdE78ptPvbga9UYpL8x0JTDxJLh4Z+yJWmJ9LHsBFwcV4IgKL4xfGTHa+1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hDTytCMZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1307763a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 17:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708736685; x=1709341485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQKkVKoC62UNhXK21zihqEnfMAgk8ODcwjqvMq7e3Fw=;
        b=hDTytCMZjXMcc7dOtYwFFM4rdy8tCW0LtvCuewIQXA+GNLevAOsOUKvHDkHn5M3/dL
         CTTWrNl3Dyevh0z6tXJBitwSesEHgNAhD16osTPqXoquEczotZbqww3bXThTbEW10jxR
         WGEiwWEBd5gzKwNDzmQ0EEw7GqcX/AEklXEdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708736685; x=1709341485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQKkVKoC62UNhXK21zihqEnfMAgk8ODcwjqvMq7e3Fw=;
        b=pk6C4A1mEq0rnLRSVnFUGlf6y9mBvFrUznx2xi1cCVLMb8pfzhI4Zcu4xSTYAQV/d1
         Gt4Zi65Ph+efJGeoWyK84MVJBDE2AkblStodKVSAoCpUWraQqyxm7VN/5lpewUg4smbV
         A+NKZnhOGtRJSfkI2hlGMG3b4waxGIlluHdC9xvxtpg1N+Mzo4Vk7LUmkkWtsete8wDM
         O0TcYShJBjm8Tk3BKMJnxwqY8bPo7VRZ9NUOwEtza7qgMxYrssEwMMFXYPuyAvfL21lp
         e3XTfOn7UU7/XsDsUll4ltEk06nKdhJUTsWHXPwStKlzNsLAqMbplZgxZwDIUP2KAmpt
         wt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3IXFJaDPiOjtE7xggw4JOfhpiA0xlS2wvXw1+gEK5CI80k6nCfXayhV33NphX+7VM0heZOnKCgWgKXg9UsshLmA0ByjYPOKAR2DMICQ==
X-Gm-Message-State: AOJu0YxpnZ061HL5g1GWG7HldxwQOc7c0z5p9dHJcbm4cTego1gGikUZ
	HzR6QgQvf7Oxa5zsKTPDM5mI0utPQOpmMkRZ0b7/bbLXMeDNleOOSUum3N9YtQ==
X-Google-Smtp-Source: AGHT+IG0YdtHF9dbaoGm8JzoVb9eQcmcaxlFTDtLUPRbBpYTUj0A/EB01yqRCMLQjT23cQBmTcoxXA==
X-Received: by 2002:a17:902:eccb:b0:1db:b69a:3fb9 with SMTP id a11-20020a170902eccb00b001dbb69a3fb9mr1864564plh.25.1708736685645;
        Fri, 23 Feb 2024 17:04:45 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bd3-20020a170902830300b001db6da30331sm33159plb.86.2024.02.23.17.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 17:04:45 -0800 (PST)
Date: Fri, 23 Feb 2024 17:04:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Li zeming <zeming@nfschina.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Remove =?utf-8?Q?unneces?=
 =?utf-8?B?c2FyeSDigJhOVUxM4oCZ?= values from vma
Message-ID: <202402231703.8D5E862@keescook>
References: <20240220051830.61099-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220051830.61099-1-zeming@nfschina.com>

On Tue, Feb 20, 2024 at 01:18:30PM +0800, Li zeming wrote:
> vma is assigned first, so it does not need to initialize the
> assignment.

I don't really like removing explicit initializations. They don't cause
any problems and the compiler will remove redundant stores, so there's
no benefit in dropping them.

-- 
Kees Cook

