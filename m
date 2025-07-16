Return-Path: <linux-fsdevel+bounces-55193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D1B080BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 00:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D828D1AA0E83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 22:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26A42EE994;
	Wed, 16 Jul 2025 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xJ/u4t0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDD264604;
	Wed, 16 Jul 2025 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706547; cv=none; b=e4d0C+vwDx4FuUH9V7ArIOOyffWlRbloJcvonMb+jq6vF0Rb1c/Tn2i1nyZ2wbaVGSmSVXmj66RJ+nh+kXRL8keSLp1FrOfAICu/HELk3agnLD+2hrvpUDxtpAouSL2v023+VkXjc8zDtJJ+oIEKR/XNwJKHBMGaVN97IYqvT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706547; c=relaxed/simple;
	bh=M15hhWxvkrQ1L1CucvfJyp93jR83Hf419GuFwWEd5SI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qQ/nUiPmii872T8ZcQkPVx+Liy/z/erVwhWg1FjwxShb5kl5aikQuHj8+kO76+9/FIosv0O2u+ye+rZ+4XIabYGIWIkCd/1OwPK5sT3Jf9J9ERp/y/y6iqmNT2WD2Csp8dlINeWkGVUDlvZqilXkyYsHzrd/YkX1jhzUSz+KBTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xJ/u4t0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6095C4CEE7;
	Wed, 16 Jul 2025 22:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752706546;
	bh=M15hhWxvkrQ1L1CucvfJyp93jR83Hf419GuFwWEd5SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xJ/u4t0W6LZyLuQhgQBYJts0DqKsJKkQrPIegf3swDXWAgKsQUQA+pDgZBEl0rlMe
	 NRi7NpMVQ/mXuW+yNL7vdueD5pKEJSG6QV4aghESMZSEbFiMmU9MxQ9DNBMzpGF8Ns
	 p7NInuja5l3/ZPEfS0/FPbWAQymGGXImQ/VFhN+U=
Date: Wed, 16 Jul 2025 15:55:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com,
 vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org,
 mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org,
 adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com,
 yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org,
 osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com,
 christophe.leroy@csgroup.eu, tjmercier@google.com, kaleshsingh@google.com,
 aha310510@gmail.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 0/7] use per-vma locks for /proc/pid/maps reads
Message-Id: <20250716155545.ad2efdd41c85d6812bf328bb@linux-foundation.org>
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 20:05:49 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> This patchset switches from holding mmap_lock while reading /proc/pid/maps
> to taking per-vma locks as we walk the vma tree.

Thanks, I added this v7 series to mm-new.  Which I usually push out
mid-evening California time.

