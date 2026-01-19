Return-Path: <linux-fsdevel+bounces-74521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AEFD3B6BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF15A312A07F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C335B13C;
	Mon, 19 Jan 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8m2fSnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A336CE05
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849211; cv=none; b=GKyGBaLL1wrRGJ4+aX8R2mD915LvhmYRAKup7easlKjAMHJ7j8WlaUzxgklVeiqYTYQedQx9MCyjLnhovwz5yIzQzcDzysKrGD4s0ZKPgbep8pki1QJrEaI8765+91BOQMqtst2U8gwOmft0OdJPbSolrhIVlSO4LJmgT7NQXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849211; c=relaxed/simple;
	bh=bI5IPQFJ+by3IIQyhZwdLpvLyRBSEgqkFjkzhjf0OBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmjfdouJO81BpgJDgYV3wRqT4iAmLF3GqEHcmmrZrYc3HaVkY3LR72ht8WVVcR5C2CUCwXj6ILpKpc7KWtHZ9POwgpQbjYjeeW/Q6sl9ZtARusXyYqDW0k/I6HVfhq4TJAWFtLqWDJXb7srthx+0I/SV/omgk1U1yjf0/sDl5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8m2fSnu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b87124c6295so635862266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768849208; x=1769454008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihXpfk6s5RJismx/mSJFIyW5r33kfZuDg7he69hJB7c=;
        b=g8m2fSnuWW9MWWU/jaHc/oeb8zlJ+oqqRATPoWyqCogV3IbzJfsewiS3Ar8VDLTYQP
         sLoLARaKdn3MyAEkw4YEFZjp5s7dzjpJxXP6W2EVcUKXNkTFkDbtgjPyY5eogFFjHsm3
         M4ZbtfOr25yubVdfxXbd5ggJUPP25/O/E0etf8muiFOUJ2zLBdfI3MGPuLWmo4SzEisb
         x6i86yX+LskIkziIb3BISm7DG8lEzzDtI/A8Jf3v4k1zIP3XRis3KG6Cfl0dNo+/snri
         a+0o/ZDxONqBdUpt/l5KP2oNSLs4BDkQBCYFhE9wQLwpGEjGlw1thZ0SVegOxDPOMybc
         Ueog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849208; x=1769454008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihXpfk6s5RJismx/mSJFIyW5r33kfZuDg7he69hJB7c=;
        b=EeMhrN1dw5uBWGDwC8BcLerRnOLtpGJmlhgxH2IBs2DoWqgOGumW1yI10EOXgRjDMQ
         uCCPMwXCimsHUui4CuEqrZzRtIhxZJB5YnKVgKfr/hXF4mrHZuHs6s12niZ5WJeXRzod
         TEQySSiaJHvnmNNVWzf4G7hejDTCZ1ZWOSesGBu90OYu5xU2kpn/TeP17hKisAfgnWi6
         MmDQhE9FRAqtbaGuO3kXhc8DofeS+ZW/sfcNehCfA7VV1mbPtSGjpD1Y4nkEwMfWYtgZ
         bT9FFs6n19Wl0j52pxlbpyJf4H4kSlDo6PmF8vgnHDb/F6NWEtCSWkkX2hrQsGeGNFWJ
         XdMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVCYhCU3Bt1y2zFWEMbwecEG+TP3WYnLCPUrl/cB3XzWEseDxooFL0ANjOvopJIBUufIqcInNgpHn+FPwQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77G7Qyl3b/pNPUI1SfJaZCjbD6YmD+w5agt1yJdmZqZXbRz5r
	/EqIgB178dk8qB/3hvFVaFvawiMHERxzr5og3ebvSOl6wsKqfBKXkLAqFboq8w==
X-Gm-Gg: AY/fxX6DDJcmnJjtxFyvRb+0z3ULkBnihc0VK4AJSBcgQICglkxxXq2FpRnBw88IWZA
	Ta8dvaGZRCUFDM4H2ArGf8dRX1AAtXX5VUDftXMIQcN2aCj8Y2e5+xo4kDNaS4YGlgvkOmiomd8
	myHut12sp8fMdJkreyAsukBLqzWqlbNnIETTHtYr6qzTwKrMQNyXZRXYF7Jbyhrw/Tcll6ypacv
	41AIaUAwXNA3As/FhwKnKMH9aVRKE4Ax1HPhI1ltEHk4pnvbx04Elcb20+B82c50wMM02y9tDAK
	KR/aMYszNT5Yct60g59qZbzdkEP4GArD642E2JAPvG/07xBtfF9p214uII//8h81pjzSWjrp0Go
	bfgCC4Yf4RpK8Zsn5jUHDrc70n2mv8KBuOLj/pjOt0yQnOnPKvGJhw6vljGST/Jdpro07iFXcEA
	dLUVB7xktBJCBgVSlXWg==
X-Received: by 2002:a05:6000:613:b0:432:586f:2ab9 with SMTP id ffacd0b85a97d-435699787cdmr17106815f8f.5.1768842854026;
        Mon, 19 Jan 2026 09:14:14 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43569922032sm25380858f8f.8.2026.01.19.09.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 09:14:13 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	cyphar@cyphar.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Lennart Poettering <mzxreary@0pointer.de>,
	David Howells <dhowells@redhat.com>,
	Zhang Yunkai <zhang.yunkai@zte.com.cn>,
	cgel.zte@gmail.com,
	Menglong Dong <menglong8.dong@gmail.com>,
	linux-kernel@vger.kernel.org,
	initramfs@vger.kernel.org,
	containers@lists.linux.dev,
	linux-api@vger.kernel.org,
	news@phoronix.com,
	lwn@lwn.net,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Landley <rob@landley.net>,
	emily@redcoat.dev,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Date: Mon, 19 Jan 2026 20:11:01 +0300
Message-ID: <20260119171101.3215697-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> returning a file descriptor referring to that mount tree
> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> to a new mount namespace. In that new mount namespace the copied mount
> tree has been mounted on top of a copy of the real rootfs.

I want to point at security benefits of this.

[[ TL;DR: [1] and [2] are very big changes to how mount namespaces work.
I like them, and I think they should get wider exposure. ]]

If this patchset ([1]) and [2] both land (they are both in "next" now and
likely will be submitted to mainline soon) and "nullfs_rootfs" is passed on
command line, then mount namespace created by open_tree(OPEN_TREE_NAMESPACE) will
usually contain exactly 2 mounts: nullfs and whatever was passed to
open_tree(OPEN_TREE_NAMESPACE).

This means that even if attacker somehow is able to unmount its root and
get access to underlying mounts, then the only underlying thing they will
get is nullfs.

Also this means that other mounts are not only hidden in new namespace, they
are fully absent. This prevents attacks discussed here: [3], [4].

Also this means that (assuming we have both [1] and [2] and "nullfs_rootfs"
is passed), there is no anymore hidden writable mount shared by all containers,
potentially available to attackers. This is concern raised in [5]:

> You want rootfs to be a NULLFS instead of ramfs. You don't seem to want it to
> actually _be_ a filesystem. Even with your "fix", containers could communicate
> with each _other_ through it if it becomes accessible. If a container can get
> access to an empty initramfs and write into it, it can ask/answer the question
> "Are there any other containers on this machine running stux24" and then coordinate.

Note: as well as I understand all actual security bugs are already fixed in kernel,
runc and similar tools. But still [1] and [2] reduce chances of similar bugs
in the future, and this is very good thing.

Also: [1] and [2] are pretty big changes to how mount namespaces work, so
I added more people and lists to CC.

This mail is answer to [1].

[1] https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org/
[2] https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/

[3] https://lore.kernel.org/all/rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf/
[4] https://github.com/opencontainers/runc/pull/1962
[5] https://lore.kernel.org/all/cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net/

-- 
Askar Safin

