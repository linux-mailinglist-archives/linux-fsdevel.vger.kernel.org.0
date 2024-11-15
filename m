Return-Path: <linux-fsdevel+bounces-34995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321369CFA56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 23:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12A71F23F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DC5192D64;
	Fri, 15 Nov 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/7dOaLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2856218A924
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710820; cv=none; b=tpfPIQRAl1jo0kVnOtMaoc+mMAIWxbh6I6N3kPOF1m5dFKfGhYjhg627rkOLZiacjD1xUo0Kvz0B89Bip9RwqOyNSUCAJklZGlz+mG2NXy9vj80LuPezt5tk6AFSG+Ih3yNxLW7jtBgWFB1nugQGSYUD+3nzlJxbph9xtiwGGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710820; c=relaxed/simple;
	bh=TtXpjhzAqSOM28Y8NyVZYfVn3ZFjzZISmYaD2WTho9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tS41k/Oz9xnf9aY2t1pDVcG7wjS1W6Yxj5tqeGo2l56SfSOGJtdTpl3di5dPz0KSo8tflZ2tnzjQctrgQqiZE4awK9+C+XeJ1l8BsX4YAwpVwkN3BjkvNSatT637bV/ksIZquRTmDjCJERb4QNrCGVEw1Vrepvqckutm80KFQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/7dOaLq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e5cec98cceso9880577b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731710818; x=1732315618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqTpYYj0xuVtKi0W3IidBx7k3eo4EvWfLhMFNi1N48k=;
        b=M/7dOaLqCFRK+4GS6ysN9vhbdWPGI34M2FVdBFNU5sD1W4dVqOxiqbbJfhZ6fHWmc5
         AgFdlJJur2TXPyc8DuALm9K0fAzqDdX5kTLb/tjKAra9555cF2B2rvm8j/kGEuy4sN/e
         EKb9lYKi3J+Sc6ShQFQEk+5qQZ/mYGnozARJUWVWC9AeuDKnjN0FKeMc59om9HHxG0Kp
         kigw2c0+v0tdsQOyNYW6BAQhIqKnA+onE8b+j/irfGRfuTP8+vNo79sipf0ZNPhuhV6L
         FYbI524OYVhkbmbacpOJ9DwyWwRHx+nK8CudkT1hcNKPhgsnulxBjuQbI1k85euNUi9/
         NH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731710818; x=1732315618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqTpYYj0xuVtKi0W3IidBx7k3eo4EvWfLhMFNi1N48k=;
        b=kGCumWnr0bcXVLI5g9pQJ5aCFQlR1iyXsst3LPgX5Et2vstd94lCVfckQXFw8ff34d
         NYIYOoFlDbMA3nRo8SWLkIxjvPT/y2aiuZUfnkj5lAFtbyUZbQ9HFPCr1ZteYiQ21eWL
         /0CGZ+UoZn7bzMlkashn9gKTSaXVNcSaq5C2W/mhfwLKQfAeCiE5WX2/L2BrTDJ6AQJv
         MzK4AoXkPM8pFhy/kIpa5NTAIzBKKlHvSDrTlN1gY6a2eN5xbZ4fIUCcbbJanub3WTCA
         B2J808ZnjR6ZD+C2a0Vhv0T97AcBMR9uWpKJ3XO8VFsHQVRY2GZSMAvahUG0hWyBZzRN
         4TTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdvW0Zg+s6EAKhuESJTflAIEYpofKAv2QtTX+h86BTgOuKAWR1HA7Mit/l/Jo9TnZaq0cfodkJVpOn+p1u@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXcTDDg3psZ6Iwg3b8KnD/ZTy6CWikKO6UW11YC1KJ7O96E8J
	awjSfbEdvax8vEBGK3uWWcDeV2wFVAExzUomMyKMaM4GJkZR1V2U
X-Google-Smtp-Source: AGHT+IHG2B4pBIMlMPyc7j9/RbvQB2IU9wmY3MOJI56h25nmFtflz9zG3n4erefydZn7TRsiabBC0g==
X-Received: by 2002:a05:690c:6486:b0:6db:ddea:eab4 with SMTP id 00721157ae682-6ee55c7897dmr58857977b3.37.1731710818032;
        Fri, 15 Nov 2024 14:46:58 -0800 (PST)
Received: from localhost (fwdproxy-nha-007.fbsv.net. [2a03:2880:25ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7127890dsm879117b3.11.2024.11.15.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:46:57 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v5 3/5] fs/writeback: in wait_sb_inodes(), skip wait for AS_WRITEBACK_INDETERMINATE mappings
Date: Fri, 15 Nov 2024 14:44:57 -0800
Message-ID: <20241115224459.427610-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115224459.427610-1-joannelkoong@gmail.com>
References: <20241115224459.427610-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For filesystems with the AS_WRITEBACK_INDETERMINATE flag set, writeback
operations may take an indeterminate time to complete. For example, writing
data back to disk in FUSE filesystems depends on the userspace server
successfully completing writeback.

In this commit, wait_sb_inodes() skips waiting on writeback if the
inode's mapping has AS_WRITEBACK_INDETERMINATE set, else sync(2) may take an
indeterminate amount of time to complete.

If the caller wishes to ensure the data for a mapping with the
AS_WRITEBACK_INDETERMINATE flag set has actually been written back to disk,
they should use fsync(2)/fdatasync(2) instead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d8bec3c1bb1f..ad192db17ce4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2659,6 +2659,9 @@ static void wait_sb_inodes(struct super_block *sb)
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
 			continue;
 
+		if (mapping_writeback_indeterminate(mapping))
+			continue;
+
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-- 
2.43.5


