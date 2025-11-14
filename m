Return-Path: <linux-fsdevel+bounces-68417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5BC5B48E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 05:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E33F352DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 04:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADF82877FE;
	Fri, 14 Nov 2025 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq9k1JdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55482287511
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763093561; cv=none; b=bCLoxuqZCn4eF8mkJPu8oUVe6xJR604cIXiQyY0jEpdzlTFZUvVsviiTWFYufC6ytpnVk7Y6vH9ewcMcSsoqxuHAOHmF6l0gDhV5xZKyKNUdTU5yBArg5iZFPq+7pBmPAq1N1cSwx3vR+oq9IHvL/FFfL5d9N06P0cAX8EdEPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763093561; c=relaxed/simple;
	bh=W0eoOQNzNm5YY5YgxflYTQ/kBk6D+mNwE1DDVVojPPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwRiOOZdnHOjzyawuf+/jPEKYy3sPXiu01J2My3bbCVf0xxMm9V/Y90oCmafzQgtbQiU914hc077GFEPcLc7NSjKKQuRMfeXvsOshuga01cAd1L5tnhhWvUVp2mBqrvTuMy03sJstpHKFmhtBNW4BaNqQ0B3Ha9jY6ZtiXYcROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq9k1JdT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b5dfa4e9eso6047f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 20:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763093559; x=1763698359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtCCwWqxWfvDUrchDxviUPW8QDIXzH4jPlQ4x/1M7QQ=;
        b=Qq9k1JdTNW9Nbgcoj5bEMEMCZay2OuYYqvHbJ4H+yXUQbg2rL0hq+1CZuceZ3aSgjj
         ubF0mWman9wo8Qh3/hLYq8eN30Wl9O0Fuz/L0m0DnUnMQCvWNkX5IkeHD3Cv2h1Lk8TB
         aFKKfCOoWuzcO8ZXs1CrPRWAMnarZvgP0OjYxNajCU9hYtkbN0x8fjNNGuIzTLlSJRnU
         d32IRARVBS5nrnk8Cnfs+hAHm2U9GP8KTYT1bzHthEPkuV8TAi1X20I5Ara2ZaQ/B1Tw
         s+lLPZvCdst2l05P2Mgx51aXfMMEbZxzaORScjiJkdXM5K8NIvmFz93ui7Snmivd2ata
         ivxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763093559; x=1763698359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BtCCwWqxWfvDUrchDxviUPW8QDIXzH4jPlQ4x/1M7QQ=;
        b=h9aasi2jNzkuDQLwcuKtfKd33UyIKVD5cGdUdKmNy85mujAAoBxOjhAobMnWB/XFh8
         +eqTMurpByjDLM8IAACWC9Uqdser7EFJuUHUG+zS7D39srcedfvAR1ueDtv75YVhiQ7G
         hhd2NaT/JvAl2PSuZ3MDkBQQFVjOPIcIJuOsft8y2r0he7PPvueeU8076iLTK36icOuZ
         MjKeMGEhKtDYbpzWtgED7zNzgNUEhcAkQ1bNDjhxIJjoJb72saCPh2IRJjhHJSnULLY2
         tA4ThhKrHcb7+JIGTRDwptXBJ0XJ4oA8ZhRFsBkdd41qa3S8MjqxTHbm2d/4C7yVpEIv
         QZRg==
X-Forwarded-Encrypted: i=1; AJvYcCU6hLj3FuQPpgxAD5TsW0cw7hqfd8XJr7K/SMzuBtio6c3U2hzD6ntCW315yJVsK1dQAJRM3FiSFcITnv7I@vger.kernel.org
X-Gm-Message-State: AOJu0YznC/Kzj4CuIwj8KepuqghSWR/I1VJrPWzUWq/V2bMTypi4pP2G
	dq91PIlXm4ptdx55atWccudIl4+H894mtatmhetNK/Bu4XdUSjap6qJTSWGZRw==
X-Gm-Gg: ASbGncuBJj2s01s5O/FGVTGqqy7MiaLeV3BVKf75ckaOWmqmhNDdrI4SnEdnQx1sUP3
	T/ELL086xtgZnV19oV//VlzTrRe+oye8YIdM9sw127n8BNDkddzlN1J/GTqVlTC1B4wqqo9lJV4
	axf6V7uow/zsgp1X5QDFJd7DIFO5OtDud1ORA9GCMFKR6uaS8oUtPiFlvyQdGDRNTijbqIs0G4J
	oGGwI8MOYCm4ERq+RChd/NTWsLkFCY9BVs1fNundQuDEW4D5ia69nDT9LcnJm/h/4SJwiACrVpc
	/c0+rENZP/4dAPLv1R+G59TRDpZSWJ03FmqnoZWflpTlYYse37jo+u8CvR4DilA5+KxwYt70FmW
	4KYvGqxQ4Tu+GD1ltnv1cM1ruzBRKX1pz9lHieBdgixCfrXhjzGGWtk+6PmnXZUPGK04onGFpNP
	472L3KRH3uiLALxx0T
X-Google-Smtp-Source: AGHT+IHgJb46lbr21e78DuTynWGU9FoSDGfZrzyP/frOGLBEVsotAqEtNc0cOuSfp9m6vZniR0aOWw==
X-Received: by 2002:a05:6000:2509:b0:42b:2dff:d394 with SMTP id ffacd0b85a97d-42b5a983ac6mr446110f8f.8.1763093558506;
        Thu, 13 Nov 2025 20:12:38 -0800 (PST)
Received: from bhk ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84b12sm7777121f8f.15.2025.11.13.20.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 20:12:38 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] fs/super: fix memory leak of s_fs_info on setup_bdev_super failure
Date: Fri, 14 Nov 2025 06:12:12 +0100
Message-ID: <20251114051215.526577-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <69155e34.050a0220.3565dc.0019.GAE@google.com>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..a99e5281b057 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1690,6 +1690,11 @@ int get_tree_bdev_flags(struct fs_context *fc,
 		if (!error)
 			error = fill_super(s, fc);
 		if (error) {
+			/*
+			 * return back sb_info ownership to fc to be freed by put_fs_context()
+			 */
+			fc->s_fs_info = s->s_fs_info;
+			s->s_fs_info = NULL;
 			deactivate_locked_super(s);
 			return error;
 		}
-- 
2.51.2


