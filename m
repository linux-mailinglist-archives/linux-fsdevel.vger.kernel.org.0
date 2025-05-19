Return-Path: <linux-fsdevel+bounces-49443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9A8ABC706
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E472C7A1C6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD23A288C89;
	Mon, 19 May 2025 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUzhjVgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9D2874FA;
	Mon, 19 May 2025 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678809; cv=none; b=VXsSGN/KgTuD0JCDCwQcAYj+G1g0v5avVAbaBUktMy3V+LXUeQquga7KN/QXW5nGOAAIGV10rSS/yq1AEJzDY5Rj8sYpC9KsiMaepaSSlk7KvsZABD8L+ZCwz5a+rnZbIxkSdz80oid+R7PGJ1yBJeqbe9E4GNkmTm8fGyGQMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678809; c=relaxed/simple;
	bh=JOUGCF2Hy/FW9KUn7GZqUsInfXLOcwoBzJP6Lgsnk48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDSNnM//b++3l9+6F5TF+ONzcu2hgq89o4zLlCgKnlOiiX5fihpNB74pFMz2iJzxLDOO4bAhV+PZ3KAet8ttzry7b6ut7/QdWuzPyCLC1qbvCUbkZ+ln4FNMbz9gJvRE0LcCiZ8XTc1ht919aC1D/h0N3bOpL6+ktEqvhEmmt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUzhjVgR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23228b9d684so17293235ad.1;
        Mon, 19 May 2025 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678806; x=1748283606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjDfrKhrOpmYxJkCpjTWVPZMuaVKhq5fpcZ84IzpbVQ=;
        b=nUzhjVgRYEZ2HbeHfDfW4lryHGeiJvwWVOhzhwYctAcjb1JMuo0BQfCegeskjGWGkf
         EPsf6uKGEr60oAMXXpf/I5KVkDnqWykk30pcQiXA18LftqVPb8mouoySZgMfGsEobCq8
         wgWju0jVyCOmeND/1UlJwesulCKiJJu/7bg7f9CiOUwkvA/1pvVgS/gF5ny3SvyNQ9Uc
         KZq5ayE9keWnnahcuLYER3UqmuQ9NdaZgdKmCjKI+K/rtau8KOV2byakOElcU8GloRFs
         80CdebNEcKDooj/ELGZGhwAbbZt9oCl49nD+afJRWX5xQkAAmHCumDLm+NFP3UcdX+Q+
         ZakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678806; x=1748283606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjDfrKhrOpmYxJkCpjTWVPZMuaVKhq5fpcZ84IzpbVQ=;
        b=Rqkz2ttxUJKQdV64Dg2gnJx84nmGG2pWV095GEOmkBO+xpFB+ew5Kg2bWvU17KMvbj
         FtUS0K20t5e/iSrVtqwwmFZLe4MkYyqrGHvL29g0/09WsGMG4YDInddqf5imjKypA4BN
         sGBPoM4a0b+aidA0vozDb/ERzXwBX3reisN0Oc6YJYb+ddN/19CME/5uy4W8dk44GuwF
         LU+pMaeEjJVIt3sx1jMjWstpH39VlEikB2qcTr/WHFK7NUKTIRDIY+IFB1iMzPlHvdEl
         k3KQxfhCjwln05DdJdAIDQPu4Z441K2pY/BvMPkx5MqXuIGOfBPmBtmC7zIjHjyTw04v
         iYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW8a7lZSYPE+qWgQHRGvgn3jUty7CQN/JVfeO8cJKHGc5efXEgYMn0oyj71leo8/TXngVrHaF9L77oplPU@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqroKvfTulV6DQAHEBYbD+gYPpNYVXNC+4woKaZdq7tBXmAeU
	Is/ucXSg6Zi2pHD8kAlBXVv2A4MqQSukfPcNm+UFUCrvTBqKH5tW8q1JeIPNfQ==
X-Gm-Gg: ASbGncu8CPB8wHOhv9LoyAD/4uy5MkHHn58tdK3fGMc52aN9+vK8tjQuDwO3pX0x0xa
	CuOwI6nKYRfgEI+RT4c0sHKvgsH3Iieh1kULbRDbB3H3vPm/qg6fYM5M2VQLUKnLrcsPfPS0MGl
	IW2KXVGIEngYkj/V1Mx1BJrUjPRp6l821/1MqsQsmk977+y9Iajzqw7U1yGLeIQA+0Fj045RMTQ
	MpLAkptNTsFroE3yt0KF+nOmQbMQkbfnRmG3VFe4oa3GejZzW5FUk2ZZd3epaMYzBWp1ftVHaNO
	UhkdYyPsU8bNCEf6rLpMbLGRyNqvHcNtWEYHUo5SCNJbnBXqAYUj1/RL/UNxVsGrruk=
X-Google-Smtp-Source: AGHT+IFKUgKeRDyAjbJ9j08ISzc1R7NToLTnQ0ZkH4nDcqGjEBmqyoKkjoAP+Wt7A2CEgngQ1BHsUg==
X-Received: by 2002:a17:903:32c4:b0:21f:564:80a4 with SMTP id d9443c01a7336-231de3ae6eemr177267615ad.33.1747678806094;
        Mon, 19 May 2025 11:20:06 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ec3sm63156245ad.233.2025.05.19.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:20:05 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 1/5] ext4: Unwritten to written conversion requires EXT4_EX_NOCACHE
Date: Mon, 19 May 2025 23:49:26 +0530
Message-ID: <ea0ad9378ff6d31d73f4e53f87548e3a20817689.1747677758.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747677758.git.ritesh.list@gmail.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the atomic write patch series after it was rebased on top of
extent status cache cleanup series i.e.

'commit 402e38e6b71f57 ("ext4: prevent stale extent cache entries caused by
concurrent I/O writeback")'

After the above series, EXT4_GET_BLOCKS_IO_CONVERT_EXT flag which has
EXT4_GET_BLOCKS_IO_SUBMIT flag set, requires that the io submit context
of any kind should pass EXT4_EX_NOCACHE to avoid caching unncecessary
extents in the extent status cache.

This patch fixes that by adding the EXT4_EX_NOCACHE flag in
ext4_convert_unwritten_extents_atomic() for unwritten to written
conversion calls to ext4_map_blocks().

Fixes: ba601987dbb4 ("ext4: Add multi-fsblock atomic write support with bigalloc")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8b834e13d306..7683558381dc 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4826,7 +4826,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
 	struct ext4_map_blocks map;
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned int credits = 0;
-	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT;
+	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT | EXT4_EX_NOCACHE;
 
 	map.m_lblk = offset >> blkbits;
 	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
-- 
2.49.0


