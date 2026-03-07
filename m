Return-Path: <linux-fsdevel+bounces-79672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id V/wyHt92q2mUdQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 01:52:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D849E229235
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 01:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CECE30752EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F986285419;
	Sat,  7 Mar 2026 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUphX1O+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C92571C7
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844711; cv=none; b=Rp7SEPMbdM6vnusZ4PiyFPb4GWrQW4AL+OGEofHg4aKMVsSnonL1wwZ2ZHq+RiS8aHRkQOW1P9N8l4GB9fqu1Hn0mpKiRp9d7AdZFCaqjajywOVzlMRNmv2INjfiZ3ubCwS3/sS8JUBK8PblUarV3OcHqzLoGjTZdEnQHOn1WDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844711; c=relaxed/simple;
	bh=mwqNcTB273ulw91qQyocu2ayRs440ihR3CBH40UXk2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8DpJmXKZe1M54t95YBualLbShnkv05O8uCpc3rdYCjsc/KhvrVds9yIb4fQFB2jVhTO7UZcG6V9Y4Dn745HvyCX3hdBr27QBGNUMnJ2evR7hMNEmS5qrmwmsGKMm0N3AQx5jDp/QlFa6tmDx3M+BZ5UPzkbkni7SOS9e6q/S68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUphX1O+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439ac15f35fso6353891f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 16:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772844708; x=1773449508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTCkikjnueS3c6z47TYvBXYSIRQdE3ZmpIej2YEQUAU=;
        b=AUphX1O+k9HPx/9cSJv5UpqfkomoIQwRytJoSaMUBcA3hEk2KmuD1+hkmO8a2bj7XK
         fMOLPnJlX9OM3wt0TYgetNywlaRIgLhoBIaZbQXE+6ZUj33WLVI4D/4Ic81MVXOfu76m
         c9yLccatXX1Jd8zJM20eY0YjGVFUEjRVSNyzUHwqE3KoZgQ9BFO//TPMMthSzo/qnlDR
         hKcgqUmv2cQb5zlaI83VZCNqHKerbrTu+1Sib5XDBv+Mo3Mei25YjvkbjQc6mJj/MHaj
         dKmt4U/0GGvGbJ73PZCWxPFzjPOUncaCKDipcH3txN6OodVH4p5ZbT8Qo7kHSsYm8W2Z
         LfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772844708; x=1773449508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uTCkikjnueS3c6z47TYvBXYSIRQdE3ZmpIej2YEQUAU=;
        b=hYS4ffDJ4JjpSRaENQbi0U/NxnML6qmQqAtsd6hYXNNZtYEFYjz3eeLiz7SH5rpzZW
         HMEeUSAZS5FcspiJ/nRkznMUmXkubVRldpsa8c/jdHdYNMhNs8am4gWVfyzRdcKdITK1
         kpZjdB4qbOL2CSgk4zvIHCZZZ1DmPmvfjmrQei/KLhT30JYUwCrLb8JRdv0BFsU+qIgY
         dDBiBNhZI268lUhGunA9KdqfpxIcxcyvGVnhs3qMqwZx7CfgUtUNfrhLTsruuDzg1yjh
         GRXqN5kPJ2YlUyJvH/cbe1y0PhjkUBeuIfo3g4nHiEl2xsY4HRTGeqXUfoiZ4nR5D0jz
         0n5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMTbo5MawlH3N/aN5eibK4ox+dc6UXeyliShVqEdS2hfeqaWI+JKPXoe6ricb9i6/Iwim6HQXWRDbsd2nL@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNSVc6gUHupMrUQ/s28PTVZpVpUhQ2g2q17cLjIXorafob1A0
	oXOjUsNv7Phv3aBOXCRl0w3R7GDvyZlxRClydq7nk8ExOb3fuMYrQcgi
X-Gm-Gg: ATEYQzyX+OliK6GatAM1Yrxnn1lHjAjgKARZZmcgfIaavsRPXFfBNRmbey7WTp2sKb9
	ByWOX+q20IqpMU/IfN1rMMt1ZWsbxaTBiPn1ep3vu8Yw1SeML2+ksZ/R9MJVCtm/lqAcQ9KiTG3
	F0bYKDeTDb9dvHeKqJNO1k/DrP7po4M93qhY5VVNGy67slBYBfAG2chGaWDGHawLE5cZBf0Poid
	4ofBQJx2lx+Y9WAfdpmanywIEyi4F+e7vzt2O1Xkgv+GqyICAujm0y6TZ2oZ1p0YY4adTcIn35S
	KDLProVfkWWiy03RQ7D1VKB71EfMxjc8Iefw7yXoAptImcAjCsMI4MKcOrDLqYsjqXTRasegdga
	bPD1A25TXyXsxZg46DPEKy04v+Ql6STqnjwgzi7XQk6/ngKQkDD7w0rRfTQFXhUR0YVEyEVTuHd
	oliVry98EFZBNjFkl1srk=
X-Received: by 2002:a05:6000:1447:b0:439:beba:300 with SMTP id ffacd0b85a97d-439da31e274mr7516787f8f.1.1772844707988;
        Fri, 06 Mar 2026 16:51:47 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-439dae57c05sm6667097f8f.39.2026.03.06.16.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 16:51:46 -0800 (PST)
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
Subject: Re: [PATCH RFC v2 15/23] fs: add real_fs to track task's actual fs_struct
Date: Sat,  7 Mar 2026 03:51:41 +0300
Message-ID: <20260307005141.2582633-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306-work-kthread-nullfs-v2-15-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-15-ad1b4bed7d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D849E229235
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79672-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> Also fix the argument passed to nullfs_userspace_init() in
> switch_fs_struct(): pass the old fs_struct itself rather than the
> conditional return value which is NULL when other users still hold
> a reference, ensuring the PID 1 unshare detection actually works.

This description doesn't match actual patch.

Your patch doesn't change what is passed to nullfs_userspace_init in
switch_fs_struct. Code before this patch already passed fs.

-- 
Askar Safin

