Return-Path: <linux-fsdevel+bounces-79576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBUaNgmCqmkHSwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 08:28:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3521C74C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 08:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2BC9304EA5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98237419E;
	Fri,  6 Mar 2026 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yecmu4Pm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B698372ED4
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782011; cv=none; b=dORy58z2OyESZT9Qj5nwfp/IQQxd96+jorb4fpDZD9+d6STahizJfjkPckFpsc7Gf/Xk9hEQyKU4qpXtsv7LWRxGxvSf8SAePpw4wenISqlVODKur55uBCe+pONNyLfBCHAbAWxsDyn09YJGevH4QWqFmHYFET+Qa96QOWHg3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782011; c=relaxed/simple;
	bh=WytjbZ0qhYdE8DhbNmTyH4k86rIIYjGXvL2X04djZNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJiapdjdnc6r0T5+jZ1OxZLAlzsceFEY14UWxW2MU83gm0iNeg/bHSUZupCdaQXWMOejdK25MS9V7efQNA6oGrpJ23AGQw8ME/TRC2dRf8zPrKfBJlapFil+aCvdjHsAY3SmTLD9Z/FpuZpD5yp2N4h8bZGfywuVUPqYWZ21Mw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yecmu4Pm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so102023535e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 23:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772782009; x=1773386809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnmjVX6JImP9WCGFTMSM7Kh0jevJDk+KG2z/pOD1Fhg=;
        b=Yecmu4PmbZ+u3/6reZxqj1xJ+Szdvqg1Y0Nwo26dYbHw+38c32Kd81ZSTyFdVbyUCl
         4K5Uw+kaxfkqjdU+EwWPJMZBtzPHha1kdNHnjLcZ4hVUgJB1VMo8UF/TF8rbNk0yOdcW
         ziuCYkFaxsnAX2rFNuOcknq8lckzeZhrdbqwQn1fHuYk1PO+rkuKSQAz7ClAPSmjQ2U2
         mMQHRTumB4IGlNrcWZrwVUhzwJCNpRZiW7pCvv1HLTDLo+6RutjRoYCnStltgc/1Q/Oj
         jmCtcB52EycrSQxCmXxJCwOXWbBrhQUFD0g3A3Tn1gq/rh0GvI1QWkoe6SVjO5w4jmpk
         5LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772782009; x=1773386809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnmjVX6JImP9WCGFTMSM7Kh0jevJDk+KG2z/pOD1Fhg=;
        b=gU3WhjbwSlzEVHIoQfyelhf8Xt/IRsYzFMfuCHVqCxa9Tp28J7gdVqdXLy+d/WWu/C
         qvDt2xSFfrULXXVlUXKViwzhS8astIgPdReVe1LwdNb62nJis5tF6DE92C0Rzh/ib5Pm
         HuwZvWDkpZADPp/HkASgp44MFfKowMjalgqz05EIaQ2Ngj1cI3R7Xn74OmqltH3uOuCi
         D+kUSeok9Rnze2EezlnUtRZQhEjtV8R3QY84/pEKDehcZQ3BLe/PBwbfyVdgcmDWPcfy
         4btDUXI5XkzwYNnou5saB/nGQclwIE48bqSaHWHJOOncSnlvED4M67JYSubD/i5D7Om7
         3Gtw==
X-Forwarded-Encrypted: i=1; AJvYcCW6B0Ryx34umtrbnqCDiPLXIjObtRAufQiyJz4bah1NhjZgtSEcv+5KCzdU8DMCW58Xz1P35wxo+fwSMXHT@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOjuWFxhTYb9gJyyQWX8FXg3hs5SoZ4v2UfPt/uDE6vzB9yS+
	HLuht6vS2kyQufcCpIV1Mie0oamWc84Z89YpPAbyvHXtNxNrcl57IeVJ
X-Gm-Gg: ATEYQzzmAkyNLKfsf+gwQE5SNL6xSBOdJt1VTGZIBBLwvEBryAZgCtYYMParxuNTdB1
	+JH+pP3yzLGhb4d8uZRcedCQV867fGQr5TdSQFDdvScUmOrj23GSUgSLp/XLEklSEkkgPfRBgfg
	TEwIOhCIRtznVNsgOj4+386r1KA7dTeMyyNlC9N6WU5ugHxf/xNEeQ9EQR3aCQXNTF8Zvkyap8C
	0wr7cVklbLvYaceszdkYWLshI6SfsPMuz1UQxoMSwXoyPmGTl5EWK/mvyHVke47yVBmH7KCQ1MB
	qvLBB8ndNiMpf4dU0LvMrYxIKoYnfzubrXsf6dz8vZXTc9xpRiAOkacnzdKGXafBRWMfC2z4zql
	kcwW4ez/S4cNAMiVy7qvzJ8cTtlz9WHe53Ja5FYBFEw26+TfnBffxlLsFzxKTFNv7rskFH3nM/S
	TX2wWVoNLd7lwBvSchFOQ=
X-Received: by 2002:a05:600c:45d1:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-48526978962mr15112605e9.34.1772782008828;
        Thu, 05 Mar 2026 23:26:48 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-485244b6e9esm18648865e9.5.2026.03.05.23.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 23:26:48 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: axboe@kernel.dk,
	jack@suse.cz,
	jannh@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC DRAFT POC 00/11] fs,kthread: isolate all kthreads in nullfs
Date: Fri,  6 Mar 2026 10:26:39 +0300
Message-ID: <20260306072639.1731059-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64E3521C74C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79576-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> Instead of sharing fs_struct between kernel threads and pid 1 we give
> pid a separate userspace_init_fs struct.

You meant "we give pid 1 a separate"


> The only remaining kernel tasks that actually share init's filesystem
> state are usermodhelpers

This sounds like usermodhelpers actually *share* init's fs_struct.
This is false, otherwise usermodhelpers could just do "chdir" and change
cwd of pid 1. So, please, rephrase this sentence.


> Be aggressive about this: We simply reject operating on stale
> fs_struct state by reverting userspace_init_fs to nullfs.

I think in this case unshare should simply fail and return error to
userspace.

> PID 1 uses pid1_fs which points to the initramfs

You meant userspace_init_fs, not pid1_fs. (pid1_fs is mentioned two times
in cover letter. Also in comments in patch 06/11.)

> `init_chroot_to_overmount()` at the start of `kernel_init()`)

There is no function named "init_chroot_to_overmount".

I hope you are not offended. I just did some proof-reading.

-- 
Askar Safin

