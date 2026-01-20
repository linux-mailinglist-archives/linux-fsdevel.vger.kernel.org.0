Return-Path: <linux-fsdevel+bounces-74618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMjxLHcvcGkEXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:44:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F384F478
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A467D64417B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B617413235;
	Tue, 20 Jan 2026 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pue9Cpys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF141B35E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909941; cv=none; b=kcTZiHlY5iXIrKuzpclZfKZajS+VJ2tjWwmRm1aAB+Md5cwjJjqVf1gQTPA0nDtrWQUnZ4Nb0QwU2cS+BlQFUC0hOAMAZndNT4+GNeaZE2E6TZAs4iQ0KCpxdsMMwDZTdBUYh7j9OJcdsnCnP9Dl5VVt/VGYSZSrfA2F1NxIFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909941; c=relaxed/simple;
	bh=eZ7TJKGaYF3Btsft7zsIUPV8gs07SrfjDP9DbiNuoFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwQvS6qlfy8yeH7zY+zU3FrfH7s9wBJlsBVs9qKCcDht4Udkmph96WSOY3ajfk480iT3ctrIlPhC+PFBx2vsSbghlI1ma+yNeq5ENTTJYjnaq57vj4QwTVaWebM6BgrIcmEQiRLAg474V76O8HltdKB404j5J5ijOKv7ObUbHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pue9Cpys; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c0f13e4424so583048385a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 03:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768909936; x=1769514736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3jCOHRzv4aKjnldOO0XQggF0Di9XNaJfQUF6T7RtB4A=;
        b=Pue9CpystnGmZrx/fluVZjLHebUi4aNWTlVUOrz4/swJm2oUVrnZWaBt8cGwYP4Fv7
         TVvPMJf3UGwSwgir6uSBUZiqRD/BnPnkcD947UDirU6VThgByfPQ48orS4l5f/1L5dud
         tdemvgCUXNfjYGDc0vdm8pf3kFbYV42gsYGnzxA9aF8yYiLDF0oEbL7dx9VeSwAj2YlY
         NDNspL3+L5Tp2/aHdBPwBdMYmU/cscIFz9p4ab6AYCW9PZG/seDVIppUMQcLi5SVOphF
         a0e0r+0PJgjijGrWbNjnnxyJW0PVZIW3JyMR655YN+/3VR9TgddbdmBH0lgCB1E8xMN9
         LXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909936; x=1769514736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jCOHRzv4aKjnldOO0XQggF0Di9XNaJfQUF6T7RtB4A=;
        b=HcOjDSSYAQonXjTK9TVPirHNoik0K+jjvmqZV8NmnunR+0nFJDXoT602p86VSngln4
         e1uIng7vkvJErTWI19CzBBh7jermtBelnEXEkUb1gUSWkh/XkgFJ/MNQ21JNWa1hiX4B
         Wv20eNJQ03+Fti3ZYvs5GgREPVoLMJ8rb7AY5znpBCqeF8is4nJ/cu1CH4LPaQtKKqgL
         1wfNc47s5jn72273iAVFyM+MBfY4MYeEzhE5Ynj9g7MrepWl5q3dGxgRfwB4+mu9X1Qw
         KBqGEaGxpfVaYxrJSJPqKWOq2X4wv/+1A8NmORbLV4RnhdPTBs2gqW2mHWvCxwIjUonl
         0yVg==
X-Forwarded-Encrypted: i=1; AJvYcCXBGsE9d/eP8hzS0f8d3Oj9gx42ioN0ebp4hNkK2e3bEhDW5LH9eAoryLh+z3fiSF5A9dhYLLODTLMb2hgr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5JQtpPwgYiC1pwhkIrWVlWmvyd8brkb7vmjhkjK8XV3HkG/a
	eVJtm1r3nXsgXgDxAlbF5jF4zwyTaRLrE/SCk07RxGm0pvLStWNMJ3mX
X-Gm-Gg: AY/fxX6hC/NP38A2TgB0junwH+LsLuRh+7rYdJu27XJe242gz7eaMLNqZgS+9wyXI0c
	wQP76U7O8Rw2WHjTVfrIsXP2TFzfgkIMy4DUk0om7ox4iODJ7B5kRcat4bf9mg9ttHzT4lGZGOj
	deMTuNUNtbIFZn2pXNwlHKcWPxGRWKub35iGXzorVCQL5mxGik5k7oVKuxzD/seY8m2HmllyDPK
	E2pPLcibTb+NvN266xa6h4CCgXK79gkybqVOX6UETM2CvIX1NPRLW81hrt/GYSBScCI9+olLCr/
	atTfzDLSywnDQ0KIzrjYH0iOkW5L5cghClSvMLOgy1MwFjT8P89cEJB38d0MVpStKSGpNGJ1MDf
	iA9X9+5Q8xvE4ky9m0BWfoHZ0X+B1I7HUpwBSdZfkMMugbdYqgRsm7kESLFOi//dS6pT9ZhMwwa
	38ePwwHDtSm5m4ytW6BltrS9c5fzv2kt3yjgeLpm1TcP5F9TQ36zciZEFIeODMoDcMi0kN+aw8y
	bE90MUPClNqlis=
X-Received: by 2002:ac8:5ac2:0:b0:501:4857:62e3 with SMTP id d75a77b69052e-502a17567camr193852581cf.50.1768909936488;
        Tue, 20 Jan 2026 03:52:16 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9eca6sm99050811cf.11.2026.01.20.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:52:16 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8333BF40068;
	Tue, 20 Jan 2026 06:52:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Jan 2026 06:52:14 -0500
X-ME-Sender: <xms:bmxvaWGr-4XpSM2vYETxRfUydfurWqwHFWJHiYR4KhaLawbuGlmK7w>
    <xme:bmxvacP1XsD6L4zGUHJS-GKS6exgJDYz4GNc69LdovkPTiAg9XappwTcXrJoE7tBb
    1QJaNmCVCPmIcANzBF-Jw6zwj6JeIpfyQuxg0jBC7_VevoPjMxvjA>
X-ME-Received: <xmr:bmxvaYseTBbK91tjAnIgIZ4nsUU5pt3fox2UdyKq9mHmollKkMp5ZbMG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeggeeukeeghfevudektdevjeehhfekffevueefudeivdelteeltdekheejgfeiveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhn
    uhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghsrghnqdgu
    vghvsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopeifihhllheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepghgrrhihsehg
    rghrhihguhhordhnvght
X-ME-Proxy: <xmx:bmxvaRUyAXBwVhh_V6IggSwh965r_5ycO2CiXOl1oFwnxZdIrzUaPg>
    <xmx:bmxvafQX8S1hdf_qS3P8eOrUvH3N6-86RENZCU3v91371q2d_58Q1g>
    <xmx:bmxvafJUjytmr_Y_iDeVc80QQA6XSAGnWssoZysgpL-n3M7wdpK54Q>
    <xmx:bmxvaQ1Q3Ph2XeOXJbSoSzmOgXP6qMYFVJSm48JOJrLVZLudCjGwZw>
    <xmx:bmxvaSJaEbhz4J4k9DL3G6r9PGLr8WJKLvCTeSQJf2kmGQStvOl5P2je>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 06:52:13 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH 0/2] Provide Rust atomic helpers over raw pointers
Date: Tue, 20 Jan 2026 19:52:05 +0800
Message-ID: <20260120115207.55318-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74618-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,weathered-steel.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[boqunfeng@gmail.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 60F384F478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[1] indicates that there might be need for Rust to synchronize with C
over atomic, currently the recommendation is using
`Atomic::from_ptr().op()`, however, it's more convenient to have helper
wrapper that directly perform operation over pointers. Hence add them
for load()/store()/xchg()/cmpxgh().

While working on this, I also found an issue in `from_ptr()`, therefore
fix it.

[1]: https://lore.kernel.org/rust-for-linux/20251231-rwonce-v1-0-702a10b85278@google.com/

Regards,
Boqun

Boqun Feng (2):
  rust: sync: atomic: Remove bound `T: Sync` for `Atomci::from_ptr()`
  rust: sync: atomic: Add atomic operation helpers over raw pointers

 rust/kernel/sync/atomic.rs           | 109 ++++++++++++++++++++++++++-
 rust/kernel/sync/atomic/predefine.rs |  46 +++++++++++
 2 files changed, 151 insertions(+), 4 deletions(-)

-- 
2.51.0


