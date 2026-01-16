Return-Path: <linux-fsdevel+bounces-74238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E365D3867B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 21:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4937C3013E8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1F34D4CB;
	Fri, 16 Jan 2026 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1vYHyXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26593385B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593875; cv=none; b=MWNGUnGcfLRgkDXUEgcjZaQkkoLOwbQ6DUpRfmev7gFU0PjDlm1x9RrsBvUkIi20QB9eJuuMkBsuDEPfWbK/SoR0MfseMzQsiOHP58XWDqYH0fu498zDZP/U8cRVvo3pLA2WEETaYcWb1/vXud1tJBGKRAgzodJldUNFO9NrcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593875; c=relaxed/simple;
	bh=ZrTxcbGiWqeGIHyF7XzURPZ7bCFWL7GMgq14iv/Pkqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyF+Hm2MNTab04VqWKipsYAer3ofL0tVCUD+dVoBI0lMtgfEgxEQPsVj11WizNlBB0v3unpwkBFMWhZ3XJX0oQEuTgY9+nrLwLFxdRScBxBOXlBGiFdQs2AZtg1gwD2f0yQHQBLmT+5zzkEVj+7Jq12vqJw/KgfF9np0MzB05sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1vYHyXF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so1553580a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768593873; x=1769198673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TqMKcPFJgNzNvwRBT4mtPpKjjhfwSlAMvBz3HHfcl0g=;
        b=h1vYHyXFBhp8rCfc7LZRfhfp7a410CIUPnKlw36AQjgK+n9QnhSJQa4PBKUpdKiAsF
         oVmWrcnDwBE4bUPT07di/VSRH+4uFKkTFCZc6ktC+a599PSN4JMDxgO07YbhVR6aJi09
         LRK1k08oZyUT1KUXKY9JFrtFfXq45EedssBuX4m0uC5DzAyCIIuIb96+WN0Vy3zVKKst
         vChjq/MoXkHmD8EloJEVrCg4GMv6r40jRbvA17VDBnWDPLOv/juy14h01seRlGJvP4uZ
         jPuvNv10l6HYzxhJNXCMjmLuNFT2LadhzcA09S5Qo9XHt+Ywdo4+tpX7GbML7Z88blQG
         bFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768593873; x=1769198673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqMKcPFJgNzNvwRBT4mtPpKjjhfwSlAMvBz3HHfcl0g=;
        b=pRdAqC347SnrTsNBusDpMJTw0BJSqMa2MntTMgKfjrqlY9uQa80H6D6jgmawfTGY9s
         /EhPdaei9hAHsqol3rIwj893KsqZ01LP7XZN3xaUD6UWQvxkPchRmlV9cCvQIF9iB6oY
         RClB813ant75Oqp6rEx4vYHjtBOJwHba/XNOGGf6UzK1JUUIcEFMRTgqtTPdrTUyKqQ0
         7GlPKO/kvwCB+68RkwEj93mFh5MQ4i64+/fzfER6KUNagQOUZ123r+XBYrqTx0btOoUM
         JvMaA4zTBmfgajwq78mnXS9tHBPmPqRvWcWA+Ck2ZRIbaGkCL4QtHcKw2o2hylbB8gPI
         /hYg==
X-Forwarded-Encrypted: i=1; AJvYcCV1lBqujaeH0KXoRCynEwFqOrK5YX+E63+h22BAGX8kGbAPSDtK0BlhcfjDRYu35HfqdUwf7Q7pmVS7x/Jf@vger.kernel.org
X-Gm-Message-State: AOJu0YxTE2qmpse18QTPuTyYjrD3B/ciPhSgC+7JJP0De4GHSOKU+m2l
	THqXLoavzjDWd70XjI7btL3oi9h0O48gdO2h5y5yb4H1n8qIbNkrVsHo
X-Gm-Gg: AY/fxX4UoY95dLYU0CeACaYE0rAL2p0jYLtmF3mQYV/IbmQFLxRKLQVsq7RV51LYZfF
	E08Gtc2jdrBqUzl66vJ5F6IG8iXBJLLRzmSDwbydHueMBr0yl0ExuDKryMjWr+Zs6AkDUfEoiNr
	e+pE+2tuBqQ2RzBOMC26/X9bYBAqLSiMvNthm0MavBBajHg6Qg8DXJOiAmttKRNCKHxHyzVgqBg
	cLGYkyMCo/l6PNrlEyXN3zMEm2anxU66fyN5pfXyATu2pwV4UQZZas0YdUpE9Wn/kP1xmMbErgu
	9Q5Duw1Nb6Tun6xbwo+2gqbPKzB88e4eh0N0GcgVyzKX26PFcOt4V1su2/2QuEZ90+Vsg+5Qp9Q
	W0l4PxX2oKtj1cUOefuflXpbKJ3rYCQc1H3gPLn68poqOfDGsVkYN24Z+djdOiqR3Od58Nxl7pa
	w8gBZkXQ==
X-Received: by 2002:a17:90b:1b0e:b0:34c:6a13:c3bc with SMTP id 98e67ed59e1d1-352678b92a7mr7197137a91.9.1768593873107;
        Fri, 16 Jan 2026 12:04:33 -0800 (PST)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ec743sm5337837a91.6.2026.01.16.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:04:32 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/1] iomap: fix readahead folio access after folio_end_read()
Date: Fri, 16 Jan 2026 12:04:26 -0800
Message-ID: <20260116200427.1016177-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is on top of Christian's vfs.fixes tree.

The change in the patch was sanity-tested on fuse and xfs (with large folios
disabled) by running generic/112 for both readahead and read_folio (simulated
by commenting out the ->readahead() callback).

Thanks,
Joanne

Changelog
---------
v2: https://lore.kernel.org/linux-fsdevel/20260116015452.757719-1-joannelkoong@gmail.com/
* Fix incorrect spacing (Matthew)
* Reword commit title and message (Matthew)

v1: https://lore.kernel.org/linux-fsdevel/20260114180255.3043081-1-joannelkoong@gmail.com/
* Invalidate ctx->cur_folio instead of retaining readahead caller refcount (Matthew)

Joanne Koong (1):
  iomap: fix folio access after folio_end_read() in readahead

 fs/iomap/buffered-io.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.47.3


