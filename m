Return-Path: <linux-fsdevel+bounces-75355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFq6AXcEdWnP/wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:42:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC47E5A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AE923013035
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5552B2701C4;
	Sat, 24 Jan 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6a1e6ax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997822A4E8
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769276523; cv=none; b=a6yKbqx+H39dzrLOkv6sFJR48Rlo06Q+RdavqvIzzaF0LEA790K7Yc3FCotzl7O7IambyDjWyv1BB4bDtj1UVC60oDY/ofysVvNxWtYykJ9zSyzgn/ylr2nUakSkn7OZhuIVRthW1Hkwi3OZXe8JD1tkzP3qJlJqdpVGZnLqcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769276523; c=relaxed/simple;
	bh=EBc05REX281vBJG/8qd75ptDoBPMWPIb7O5pqviqR6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDzNp6/nADeFb0VN8PrfQ5i6K/dg2qQ7kKBld+Oi08IBpF1qse0AzNnGsutnYUjZQ8GQny3jL6W8shHK5EAbfXqPI7N/P9126SCEcE/DXqlBJ6p8N6xCwkBVWC2r5IjkSurdWtnHzvccA/BZoizBakbRdERw2NdbxQqfNoz51MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6a1e6ax; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4359249bbacso2770351f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 09:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769276521; x=1769881321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwxVrejUO+lBMAe9SgBJs9PZlLotjLAwzjKh+NoaG68=;
        b=h6a1e6axnIl9uasuCe+IoZZfQ8tR9FHExwjXuaLiaDKWlkFNWLqXVGIq8ce7g57C7A
         7dLWhxkl2RZ0Ql9E9ulLuqiSxZpL5FfyV45ZJHXf7BBHCsv301jnwgsHoihBgI/M/0kS
         3xKpIsg2DjLwvk0dURPfK1EdhkUipaWQtQQp+a/H7NwCGkRde9/2xX7RFpQXw6gu1tKi
         SZxQawcmRfX4u5sB9p2sUguwyyyUrTNqgCboNdKTHKG1DmkDpMxADZ/UC4O1XysQNgBC
         myg/+7BsL2Lps5v8LA7P3AXm2Gvsaoq0ygDIUKAHkbnuHw6ebM31vm+a+7l3rtclEUPi
         F2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769276521; x=1769881321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hwxVrejUO+lBMAe9SgBJs9PZlLotjLAwzjKh+NoaG68=;
        b=put9gtisZfsFdITTgDBS1WUGY+yboK0Jo9m0FvYQkQCOafzmFCpwc/T8f2M7gd6Xey
         Lf2XH0+4RFhRUQBhlvW77bzV2GdIOV5L+nbBql5pvSluvSwfspQThT386OZcrcv7BEbh
         IBaQVMKbEF0ogbipY/UVjpMc4BjBi4ayniU72tcf+keVwM46/GBXJAcdGHj3k1hz+liy
         BDjBsapFooPpDkhdT31swqntvqZI5QtBKJUQ7KCaiupr8tJ3O5p5q2hXAH/8YBw0wD5H
         qS1NiywOE+DFSQl8EQa84uAnRvH/CgD/JLGnmOBAKdJGbBmuQVuhXP04GAMucWdsFhyh
         9AEw==
X-Forwarded-Encrypted: i=1; AJvYcCU7K39w/hoOsbTmfhVzw6mrMrYG3x1r6DKBeVgX++hc4WphR/fHIx9OT2wLgYV2pzY8R/SRLwQdwVNylu/P@vger.kernel.org
X-Gm-Message-State: AOJu0Yywor3+r87NbCYc92KZfKCw/t81GbpbNu7hYPBwYrYdlXJ3+ETT
	76mSKx7mNDbUw6LzoGzQ99JE1NR9N9cO4vb4vA7ghZFjO5S9AXP1pt5b
X-Gm-Gg: AZuq6aKg3XxpSPhu/HIj2jZEqgooWlwGZfRtZoOuXNvRQm3Hj4AMyIY5jo7IiBfie/R
	ghTCPihTHLhQNsLehAtpQ0x6CNQVAuZ5rCGH2hWU6oNtdAMnmwzu+TselC5xN11Be6Y90gzuKNj
	Cfxp4hLDArO/F3J1fttLOtilLv6TCYWP0QkCsTARmGSNpHO5q9hWYrcxaVXQuENe7HCWxM+nBxU
	mNuV8PSturdQi7PZ2sa4ixF2DxwHsxmp2ecdIWp62Xc7dTj4C5g4NiEl8paC0ON7wi+C+/WXj61
	k/8S2LCC3qI9naQ9BBxKHD/B230uP2Jxl6eVvQ9+cLbon0nQrAILg+GY0kA/U1UPYgHEG6tEBBJ
	eXFk79TqSl+Mbl/SAI3slV/aESUdjyZ7wmCZMZ6QHtjVfhUMro/BT76FAus3BPN2K2QSVHyfvC3
	x7/rumdB8UvzAZI/mxtA==
X-Received: by 2002:a05:6000:18a4:b0:435:9538:939b with SMTP id ffacd0b85a97d-435b1ad3727mr11730610f8f.8.1769276520845;
        Sat, 24 Jan 2026 09:42:00 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435b1e7164dsm16037107f8f.23.2026.01.24.09.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 09:42:00 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: hpa@zytor.com
Cc: brauner@kernel.org,
	corbet@lwn.net,
	jack@suse.cz,
	lennart@poettering.net,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] Add the ability to mount filesystems during initramfs expansion
Date: Sat, 24 Jan 2026 20:41:50 +0300
Message-ID: <20260124174150.974899-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124003939.426931-1-hpa@zytor.com>
References: <20260124003939.426931-1-hpa@zytor.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75355-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBDC47E5A9
X-Rspamd-Action: no action

"H. Peter Anvin" <hpa@zytor.com>:
> At Plumber's 2024, Lennart Poettering of the systemd project requested
> the ability to overmount the rootfs with a separate tmpfs before
> initramfs expansion, so the populated tmpfs can be unmounted.

This is already solved by [1] and [2]. They are in next.

[1] https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org/
[2] https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/

-- 
Askar Safin

