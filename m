Return-Path: <linux-fsdevel+bounces-70645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A3CA3332
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 11:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A197E3094484
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6553332915;
	Thu,  4 Dec 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0VoEytU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C13321C9
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843332; cv=none; b=tQKOOyDiOvp0ONPo+xiA1xjyznoI3nUIFaKtBafQWlYOo2FGBomd7kp36bJyLvFASLgrUE8gvIuAMo3THaR2Wc9HAlNGgwaOAg0sUFfqmpI11a4OrbNk2PHvFcIF2fahtjeWL/4+G6NdwncaBGVdH4iNx6lrg2y2N9nUPzbYKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843332; c=relaxed/simple;
	bh=G/V5a2DM4z0s4NA1jFBIhpGM5FAP4Ci6VK98GbHxpMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1e+1OxleQ3wHYKG7i6YFWdrVU0Fe7wY2JmNfHu4xZ8y17EUyaz+1/kuFF8nwhtPYa0uyUgTAH8j0sCFxXqaf6qKjAvdrvQIXFYM+bNY4B5Rqo+PkfWPZ0Hut8XktU2Eu6hMnbTp940b/GtGHwuCyseU7Nif/iLzG4kGfwa+W0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0VoEytU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so1084219a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 02:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764843327; x=1765448127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58j801WLI+nIYxqrnb2VGaqLqwLtuta5ZxrmeODMmzc=;
        b=U0VoEytUeDd1Ug8TI8CpNK7Gbv3PalRh4KLvVkldmdJboRx/Rgrg9XZlRaPHddnYv3
         1oc1Iqy7gViD/dEg31SOS8huCeuptdWhbqEqUrrh2K6o2Gt+CT4igXGcdAf/uvWZK9d9
         iWlZsHLq3Bu6o4Wk+x1dc84C8JSwjIEWUw8cmKt2YiZJ81V72Af2ro8A+mHLM1oiJcFZ
         +ewTjVovPbcL/U5ooGqoK2A/PU5uDji5ij/tM+xT0S3vlfkvMKuPuUXEy5/f8bn3lypr
         jPrrwDWKKnTW2mmTaKJUjaDRdVTfv6fw34rkglqs8rVLkKX6JYtEwPWn7csqhEmUONqM
         EO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764843327; x=1765448127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58j801WLI+nIYxqrnb2VGaqLqwLtuta5ZxrmeODMmzc=;
        b=LEeITa+btYVdcBCH6jc8DHDxj9Eb+3J44oUf1EmUvj3QDs2NFNnKuPh26iHoriVdHb
         iGqqvOe4usGGOztPjytptVxyA8NNCeFYJQPT2khcoIWaU2F4kqo4WZAt59enE2yAa3Sm
         VwdqO6QO13v8Tu9dSQiQaZ2zxL/c/cK2pAGzqb7FhGYc0FQ5ytoTWK/Um49KkFlTDPdo
         a986qTHAnr9G/B7IsqtRXypt5RZoKEh7citcGnDZ1zDcpn4IxdttbgX+/BNmGcxAecxQ
         MsoCsUdd+tLUeuzVT4iJZsvepDC+capORv9RjGJZd2nuiK9YlYx2lbBlyWoBlCOqhXA9
         Tdrw==
X-Forwarded-Encrypted: i=1; AJvYcCWCA0J+4Yy8KcGCeF+4FghnWPUEDJPAMxQhHuGlWseI0RtBkGqAtesqhc5q3BPuZleex3kRggpz4tooVW/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+ubRo1rRqgeJsuW0YqIqYhHohwcvOKBW94s08dHj3QD+JVcO
	dwBWnOMQdSivvn3wkSmhxYgAhw0/iJKiiHr2CUcY8kfk5ZL+Fh7ffisb
X-Gm-Gg: ASbGnculMuz9f1sr4AB4eZIOUOcERLPj8StFg7o/Z0+r0yBLbYlnQnj9lYJrjq0nOf/
	wTZgVfUoo7B2/kirzIRNXzWhTrJ9yUPkmwa7nsFKY2PSNJa+CiLbLCvBDOXNlXqdQXla3ipPZRG
	ZRnr6+sRHsQd1kpnPY2rkhBE3MI6wW0r+mthxU4gUpgXXT3B7+guA5MVpoLR1a/ehuJbs4JKfnS
	a/64EvJf6GGDFCCcYs1Gq0NB5uzkIIxcgpv5xRPEoJEgGHqvOaxJQ45D81RsxDofw0BHjIrh20Y
	gUWvx5GQ1SxYDXj2LwzWWXno4hcBtBUijRAlwf631T9yFBUC7UBYCd1U5GG+sneJCulOLbwzC6a
	PM7YuuKLAaAhoRgUUaSQXbiABWUOQt+WBbkXSBdxt4h68rskpc9gaJXhg7Oevh9sXBgCZ5fFeQz
	AH1Y1/mN5jzfq+GT4kX12Jn2qO/qLFaHCQWY4sJFbf3YTdUXwCAipNB8YF
X-Google-Smtp-Source: AGHT+IG5aE1vQvhlm3ydUo6OyEdm6Ub4STF8TNV1hee0aDAXuKoA587zP9S8T0STP6SoUCC84C0yPQ==
X-Received: by 2002:a17:907:7e9c:b0:b0e:d477:4972 with SMTP id a640c23a62f3a-b79ec486c21mr260273066b.25.1764843326518;
        Thu, 04 Dec 2025 02:15:26 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2edf71fsm956544a12.14.2025.12.04.02.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 02:15:25 -0800 (PST)
Date: Thu, 4 Dec 2025 11:15:07 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
Message-ID: <y3ucyzxisq6hcrhynzyhmb7h4vpzkyuueqesw547cx5zmzrvl4@offzqo327t4w>
References: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>

syzbot had an internal failure, so let's try again

#syz test

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..87c99149a152 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1896,6 +1896,14 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 {
 	int err, mask;
 
+	struct dentry *_dentry = nd->path.dentry;
+	struct inode *_inode = READ_ONCE(_dentry->d_inode);
+	if (!d_can_lookup(_dentry) || !_inode || !S_ISDIR(_inode->i_mode)) {
+		spin_lock(&_dentry->d_lock);
+		VFS_BUG_ON_INODE(d_can_lookup(_dentry) && !S_ISDIR(_dentry->d_inode->i_mode), _dentry->d_inode);
+		spin_unlock(&_dentry->d_lock);
+	}
+
 	mask = nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
 	err = lookup_inode_permission_may_exec(idmap, nd->inode, mask);
 	if (likely(!err))
@@ -2527,6 +2535,14 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		return 0;
 	}
 
+	struct dentry *_dentry = nd->path.dentry;
+	struct inode *_inode = READ_ONCE(_dentry->d_inode);
+	if (!d_can_lookup(_dentry) || !_inode || !S_ISDIR(_inode->i_mode)) {
+		spin_lock(&_dentry->d_lock);
+		VFS_BUG_ON_INODE(d_can_lookup(_dentry) && !S_ISDIR(_dentry->d_inode->i_mode), _dentry->d_inode);
+		spin_unlock(&_dentry->d_lock);
+	}
+	
 	/* At this point we know we have a real path component. */
 	for(;;) {
 		struct mnt_idmap *idmap;

