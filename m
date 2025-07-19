Return-Path: <linux-fsdevel+bounces-55518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07153B0B2BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 01:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF8FAA371A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02ED28A730;
	Sat, 19 Jul 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kHZjQLdQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D72E659;
	Sat, 19 Jul 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752967129; cv=none; b=aIIOtKfCMXTKv8mEkzazD5zWM0o0X9FTRC+C5ukJ3+Dw5Shwa1R6FEQFxpPWeU9nBh2MkCzx8ph9pNk/Srk+v5+DHTt8CLOZdFXSyTvnVA144uUXdfagC2TYmV8A2/zPsss7RLnko1I+BV47u6wzY5H26ou6EyDYK0ZQzRxFsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752967129; c=relaxed/simple;
	bh=HyoTfwEg4C9wFU+VWZw2N+JdhbGSMa6Fwx18HRuaSdw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k8gHF1ceehBqK4qmK69qzPxvDZSFtMSdu6YriS8xzcMPI73G5X7nijV3+bA0XIpMLZAuYz2yxR48NvAVCIU2IFoE4xMeh7gZl+qjJiPZJ9lbzjyvHvyaAur3gvwL/8guhq5j8TQYyrpOh0v1OReIHTUTLeXU7iLCUitE5JkdfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kHZjQLdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20885C4CEE3;
	Sat, 19 Jul 2025 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752967129;
	bh=HyoTfwEg4C9wFU+VWZw2N+JdhbGSMa6Fwx18HRuaSdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHZjQLdQm8Xd5WDVH+rbSCpn4w/crzJeE7U0jVXaAHh85IQb4ymFyKBdkdb2JtxgA
	 IV0yh3LTSj+yqNFLN3FGXtRnfnCuMF4hi2YhV/1zB5NTX6RJ53fTleakMXnP4t9kuP
	 E2riMY89gRTBvzLWewW0lNyvJDahQVYHYbysuiSA=
Date: Sat, 19 Jul 2025 16:18:47 -0700
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
Subject: Re: [PATCH v8 0/6] use per-vma locks for /proc/pid/maps reads
Message-Id: <20250719161847.d09abb0c9a0db0b94c4daa23@linux-foundation.org>
In-Reply-To: <20250719182854.3166724-1-surenb@google.com>
References: <20250719182854.3166724-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 11:28:48 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> This patchset switches from holding mmap_lock while reading /proc/pid/maps
> to taking per-vma locks as we walk the vma tree.

Thanks, I updated mm-new to this v8 series.

