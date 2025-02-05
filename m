Return-Path: <linux-fsdevel+bounces-40939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D89FA29657
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2017A3A879D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E8E1FBEAE;
	Wed,  5 Feb 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrclzxYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008F1DE8AF;
	Wed,  5 Feb 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772909; cv=none; b=qrwO78evMJInZx12WpbQt8NyuO8oUFeMmTDVG8edm//M3OixOIHGanPU9sN2pNlb7mrj4Ikg/TMr886HsXSfqeKMQdTvWS0nDX3kH5bKV/JbUYTbOKuN1zsspZJafOllehvRU7oNShW+lv1Aq5adBY+M8Tk17HvPAAiiAQhirLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772909; c=relaxed/simple;
	bh=QYYjwvMj/ytRQYQe1vphAg9qJdQFkWnYIBKIzbaJYWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfUEEySLHvmW7aKa7FeXITy0VUFJ4QxLMuBuSvkkSP3aGeR42oVeYlyqqZbn3b7uUOly0J2/TigY/fU74vE/PbDnqeokluSnE/SxyRZOJGiTkaXcequO+oslzB1y8oM2rA4uN9fyBZgVS1EsaYhmgaUI2tMWfz/gJfQoZTuKDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrclzxYO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so397502166b.3;
        Wed, 05 Feb 2025 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738772906; x=1739377706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNyQmIYSea4fFxNMDMi3F3YqqMgkH8EXdnd8pj8SHOo=;
        b=YrclzxYO/pZPg8DF9KszBR6r6laWCexDt3OY+RtXeoIIekZL9PLYlVR4h2XMUrIQIa
         fcTF5I5yeaQBiSuAt4T90jewKlvfCQo7kmNaq8JvGeLYiTc5u2/AKm46ZL4xlPGya/fw
         YIb/DgXB2jH+XMuR26/EDyyOQ75OouN+m+TWFxsnjgy6C2WXtTjhUCXOOKivwyis3w5r
         IlrTtB0Cmv+Vt8L/EZiFnF+eYO7uSnvtw402CwMPSOPlZ8YAC+jW5Qwv68QlgS2Bl1uJ
         m3hwJ6zqUcM//sNQnL2G/xlZzaryCDO/ni28t7T+ZpGpeCD+n+F+pFIx3if9BLKjwJdS
         iaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772906; x=1739377706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNyQmIYSea4fFxNMDMi3F3YqqMgkH8EXdnd8pj8SHOo=;
        b=KeeIVaXpTI4RSG7/BT5odE+sdjn3nbINyxi+0cSVeFWppDL13K3CmgxcdUKb1jC4X6
         lpGQbvEkbBNdvX3F6attwwApYkOi4zFVrKUJ39qg1/kPwCOe6ot1PvT8+UzombGdP6JQ
         JPg5A1L/gxX64tqf2AJUTUJr0bsugQXN1ooQam2lEnzVSd3zPTamgqrEQKfwLafJhluk
         1zMObPJ6wFdMNdr3vSiFmOkWIQikZyAJu4vzL99UX3hl7dacxq519+vJ3w6d+AmQ/MXx
         GNC+/cl8TwG3ExVDjC7z3viV0Ig0d+ffGgp5pgZaDWQrMgXm0D2jGmtVyLQfib/wdiAj
         Ig6g==
X-Forwarded-Encrypted: i=1; AJvYcCV0jmJifiM47vw2vvt1jfLaQbTM6mzHFgKGQtRTBdLByr6vZelGlLlcI46MF4OB6QTQwmJ+O/yOYhCf0Q9j@vger.kernel.org, AJvYcCXoI15nEu4Aa4gEDGNXgcJgLZPjxiWX8aGX3paSgUEKRzZwopGO7HdWlaCwjZ0Kuf7pfQROmqkQ76axCYcf@vger.kernel.org
X-Gm-Message-State: AOJu0YzlapGw3Y4fgul8hAr8oVGR/HovtzLq0i7pGILju3J967JzyyIg
	o4BWJI8k8rerZj35Ne2Dc4vcwXcQqWPnGmXZkN+FH7+79IXno5Ex
X-Gm-Gg: ASbGncsDVlYjBtozxC6zxY3EFKBqZGTLt8zuLfNnbcA8ZH5Ob4wUCviNgzD0ahtUisS
	k7G7vAwcmvxlkWMMz3kmHNmLGLkXDJXikKxm4hFJsNt8TdM3PWyV+imWS/7cPYy5kqw+gJtf9Ms
	gWzoHlm5js+KEKtzeH1g+hkhK8bi9QL0hPsfEeebzSefthpjeLzn/46OyPM0hl52B9DVr/HtyqV
	5sgxvHf+OmE1MtvpDnUzyp6E3pXM0OaV1YzG4U97KqG3t84x9RD9byxMoTBtxhl/iUosn+DVQiT
	FlYofj1xw6VkOqxgChUh+pdV19hvrKs=
X-Google-Smtp-Source: AGHT+IHDQkMe1NAtIjoj5eiMKcVRZ+YDCWESIQZjxceh8xd0z3spAhNsOJW4tTN7DtNMkVsbER0zcQ==
X-Received: by 2002:a17:907:7294:b0:aa6:82ea:69d6 with SMTP id a640c23a62f3a-ab75e245bbcmr344039966b.18.1738772905799;
        Wed, 05 Feb 2025 08:28:25 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7656d5d5asm91255966b.48.2025.02.05.08.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 08:28:25 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	tytso@mit.edu
Cc: kees@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Subject: [PATCH] ext4: pass strlen() of the symlink instead of i_size to inode_set_cached_link()
Date: Wed,  5 Feb 2025 17:28:19 +0100
Message-ID: <20250205162819.380864-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call to nd_terminate_link() clamps the size to min(i_size,
sizeof(ei->i_data) - 1), while the subsequent call to
inode_set_cached_link() fails the possible update.

The kernel used to always strlen(), so do it now as well.

Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Per my comments in:
https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com/#t

There is definitely a pre-existing bug in ext4 which the above happens
to run into. I suspect the nd_terminate_link thing will disappear once
that gets sorted out.

In the meantime the appropriate fix for 6.14 is to restore the original
behavior of issuing strlen.

syzbot verified the issue is fixed:
https://lore.kernel.org/linux-hardening/67a381a3.050a0220.50516.0077.GAE@google.com/T/#m340e6b52b9547ac85471a1da5980fe0a67c790ac

 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..30cff983e601 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5010,7 +5010,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			nd_terminate_link(ei->i_data, inode->i_size,
 				sizeof(ei->i_data) - 1);
 			inode_set_cached_link(inode, (char *)ei->i_data,
-					      inode->i_size);
+					      strlen((char *)ei->i_data));
 		} else {
 			inode->i_op = &ext4_symlink_inode_operations;
 		}
-- 
2.43.0


