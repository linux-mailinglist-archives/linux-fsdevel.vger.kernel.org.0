Return-Path: <linux-fsdevel+bounces-49788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A444AC2881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 19:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233CE4A3320
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4B2980CB;
	Fri, 23 May 2025 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6judB9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE3297A71;
	Fri, 23 May 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020988; cv=none; b=cLmyrRLP4cbklIvKXI9qnN/gC7wwwOcIGS4puMa/R9tl7bCwHdnF83zC3jaZWyrW8GyCeDPTB0RIS+1P5u1pqSwG3GQ2AKlbuyo6FfJOUE3XGjG9xx72Xk0FpjGZm11gy8BJel7hRRALzre4LeTa32Sp3p25Y5f9Vi9/tYT9ILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020988; c=relaxed/simple;
	bh=NUvbc6H+63QwbLHlhk9ScPPC6XeQK+9ekKzWJM7gBxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JmYq0HlhH+vmUgUXVPWkM8azCnTP4G6KRA6zxxbVwryRe8b4OhkTsCIvzaw4opliMIjPGLuq/dbskWXdoSPM9OmYSGlTRPSN7LK/SPnWobbLFe59TDFIFjrFejLryhiTVaof+bCtI0SvPxGsQ0VILkjE9jdA/piltvArpPDI1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6judB9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D466AC4CEE9;
	Fri, 23 May 2025 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748020988;
	bh=NUvbc6H+63QwbLHlhk9ScPPC6XeQK+9ekKzWJM7gBxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6judB9iBxgyeVnV6AglZMnfWJRVmqj8bnQ3XfIfutH/CFnB0Ytq8OpY7yrzsITKw
	 4w/+++NZ37QXH+vjnvQSmXgEwJhIVcBj0ybcoyzIP4CsyvWVxBRBvZkQNLaqhNMdsM
	 pUGB/jlrsiEUm2QvwVqg3T24lA2+RmYfMW2t4CuziLLZGZlVFng9wXtN2mAtht8YiN
	 1SXnunl7LsIb2Z0DXfYxveTP5KVIZ7aP3FJ6WhCjDbTIuKhkThrzfsG44ceJhInObq
	 EhzMCOtrq9tWwM5X7YVSciVszwjhHTUy/UiYYC+1tNTXOa1oxSEhpM0twVP2Qjomh1
	 zgdNJ91cFcnoQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	akpm@linux-foundation.org,
	david@redhat.com,
	shakeelb@google.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for users
Date: Fri, 23 May 2025 10:23:05 -0700
Message-Id: <20250523172305.57843-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523172029.57745-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 23 May 2025 10:20:29 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 23 May 2025 11:16:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
> > On some large machines with a high number of CPUs running a 64K kernel,
> 
> What does 64K kernel means?
> 
> > we found that the 'RES' field is always 0 displayed by the top command
> > for some processes, which will cause a lot of confusion for users.
> > 
> >     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> >  875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
> >       1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
> > 
> > The main reason is that the batch size of the percpu counter is quite large
> > on these machines, caching a significant percpu value, since converting mm's
> > rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> > stats into percpu_counter").

Forgot asking this, sorry.  Should we add Fixes: tag and Cc stable@?


Thanks,
SJ

[...]

