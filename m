Return-Path: <linux-fsdevel+bounces-41540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B2A31669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9ED3A173C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98DC1FAC49;
	Tue, 11 Feb 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkw/yjvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE4265603;
	Tue, 11 Feb 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304456; cv=none; b=cKC4xBBuswXQXuodF6d9RpOAFjku/ehNA7+g2YCmiylSaWorABqOX7AfEUC5DjTO2gTh0JpDOE9//sENQKpwk2EkVioq6UBeTuu0ruWMPEZgoZzr6OPNLjna8ZS6byBHfxrDXIKRNvkMKN48Yd97DW5ZhVL8mEMQMH7LD584gKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304456; c=relaxed/simple;
	bh=3DD4EKvKVSd8aFRggmsk4mG5M75X0oz1cvV9FUbjaC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hlmFYwL9Al/mmPO98+D1HY/5w5wpZBZUTh/k84XzNpGUi2SW4GlThkJq4BPwtYhMjHaeQiq5zLM6g8LnGs22/aSSTUpB5aanZg1A4iQ4wEGp2fkGLg7398En7dPlxHdIooENXvUr4iar+aO+BahI0BVYcI6KWYfdQtv7dYfWkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkw/yjvH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43690d4605dso41455995e9.0;
        Tue, 11 Feb 2025 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739304453; x=1739909253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEyL3Ra1dZj32nQnln1nD3gAOn0lhzcqC8+EuVYZvk4=;
        b=dkw/yjvHbAeuXI9wAXT2i2k1IxEx+5w+/BIS1pMTpV4YIK3lafjeYDHvRxSa+EmuXt
         iotBzK885MFA5nik0zJqnbseeAiTQkjh1z/UvcwPje84uU61wFQHOvJAoj7KT4dZ++PS
         9xepgc4ji7422FeCQyyGZKkjv642qpxmn2EboFojPuxAP+nPzeabY7Pnp5vFeyKr/YOL
         5rGZlFEBIYvZN6kRHm9kMhiRWa2rjbYZPkXF3oLwgyviDSxfmT6jedqzwPafoldF8Hq/
         4V92ob9BQYsg1dVFFQ4FH3h+EHg75TKxYDs1FdaL15pFhfTESKACdxO5JqZfi6nNhiG0
         swUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304453; x=1739909253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEyL3Ra1dZj32nQnln1nD3gAOn0lhzcqC8+EuVYZvk4=;
        b=QBiW1pxjKs/carNN78rvwLjtQFgUD5d+y86zdfv29dSUYI480tdcXLTDxjokLv9pcX
         NAejV3DBoRObHA2yDMXopP1L6ssH/qQYf//ltJMYyIXTIVbbJL6R7+/CVY3ecRirLpa0
         veZSWBo6pyH8NvkYMutjt8iW2lX6mg8y2q63Eh2qNTGm0TkX3U8mqQJ2Vlbl4wPzjKwL
         Jc+HTRqF4fKMs8kagMI79hrpcNNEG/u98qPm/nAm0Plyx3WpE8IP1X0b/z0h9PJ3bQ48
         M2glRs4Rk/NeNBLHIMop60UZi+s3tYsViCJV0Uh5yQO/I2AiYDsR96t4HW6wlbk3l6d7
         ZkJw==
X-Forwarded-Encrypted: i=1; AJvYcCWmmj9d0crrMCpJFB03MhGrJvcTBjyk/XUtD8Q5GwFYYEKF126+/6i1I9qfQ/1h6Mz+p5ZnJCWUDJT4ifM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywBCwFA18JEzi1i2le7PiYwmfbVIUOyauPx8vm8YZgJHfRKaq
	2PhkNKkShZI1Pv+8D/pjPG3vYTmUEytf7EeDCPjUSEy35qz/BkMp
X-Gm-Gg: ASbGnctvjL57HDS7Ymukd7JmgDfFi0uiRONvNx7btNFT1yXOopiPM0hqRS29RFQiGXO
	cf99kNp98/6EhOwU2UUdaZZ5ItFkBKRTwSZlYW9VQSoo6flepFHLsLQJp7U7mrqheUhyMdBbesQ
	kKvg+yMq4LaDOKNrcVmFUv5ZE7dZXlJ5yiH7xph2u2AtaJdOjUWr7xypLMY7U9waYzoZeKIr/Cd
	jnIHqZL/t4x0U2nxVtZsDGyq3J9I7/jsk3Z8z3iVYq6pkiBoGuFS60jAlp96htXOTCYiTs5whMr
	5Hr8Mso6POYXQwV8FMpTAKZbxpY2zA==
X-Google-Smtp-Source: AGHT+IFReHQyspvddJVe6BAdIbiNMz3aJXBLAbR5Wy0ZwgSfNw5RzJGOdLB0dflO4lE9nI+KgPTYNg==
X-Received: by 2002:a05:600c:3b11:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-43958176305mr6382055e9.12.1739304452436;
        Tue, 11 Feb 2025 12:07:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:998a:facd:f681:8fdc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43947a5be1bsm60051025e9.8.2025.02.11.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:07:31 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
Subject: [PATCH] isofs: fix KMSAN uninit-value bug in do_isofs_readdir()
Date: Tue, 11 Feb 2025 19:59:00 +0000
Message-Id: <20250211195900.42406-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_isofs_readdir() when assigning the variable 
"struct iso_directory_record *de" the b_data field of the buffer_head 
is accessed and an offset is added to it, the size of b_data is 2048 
and the offset size is 2047, meaning 
"de = (struct iso_directory_record *) (bh->b_data + offset);" 
yields the final byte of the 2048 sized b_data block.

The first byte of the directory record (de_len) is then read and 
found to be 31, meaning the directory record size is 31 bytes long. 
The directory record is defined by the structure:

	struct iso_directory_record {
		__u8 length;                     // 1 byte 
		__u8 ext_attr_length;            // 1 byte 
		__u8 extent[8];                  // 8 bytes 
		__u8 size[8];                    // 8 bytes 
		__u8 date[7];                    // 7 bytes 
		__u8 flags;                      // 1 byte 
		__u8 file_unit_size;             // 1 byte 
		__u8 interleave;                 // 1 byte 
		__u8 volume_sequence_number[4];  // 4 bytes
		__u8 name_len;                   // 1 byte
		char name[];                     // variable size
	} __attribute__((packed));

The fixed portion of this structure occupies 33 bytes. Therefore, a 
valid directory record must be at least 33 bytes long 
(even without considering the variable-length name field). 
Since de_len is only 31, it is insufficient to contain
the complete fixed header. 

The code later hits the following sanity check that 
compares de_len against the sum of de->name_len and 
sizeof(struct iso_directory_record):

	if (de_len < de->name_len[0] + sizeof(struct iso_directory_record)) {
		...
	}

Since the fixed portion of the structure is 
33 bytes (up to and including name_len member), 
a valid record should have de_len of at least 33 bytes; 
here, however, de_len is too short, and the field de->name_len 
(located at offset 32) is accessed even though it lies beyond 
the available 31 bytes. 

This access on the corrupted isofs data triggers a KASAN uninitialized 
memory warning. The fix would be to first verify that de_len is at least 
sizeof(struct iso_directory_record) before accessing any 
fields like de->name_len.

Reported-by: syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=812641c6c3d7586a1613
Fixes: 2deb1acc653c ("isofs: fix access to unallocated memory when reading corrupted filesystem")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 fs/isofs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index eb2f8273e6f1..366ac8b95330 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -147,7 +147,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 			de = tmpde;
 		}
 		/* Basic sanity check, whether name doesn't exceed dir entry */
-		if (de_len < de->name_len[0] +
+		if (de_len < sizeof(struct iso_directory_record) ||
+		    de_len < de->name_len[0] +
 					sizeof(struct iso_directory_record)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %lu\n", block,
-- 
2.39.5


