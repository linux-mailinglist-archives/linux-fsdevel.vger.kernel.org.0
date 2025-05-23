Return-Path: <linux-fsdevel+bounces-49787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EFCAC286D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 19:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BB81B66B7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DCB2980A2;
	Fri, 23 May 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kunSfAmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DA22318;
	Fri, 23 May 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020833; cv=none; b=NbJwQXDf5RSVf8DVUAhBpKS8JHLzU8OhN9yyV0ZWFR4nG7CWzPPo+fBhCEds2Xt5iqEPYyTWF1n5f0D/EEHoEOT/uEcxt2hcGHPiNRaCrhBMCD7567u0KfwAx0u8xZCC+YAEJ9RT1TTFbTlsjllGOYSZfY3isvSQB1hq8d356Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020833; c=relaxed/simple;
	bh=3PJ2sXRRuy9FBVHB60fefL2TsE8bj4CUwAYyYK+swB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KuQnGnjcMUG4ReIkKbZ1yDZVYChRbEUcEf9Emx9B1eGkqa4X8OSzhmo+e47ZylbCrcyw2pEJgvTkiCY+VDzGUk69U7RRABmQCyoU7R/MqcaqC0NjdpLPQAsP3Ey+nMCHaq2gLVnfjD0iOk/sRy63plMw8DsZRyCcEP1avUB35VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kunSfAmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EE5C4CEE9;
	Fri, 23 May 2025 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748020832;
	bh=3PJ2sXRRuy9FBVHB60fefL2TsE8bj4CUwAYyYK+swB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kunSfAmIoAi5C2EnVsj9XefCcZGH1ON+nVJ1t4jdkq9sz4rdy/kBsGK6fv6hbk8yK
	 5gV7Ee3Y6FtwOGH+l4xbJKfDyr8bH/5D6BcG4V4H69lS8+18zyh5J5X+1im9mtwk/o
	 HFdcoj2YFA3Xq8bRiagmLudG8wvL7Kk3zMxZZaTxlV2Z8D2rtj/frdOhZEDsAehkVz
	 bMZafCAYm+MXE/zvCEU4fqBO+bnRiYLJZwQSBcUPBiofMYDkSp36rfOOjBuW6hkr2z
	 K5ftfGYJC0T5xgk57VXZkr/iAx7aKOnmJD7Mlk1/ZnH71gnn36bmX0k6FfZhcaVL/m
	 OSoSayO00Qk4g==
From: SeongJae Park <sj@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
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
Date: Fri, 23 May 2025 10:20:29 -0700
Message-Id: <20250523172029.57745-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 23 May 2025 11:16:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> On some large machines with a high number of CPUs running a 64K kernel,

What does 64K kernel means?

> we found that the 'RES' field is always 0 displayed by the top command
> for some processes, which will cause a lot of confusion for users.
> 
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>  875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>       1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
> 
> The main reason is that the batch size of the percpu counter is quite large
> on these machines, caching a significant percpu value, since converting mm's
> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> stats into percpu_counter"). Intuitively, the batch number should be optimized,
> but on some paths, performance may take precedence over statistical accuracy.
> Therefore, introducing a new interface to add the percpu statistical count
> and display it to users, which can remove the confusion. In addition, this
> change is not expected to be on a performance-critical path, so the modification
> should be acceptable.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

