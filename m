Return-Path: <linux-fsdevel+bounces-44823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E1A6CE2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 08:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14A83AB650
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08920126A;
	Sun, 23 Mar 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxgnBdTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8803FD1;
	Sun, 23 Mar 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742713348; cv=none; b=Rr/j1ZGR1d1QVA1tVABNTG6gTD3Mhhb9QzZWEQRbKGi4xmJfIlIhzPvvc4lNdGF5/l9naNIBDEaEpY7J3eMsrOvOUQJDYMYaRhiu8KoCkJWuHT3VH/ZNp7tD9/cCTCdZm36gKD8sK5lUY3yIDq8aBXAXZgVUcdO48JaRMeUgCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742713348; c=relaxed/simple;
	bh=eRj7ZyYdHApUuqrgnDlrZoak4fEqCjIc9LNCmw5Ib8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdgD6e0EZ0xQ0fTyjeDP0z/QhncUN2A5j/A/RcQX7uT+lTDd+FhQcr3Oi0wb5HI9S3qZQjzjWMC88kotbnRrw9HUa+wmVmsCoaRxTC5M8Df2TchUPA6U/SysSW/axd3NWDJC2N9i1WzDxM4y1+P4CROxIc4LD128kOLekfXlR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxgnBdTA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-227b828de00so632335ad.1;
        Sun, 23 Mar 2025 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742713346; x=1743318146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmGMB0N7I4U2fl8kJydMFtAwhymEfbcfkap4BCaT23g=;
        b=fxgnBdTA9jhHtmaKmae9WBEhq/cN8KQJJeYkEJI2stuu8+DWtV0sSkLgOFlKZGVZ8W
         BF+A2ARilocDdCAtl87a7kd6UDqyKjcWoPYBqVM7O35Ovfk4O7u1Kel4iGU8sD0wJxRX
         VdAGKEOAUl/SItqHLK/wyrqRI6SCY5dYgRhV3yewfiGyWpYrBoGG8s1T/IIDyLsFUeqD
         xmuSldfL4qMs0nWVLdLvV3H/EP/C/UERSN+6Gh+fFF2ZkRTxnHj2aLknoa0T6lDuCMLP
         d3wGw6DCqngtGzCMwmpTC/YZFqFliMKXpfzRe0tKGUMWHftfcOGI4/YJEg6aWOjyqzbN
         5fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742713346; x=1743318146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmGMB0N7I4U2fl8kJydMFtAwhymEfbcfkap4BCaT23g=;
        b=p0aX3vEtshE07ukWvQNAd7Gr240oBuZBTECG3qFL3NtheOLwnfchuqGL61jEvprUre
         zDo7zihW8M8kuyCNSbF74rvaRCmqkeEdq1yzCQPH/Y99IsnGgoeb+EaxOKqs9Th8Hst1
         yBdatsBG8QxO3puuN/z0mTqNNtrGfioV/j5e0L2TTp7jmszWt733Oh1jyKa+CKO1bxNp
         U0v3yjsWNE40owQdP1JPuJKoC/WkMDI7tihZ+bsBOSmdoSPy5i0Pedm+Nn/w05XzKslo
         CV8O263nEkYl7YqFtwiJrB8PvPPr+EuRFlrvvAWfRFccvcAiGnlIEVyQeGRamcaM/THF
         eaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEPu/F9Ki9g/x4janxIgsViAu3rhLEA3BSjeW7jKhMEZq8S7zZz14mRS4FtNEc9CrE/yk4PPeq1a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1MZHfd6XMYaf0zgohVq1DNjCBLAJY30FgEwPe3rmyh0j4xWc
	IvbjQG7okcD11JBOQRRkE6T+Vk0PjVtlNPzm+CTgX0FRO2hIxtlljEPD2g==
X-Gm-Gg: ASbGncu5jw7pb40QCQaCMTqsAWfXmyjD99CplJVFiKBx1gfsZXy5P+3PGjxC5XqXw89
	X4ysuznKbAWjIunXtO+NPm7oKdoJjfpCqaMZQHvZ0z3SZATOJvWM5Ess+aZ/2U59REjEP6tRSmN
	/QfXT/byIl62qT6l4YlvvcorI2QhkBN6DNBpUw6oNW/WmC9A7Ac7OLCoYBPY9HHJKMijadbyyOl
	J9q7XPcbIqIrbka14L5JGmf6Ed8pmY6k5gwpGN2C/LfQIPwREoENvrP56/GUPTCrJH6w9tYNRTn
	Q/EXSL52zrcr/gwHVCvnesaFGwr+XURewbJSkq1B
X-Google-Smtp-Source: AGHT+IHbrkQTzTlMQeljmfodJMP/bmSBAdizDNLYHsfvhoZXbxbNx9TuzeObX9t+pIjiyBT/DFR1tg==
X-Received: by 2002:a17:902:e888:b0:223:35cb:e421 with SMTP id d9443c01a7336-22780e258cemr130352045ad.49.1742713345661;
        Sun, 23 Mar 2025 00:02:25 -0700 (PDT)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da89csm46058445ad.193.2025.03.23.00.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 00:02:25 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 0/1] EXT4 support of multi-fsblock atomic write with bigalloc
Date: Sun, 23 Mar 2025 12:32:17 +0530
Message-ID: <cover.1742699765.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC patch before LSFMM to preview the change of how multi-fsblock atomic write
support with bigalloc look like. There is a scope of improvement in the
implementation, however this shows the general idea of the design. More details
are provided in the actual patch. There are still todos and more testing is
needed. But with iomap limitation of single fsblock atomic write now lifted,
the patch has definitely started to look better.

This is based out of vfs.all tree [1] for 6.15, which now has the necessary
iomap changes required for the bigalloc support in ext4.

TODOs:
1. Add better testcases to test atomic write support with bigalloc.
2. Discuss the approach of keeping the jbd2 txn open while zeroing the short
   underlying unwritten extents or short holes to create a single mapped type
   extent mapping. This anyway should be a non-perfomance critical path.
3. We use ext4_map_blocks() in loop instead of modifying the block allocator.
   Again since it's non-performance sensitive path, so hopefully it should ok?
   Because otherwise one can argue why take and release
   EXT4_I(inode)->i_data_sem multiple times. We won't take & release any group
   lock for this, since we know that with bigalloc the cluster is anyway
   available to us.
4. Once when we start supporting file/inode marked with atomic writes attribute,
   maybe we can add some optimizations like zero out the entire underlying
   cluster when someone forcefully wants to fzero or fpunch an underlying disk
   block, to keep the mapped extent intact.
5. Stress test of this is still pending through fsx and xfstests.

Reviews are appreciated.

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.all&id=4f76518956c037517a4e4b120186075d3afb8266

Ritesh Harjani (IBM) (1):
  ext4: Add atomic write support for bigalloc

 fs/ext4/inode.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/super.c |  8 +++--
 2 files changed, 93 insertions(+), 5 deletions(-)

--
2.48.1


