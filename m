Return-Path: <linux-fsdevel+bounces-1142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9144B7D673B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F611C20D25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB4262BE;
	Wed, 25 Oct 2023 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="t/sioXLL";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="d7Fp07fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB722F1A;
	Wed, 25 Oct 2023 09:44:10 +0000 (UTC)
Received: from mail-edgeDD24.fraunhofer.de (mail-edgedd24.fraunhofer.de [IPv6:2a03:db80:1504:d267::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE8E5;
	Wed, 25 Oct 2023 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227047; x=1729763047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lj4vIchilQSP7CJzsy23e8C9QwMXZ+lNYzOtv4p9Euw=;
  b=t/sioXLL7rsHWoj8k2wV9yqvEz8td3lYvgTSYPMkPsmAdBvHm/nkPxss
   9dqazrYmghgAJIVwZdd3mOKOuVivjgwdsyysfpCdFrp96W1N77fc6QURm
   u5npcLAzjYxXbAzoKToBsIHGfk2SbYQXVPq4rLJ5cwDqTwiQehTHuGNH2
   WmzFzNeB2+2qPy83JGtx9o0WT4+KtOtRyWM8bAxnAh4r1w6faOacrQ2nZ
   C0Ke0nG4BGJ1S79X9jYBWFHjUm9sGo1Diygz3tlgbfAs6mJr1Jm2Q7K6o
   dcC/0c6aaEq3ivZ1n4FDrUqT6WVdzK7aPJ/vyBi1Aki/cwth8wZiIFqXA
   w==;
X-CSE-ConnectionGUID: hwgJjR/STN+eETh6yYxBVg==
X-CSE-MsgGUID: aZ9kKngjSJG9CobO4vsqtQ==
Authentication-Results: mail-edgeDD24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2HeAwBB4jhl/xoBYJlaHgEBCxIMQIFEC4I5gleEU5Fem?=
 =?us-ascii?q?CaEBCqBLIElA1YPAQEBAQEBAQEBBwEBRAQBAQMEhH8ChxonNQgOAQIBAwEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAgEBBgEBAQEBAQYGAoEZhS85DYQAgR4BAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAjVUAgEDIw8BDQEBNwEPJQImAgIyJQYBDQWCfoIrAzGyGIEygQGCCQEBB?=
 =?us-ascii?q?rAfGIEggR4JCQGBEC6DXIQuAYQ0gR2ENYJPgUqBBoIthFiDRoJog3WFPAcyg?=
 =?us-ascii?q?iKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGUQQXFiQJExI+BIFngVEKg?=
 =?us-ascii?q?QM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEFBeBEW4FGhUeNxESFw0DCHYdA?=
 =?us-ascii?q?hEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDBIE2BQ0eAhAtJwMDGU0CEBQDO?=
 =?us-ascii?q?wMDBgMLMQMwV0cMWQNsHxocCTwPDB8CGx4NMgMJAwcFLB1AAwsYDUgRLDUGD?=
 =?us-ascii?q?htEAXMHnU2CTSABgQ0ngTR9li4BrnkHgjGBXqEJGjOXK5JPLodGkEggoj6FS?=
 =?us-ascii?q?gIEAgQFAg4IgWQBghQzPoM2UhkPgRuNBQwWFoNAj3t0AjkCBwEKAQEDCYI5i?=
 =?us-ascii?q?RIBAQ?=
IronPort-PHdr: A9a23:wY1uXhd0HcpMl0W4bQbCtOgQlGM+49/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvWp6pgjTDjutZhArZHcD1RLQoQiWs5
 JowR1z5qxUaHTQL03/LpM9Xkfpho0fywn43ydvYP6+NbKVwYL3zJYkHTkxxbJdgRS9tRbKHM
 KAIEeNRL/plirvM+3lVvT6HIAypVLzy7TNPiFHLhqkT6/0MDAvK3g14PdAuu3rXkOivEfYXW
 8ec3fiWzRydV+sR5T3P2M/CSBUgosC1GqBzSNbawA52FSGdoGyQtL6mGmKW5P8qtXSZ7+lNd
 dCm0zE+iQ1p/RWWyc1rtdWOu5kS2HyU6zgj7KIFe+SYUmJDf/vxQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvGLfIWkzki/EuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
X-Talos-CUID: 9a23:Ts6jim0qJvETZe/kvvUpWbxfGt8qUH/ni0zsBQy1JFppFqykWXWu9/Yx
X-Talos-MUID: 9a23:xujrkARfK7+NfJW7RXTltmBhF8Fn4Z+MJxEmlp8h59efLDBJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="71347900"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeDD24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:00 +0200
IronPort-SDR: 6538e324_DggGUANX/jrqBoGx0oGFxp6RILZHjWiQ7HkbaAvtfqaaEjX
 tFEz7emnYY0XArFoLUv3XZKvS2Y+F5IvYONMvLQ==
X-IPAS-Result: =?us-ascii?q?A0BEBgBB4jhl/3+zYZlaHgEBCxIMQAkcgR8LgWdSB4FLg?=
 =?us-ascii?q?QWEUoNNAQGFLYZBgiE7AZdqhC6BLIElA1YPAQMBAQEBAQcBAUQEAQGFBgKHF?=
 =?us-ascii?q?wInNQgOAQIBAQIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQYEgQoThWgNhk0CA?=
 =?us-ascii?q?QMSEQ8BDQEBFCMBDyUCJgICMgceBgENBSKCXIIrAzECAQGlLwGBQAKLIoEyg?=
 =?us-ascii?q?QGCCQEBBgQEsBcYgSCBHgkJAYEQLoNchC4BhDSBHYQ1gk+BSoEGgi2IHoJog?=
 =?us-ascii?q?3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGUQQXFiQJExI+B?=
 =?us-ascii?q?IFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEFBeBEW4FGhUeNxESF?=
 =?us-ascii?q?w0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDBIE2BQ0eAhAtJwMDG?=
 =?us-ascii?q?U0CEBQDOwMDBgMLMQMwV0cMWQNsHxYEHAk8DwwfAhseDTIDCQMHBSwdQAMLG?=
 =?us-ascii?q?A1IESw1Bg4bRAFzB51Ngk0gAYENJ4E0fZYuAa55B4IxgV6hCRozlyuSTy6HR?=
 =?us-ascii?q?pBIIKI+hUoCBAIEBQIOAQEGgWQBOoFZMz6DNk8DGQ+BG40FDBYWg0CPe0EzA?=
 =?us-ascii?q?jkCBwEKAQEDCYI5iREBAQ?=
IronPort-PHdr: A9a23:gc6kIR0z+RLqnuBwsmDO5gUyDhhOgF2JFhBAs8lvgudUaa3m5JTrZ
 hGBtr1m2UXEWYzL5v4DkefSurDtVT9lg96N5X4YeYFKVxgLhN9QmAolAcWfDlb8IuKsZCs/T
 4xZAURo+3ywLU9PQoPwfVTPpH214zMIXxL5MAt+POPuHYDOys+w0rPXmdXTNitSgz/vTbpuI
 UeNsA/Tu8IK065vMb04xRaMg1caUONQ2W5uORevjg7xtOKR2bMmzSlKoPMm8ZxwFIDBOokoR
 rxRCjsrdls44sHmrzDvZguC7XhPNwdemBodBwGd3A7DZpbV7gi5lud+0S2GJtz4Ro1vVnezz
 JV2YhXaqzkbGT0e7TntiZkj6cATqket+DJnm9Hafp+7bKBjdYXtT4IrV2ltGfdqCAdGHIrsf
 ZcyKtgwYcQDv6zEgl4L/USjIgWrCs3SkTthvmbbwKc20eV5MwPm1wIjI+9UlSXRpvLcJfZMU
 cnr9LGP8T/xX7Rc4zL867nxNQIimO2HVPUpc+iJ53AvCjGGqwSTm5fCOS+X1ucgk1qSt7V5d
 +631EMepAs2nWTo+9wrmKWZmJ9P5nT0qxxZ2qoNO/jtGwZrJN++F51IsDuGcpF7Wd4mXzRws
 T0hmdXu2La+dSkOjZE7zj32MaLBfZKB/xTjU+icO3F0iSEtdLG+gkOq+FO7gq3nV8ay2UpXt
 CcNjNTWt34M2hCSosiKQ/dw5AGgjB6BzQnO7OFDL00u063dLp8q2LkrkZQP90/EG0fL
IronPort-Data: A9a23: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
 BsbnYdWD7y+gRT/YZcUhu8=
IronPort-HdrOrdr: A9a23:rAnOHKtpP+sXlNTlEgkHMKFl7skDctV00zEX/kB9WHVpm6uj5q
 aTdZUgpHjJYVMqMk3I9urvBEDtexzhHP1OkOss1NWZLW3bUQKTRekP0WKF+UyCJ8SXzIVgPM
 xbEpSWZueRMbErt6vHCEvRKadE/OW6
X-Talos-CUID: 9a23:49GctWEwnTPqUw83qmJB2lQdOdEKQ0bnki2PIBSoVnpUU5aKHAo=
X-Talos-MUID: 9a23:c1KelggZK6Q+5EkY8iK+88MpaZdk76+OCx43mKoil8+tMjddOz6MtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="68486277"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:59 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:42:59 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.168)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:42:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqpIjms/NYp1U9pHDasUBGtcns2zDrTzpbmZ3s1F67VY6etH0S1qCH9KhDxC9XwyV1dV15DfoU163bU1j2HPTUwIWoX1msmvFgJm+Ef2BwZuxaOCnY3/2WJ9og3rLwkLYhzWH6kjHhaer1T83wv4feTc3dFbHOIgdCDQ2THqUUYsR9wOWYtVr+jpDBdpdaQejKwjFV8j7f51tjOgiUEMK6aqM9Pq7eEKmESOauuYUDJkMVCtqWBPUd6JCotT7bta2yPR7zD72hC5tKLA1tZCPP/QdSX1uMEJ+vSZdwbAzk0B9aEinkiwP/diRzDp8+HU6vWBzBjCPMtV5WxkSgt5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la0XwQPiL4K+HekaltsyfcU3g+yKZuBbZKvtFkOu0Rk=;
 b=QBak9s4qYpByf83gS7u0qFlZh5YK/C6Q/1robqsr9HdEFA06C/5D/MIxyljTeHYjd0osIPKC8xZsIwsOkiLTV82gkkxbhsArXPQ8RKzScYCDLOsA103CW4jdTLDxS4IyTe6/kSb0F9vnmSkL0zqAqDm5013xn1T8MKC5XAjDt+qTBhAL8sKWOw0DYxbn+sWyPmRaOTsLl3AQ/76w7x3Agw8DtSjRMGzTjjjYRvAfr7L95L0csEiecuecIifcRefZSQ2zOwddktarBPJoCKiLYE7ohZA8CGT3GRpGZsBlSHqx6BaF3mkV77qqCCGQMZukXTOu2+UwiptwgDMF25nrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la0XwQPiL4K+HekaltsyfcU3g+yKZuBbZKvtFkOu0Rk=;
 b=d7Fp07fvvF02ucNXZ9YzkD/YS7Cova8ztUMZY4J3xMQMmm87uOdofFU3lAPqEubdji0JjHcfkTU2M9mbOAy96hA6Pp/TbZX/bRmikYQ/zkQtca/1jJ0FQhuZ+M9kZsOntjhkEHZa07qJdp7EQgb/W4/UsozD8vu2DLX6QHrDPvM=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:42:58 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:42:58 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner
	<brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
	<paul@paul-moore.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
	<amir73il@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [RESEND RFC PATCH v2 06/14] block: Switch from devcgroup_check_permission to security hook
Date: Wed, 25 Oct 2023 11:42:16 +0200
Message-Id: <20231025094224.72858-7-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BE0P281MB0116:EE_
X-MS-Office365-Filtering-Correlation-Id: ac42e99c-262b-4c25-733b-08dbd53ec5b1
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LxokPclv89QKj1UIGoSMqhDLjoyO45hVrJ+uFd0/PXAWKEGPTQ+ik258KpGHufB50OwQCs9aGc6RXb/Vt7U57kGoqhBB1yqkLW36NWgyML+N4XC0X0O9pe936e/yJp2FX2ABz3fDYJlbg07e8R3Tc3OzsNQmAPy4556acPft95aQPZEf4G0xsE8gr8KpGzJISKiJFVvm2WYZkRlE4oAjjQmtT4i4/kdZGJDel+WcKFcDGq9aNTPDOGB/aJDVnzN+E1oe2FQWQnPUVD8MhUToCPpB5cf3lJ61U84g98SaMALhhc6yHYgZDSzJ2gHrcCmP2RkFnZg70SZw81li3KgQi3ujrkgS0B0I591X0JjK7mawntiC4RcJBV7s5MFTS3Dj37hIpng1JNS+BsLYDQCYVGmQ0F7N2l566B11PD3OSb+b2Z0Nj5m5PnTw3mFFJe1BIA1Y6UtAkOeoiiPQ9ucSxJTIdcMkFh3QvRjYb5xwJRnaTzsy/h7DphyqZKNdqfgWD9c98RMHB/0B2AcJQJA9gonUn770j3q5sp0kSxW4sN+2xHAbak1RI0EqAtXxswqrVJdEQ0EDsu9ISKf1evYwMBqvMg4FQvGPMmt3h5sRrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(15650500001)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlQ3T3k1SXFwRDZ6Tmw4cktqZzZQV3BITzRKM2Y3RFpwQ08xcklKSnlrZzIw?=
 =?utf-8?B?ZnVvcFBPVy84RmJsaXMwUGdEeVpacEllWHR1M3huV1krcHlINDRpaE94Tm4z?=
 =?utf-8?B?d3ZsWDQxVnRTYll1dEtXd01vOS9NWVlLSHVZaDMwMWlqVit4c3l6R0ZtZVda?=
 =?utf-8?B?QmdyS3dzdWxSdGRKWnYyaVYxQ0k1YkYwV1Z4Z2MxcnB4Z1RXUStYdVJCVllx?=
 =?utf-8?B?Tjc2YXdESGRJYmppWkd0Z29lQ1RTZy9GT3FtVTJCU0RHdHVLc1MydmtMWjVq?=
 =?utf-8?B?Tnd3ejRUTDhTWWFOb20wUEVobWk0Z28xWHlsQmRjeHpTVDhqUGYwcnZpVHFR?=
 =?utf-8?B?OGhvdklDSG1ROHhNTUUwYmVJU2RxQUU1ZjJxSDgvb0RjcitVNUx0bWZ0aVdz?=
 =?utf-8?B?cjdaM3VITGFFOXd3cjhCY0YyVCt5R2JVM0NVTWd2WGZHUDZvZmd2SEI5T1Y3?=
 =?utf-8?B?TUhNOVROVjY2Y2RsNDJpV0ZNcnFNOXpIQlBvTERIRzRYVXNBRUU1WHVwQWZy?=
 =?utf-8?B?WUQ0dEtrR3FVNEd6ckhSOXpjZzM1Zm5Hc29haGRCWGdwcUw0RGpzaVFYSXFQ?=
 =?utf-8?B?S2Nxc2tWUG9EYVV0SmNWQjJNUkRUeGh0dTRUWVJ6VVlXTVR2UlpNVThqTXdz?=
 =?utf-8?B?ZGxjQkxuOXBwVXdGMFZoNjYzUDhnQnJaWmNTcCtFb3kwYW8vWHRLQzRSODFI?=
 =?utf-8?B?eXgyb0paa3VscW1pUktSMVB0dURJZEZlMmtqTmRoV3lEYWNodDZoRmM0WHhS?=
 =?utf-8?B?NXl4WmhONEo0SVA5KzBPNnJSTWhzM244VG1NVzgwQklxRHdvb0d2NzNkM2E2?=
 =?utf-8?B?MkVuNHVaS2Iva1FpRTF0VzUxckp1dG9EWGdkd3FmL2t2U2VsKzVKclRseGdo?=
 =?utf-8?B?cDdoK0Y3V0VzbmJHWUlFbGlrQkhLY2Z2ZTVOVTMxYmY5NzkvM1M2dXBqMGs4?=
 =?utf-8?B?MTN3U3dwTWJmOUhJNjhCL0prMzNsUkhrN3dJRkpsWXZKV2FjQWt5ZDF4T05C?=
 =?utf-8?B?M0Z2TUhTcFhEOXFWUmRoWWdJQm55M1FWd0RndWZoYlNNTy9HVG1RK3BrMCtl?=
 =?utf-8?B?VHg5Yy9BSlpNc3UrU2I2dDlHdksrbjV2QzFmUnQ0UWpNZlVWSGtpNm9zTm9F?=
 =?utf-8?B?dUJodFJta0l1dGM4OW9TMnJlMjU5V1lHdDlLSjJqSnZvL3pLM1dIMjF0a3V2?=
 =?utf-8?B?WVFJc2FhSHJFMU54VTQ3c1Y0a2VDRFJwQ0Vrbk9rWHZ6bHUvL05xR3M3bFVz?=
 =?utf-8?B?cFYyK2lKenZtb2ZUUUxMS1dXc0phSUNCTFZETFltUmZUSFhIdWJxSzhDdHpX?=
 =?utf-8?B?VmtUSFhXYzExL3FPZXQ5SHFZV0ZzemtuYkxzQ3FXVXBNR1c1TXR4SzFXeGlv?=
 =?utf-8?B?L3dDNHRvQnE3ZnlPNGJQQ1ZmYWNIWWd6NkloVHJkb01xNUFQUFozQmFRVkRy?=
 =?utf-8?B?R0dTZFZsUmZ2SEUrc2JZb0pZem9Wc1d3S091YzFFRm8zKzBOVkZCU2VGN3Nm?=
 =?utf-8?B?T2J2V2N3ZEJ5SnFDRE8vTjRBNWg5aEJGR1NoOFdxbENVRDJCQ2g2ZEF6bzQ1?=
 =?utf-8?B?Tlp1THU5SHNtT2hqT2Q0a3dESnZkYm42cHI2RldSdnlBc0xybjNFMmM3ZGFj?=
 =?utf-8?B?cnEycVUwUTV6aFh5dzJTMURteFVsU3lFYUJmZk9iZHVBOWlIVEM2NTI2dDVV?=
 =?utf-8?B?dnpuQ01vTW16N1NyTkVoZTVINGwwNndqU010TU0raS9SWjlrRk1QQ3haL1ZF?=
 =?utf-8?B?bW55aXMwUnZIUExuUzNqR2hxQUQ4OHhQa0pZWjZuZVpDVGF5UTRaNHZTSUVa?=
 =?utf-8?B?RTJJZ3NBcWZMVmt6OGRaS1dueTFqa2tURzYrVlZvNElVaVBYdHpYVTlwM2dN?=
 =?utf-8?B?ZUUrQ3E4VjdKbGYzVU8xcHlUd1J5YWRtNDBibThEQ3BNRENwSFFWK1dWdlVy?=
 =?utf-8?B?OU1JTmpSKzlaVG02UTBPcWtrdVZkekl0NDlDUnhrdHZTcXBYS3RlUTNXRTEy?=
 =?utf-8?B?Q3ZDS2lLczRjOW5QWXpiaGpoczAzTy9CNFBsOVJZOFJObmFSd3BlN1l4aWVx?=
 =?utf-8?B?VElIZ00xbyt0cDFRblJKT040QXJoNmhuK2tpMTF2NzNsUkV6YnhwdlBuT2hZ?=
 =?utf-8?B?eURMSmhqRGdnNGFRdVUybHk1OVQyckxOL2orZHB5T2wxcW5KV3dscmkrZC9k?=
 =?utf-8?B?WittKzVrenhBNzczZkphRDNtYmVqdU5wMjMxUTN2V2FuNjhWNnB2Q0VZajFM?=
 =?utf-8?Q?fYATk58lTIKnyZAF2wsIMZVFAbZOtAU3WAFtzNlwqI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac42e99c-262b-4c25-733b-08dbd53ec5b1
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:42:58.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6cb3h8jL2TwWkg39T2EApG5kUW9tOA7sARXaoURhB++RNw0p5V1llkySFOH9OyIVa9NMuCKedeudF2S+A83u+4VgDum80S2gwCOEd12P/ALbJkGzSo858hvA3GLoqcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

The new lsm-based cgroup device access control provides an
equivalent hook to check device permission. Thus, switch to the
more generic security hook security_dev_permission() instead of
directly calling devcgroup_check_permission().

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 block/bdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d4..fc6de4e2a80b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -10,7 +10,6 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/major.h>
-#include <linux/device_cgroup.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
 #include <linux/backing-dev.h>
@@ -27,6 +26,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/stat.h>
+#include <linux/security.h>
 #include "../fs/internal.h"
 #include "blk.h"
 
@@ -757,10 +757,9 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	struct gendisk *disk;
 	int ret;
 
-	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
-			MAJOR(dev), MINOR(dev),
-			((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
-			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));
+	ret = security_dev_permission(S_IFBLK, dev,
+			((mode & BLK_OPEN_READ) ? MAY_READ : 0) |
+			((mode & BLK_OPEN_WRITE) ? MAY_WRITE : 0));
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.30.2


