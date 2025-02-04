Return-Path: <linux-fsdevel+bounces-40806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A61A27BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2253A2A8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8120370B;
	Tue,  4 Feb 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iQnT28YV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E87204F7F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698510; cv=none; b=ZX02UWlYd5EjBDIT/SIl5rsVYGY7Ga4E6IzVJr+E3dfX95NsijvwIQYcNKzJhopPCHVos4VgMsl1rL6YT/M7QuCLJB4I+sFywqJsOQKtBzTDiwJ8g6C2egeIuxq3Ng3P9qpWR+WvrsfNKAiTPwuit7gsFkJ4AT46Y70PuIrnA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698510; c=relaxed/simple;
	bh=iDg1pcafrTMf1M9THTPfS2st6QLt98jXRHhiBzRj5oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFaQJgUwRuuvwc+47xqFGhF5u1udNL5F5FN5WEHWWrxtsVKSIWXk1f7GX3P9CwWubw6LFkFCXSOMunqzymmXxqZed8l+7yQLypJ0CnO08fqgKs1jVlmM5SlDg5bp8m/GeHLKavtLH62fLN1YnIYgwgY0Io5pRTmvGQ1Awl9jcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iQnT28YV; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-84a012f7232so4410239f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738698508; x=1739303308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DNE4ajdvoJ7lxr6HNYBzebwW7qzyN+uH2k2BONZWcI=;
        b=iQnT28YVwSV9Z2vBpZk4m77N/DpfBaU2BP70tZxHLHYdXmiEsj6Qw1CRan1uWQM926
         PRiQbvOJTa/aFo9zNbRJdEYXepBM55tnzkB7VMrpBEgzwDjRSiPTmt7eEsOrNxMs7Vfk
         ZNDN2aCdEC9tms2i/PVWKHw6qQXLgy7yrO1l7EXa8Sp65njp//ie2UG0PW5yMVY0AZ6l
         tqDTcIAi2dZuxx+CAt817FQP7GPljxyMwt+/HAaNW0DXzcZFYuRkUSZ06lKDXkyNhb7K
         ikkqH6J3un3gv7sDJ4RgFnUWlr28p8RUSIxbQy3QZ3rYs1FWPhfCPa/mZ5ZYGvhNszgx
         j2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698508; x=1739303308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DNE4ajdvoJ7lxr6HNYBzebwW7qzyN+uH2k2BONZWcI=;
        b=IYRlajSaG+F5XiAiKihqqCw9g2qDu9grYl5IZPCM51Slt0O0M9B3lciKlp/ebEWi3s
         vj3JDahCYAXiF/9ljA0qbtuYqLvJYQqX0Gty2XnSWFN1Difu0+JQyUIgzdmvOFSUZvmi
         Rf9JAaIbTf7De6dI227hKlGMQ6s996N6sc1z8VGOnTmWvGPxa6sFb0sIY+m4J1xR+t6s
         j7c8VaEB4rf04Dk8XF/9BNZp41Uif12hr3qGn7KrFmO/z8Yo6Gvzg8x1FzuC3C3IT2Lu
         ycjDFWSWQEkETfl5TQ1W7CEZ6Im3d+lNAFeB0OerI/K7qiKWzfaJOQO/T+CrROv4CXM8
         85gA==
X-Gm-Message-State: AOJu0YzkDcuz9SuA7WxSZVlcB/8N+euu+YWq49X1nvMCNp+w6QW4JaWh
	+SSQpGHP80qFhc993+5tb+WoshcdvkkQcAGBYLNmqlp2sMLJGEuOJxxhvrCsQsnCv3oAsFw20oj
	O
X-Gm-Gg: ASbGncssckbEsLwaGSzXgtCcEINiZA6AAkTT2/AZYFZPy1JTVdXTPG3bwcYHu0xhroQ
	Fz8+REHYgNXiq0J9FrKD2lgWy8etHhFpQs9vAYHIZVLHwtNSU8a/yiXuBQy39dV4wUfpHDFrZEQ
	HEY6RDXSaQGleusZrfNSLsJ+IW0Hdq0wvmiwHtZ65ygvr/e3PagjDsWF3JG1YcykbVwsfAlEr/W
	LEL4wmSOB4EdUGlEJbl4C8XqIQ9tYZYDPkN2ayrvKaWA7dsezxM0qj90BHOYQ8fkJJ4KTUFrpNy
	+PoYschPI5KtAHh68is=
X-Google-Smtp-Source: AGHT+IFNPD1IIdcxu8TcCpr/goDKctc2AwLqLRzlAImxHhejCrluUFCk1NTnS7+2N+VAFH1n4BQjJA==
X-Received: by 2002:a5d:8d91:0:b0:841:9225:1f56 with SMTP id ca18e2360f4ac-854de076c3fmr394580239f.3.1738698507837;
        Tue, 04 Feb 2025 11:48:27 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c95c4sm2841466173.127.2025.02.04.11.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:48:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] io_uring/poll: add IO_POLL_FINISH_FLAG
Date: Tue,  4 Feb 2025 12:46:42 -0700
Message-ID: <20250204194814.393112-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250204194814.393112-1-axboe@kernel.dk>
References: <20250204194814.393112-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the same value as the retry, doesn't need to be unique, just
available if the poll owning mechanism user wishes to use it for
something other than a retry condition.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/poll.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/poll.h b/io_uring/poll.h
index 2f416cd3be13..97d14b2b2751 100644
--- a/io_uring/poll.h
+++ b/io_uring/poll.h
@@ -23,6 +23,7 @@ struct async_poll {
 
 #define IO_POLL_CANCEL_FLAG	BIT(31)
 #define IO_POLL_RETRY_FLAG	BIT(30)
+#define IO_POLL_FINISH_FLAG	IO_POLL_RETRY_FLAG
 #define IO_POLL_REF_MASK	GENMASK(29, 0)
 
 bool io_poll_get_ownership_slowpath(struct io_kiocb *req);
-- 
2.47.2


