Return-Path: <linux-fsdevel+bounces-25098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6B948F08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935D81C22104
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8BF1C3F3E;
	Tue,  6 Aug 2024 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="h/57+CeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF21DFC7
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947588; cv=none; b=pC7bHtT9xjtZfnl9SH2yoQMcY6JAWIy1UKNUrNRxoS5AC6Kum3tIzRl0BeEsoyRChuhHBsHvOc9xV/D3Ca4ttacV1+KYH5AKSTMbjQdngLAW8GH8Uer/0VRQaEHwUcLPtk8zuilTXucRLlCia24tjtOOnzvuQqJ+xFhI+BF9D28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947588; c=relaxed/simple;
	bh=hLDHnjRdPnpaeg167MxCyofiZQOaLsJlLf+Rmw4qk3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=adedP4vbrilSrbBOdjM6Nep1mXlW9R4uOZrk0Cr2OOTl07E8BtDb88neXVZE68vMqv4Ey25+H/BiUDDfeDAqq3FD6OktGL8/Ip9N6Z7g+D9WCxBjnbjpq2VOstX9U+gOXjc74u+uheyPrJW3MotvVRM/AubEc6vjS+VtehmQ+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=h/57+CeY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d18112b60so617975b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722947587; x=1723552387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AT7QwYWK8WZyIEtyo3//GG8heHvMwjuLkdYziSoLjUo=;
        b=h/57+CeYAWdfu365BOQ6Xxc2IhfE3gf2v9om5XyaVH+zMxhTZyrfVAd63mbXzj4qEf
         Q95+ZeSAqx59QW0Z8pO54tBttZJREbOEuPG0t+qG1wyFGjzdL0h6txUi5Bd+UUL4Bt7d
         anUs70yV/hEzj9WKZsl3csdVs7eL7xvQz7FKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722947587; x=1723552387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT7QwYWK8WZyIEtyo3//GG8heHvMwjuLkdYziSoLjUo=;
        b=KDL7T2jXw7XXCAvpBivvvgm/4btnfPrSFo+1HOt6K2nX5x/W0v7xPeeIwh7+1ySVQ8
         dc3cOkmC/ETNigA1uz5rJfFjqWJgX07ON1ntQ5HaCCMgfAgPrnqJpTYdx+sq5weGVqBY
         LlB1mWvDEDh7bSFfZjfrGBFDvxkTj+D0biZRAT55ksOsbfQddqgQyGYW77Y4vL0fJ8Pv
         4b0P0uONALfavmQmYXDNmcswGzn7a6ro1OPWjYN8/FR0GtmTsZ4i+vzYA89MX7CJiZHf
         V/5YZmbJQOh6AXFV3Dd84OwIQwi5SI9TtqRPRueQrbpRPYbN/OD6sRv0cFVYSq7bvehp
         lLAg==
X-Forwarded-Encrypted: i=1; AJvYcCVkRZ0nl27B9aA5LGL9lU8f5gx2UBifDwyoEzoprEekY1XnJzEg5TpKD5W81BzRMg/rjVAc2lIaRcE7w6BCJ6f7U6W/yjOkMxY2ggoHnw==
X-Gm-Message-State: AOJu0YzQqSdn+5+NI6vL9cCSYXyIflVjDGVErM/x7RGbE8NVO53tTdpW
	QMC+9w2TizzJoMs4ar/+9M8NjMNE11+OFc5e8koKjqfYi1CydnjY65FN0PxMJRI=
X-Google-Smtp-Source: AGHT+IHrUqiuFtCV3WrfhBJ4arzdppGltRltfSkrJGcbzB3/8Mb8Oiy5ACComQJXPWx7LLJfKZ66aQ==
X-Received: by 2002:a05:6a21:788a:b0:1c4:d14f:248f with SMTP id adf61e73a8af0-1c69a5f0268mr22605294637.13.1722947586715;
        Tue, 06 Aug 2024 05:33:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed16cb3sm7141271b3a.179.2024.08.06.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:33:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	stable@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] eventpoll: Annotate data-race of busy_poll_usecs
Date: Tue,  6 Aug 2024 12:33:01 +0000
Message-Id: <20240806123301.167557-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

A struct eventpoll's busy_poll_usecs field can be modified via a user
ioctl at any time. All reads of this field should be annotated with
READ_ONCE.

Fixes: 85455c795c07 ("eventpoll: support busy poll per epoll instance")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..6d0e2f547ae7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,7 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!ep->busy_poll_usecs || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


