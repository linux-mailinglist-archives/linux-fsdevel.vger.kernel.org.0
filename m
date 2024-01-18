Return-Path: <linux-fsdevel+bounces-8277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312D832136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 22:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBE72897AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA631A60;
	Thu, 18 Jan 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iS73GSEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84C2E848;
	Thu, 18 Jan 2024 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615186; cv=none; b=E/6LFwSfrmKWp6c5JgaFvwfyadLYOeZV4LAsJ5a/wTckbNK+qq70WlAdBibWr/90RBtkHzilPp/FscJ/VcgtCr8C4q/i26aqWwE4LLjSuo8oR/+G+xi1Khc5IN1mlr4wu/wbQxbdEiBezp69kwwVQE9m1XPDtuV4UAIzb58Pw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615186; c=relaxed/simple;
	bh=mSqSrX7G5ZUR4Mnn7J6yXV/zLXQD7Pr34tqNmgcTqBE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Oei4WUAL5zP6NVRZNpxPJEbH7LfsTchq0pXXGtRTcUehgrnaOCdPxYg6yXpCHpbjokPgCz9YZtigi8rsl5sn7MrSc478uhRvxtoVgl+Of4eVOx9nvOpS70w8T900oKGK3hATb/x5FSyf53mMHPgmra6e8z1tbUJxpY1wGi+qZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iS73GSEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B20C433F1;
	Thu, 18 Jan 2024 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705615186;
	bh=mSqSrX7G5ZUR4Mnn7J6yXV/zLXQD7Pr34tqNmgcTqBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iS73GSEOVBGj8srjQKqXxORp8aFyAUqqJrJieP4bSt+uz80QDAlDkQr+C+dTHzVec
	 n1WAekPJ/ujc0WiehjMBtxpcA0iQNxVNFcC4gKAwjPVZjQSkEeE6Xtwo2KhHRoAyB3
	 P0b0lol4VrgCn1uKfPTgI6ZtCRcORPz0UHuoEoIc=
Date: Thu, 18 Jan 2024 13:59:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com,
 kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
 david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
 willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
 ngeoffray@google.com
Subject: Re: [PATCH] userfaultfd: fix mmap_changing checking in
 mfill_atomic_hugetlb
Message-Id: <20240118135941.c7795d52881f486aa21aeea8@linux-foundation.org>
In-Reply-To: <20240117223729.1444522-1-lokeshgidra@google.com>
References: <20240117223729.1444522-1-lokeshgidra@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 14:37:29 -0800 Lokesh Gidra <lokeshgidra@google.com> wrote:

> In mfill_atomic_hugetlb(), mmap_changing isn't being checked
> again if we drop mmap_lock and reacquire it. When the lock is not held,
> mmap_changing could have been incremented. This is also inconsistent
> with the behavior in mfill_atomic().

Thanks. Could you and reviewers please consider

- what might be the userspace-visible runtime effects?

- Should the fix be backported into earlier kernels?

- A suitable Fixes: target?

