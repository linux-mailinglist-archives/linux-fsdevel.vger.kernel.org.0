Return-Path: <linux-fsdevel+bounces-67399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF4C3E33E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 03:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C43188A2A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 02:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23102219A86;
	Fri,  7 Nov 2025 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OYp4ubuT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BA7494
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481221; cv=none; b=bYUuQ5SllG4O8bWhTGrivbXcmHqHTFFJcyUaLKjgIlf573ckfPH3kvqDWqubWkVMvW7F5rupb3YdOXK5DD89x6VRFeXtQSgSJSX10tKChsG/wuWRZUi81yXkDo/0zclbsIzw3kWJGJ11jO1zMwKBtNqRkrWRAeLwsAXk0qw+1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481221; c=relaxed/simple;
	bh=5/T0SIm0UdNO/IdzRZZKEiu//zm3DFK1QFan+BlZfc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lD+SxPMoMoY+Qpr2r3FKkzhy6jaFeyu99c/fqAMP67Hn/n3fqRwBLqtQxEjszud5G+1LIWko5626aC8r/h2vpC9Sm1I2Hl0Uf0Wa6047y/PHSD1yjEgQP2TIA4tx23NxjDF2hYUsYUwHRz0Cqz23boO0VzyhweYGu9jTMtgUHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OYp4ubuT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29524abfba3so2630175ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 18:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762481219; x=1763086019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=;
        b=OYp4ubuT3gFc60iNpOyqfZR5wKv5fjTWfjquldjj3yOmqwOqHhb+gL5tBGy1h6g19a
         mE9JKBplmSkVKkEn3gsbnssVeL3P2OnVme1LfIGDUWl5uwketcnYSSPYd40ovl+AAtli
         qK20UzYrZWuzXHfZvM8pZD6J1OS8frr4sUeuoh+AKkoH53mA0fbtfwSUkKSjloevMJ8H
         BKbPC7Ggm5NBb6iCHtS/VLhpM2bxPrrfQKV92pW54zrGq7nwYO5NHJQ/ZCweBAVuV4JQ
         X8QjrT3Jou7mvj0bxG/giBOc833ri2zbOH18PTI/qb3Ld1KMUxR3ET8eZjBe147luRUB
         lIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762481219; x=1763086019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=;
        b=Oj1gTjs4yfu4CieWG7W1CC+gwOk4k1x/tbkzGEmZt3LdOukN/cbWNh1B1BmExy1VrD
         C5m6XpRjUhDPlmda9t7uNfZ1AuaBr8rShncsnIOAOJDMeihASw48+P5Bvf7AXa/j157J
         HAYrqPGZbMtLiZrWwmN1UGTJ4JLKFIVrhNefBcbWcu0wKKPKzNbwlVVTmd4jOwBnyOwR
         aR1sM0Py4WLv9sxjQoRLlob+ROjIfHGKJUpA8DNn3cuvpcY0x6jjtbDmoMGth9StrHra
         T5v/RDLChrDag2GfupJPwet97pI0JOCTXwSERC8JmSQ3aNqscRqsqlHTUMU/K33rRtR8
         eivA==
X-Forwarded-Encrypted: i=1; AJvYcCU/cruySRuewy3QWSaoLo4esRfOH4wwgrzgM1BwhslAMSsO5f+6KAx9EmaHJuaZ06xs9U1xek1WrY9XPvfg@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAuq8iaSZCOX049XFkqP/eicHio+L3BIvvomctOstRFB3MSRV
	ovDKnwpn1vzE9Ej11tVZWU8JewvBuIbjzFQhwGDkbOL4jQoZ61X/JeSv6pyVjoX+MBo/iyyndAH
	nhvjLzr3XYQ==
X-Gm-Gg: ASbGncuOUBqDeH+s5W+AgnJkXiGWXA+CVPiUvOl9rmCjXxQ5b+t606WyE6kaMGL6MBA
	+6Ww8WglhrfV+VnPFTTLPZ7oqk15FNROQQv3F4IwFRtIpDXhMMGkeCjFHudt9c/WhMm0Ou521/7
	zH+Rfg/Kl1YYHgPn1G+SdErPTaO0HuNhz5dBCQhiaX846L6YQjNFSYoVIv1369LDlY+M1g2M5R6
	GQTJm98MPdI3WBRBoOKa3q06HYQdLhVd/l/Bn4/XkCePWWEIBja3RfkitPh8YVFusSvborcsp2e
	XnZW771c8py6ROVAEM64E5jXZW203y7G0hV5ldcqUPoY/pxL0dcaaI+phbB3w/LBbpyNcwz3/Ly
	BH3kCRUWiyw7/A6aVnxIkkV8SlOsEKCGwyTWY6YSr7nOlaq+4ILPy6JzkgMiMphGfiOsKTdRTXk
	tH4i/VU5AV9E/zMwee
X-Google-Smtp-Source: AGHT+IEQ1r7AsblEW15F6NrWnCgQgZkngBPtkNTOIEI5NyInjWIPCo6YMVNtFNrYGdMqGrYdOjvVJw==
X-Received: by 2002:a17:903:1ca:b0:296:1beb:6776 with SMTP id d9443c01a7336-297c04aa6abmr21929025ad.58.1762481218563;
        Thu, 06 Nov 2025 18:06:58 -0800 (PST)
Received: from localhost.localdomain ([2408:8740:c4ff:1::4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm43129885ad.3.2025.11.06.18.06.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Nov 2025 18:06:58 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2 0/2] block: enable per-cpu bio cache by default
Date: Fri,  7 Nov 2025 10:05:55 +0800
Message-Id: <20251107020557.10097-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, per-cpu bio cache was only used in the io_uring + raw block
device, filesystem also can use this to improve performance.
After discussion in [1], we think it's better to enable per-cpu bio cache
by default.

v2:
enable per-cpu bio cache for passthru IO by default.

v1:
https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O3hjexFNb_tM+kEZA@mail.gmail.com/

[1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com/



Fengnan Chang (2):
  block: use bio_alloc_bioset for passthru IO by default
  block: enable per-cpu bio cache by default

 block/bio.c               | 26 ++++++------
 block/blk-map.c           | 89 +++++++++++++++------------------------
 block/fops.c              |  4 --
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/fs.h        |  3 --
 io_uring/rw.c             |  1 -
 6 files changed, 48 insertions(+), 77 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.39.5 (Apple Git-154)


