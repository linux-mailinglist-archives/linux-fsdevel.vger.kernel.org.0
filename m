Return-Path: <linux-fsdevel+bounces-68997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD0C6AFE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F3214F1519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26021B9C9;
	Tue, 18 Nov 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsIroKa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381C36C0CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486854; cv=none; b=NrRolQ8jM0+C6IuZ/+10UHNjroQvycTVY7JxDAsFsSq8SHU502xQWkQjBNUT5LT6t4KuS5e7Hh+dMHP7CyRuT3itHq5on9s5/C+W9oKHTgvqYfaWW3bycHHKp/wNdd8IL4VhM4XdGgZCEJFU4FguMu4oTncBIWQHZplxEgCs2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486854; c=relaxed/simple;
	bh=7KAJHaucmzr2KSWD/RzRx3vu/nMq7h6SRh+D1lHndEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsTvqrbJj4oyPXnCaOEgpt0/kRuB25NJJJVXTe/dsltJQPi8U72m0VTvd/rkwyocWDMrU9Xh/2Hx4P+KSTiXeUb2Uww4Jz9XzGalpsMeNk4pN6pm+Vpp164VjXpLCLBPWn9WTCFdd/wgOkZbSFNp89GVYpE3hqyofD8+Txo6LME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsIroKa+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779b49d724so3815345e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 09:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763486850; x=1764091650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekVUjgKbtkArT9PPsSfxvr4Ab7eAnGY1uh3uSoRQalI=;
        b=NsIroKa+y5+G/aqu1zi6AB38X8/78XrvvBY+0fWNcYY5urJAirafFN0vdpRxrlrkQn
         mvWOgHKjcWSa0y6Do7JeDoqgA53KEEVrI8s7Tv1eF8rp3DM5Zhu/GhmcAYp3rzpd1cLj
         Mh+iTFjqH1IU2HI3JVC6DsqiOgB1/k6YdzrTI3zr4zlXl5nyHAw8Fet3mH+WakFHgnPF
         2ldsCvdgGkCGcVcPduHXrRCwF7aDEaIOxAwz1cQ5gFaAI/QmhdD2sI2X0kk2gC1IVgBh
         ZnpjAtmNeNHMCAPP1VAz6IiRhqSSViUCKGUbRe01qv1k/tdBBQGYzaSA13tf8Dhj4/7o
         DXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763486850; x=1764091650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekVUjgKbtkArT9PPsSfxvr4Ab7eAnGY1uh3uSoRQalI=;
        b=lwjoP6XaNQ7w/lbOI1tmb4ZJhI8/v1yJfP8WExwz25W/U8Q/WObyed0KOuzo4uVQkQ
         figRpO/YZORNez+PF78rSsjOKW1zNmiQiwSebvt189Ku+OJsXOtUBLjq1aAoBIPmgafr
         PpkTtXPnJhWGBVfUlBtLrQDwL99dVrQV5cs+evm4aqW7TYth8Pe5TLL1XELXDYbfd3mE
         FLtUBOieLMvownBL+FqB7v3RnahyVmxvmV1wwcDRM1Cb9NPdGZLAiTZ3EzHbmoHT58dG
         RXb2Don8hBVjvtqdEJImWPkH9EPQU/wDwx59fAMk3Q5DrUvc3zYQS+HmfHCpUZ6gWAlY
         q9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF6cLHnpLCB8ae+N3E3PJWzyGDYzJ7VIM9DtevlgnY2L9kAhmGSFz2Fwr3BcrdqHBZJrCtQ1KWqBKtUgVK@vger.kernel.org
X-Gm-Message-State: AOJu0YyI6V3G2hRJztt6JagVmpoVWbzbL83QTaFjWgzqjWxtUp97RcXx
	+T4sKlZhCfLLcO4CMy2LkfnNTE7jsivRymWO1coDeNdBBnMDSYXBUMv4
X-Gm-Gg: ASbGncs0lpNZEHGXuK++Nnlm9fUhfMluBZusJ4pP4fSAkjslsKUPp+Bpfm8U31FbLOh
	imLCIoauTXoh7a5q3wGx6qd9+QYs3+fHwLwsIFXXbjAcKHmvDjKsRJnhzjfVrwWJDTNwRa6IZ08
	JFNpW18oL8lsAKRx+SYo20mKL9eUCFEP2FK0Y5OgZP0hspLTpEenCmpdtMNca/lST4SMJPnBFg7
	VYdRpP5y3RQoBtQDqM2I7yjEul9Xw4IhS/Net7T7hwjHpYorgy0SAMMD9xC8z32/VlGuOa5jDTP
	Cca0eeIXubs67V29dIFmuvUoBYGNSwH2aHepvw4ssbN8sYh2Zqohg8mpzI1SzTqKZCgpxfUgd2F
	/bhUgYm6KSYKLTNCC55iwqeX466GNgiWwyFp/rmhlTxjSGLn/a9ZQaJxDrqwCL4br4t0xzytlmf
	Ukb3Xzo15ye0ekTA==
X-Google-Smtp-Source: AGHT+IHrQctkzo7habYnuQPZpAYorsefys/0nx6p99wB0XARQXvDWuu/ORPVGLomOanVMaCrRzqvkw==
X-Received: by 2002:a05:600c:4ec7:b0:477:9fa8:bc99 with SMTP id 5b1f17b1804b1-477a9c2aa35mr16817505e9.4.1763486850088;
        Tue, 18 Nov 2025 09:27:30 -0800 (PST)
Received: from bhk ([165.50.73.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d198a0sm22658835e9.1.2025.11.18.09.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:27:29 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: 
Date: Tue, 18 Nov 2025 19:27:06 +0100
Message-ID: <20251118182710.51972-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <69155e34.050a0220.3565dc.0019.GAE@google.com>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..46cdff89fb00 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -431,10 +431,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfs_kill_sb(struct super_block *sb)
+{
+	generic_shutdown_super(sb);
+	hfs_mdb_put(sb);
+	if (sb->s_bdev) {
+		sync_blockdev(sb->s_bdev);
+		bdev_fput(sb->s_bdev_file);
+	}
+
+}
+
 static struct file_system_type hfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfs",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfs_init_fs_context,
 };
-- 
2.52.0


