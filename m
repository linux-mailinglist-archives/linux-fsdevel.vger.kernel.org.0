Return-Path: <linux-fsdevel+bounces-77989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF8RC2GQnGnRJQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:37:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591BF17AE96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 043B9300D74D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9E8331A6D;
	Mon, 23 Feb 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDD602pt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB511331235
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868091; cv=none; b=NEH6nWfjHqaLDut0guWrPe6wJFK7/X/kSB+EV+/yZbuSp6dt3AYo5Fg2KoBQAVFh5UXG2ycU07gOnnOT/9QGNsKGeTIizoJ4LKUqwxcT6mHsXJjcKTZKHsjCWJZkKO13xIsUhYMJRJKyOrOimqLOnl9X/gRduUPMtTTDtjCw5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868091; c=relaxed/simple;
	bh=pPVYjjX+g8lwuvjjX9cEbFdLG+Rgns4g94OuadbV+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfCZQHqzWyDv7i1YCGgG3gT/LhBHUaclySNAvr5W72yVAJ+lWvESUOvQnpTYspmQCot663/7CzT91iGFsNpYgEmAjjivaSpvP02w8fABg/0yzlxSmNn0MGQFW6uIsIQ8gjlxQEv0mMHKyLawmdJOtPBuRWr+DwSpkGAxuV44Qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDD602pt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48375f10628so29642705e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 09:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868088; x=1772472888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUEz6YAu4nuheVqgpSXCLvSWu/dJuHAVRYNHbZZUc14=;
        b=KDD602ptgLwZUkiYwqEY3ctJ6bnFLeGw4F3dDv3tqqouq2gA/YOh5kHWEBI4H7U6ku
         IZ/OJCPlsgJTTg6israrsbj/MEeFAkUZkN+bjK4INGcsQIu12S60FJsdLpBJ43RtVta4
         tRAEzYzILAO5PJ3FR6FLeVVICwl9syZ4Yt3N3paOpMpy9Ny69alxVadj04I+v6hhI42k
         f3Oic7cnXRPwX1WBFS0rBNWJv27MFth5hlvp++bRCvSbZpmH9O1dO4g1B2STuKHOyYJp
         HyHSxLCth9UFUddaUU3E0JquTttLRtI3BsKHC91WaOGT2GsQHCV+6VTPOpo5sgdheR/i
         2Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868088; x=1772472888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUEz6YAu4nuheVqgpSXCLvSWu/dJuHAVRYNHbZZUc14=;
        b=u6TBFyTGf5oOuNauAHBEVSplcG/mGvl50p+WiJ1Bc11a3TG46WHaV9wY/i3+ERpRDC
         22/g6ezO3MxURyjKqsltCXgfaHFlHjMBt5szl4uBVVFsQlg2UBXXTAjOsAn1mnLuX+pq
         sTGj/D8rpi6d6/plowioGR3s7/urGQwZJ91Oz98l8SH4Tm4kgfplOzRvc9mtafKRmikW
         8vGfxONMdihz4czBD17jP2PXEb3hBSk0ZDcTdmUMPMVcs4fL41jsf6WLRfPg51mKJcD1
         EJtGW24zbYnaeRU40O6ZdIv0fiJ2WF7GTBVi0CUkoK4sm5yPwH5b7EqLvE2UMWseHgny
         QRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLT9yPjsVcWuUvSWhikvuUr/2wdInCkXh4lAw6fpLKWX8irksXTFj9ggH4O8wqmLhUJ1wlKrn2W7l/FmiG@vger.kernel.org
X-Gm-Message-State: AOJu0YwlsvqCqIaMljpG/cbdaXHCWKnubpWLCQJb+bRy9l6nN0bOWGqp
	asfIPfobx/eyTZLlNiajgiHsFCL6Ahpich1iEkDh15gQWUdSFKRqPSEx
X-Gm-Gg: AZuq6aKyLfzCB27rxlzNtY+y1OCq8pfQmJDm48YS86ALdzVEIrsd5ht8elWXoOO4r3+
	qpmPTYJU1fx/OP/eAxzZjn1xFa6rz5mBmiXWArOS8832eEXdzU+Tp6tKwKRNBYNgPXOmoPgXCwY
	kbd8PNQ9GBk6vaAO+c4ZyNpU3BtD41CpxvlGIiWQZZ6l8N97a4NcdOoZjPcUnCzarVWLX6qP56h
	OqOAjR1d/a4uI5cuwdvUxxxOmsn6fUXxcgXTMnrXSYcqorlzJ0MzI6jv81fm3TOpPlQqzXrMa3e
	4HN4Kwxzt2APLbDf8y2yR8D5iPPXH/qaYRHk1eF3pUq7tDFDKwMOiPXn/Boxt/U4mJHaMSnKU+R
	O2vVx/9le37bAo/V1QTmuf6xO3LsDGR1E74fgelNIQz5d93WQXU2s6zjVFKatIiJri1xHosJDeN
	hpnoATZAVBP4GQk859ScE=
X-Received: by 2002:a05:600c:45ce:b0:483:a895:9d85 with SMTP id 5b1f17b1804b1-483a95b3e18mr165817715e9.2.1771868087959;
        Mon, 23 Feb 2026 09:34:47 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a9b668f3sm213824665e9.3.2026.02.23.09.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:34:47 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rob@landley.net
Cc: brauner@kernel.org,
	ddiss@suse.de,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	patches@lists.linux.dev,
	rdunlap@infradead.org,
	safinaskar@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always available in initramfs
Date: Mon, 23 Feb 2026 20:34:42 +0300
Message-ID: <20260223173443.327797-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7e309fc3-7d55-4e95-8dea-f164a7a96b6c@landley.net>
References: <7e309fc3-7d55-4e95-8dea-f164a7a96b6c@landley.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,vger.kernel.org,suse.cz,lists.linux.dev,infradead.org,gmail.com,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77989-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,landley.net:email]
X-Rspamd-Queue-Id: 591BF17AE96
X-Rspamd-Action: no action

Rob Landley <rob@landley.net>:
> The real problem isn't cpio, it's that the kernel interface

So there is some bug here?

Then, please, describe properly this bug.

I. e. using usual formula "steps to reproduce - what I got - what I expected to see".

Also, does the kernel broke *documented* feature? If indeed some
*documented* feature doesn't work, then this is indeed very real bug.

I kindly ask you, please, please, describe this bug. I really want
to help you.

-- 
Askar Safin

