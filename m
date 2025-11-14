Return-Path: <linux-fsdevel+bounces-68530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975BC5E462
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 492C44FDBFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3A32D428;
	Fri, 14 Nov 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnNqWYSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68032D421
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135597; cv=none; b=nVhfG85gbS9jjpigq+XvP29Kj6tI1F0MU3kfjJciQLomuokVnCzyGik592SyP95HYV7y/WQzInUoaxou60HTW+yKzpk2qERSlR6rTx5gkJAxTub62iFEXQWucT7yWjSbvnGNAvXR/jkvIJTCSC6VnAhFh3LnAdjtIGWdO3epL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135597; c=relaxed/simple;
	bh=8WRpsZt54Mswfz2xCcSPYYNBrsqaK3aNc9iH26/F+kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmjRHYSqgZfsjv5G7HipheVPDorLnbGqj6+LSf/HnOcHvlMz9RoamPP8q8gDPP+ZUtdjUj567z/iKE5FVv3i43Iss5JNdpeULQi2eMeQtjHTmO+Fn79jc+YFrpgvc0nghtb7bo5/EZPg2Fpu5IggNndmPlCC4uG93jAt0KMVsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnNqWYSc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775c4197e1so957935e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763135594; x=1763740394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8KPdQqhauc0N5/k7s1UlzxI59hwfKTHWBoWJzJ2Gqo=;
        b=XnNqWYScJ8m1xV/cI396DbMRPuygqN0j2c4tApMhcwo16wdSHnq9qo5jzwOf2rhWJu
         aGme5SVlqAdkva3aFQHtlkA2MadnFbyOsZwUgGhPY0CoRcCv4OAzARF/1YahueVkRZUK
         5AWSKuoM4oEqgiPbGlag4/c3pY+iSQQYTrjZO4xnikG5s1/DySCEU8oaXMfcg2eYCAQl
         Vlv9ZJXpkJU4cZOkE4IfvyNQL7VS+2Jw7WR4DIAG/ptpTWkp8jxaXjruFH5GWCGJ14mn
         1AeSNWpE3sUrUqw8HqaY36PDsk6H/+OJTrtET+67ryakpLi0bdMNWCUaoTl6zQBAnTO8
         pbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135594; x=1763740394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8KPdQqhauc0N5/k7s1UlzxI59hwfKTHWBoWJzJ2Gqo=;
        b=wTkjvOhojABtctUXcvoGVNKdmdU5UntgLuTJ6x5LnS/EwEOcLmQ/asVV47+GvjQfdz
         bPpisYW6RP6RNaeg2W5C7zIRsd7IAskdpLUWAT9r5OLKRFLfNiVWK3XumBiWY5bYTFS7
         nS4kNhei0bLxiNjd4yObNxDMpz+rpe1ul4lZ21tv5tkTXWp9bnQNUOir2Fc/j/I7fNHp
         9l4Xt+xB/bg0cUTV3niHewQejxZUfzy9wKfDbqYBcH9sR2EIFMlD56uZs63doyGoHQz8
         MW19PZi9AGc25wQW0ExQdNdQ0Su25MrlhNVfzJN+JO8k7S4IXM3YY3NReRdYmddsz7eh
         xn+A==
X-Forwarded-Encrypted: i=1; AJvYcCWtPHw3Hs0A/1RI61tAuLkNIrIJPm97dtEzP0mjJsDW3fNNjgiYifjgTZlw5fLK1nDWwhbfHTF57qLPcQnJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsUKn9gEBPXNyuicthMCqu/3Zo631PvVBRib7Qtg4TB2OIuNh
	KuAPUaruF5oqulEGLVlpCwhce59Sr407rk/Zqm/HfTHbYR6JuasY1971
X-Gm-Gg: ASbGncutas1/ce0Bwub+0nGxl22ggHlT1uNW3mCJVjNEDE4xmM/XMLpruGduJEO7IB1
	U2DgQgxpF1pXy4vxGMRNiLsiX8pQyxxRgjqsBAxZqNgDqbI2YShZ1zm/whqvyrK7DHn50GeuR53
	EVqdKmbIy1Hk7GcJz8vztoME3vxAr5QoO0iccHHTMO8YzK66OvITV79zArSOw9AV4NWeMjCxYNT
	NiuR/IpbhlTjsKfyuyWNx5kgesTJccR52UjQ8/fmhQ4fvbUfma037bPb4zw/h29v8Dy3w9uK9KH
	uYBfsHEgypo2feY96y1ZWCsvsW9uYuu2TSS2haBG7I2rEU4COndGE4b8fDRpjW16mgcryiwu+Oy
	425ZKk4ee31a/OOyE/uByTXtUB9u8kJpBWW+dC3yDKe8FBKG7pHBzp8qEW1j5ZCNLlsjx9w00V1
	02d6n5lA==
X-Google-Smtp-Source: AGHT+IGT1RDAkilt8ulv0yMxWgpeZ6pkOqR1nVxwseskZoLEsxMf89IT/uT00v+JdAbcSlztK4/FBw==
X-Received: by 2002:a05:600c:4e8a:b0:477:555b:3411 with SMTP id 5b1f17b1804b1-477902367d2mr16058075e9.1.1763135594359;
        Fri, 14 Nov 2025 07:53:14 -0800 (PST)
Received: from bhk ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47795751d08sm8972205e9.7.2025.11.14.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:53:13 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] fs/super: fix memory leak of s_fs_info on setup_bdev_super failure
Date: Fri, 14 Nov 2025 17:52:27 +0100
Message-ID: <20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failure in setup_bdev_super() triggers an error path where
fc->s_fs_info ownership has already been transferred to the superblock via
sget_fc() call in get_tree_bdev_flags() and calling put_fs_context() in
do_new_mount() to free the s_fs_info for the specific filesystem gets
passed in a NULL pointer.

Pass back the ownership of the s_fs_info pointer to the filesystem context
once the error path has been triggered to be cleaned up gracefully in
put_fs_context().

Fixes: cb50b348c71f ("convenience helpers: vfs_get_super() and sget_fc()")
Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Note:This patch might need some more testing as I only did run selftests 
with no regression, check dmesg output for no regression, run reproducer 
with no bug.

fs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..8fadf97fcc42 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1690,6 +1690,11 @@ int get_tree_bdev_flags(struct fs_context *fc,
 		if (!error)
 			error = fill_super(s, fc);
 		if (error) {
+			/*
+			 * return s_fs_info ownership to fc to be cleaned up by put_fs_context()
+			 */
+			fc->s_fs_info = s->s_fs_info;
+			s->s_fs_info = NULL;
 			deactivate_locked_super(s);
 			return error;
 		}
-- 
2.51.2


