Return-Path: <linux-fsdevel+bounces-16728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2721B8A1E24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBFB28B083
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F938FBC;
	Thu, 11 Apr 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O91Vl//U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F238388
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857874; cv=none; b=JF1sX87laZGyH7rKaYQ9y/bxrvr3ujafBEGNweYqAKgZU8Lmh8pIHoFk9ACRlkVuynB/DkmbVFecOjrDr+zU1BKMkLxaMWsrtNiUG9rEAVitZRvvg7WZYsQwPOfZDFm4w5hR5giVrBqIBYYwNGsOK2WqbE7Wlfr9Oprx19Dak5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857874; c=relaxed/simple;
	bh=SqGrZDc70r7mD0H862nB0ZAZxCkUeVw5p1Wxu4Sq6ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBgx1dy7oXzmAesr94/YW7Qf/EbcK+wW343AVOOsFMinpaR6g3JDhNw4jRcXqSTpSAsTGqf9hIKPe0dhJ5xipyDZAu64t2ifgLHV3iejTEWHy4riADvyei3Bm4XJah6/UnI4tgADgrdLeubbiPIhA8V5CV4AVS9ki6B6PiX+GKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O91Vl//U; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516cdb21b34so134528e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712857870; x=1713462670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CKNWZWvf+BbBlRIjEGoOxmGXH0/50SHsxsQ19c/vz6o=;
        b=O91Vl//UcObvtQtouZ5O30ns7rB+Hnn+uoki9cuFdDF/4WAy+bJFETEe7GgM+S6Evn
         ClocLCQHljUcW6qlzPa8mAVtFPLgFy2ePUR8glfVpXw7LVV0ATVheMgV00nnIzzSNB7S
         UVnRXpLWZ0bSthMAnLpNn6O0Kl9D4xdxObIqFgKavKDK66AXcpwlzZFNq9illlms5Y+t
         FAO/KvMFcntOZH+uR+P6+kuI2U5QafRqOvviDh6AzwvICOlwS4r4Jpfjqxqjm446NnMX
         9RaQd0Rmna090pp2DSlKggj1/lWOz3b3g3vdjMkf43/5vfvIMzDBhzx/jVla24Zrb76/
         T2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712857870; x=1713462670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKNWZWvf+BbBlRIjEGoOxmGXH0/50SHsxsQ19c/vz6o=;
        b=AOKs2VGwv7RS0P25DhPDh0HNXzBcVq8xi9dkqTxbT7mvNot2q7akB0Bg2bHgzKjm1O
         Gg4KTKOBRgWSlVj/fVb/ypzB/8R/9uZkf7GuE+rHSH7Wyo8Glunqa0NBU78PAiId9Bps
         O3zrV4PkyddL/l0IML4n+anBDj1VaHkonR9CQvTdqv0wC5oPl6SfTHFWfW7svQHzbye5
         XqeRFORJltg8gVrqIDy4Xx06QFS5wt1wikth5FPJ6yuy0iBrMfFO9+CDlzgmWQkm038+
         4Up66zXX3wZyK3LMmoIIW1CIxjia8DPbXmFn8m8dglM06jRUT7oQrHL4KIH4CNWNJ0aE
         ZGmg==
X-Forwarded-Encrypted: i=1; AJvYcCWfWobXA/7n3h8mO14Q/yXOKIgYT2I918zvg/4otS2mTaZhr9fgjMS54h4xr4QHuz/XqxtmlaER4psfSpYHFjdfnDLaJQyWiJ52yXMKyA==
X-Gm-Message-State: AOJu0YyRLiocofaxSiM0G8AO0yoeHBam+ZuFZpLVLBdgFhgbrL9l5Idv
	BxCW+rWkwtHjLTKO07RX/lSMFDhSOX9h5dh8kjpaeDUIRZt4VtQ=
X-Google-Smtp-Source: AGHT+IFZFy4eDYB9HPnwElgKKkj2p+TbDhGsIFznAGcIVpZuAk2isOs1MgTDeSl+4ZbJNANA7+Ckqw==
X-Received: by 2002:a19:6b15:0:b0:518:69c5:c027 with SMTP id d21-20020a196b15000000b0051869c5c027mr260838lfa.18.1712857870314;
        Thu, 11 Apr 2024 10:51:10 -0700 (PDT)
Received: from p183 ([46.53.252.51])
        by smtp.gmail.com with ESMTPSA id dt6-20020a170907728600b00a4e26377bf1sm960511ejc.175.2024.04.11.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 10:51:09 -0700 (PDT)
Date: Thu, 11 Apr 2024 20:51:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND] vfs, swap: compile out IS_SWAPFILE() on swapless
 configs
Message-ID: <2391c7f5-0f83-4188-ae56-4ec7ccbf2576@p183>
References: <39a1479a-054a-4cb9-92c8-e9a2ed77c9f0@p183>
 <20240411-goldbarren-angenehm-2239655a3f79@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411-goldbarren-angenehm-2239655a3f79@brauner>

No swap support -- no swapfiles possible.

Signed-off-by: Alexey Dobriyan (Yandex) <adobriyan@gmail.com>
---

 include/linux/fs.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2253,7 +2253,13 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
+
+#ifdef CONFIG_SWAP
 #define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
+#else
+#define IS_SWAPFILE(inode)	((void)(inode), 0U)
+#endif
+
 #define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
 #define IS_IMA(inode)		((inode)->i_flags & S_IMA)
 #define IS_AUTOMOUNT(inode)	((inode)->i_flags & S_AUTOMOUNT)

