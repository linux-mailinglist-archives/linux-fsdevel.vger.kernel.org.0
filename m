Return-Path: <linux-fsdevel+bounces-40646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D395DA26304
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CFD160FF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1426D194AEC;
	Mon,  3 Feb 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw8Jaw9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F51192D96
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608652; cv=none; b=EO281yVZsFAQwkT1fOr34kdBBwRq7zx3rS49xv/NvvadpHGqPVuTva9Djli5tJ7A/WxWLm8pajYjcJ7xVJTChfa+D9dcgv1Q0TmOQQ7Jg0b5a0Kr1u5Km5Oc8ABAo/eB61FNHbfSSa9+MN9oMmP/qCprXT6NBtKpg+vzeZIyu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608652; c=relaxed/simple;
	bh=BFD59uvDnR+GOkU5rLWbMQqOyJ2+gcCRx0M9yXxqYpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cw2mzoJURsl2TdiDk14mQAxiqdrGjwkR7DhcgdL63IplZ74E7CLWEFrqCyl40bFnjcqsWiuP0kC+1rm18Lm3eqI7hsoA9AsswZTDQ2CbKkelhspId+lCtAo+th6uUpmVfCWKK2yHL66Y8aOiUDbw4zSWhdw2w1qsapBYkM/Tffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw8Jaw9L; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f6cc13d103so25718277b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738608650; x=1739213450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htLW/KOelIjWDkTafZY5V1VR8T+j+68LA8yYQyGMNyw=;
        b=Kw8Jaw9LBn4aOifr7XUBZrtU2D+ljUOjDaLfqAx63llyoi1EhFqx+n+Y0zSkaZ3mTE
         P74B+5R41qudYcOeFNNHCutLL5VxQFlofZRAFzX8BAHrjB3YjvcKhGsvLuHYNSVkjdv7
         1fUwKZLqNFj0H+Tdv1SwO29L8wTsXOc3iTX8ENBc/f5NA7p5/PZoAlSkbKBALggVJvh+
         7/btcBie/2zU/aFaBjELQM8U1dDWy6St+/obVEwrXBiLGjT5agCFiktovApyzBkbkkTJ
         V0BfKEPlwS2jfOwCm89PNIpShGR3ijRniOGRLa1wxGx56OBtXHzQLlVbZQN2mryz9OPA
         hZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738608650; x=1739213450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htLW/KOelIjWDkTafZY5V1VR8T+j+68LA8yYQyGMNyw=;
        b=UywjsOUJ6BbMe7GHyS9FvrGE6JSBnneNyKRVVLOeKvmhn2l4D605kervR5RS0HZF5+
         f0czom3h3tih7DcY/ZRXAcrE64opUEoFcb5Ma7hgcrv5b2IlS8DBS/F7/GbxpJLpirKD
         cl14g6UQf61xs7DMcEttGGtf42sfslaJBkaax6VoY4Pryea3iSSvTFmEinEP8XpoZ77A
         aF2WH2zdtCu3kG/Tm219cxeLwFQhv6gszIIiK2LPG9n+NnFFclFo4nx9a2IFEtLpzkjF
         XIDujOHNKVosU11SzjEHb+DBrqqdpemHKAnlXszDO6oo7szmRPggt2EWstf7XQJNcM9t
         285A==
X-Forwarded-Encrypted: i=1; AJvYcCUvPDETEy2eUiUn6x0JleAHfLb/8aZFb2Pt4z431M/UVv0C47g16yMrNvhxX6zF7kbNUo31kvedIsn7maO6@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkiYrIfSoiBAIffC0E7tWJXFjB9hIIkHnDiXa/7sC8Kmp+dba
	Xt/ZFuqLVYllsrrS3CY/ieUfn7Pyec9a4VXR//9JjygzeId3t+JHT9yXuw==
X-Gm-Gg: ASbGncvUuy3NFqgyGp1vzJG4Qd4ZZTOoGHHScClOwawgmKuFqI1bcv/hgVasgr6jHlL
	aQx0nZfwL8EBjc6QHJriuv/oCmVmWZbt0Eq3gvM3p14O+5uGojtjK4sKi+6T72UUMUA1Mp91RNx
	uGHMYR1fLF+nGd85nWjhekDAizV1MF5ZsCNdelWxbvNrtVIrNqT0wc2BD+0WILWcpAfMcg+VHTe
	MUi3zj/4dd/LgEXoqhkkF4UkQ2CejyLn4gZ8KxmVBMe2/3CNe3w0/PTM4rIZs3Wb7kKYwWpZQ8z
	3UXvzjE0Ab40
X-Google-Smtp-Source: AGHT+IFC6Av7/3412uHVnoUlD0Xvqq4vpXk5Pv4oPVcUFzOcm5oR5X6oBmKBWyXqKV5v4f74f6hFXA==
X-Received: by 2002:a05:690c:6603:b0:6f7:598d:34c2 with SMTP id 00721157ae682-6f7a8444231mr172687467b3.24.1738608649650;
        Mon, 03 Feb 2025 10:50:49 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c465baddsm22510347b3.63.2025.02.03.10.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 10:50:49 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring requests
Date: Mon,  3 Feb 2025 10:50:40 -0800
Message-ID: <20250203185040.2365113-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

req->flags is set/tested/cleared atomically in fuse. When the FR_PENDING
bit is cleared from the request flags when assigning a request to a
uring entry, the fiq->lock does not need to be held.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: c090c8abae4b6 ("fuse: Add io-uring sqe commit and fetch support")
---
 fs/fuse/dev_uring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ab8c26042aa8..42389d3e7235 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -764,9 +764,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 			ent->state);
 	}
 
-	spin_lock(&fiq->lock);
 	clear_bit(FR_PENDING, &req->flags);
-	spin_unlock(&fiq->lock);
 	ent->fuse_req = req;
 	ent->state = FRRS_FUSE_REQ;
 	list_move(&ent->list, &queue->ent_w_req_queue);
-- 
2.43.5


