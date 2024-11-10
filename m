Return-Path: <linux-fsdevel+bounces-34163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F49C3427
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4111F216C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938E13A868;
	Sun, 10 Nov 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GhhF4bJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011F12BF02
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731261965; cv=none; b=NP1YwBYFEpEHbsc1EVBtL5fHz3P4Ec8IRX7kFIDqKxwDQpa7386r4K3j1UvxUr8VtWzts8g0fepKp0S8fN0vnVx6+T2qxEre1jDlE9XAFhm/vIZJwUZeHVsrR6AyVBMZCrQ4I30r2blmhBnASUboLcRRIoO8ePjKuPsqIr/QLek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731261965; c=relaxed/simple;
	bh=XwGC4KSTJ1voAqNyzsky7Rgyu744WErtSdkdvrA3ZAE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IaWMt3hJ6G3k7E7WOYUmoZGWwsrOPDcjNOwlmguTWcB9fKNUVOGI7LNQvNvzYsC48dZMrLM1LdjdVuKDC2XeI9q18PpQ7YrA2LOjhzl2iYDUMkRsOSvNQRk+srR7Grn9ggUIpd8Hgqwzz/tbqB+IJySgjpcO2n+BXCkMqkH98d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GhhF4bJq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AAI5Xe7022225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 13:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731261936; bh=hXDYJ+1LRmCbCIZx8cVeseKteiPATKs0qcxx3fJkx2E=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GhhF4bJqFaoEdxCl9oI++cIPRmi9Q05xnaRb5kPo2ALHQvfoA4qmmR4WmYuimWM6X
	 3bqaOtPeYNTislpA1exdd/VtXl+gqV8NOSi31OAKFf6v5M5RsNHvqi2wUeNtSu4k4O
	 YCl4uXieVHEDppXbxHaCkWcGMUHe7UoSXHut0iyEQXgwRk0tVu2lyE4VKzS4Ok/a3S
	 s0m70s1larXFaJny51s/vzDg3vIf+LuL2q1p5lUd/msAWwBjxKiGVimxRqZuA1cGEo
	 WnSjd1arae0zJ58B+lJ2mJv4595MRclKPo5PX86zewFQCoO7U4QV0X9YvTK59BaGNU
	 HyoNrU19vFR6Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 97FEE15C02BF; Sun, 10 Nov 2024 13:05:33 -0500 (EST)
Date: Sun, 10 Nov 2024 13:05:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        fstests@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org,
        Leah Rumancik <leah.rumancik@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: generic/645 failing on ext4, xfs (probably others) on all LTS kernels
Message-ID: <20241110180533.GA200429@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BCqnBw7vZwXXJmTO"
Content-Disposition: inline


--BCqnBw7vZwXXJmTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The test generic/645 is failing on (at least) 6.6, 6.1, 5.15 LTS
kernels.

This fix is apparently commit dacfd001eaf2 ("fs/mnt_idmapping.c:
Return -EINVAL when no map is written"), but in order to take this
patch, it looks like we need to backport the 4 patch series
"mnt_idmapping: decouple from namespaces"[1] (and possibly others; I
haven't tried yet).

[1] https://lore.kernel.org/all/20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org/

This looks fairly involved so the questions I have are:

(1) Should we request this patch series plus commit dacfd001eaf2 into
the stable kernels --- or should I just add a versioned excludes[2]
and just skip generic/645 from all kernels older than Linux 6.9 if we
think it's too involved and/or risky to backport these id mapping
changes?

(2) How much do we care that generic/645 is failing on LTS kernels?
Are user/applications going to notice or care?

Thanks,

					- Ted

[2] Like this:

diff --git a/test-appliance/files/root/fs/global_exclude b/test-appliance/files/root/fs/global_exclude
index d7acf89f..42902152 100644
--- a/test-appliance/files/root/fs/global_exclude
+++ b/test-appliance/files/root/fs/global_exclude
@@ -30,6 +30,14 @@ generic/484
 generic/554
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,9,0)
+// This test failure is fixed by commit dacfd001eaf2
+// ("fs/mnt_idmapping.c: Return -EINVAL when no map is written"),
+// but it's too involved to backport it and its dependencies to
+// the LTS kernels.
+generic/645
+#endif
+
 #ifndef IS_DAX_CONFIG
 // Unless we are testing the dax config, we can exclude all dax tests
 -g dax

--BCqnBw7vZwXXJmTO
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <tytso@mit.edu>
Envelope-to: mit@thunk.org
Delivery-date: Sun, 10 Nov 2024 15:12:24 +0000
Received: from exchange-forwarding-2.mit.edu ([18.9.21.22])
	by imap.thunk.org with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <tytso@mit.edu>)
	id 1tA9bz-0004uy-LV
	for mit@thunk.org; Sun, 10 Nov 2024 15:12:24 +0000
Received: from mailhub-dmz-4.mit.edu (MAILHUB-DMZ-4.MIT.EDU [18.7.62.38])
        by exchange-forwarding-2.mit.edu (8.14.7/8.12.4) with ESMTP id 4AAFCIbh002718
        for <tytso@EXCHANGE-FORWARDING.MIT.EDU>; Sun, 10 Nov 2024 10:12:20 -0500
Authentication-Results: mit.edu; dmarc=none (p=none dis=none) header.from=thunk.org
Authentication-Results: mit.edu; arc=pass smtp.remote-ip=18.7.62.38
ARC-Seal: i=4; a=rsa-sha256; d=mit.edu; s=arc; t=1731251540; cv=pass; b=r7yctp1efB2F7cgvyLkEVtL3U+N27il4Zgnrgj+YXNtreYtEPyQ9liYOjoTL5NSsaiViXSgqXh6U3drdEOvMcML/gK2LJzuwnupLGwO+iyQey5tRDAwupRh393Lknm3JjC3mKeEvQ732EgF0dS9ZHK1HTRIH4ar2WKx91F1a79Wqm6E6vVewNS6VeOpPKF3egL6INm/ulgDaP0k5WxIuSSRAsXFkbG3G0cEsrdCNsgFB1zoTV2/KC0KX4fVgBACRbblUtg6doON1uba3GEPyaFLYQVklhLiWGEwInZTW9ccmRhy6Il/XjQcpd9Yt604ZGOrzFiQqDCQNWJWAZX1qEQ==
ARC-Message-Signature: i=4; a=rsa-sha256; d=mit.edu; s=arc; t=1731251540;
	c=relaxed/relaxed; bh=9Rj6mi0Kv4LOwjtvDDjhdGOZgsMtLBMs6nouCZPM87E=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject; b=l3QIvSghFV/VrqdfNgkGo9ZYxwHwZkAyJtspNmJSFiHDVx6kNOUBeUsFoPgcgZmA7SzZXqwVgJprO3Ecm3JJqKQjm2UkvAa9aePihTJ4BMwFaAmb41cT8Y/qEZyQ8TvJ8khCc/7iENzDK1aYu12uThi+2bpUBwQ178eCo1qD8MDNNZI6amksTc7K0xhPqnqDLMFnJ0el2POZpqhnMeV1SvUDnpWRG9J7f6Y2soE5pEniuSkJK1epS18JpwniKaHACd+3/UvfOT2XZ+ZhfB3tktqmbH2ZlKoeO2vKltX09PsA5t5TAmDEvSKXAY7XQcO3pKD5SQ82H1u3o0iLt36NOw==
ARC-Authentication-Results: i=4; mit.edu; dkim=pass (1024-bit key; unprotected) header.d=sendgrid.me header.i=@sendgrid.me header.a=rsa-sha256 header.s=smtpapi header.b=DAprmSZX
Authentication-Results: mit.edu;
	dkim=pass (1024-bit key; unprotected) header.d=sendgrid.me header.i=@sendgrid.me header.a=rsa-sha256 header.s=smtpapi header.b=DAprmSZX
Received: from mailhub-dmz-4.mit.edu (mailhub-dmz-4.mit.edu [127.0.0.1])
	by mailhub-dmz-4.mit.edu (8.14.7/8.9.2) with ESMTP id 4AAFCIRW010355
	for <tytso@exchange-forwarding.mit.edu>; Sun, 10 Nov 2024 10:12:18 -0500
Received: (from mdefang@localhost)
	by mailhub-dmz-4.mit.edu (8.14.7/8.13.8/Submit) id 4AAFCDIq010310
	for tytso@exchange-forwarding.mit.edu; Sun, 10 Nov 2024 10:12:13 -0500
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by MAILHUB-DMZ-4.MIT.EDU (envelope-sender <theodore.tso+caf_=tytso=mit.edu@gmail.com>) (MIMEDefang) with ESMTP id 4AAFCB1I010308
	for <tytso@mit.edu>; Sun, 10 Nov 2024 10:12:13 -0500
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=p3WM6srk0y6jQgQGDRWOtKbtgAdMY3Si3EE+cM8MIE1oBnD6q6Ms5d5lhi+dA8dOut+2f4ltsAL2okTFE7m+ffhM25iZv+LdlJgWOEDphrxcXXLWZmsqNazXhrGCFmQh4d9EhXenKKgKZNpFvCxvcpBOEx+HnZfWwaPLmAoFjxBIeRcErwbsuIH3VopamtDJHV+TjYqdMvhOmIIKTmHuwUf2Ss4I8VNXicB4uYybmLadUIY8dL7R8BEo50hjAZQT8XR2ZM7Jc2BCB/L8b+m5lCF0Nko3EIauT0Ii7YtNrBmS3Bhuz+j9zLu1TuauFZLIppYfVQPdAxIn3uECF6zmpw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rj6mi0Kv4LOwjtvDDjhdGOZgsMtLBMs6nouCZPM87E=;
 b=RxF26jkx+anLJZWsMEm9XJay6uqmkJb2cgo7TzipqEp9z2QJystpcYD1QelntEeaRuL7SAtniystMFu1FODOYn+u94ZSCDSAgKE3cq5Byzy0Rmr8vcAoq3XUGFlGy7RNybWgI92I3cJjJ1dJ/xnIo+HmbW6PhDbbp7ES75juCn0g76ZagzYBYkZxlc5nCeUOqjStvpLTP/r3LF+7PqRO9EAEKWMOyNBvW6sJxcE4MVLDEQxpEBfgF0chM16S3NN/lqCeg3dXHODjUF2qIQOMg5XA53lZzG0NS9nR/59dJANrc/q8KOGoRzONfK5TxiRoAAUHGFB9ZFpxYB3PCDkscQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 209.85.215.175) smtp.rcpttodomain=mit.edu smtp.mailfrom=gmail.com; dmarc=none
 action=none header.from=thunk.org; dkim=pass (signature was verified)
 header.d=sendgrid.me; arc=pass (0 oda=0 ltdi=1)
Received: from DM6PR02CA0134.namprd02.prod.outlook.com (2603:10b6:5:1b4::36)
 by MN0PR01MB7586.prod.exchangelabs.com (2603:10b6:208:371::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.13; Sun, 10 Nov 2024 15:12:09 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::3e) by DM6PR02CA0134.outlook.office365.com
 (2603:10b6:5:1b4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26 via Frontend
 Transport; Sun, 10 Nov 2024 15:12:08 +0000
Authentication-Results: spf=pass (sender IP is 209.85.215.175)
 smtp.mailfrom=gmail.com; dkim=pass (signature was verified)
 header.d=sendgrid.me;dmarc=none action=none
 header.from=thunk.org;compauth=pass reason=101
Received-SPF: Pass (protection.outlook.com: domain of gmail.com designates
 209.85.215.175 as permitted sender) receiver=protection.outlook.com;
 client-ip=209.85.215.175; helo=mail-pg1-f175.google.com; pr=C
Received: from mail-pg1-f175.google.com (209.85.215.175) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.14
 via Frontend Transport; Sun, 10 Nov 2024 15:12:08 +0000
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f43259d220so1585845a12.3
        for <tytso@mit.edu>; Sun, 10 Nov 2024 07:12:08 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; t=1731251528; cv=pass;
        d=google.com; s=arc-20240605;
        b=ZxsgVk0XzkkheERH4HXZWgY6fRs+khVkE3O8qes04o7vIDgiI2fHBBjX0Xv5cjqYuV
         nw3fT/d9VNyYBtrHX4q5nj7xLEcC332ULVB5Hgw4RGaoaQiY3R3EpBTOChB8tDVlDK/C
         oM84zsQRJVSBCm8pvVo8qatMefMeSNzuYFE6T4yW0WIHbsgoF0Yyu7DA5z8xv6Hpe5b2
         iY1HpdOViSVzpbtNUk/pQ8bnRJhZ3tGMsiYl78yQI5msqxb+SahqqpHecD0UsNqs1FJP
         +qLBRqhtzUl2yOudfVULV9Gl75jqf8QrK3LhMriUf4sz60TzAMKBSgOvnNpuaMCeP2Ph
         qWtw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:mime-version:from:date
         :content-transfer-encoding:dkim-signature:delivered-to;
        bh=9Rj6mi0Kv4LOwjtvDDjhdGOZgsMtLBMs6nouCZPM87E=;
        fh=Ep551lSshczXgDsVPoP73gflJ/f7LVyrwIMyTStbzL0=;
        b=c/KNl6DTcyrPYRuaZsh3zQb6ehHI6DIxRPOXFZipXMu4jHIGXNd1vb9QR53tb3+JbN
         OFHrmzhsPHK/arm/iBLvywVFg7n+WnDUvx5v3OLHVDzknYmQU+/IE/+4aNKtpO+KT0Io
         9kZuGVAAvNcKXeHWblVmoPuXGMNc6/XgkgLWDlZKYhxU9IOeEQDYzlvmOSPmeCa068IY
         ieTC17Bl993twLPbxTYmyRgqH/9ykYmvV5MMDbJWw7Y/1KhZTlOXwyG7Lq1EBe8r/Ton
         etYwN5FLUS8m7sOnSn0j/mT6fCryburiF9YVPHOVrPLhVblUr1KYDP01DtbWp6LhX1Ww
         bQnQ==;
        darn=mit.edu
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@sendgrid.me header.s=smtpapi header.b=DAprmSZX;
       spf=pass (google.com: domain of bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net designates 149.72.120.130 as permitted sender) smtp.mailfrom="bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net"
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731251528; x=1731856328;
        h=to:subject:message-id:mime-version:from:date
         :content-transfer-encoding:dkim-signature:delivered-to
         :x-forwarded-for:x-forwarded-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Rj6mi0Kv4LOwjtvDDjhdGOZgsMtLBMs6nouCZPM87E=;
        b=GNn7x+Bj8Y2v6+5edrlsmxKlG0EEmEuaTHUFYHQzpCc+c/UrAx7VaAY3ayqv+zGLTc
         V/SPiMxsOW8CK9MXC+eL3qSib0s+b3ThfixrepS/mi/fqKePTkD6L6w0AGobuDtrHt9m
         5bTFyi4YcPL2eSmnrIuleekEys65AsGDTMP+4sIzxhIMqsZb652fWqdI1sa9E+mwRvWU
         jqmRvePKYOCtXmWair5ejF9jHtSd7CFPrLkFY30md3vqz9zY4gfDnF8Nw4PWCnikCDA0
         bubqLl4rkmJhseF9HbunXLdrxFoZtkFhNp4uJ41PHXsBUjLPSbAIV75GA7Gr5CG77THM
         w9lg==
X-Forwarded-Encrypted: i=2; AJvYcCUPawI0+p2YiYExRJAdKrXb+3cm4iaArq4X5Wdv8w+kGhxDwJEzhd00Yjdi0W1ZA5/cJ1AXLQ==@mit.edu
X-Gm-Message-State: AOJu0Yy9/eJ1GmLWZGuLBogMX8K8jc1luD6iSTenQ2aYnTtOAi1gn6iX
	XR+aZMbNYrUT05KL/fhPVW8NgxBxWtfNtpShsnbpbwTCut9BD6AKhqWGL/p3eVW9aBocMAEr2vU
	m+S1Rt72Td8LculdnCT0gB2PRXXz5Zt8Z5UMsNLsk8wNHliGj14Iv2iptuQ==
X-Received: by 2002:a17:90b:3847:b0:2e2:d17e:1ef7 with SMTP id 98e67ed59e1d1-2e9b16e265emr12611571a91.3.1731251527843;
        Sun, 10 Nov 2024 07:12:07 -0800 (PST)
X-Forwarded-To: tytso@mit.edu
X-Forwarded-For: theodore.tso@gmail.com tytso@mit.edu
Delivered-To: theodore.tso@gmail.com
Received: by 2002:a05:6a11:f5a9:b0:5b8:19a5:f5e3 with SMTP id ic41csp3634005pxc;
        Sun, 10 Nov 2024 07:12:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJQkYmB9GTwj15B1/1zwGBQT+0XCYAP2yV5Mb3/k+AiKvZEl5M4xlQ5xq6uker7//SSiQt
X-Received: by 2002:a05:6a00:6caa:b0:71e:427a:68de with SMTP id d2e1a72fcca58-72413382fe6mr13609517b3a.24.1731251525949;
        Sun, 10 Nov 2024 07:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1731251525; cv=none;
        d=google.com; s=arc-20240605;
        b=N/Yo8R/Hq5WkGAi8eRIDoj05U64tN3jtdQxDG5O3dpUKzrsKRMxrNMk1o9OSnce97K
         tOqoZ6kB6m9R/qAqoRrEOD5WNex0GPH5NiZCmWKM8oW+yIdOL+RkA0Wvz/6UvNRmJB1P
         /8agCKvEhKqq5WAPQm0Bsvbd9wWVGQl9CfWexuBzLJSC1RvnMfKKKGJmN6VQDuRw+ldV
         of6lf+yG8S0l1UxNdtbF6z6rmM4M7s4urAaSe2dZwwN9uN+uRUW839XDEs0o3/+B+2YI
         Q34DBOa7b2TLNo2RdridGkDowRTMWDQ1opZMGx9Yha1lXu7+9MMUpYYpM6zFr3BFNWYR
         raTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:mime-version:from:date
         :content-transfer-encoding:dkim-signature;
        bh=9Rj6mi0Kv4LOwjtvDDjhdGOZgsMtLBMs6nouCZPM87E=;
        fh=px3dClbshMynTO2CxTh7Q51Apyf1LkdTq7Ys9bYwEMU=;
        b=JRWROAKvtlrCjeVU2uMmIvddxQAEqj5f0Juiu+ua8ZfgWDah5/r2mNcRwohyFD4y50
         f0KndfrxT4tbVMyfU0l4N29Xd09oUOU+l6wxFlS0UyPHRg9xPqEC2eFu8hcrwexjktEO
         OPiFLeTsM4jcVUZYKo9JhES4l1J9ON+xINxdlLgjwhE0QCk7hwFxYL1ZbTfD7xnLk5lc
         g9IWIVcOUT7ILCZ/8To7t1Xg+4J/lagx8nlQ7H5B68Y2+wSlgZa6eDUQgKbBpQk4/BqE
         MaP0oPvaEkBoBUWV5wfyDxPWvlj3faSLrG/kxiDKsTArK+X6EuheX+qOAF6tGrcBYXID
         pozw==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sendgrid.me header.s=smtpapi header.b=DAprmSZX;
       spf=pass (google.com: domain of bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net designates 149.72.120.130 as permitted sender) smtp.mailfrom="bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net"
Received: from s.wrqvtvvn.outbound-mail.sendgrid.net (s.wrqvtvvn.outbound-mail.sendgrid.net. [149.72.120.130])
        by mx.google.com with ESMTPS id d2e1a72fcca58-724078a46c4si9962765b3a.120.2024.11.10.07.12.05
        for <theodore.tso@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 07:12:05 -0800 (PST)
Received-SPF: pass (google.com: domain of bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net designates 149.72.120.130 as permitted sender) client-ip=149.72.120.130;
Authentication-Results-Original: mx.google.com;       dkim=pass
 header.i=@sendgrid.me header.s=smtpapi header.b=DAprmSZX;       spf=pass
 (google.com: domain of
 bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net designates
 149.72.120.130 as permitted sender)
 smtp.mailfrom="bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.me;
	h=content-transfer-encoding:content-type:from:mime-version:subject:
	x-feedback-id:to:cc:content-type:from:subject:to;
	s=smtpapi; bh=9Rj6mi0Kv4LOwjtvDDjhdGOZgsMtLBMs6nouCZPM87E=;
	b=DAprmSZXC3bFtsHlVazWD5lLHW9OmYC0Hf1kNRM7wmwLOvUozlUmxKHRrYbLKofrD8tO
	gwQQIypI3qj7o6l3sHrly5ovMVj+vwSMMig/5TpVLGB462U1U5FiVzDlSVk3c0FFfU+GXJ
	gp3FxiL8u/QZgCcT/gn6C28I/EMHSc8/w=
Received: by recvd-55fc7fd858-h6r4k with SMTP id recvd-55fc7fd858-h6r4k-1-6730CD45-3
	2024-11-10 15:12:05.307994185 +0000 UTC m=+5087693.301092335
Received: from MTg5NjcyMA (unknown)
	by geopod-ismtpd-6 (SG) with HTTP
	id kF4Z6m8lS4qxluY2wPzMCA
	Sun, 10 Nov 2024 15:12:05.225 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Nov 2024 15:12:05 +0000 (UTC)
From: Xfstests Reporter <tytso@thunk.org>
Mime-Version: 1.0
Message-ID: <kF4Z6m8lS4qxluY2wPzMCA@geopod-ismtpd-6>
X-Feedback-ID: 1896720:SG
X-SG-EID: 
 =?us-ascii?Q?u001=2EMxrsaI44goA65Ct+PMRZBcKM0BzC3TC9StWRwUZI3HOdTi3WNqYQIyJQH?=
 =?us-ascii?Q?Z+rSac8HkLRwPK3n4b2hTuuRKBXKO+Ac7TToPQZ?=
 =?us-ascii?Q?fBZrzDx4fkm=2FD4ZV2Eo1eh=2FMk5Ry6aEmjyfAp1V?=
 =?us-ascii?Q?O=2FiIWRx4lI2w=2FzOYTuPd2TUi0kDk4GBcbdCiu4O?=
 =?us-ascii?Q?IXOhWE8qH1NtvYuJkqaG4HZZgwtNF51BeHF6pfp?=
 =?us-ascii?Q?LclPTHJGcvY5j0bpHSLTzN8fl=2FW+pAIU2AcpXrP?= =?us-ascii?Q?hFAK?=
To: theodore.tso@gmail.com
X-Entity-ID: u001.XCHHN99Ad702A07KJDcTSw==
X-EOPAttributedMessage: 0
X-EOPTenantAttributedMessage: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b:0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|MN0PR01MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbca6a1-4691-4890-b626-08dd019a0baf
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MIT-ForwardedCount: 1
X-Microsoft-Antispam: BCL:0;ARA:13230040|7093399012|29132699027|43022699015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1ZhQEdugqHH+uqyGEO6vbyUGpnMon0SwaBBCKM5Awo3Qj2PFPq7Rk6HxmzZF?=
 =?us-ascii?Q?8F3S0WfsRM33WRzd9Dz4capLi1nAeC3wUXdLAHrY1l6zSdSxX/aCiTWveseN?=
 =?us-ascii?Q?f0V366od7Hm0uMGFGNZ0XGD7wDAilOqcQEwrefsM3JYasrt2LFrXVclAag3X?=
 =?us-ascii?Q?oXoaJfIDJdq1NrmU1/SZYfl+4QXk0RDNs5S/FCEakexBG0SKXuIeqQFGVAu7?=
 =?us-ascii?Q?lihEyn8MNELGpKdYjSV0mrnMmXwXhs6aGdY4yeAG48Y0qW8Bk6bV+QUwOhHY?=
 =?us-ascii?Q?oVIPVaoqwiwg3U/Q8CciyBWikzQFigqE0scnLamw7EwnZbEkPFg+nUPYZbkN?=
 =?us-ascii?Q?Wzkdplxk0BPUDdxlh5sVZCyN7wazfTclsjHPIzE/tMB3aQaFloyAgpUBVSuA?=
 =?us-ascii?Q?fxN8kHlVh4vKy1VQj6E16TLsaEW+1YER+d9Iv2PjnOAW1hK+MLkD8i0xSp6v?=
 =?us-ascii?Q?pQ2i+GaUV/p0ed2Y2pjcxjMKZkv3rAd+aD9EbB5CL7clQ14WdSo7QheuPPMT?=
 =?us-ascii?Q?RhgJ747Jj3txzJvJCz4x7hBV+8srFD2f4B26WJP/eO+FQBQQchW7/UoUPYVn?=
 =?us-ascii?Q?wS5vYFWIA2KOjpqLGiHrLpt+MIMEfMC0sYf/8xELhUpx5ldRcV98EWVm5tpD?=
 =?us-ascii?Q?KGFyoAXAnedTcwBa6QhRLmtKM2f9nkZK4DUFmolpS06t/O05cdBYJ6pHXNZr?=
 =?us-ascii?Q?kYZ25eVjXSSi+IGoCodk2e0vPh0zXlbnOKPOs6h/3f6JZnMg6UKn1EHvw5t8?=
 =?us-ascii?Q?vGxeyEB1mSvQcEqrjSmCAuvmEIOUEWDXZNnc6aE6g8/Eh+NXQj8LFtTKAsT0?=
 =?us-ascii?Q?sw+h859L6Bh/sPB4EEfJVmTpkfDB9Uxo7IOxjByxGQ2me2PCHpQQdvidR6Dv?=
 =?us-ascii?Q?P0vRDD52SZjCU34TGjXeR8gPzXoV2YQicoPMKjsiAHhAAr2mT8SuB1Ms+sC1?=
 =?us-ascii?Q?Emh8V5klz3+SRW60g0V9UwqO2wZut9b1tTYqmt++ynEJuTrjZuLeJGtyuFfR?=
 =?us-ascii?Q?EUg9jw2aG3A54SpPIvFjoDrvepd9hesyZLlHuGwCy49auNAXKFlE1500U53G?=
 =?us-ascii?Q?4xbqEx5Fno2X3QtKA2RDmCzLIFdNJr+L9Iu0X8q99Pll+/CzdDbSLwiaxDt3?=
 =?us-ascii?Q?AP5qLFtiAozClhV3XRF1ZpBoUQT0rfFwzW6P9HyGvPOowYpLIt+lo5hQXE1r?=
 =?us-ascii?Q?IVW+WZdRTtl4LeVef6XnOi6IrziTaJXIdbey9b1cue3UQOIR60oKd+3DrwLa?=
 =?us-ascii?Q?Eb8yr3kOc9AZPRdLdFiCFQwE4wEt3JumoDjXprmdlyu0s4EiEBkRmPRQCwnO?=
 =?us-ascii?Q?PbClXyxNizSuRnXjoXX7F1ilZ1EPNoFgTi4anH2446GZd9CuxX0kO94q0XdE?=
 =?us-ascii?Q?nCRQuE0kGPw+Who9Mq4sn3idQKknwo/Kwe4gnSvEE82JKvLyLc49F4/p9/7B?=
 =?us-ascii?Q?YdHQ3HmfAaDV5NoT+dGzJ4QirSzo4YL3PIlfulPFBL4stFEcB5UnUO6S1hzQ?=
 =?us-ascii?Q?eS8iqD0Bfa5Oq8o6SjYdkYtBUGgdnk+rYhebO/CQCVN3OofmDj9iWT+Y7kn+?=
 =?us-ascii?Q?VkGtniKOZVNcbXJIbjH8Espl5hFcondjoqk5T5XF0fuP/Ruq/kz7ch1X0yPO?=
 =?us-ascii?Q?h4xG3FVkI0y9YT5ytwLNJtvN3O6E1sJPdNqLkAhmHegiVxaPpA6gKF+fSOc5?=
 =?us-ascii?Q?ubn4P8dluy9W+yQ8HruZEoPwOANR99qrzgMV8JH17FKznu5IuJXXTbwEc7UA?=
 =?us-ascii?Q?l/Wwc4hn5qXQ6+qsEENS8KDZYZwXr18sDCqJisLYFUIg0WS+QPTXbK9P5y68?=
 =?us-ascii?Q?/jK/RB3fW4NqnnZjUiaYMiy/COfKBSG0I22o4us5dcVwXynJS/RYyloxwTux?=
 =?us-ascii?Q?28I2WD0mCGVm0a8mCzVGmDXvtu+FwL2xf/GNDJxmKNqU8sv8ue/IEfe1Bs1T?=
 =?us-ascii?Q?HR3Ku2BmI35F5184iz45vQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:209.85.215.175;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail-pg1-f175.google.com;PTR:mail-pg1-f175.google.com;CAT:NONE;SFS:(13230040)(7093399012)(29132699027)(43022699015);DIR:INB;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GP3mYwQFbrMli1q3Cetu2/tn9NaBipfG/RcvgcvEGs9FDwGmqLeye3lljLN38OMB3YQmV/kjUfHAMqBXGV0fPdcM/ljDaLrM5KiECYH7kIVjJDoiH5Ba7vmStOz4YW77G8LIVuwjjiCOblPTnmLOUNB58047+XbjaOxUhMLHwmXAIpCEv2aZjqFZHZhAjMGFLh/YQbPF7QVF2Uz1arxohWkndY7utP82SZvGbhiO3GT6wwdTz0VyDQJmABFKWRHgcNleYLo2nMrd2IifkNL04fqQPhcmxoIFxi0tVmmEpvepDCLIpdl+edNSPm1Xf2YWObjBY4vB1EY5szibuKk8T60p903g8YvFcseTXN1rXc1xCioT0a4QVNtnykCG5Oei/ttdfsDU+/YNgVYv4D4Lq7j9mPnJXltes6IOVlR/Z4X5Xx8pS1KjQBsTiYsOmCnPurwvGz7eek8QRORZ3cliL83mWxILbqoqn04Y9CdgCpHRncL2FkFV+IRfie9A7vEk1giCf2POGkLsG4qeJ40lL1tteOYiuI8UWm6njSBMp0HSFgKG9sJZOKa10lK2M6VZhB2A4HJDTB6VBilGVTyYjMt/5lCrztFUAseUQfioBPj36KYQDYGDsXYHuv02oGhE
X-OriginatorOrg: mitprod.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 15:12:08.8978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbca6a1-4691-4890-b626-08dd019a0baf
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-AuthSource: 
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7586
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 209.85.215.175
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-AuthSource: 
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossPremises-AuthAs: Anonymous
X-MS-Exchange-CrossPremises-Antispam-ScanContext: 
	DIR:Incoming;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: MN0PR01MB7586.prod.exchangelabs.com
X-SA-Exim-Connect-IP: 18.9.21.22
X-SA-Exim-Mail-From: tytso@mit.edu
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on imap.thunk.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
	RCVD_IN_VALIDITY_CERTIFIED_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_GREY autolearn=no autolearn_force=no
	version=3.4.6
Subject: xfstests results ltm-20241016165408-0014
 6.6.61-rc1-xfstests-g4744f45e99fb-8
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on imap.thunk.org)

TESTRUNID: ltm-20241016165408-0014
KERNEL:    kernel 6.6.61-rc1-xfstests-g4744f45e99fb #8 SMP PREEMPT_DYNAMIC =
Sun Nov 10 05:14:53 EST 2024 x86_64
CMDLINE:   -c ext4/all,xfs/all -g auto --repo stable-rc.git --watch linux-6=
.6.y
CPUS:      2
MEM:       7680

ext4/4k: 576 tests, 2 failures, 55 skipped, 6031 seconds
  Failures: generic/365 generic/645
ext4/1k: 570 tests, 3 failures, 59 skipped, 5818 seconds
  Failures: generic/627 generic/645 generic/750
ext4/ext3: 568 tests, 2 failures, 148 skipped, 4243 seconds
  Failures: generic/365 generic/645
ext4/encrypt: 551 tests, 2 failures, 171 skipped, 4186 seconds
  Failures: generic/365 generic/645
ext4/nojournal: 568 tests, 2 failures, 126 skipped, 4458 seconds
  Failures: generic/365 generic/645
ext4/ext3conv: 573 tests, 3 failures, 57 skipped, 6299 seconds
  Failures: generic/347 generic/365 generic/645
ext4/adv: 569 tests, 2 failures, 63 skipped, 4802 seconds
  Failures: generic/365 generic/645
ext4/dioread_nolock: 574 tests, 2 failures, 55 skipped, 4746 seconds
  Failures: generic/365 generic/645
ext4/data_journal: 569 tests, 2 failures, 132 skipped, 4243 seconds
  Failures: generic/365 generic/645
ext4/bigalloc_4k: 547 tests, 2 failures, 58 skipped, 4770 seconds
  Failures: generic/365 generic/645
ext4/bigalloc_1k: 548 tests, 1 failures, 69 skipped, 4855 seconds
  Failures: generic/645
ext4/dax: 562 tests, 2 failures, 159 skipped, 2977 seconds
  Failures: generic/365 generic/645
xfs/4k: 1157 tests, 13 failures, 181 skipped, 11983 seconds
  Failures: generic/091 generic/127 generic/263 generic/363 generic/365=20
    generic/616 generic/645 xfs/629 xfs/630 xfs/631 xfs/632 xfs/806
  Flaky: generic/455: 20% (1/5)
xfs/1k: 1157 tests, 12 failures, 169 skipped, 12621 seconds
  Failures: generic/091 generic/127 generic/263 generic/363 generic/616=20
    generic/645 xfs/629 xfs/630 xfs/631 xfs/632 xfs/806
  Flaky: generic/560: 20% (1/5)
xfs/v4: 1156 tests, 11 failures, 476 skipped, 8452 seconds
  Failures: generic/363 generic/365 generic/645 xfs/348 xfs/629 xfs/630=20
    xfs/631 xfs/632 xfs/803 xfs/804 xfs/806
xfs/adv: 1157 tests, 13 failures, 167 skipped, 11341 seconds
  Failures: generic/091 generic/127 generic/263 generic/363 generic/365=20
    generic/616 generic/645 xfs/157 xfs/629 xfs/630 xfs/631 xfs/632=20
    xfs/806
xfs/quota: 1157 tests, 12 failures, 166 skipped, 12417 seconds
  Failures: generic/091 generic/127 generic/263 generic/363 generic/365=20
    generic/616 generic/645 xfs/629 xfs/630 xfs/631 xfs/632 xfs/806
xfs/quota_1k: 1157 tests, 13 failures, 169 skipped, 14282 seconds
  Failures: generic/091 generic/127 generic/263 generic/363 generic/627=20
    generic/645 xfs/629 xfs/630 xfs/631 xfs/632 xfs/806
  Flaky: generic/112: 20% (1/5)   generic/616: 80% (4/5)
xfs/dirblock_8k: 1157 tests, 13 failures, 166 skipped, 12183 seconds
  Failures: generic/091 generic/127 generic/263 generic/363 generic/365=20
    generic/616 generic/645 xfs/629 xfs/630 xfs/631 xfs/632 xfs/806
  Flaky: generic/075: 80% (4/5)
xfs/realtime: 1156 tests, 6 failures, 521 skipped, 9530 seconds
  Failures: generic/363 generic/365 generic/455 generic/645 xfs/629 xfs/806
xfs/realtime_28k_logdev: 1156 tests, 5 failures, 602 skipped, 16344 seconds
  Failures: generic/363 generic/365 generic/645 xfs/598 xfs/806
xfs/realtime_logdev: 1156 tests, 7 failures, 575 skipped, 12594 seconds
  Failures: generic/363 generic/365 generic/645 xfs/598 xfs/629 xfs/789=20
    xfs/806
xfs/logdev: 1157 tests, 14 failures, 236 skipped, 15071 seconds
  Failures: generic/091 generic/127 generic/263 generic/363 generic/365=20
    generic/616 generic/645 xfs/598 xfs/629 xfs/630 xfs/631 xfs/632=20
    xfs/806
  Flaky: generic/112: 60% (3/5)
xfs/dax: 1167 tests, 7 failures, 552 skipped, 5763 seconds
  Failures: generic/365 generic/645 xfs/629 xfs/630 xfs/631 xfs/632 xfs/806
Totals: 21269 tests, 5132 skipped, 739 failures, 0 errors, 186798s

FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0=
200)
FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0=
400)
FSTESTVER: zz_build-distro bookworm
FSTESTSET: -g auto
FSTESTOPT: aex

--BCqnBw7vZwXXJmTO--

