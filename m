Return-Path: <linux-fsdevel+bounces-44805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F65BA6CC62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AC8175512
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616B235374;
	Sat, 22 Mar 2025 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tel4EGsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE9224236
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675781; cv=none; b=ujir5Kt8mEPqPFLTCHD4GsTg5Af/1vwyNmdrtaCfBQkpypD1ll0lOIGrT5y6LZrbDNDBwhCUlKPww/wLvsJv524+/lgs06/tcMfD91tSjMizipQp3YpwDvvIjZsRx0l5GWk0XJEGnU1O8C67+jWVHWBpITkI82WKLJdQI+/L9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675781; c=relaxed/simple;
	bh=/zm0caTFpa5mQQPIid8qQMt0SVoU13C1ydN1hUjgYNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNuHkLw+4h2gHuLET/z7APwyrlY4d5WYW3vQSBP0U4isub1JO+ukomhhcEKOCulHkVttyson8ftEDa6zgjVgdYWNrun/4pBQUeuoiSn5Is44EV2eInbDRtusRIN+l33Qt3JvKw0j05sfv4/+GUkRAvLN1seUfPu/STRScVyc5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tel4EGsR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so3956433a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742675778; x=1743280578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBCRJIfeoI4+hYoyENJ+XtmGOK3o3ECSkLKYl4KE6xM=;
        b=tel4EGsRZ9i0Mp5lyCT2l7sHMN8qBGw4+M31Xa0xkDQ+MbR0Zq/7ldE15b6VMKOSA9
         cvxrbjEZD0+3cV8XJwRroptZPoeFkcE2ggo2nEiZI2orL+MyyHj7TZs7D1qfi84bZJIM
         4Dxen3IrC12Si3RWJw+8bKQ8M4KP1iFajXpEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675778; x=1743280578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBCRJIfeoI4+hYoyENJ+XtmGOK3o3ECSkLKYl4KE6xM=;
        b=wTge0GRD1BcKMnY61PSkFqVKW9h+10u4kygi8E5yZ3DMj67qNgEOBIdeKu0P/Ski0k
         fpqHQnYwSrIZ+rGjVj/6co9dB+Qn9KQOSzkFQ8qf6UFr0QS74wrKhqr7jGtbnT1y9eEI
         nO9y0xBOFYUteZOwYIEzl52JOQqg++dmLS4M3H4ZbPjzaGoOacTrZX6Uais4b0lhCbPc
         24nB/V0dMbEViLoMA7XeNBQSPGmFq3UCqCDR4PLNVo0PJ08vOvXzL3mHNkB8Pdw2qwcC
         7Wl1P7vUPQ/ZoQHSIDXXPXamoY5BwJO7eNNlHC/3VZTAY/0q/lsjTpjdP4sJJokMX4Fl
         5k+A==
X-Gm-Message-State: AOJu0Yw8nOK0CAyr7C4BidLr3cTkRWrVdC0LUovTOsM5PbeaJzWAfmDf
	4PfjFKhaQzNsT3zj72Bo9b5PIiyvGmojxIF531seqZQe0eiMifjCgtQ03Ryy1ZydsFsus3UP5cE
	fQEyjZuXDFF/5Uv3HUBrt2F/AG73ajGdJah4G3n4RS3y+oUayXfzLMn5iqfdBR8ficHHA+y/ZTt
	GupvsU6kn+0JIjHJsMtPQoPsDhBOOm5EE1ezPAxvgvj+Rn
X-Gm-Gg: ASbGncscSb3DBVKl2nInKuzolmIAuQ6IF0dVE4Gh9guBE8Gy/KzRDRv1h/tyEl6vD/b
	fyxQ0wKUYDJjtJaZqof9lRDw1AWwqlaAnUBnaIWRwkd11qVDSxI54M0Ra3ZsZCPVXQvWaOuvGOl
	EqRNkkgyuk/yKqMAUQ2+EZGiXmEzDiR+gG9rmz1H/RtcECu4WXHWuJNtNteI7sdLTrA1ZK1KG/y
	MoXxEI/OZTdbERFWSRE/BfEXyvgEdPB+/JAIluXCZ5yAGDrCIDX5jnUfpdp92vKfJ1v+3hHyVuU
	qgx+Ro9uAKMccduQKnh/IDJaf84JwSl+n+XqoZuZ6FYH5A5PXAT9ghKQoxA35dE=
X-Google-Smtp-Source: AGHT+IE37OrujyxGFgxAEo8ctQ3AWaU9G2PByR+MB79aOMDqG+16a9oIBZcx1WW8S9MeG/hspBAWTA==
X-Received: by 2002:a17:90b:4ccf:b0:2ff:64a0:4a57 with SMTP id 98e67ed59e1d1-3030feeb744mr10822043a91.26.1742675777943;
        Sat, 22 Mar 2025 13:36:17 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a579sm8711798a91.32.2025.03.22.13.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 13:36:17 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	hch@infradead.org,
	axboe@kernel.dk,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH vfs/for-next 0/3] Move splice_to_socket to net/socket.c
Date: Sat, 22 Mar 2025 20:35:43 +0000
Message-ID: <20250322203558.206411-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

While reading through the splice and socket code I noticed that some
splice helpers (like sock_splice_read and sock_splice_eof) live in
net/socket.c, but splice_to_socket does not.

I am not sure if there is a reason for this, but it seems like moving
this code provides some advantages:
  - Eliminates the #ifdef CONFIG_NET from fs/splice.c
  - Keeps the socket related splice helpers together in net/socket.c
    where it seems (IMHO) more logical for them to live

This change is essentially cleanup; no functional changes to splice are
introduced.

I based this change on vfs/for-next since 2 of the 3 patches are vfs,
but I am happy to rebase this on another tree if necessary.

Thanks,
Joe

Joe Damato (3):
  pipe: Move pipe wakeup helpers out of splice
  splice: Move splice_to_socket to net/socket.c
  net: splice_to_socket: RCT declaration cleanup

 fs/pipe.c                 |  16 ++++
 fs/splice.c               | 170 ++------------------------------------
 include/linux/pipe_fs_i.h |   4 +
 include/linux/splice.h    |   3 -
 net/socket.c              | 140 +++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 166 deletions(-)


base-commit: 2e72b1e0aac24a12f3bf3eec620efaca7ab7d4de
-- 
2.43.0


