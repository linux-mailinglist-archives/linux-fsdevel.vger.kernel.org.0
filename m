Return-Path: <linux-fsdevel+bounces-72646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C35CFF0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 18:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02AAA3012CCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3EA3933E4;
	Wed,  7 Jan 2026 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgf62Zsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1038A733
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800053; cv=none; b=f2kVdLn/aZFixqEYcOqmr0HmNTRp08G+0rVdd39yTiB6akypFldSLPlMqVcZaaY2OIn+GEyFqPyAp0AOutLzxwksCzhp+U0Ae5M9ZrzLB49LVprKdVwiQrie0xwk8Q6VxpPveSlIGONPf6HAijRgs57zBYjdfGWcYhSMscxVmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800053; c=relaxed/simple;
	bh=4TXKGjJAeQJwDyMsPwSGTtB9EZ4t0ayfW9/mqhAX0Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4rhYC/b+HENJ9sYcKS0s/Sfdio2E2k6o9lNhw8hT4mIn0vwD3yHfAubVTorD21El4wyDVWK/17w6DnCPXFzZXhjPXH5Q0cvQ5e2qrs5ZTx6ODS1C4EzZkkmutvZnEb1Y+egUyfjDruUFuChUnsh+YZ2pLTeOkEF+x9r0aQqoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgf62Zsk; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-450b5338459so1353447b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800050; x=1768404850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsoizNZgLZaDBPInQieK4jd0iMDgMqPyINA++t0nMgM=;
        b=Cgf62ZskAjdt/2L9b76VksAj77KbHek0naYG1vY1XQe23J4K38Nz1m/K740Rq7OlVo
         zLrwDRz5pGtWlCx667y+8EAUB273ZdeuzKrbxsBY+oNeTvu0SY49seTPDl4AvCkc8QPB
         uVImzIVQC82a6q7azDL99a9d/fyPNfahq1bHxWIqZ5uJEJhv9t/1KtKG/fEgSR2DBKbI
         Zb6q4dOJcfuXVbsGmRwaBLvw0jmpHd/yl3zjhn96IJqrWRWoY6C8HOTfAMH/wye1Rhb7
         NUlMbF9S8UQ3rFA1t0Y2ei35zezVqIdTn9oGDJu8+NiTbR7w+V0CavvAqeizpWdW2KCX
         SePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800050; x=1768404850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsoizNZgLZaDBPInQieK4jd0iMDgMqPyINA++t0nMgM=;
        b=uaZsSPpYxlesiY0IbQCmygb3O0nDhZvNmsQXQy9WAHpI09y787u1kXnsP8d3WJQ77o
         A5d65ZEPKL30N4jDwdKaKgMKdY0o1Aoz7jUntEBTPo/0xpJA1G4XTvwnlfHQCjp/0ZrZ
         VeRgal4I/Yskvr2ZOf97UeosUDX+EXNTBFcoUiD4lb7dzKn11YhQYZlZ4GMRguXjRzsp
         NjCMQGhxIcfN2c/1QySYDQtznobJtDBI1CIHVfw4jhxwwDDUDUiIlIZmW2vlM21ZEz8W
         SHMOFnnj5Uy54yfsmFjdj11qM7YvHfMyIhcgZx2ADG6bLgVXs5p5UIG2RcHQ8KAIeUG3
         DCVA==
X-Forwarded-Encrypted: i=1; AJvYcCVt7Id0moJnny19hjJAvfyocEqnESDQ8YG5KfEXl1VVWohlxBwo/m4gI07Yx0YJW6NWoQpdsWqE429lyQ0Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqHjJa5PuwB/tkYrhlMKLuN3l6ERWm6liKNo/gHAYu+eqFRqQ
	bpHgyMxX1xp5c5e0d16sUuxBfsWbhhNBmS0gYSLHp+Q+DR43d0BSMJcu
X-Gm-Gg: AY/fxX7VfAcNm9oSoKqd4Jl4Ia3IpByf+bZyOa3UnNEQpvTuiXr29L+AOect1oLrfRa
	GCpnc135R3laKtx2KjYyuyZglIkB3xuZHBiaeohRDeRFCWJSzbx+s/6euvcRcKTO5GpkRBTxRN2
	V2s4CX3vJ65i5WHdKkPLkCXDZfrUIIvj8rZ1Xu7yD2tim52Xdj6M2RBJkbppfP3Mt62E9j53Q26
	xww+K9Kt0U/OyAr88YqDh2+vVrhWtz0j9fjNaUGHMOtZVGCeNtn6FNJ8G/S1doujGwkIiMaJbkL
	DA4xv/QUmaY+3zvunaJk6+KbjrBlTv1p7eU8LHquww3QjVtz3BgkpWqCwX4UecBC74B9V9Lk+D0
	6ofjmpFZOXQNXaPw2nML1GNyVwZI7JgtSESkCytxc+QbRMHAgLZPj74o+2KhoutD/00C9v8xUcN
	8L9/Hg3vlquNyJbzIInH+X+B4Ys+QJn4iNopp1dCiBrQBwmEikKbYVPAY=
X-Google-Smtp-Source: AGHT+IFO/ZLxuqaj17abyw10+8CVi9iLvz7AXlLgZerskMOrQo6BFT5caxK0XQr+JNLPJZbm/V9Mbw==
X-Received: by 2002:a05:6808:1786:b0:44f:f747:f9f with SMTP id 5614622812f47-45a6be3820fmr1144818b6e.36.1767800050216;
        Wed, 07 Jan 2026 07:34:10 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:09 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 10/21] famfs_fuse: Kconfig
Date: Wed,  7 Jan 2026 09:33:19 -0600
Message-ID: <20260107153332.64727-11-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add FUSE_FAMFS_DAX config parameter, to control compilation of famfs
within fuse.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 3a4ae632c94a..3b6d3121fe40 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -76,3 +76,17 @@ config FUSE_IO_URING
 
 	  If you want to allow fuse server/client communication through io-uring,
 	  answer Y
+
+config FUSE_FAMFS_DAX
+	bool "FUSE support for fs-dax filesystems backed by devdax"
+	depends on FUSE_FS
+	depends on DEV_DAX
+	default FUSE_FS
+	select DEV_DAX_FS
+	help
+	  This enables the fabric-attached memory file system (famfs),
+	  which enables formatting devdax memory as a file system. Famfs
+	  is primarily intended for scale-out shared access to
+	  disaggregated memory.
+
+	  To enable famfs or other fuse/fs-dax file systems, answer Y
-- 
2.49.0


