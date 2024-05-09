Return-Path: <linux-fsdevel+bounces-19156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50EF8C0B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 08:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F14D284300
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF79149C4D;
	Thu,  9 May 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mFw1Qnul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259FB1494B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235395; cv=none; b=JjVPWolxB71HgN4cKvWgke50aimGf+YCZhGAj3Rb72Z1Iz1rKB841vpSuGy74+UB0dzahuQKzBkv/lONLo288if/jZuJnT6FZl2WFcqYcigNoOf7BWkeH8664COZlnZXkUw34YfOmOTo/JrZnvZKUDE0hUWikUGdae4DSuF1Arw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235395; c=relaxed/simple;
	bh=PtJHMj10OXb0kdkgkrb8tgubNV8cNGlXUgK81dDn4uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoElRcbf6aCQFqrimUdXtpdSeUty2C6o/XUNMjwxXcsQRxaKuxdTsK3skctYQubHwJNoWfJRebmTLcz7suNZYGzx9ulNqZC04HTE8Zjbnt2eXAB5QB70kfK57r+1775l39yLjyWmPRXEAsFZhuEQy3Qi8NasGlb5UIgOY87i7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mFw1Qnul; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b4952a1b51so460818a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715235393; x=1715840193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8s5ogdUt9IfEZlAdYuj7aMmz3fDPUoN3crsNCifKctI=;
        b=mFw1QnulXKtHwMeqJ36x/CQP7UOYa+CMrVvUctDELyB1e8/B1Nlq9LWQ7JSGUF0+Oz
         YkiLhgARY53CVU3AaGl3EOhkQWX3VDonqooPYPhiDZnb44M4rJQ92bmUzoLEh+hfQiHF
         0xdQbi6Q2e8dr4FUGKJEJIk2qbVxLBlO+af9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715235393; x=1715840193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s5ogdUt9IfEZlAdYuj7aMmz3fDPUoN3crsNCifKctI=;
        b=UkjAE1o9OyIolc5vh4pntYYcAdwYfhsI4DJISKiS/Hk+5CA9yo9WaMW+NrSnKoZIAj
         ljSYehMaBOOYu9OZGmoUG9oj80wz2uRaGSu+3wICrT/N0JL3E0cQ5K/MErmjfFf3ooxz
         4TIr+EooWNvBPBrVFOiIXozZnBXEzSzfzFG4OWwRG9FioFi4BsG9uywomk0mQ+mDdUkJ
         n0JNY01evx2l1Ivn1DpAAssBA2NmRbpGgtqqXruZ+3+Aq4yNFdDqG8myfkUXlvn4gyDn
         D4lw2HBRoB2+U5qTir+4kAcqTNa0yPZddytWiIsKpXg0Am6V2z8MznVg2m3PSsoQc+3N
         D5LA==
X-Forwarded-Encrypted: i=1; AJvYcCWqNkAP7IBv99nBQdw7MWXmVBMr0qwvDtwutg7cut+1KYz2M3nOdxu8WovxOtzwwzPfBruBQ7rfTKFiTv5+teRszGAjxcJTWKcwxSo34Q==
X-Gm-Message-State: AOJu0Yxgk8r6W6DFEnCGG0cUNMTOSKDAIdvwO2ku7hZHyCS86IQsze6f
	uSAkmQl49pFxbZf2g5i/UJKu0SRJGOOxjtAPrMTqmmdOFHS87kOKmQGoN8QxtA==
X-Google-Smtp-Source: AGHT+IFqzikMESBMZG+WVvk+WptHcSgh5kqTqoDaOrL0B6tQBKEyulj/ZA+fDWbKAGEbWorXR4unvw==
X-Received: by 2002:a17:90a:ac03:b0:2b5:6d47:9e12 with SMTP id 98e67ed59e1d1-2b61639c8a6mr4341255a91.2.1715235393466;
        Wed, 08 May 2024 23:16:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6a83sm2490804a91.56.2024.05.08.23.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:16:32 -0700 (PDT)
Date: Wed, 8 May 2024 23:16:32 -0700
From: Kees Cook <keescook@chromium.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: "H . J . Lu" <hjl.tools@gmail.com>,
	Chris Kennelly <ckennelly@google.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Fangrui Song <maskray@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Victor Stinner <vstinner@redhat.com>,
	Jan Palus <jpalus@fastmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/exec: Build both static and non-static
 load_address tests
Message-ID: <202405082312.D922795@keescook>
References: <20240508172848.work.131-kees@kernel.org>
 <20240508173149.677910-1-keescook@chromium.org>
 <1f6a2905-395d-4f81-9ee0-57c541fb2486@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6a2905-395d-4f81-9ee0-57c541fb2486@nvidia.com>

On Wed, May 08, 2024 at 07:54:13PM -0700, John Hubbard wrote:
> Didn't we learn recently, though, that -static-pie is gcc 8.1+, while the
> kernel's minimum gcc version is 5?

Yes, that's true. If we encounter anyone trying to build the selftests
with <8.1 I think we'll have to add a compiler version test in the
Makefile to exclude the static pie tests.

There's also the potential issue with arm64 builds that caused the
original attempt at -static. We'll likely need an exclusion there too.

-- 
Kees Cook

