Return-Path: <linux-fsdevel+bounces-77162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI60ODZtj2mNQwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:28:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EFD138EE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A6430421F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D827B340;
	Fri, 13 Feb 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeBWmqHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F109275AF0
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007261; cv=none; b=BmbNYeZ8KQUIfMJa3gNlk7fbfBeXocWA/XN/Lt9540j+HEmQW3iHOVDgVwDHiikJHdyZ2NbKqTw17fBUSabs4boRwKL61eegz+OV4TXCOQoAZnvKF6gIuP/xztjT0PNq9z+90v/kTEin7228do52mNGu3YocrqOo/qK4tXUSaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007261; c=relaxed/simple;
	bh=un00/YsGQQv3elrbVj77h6K5Ws3O5O7Vg566FCJjDyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg5lvpFmfsIRqc22W9mz6VbbBCdd2PBnOpdrPpmPWpwLYbdDuJWFcvV/r/VDzqan78cmZYJwdd7LiI1i6yLOxmmBdnYiyHkGe6m2HPEPyo96HGM0H6mjKnoBdw6arlM+MxZbRSALIFgXjvBrNeVXFfci+erantNddwNhlsEItvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeBWmqHD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so11197115e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771007258; x=1771612058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIMMnxMQ1WoAnfxxh3sQIcoIuJ9TrAnBleUpKgGkF+Q=;
        b=IeBWmqHDfOO/CNm7mqvEz49XQj7R9c8MJqV3VnF89ixg16Ib5Mi+7GWEm0iYrEc9pM
         ejHDqM4CB/9e0Q6T2WBs7EN7KEojaJxIluo+StGgEhoeMXtKw7crLs7V8rUiDKB2kLM7
         n6BVLgSbWd+ucuL+U03G2dbOma+sP07oSyT1tVpKIq+yEVUQiB2OU9Zk04IDaQrDZfoC
         +44RkxX8BpWd+lDnNTZgLbv8VpZsrBooDzN/5I81BWdkCCvi3S0yNrT49QpWVoqn3j1p
         zBPN9LTRai10SSXx1BMpOIqfwobrOZIjisKyqxSXsph74ryl+gTdMlhyrQjyuv3QeYRf
         KZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771007258; x=1771612058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIMMnxMQ1WoAnfxxh3sQIcoIuJ9TrAnBleUpKgGkF+Q=;
        b=QxgOd2LRw6Udsq8+vZUsbvBHsLvuctFg9OslNlPPXzNHVhZWr70LBW2X3F5LPDHdXp
         /zUi9XkzQmoxva3Q6NB9H06+qB7BXb+TwmvPX1JFLj8WcXFiwyp2v5FFyyD/y5S9aJ8b
         cOEftibhg4UlYp81lxJgTmpx6KIQYFQtq9fGnarTArXupdYGxbouVrNaNz9RKESxyNvT
         /nOk68sA4F2CLnMRS+MFCZXgYly/qF+MgewHSuRkjZeL8cIbwu2WfExYmMmS3YZachaJ
         77u0VET4bS0BEHDhKQTduHzNcDDcaCI1herISrEUrU3gCQREC/gAiqDp21NeBJjCHjue
         wqKw==
X-Forwarded-Encrypted: i=1; AJvYcCXYbFP8iRd6YId4thh9k1RFMk7oTVf4pE5g+P6XexIzWHo6X788sD477wcxvZAYm8VAZZpwEJ7Gu/FC9b2+@vger.kernel.org
X-Gm-Message-State: AOJu0YycJha9Uza7F66nNYFIgfv3ylaMod4lgkyFAtN4CR9DbiEoA3XY
	5zPtqz8lg9XCHw+VR+CeNBAtPMQvkTr1hg4OkInww0gxbjiYd+ueP6MwRb2Hhw==
X-Gm-Gg: AZuq6aIdhNSUwKz/fFcUhCUcfR7BqtO9xk7h/KZIKI2NDhQt7id9c4lhPeN1BECz+MB
	vrvOIXUKAM9vo5t0zrZmjAWEmGX0CHbgTrtGSA49OCNUYl+CMzALJ3wuAfiNRnBBGYq9NMVsfZS
	cYsusIOhdpomxG4iHforzl3KzYgD1bxlkwnwFj9vtIRKf/yRtNil4yiJ1d0Us6Q1V8O3M0BoeSh
	Xq+et8K/TDJR4DJniDgFAp7hga6mNYU1yOKoQ7di6HKxBaU5bDKXoLrD3eMr+cXbnYZd7WDPlbm
	0Kv8hTxTfQE0oNZIxXtR6HBlfL1YOlUiOl6WW8ckGrI3jvxQpJlWPrLSv4c8uymj8/AUF7zOzQ6
	dv0KhGv6Kkq7F7d3s5WOiLsdM5m1pP+6RIFAYGhVnzBzp2ySux06CqFKQ+AW7oXH6SwH+xC5DqY
	S2XfLwz/ln13TGvkhhCGtkyAaxxTQ6vg==
X-Received: by 2002:a05:600c:8b32:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-483739fc64fmr50451065e9.7.1771007258505;
        Fri, 13 Feb 2026 10:27:38 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4836cd7af87sm115880105e9.1.2026.02.13.10.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 10:27:38 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: torvalds@linux-foundation.org
Cc: christian@brauner.io,
	cyphar@cyphar.com,
	hpa@zytor.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	safinaskar@gmail.com,
	viro@zeniv.linux.org.uk,
	werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Date: Fri, 13 Feb 2026 21:27:32 +0300
Message-ID: <20260213182732.196792-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
References: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77162-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[brauner.io,cyphar.com,zytor.com,suse.cz,vger.kernel.org,gmail.com,zeniv.linux.org.uk,almesberger.net];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73EFD138EE2
X-Rspamd-Action: no action

Linus Torvalds <torvalds@linux-foundation.org>:
> +	/* Special case: 'init' changes everything */
> +	if (current ==  &init_task) {

pivot_root is not used by real inits now.

pivot_root was actively used by inits in classic initrd epoch, but
initrd is not used anymore.

pivot_root cannot be used by inits to switch from initramfs (in 6.19) because one
cannot unmount or move root of namespace (so everybody moves new root on
top of old using "mount --move").

Very recently (in 7.0) pivot_root became viable to switch from initramfs, because
of Brauner's nullfs patches. But distros didn't start to use this yet.

So, inits now don't use pivot_root.

So there is no need to special case it.

-- 
Askar Safin

