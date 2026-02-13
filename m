Return-Path: <linux-fsdevel+bounces-77135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA0yMjkLj2n4HQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:30:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22236135B97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDCE9305B97D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222D435A949;
	Fri, 13 Feb 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AH7y51N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8132F747
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770982194; cv=none; b=BV4syCNaOCqHY3VEOWU4ox6AsVlQBEy+k4grpy3bslsd94yT52md+oy8Ovt+D/hW2+eUuOsW4ey11S9iFOEbM0KRd1DYo+e/DnSqCsnzFqqnCSTNl6mF5j6J7V1z8FuI88UzsgU/qZY/XZTy4nxI7vz0oWPohP30fVTClxk528k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770982194; c=relaxed/simple;
	bh=yRdxxEeSNXy6izj8NgpmzDD0cYAPaGgW0s6zZ0jEfss=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tQGwgEa6Ak8d+s4XHt74w6KPDiPPbFEWydAMA4Ykz6leqOup2cQOAqE3eln+6+ja5m+ZXFb8P4qIKS5aJk9rsfp7yFn3AlCd6fa7Z5OWpi+wV5YAOBz0WcAnWaInSNRM0zNSjwi71V2rkKrZYkP+UXdwrBX1+i3PIb9gTuRe/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AH7y51N; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-483786a09b1so948475e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 03:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770982191; x=1771586991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VrRaENV2+RrJhtN63mBpOYEQNOfw7by1//NaX0dMW28=;
        b=3AH7y51NpgcfeQB2x4ZH5z0t0lhZNs0TRy9+a1JFFEH5QZribSWICM0pYNc9j2kl+I
         QE0bhL48Mg22B2FDzt58v2iAobJ/aYiTcrMORIvEwaYogd5G9ijXHIid99ZGTImFgKf0
         cUNcwLCg50A6ABT235r2UZY6yRG57kuupGEuKxO9IZEUMnvqap9Nn75BPavOl1JPONc0
         r8zwyzybYBf1GBm8lwhA0hWs8rpPSxNs5FxlDc4Ni4iX5Aj6S84r4Rzi0HI7971SK3gs
         JtR5teT/XEslPdI0GWdsNwSCacnHP6XcA7mt/vzisEGoZXvcfvJo1kP1lai8vH6dac3t
         SYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770982191; x=1771586991;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrRaENV2+RrJhtN63mBpOYEQNOfw7by1//NaX0dMW28=;
        b=LKGcZNB6mvzMMazmr9VhBztZh5gXXNxmRG7bH740uKfh5jP4jpMK+45wZ/cgt5vCPV
         3HuYkcVRMJOJFyglLUYg5m7QapjKIWENRFR8E39RHq0g9FTQW4iltgMWGEDpZMAqr6EW
         RwyxRFUP0eJyPY4QzmTmjhoOOrZB/cqgj0eN76IRxZS7C6gKc1/YaM/v/MMVgH4HpmOf
         ay7OLD0+l/ArLE7ED0YWFYU+b7iociBmBaGcDpDk+Fu6UhniVG3qVGT0+JiicFZ6EglZ
         KIKnIt1rbniQyb4HqwEb99R0nyWtmXzIvZIegwJhgS5y2FrmIhQFTXzWnGDhEVHU2Mbx
         iDGA==
X-Forwarded-Encrypted: i=1; AJvYcCUQk3Bp75Iu9jbnd4zuNWRhJeSdxYXOcI56OhlKHBHDOQtRhGNqj1dbRDWb203A4GABIg5RJSPllfLVyofA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eg9ZXonMwKfldXQdYaTJxTaXXe1xNPLoh7rU0HiHQo1/mkAL
	44efGylCnAE7caVac+M8Ly8cuL/QmAwER73Bk3HTEHvgfqqdOwql/1gqMfSIuGS8fBkPqvfiTJh
	TqfbLQuo8PUspCJvgcw==
X-Received: from wmbfj12.prod.google.com ([2002:a05:600c:c8c:b0:480:69c2:3949])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:630a:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-48373a7b37amr22798665e9.35.1770982190612;
 Fri, 13 Feb 2026 03:29:50 -0800 (PST)
Date: Fri, 13 Feb 2026 11:29:40 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACQLj2kC/3XMQQ7CIBCF4as0sxYDtHGCK+/RdEHLSEmwEFCia
 bi72L3L/yXv2yFTcpTh2u2QqLjswtZCnjpYVr1ZYs60BsnlhQuB7BVt0oZYDN6zHomkRo3KGGi XmOju3gc3Tq1Xl58hfQ69iN/6ByqCcSZQDT3OOJtB3WwI1tN5CQ+Yaq1fDG9sQKkAAAA=
X-Change-Id: 20260117-upgrade-poll-37ee2a7a79dd
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=yRdxxEeSNXy6izj8NgpmzDD0cYAPaGgW0s6zZ0jEfss=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpjwsoVNOaZN4jkXsUSkQmEHNsddyukOox7ICPP
 4GOmuXwfqiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaY8LKAAKCRAEWL7uWMY5
 RlyKD/9pqdT6OQJIwAkiDcdMeckSRujXSgAHs4RPe1qaUpjFqaWptJUo+y5jTcxD1jALPf0ReyZ
 Z9SMLcrhS4eClV10rWZUYr7dLm56YibuqBznRjB57W7XfM31m6gbzCgIp0ihHi3ozyaahA0RpWf
 1LVIjP5sRVgdwtVwH0oCCSCpvRRsKapM+IZ+rIY7Y4d0awtysi0WE8YI2kXK3TM3i4bcm3FoYSz
 KFrhLu+C3/uzie4ykyvhhpqWi3X5f5wgywlLvp7gqkIkvmOIOyrPAbDhD63PudXDuc/YcV5Wo0n
 fQr7Hbf1Yv8YE+NGOXkIGNbaxI+OAbB6ERWznjjxn/G3ohUfXHMc/2BYtrkVk6+6YNHFNv96ThQ
 UmalU9oLC5IgiKGK6JObg433LzPajGpvhXKsBYIC1H7rFrZWrBMYaeAWS3709DkenGZZVgQP+fI
 P/HDMxo/3h4AVlc7x7Qz+tHGwJzwwTTbsvhiCZar0rXviUXD8VfNr5rTt0ILXuKK18A0AWmU7lo
 utgclV8EvVQx/2GIZBhDm7NoZVnODPErPXtSnR1ak/gdHp2xcF7n6rZdbYKHiBbU5F6B1oqBzBX
 znm5583qeZJq9s9i+t9SR/ssW8NiIcPzngqOGvR8DdtQOB4DO4LEWiihhSmSlCD+sHBFtqbx5iT 4J3UJcIEl3ZcWLA==
X-Mailer: b4 0.14.2
Message-ID: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
Subject: [PATCH v2 0/2] Avoid synchronize_rcu() for every thread drop in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77135-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22236135B97
X-Rspamd-Action: no action

Right now Rust Binder calls synchronize_rcu() more often than is
necessary. Most processes do not use epoll at all, so they don't require
rcu here. Back in Kangrejos I came up with a way to avoid this. Idea is
to move the value that needs rcu to a separate allocation that's easy to
kfree_rcu(). We pay the allocation only when the proc uses epoll using
an "upgrade" strategy - most processes don't.

One solution that may be better is to just kfree_rcu() the Binder Thread
struct directly when it's refcount drops to zero (Drop of everything
else can still run without a grace period). But I'm not sure how I would
achieve that - after all Thread is also used with kernel::list.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Change how Rust Binder handles the lock class key.
- Rebase.
- Link to v1: https://lore.kernel.org/r/20260117-upgrade-poll-v1-0-179437b7bd49@google.com

---
Alice Ryhl (2):
      rust: poll: make PollCondVar upgradable
      rust_binder: use UpgradePollCondVar

 drivers/android/binder/process.rs |   2 +-
 drivers/android/binder/thread.rs  |  25 +++---
 rust/kernel/sync/poll.rs          | 160 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 176 insertions(+), 11 deletions(-)
---
base-commit: de718b2ca866e10e2a26c259ab0493a5af411879
change-id: 20260117-upgrade-poll-37ee2a7a79dd

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


