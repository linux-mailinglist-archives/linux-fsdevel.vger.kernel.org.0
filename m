Return-Path: <linux-fsdevel+bounces-73851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F040CD21C1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 00:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71222300B9E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CD3563F4;
	Wed, 14 Jan 2026 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL5Ia4H1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494538E5D8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433197; cv=none; b=h38634RquXH/2oouS6jQ6oln/vIHw/uaLOl9X1NI5YlIgtb4objlmIXNRvi05CSmhtbiwu7D1djyO4vNflhawyKpBeDN7GMY1s8+++b4pf1hAs7P6RTE7LLRZoqkLI8NRzFelqjfu8I40pkKyfNTGc/O7pQruVGSTiPwRJ8PUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433197; c=relaxed/simple;
	bh=EHMwJPD2Vt6csWKDxVM2bpGH+6rPVOBI0T+ZdejS8PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/drOpJafdjJ3ZXnAIqqXkGMeOGXNv2RaHByyckgtr/pCPrXOPWS4KaTjuXA6yQPyMMVSs9b9S9uXNASibceqkjJjA+8RIZ2SyPfAYp8R/3lLSHDioyH1FvrP4lERXyX50mSclgcFd8YA1dHJ9wH2kOAJA95AAq9+3XGLYwLRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL5Ia4H1; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so626148c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 15:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768433184; x=1769037984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIEMUdHe6tYyV62gaPFR8QpHnKQnU3PaCpWSzsgNDe8=;
        b=WL5Ia4H1xvnSRBomcg/Q+pw6GDIYyz/ajvnymi7Vl40JU1fGac4GniuTfDMVs8NgrJ
         AFS4MyvYIuyWmg/isDF/fp0jZ/K1tyEPAu5eWPyA4wizvEoNPkMbx9MZW5YA3u0+HExy
         IgyzkqQNuUNDUywj30p0QMvOu2Z7RvCJfNR0/KXEGx0T86VYBOK7PTHV8rQ0UzJObr6d
         q6aO0xSDIbyAgcjjfUT33NIHcE4/gUoNudCu9Vv4OjIVbDRgJAOYfS7tg5OUfvQmZ5hy
         dql7bIoMcOu0mZ/B5Q4I2IGZGGIdVUgFkuXMn+LgVQTvFRPId1k5vE/nrKDOHZkGCgH8
         u+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768433184; x=1769037984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIEMUdHe6tYyV62gaPFR8QpHnKQnU3PaCpWSzsgNDe8=;
        b=NYumU5VpkIaGRRDnyk1MhZ3NJJYINGoSRgHMRNplQ7WPeQPH39uWQnd7kG+m1nz/Hj
         MoeIbcDzHPj0T21csCMDlpaQOTv99lgEJek5kdXNLCaVs1zIHQmM1TvEbqXl458QOBai
         uvo0aQ2nhb0Dn3U+71YI8sdzPWX6ToxheFSbefDjWifmB+Y5Fs9CydYw/YoJvBQj+Nu2
         ifF1gwxjhbyFtdaN8jR6HDGKF5JPsoq9QJ4A31Bv4OE9DLFGU9ttX95DSrP3naNKz3iZ
         dfrlyIYuuaKLyLWOGgM33dm7RAcMe1DUbU3ZRMR2Fp09e1rp5lRrdhou4bbRcMAot6Gs
         k+VA==
X-Forwarded-Encrypted: i=1; AJvYcCWtRrzJx6OjvAzqMeITdDb3/uNY5TXa3U02FNq76I5RHDPTse+XwxvxI1ji/HT48Q7/a6TPPLYVkhFpyz81@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEtVdd4M8WvTCejL575+2fTGgLp3amUI36BSm9HmVWl0ViFvr
	zYj3N103Yo6eFC51RBgJecTD802nSGY+YslLnqf6q0Jo/Mmkxa7k2CuA+lU6fw==
X-Gm-Gg: AY/fxX5KwEf5+W3cZoSZh+ijaaSQSXkXdJ3KciSBRt5RrNXHpB/9TyeERPxRIMl6Wwa
	JppHhnB6Ci2OuqyxWjOIbI8GqZGee8BoZleofugELzXb/ZDqW+nZj/AT+hV5IlZQTNDWWkOQmkU
	YlQPMrBTQQYp3zDUfaRoPSlQrdWUOJEjfyz8a5Hn0qZPbygSRv9ZJk+edjs6tmqCYigHkyc4vEr
	wIy/hvRNVwU/JDAtg+5brv7lfeMlXZA7A3BG3recZdGIaEhLw+6HOA/6uEVomBDb/SiqTk/+fEO
	0MD+EZngq7kDm8jxzU7dAz9JP4Cl421jqB04qXj+ep/vUMY9MnsXQymNGYDkXEDo23wxC8Boizu
	KjFbx5NKAnv3+mfjOy0iMedpERoCPd5i2nN4rqzx3mHdodP3hAaLk/GNzoN6VCieFiwItYQ6REw
	fyiHEaH30UR5/GKmA1V/xJrFwehjqVsuj4TN95hv00CvaQBSr5ro12gTw=
X-Received: by 2002:a05:6871:7817:b0:3e0:9188:8f10 with SMTP id 586e51a60fabf-40406c5d030mr2965148fac.0.1768427121522;
        Wed, 14 Jan 2026 13:45:21 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de55ffsm17644773fac.2.2026.01.14.13.45.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:45:21 -0800 (PST)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 0/2] ndctl: Add daxctl support for the new "famfs" mode of devdax
Date: Wed, 14 Jan 2026 15:45:17 -0600
Message-ID: <20260114214519.29999-1-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114153133.29420.compound@groves.net>
References: <20260114153133.29420.compound@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No change since V1 - reposting as v2 to keep this with the related
kernel (dax and fuse) patches and libfuse patches.

This short series adds support and tests to daxctl for famfs[1]. The
famfs kernel patch series, under the same "compound cover" as this
series, adds a new 'fsdev_dax' driver for devdax. When that driver
is bound (instead of device_dax), the device is in 'famfs' mode rather
than 'devdax' mode.

References

[1] - https://famfs.org


John Groves (2):
  daxctl: Add support for famfs mode
  Add test/daxctl-famfs.sh to test famfs mode transitions:

 daxctl/device.c                | 126 ++++++++++++++--
 daxctl/json.c                  |   6 +-
 daxctl/lib/libdaxctl-private.h |   2 +
 daxctl/lib/libdaxctl.c         |  77 ++++++++++
 daxctl/lib/libdaxctl.sym       |   7 +
 daxctl/libdaxctl.h             |   3 +
 test/daxctl-famfs.sh           | 253 +++++++++++++++++++++++++++++++++
 test/meson.build               |   2 +
 8 files changed, 465 insertions(+), 11 deletions(-)
 create mode 100755 test/daxctl-famfs.sh


base-commit: 4f7a1c63b3305c97013d3c46daa6c0f76feff10d
-- 
2.49.0


