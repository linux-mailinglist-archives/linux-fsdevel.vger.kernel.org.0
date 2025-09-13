Return-Path: <linux-fsdevel+bounces-61182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 678E6B55CE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB841C87164
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD19B15E5D4;
	Sat, 13 Sep 2025 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a67LsgU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF319AD8B
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725777; cv=none; b=tKwDM5MUx0eFSx/1PrFS50YkMnLbZ3iStgVVaTHv2YdUmg8DkG77luIFKFkbowKva1BBCtRPWuTp2fHtXSo293tdjBmLUvSQNd8Cbq8UrCA147YFuqYGBApdBNvA7/VBsxJqB6auAYa+FpN+5PtaqK818+P7sJfhV97CRxyIJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725777; c=relaxed/simple;
	bh=OB8rvKJ/i9Py5pg6KTYPvKorTOVHkmUl23UIALP6A5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3IkuMcnIeGC81+XI0L3eYRWmSWrdtQbdlUKa0b5RCYPM5BHKdko85vatgT6LacGJOkv4Wr/8W5V1+Z6d5cFdhGWV2TXR4CdJNhG7E1J9rvz7Mefr64rQh30A5ht/gCqQC2su/9839mkDeSML3LMWuWT/lQm6IO1/ShaCtPQqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a67LsgU+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07ba1c3df4so345546766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725772; x=1758330572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=;
        b=a67LsgU+PqFcCyQYOwGfpgZYrvZLskJpWHMhCd23XBdT6GhY2QVzopMLEcTiTwcU8n
         aRXxksx8QL94IAJD0uxOztTCPgTj1BtWsyM/kG+nLV+TpshnC7uUxRKpC9wDTpLGZq94
         ZOqsUlHJQkT2klUn9663/rY9OOFnLqMxlMyaQUlsL96ITKc6UC1tGx3tp/iTsNpX/Gl0
         4qJb49YJJmcWjmVUIQnbNHgh0LOmGNGWxeSBQEvg4fPR2zxEy8hvhLyji2gZG7GN034z
         Lx6bYf49mEL+cge+EW32SYuLX3/YuiiyNTqmZ1EKoxUEqsDHaSGO3qHPWNhLDjtiY01k
         zmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725772; x=1758330572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=;
        b=SIV9jgTY3LmL160VW2epY0e+BzH+PTi43r6aWeJe6KKnumwS/mtocfU8Prkb+8nFQW
         WuMwPlRF2IKDh6ie3SHrBv2WQJ60nXfeathe8kqY486iZIumDm4piCgVtiW+NeNjcb0b
         9fcNtpEyjjXOYIv91aoSEZ10xjFcp+0s1EhrLyElTXeD98UrQ4+mmaMxDjXXpUlrBwWV
         9tqb0g5w2Idsfo1A5ZJbePKQGE6IyjBjNt2Fr4LNVAuKA8XhppFlryBbVKrwy057yiW0
         kwpF7dzk+JRc3NnT77SsED476POqcLG/lnkOa2EtmJosIYWJChbUUFp2ZJT/H2Iw1wNN
         6GGA==
X-Gm-Message-State: AOJu0YxJT7h5Ns3WtPrfCmA4fQbUQ4LMMk4MQhCcBbB/pHnNszXF3Og4
	DAk6UKNT4EbDjecVTc8H+pd0FImPO+iJBXfSau6FuBWWX3uX1+X/aulA65L6zVwc
X-Gm-Gg: ASbGncvmiNhOcUHO5W9biWoRXvadRtNV85qEdrDWKR4QDSFuL9DjOe7yjeIH5iQwoEU
	m7s6c0dBvPT3rlTzEEwnHn+nFeXIdD0dc1t0rIW8NxaY5UseY0f+ZX5nmtFWzFlkF5F0OY1FWDJ
	pOZcXYcQgNASnDPqmPPcpYH8p5YOBG83xsbO9N0mZpcrbPAAPnwuqXyD814MiezARMOrl8T+z8D
	ttzi9HFvTdKzib6RmhXRnXR6ulS50Z1lZnLVL+ceYtM33vP09FGzSVA8LZpZa0gQvR1GnDL5ZPO
	4iFJszrNYf1Rkp5NJ/GYRBYx7SBT3l+uuNaXyhA0gq1ryH82TOGmBF0MJ6jGSAKgp/W7mBQQ+z5
	15nhcMiRlo0eqOWA1INc=
X-Google-Smtp-Source: AGHT+IHrHcZIQpP/M06nOcq3Snl8FXkxUTmgmKKbhKMXWfrO9iWe4P5Ilwjf7ocqvFrLGTk9+k818w==
X-Received: by 2002:a17:907:3d0c:b0:b04:250d:ee7 with SMTP id a640c23a62f3a-b07c37dca1emr487688066b.31.1757725771595;
        Fri, 12 Sep 2025 18:09:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07da7a8918sm104574066b.56.2025.09.12.18.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:09:31 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 27/62] init: alpha: remove "extern unsigned long initrd_start, initrd_end"
Date: Sat, 13 Sep 2025 00:38:06 +0000
Message-ID: <20250913003842.41944-28-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These variables already declared in <linux/initrd.h>, which is
included

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/alpha/kernel/core_irongate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 05dc4c1b9074..3411564144ae 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -225,8 +225,6 @@ albacore_init_arch(void)
 	alpha_mv.min_mem_address = pci_mem;
 	if (memtop > pci_mem) {
 #ifdef CONFIG_BLK_DEV_INITRD
-		extern unsigned long initrd_start, initrd_end;
-
 		/* Move the initrd out of the way. */
 		if (initrd_end && __pa(initrd_end) > pci_mem) {
 			unsigned long size;
-- 
2.47.2


