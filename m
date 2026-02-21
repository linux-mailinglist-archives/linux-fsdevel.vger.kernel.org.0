Return-Path: <linux-fsdevel+bounces-77839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHUWKnH5mGmoOgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:16:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04A16B895
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A543028B1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E1FC0A;
	Sat, 21 Feb 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmyGnR+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55241B808
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771632988; cv=none; b=pcQRlp7bJOXZQJso1PVJn5xUTq5oFmR569hNzEIlDCWj1ffDwL9L2tRNfjBIhpQnLyldFxNNC5lXyj8qo7hvd3+KqbLaksyUtnpplqlhI7tR52HR35ipQMAmuAksyXGwVnoPVkzQ35IRgrV7VqZxlTlyE2mU1aT2r+QV3blWG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771632988; c=relaxed/simple;
	bh=3CyBu6t4VMRW7+VaTdEqeBQZt8ryLT8L+AYTjT70+ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6Oq8ef4PAOwMDtshaEjMxNpCWekvhRBQHn6cz2DWsFPlXxfp4xlC0nUqgO47HgQTH3WQEjyY5RUdEWHbRG7ixHi878IkMVSzp31RAkcWtkybf4vYvw14133YmrcHjASTavA5+5a6MOpxLwaGLGwez7OtRLT2sGvocbWNnaXHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmyGnR+c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so15387585e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 16:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771632985; x=1772237785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT8043eXb3x0Y28ESC3KU+eLsSvxZ0GN6RPVeedqxFo=;
        b=gmyGnR+cTByphmKcMVQaGwrgyNnOc4mBuocXd2Bt1JNeS6DrZMvCUw7QWjM3nipa4y
         bjyuuE7o1mZcN6cHm6gHllEBqLgCoq+83y4PNmNan+G7O20r5zx1ZojRa3qS8ZwAyWOM
         uJuxLdRlotZuh4uqIYlx+EAMDXF9H6luBhKZFECbATtuPqwTGwXvAhI+VMt8NLZUsotA
         7ZHQh50HCA1hRnJ17+A2P/PER9XokOBnW3WzBQsc3KhTDSZhjDdHcC15l9EWrwQLzHdw
         TbCysF5cXa36FJTpIJiCxyDQnSe39LAowaXGxmpbdhvS/D5jrv8Gxud/WlBAs4Wcuvvv
         8rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771632985; x=1772237785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pT8043eXb3x0Y28ESC3KU+eLsSvxZ0GN6RPVeedqxFo=;
        b=FkKLJRDbWis6ZeY01HJSVcK4K6XJtxuFdKDCpjbqWXi+j3mFpmVENfZO3TQHOjYpHQ
         qjDorxCix3oLVKCYNWYMlSdP9m/x3PzQa+Ce1xW5hNnW248P3j3aK6XlMBEENrRdPx9c
         VDaTTwYTyWIrIHbSqjIlNZrif83S4q9bKJ6iv/WHdmOJxQjtXGxIUQ3ASpnWpeXd+VCd
         zLYrMKpUmOShIdC31xO0tXHTDWWShzxcoDK22GEE1qfjuvyzFHU5E3+7spSDh7Lt2Brq
         dCZY4QFhcwRNbqmspDuLRBSOtBHsInykC9798JRlQaBqKt6lrc4dv2QUF1Nt1AuiKqjz
         XJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLnGY8QRFNRcg2UvouUDixyl+tfQMGaE2MeuPU3WSxg5CECR0K1LS5EPNENBKmFCeqchJy+JCgMFY2dYK7@vger.kernel.org
X-Gm-Message-State: AOJu0YxyG3UwLHIqmjIg6YGbw4veJoyH4ParssdN5h7dE6QbhnuEqv8n
	p7pZj7DUSuHgqMaOvkuuzKg3yuQW77tjO4kqhGV1vXg1XkRvJ9X33d0L
X-Gm-Gg: AZuq6aL56UuyusfftJikqVvSPWXBMIrTbKWbsjIBdtdzWTcAe6zij0a8ddpwL4NP/K9
	MnQiXdo10uS1WO4ut86hbgT4ykfGcF36HWJSrLrVVnbmdZ+Xi8SmMCG/OgJXVnPcHW1qJsPIVZs
	Wy/GbDCSy82W7YjUQtd6FfmLE9Yh1wc26rF/R6NNjDhEs46nMSoGG/OWo7gq7nYCF2AGg1MOxzm
	8w2/46y9gAWLqZarDB9+Vd6QmrgOGyTr64ZKajeuxZWbRz2tX5bdpwgUPTawWT13V0V45ezU6eV
	LlLVyjOoC0coL6QAjWegxt/79b48MPQ5+/on0c19fOFRHci/O8pPUA6m7vj8Af2BnE8MoRwqdIK
	RpqsN/GjXMGR0VltrL1owI1C9t3dDAZl5Wa/74QLMqsH/4pA4o1RweJ+43zKTeRrqEQbxO3S/KZ
	rrYl5ExnWED3NnSQ1t8jI=
X-Received: by 2002:a05:600c:1d15:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-483a95bc0cbmr16930615e9.8.1771632985095;
        Fri, 20 Feb 2026 16:16:25 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a42cd49fsm38764515e9.5.2026.02.20.16.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 16:16:23 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: ddiss@suse.de
Cc: brauner@kernel.org,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	patches@lists.linux.dev,
	rdunlap@infradead.org,
	rob@landley.net,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/2] init: ensure that /dev/null is (nearly) always available in initramfs
Date: Sat, 21 Feb 2026 03:16:09 +0300
Message-ID: <20260221001610.820321-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220112606.551099f5.ddiss@suse.de>
References: <20260220112606.551099f5.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77839-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,android.com:url]
X-Rspamd-Queue-Id: 0E04A16B895
X-Rspamd-Action: no action

David Disseldorp <ddiss@suse.de>:
> It looks as though Bionic has extra logic to handle missing /dev/null
> during early boot, although it's dependent on !is_AT_SECURE:
>   https://cs.android.com/android/platform/superproject/main/+/main:bionic/libc/bionic/libc_init_common.cpp;drc=a7637a8f06f103c53d61a400a6b66f48f2da32be;l=400
> 
> I think this would be better addressed via documentation (e.g. in Bionic
> or ramfs-rootfs-initramfs.rst).

Okay, I see, current bionic behavior is good.

Okay, I agree that this /dev/null patch is not necessary.

-- 
Askar Safin

