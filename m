Return-Path: <linux-fsdevel+bounces-22223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFB89143CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 09:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FB91F2179D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897214595B;
	Mon, 24 Jun 2024 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMpz7szl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D443BBC2;
	Mon, 24 Jun 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214908; cv=none; b=M1ye21ksC/JGMImSetk7PWwfY/4pRmKqG45nWZELDq5B9dH1KsE2iLBVw8j0x26mNhQuoyF0sMqMvPpUgZ2S50NFM2sJPA+idOMvOYAI+C9QkzWmG3Sbavopxk2zlXOXO8feDNF2biuHd+Grn3kevRd0UKBci1lDoh9BlKjji1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214908; c=relaxed/simple;
	bh=9M+z8MklXk3FMG61i6vFgkF3D2d9ZvYbgMrZC3gQ29E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddfAjJnfy3VhwXZGKzN/nlmNfubnGRu5Ws7XQqhfkQZQQLNrGzpfHOwpZnw3O8CsjROlp7afcJOUl/tEBgAI9zRpmujr2LH3j2NYM0EqChtRJzvioIp7we2mvdq0LA21QvmBzPw6Aq9z4a2T4ia+S8Om/iOXffY3cEDXmPFOWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMpz7szl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so50258611fa.2;
        Mon, 24 Jun 2024 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719214904; x=1719819704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXBCIub9Fx6A3rK4w/i/XPN7m1LBrK8LUX9NK9s/egM=;
        b=bMpz7szlo0VmJiJssgTtgLLX4lY02dBLUgi/59344ZgTOm4LgKBValTGoqNocqQs5W
         a04fCvoG7rfUdMwinlQAjeDCYCxvYb6rjG8A/wsZaOqzTrHNMiKtl7q7nHhh46xHeZdL
         rIncThs0wGjlY6mMJGcVDGr25qCwecrZXNP/+oJhhu41bmCydMD8iwd2Sae1Kb68rqqn
         8kPBFdudZV6R6Pshpt0QVl8BEDWs65L0/MNFyB3PJN3NZgDz/jx14VHFDQU608agt9Zd
         Y2S1pYfKcWgbZwBEPJWKp8Zs9E1uqOxz24hM80SjVRcwok4rTOUfwWiLoAU5zNKAPxYd
         lJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719214904; x=1719819704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXBCIub9Fx6A3rK4w/i/XPN7m1LBrK8LUX9NK9s/egM=;
        b=OSeKGb8ulBpc1Mq6Iza8KFp+h9/kTr1Euw0zt4YaKL0Do8RW5drsEj4adCzwRg4bMH
         TctfVbwoK7Tq0axywrYnJsfOTy4Q61i+E8evz44Iwi3Ao07Bsh6l9AoOPQfAxtq+hmbW
         2+OyjGERtI+GMhdEE8OchFoeZEa3RkH1roS4PcHmLtb2FL6f9ruoMyicK3sIQLjRFFoE
         A2yVwHCGlG63ZKWoZMSkMmIhn/H+lJSLAmbY9Co9RKLpFysKg3iIddevFva0RfqFNHR1
         Y13aAPwYPN+FCZSmEA8HzHfTPRG5Y0ydiuYLKnJ1ymwyFQZgiIyjOvobQ5bdNk0DdeGh
         di4g==
X-Forwarded-Encrypted: i=1; AJvYcCWNfdEGeELX2Trr1MWA3iSBelKtjO0cDEb7tqooWPbO1UqKYy14hFIWqmSuBXwJoSZ7NydLnFU1DRYdfBVk3LPav5zv6uctEaJo6yyxooW5RC4PExSkbBId94N8l86op8RmteUXe7+pRa2cww==
X-Gm-Message-State: AOJu0YzR3E0GIx6iX41GRxyhROvIXRBgH3zL0YRmy1JoU/gqF1whTyV9
	DdF/R+//qwdso81po3TtV9ZOnXCOhnxJCUoLbTumPRpjU3Bwadgt
X-Google-Smtp-Source: AGHT+IG11fsxSsN23a0lExAwPS2/6Bzf3b+gb697LzAFSY2k3/HMvphibAWbFWauunANWEB252UUcA==
X-Received: by 2002:a2e:720c:0:b0:2ec:4e79:b416 with SMTP id 38308e7fff4ca-2ec5b2fc299mr27368231fa.6.1719214904154;
        Mon, 24 Jun 2024 00:41:44 -0700 (PDT)
Received: from f.. (cst-prg-87-23.cust.vodafone.cz. [46.135.87.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30535010sm4370063a12.59.2024.06.24.00.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 00:41:43 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: cfijalkovich@google.com
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] vfs: wrap CONFIG_READ_ONLY_THP_FOR_FS-related code with an ifdef
Date: Mon, 24 Jun 2024 09:41:34 +0200
Message-ID: <20240624074135.486845-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On kernels compiled without this option (which is currently the default
state) filemap_nr_thps expands to 0.

do_dentry_open has a big chunk dependent on it, most of which gets
optimized away, except for a branch and a full fence:

if (f->f_mode & FMODE_WRITE) {
[snip]
        smp_mb();
        if (filemap_nr_thps(inode->i_mapping)) {
[snip]
	}
}

While the branch is pretty minor the fence really does not need to be
there.

This is a bare-minimum patch which takes care of it until someone(tm)
cleans this up. Notably it does not conditionally compile other spots
which issue the matching fence.

I did not bother benchmarking it, not issuing a spurious full fence in
the fast path does not warrant justification from perf standpoint.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I am not particularly familiar with any of this, the smp_mb in the open
for write path was sticking out like a sore thumb on code read so I
figured there may be One Weird Trick to whack it.

If the stock code is correct as is, then the ifdef as above is fine.

The ifdefed chunk is big enough that it should probably be its own
routine. I don't want to bikeshed so I did not go for it.

For a moment I considered adding filemap_nr_thps_mb which would expand
to 0 or issue the fence + do the read, but then I figured a routine
claiming to post a fence and only conditionally do it is misleading at
best.

As per the commit message fences in collapse_file remain compiled in.
It is unclear to me if the code following them is doing anything useful
on kernels !CONFIG_READ_ONLY_THP_FOR_FS.

All that said, if there is cosmetic touch ups you want done here, I can
do them.

However, a nice full patch would take care of all of the above and I
have neither the information needed to do it nor the interest to get it,
so should someone insinst on a full version I'm going to suggest they
write it themselves. I repeat this is merely a damage control until
someone sorts thigs out.

 fs/open.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 28f2fcbebb1b..654c300b3c33 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -980,6 +980,7 @@ static int do_dentry_open(struct file *f,
 	if ((f->f_flags & O_DIRECT) && !(f->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
 	/*
 	 * XXX: Huge page cache doesn't support writing yet. Drop all page
 	 * cache for this file before processing writes.
@@ -1007,6 +1008,7 @@ static int do_dentry_open(struct file *f,
 			filemap_invalidate_unlock(inode->i_mapping);
 		}
 	}
+#endif
 
 	return 0;
 
-- 
2.43.0


