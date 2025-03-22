Return-Path: <linux-fsdevel+bounces-44808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A1A6CC6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138AA18864C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20223BD11;
	Sat, 22 Mar 2025 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vYtlnrts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9CF236447
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675788; cv=none; b=NWuPTKNRZsZurWdS9LP+008vhTBGVZQuFR9eUpaza3RXfRMtGFVM8EX+9c5mSOq3nw8aLCdpqd5pqIb5MKfRHpKHIKU2OiY0jM4kBhcWq7qqPQDT41/nSN2eeIlkCza47sp8Ls9zO6+1Ro4mplvwf+CvUpPlSMESHuTjeN/BBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675788; c=relaxed/simple;
	bh=c3/J2vBhFHgcYU8/R+B3kO6gEpk4hnzkVfVtuyfH1MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7fzSEX7eHpvl24YISKARa6B7kfKHIxNfSsXDaXjJ9ntoBm6PJL5RhFIVWSZ/c3ZNG9JaBdi5+D+uf4SFvT5h60o4J8CQhHNme3X+jtxJ6+jgeR/zPpjwwbmyYRypO6+CK0O1MoN2XX9cs8yek7W+mBuPgAIiMrVJYYMbGml9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vYtlnrts; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2235189adaeso57961485ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742675786; x=1743280586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz/LHTTUvobHGyp+oeRaoigsjw3nQSx8Yss6Q7WiTEA=;
        b=vYtlnrtsa70XvUxSH/BwDpwL7WlkEe4pR4Dqcd+CuXXifqtEe04UCyrmSCgFn2MBiE
         0xvx0EEJLPsYvBsDDvJ7p2DFfbSC2vsUr0PMxehVIEQbrS0mCf9+ohJ+0kHvjJU/VoKP
         CSZemS9GPjNvXN1utqyDLFd32AA3/U3MqFj2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675786; x=1743280586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz/LHTTUvobHGyp+oeRaoigsjw3nQSx8Yss6Q7WiTEA=;
        b=AdCtZU7u+gR7W0eKrBZYmRnAg+XNLrcLlfYPakyTVDVbvx52r1xZa9LGLe91NO5e4r
         RDuXJA82KMmVKB2gNYnnWqeT6NzikK1a1ZdOoJkpbE+1K+IvFOHDWnJTqB+m2BHatfD6
         ZOnfz287CHvYQesyCc2T1e5vECbKe9Itzgh2VclkhWCFSTFxgHvERBC5P6GKMAn1ukLq
         pTZgQL1ebu2yqQ4q3V9mo8Z6MdBMN9TgnM9hqUi5u1jg8ppFCfi1UA4T+ysRshOMgVV7
         BHFMxJ4+m8UR05E7yJesYBhGua+vH+QB7bJkIEOTwbuo0eF03Otf6dg0b5/bBVzfvaZI
         hYdQ==
X-Gm-Message-State: AOJu0YxEaz/gmgzmmAE5ZIJnmJc3XDqBdD++9xrUplkcFsV64QVXy2io
	ByYyv9BPLCxai4hyf9XrXLcmqRrvF2hGbIGVv4J3ZwmQtcP/s2RBJvjWVpE3pJCk2EWXohKuB86
	techgYZA2BOC0IJ3mshISU0Qx12L3G5IBakUu/xNKGtsGGOyzdGqMJHMbvNbq/PKL7AmwiYe6t3
	0zfl6upT7QB0SilXVFx7DbIz2UO0bfLD3gl2eZGtlnMDRP
X-Gm-Gg: ASbGncsQDhXRaV1I2LL3b/ax0DGMK07vr5WAVlFBkThV8jd0ped9bPQXTFzcMKa0g/P
	+ZG0LpqZjXorvUqYHm+OayNPqLqHd40AFPu71F8j8qFvL5OMrKM5SBA2Df/x6PiDcwdKNGiqLj9
	z+QTCL8ITXGr8uRvuaYuwe1fGzzK7woWxS+ToqCzhChdR/ML5kyckpM5yJCQSjiHc1ntTlMhGFi
	yUAs4qgWPgNTdUy/T5oJriohSLDt6JvLXY1o9XBN6Z5QHCyvUdfh4Y70SIJh23jgmTx1OCa2aYK
	USMMnFj2qTvZ/I0GYdupTkYtrr7gNz8xvjzxslD41FDfvV1GDeWVLiP8ZwiQ0BA=
X-Google-Smtp-Source: AGHT+IFlOF9+hHiNwkeX6ca8/2vV/UbK7oUM8j14EpRf1krcAZwqEjvIIPVQftAfXDqYfTgS2nWJkA==
X-Received: by 2002:a17:902:d9d0:b0:21f:6d63:6f4f with SMTP id d9443c01a7336-2265e67fa37mr149203865ad.2.1742675785993;
        Sat, 22 Mar 2025 13:36:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a579sm8711798a91.32.2025.03.22.13.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 13:36:25 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH vfs/for-next 3/3] net: splice_to_socket: RCT declaration cleanup
Date: Sat, 22 Mar 2025 20:35:46 +0000
Message-ID: <20250322203558.206411-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250322203558.206411-1-jdamato@fastly.com>
References: <20250322203558.206411-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make declarations reverse x-mas tree style now that splice_to_socket
lives in net/.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 2640b42cf320..b54df75af1a1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3739,11 +3739,11 @@ static ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
 	struct socket *sock = sock_from_file(out);
+	bool need_wakeup = false;
 	struct bio_vec bvec[16];
 	struct msghdr msg = {};
-	ssize_t ret = 0;
 	size_t spliced = 0;
-	bool need_wakeup = false;
+	ssize_t ret = 0;
 
 	pipe_lock(pipe);
 
-- 
2.43.0


