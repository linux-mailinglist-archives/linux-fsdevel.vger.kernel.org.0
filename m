Return-Path: <linux-fsdevel+bounces-34181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26829C37E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28607B21669
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 05:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1163614F132;
	Mon, 11 Nov 2024 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fvneTsgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABF18E1F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304314; cv=none; b=AbPLacc9rLZXoMRAb/7mSh0qbOlhl1GytGw1E0/vUe9PnGMKIZMzx2+uSheahjpUI3PICl9wbUUZ8/vBNnS9GBgIEIC7+yV7GcvFKy+UJXFhvNXuQHDe9/6kHceQTEn34tzAHvp1DWHdqNgoK4PQq0B2IAEtHqZynfTcbw0X3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304314; c=relaxed/simple;
	bh=YEdfaM3Jd4KS472gYqcc4l9HPKkzSqmWnqgKk628khM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix4YSoYt1w1aPwCZCKj4toCOO7QQVyNgbrJ4Wp+H9swqa30V/RFOuG9UcuqN6brSOhtrNSrz6ppJLA+ns+MD+rFs72u1zRYx26U+kC2jrxRjyXJklRmhN2f6pwjgCOVyV/rO1QpY5mpLJ0Od7XDbaQcDFwEWZw4D4fsH1eU/J80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fvneTsgv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so3260742b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 21:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731304312; x=1731909112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Foh0UsYIXPUZmsrbDQnaRrOZh3M/3AkXvl3AtEjmLXE=;
        b=fvneTsgvZx2nYMaIPhM7Ncf3+q86NLvyXiDlLtEhYr9ih2KpBInRGvZY+NOnv9RcQE
         zsmNjn+jy/hMPD0VbHK6derUb8cxZlRNIEdwkjisqVQDgZXlM3H3Yz+sfymmlcjlCmhS
         xYHjuOgNaq0+D6dKUZRynhoiPIUSgpHdTAF9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304312; x=1731909112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Foh0UsYIXPUZmsrbDQnaRrOZh3M/3AkXvl3AtEjmLXE=;
        b=ZIxhfh01+JqbA1B9UMaRBIFeJ0y1kkB/We34/JdK5Hz/BnxiUyGSLtUB839/Udw27+
         WIiYi4oWEtTW/8goAN7KXxIBRuHBMsC7TZKA4bPVMK+/a4z2e6YFHf3wE7G0964PGpnh
         xxHkwrvgNK2RoUxjZFySWh1zvai+EF6HElV21L/H+2k1h1iJaXaQyCLmMHnRsY16TxzM
         /LeLYVwI9UeExh1VsXWzIZXLpZ76JvLBxhoXwpUiJJJ0FI7uEaFV+P9xoKDduRelwUss
         q25iJISRZSLXEcpfTdKItHBdi3P4j7/VUskdOthxn88m6lulMyzGgNmaOVJJqiSOQ1cS
         9fZg==
X-Forwarded-Encrypted: i=1; AJvYcCUby8TeweRfSP85dVUA4Eo9FyVfdwlMYxOkqYTUYBsm5TY1Cb837uAq/pg9GrtycQgm/fgcg9jEikQHlV3f@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrp2oQCcWkDLZ6RXfMVb6DN+CXxJFeKAVKJ5CWeaESVTnO9XE
	aGZJYJgPp8QwTYbz20nVBxccrcY/N/4rq4UOag5CWW5WtJqBJ9GBpvGsshqlf2fmY05GFt9fmo0
	=
X-Google-Smtp-Source: AGHT+IF/+AvkwmPA2wuy0MVZEKqJsApzJ/i3RyTv4BlbJnKa2Sv5Pc2joVr+5WcVWSGIEu5T64xndw==
X-Received: by 2002:a05:6a00:3a14:b0:71e:6a13:9bac with SMTP id d2e1a72fcca58-7241312915emr17467219b3a.0.1731304312323;
        Sun, 10 Nov 2024 21:51:52 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a43c:b34:8b29:4f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a4126sm8396292b3a.102.2024.11.10.21.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 21:51:51 -0800 (PST)
Date: Mon, 11 Nov 2024 14:51:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org,
	jannh@google.com, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/10] bpf: wire up sleepable bpf_get_stack()
 and bpf_get_task_stack() helpers
Message-ID: <20241111055146.GA1458936@google.com>
References: <20240829174232.3133883-1-andrii@kernel.org>
 <20240829174232.3133883-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829174232.3133883-10-andrii@kernel.org>

Hi,

On (24/08/29 10:42), Andrii Nakryiko wrote:
> Now that build ID related internals in kernel/bpf/stackmap.c can be used
> both in sleepable and non-sleepable contexts, we need to add additional
> rcu_read_lock()/rcu_read_unlock() protection around fetching
> perf_callchain_entry, but with the refactoring in previous commit it's
> now pretty straightforward. We make sure to do rcu_read_unlock (in
> sleepable mode only) right before stack_map_get_build_id_offset() call
> which can sleep. By that time we don't have any more use of
> perf_callchain_entry.

Shouldn't this be backported to stable kernels?  It seems that those still
do suspicious-RCU deference:

__bpf_get_stack()
  get_perf_callchain()
    perf_callchain_user()
      perf_get_guest_cbs()

