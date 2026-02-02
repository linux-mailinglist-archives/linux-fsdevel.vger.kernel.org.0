Return-Path: <linux-fsdevel+bounces-76054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEsyDX/FgGl3AgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 16:40:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D5CE5CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 16:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC23C300B45F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862D5221DB9;
	Mon,  2 Feb 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAQzHm5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3836DCE1
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046843; cv=none; b=h2FsIa1GBYD54S2RkYpdSTSFuH5ryS5RHlrFyuoz9Felx95mIUzIZY6n5thIR6Ydixziy5BSC9bGY1a2PmDkfPyPTQ9zdIIC+Knsdd92oW6IhOyYjORpAzLLN+GCX5FP3MrTgGCFXiPFCYv1Gv2ZlyJxLR7qN5waQYWgecmrBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046843; c=relaxed/simple;
	bh=RP6S1ivaYAK6Fs5+VhDcT3M8k5FicM0n51mqRABDv7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nVmHs0O3RS9KLxy+7UDKNk1BQbqkOeia5amC6cZABMbEXsrb8530xgGW+0BdjNNPn/voY0CUzXd2uB4ZA/6u1y7UwVFxtDVmwgoz0e31fDCHzqPHOYVzRY+WS1aCA5yLuCUdSpU/w96cQ8F2X0dGr6hNJhJHtAlnEX9CmK3TteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAQzHm5p; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-823075fed75so2989499b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 07:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770046841; x=1770651641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n05z2JgZ055VI92yGkVjhSrgVttdCiXX4GMR4DMFah4=;
        b=kAQzHm5pTWygrkNcCvwyQzPkeb3zpZ1/rPtCqNQ/srl24eOOYRxh3hFsf2L1I23R5z
         Ib0UCnjBi1f2Ddp64smUrCpzhSHN73Q3nHbpcJo8RP9m70biXvQuxFIltD3kLsZdAJWa
         kvISTxR9gTS6PaGBpztbHS5WBOj4BeLX3h8kW7c/q/EJ/PgAwLwxmv+lzESVFqOHU1xe
         gQqWcUV1QaunUWmCIFcR7hSbSf2TAA6YVP4ATqrk7eqVyU3TeToApfDtI2bzlO2OarxS
         YcXn5y+XpnwPOHa/zQHe5ZxcCFqNWbWsldbU0l1xfiptEo6Vhkwl8cc1svydgnH6tR41
         4U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770046841; x=1770651641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n05z2JgZ055VI92yGkVjhSrgVttdCiXX4GMR4DMFah4=;
        b=n9r/cYncMjahC1ZkvKdhuYcMHG/+jTm6vzeV5nRuWQ7BGklte1AXvnq8v7xYeHdpFt
         aoaXeolDo8CXtJ6c55tSalDvBFfN0LZWKK9RT41I5mZ4P1eT2Q2njnOBZgyRGusghUo2
         L/qxm/HJs+SNxvSfStko1KqogAPKFAhjJSfEC5lokpjAv3NA5TvM8OiXHG+iT1n3IQyD
         87XYUeQh4Pv/aMobUv2FE+chFGMYsHeJBBr+wgwlbMHOzt9vVHRs45Pr35BmzEpsEOVX
         BVPh5+ioWcb9GZktyg48rb9bvTQFRu2KsnAgDTn8Ro2aXqiKp3nUN/bf+x6JtXV1g5EJ
         vlgA==
X-Forwarded-Encrypted: i=1; AJvYcCV96uGma2gGK9YpwWqMAYSglQQfsgwKEEusPFo2jXuDFomcvibQx9cjTRaG0bF/q3F69+64rNYA7W3BWuin@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+7/OB7qhuw67/Ip8p+c7t8FQ4M05b+vCTJcCfTIbDOBHWYSy
	oYuBFMKYH2sFYo7e/iZ2lnZ8b+6Gw2fScQXN/MYDaPEiGYx3IEb2ZrLh
X-Gm-Gg: AZuq6aJpgwcJ9ezGNbT81VDTl2J1S5da6ks1RqF4y518lWl/ChSmnVp3+EsRMr31ALe
	1DDD79VbHR06yHCrzcdL533xQCFn6/kEPe7NCrv0a7PWjJrjXr91anPRqPXyR2Ps0p5+wLh5CIW
	ho2yWZemNA17diFAq4FoPqPNo2dacijycMRs7qjC9gEccYYYFPGWWlpbhNvWQQakYAlSfx07Yn3
	oiUvmKqdV6jZkWDgo06L3H1WPfEZCCMuit0y8rt1wAHKHhRiQWQxeU2j8bXMznSx/urfxvvMDkt
	bYzb+bBkisRlLKh8xLpeFhgrPZGb+eQr8971aZMoHF9rFMp01eP8zIE/KH6R+/hxN3AKt8WNFOV
	HzS9dK04VS0MNBa+/4w1vIw1vgMbF/IJYirUGzVuXaQLnV1KLx1SSpe2o1s4NrhMeekYkXRGzZB
	m2fwdjExp9mPWrDTJcKFPfrKzau8et+Kr5dmWMKnoAUldR04ojXu7VoTHynwC8DCXamMNQ6pnq3
	byYxcb6pFdnrPpD9K75ZcOju0qntbFlprIdJ5qdoCOXkw==
X-Received: by 2002:a05:6a00:218d:b0:81f:804f:af26 with SMTP id d2e1a72fcca58-823920f2aaemr18442535b3a.19.1770046841306;
        Mon, 02 Feb 2026 07:40:41 -0800 (PST)
Received: from lorddaniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b2305fsm19783019b3a.10.2026.02.02.07.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:40:40 -0800 (PST)
From: Piyush Patle <piyushpatle228@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com
Subject: [PATCH] iomap: handle iterator position advancing beyond current mapping
Date: Mon,  2 Feb 2026 21:10:30 +0530
Message-Id: <20260202154030.644730-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202130044.567989-1-piyushpatle228@gmail.com>
References: <20260202130044.567989-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76054-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[piyushpatle228@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,bd5ca596a01d01bfa083];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: CB3D5CE5CE
X-Rspamd-Action: no action

syzbot reports a WARN_ON in iomap_iter_done() when iter->pos advances
past the end of the current iomap during buffered writes.

This happens when a write completes and updates iter->pos beyond the
mapped extent before a new iomap is obtained, violating the invariant
that iter->pos must lie within the active iomap range.

Detect this condition early and mark the mapping stale so the iterator
restarts with a fresh iomap covering the current position.

Fixes: a66191c590b3b58eaff05d2277971f854772bd5b ("iomap: tighten iterator state validation")
Tested-by: Piyush Patle <piyushpatle288@gmail.com>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reported-by: syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=bd5ca596a01d01bfa083
---
 fs/iomap/iter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index c04796f6e57f..466a12b0c094 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -111,6 +111,13 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 			       &iter->iomap, &iter->srcmap);
 	if (ret < 0)
 		return ret;
+	if (iter->iomap.length &&
+	    iter->iomap.offset + iter->iomap.length <= iter->pos) {
+		iter->iomap.flags |= IOMAP_F_STALE;
+		iomap_iter_reset_iomap(iter);
+		return 1;
+	}
+
 	iomap_iter_done(iter);
 	return 1;
 }
-- 
2.34.1


