Return-Path: <linux-fsdevel+bounces-48655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 984B0AB1C06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 20:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01CA1C45764
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6032223C8C5;
	Fri,  9 May 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXxMSvLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BADC23BD05;
	Fri,  9 May 2025 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814154; cv=none; b=QSLS1sgAbDReRX97NNmbKqfmzWhrNXn03vJuwILQpXvEbF0u0WEPmZiISN9P1erKKuLLAx1xgWKIJum87JZH/YZdiCt8Uq4i1EgeRXFjChg3Z6lFO3TJYGuesPFU4OmqFTQU1TTZTHo2yZwEz++ia+X+ZGqtlEdS3iI2WOeXOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814154; c=relaxed/simple;
	bh=o3aqF2cZ7prE9lem+Axxs/68qbd5Oyb8f3//e0+M6fM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ZQBMXQMU5xytYr7ncCKLkhhYa+DqMJZ9Bjr8BbhjVtMgOJlnqmUTRsh4DhNRgK7oEoRGdMd09rmWe9TK0Ipxfdnmtvy+NAsR9izuZZ6n8dVw/Tso0ev7E+gaZyOMQrjFkE1+AObXabsdDmfDC5vdeQTwONQlpAmsbYJMohhkWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXxMSvLX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2996012b3a.2;
        Fri, 09 May 2025 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746814151; x=1747418951; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MBHyHB1Dk1aI/SNuHaIc0QgPMAr1z+7wIjvpDGXz4WM=;
        b=OXxMSvLXMHZsvKgFjgh37eWgHmK0QIoF1hHPxRooD3J5Po5ceQpJYlQN4Sf9N+mwBj
         MZKoOe4GwAUJhQz1uSdyysgllgyuM9T9Ywi4k1ZBnklv4QflJCFYWWc9JnZ77BsgcpwM
         6jZutTXFmrgumwcJMyTtksHdnibaYCkFx+/Eieurmr7/jnJdk5BzKH/0cpEbd70NSOTz
         TeEz92ZDznU1rhYJLyBB7ukFKqMVU2EX/QPG/t+CLawN6uNaD5PGFkCaAAA3BvNafMz7
         ShWi7sVrLp7bqPr7Lm1+QMnDm0vDXXaotoXZN3p8FDFgJMJ+G909L5zZ4zCw0plFKC1B
         rF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746814151; x=1747418951;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBHyHB1Dk1aI/SNuHaIc0QgPMAr1z+7wIjvpDGXz4WM=;
        b=pZfDNIAQ+aub6OGQgy/Yogf2H5cbav+KEjO1SMKOnBLGxKxqFWC5zbn35PxS8x77qo
         5/5gQjaHF+klrZiZSdD+GwDn2ASa4C1RYG/dD8ebpox9WAbp7hXIlZ1Nz3rWWDPU+Pfk
         jJPHhWQXxv+QQ3yeVaDR5F6m9e5NhLuObKGOufKB/HKULO95XLNk5DI5glTOqqimUujn
         3a0/mRyBINE12o5Rpsflmx3PYNEYGdaQXUm5wmmTgcVkAEbhTlpVTfq0zaJLRz8CkcFH
         nISV0/ApnPeatzJ+zoctKQuGkFl43uPBj4B1A6tD6yfoEhlqWJPs5bEHeOjXad46rgL2
         IESA==
X-Forwarded-Encrypted: i=1; AJvYcCX6PPaacGRRGk1wYrs9e19rrvcnfOr1F1t184icPWEtIqUy3J+rxxDccT2Jnp3kj6co1zz4S8SQQGalyrHZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2NoJgXSPioUT3KC1AvY01LrqIh69hVIvq4orWuYcQ+longwk
	M6Nvq5XCsAlcglfSC5jNv5knUGyn+XsvtorHNeUpMTZYGgWvcuAso9nnhA==
X-Gm-Gg: ASbGncvj8WJd7bzPxs0vEkPkihwKX1uFXtjI7elYUJ8yLYJxKY6IGc3o4yV7tTOLKF1
	VbhSZA0ue9dmvM4blFePANUVGsxYU9ZrROJcs7VyHSCVzG28OtWEZ76R5A2yiyetgCyEgZnKDh+
	Oub3Z4NwpD+320S1rTxQRyDlwEVZsX57+CUxj1xtouN96UX9bnUwNETQCPc5YkJk1cWx9ZT70+u
	Qn1fun7hzarCoJoO2gqVTbhwXO7WXo+5mgX6I8DsVE0P4UIrOGNlazImeUabYd683hVCDB5zOOm
	WZOw7JtRdAGOOoJWbN8L3bDocubzqdCFTD5n2gQaSgBJ
X-Google-Smtp-Source: AGHT+IHCCagfbMlF+HCEhFnc3WpilDu595YDEhX7OaURxQDSQkqL3rjCm68ctGB0QZnkzzh8AYp2YQ==
X-Received: by 2002:a05:6a21:318b:b0:1fd:f55f:881e with SMTP id adf61e73a8af0-215abd22460mr7595451637.36.1746814151050;
        Fri, 09 May 2025 11:09:11 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a3d1cfsm1999385b3a.127.2025.05.09.11.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 11:09:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] ext4: Add multi-fsblock atomic write support with bigalloc
In-Reply-To: <cover.1746734745.git.ritesh.list@gmail.com>
Date: Fri, 09 May 2025 23:12:46 +0530
Message-ID: <87h61t65pl.fsf@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> This is v3 of multi-fsblock atomic write support using bigalloc. This has
> started looking into much better shape now. The major chunk of the design
> changes has been kept in Patch-4 & 5.
>
> This series can now be carefully reviewed, as all the error handling related
> code paths should be properly taken care of.
>

We spotted that multi-fsblock changes might need to force a journal
commit if there were mixed mappings in the underlying region e.g. say WUWUWUW...

The issue arises when, during block allocation, the unwritten ranges are
first zeroed out, followed by the unwritten-to-written extent
conversion. This conversion is part of a journaled metadata transaction
that has not yet been committed, as the transaction is still running.
If an iomap write then modifies the data on those multi-fsblocks and a
sudden power loss occurs before the transaction commits, the
unwritten-to-written conversion will not be replayed during journal
recovery. As a result, we end up with new data written over mapped
blocks, while the alternate unwritten blocks will read zeroes. This
could cause a torn write behavior for atomic writes.

So we were thinking we might need something like this. Hopefully this
should still be ok, as mixed mapping case mostly is a non-performance
critical path. Thoughts?


diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2642e1ef128f..59b59d609976 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3517,7 +3517,8 @@ static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
  * underlying short holes/unwritten extents within the requested range.
  */
 static int ext4_map_blocks_atomic_write(handle_t *handle, struct inode *inode,
-                               struct ext4_map_blocks *map, int m_flags)
+                               struct ext4_map_blocks *map, int m_flags,
+                               bool *force_commit)
 {
        ext4_lblk_t m_lblk = map->m_lblk;
        unsigned int m_len = map->m_len;
@@ -3537,6 +3538,11 @@ static int ext4_map_blocks_atomic_write(handle_t *handle, struct inode *inode,
        map->m_len = m_len;
        map->m_flags = 0;

+       /*
+        * slow path means we have mixed mapping, that means we will need
+        * to force txn commit.
+        */
+       *force_commit = true;
        return ext4_map_blocks_atomic_write_slow(handle, inode, map);
 out:
        return ret;
@@ -3548,6 +3554,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
        handle_t *handle;
        u8 blkbits = inode->i_blkbits;
        int ret, dio_credits, m_flags = 0, retries = 0;
+       bool force_commit = false;

        /*
         * Trim the mapping request to the maximum value that we can map at
@@ -3610,7 +3617,8 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
                m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;

        if (flags & IOMAP_ATOMIC)
-               ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags);
+               ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
+                                                  &force_commit);
        else
                ret = ext4_map_blocks(handle, inode, map, m_flags);

@@ -3626,6 +3634,9 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
        if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
                goto retry;

+       if (ret > 0 && force_commit)
+               ext4_force_commit(inode->i_sb);
+
        return ret;
 }


-ritesh

