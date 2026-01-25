Return-Path: <linux-fsdevel+bounces-75383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EPXGWQrdmkVMwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:40:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13281075
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF0C93005D13
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D553242A5;
	Sun, 25 Jan 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iGzYx2jC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V/werXKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00F7081A;
	Sun, 25 Jan 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769352027; cv=none; b=esF2Hqno7XuRx5QOQsklOzeClE+mhFxt0R5KAUr4itxDy5K0zPQP1XNiiCg2YL6cSgfr6/XVs7VsI/E5o7IYCBU7cVQG5cII91rWCK/9JRU6FqfnH8BxnfrAJhYmm4NL3lIS3T8DtKcN9WG+3U9A7Z5TckSQuU3IHpmd0Gt7OcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769352027; c=relaxed/simple;
	bh=KPDAkGr8n7LDUpQuJdayySUvAhzmR/J8rH+zt+GoQ9M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qUv3EY+DjcknfXYdq9eE4+ggIvQmCI6SU/VPc0b+j+YRcLg5DKxXnV7nlTb37SIn1B2r4NSgZ4nYUHZCELdmV57ZgxF5QBMAgnmaNYGtn1LVl8Yl6tocKkNgewTAPEmweAkTk/7P7a3OR7fRP7WZOQpGU4u8CtBfS//nWui9PEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iGzYx2jC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V/werXKU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E9AB7A012F;
	Sun, 25 Jan 2026 09:40:24 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sun, 25 Jan 2026 09:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769352024;
	 x=1769438424; bh=e1+LRUSjs1wRZ98SLc7vlwG7NKTx+fUqwKv087ZYlf0=; b=
	iGzYx2jCRENOcTQVADHdxTEQ4d/3juOdVZWStF9P/BkmSc6iVDTI3C5EX7UCGqYH
	QLLmkrGcnMNIf2/a0PYPGKmtBeM5pdQ6MKNheSQRL5qo+MVEy/flEYFiquyeTRyl
	kfZl3VXjN6eT+n9XiwYtWTh5mLOL2sByApNTukV1njrCC+Vzd8b93KaCTEJGY6hA
	d8sjAhtI6CXMePbwq1elpzeuklhSYtXOY5d+ZiGICk72C/FS2mpaPvYBCKsbx7eR
	GVH47fSvrb8pcS5ohp5ydlhRZ8c2rtN8syplRqCViwj8FD3usFNqP60GiA7IwYc0
	hC/gdQyABIN5sYm6U3S4YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769352024; x=
	1769438424; bh=e1+LRUSjs1wRZ98SLc7vlwG7NKTx+fUqwKv087ZYlf0=; b=V
	/werXKURR4uBObiIIpKCwEsMNV7QsMlVRkXu/vkcS2LqbyMyJcpN480aKV9H+uHk
	e4ij6FptkhXHt6PuCO89SJxdADXCck29XUbu3nHsquAjZnFEF35nFsWYT/R86SPK
	aj79mUVxpLr7IYkbXJopMiry0S+JTEywQM5/Na4GI5E6iGcNTMwyz4Lqfk0NruKs
	W9ur3JynGY9WNy1dnNi8ZS0eXQYwi7Lp5LcJnaAyFIQYAiBhSJaWSrCEkTZ20U3S
	msRASYNeEbg9cnSs1/UsMZSGcCNDPBhkDG3K0B3mGGWP7IZJMYahdKXDDjWAKMQP
	scX7wwNpIlgtNdvegxVwg==
X-ME-Sender: <xms:Vyt2aXep3IsNnP5MJHq4H20yrHmmotsoZ0Dc67p3ak0Tt9YIeCsB8g>
    <xme:Vyt2aYDldxRk4GOl6KCwglW8lGF8P5nEElaNrRi7qACpyG4lAGnTxFHGXurCHiLlb
    6eNzfKhAI4THJb7lwG_ix1VfCi_FUNycduwmt6rGqSfGNkYcMS_ons>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epughorhhjohihtghhhiduuddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrrghu
    nhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqfh
    hsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhroh
    esiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:Vyt2aS-cVq80xkuRv4FIdQ0zrdCR3d-qane3ulqfmk9QFNqyNFHE7Q>
    <xmx:Vyt2aVy7-2V--wHM8POaXBHGVKiEdaGVxIHJmfUYxXEP-LWJthYZnw>
    <xmx:Vyt2aSpGcXODmBXNG_ktRgFUzFLzii5v07kBaZsZkwrSSbGqgvnS8g>
    <xmx:Vyt2aWoT_98xm1tO4wIODJXn-EGPhLuqk6MXM-eZ8jZUgxaLA2CnCQ>
    <xmx:WCt2aSqYyKAA7Iqxu_pwPXd7YhnGxbwMLumbgXBe5fwnM3cII3PdXrjz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A4E30700069; Sun, 25 Jan 2026 09:40:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: As39fFuPNmh7
Date: Sun, 25 Jan 2026 15:40:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dorjoy Chowdhury" <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>
Message-Id: <57fe666f-f451-462f-8f16-8c0ba83f1eac@app.fastmail.com>
In-Reply-To: <20260125141518.59493-2-dorjoychy111@gmail.com>
References: <20260125141518.59493-1-dorjoychy111@gmail.com>
 <20260125141518.59493-2-dorjoychy111@gmail.com>
Subject: Re: [PATCH 1/2] open: new O_REGULAR flag support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75383-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 9A13281075
X-Rspamd-Action: no action

On Sun, Jan 25, 2026, at 15:14, Dorjoy Chowdhury wrote:

> diff --git a/include/uapi/asm-generic/errno-base.h 
> b/include/uapi/asm-generic/errno-base.h
> index 9653140bff92..ea9a96d30737 100644
> --- a/include/uapi/asm-generic/errno-base.h
> +++ b/include/uapi/asm-generic/errno-base.h
> @@ -36,5 +36,6 @@
>  #define	EPIPE		32	/* Broken pipe */
>  #define	EDOM		33	/* Math argument out of domain of func */
>  #define	ERANGE		34	/* Math result not representable */
> +#define	ENOTREGULAR	35      /* Not a regular file */

This clashes with EDEADLK on most architectures, or with
EAGAIN on alpha and ENOMSG on mips/parisc. You probably
need to pick the next free value in uapi/asm-generic/errno.h
and arch/*/include/uapi/asm/errno.h and keep this sorted
after EHWPOISON if you can't find an existing error code.

> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 613475285643..11e5eadab868 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -88,6 +88,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
> 
> +#ifndef O_REGULAR
> +#define O_REGULAR       040000000
> +#endif

This in turn clashes with O_PATH on alpha, __O_TMPFILE on
parisc, and __O_SYNC on sparc. We can probably fill the holes
in asm/fcntl.h to define this.

      Arnd

