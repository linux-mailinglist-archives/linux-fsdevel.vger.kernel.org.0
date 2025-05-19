Return-Path: <linux-fsdevel+bounces-49395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E6ABBB6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21143179D31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C826A0BA;
	Mon, 19 May 2025 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnP0n8nI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFD3208;
	Mon, 19 May 2025 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651724; cv=none; b=sYIfDaxm/0oGMzjtKwfD+Th0L56LpOzzfRttaeKo4QoQlrxOcmjGyKALmvIMfjs2Gfmah6H9cjQ/88xgYy1EBx5Ma+1SvHm4pFnF8/sU20EfUghLYFfksniHQuVQtRel1Ous3+Qv25P8QzWVCNi3t5Gc+un9VqOnAxiITzjW8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651724; c=relaxed/simple;
	bh=10nLNhZ6GFrdReHtylXJB7WK6jzttMXX1sTFVKmQ9Q8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=BSDTZqQxdnDOVH7IWLRGyA54CFgQ7Ze/r7FdwEdlMSnwoGd/j0frB0hseVp27oit0JApYjhxxTlNuJuN2cLFiSfMkZZA24WKEOjuUWtdkZ6DGRvXK/GjHkQR2vDbgFQSrW666bLb2URB8fDx8i9PwfPIvNt2mOWgaT/0XVZeRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnP0n8nI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231c86bffc1so41132805ad.0;
        Mon, 19 May 2025 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747651722; x=1748256522; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p5QOKNkL19Kp3xC8l9jIeYjLGhIQ9n7VjMtSrEEZQbc=;
        b=bnP0n8nIc54CZGqVjAt3dhEcKPn+PScscId6+/mvRtV5rFRziKhppD+4eK5TufjTXB
         dmaLLyFtvfFoe1/JtrT4e++Cbn0XIOBMa1QIqMusCTLfCIIpfrNOOOzrx2bEBJVA5gEo
         W3Mq+ZXhS1Gj/j5BbIXd5Jt+86cvYv1WRntRLyaQbETgkra+/9HLIMae3cI0fUhXib6U
         /5WViDj8fW8BsBfYPoJlZgijcSAiO/5FoPt8YLUsKrEvpc6vjHhpV9GPrM+ZS6D0H9XA
         UJvfpQLeSwqjfQwhC6qKAAFrZn+MW90uF4fMtZDwxe0Q0KfBSVf9qa7V34WOW2qo2tdo
         zumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747651722; x=1748256522;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5QOKNkL19Kp3xC8l9jIeYjLGhIQ9n7VjMtSrEEZQbc=;
        b=E+CxyIfFUHLevX/2U3fKFHGr0s8FfiaZZRnDPZgbcVDXnBrmXYiiIfR6lFbdw7Xfmy
         Z4UZGu1Mz/kvHrJd+d4SqE8gnE9QwGFf8wuSyYkQTynp6knDwDU9WVdA1y5LAuJS1g8o
         zFrUlLuzjeaJHCZZPntgOziRPtNi2ZmJeh/XfzD25t9bsEf8CLMMD9FYadGs9DOtYkXw
         rhw6NXW1VsM99o4TTGPhbRKJc6UMFoKtf4YgkSEcv7VWp9lDaq8Y04OJpdL/3bD2ntSd
         K6EA9O2t7MDjQmPtgJtl9LINdYMlWCYkhPGEV9Bh8r/VaGegcPbTHtlRduQQsLHPU1zJ
         kpqA==
X-Forwarded-Encrypted: i=1; AJvYcCVThxirUkKc5DEDXbD5o13CqytO0N5clkt8hZsCK+x6VE/835TvzjMwion31Eh8o/dimk0pdQWU3SN9@vger.kernel.org, AJvYcCW4QpkK0BFvqQsB9t4hIAqGx9OZVj2frAGxwgndmPGS2vrVfM7fP42KbEkLESnQBl+dpzSCzfsj/1RnIUA41A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA3sphacd9LqFLRWik+V1Z/uwBUWfYDy4WuTaSEehpUwifpFkh
	X3tJzQ8pYohbzdiywsoZXUHuc+N4niuRJy0Hdy3OVP52cgb0EMB7L1CyHnkwTw==
X-Gm-Gg: ASbGncsFcN7cvv48PkHa06KOSLGc4qwBCmCYZD+AbjrKAYOwnQRUFwBNgzLr9aB+pPK
	eAyDOe3bjdVKN8PrB25cUjfHtW+eTPEkaCXweCY4oEgLV7eSVhEwP9jjbcwExq+AnoTrm6fhN+I
	m4sfxr4+slCP1YYjHCLj3U3dmfnDbDWwLZYNuXZ19rpUNAzcl4mBKXCOcwdZVihLla0Emyz/x/o
	97GaZ30flOOeM1qj872IB8S/Kj36NNREUvCTyxJCtlTATNobT68m6Y8l6/O5XJPYZkCrGmffjpt
	x/39FC9supsoO3nb1MDDmgAxe34m0WHJlDOf1v6gZME=
X-Google-Smtp-Source: AGHT+IHw+YJ5sE4VnZc70gzP29WqwWASwuT643VaDkN8HVjtMhhlPCF7dCd7G3WF6/Q6iEOqOze5hA==
X-Received: by 2002:a17:902:f78c:b0:21f:85ee:f2df with SMTP id d9443c01a7336-231de35f324mr185427885ad.15.1747651721829;
        Mon, 19 May 2025 03:48:41 -0700 (PDT)
Received: from dw-tp ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm56857705ad.147.2025.05.19.03.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:48:40 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 0/7] ext4: Add multi-fsblock atomic write support with bigalloc
In-Reply-To: <cover.1747337952.git.ritesh.list@gmail.com>
Date: Mon, 19 May 2025 15:37:52 +0530
Message-ID: <877c2cx69z.fsf@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> This adds multi-fsblock atomic write support to ext4 using bigalloc. The major
> chunk of the design changes are kept in Patch-4 & 5.
>
> v4 -> v5:
> =========
> 1. Addressed review comments and added Acked-by from Darrick.
> 2. Changed a minor WARN_ON(1) at one place to WARN_ON_ONCE(1) in patch-5 in
>    ext4_iomap_begin(). Ideally we may never hit it.
> 3. Added force commit related info in the Documentation section where
>    mixed mapping details are mentioned.
> [v4]: https://lore.kernel.org/linux-ext4/cover.1747289779.git.ritesh.list@gmail.com/
> <...>
> Ritesh Harjani (IBM) (7):
>   ext4: Document an edge case for overwrites
>   ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
>   ext4: Make ext4_meta_trans_blocks() non-static for later use
>   ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
>   ext4: Add multi-fsblock atomic write support with bigalloc
>   ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
>   ext4: Add atomic block write documentation
>
>  .../filesystems/ext4/atomic_writes.rst        | 225 +++++++++++++
>  Documentation/filesystems/ext4/overview.rst   |   1 +
>  fs/ext4/ext4.h                                |  26 +-
>  fs/ext4/extents.c                             |  99 ++++++
>  fs/ext4/file.c                                |   7 +-
>  fs/ext4/inode.c                               | 315 ++++++++++++++++--
>  fs/ext4/super.c                               |   7 +-
>  7 files changed, 655 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst

Hi Ted, 

I was working on the rebase over the weekend as I figured that there
will be merge conflicts with Zhang's series. But later I saw that you
have already rebased [1] and merged atomic write series in dev branch. 

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=dev

So, thanks for taking care of that. After looking at Zhang's series, I
figured, we may need EXT4_EX_CACHE flag too in
ext4_convert_unwritten_extents_atomic() i.e.

	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT | EXT4_EX_NOCACHE;

This is since, in ext4_map_blocks(), we have a condition check which can
emit a WARN_ON like this:
	/*
	 * Callers from the context of data submission are the only exceptions
	 * for regular files that do not hold the i_rwsem or invalidate_lock.
	 * However, caching unrelated ranges is not permitted.
	 */
	if (flags & EXT4_GET_BLOCKS_IO_SUBMIT)
		WARN_ON_ONCE(!(flags & EXT4_EX_NOCACHE));
	else
		ext4_check_map_extents_env(inode);


Other than adding the no cache flag, couple of other minor
simplifications can be done too, I guess for e.g. simplifying the
query_flags logic in ext4_map_query_blocks() function. 

So I am thinking maybe I will provide the above fix and few other minor
simplfications which we could do on top of ext4's dev branch (after we
rebased atomic write changes on top of Zhang's series). Please let me
know if that is ok?

Or do we want to fix the original atomic write patch and do a force push
to dev branch again?

Please let me know whichever way works best?

Thanks again!
-ritesh

