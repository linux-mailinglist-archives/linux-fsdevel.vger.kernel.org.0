Return-Path: <linux-fsdevel+bounces-32364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40759A43D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136F01F22314
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396D202F6C;
	Fri, 18 Oct 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hRPBiAr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C19202632
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268936; cv=none; b=e7420bW1jdisYwdn/kS8mUPuSPbejOIkSHP5f3R6H9abVWFVndZ9STygvN2UQGx5PEtw0WmU4UjHZTvGenjf2hhhixNWoHskVFmcsxa9UAwVUE46mcO7e8K3+m+AYl8TBfVmk1pABthj3DVRBvLmT72vvke07omEdp+pBaodCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268936; c=relaxed/simple;
	bh=Zc7kcKZmoDd6vL5LbQEkJC8eR7LWqB/Qel9dspbBBFQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y/GzTsbMQuzL8barXpkThF+HUnrDoxs0RQ/1eTX9uNyPg4YkecYkik9TwTPiNo1qUitPzYNAtXZcD+oZVB3X1TEiyA4A4hAXkt53OY0CUflHBK1SyqscaCBGCcX0kgHFq/rTBjMHeS4kwsLMJCBC8PQGniytKhFMXBm3Pr9qQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hRPBiAr8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-130-231.bstnma.fios.verizon.net [173.48.130.231])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49IGScoE017264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 12:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729268920; bh=qh0VcFTdJcjxM4zaxdxjSqDyVEdK1tlfE0lSTdtqQ5I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hRPBiAr8g1CDdia+pliGagtlt1ej7+3ZZPeRB1Xn8I3mVh9Yt0m3UWNYQICObzCle
	 WSyd+wFl2CKyqelljNs67GI/qwMg2GPYzUH05WCPnRv/we+PY+eidP06Re6VqQBP4V
	 dHbyioJslHTw53UUWyVq9E29yNVjDCtuxO0hK5FlVfPlAf8omsb9tttnPeMzzsH0gq
	 7Ut5hNS0XS9zoFnsQQsDx37JJszsU6UMcz/+ICkUPouT4MaruaAAUDhp1UkdWdjtt/
	 NFzG+OVljlsmc5SUaQR097exaCSc2IesZaCi/0wCE+teXPS/E83rcs/CQOCxEan2pH
	 ptWfbWgfpDBmA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C4AD815C02DB; Fri, 18 Oct 2024 12:28:37 -0400 (EDT)
Date: Fri, 18 Oct 2024 12:28:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [REGRESSION] generic/564 is failing in fs-next
Message-ID: <20241018162837.GA3307207@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/EKuaYg+Adjg8tEj"
Content-Disposition: inline


--/EKuaYg+Adjg8tEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been running a watcher which automatically kicks off xfstests on
some 20+ file system configurations for btrfs, ext4, f2fs, and
xfstests every time fs-next gets updated, and I've noticed that
generic/564 has been failing essentially for all of the configurations
that I test.  The test succeeds on rc3; it's only failing on fs-next,
so it's something in Linux next.

The weird thing is when I attempted to bisect it (and I've tried twice
in the last two days) the bisection identifies the first bad commit as
Stephen's merge of vfs-branuer into linux-next:

   commit b3efa2373eed4e08e62b50898f8c3a4e757e14c3 (linux-next/fs-next)
   Merge: 233650c5fbb8 2232c1874e5c
   Author: Stephen Rothwell <sfr@canb.auug.org.au>
   Date:   Thu Oct 17 12:45:50 2024 +1100

       next-20241016/vfs-brauner
       
       # Conflicts:
       #       fs/btrfs/file.c
       #       include/linux/iomap.h

The merge resolution looks utterly innocuous, it seems unrelated to
what generic/564 tests, which is the errors returned by copy_file_range(2):

    # Exercise copy_file_range() syscall error conditions.
    #
    # This is a regression test for kernel commit:
    #   96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
    #


# diff -u /root/xfstests/tests/generic/564.out /results/ext4/results-4k/generic/564.out.bad
--- /root/xfstests/tests/generic/564.out        2024-10-15 13:27:36.000000000 
-0400
+++ /results/ext4/results-4k/generic/564.out.bad        2024-10-18 12:23:58.62
9855983 -0400
@@ -29,9 +29,10 @@
 copy_range: Value too large for defined data type
 
 source range beyond 8TiB returns 0
+copy_range: Value too large for defined data type
 
 destination range beyond 8TiB returns EFBIG
-copy_range: File too large
+copy_range: Value too large for defined data type
 
 destination larger than rlimit returns EFBIG
 File size limit exceeded


Could someone take a look, and let me know if I've missed something
obvious?

Thanks,

					- Ted

--/EKuaYg+Adjg8tEj
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <tytso@mit.edu>
Envelope-to: mit@thunk.org
Delivery-date: Fri, 18 Oct 2024 06:21:37 +0000
Received: from exchange-forwarding-1.mit.edu ([18.9.21.21])
	by imap.thunk.org with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <tytso@mit.edu>)
	id 1t1gMi-0005BU-0C
	for mit@thunk.org; Fri, 18 Oct 2024 06:21:37 +0000
Received: from mailhub-dmz-1.mit.edu (MAILHUB-DMZ-1.MIT.EDU [18.9.21.41])
        by exchange-forwarding-1.mit.edu (8.14.7/8.12.4) with ESMTP id 49I6LY2X019902
        for <tytso@EXCHANGE-FORWARDING.MIT.EDU>; Fri, 18 Oct 2024 02:21:34 -0400
Authentication-Results: mit.edu; dmarc=none (p=none dis=none) header.from=thunk.org
Authentication-Results: mit.edu; arc=pass smtp.remote-ip=18.9.21.41
ARC-Seal: i=4; a=rsa-sha256; d=mit.edu; s=arc; t=1729232494; cv=pass; b=AAc54PDBxx7xzTSyYxJfdDvrC2Ov9by5+xg5L3zOetFkGcPOkc9Dr/XiPc5P6mViu3GVIyDEOhLaW92IuLdS9QRLTCYzZQUV2oTNHs8vsHRB2MZl+wGO52S9tRw/6C14y88/w/f7SE8AIdCnnzzFYFZRWOvtEbKoW1bZ2BSOUMEEzlWPzegAyoKVe2WyatEWXcMA0iJ8Lc1Pgh9d2QQwjsEfJMhqB2KUh2wsYX2JKxFnn2zSGESJIg0O0gsb2xOuhW+PCbxs2IvsPbOkMbdl5QTYfgP4LPlrKZwIo0zg547cG60v+N6XqQDSpySkifpgwr/XWdSjYD2s9nWxGBSdtQ==
ARC-Message-Signature: i=4; a=rsa-sha256; d=mit.edu; s=arc; t=1729232494;
	c=relaxed/relaxed; bh=WncWsA8Rh8SbXD8jSjEoJga+V7k29xxq8htsN3sdVrY=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject; b=XQtdZ+DIf9vg+gYgi2AzCEOgO+ylO3/1o+G5ymWQMVGpHmxCLp7a9DAPTvZzmhGwDhqoXe4cqf6zfIidvdlPo/4e6KxsSLeENqlb7mTfg9tgT+Yh0AiRKJefS+WMPwaxB93urhBkKOTaJjHwu5AK1Ev/ZXvw/2JbEaggD3puyiFWL3V/AduCZZONV48rqVX1aUTNPmAymhg4StLxgnIf3OQ2VmG3/UA7UhTDiLjDxC9/FWehdbR7DAzAjl9PAuBhlGpRKhlPi9XziyFmBHpZKr1h6zahbcQDzmAu6T5yiX4ScEvhOh+v/xR9jCWSLIEaSNGlgI9kxu1G7P9mgP8j5w==
ARC-Authentication-Results: i=4; mit.edu; dkim=pass (1024-bit key; unprotected) header.d=sendgrid.me header.i=@sendgrid.me header.a=rsa-sha256 header.s=smtpapi header.b=WYawv6H9
Authentication-Results: mit.edu;
	dkim=pass (1024-bit key; unprotected) header.d=sendgrid.me header.i=@sendgrid.me header.a=rsa-sha256 header.s=smtpapi header.b=WYawv6H9
Received: from mailhub-dmz-1.mit.edu (mailhub-dmz-1.mit.edu [127.0.0.1])
	by mailhub-dmz-1.mit.edu (8.14.7/8.9.2) with ESMTP id 49I6LXLa000981
	for <tytso@exchange-forwarding.mit.edu>; Fri, 18 Oct 2024 02:21:33 -0400
Received: (from mdefang@localhost)
	by mailhub-dmz-1.mit.edu (8.14.7/8.13.8/Submit) id 49I6LXoV000979
	for tytso@exchange-forwarding.mit.edu; Fri, 18 Oct 2024 02:21:33 -0400
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp17010005.outbound.protection.outlook.com [40.93.1.5])
	by MAILHUB-DMZ-1.MIT.EDU (envelope-sender <theodore.tso+caf_=tytso=mit.edu@gmail.com>) (MIMEDefang) with ESMTP id 49I6LWc6000977
	for <tytso@mit.edu>; Fri, 18 Oct 2024 02:21:33 -0400
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KVHxusdk5t6KJpUoI4G7gf/VmLpHUykWSRLmItC6HCyCe3W2t8dbj6vKzpFB0BsrWfoOCVz86LMGY/v1d0Q30N0pMcSNnb0OmkdFbhlSaodGhc4hn5oZ/Rv2qpZa94Y/9VgyMQxBhw4V5H9SDPfpRqxQ62U/w0tPpMAhEi7TuwlD5SyOmjKivXt5koFOK40sIlW1OZH7hxfEEQ6c8zqwJafIyv6RK6bGN1qhejUGwE3vvE0Jx4pdc0iczCJWMHBYOtF3Y61DNlIAJ7aSRdPi+Nn/SPBeyuelkStENDzP8f67rpT0/kHIKVx4S2C7dBnKl0egMlLdl3Eo0RQbaRv2TA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WncWsA8Rh8SbXD8jSjEoJga+V7k29xxq8htsN3sdVrY=;
 b=oCPjAzhAAJC/DdgQBgPV+AsJK9z17JO4qnVZ9nYxA9vkMWcGxIuueiCKMUdI5lTuuWDQhCezjfskPpDlA6Q0SSGAyMeAGgQ3rGoXSWP/LtEYfJtD21W9+lL8LWpllC8UQMeW5E5zzUtYu7uMZ2FTxoMwwY7CYj4bL603XArnIRR4l1ONzJdlf6h9APtUX64NJRdFiwIOSEheLrcMSzCcmlj46PwXSg4Ck6RY+Fm7/Jtwks1s5UGa16tgXJgogiHXbRLZUQLOSOUhxxyrSg2GWY+4yrxSMs45T+Uiyvi3HlQ/DOfPVGHA+cxfGXPJhRm6ucL0eUNpjy1R4YpzqiM4BQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 209.85.210.46) smtp.rcpttodomain=mit.edu smtp.mailfrom=gmail.com; dmarc=none
 action=none header.from=thunk.org; dkim=pass (signature was verified)
 header.d=sendgrid.me; arc=pass (0 oda=0 ltdi=1)
Received: from SA0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:806:130::29)
 by BY1PR01MB8803.prod.exchangelabs.com (2603:10b6:a03:5b3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.21; Fri, 18 Oct 2024 06:21:27 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::6d) by SA0PR13CA0024.outlook.office365.com
 (2603:10b6:806:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Fri, 18 Oct 2024 06:21:27 +0000
Authentication-Results: spf=pass (sender IP is 209.85.210.46)
 smtp.mailfrom=gmail.com; dkim=pass (signature was verified)
 header.d=sendgrid.me;dmarc=none action=none
 header.from=thunk.org;compauth=pass reason=101
Received-SPF: Pass (protection.outlook.com: domain of gmail.com designates
 209.85.210.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=209.85.210.46; helo=mail-ot1-f46.google.com; pr=C
Received: from mail-ot1-f46.google.com (209.85.210.46) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8069.17
 via Frontend Transport; Fri, 18 Oct 2024 06:21:27 +0000
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71806621d42so811051a34.3
        for <tytso@mit.edu>; Thu, 17 Oct 2024 23:21:27 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1729232487; cv=pass;
        d=google.com; s=arc-20240605;
        b=hoxnWtiW0gaRNYSYIuauSXc5Kb/+hOIbGrZ7G4IFtXBCF3QbuHE6vs9jZAIAxq7wga
         +NfjU7tIkWSlQb4rWEqoD3y0cmeCFJSCx8E/vqkICLpPgkBOmmohjj/B6UDlc5SgKyDS
         1HEkDO8ZxJjKMqPf2DLhLYPRn2sHDNMjoNcdO7wxlY68jTok5Yip14hiMZkSgvfleTb9
         7+St7r8AquJ80fJoulDqO132ohxXUt4WdtwDbnmglccdmpARz7sSYVkthi4oyc0ZcBLM
         oOVxxR4ysPQfPb0BL7f2rmy5KoY79oqQnVmdoHLo/vBgXHpwrGgMvAD4JVR7Q8cCFZOd
         jTfg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:mime-version:from:date
         :content-transfer-encoding:dkim-signature:delivered-to;
        bh=WncWsA8Rh8SbXD8jSjEoJga+V7k29xxq8htsN3sdVrY=;
        fh=cBqM1GDqvBQarHi0E+01BVbiac18aRUt1KRY0xTlZYk=;
        b=J6QOwptERecia4RY+Z0YfCcbDes0qK6iFuEdnbV9mBKqJkKaF9XYPmrjCuB3zZyBzc
         rCKIV/znqh52RmrvL9s2c4A9lkGZlM/xE0iEliYDGPAVVEejfpc6f96w7FgyPDw6bgxa
         fVv5zMgBIKmQ4wz2h0bhSDM6lNTgNJfz9FyQU5OcwpZNRCCf8gSCElsau8iL9kyh7Nqu
         WldGxTFnmHa2RBPqTHdV/jLK4PqSvr1h6MfaxYDsAg3C2l56TQ7QqDtf626cvhOKtueG
         BxorlCPbP0YHvN4gErYA1/YwLeCwH8sBdlJuJ6U5WGFFH2Pb+PspFU0snbH7emDNFYQI
         VLxQ==;
        darn=mit.edu
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@sendgrid.me header.s=smtpapi header.b=WYawv6H9;
       spf=pass (google.com: domain of bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net designates 149.72.154.232 as permitted sender) smtp.mailfrom="bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net"
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729232487; x=1729837287;
        h=to:subject:message-id:mime-version:from:date
         :content-transfer-encoding:dkim-signature:delivered-to
         :x-forwarded-for:x-forwarded-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WncWsA8Rh8SbXD8jSjEoJga+V7k29xxq8htsN3sdVrY=;
        b=cHiSQNYqhBDkv+zXlRRoTWgNwJbWv174I6ap7LmR+zA+n4cbpIes0q6fbrGlmFo8U5
         tU0BffVLyehp8fBeysgyApYfmOB3/KVVkpjLw98RcQvCWDEmx9Kv3b4mgRmnyocVpAoN
         D8RoQ5ApA8kUI8dfcYntRxVneASoZnwyNhFJ+NqcZUK9qJiaRdd7TUbgFH1EwLH1F0jD
         7nuwShNkRDPrRfMPN0PzDbUKjHMwu8fdhECoxEyKotN9DAJUrTd1LXBFKzmap0nuFJlP
         KZcE+pHYkxrdUZr0DUiV+A4p4w/SEJS9EXv2Dhqq+LqX0GUo64yU2pwyHreaz1KliXdk
         naZQ==
X-Forwarded-Encrypted: i=2; AJvYcCVVIBWj1Qrmxs68mwsfNPFyiRmjo415RqI85lwZAKIhfd/f17VREjy4TnAkqZfqKOeI2IK/Fw==@mit.edu
X-Gm-Message-State: AOJu0Yzu9DYdQo6RJn9wvqamBKu4vbB1fu/aa0kn5ZrzLw8EHziRWsnT
	l2gApYWUzLS9hdqakpyr2LF11Beazn0Ga18rU06AXqxgfvWPBpUOPPkY6wi+KsRKvmnpow/Wuqg
	9CPPX+d8ahEyyT2K7DRneUZSXxzY60tZAU7yMDNaPbC3uRGFaYcC7GWuH7A==
X-Received: by 2002:a05:6871:549:b0:277:cc6e:15de with SMTP id 586e51a60fabf-2892c24db35mr1388463fac.4.1729232486668;
        Thu, 17 Oct 2024 23:21:26 -0700 (PDT)
X-Forwarded-To: tytso@mit.edu
X-Forwarded-For: theodore.tso@gmail.com tytso@mit.edu
Delivered-To: theodore.tso@gmail.com
Received: by 2002:a05:6a11:f59e:b0:5b8:19a5:f5e3 with SMTP id ic30csp782402pxc;
        Thu, 17 Oct 2024 23:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtOqStKL1fNDsPh03eSP1BHUIwPMUi2zuendxsJeD3p+NCSvzXZY8tyrw1/FipXdqdWMam
X-Received: by 2002:a05:6214:4a08:b0:6cb:4c1c:508d with SMTP id 6a1803df08f44-6cde1532664mr19384986d6.28.1729232484019;
        Thu, 17 Oct 2024 23:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1729232484; cv=none;
        d=google.com; s=arc-20240605;
        b=Xybboj37kJNG7/8dblisEdACJ0ZYGdDrTJnP7tRjD2/WfIFBLbgzbZICm8pBukZfKR
         s5r0E4gMmFDScnCDKK/tgJ8Lg9NTOMgKtuhB0CclpTgMYGS7uo72nn5kt9a1kCrvgh52
         R0G4CVEP9lx74YN2eqPmNmnPMmfCX69AIVYBcp79BgH9hd8aWWbsxUPDuWgSMU1vWDw1
         YJ9mJ//Wah3DDyjvDG4vCsLi1iOmkk/96VdNZFfXhEgzgZWZLucNhH4AAZgr7b+Pvhwt
         qRFHsNuH3S+lDjsJwJ92OV9m65Vq/zVUjEBLPWyrR+DmVp9dRq4HdIDyh6yJBtPcG3Qa
         jsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:mime-version:from:date
         :content-transfer-encoding:dkim-signature;
        bh=WncWsA8Rh8SbXD8jSjEoJga+V7k29xxq8htsN3sdVrY=;
        fh=px3dClbshMynTO2CxTh7Q51Apyf1LkdTq7Ys9bYwEMU=;
        b=insPaBldDXIXbTbfTDNG+PHQ5QWZOtTYnk4nW36tThSm7fZljQj6kYaGRFA/PRrMcC
         VPcfUtlYTinKZeo8OSptFP/SK2f0W8rtmI4mGiGFLwm/+b0+Bjvc0x3JUlPwJp51poQ4
         +uxrLrpaj8OKuR6u+gK8y1relFkSqJmTSmQ+740dZL63gb/Aog5SS4YYBF+NBwJLoPUq
         ZGS5fFQDhKN2J0/FlJUrWXABoeDCbXwXJZyTU5Wxt5jEQBBioLyt9hsIixniNvgUB1O9
         ya9FDWa8rjp49iuULI8kEkwsGzFKAUA0RrEtBgIEsc7xsM2G8YnpOYiHfLIAPAItbJxh
         LMyw==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sendgrid.me header.s=smtpapi header.b=WYawv6H9;
       spf=pass (google.com: domain of bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net designates 149.72.154.232 as permitted sender) smtp.mailfrom="bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net"
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net. [149.72.154.232])
        by mx.google.com with ESMTPS id 6a1803df08f44-6cde1122cadsi10025526d6.120.2024.10.17.23.21.23
        for <theodore.tso@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 23:21:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net designates 149.72.154.232 as permitted sender) client-ip=149.72.154.232;
Authentication-Results-Original: mx.google.com;       dkim=pass
 header.i=@sendgrid.me header.s=smtpapi header.b=WYawv6H9;       spf=pass
 (google.com: domain of
 bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net designates
 149.72.154.232 as permitted sender)
 smtp.mailfrom="bounces+1896720-29f7-theodore.tso=gmail.com@sendgrid.net"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.me;
	h=content-transfer-encoding:content-type:from:mime-version:subject:
	x-feedback-id:to:cc:content-type:from:subject:to;
	s=smtpapi; bh=WncWsA8Rh8SbXD8jSjEoJga+V7k29xxq8htsN3sdVrY=;
	b=WYawv6H9uqqlc04LwzU+O/I2zAHRJXiKqfyIJg3/1uamHjSxjmI+0SE2sZ1WrRyOrFqn
	S6ukQ6CaDDYhSjUw2qYdPS4whqyxxyQQtzFZIbzjInS6ZkZLbyAw6ER8AS5+Wfj/90g5+b
	dkIoSQcMeTxpOCYXVpdAw6NCCGdDh3Dv4=
Received: by recvd-76b48cd7f5-cffq9 with SMTP id recvd-76b48cd7f5-cffq9-1-6711FE62-4
	2024-10-18 06:21:22.203025749 +0000 UTC m=+3068606.621218345
Received: from MTg5NjcyMA (unknown)
	by geopod-ismtpd-1 (SG) with HTTP
	id GetBG70iT0y8vnGiS_zP5w
	Fri, 18 Oct 2024 06:21:22.089 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 Oct 2024 06:21:22 +0000 (UTC)
From: Xfstests Reporter <tytso@thunk.org>
Mime-Version: 1.0
Message-ID: <GetBG70iT0y8vnGiS_zP5w@geopod-ismtpd-1>
X-Feedback-ID: 1896720:SG
X-SG-EID: 
 =?us-ascii?Q?u001=2EMxrsaI44goA65Ct+PMRZBcKM0BzC3TC9StWRwUZI3HOdTi3WNqYQIyJQH?=
 =?us-ascii?Q?Z+rSac8HkLRwPK3n4b2hTuuRKBXKF7n0FbMiTeT?=
 =?us-ascii?Q?EO=2FZ4+vdLoSzHYD+VEqRLWtKONIpGuBM8HTR3yk?=
 =?us-ascii?Q?fJit7wBdhnmmb5wwJFhWnowfq=2Fq730NQq0vBqUn?=
 =?us-ascii?Q?Mndi12BRYpKG6W33BHXk05yaOpf1KSKzbz6VwN2?=
 =?us-ascii?Q?N4T4CjK86GPX8a8qKa1B7WX+k8Z5JSxd9B3Vi3Y?= =?us-ascii?Q?2M=2F9?=
To: theodore.tso@gmail.com
X-Entity-ID: u001.XCHHN99Ad702A07KJDcTSw==
X-EOPAttributedMessage: 0
X-EOPTenantAttributedMessage: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b:0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|BY1PR01MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc55b63-1e48-4407-69ff-08dcef3d192e
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MIT-ForwardedCount: 1
X-Microsoft-Antispam: BCL:0;ARA:13230040|29132699027|7093399012|43022699015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VR520uL0BLKQMENvdaT7JmSUKZvRl+ZKMja4hS9xAmMg1Vd10fpiIy76JUOW?=
 =?us-ascii?Q?qPz2zJgMLEvXsaSgbBXgQTrnve/wucUndLzHmqCgnVmWtNz6IV88MMd084fs?=
 =?us-ascii?Q?EmQtHZSK4hFXnDQNrY5Os2e3wY5VkFQBrnA6LJdBsije9doil+2SpFwASnNT?=
 =?us-ascii?Q?azVGFyqXJxnDj/CpOAo9RKqGYVTlp8YR8sEdHbBMZybl1HthI/kW6g8rA9Il?=
 =?us-ascii?Q?2T65WIFBt8NlNa0zfCXMzF8HvQdAG2zugMmLDm1Rlg1iKj9w9BEqDiIFFUYY?=
 =?us-ascii?Q?l7jfPO0ERMdnT2cLGiu34TT+1XY4U4LPvQV3t1qarxg1u/p9JInLIUtZxxxA?=
 =?us-ascii?Q?qjxZm18PMbYlUszw/kRXQoF6e1pgtEfK1qwm0D0fv+zn0K3e9/N8TjL/8/8d?=
 =?us-ascii?Q?BPElIhG1b3p5FjQMPaBKxv+ApEEVZW8A7AvXQS24e3MVLpZ1uBEKyDg0Cjih?=
 =?us-ascii?Q?YTJVTWnYkG+BDMIppffuuHQgp6mq/ENCyu1R01p9DjTAqYcHLTwmwjZV9Ol7?=
 =?us-ascii?Q?nQu0fsksQ8km2ieyR8eBNAuE/+SFLSleioLByuuiHVt1TW3P38WaKTLgkLEw?=
 =?us-ascii?Q?YxEynXDMuEbeNydT6rewxUaxNpyVdOFPYWYgphPKpa4QvhgPWjYXiNjdnl5s?=
 =?us-ascii?Q?2YHenz5OYRww9DWASp12lZ9AypeLQupJwFCEa9GNZ1Aug+Dz01rb3G37tPuy?=
 =?us-ascii?Q?4ok1/MysCQLjSSJogwJZsZW4kM4XgOy+qcbbZFYlMszlFhhCbmr2Q7DrkwVM?=
 =?us-ascii?Q?V9GD2c4Va0AanE6aQVC1UbHLktNSPEa2KOftTOPj6mHgzIVs3sHtd1iXMcBV?=
 =?us-ascii?Q?oUPoOBcux4T9EcGUnLrzV1NuPpW8MPDHyuIDUMjJqU/5nJkWXcM0SEB/zAty?=
 =?us-ascii?Q?krUxEqB+ukI7K9QTKBoTMaACcnnf2j24XXBx9tE31GtjB9Bk4ktY7wQTCEHS?=
 =?us-ascii?Q?/pIYv1r2fjwhuMzdpPlKZu/dXMVAOpz+HDhxcBXTxQlVYP7aMiQZjB5gYqOF?=
 =?us-ascii?Q?09TfCzo1tdZFcgl0RhreKmAQbufxXxAkW9yEge1cE9YUm+cQL6tw3Owx87FT?=
 =?us-ascii?Q?v1oQIiouf6PUow3iz95Xc85lc9LrFeAZnVFCXcdt5OMoccDdqHrfzaUWztwM?=
 =?us-ascii?Q?h4jAVoPPL5IcIl19UV1QOXDwz1n728AxUvx9Uo/p9p53eC1/JCivWNZMZthT?=
 =?us-ascii?Q?52ye7T0qTnYeQfZxL0FzUq+BCYqef9rA84eme6sIsE06nPiUEVacDSLcX180?=
 =?us-ascii?Q?Zybc8Qx9u2C5Ktxtukq+9JtZrQJsJPl70b572HK8VA5UUqYX0cqHFaEayZRN?=
 =?us-ascii?Q?H0064mq2JBUKVr6sZPmFLlj+quTeCynJKKa9lK7k1hk83ZrrLk5A8vI+Q4gt?=
 =?us-ascii?Q?Cqi0AbJ2Z5Aj9sck5qVRW0kLmqOZUgumFr0LRxSsYvTIKp+UPYrqCKlD9uil?=
 =?us-ascii?Q?f0cQ3wvyWtL3iiPg7euSz31AHBLUzB8xP81BVxg6qwIz4rTYOUTMSr8MYJP7?=
 =?us-ascii?Q?I8V33ANX2YgJ8JqgXGZtET+jYi9F/i1Cchn2BF7gfoS8ujvAQxgWc/RYtpHi?=
 =?us-ascii?Q?zWQXovXl6LbXUX1hMilXIzqD2DbakC10hXCzInYJouVQTLiQQJHd5Od++prC?=
 =?us-ascii?Q?vElvbqYqJCWmjbRtJAs39DAfFH/qwXYhTfeMN4BZkG8TCtAGQjfVebSar8w/?=
 =?us-ascii?Q?rkYQxgPa75NiivkgLIu7R1fwz0+lhlM2P/0JWSoMGUDEENa/oraNQu45fPs3?=
 =?us-ascii?Q?oU/67ZQzoyLIu8cwijQRyJcNkLJDb83E2TgnqpxFpxeDt5rPzcIHPfwiJCKD?=
 =?us-ascii?Q?DzMrFpZATpU9EmG41MPp9pc37DMm/JupyvxnAeUBqK/YQOS7WNCabFF7NxwS?=
 =?us-ascii?Q?HbRSkA9szIBz/L9OLLS7PAjjDwHa1DT2xt5QuuBxnbN6WGcUJcqbd0kKAyxR?=
X-Forefront-Antispam-Report: 
	CIP:209.85.210.46;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail-ot1-f46.google.com;PTR:mail-ot1-f46.google.com;CAT:NONE;SFS:(13230040)(29132699027)(7093399012)(43022699015);DIR:INB;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AkDG4HYj1TMP7AHq/G3VrirdmFmPO7wsU/oi3C1I5Dq8uoq0b/EuorASHSLfr79JqAXqApfU6U/x6STMZBLLwbPGCmT9Rmr95JKHvZ4V2pICjEgB/8rIlbkjeyezVOcfosfsm0aQzHRFV/1DV/tvTVWct8SIq4apEqgNKAAApVx66Ga41LFwlLC2rKZroj586OLwUpAP/ua8SFD9VcIeVfZ8c+ap3ikcDtOFm1CMwLo8RwZy1b237GdvTbQ7zgHg6NKKZrsTuZXX2hPTq0Mi2KOIGCtMKFb8AXM1iLz5gLgrlcf+uEYugOtf5KdQhePN1pcacUS2CyOLLJuhkxR2KrBbMy620USozixy75gnn5zBE8Hxn6xJpNjDZWTsBFXoi77nMNwT4JdvNekQFYmLtejd+RTwtFQPrJUjrVCHcMO+M1c6rn1lm7QNXwOxCSTayjocvXyeOYXi/s0HiN2H0HBEuj8CId6wednlFYjw7DGMEpvJgpM9hx14+qUqSVlc8zaUZ6zikj7+V5jkBFFJkm2L7KvJY4BqAzIbbRVmyHwyRFGVw1Lh06ay/mMH8e8jBH5eY0ygydUJoBddfrFA/FRy+0Q6MYmjAHh9RbUAYfF8T+uZgks6eYlSvCSGcydu
X-OriginatorOrg: mitprod.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:21:27.4283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc55b63-1e48-4407-69ff-08dcef3d192e
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8803
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 209.85.210.46
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-AuthSource: 
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossPremises-AuthAs: Anonymous
X-MS-Exchange-CrossPremises-Antispam-ScanContext: 
	DIR:Incoming;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: BY1PR01MB8803.prod.exchangelabs.com
X-SA-Exim-Connect-IP: 18.9.21.21
X-SA-Exim-Mail-From: tytso@mit.edu
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on imap.thunk.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_VALIDITY_CERTIFIED_BLOCKED,
	RCVD_IN_VALIDITY_RPBL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
Subject: xfstests bisector summary 20241018002402
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on imap.thunk.org)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DBISECTOR INFO 20241018002402=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
CMDLINE:	-c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-goo=
d v6.12-rc3 generic/564
REPO:	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
BAD COMMIT:	origin/fs-next
GOOD COMMITS:	v6.12-rc3
SINCE LAST UPDATE:	0s
BISECT LOG:
git bisect start
# status: waiting for both good and bad commits
# bad: [b3efa2373eed4e08e62b50898f8c3a4e757e14c3] next-20241016/vfs-brauner
git bisect bad b3efa2373eed4e08e62b50898f8c3a4e757e14c3
# status: waiting for good commit(s), bad commit known
# good: [8e929cb546ee42c9a61d24fae60605e9e3192354] Linux 6.12-rc3
git bisect good 8e929cb546ee42c9a61d24fae60605e9e3192354
# good: [c34fba96e591306731d18feb1ec853e4659e16a2] Merge branch 'for-next' =
of git://git.samba.org/sfrench/cifs-2.6.git
git bisect good c34fba96e591306731d18feb1ec853e4659e16a2
# good: [08c323ab021e3a0246554cd7e753e91b3845e3fd] Merge branch 'vfs.ovl' i=
nto vfs.all Signed-off-by: Christian Brauner <brauner@kernel.org>
git bisect good 08c323ab021e3a0246554cd7e753e91b3845e3fd
# good: [cb0764720682a330425a8354c12ea5343a5691c6] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
git bisect good cb0764720682a330425a8354c12ea5343a5691c6
# good: [466247e4e33b7e43589e5fa00bcd721a67463935] nfsd: rename NFS4_SHARE_=
WANT_* constants to OPEN4_SHARE_ACCESS_WANT_*
git bisect good 466247e4e33b7e43589e5fa00bcd721a67463935
# good: [cc261279af9809ddf1f22d12966d4b9033983154] Merge branch '9p-next' o=
f git://github.com/martinetd/linux
git bisect good cc261279af9809ddf1f22d12966d4b9033983154
# good: [c29440ff66d6f24be5e9e313c1c0eca7212faf9e] xfs: share more code in =
xfs_buffered_write_iomap_begin
git bisect good c29440ff66d6f24be5e9e313c1c0eca7212faf9e
# good: [b026d364517dc97cd27e0e920a8b5f25f9889059] Merge patch series "API =
for exporting connectable file handles to userspace"
git bisect good b026d364517dc97cd27e0e920a8b5f25f9889059
# good: [f6f91d290c8b9da6e671bd15f306ad2d0e635a04] xfs: punch delalloc exte=
nts from the COW fork for COW writes
git bisect good f6f91d290c8b9da6e671bd15f306ad2d0e635a04
# good: [2232c1874e5c400d4666ac296258e37828c1bd70] Merge branch 'vfs.export=
fs' into vfs.all Signed-off-by: Christian Brauner <brauner@kernel.org>
git bisect good 2232c1874e5c400d4666ac296258e37828c1bd70
# good: [233650c5fbb83fb83f8311d660120ba910eff5fa] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
git bisect good 233650c5fbb83fb83f8311d660120ba910eff5fa
# first bad commit: [b3efa2373eed4e08e62b50898f8c3a4e757e14c3] next-2024101=
6/vfs-brauner


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-c34fba96=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-c34fba96
KERNEL:    kernel 6.12.0-rc3-xfstests-00245-gc34fba96e591 #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 00:33:27 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 12 seconds
  generic/564  Pass     9s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 12s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-08c323ab=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-08c323ab
KERNEL:    kernel 6.12.0-rc3-xfstests-00125-g08c323ab021e #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 00:47:07 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 10 failures, 19 seconds
  generic/564  Failed   12s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   0s
  generic/564  Failed   0s
  generic/564  Failed   1s
  generic/564  Failed   1s
Totals: 10 tests, 0 skipped, 10 failures, 0 errors, 19s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-cb076472=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-cb076472
KERNEL:    kernel 6.12.0-rc3-xfstests-00295-gcb0764720682 #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 00:56:02 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 10 seconds
  generic/564  Pass     10s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 10s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-466247e4=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-466247e4
KERNEL:    kernel 6.12.0-rc3-xfstests-00036-g466247e4e33b #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 01:08:37 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 15 seconds
  generic/564  Pass     9s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     0s
  generic/564  Pass     0s
  generic/564  Pass     0s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 15s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-cc261279=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-cc261279
KERNEL:    kernel 6.12.0-rc3-xfstests-00350-gcc261279af98 #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 01:21:55 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 20 seconds
  generic/564  Pass     12s
  generic/564  Pass     0s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 20s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-c29440ff=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-c29440ff
KERNEL:    kernel 6.12.0-rc2-xfstests-00024-gc29440ff66d6 #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 01:34:14 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 15 seconds
  generic/564  Pass     8s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     0s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     0s
  generic/564  Pass     1s
  generic/564  Pass     1s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 15s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-b026d364=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-b026d364
KERNEL:    kernel 6.12.0-rc3-xfstests-00010-gb026d364517d #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 01:45:14 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 20 seconds
  generic/564  Pass     11s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 20s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-f6f91d29=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-f6f91d29
KERNEL:    kernel 6.12.0-rc2-xfstests-00026-gf6f91d290c8b #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 01:53:01 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 18 seconds
  generic/564  Pass     9s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 18s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-2232c187=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-2232c187
KERNEL:    kernel 6.12.0-rc3-xfstests-00136-g2232c1874e5c #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 02:03:22 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 10 failures, 17 seconds
  generic/564  Failed   9s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   0s
  generic/564  Failed   1s
  generic/564  Failed   1s
Totals: 10 tests, 0 skipped, 10 failures, 0 errors, 17s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DTEST 20241018002402-233650c5=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TESTRUNID: ltm-20241018002402-233650c5
KERNEL:    kernel 6.12.0-rc3-xfstests-00362-g233650c5fbb8 #1 SMP PREEMPT_DY=
NAMIC Fri Oct 18 02:12:07 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --bisect-bad fs-next --bisect-g=
ood v6.12-rc3 generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 20 seconds
  generic/564  Pass     12s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     0s
  generic/564  Pass     1s
  generic/564  Pass     1s
  generic/564  Pass     1s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 20s

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
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

--/EKuaYg+Adjg8tEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fs-next-fail-report

TESTRUNID: ltm-20241017115737
KERNEL:    kernel 6.12.0-rc3-xfstests-00490-gb3efa2373eed #1 SMP PREEMPT_DYNAMIC Thu Oct 17 12:14:51 EDT 2024 x86_64
CMDLINE:   -c ext4/4k -C 10 --repo next.git --commit fs-next generic/564
CPUS:      2
MEM:       7680

ext4/4k: 10 tests, 10 failures, 15 seconds
  generic/564  Failed   9s
  generic/564  Failed   1s
  generic/564  Failed   0s
  generic/564  Failed   1s
  generic/564  Failed   1s
  generic/564  Failed   0s
  generic/564  Failed   1s
  generic/564  Failed   0s
  generic/564  Failed   1s
  generic/564  Failed   1s
Totals: 10 tests, 0 skipped, 10 failures, 0 errors, 15s

FSTESTIMG: gce-xfstests/xfstests-amd64-202410151341
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests f043065 (Thu, 20 Jun 2024 16:26:22 +0900)
FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
FSTESTVER: ltp  20240930 (Mon, 30 Sep 2024 12:27:12 +0200)
FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
FSTESTVER: xfsprogs v6.10.1-91-g42523142 (Tue, 8 Oct 2024 14:31:31 +0200)
FSTESTVER: xfstests-bld 71bcf39c (Tue, 15 Oct 2024 13:27:36 -0400)
FSTESTVER: xfstests v2024.10.14-11-g173cdbc07 (Tue, 15 Oct 2024 09:31:29 -0400)
FSTESTVER: zz_build-distro bookworm
FSTESTSET: generic/564
FSTESTOPT: count 10 fail_loop_count 0 aex

--/EKuaYg+Adjg8tEj--

