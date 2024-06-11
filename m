Return-Path: <linux-fsdevel+bounces-21465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24090441C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 21:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E089C1F244CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61287E57C;
	Tue, 11 Jun 2024 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CpNB9mt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052B7E563;
	Tue, 11 Jun 2024 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132392; cv=none; b=c28mNAfP2TZFOv3IaDOWDyvojR6HamBcrn+l+9Xi+UBKT8AoSqb47hLUVzuyP+jT+RDaBz95w3t3J3OixSPeY6S/fILwrgo16Vt4xl5X0g55m0maY9FXtFFl1bYIxD9RNU2qovtljb3gsp/H8xi5guZPNzIljfWDbTkcQS1Lc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132392; c=relaxed/simple;
	bh=Z0AdnMQuPM/Bin8KMAQKa4YF3YN0x9Dx2QEDp/iveXM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tZEyzTgq5Mi5g0FYEv7jOgWx/ofYErDii10SxJwZwnKEVqhGWYS3JiyW/KO5KU4BIDIqc4SHF0Ff6OelGjZYnh/A8PZP9CTMvF8G8uetaoPS6DB6grzaySSKt+g9MRF4S3VAWG1HeC1KUovrPdvnWtuzr6v5P1Stmxd58Wmonuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CpNB9mt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6CBC2BD10;
	Tue, 11 Jun 2024 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718132391;
	bh=Z0AdnMQuPM/Bin8KMAQKa4YF3YN0x9Dx2QEDp/iveXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpNB9mt7iK6m7a1s7BE80uyrEbYDQ23XIzOC8afqYvNTO/jYEX7DS+XoovRYE4nem
	 21ezMNwnb8PmAtxttYf9hkWWH9L2USPR8Tcjiz4WqqFzdRWBd9tWstqCEEiEyo23ZW
	 r4O8+3h8XCu4WEkmDHutyhpGUbbwi6EdYxOnu5jc=
Date: Tue, 11 Jun 2024 11:59:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com,
 surenb@google.com, rppt@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v4 0/7] ioctl()-based API to query VMAs from
 /proc/<pid>/maps
Message-Id: <20240611115950.35197b36eafe0a804ecaa0de@linux-foundation.org>
In-Reply-To: <20240611110058.3444968-1-andrii@kernel.org>
References: <20240611110058.3444968-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


(Please cc Alexey on procfs changes)

On Tue, 11 Jun 2024 04:00:48 -0700 Andrii Nakryiko <andrii@kernel.org> wrote:

> Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
> applications to query VMA information more efficiently than reading *all* VMAs
> nonselectively through text-based interface of /proc/<pid>/maps file.

Looks nice but I'll await further reviewer input.

> 
> ...
>
>  Documentation/filesystems/proc.rst          |   9 +
>  fs/proc/task_mmu.c                          | 366 +++++++++++--
>  include/uapi/linux/fs.h                     | 156 +++++-
>  tools/include/uapi/linux/fs.h               | 550 ++++++++++++++++++++
>  tools/testing/selftests/bpf/.gitignore      |   1 +
>  tools/testing/selftests/bpf/Makefile        |   2 +-
>  tools/testing/selftests/bpf/procfs_query.c  | 386 ++++++++++++++
>  tools/testing/selftests/bpf/test_progs.c    |   3 +
>  tools/testing/selftests/bpf/test_progs.h    |   2 +
>  tools/testing/selftests/bpf/trace_helpers.c | 104 +++-
>  10 files changed, 1508 insertions(+), 71 deletions(-)
>  create mode 100644 tools/include/uapi/linux/fs.h
>  create mode 100644 tools/testing/selftests/bpf/procfs_query.c

Should the selftests be under bpf/?  This is a procfs feature which
could be used by many things apart from bpf and it really isn't a bpf
thing at all.  Wouldn't tools/testing/selftests/proc/ be a more
appropriate place?


