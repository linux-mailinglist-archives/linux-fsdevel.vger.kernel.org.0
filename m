Return-Path: <linux-fsdevel+bounces-18538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1318BA37D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E5284B02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A071BF3B;
	Thu,  2 May 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QO8WDE7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D81B810
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690344; cv=none; b=C4X0bzuytoxeoiS0nSE4mqkYawvqD6bW0K7EN4ooDcryKHdpt8YDGkNDqHq4N6615riAmo46P2Toty6DMpruQiZiJZpsVNHwmhc341sNR0N4A2FBC9AXtSgjJSrIkErpub3SKoLRxLJj6IdeRwNnz4e7xY9IT8VA5uKEH96q8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690344; c=relaxed/simple;
	bh=N2PaycxEmY7XWj03FUl9SZb9HROv6N5dMS34YzMs3ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCa8OHjvecdUkLwhem9GLsmUlazBkIYSO7hf7TsE9GoBjNUBhHgHkHfXZY8L60jCpqNHUb8WpzmS73oaMi7m01PI+d5TRKSom0D4xWbkG9r6yklIe4ihUkfSWoLrDbL1Yg7VQf6wQ88aYZZDQT1scBekYs0ekiAsm8j+gTCMAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QO8WDE7X; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f074520c8cso8093517b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690342; x=1715295142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaFsfP7DKpgQNfEAphXpGxTTBp7ycaxayFvxorBszwQ=;
        b=QO8WDE7XgujGXM9YBez1z+Fki6cqLMk1iBvSPpVxul8fnUPTysO9UOYYIf7OmIxup5
         xUP+ABJq2Zb685i4SXMsjzFPHjseWjNbVzNbbWBXKxGeQryaxRXKK2+ZYpfbeLFw36Tg
         /4MKWU02/CFdSE7hsy87x9KwJuQ0/cDN5/yvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690342; x=1715295142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaFsfP7DKpgQNfEAphXpGxTTBp7ycaxayFvxorBszwQ=;
        b=rWD4gVq16DEYBxpIT2sZY7wT0Fyrvrr1rqj+Hbq8vW3BEs/PEEAQtW5JbVFSXNnpRN
         BaJLjOacIiOwCEFyko5xG/eK3mStmXd2SEadUJOJ/yp5Nw/hJSQ5o/K+uCgxTig04d8Y
         6sqhN7X8XTF6lok+AjplSlJDCI+NH/dvAOsQL6GrZqOzfyHbV0aJ1VGfuvbB24TkGiSx
         jInqK8gdtYyCmMH4cihGzU5I0DBUey6TyXT+lH3ZLHGLiGMUBKExJjoD0OWLUZwLqBtI
         FxUDAR7hVsrFvKIX9246yj+OOz2ZBHSIh5sA1YHlAwMOipTLw2/LH5MEXZWqpkmsu2e5
         UeXA==
X-Forwarded-Encrypted: i=1; AJvYcCWxBo7qbWLscyRTzrNFz7tGL2whxTD3zcjsM9T1s7BhY/0dsYDVPH3LnGW9tZiOMwTrxLWIXzhMCHLwdutRVXjRtA0HENVjC29gYqk07Q==
X-Gm-Message-State: AOJu0YxySiObw6CrJZvzLHzKTT1qyAe1FzehMcPC/lEzaR7qdkMQUDzk
	q07exPQN9MMlPKW9j5nGhy+QUrE8UBh0iFQAbSm/6gi2DXLVENqOoOIM6pE6Dw==
X-Google-Smtp-Source: AGHT+IF6DEKM5OKMglZmn4Z71ee5/EXabaGMMWGKP6YJ9ZMYVLGTNQcbbL5IuYd27jIZQ8XL5S2yPQ==
X-Received: by 2002:a05:6a20:e687:b0:1a9:8836:ae37 with SMTP id mz7-20020a056a20e68700b001a98836ae37mr1313878pzb.12.1714690342568;
        Thu, 02 May 2024 15:52:22 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz14-20020a170902ef8e00b001eac94472f6sm1877632plb.93.2024.05.02.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:52:21 -0700 (PDT)
Date: Thu, 2 May 2024 15:52:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: Convert struct file::f_count to refcount_long_t
Message-ID: <202405021548.040579B1C@keescook>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-5-keescook@chromium.org>
 <20240502224250.GM2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502224250.GM2118490@ZenIV>

On Thu, May 02, 2024 at 11:42:50PM +0100, Al Viro wrote:
> On Thu, May 02, 2024 at 03:33:40PM -0700, Kees Cook wrote:
> > Underflow of f_count needs to be more carefully detected than it
> > currently is. The results of get_file() should be checked, but the
> > first step is detection. Redefine f_count from atomic_long_t to
> > refcount_long_t.
> 
> 	It is used on fairly hot paths.  What's more, it's not
> at all obvious what the hell would right semantics be.

I think we've put performance concerns between refcount_t and atomic_t
to rest long ago. If there is a real workload where it's a problem,
let's find it! :)

As for semantics, what do you mean? Detecting dec-below-zero means we
catch underflow, and detected inc-from-zero means we catch resurrection
attempts. In both cases we avoid double-free, but we have already lost
to a potential dangling reference to a freed struct file. But just
letting f_count go bad seems dangerous.

-- 
Kees Cook

