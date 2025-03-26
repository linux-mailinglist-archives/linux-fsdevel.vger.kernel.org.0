Return-Path: <linux-fsdevel+bounces-45069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B4A7152B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D5169D88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B31D07BA;
	Wed, 26 Mar 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="ybCwoLqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2022F01
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986760; cv=none; b=LKPtV4s6CEq8mD4yXjQRBXabZ1QB/5zKy3x7HWuNtIaof8KLw3Dl/A859bnVPkqIQOGUsOO3+hNKVE4ygnNztQZ5Kss8uTbEphA2sy7QywIFO8XkJkUq0xkZdmjOVeLz6OQBN7EvAzeLjV1Ni3gms1mhzW6cvD0dhTsyW/53Noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986760; c=relaxed/simple;
	bh=uN1vr/Fb0iYszlHwQ7A2qkr2YXVD6KSqZVcwTPfuI+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkDSm2g7VHCxLkqmawIOouK4miSTB7Ca/aa5OdC41ZC5dPZgIkLY4HbbPtlp5LjVPkGi/lCD+sXsp4WqRfH5+0IauOATQVLulxAtWTRLaeYEyIaXdKJycgJky4Gz7RuMTr88yL+K3PL+5ci2ggHkQ0CjWHqbGtGPOI1ZKBMx9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=ybCwoLqf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so39645075e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1742986757; x=1743591557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkYrvJH8MLboZJYN3SET+tKv3pjaS9s/Q33mAFg+/Ks=;
        b=ybCwoLqfgz9r8ysTBw7NmfiRIHD5TC4BJGuoq3IVFmNOnEY012oZArULW5cake8jFK
         po4G+HZSz3Mh/74Y2FPDQ1NYVTOqvbm2ZU2IhnUhdRO4AlDiXtaV2pJSjGZsi2OfTEX+
         Dm0imzxUO78R7nE89UEivoMYLQCsbicet8CMlts2+f5ri4/76yngat11BkqPp5uwnmEy
         BlnFZvrS6eGOwqgi0LQiT+YfIoeApuQYOV7pOTk9nOmFOraSR4cxVk0uOShRXqyWLbTr
         H1SqcDmZcKrCVt45Aiv/1C6FeWZc5vTqghmLaGi0lCrdffev1H2wWgNhYn4ZXfXcrRKe
         v/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742986757; x=1743591557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkYrvJH8MLboZJYN3SET+tKv3pjaS9s/Q33mAFg+/Ks=;
        b=o0bfTfg6UYaGb/07z93F7kluoC5kqDDRpTtKQQApGyxq3WczN3U6DjAw6g5eQo//mg
         wzKJs/0LoE+FCnCxHYX7Q6tTtoGd1wwMVlvrdP2m/BjoftO+w/iEKcL6b4gtoNOhF+0v
         DDS7p8KjVmISB/bizwq5i1s53vXOT4Nc+G3XiOjvcm/OcBqWCEo1acSfbiy3QHCE2wKQ
         WxwGqAoqlnuEXfNFaCDSFRSRbunizdXXpV6YbDz+Djca+bNIbCBcn4M4tEaQ15dxoOsK
         tBC6TKf0lhzTtlgsmUXRgvWLApv3ByKljJ2YQ+GFuhiLDld+wasIUqiHaXZFL10Wmkn8
         LdPw==
X-Forwarded-Encrypted: i=1; AJvYcCXCSbOscdyu+oFeu/zTxFHFgZqI95GVu73eNSQewE/WrN/g/ZomhCyw9X0LJMXdh795b/iFjSqXZti+gEfr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp4534c0AYd2UmbOMTgYq2hFW/umi8En4Ea4sm18UU7IKZs4NQ
	j5+s96hBB8IC034iSx8xbX+yu8pQNIWdkoPuRwStbS72V0rUiZCW/hprYueCwak=
X-Gm-Gg: ASbGncvYpmqYyjG7DHxZzsxCYVTw+hP8Br31zagktHMn7IKQB/g6Qmc1yDbczuYmugA
	2RdSp/SR82Eide879/DSakbO7ZIXTR+a3mksQJMVhYfjG2G/w9laxAhFsn0OEwQ0+11WxqC5SQg
	vm6AOmwtvURM7b4h4avXrhZCYUJ4vq2E/OQ4WwFwMvtHT9ACFKaquESp/jUGe4KhN51fpREK1iC
	P29Cj/I3Cxvbz+RI1UnRsbHQO5AejOVLpXDjMqAkdA5t9tyawUWlzFwz6HPL1PqkYPSbhZjeP/c
	j0W0YlGH1vdaUOTmQ9fpVGZ945L1+iuA1i3nd529soK2jLgi
X-Google-Smtp-Source: AGHT+IGsynMjLeM6MvbAOiFyQWhOSUi+GKcc6H4q6k5SLyMO29JdoL407k9GE1BOdU9b67T9vRhDlw==
X-Received: by 2002:a5d:6d86:0:b0:38d:d701:419c with SMTP id ffacd0b85a97d-3997f92da9amr21706605f8f.41.1742986757289;
        Wed, 26 Mar 2025 03:59:17 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:28e0:840::179:137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f99540bsm16374900f8f.2.2025.03.26.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:59:16 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: willy@infradead.org
Cc: adilger.kernel@dilger.ca,
	akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	luka.2016.cs@gmail.com,
	tytso@mit.edu,
	Barry Song <baohua@kernel.org>,
	kernel-team@cloudflare.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux kernel v6.13-rc5
Date: Wed, 26 Mar 2025 10:59:14 +0000
Message-Id: <20250326105914.3803197-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z8kvDz70Wjh5By7c@casper.infradead.org>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Mar 06, 2025 at 05:13:51 +0000, Matthew wrote:
> This is the exact same problem I just analysed for you.  Except this
> time it's ext4 rather than FAT.
>
> https://lore.kernel.org/linux-mm/Z8kuWyqj8cS-stKA@casper.infradead.org/
> for the benefit of the ext4 people who're just finding out about this.

Hi there,

I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.

Does overlayfs need some kind of background inode reclaim support?

  Call Trace:
   <TASK>
   __alloc_pages_noprof+0x31c/0x330
   alloc_pages_mpol_noprof+0xe3/0x1d0
   folio_alloc_noprof+0x5b/0xa0
   __filemap_get_folio+0x1f3/0x380
   __getblk_slow+0xa3/0x1e0
   __ext4_get_inode_loc+0x121/0x4b0
   ext4_get_inode_loc+0x40/0xa0
   ext4_reserve_inode_write+0x39/0xc0
   __ext4_mark_inode_dirty+0x5b/0x220
   ext4_evict_inode+0x26d/0x690
   evict+0x112/0x2a0
   __dentry_kill+0x71/0x180
   dput+0xeb/0x1b0
   ovl_stack_put+0x2e/0x50 [overlay]
   ovl_destroy_inode+0x3a/0x60 [overlay]
   destroy_inode+0x3b/0x70
   __dentry_kill+0x71/0x180
   shrink_dentry_list+0x6b/0xe0
   prune_dcache_sb+0x56/0x80
   super_cache_scan+0x12c/0x1e0
   do_shrink_slab+0x13b/0x350
   shrink_slab+0x278/0x3a0
   shrink_node+0x328/0x880
   balance_pgdat+0x36d/0x740
   kswapd+0x1f0/0x380
   kthread+0xd2/0x100
   ret_from_fork+0x34/0x50
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Thanks,
Matt

