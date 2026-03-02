Return-Path: <linux-fsdevel+bounces-78906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI+vMYebpWmfEwYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:15:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C703E1DA816
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38AE730299DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289643FD13F;
	Mon,  2 Mar 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGyoAzwf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AE3FB066
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460611; cv=none; b=R3sX5fT2n1mO9zZGjaSSJada9OScpLl0nUzoIHD1D5xSy9McYsaB5yg+acxt5jEsuKcRtCWDBXrus8sURfVWn2tlvIo0fUpyCyFknIi0TEip3JmjIg2nXVez08i+1QheOUpGsUnDjbjZyV1lP8dIaRB9yh4giauW2bR+qcahA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460611; c=relaxed/simple;
	bh=qyZTSf5Si3NqMjr5V8jrFs3PXm4h5IveD0OTiI10Xwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iabpmz0bVD6XawFH3IzNgpRt2d41Op+VfZQwq1fnXnJ+y3ce8O6l/QlkX/v70WQUMSHB+XwcpngHAyxxhdShDqWBAKTrCKETBKV7nXL2YY6jDQ1f41rJtfJfRSuPpGeJqWyt88WWNYQkRlRpS9viPdGUW0akp9yFyIJ9WvtKbWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGyoAzwf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso4943945ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 06:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772460610; x=1773065410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZR4SU7BAv0LyCxj4xdBAOVWg9UwODZh/qWxLhm3ig0=;
        b=jGyoAzwfup0t0eREeWQ/2p1nDGjbRtGtbPuRSTB35zKbhkpE57V1w6KVAxvNr4yU4t
         BK9QaeE/PEMVZ74dhfNKfYOyii7OTvE9AYHA4hekq7XLAYupMt4FoxWfvzTMeOwKvrn0
         x/MPHsI1Lim4ordxZoLUdWqjbmwCchsv0/vuYRYifWtndzSHFIzzipEQttr9CDQGkJyj
         HoRWMn6RSzGG6DTcYyCW5reVev0ar/cq6EE+h6qdXYT104zNc2+QCTZahudS8yXFiMae
         R0F/dkVOItml48B3WjGriF1nPkoUmb5C33u538puO2iHIi4S9SYb+uPiVddRholt7wMa
         fDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460610; x=1773065410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZR4SU7BAv0LyCxj4xdBAOVWg9UwODZh/qWxLhm3ig0=;
        b=PHAFaMjIA5eWtWDHCNjd7vbYEEbieNOf7BAng3uJ/7pzJ8G3tBarvFdZRkoaTKaHaf
         8j/SQA4JGnahhN5F29oMYqnBr8EykLzO1K01bQdZmzIhTTxttnWvmogsTMCaSqPNLk+I
         NBjkqThrQlyaNZwhrdXJP9FpiJT+W+ziYVZNLHWH78WrKkPiSV9tep95peYULn/a1/o1
         NwDXSIbb3U1YQA/bnrzswwijQ6jP1ydwSY3hquFbgPSjTcWPO+7wlVQqS1vEjFlnzzg1
         XXD0X91WlKbrqVP5aT2VfjhwWTWHZYfRybYMvmEB7dUtuEKJS5zAT/tCDpjOqCsHxIsL
         cVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl5lHGhpdjyhD4JZ9loiqDoSWNB6gKQDeXl8j5+rAtyTiyl4rFBpt5nprjdtmOeqcOKUqQGFTZWOTnPpMs@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfxTFvPa6oPqWqsFbJ0x8629HOtQqfHMQbAadxtGJNu6oJ1/M
	F8CREBhvvjUBhixAWCC5ulgLWP1jWdgQTjzUohOnD0LeuQNuhFhvAGCd
X-Gm-Gg: ATEYQzxX136nmo/rrZe4H8t11pKUfpAaYU7C1Ja30GG27lmvNdt1uTxm3MWgDcufhCH
	3m+vxlXeIINFFZGd6DAAMuoyziin0fDpSmwurAQec/nyvK+TLsWo4E/5OvZmdxg/ICCaFgVVK6Y
	FHwSA209kQs3lS+MWAheR/F2aISXVIXa/x4V43KGjR9U8h4FxrsU/4HL/6ET08M1wHQL6Xi6qmR
	nenQyTGySgBmHxvwHv0O1r01ij+vPHp3Zyj2OE8AaLG1c5LmUA/ngrUks7LEWVXjJWmlTtkAP1W
	zQCMD3qcHbuVYI8uq4YA7jQSfUCr5nXIN9UTENYt/0vVjxSvZw8H3p9PPkXtLVn3qkHiN+ggVAZ
	BordOs8BUcYILzqrrGCxj0C/6oMT+E1YCOl0YQz2nyheQjlI4/NoUQgobNOZaoul6wdilHclzdD
	nUHH43XvyFiE6HLHWjpbhbHh51IyfK4f0wdQ==
X-Received: by 2002:a17:902:dacc:b0:2ae:50ec:fa27 with SMTP id d9443c01a7336-2ae50ed022fmr30688775ad.45.1772460609891;
        Mon, 02 Mar 2026 06:10:09 -0800 (PST)
Received: from yangwen.localdomain ([121.225.53.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5043971esm31045165ad.3.2026.03.02.06.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:10:09 -0800 (PST)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org
Cc: anmuxixixi@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Subject: Re: [PATCH] exfat: initialize caching fields during inode allocation
Date: Mon,  2 Mar 2026 22:10:05 +0800
Message-ID: <20260302141005.107-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKYAXd8PmK6jXa+6kbF2Gf2HZ7Ne1-3_ZwBS9kSOY-JwogZTpg@mail.gmail.com>
References: <CAKYAXd8PmK6jXa+6kbF2Gf2HZ7Ne1-3_ZwBS9kSOY-JwogZTpg@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78906-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,samsung.com,sony.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[anmuxixixi@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C703E1DA816
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 18:58:41 Namjae Jeon <linkinjeon@kernel.org> wrote:

> >diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> >index 83396fd265cd..0c4a22b8d5fa 100644
> >--- a/fs/exfat/super.c
> >+++ b/fs/exfat/super.c
> >@@ -195,6 +195,10 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
> >        if (!ei)
> >                return NULL;
> >
> >+       spin_lock_init(&ei->cache_lru_lock);
> >+       ei->nr_caches = 0;
> >+       ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
> >+       INIT_LIST_HEAD(&ei->cache_lru);
> These fields are already initialized in exfat_inode_init_once().
> Please check exfat_inode_init_once().
> Thanks.

Thanks for your replay. While it's true that exfat_inode_init_once()
initializes these fields, that constructor is only invoked when the
slab object is first created.

In the case of inode reuse (when an object is freed to the slab cache
and subsequently re-allocated), the fields inherit stale values from
the previous user of that memory block. If an eviction occurs before
these fields are re-initialized by the new owner,
__exfat_cache_inval_inode() sees a non-empty list due to stale
pointers, leading to a NULL pointer dereference.

We have recently observed kernel panics on mobile devices, which were
traced back to a NULL pointer dereference in list_del_init()
within __exfat_cache_inval_inode().

Thanks.

