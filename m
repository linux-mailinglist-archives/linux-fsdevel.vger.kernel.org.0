Return-Path: <linux-fsdevel+bounces-5904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC138114D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B20D2818CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7A2F859;
	Wed, 13 Dec 2023 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="WkYYSKaI";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="ADbUTnch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054B4DD;
	Wed, 13 Dec 2023 06:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1702478327; x=1734014327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fBGOTfZY/o/A6MXWqtrZ2pIBlMj1OKBCD9LPgcpMKac=;
  b=WkYYSKaIalncNUsUqxvdGdY9sHpG/iu5VKeMXyDnj0gu8s2UYvh80/u1
   3H5vnRItHewtnnh2wmqdKn+imquO2dGFitmAvo5xJ17xHKXZsTgUIkdK8
   kYHLtycXy2CG8tDPyj42MUZZmHm1jMA23QxCxmYEpCk9DpMX6NGBP2xm0
   CP0EWMIENCIwYpya/zo1z7tdRLuMy5q+bf3gPA3vZUGj/9EHfmYSrtN+f
   DzvSCepEQ/BzpOJQPu4ubVZaFAbDjuWzeOWZ8Nw3sunjxKkM9aDngzQ0P
   +EPuHWwhSsiRqmZvuIeZyrXonwQMXt93aifBFTzQhBa/57IEXHwmJFQ0S
   A==;
X-CSE-ConnectionGUID: P/ZU4PSvRL6FaWWckXZprw==
X-CSE-MsgGUID: EV5zJoBOQkWQecf95iGCYw==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2ElAADxwHll/x0BYJlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4glmEU4gdiUacKyqBLBSBEQNWDwEBAQEBAQEBAQcBAUQEAQEDB?=
 =?us-ascii?q?IR/AocwJzQJDgECAQMBAQEBAwIDAQEBAQEBAQEGAQEGAQEBAQEBBgYCgRmFL?=
 =?us-ascii?q?zkNg3mBHgEBAQEBAQEBAQEBAR0CNVQCAQMjBAsBDQEBNwEPJQImAgIyJQYBD?=
 =?us-ascii?q?QWDAIIrAzGvEH8zgQGCCQEBBrAjGIEhgR8JCQGBEC4Bg2GENAGERYEhhDqCT?=
 =?us-ascii?q?4EVNYEGgi2EBlKDRoJogVOCE4R6PAcygiGCdF2DOD4ljRt9RloWGwMHA1YpD?=
 =?us-ascii?q?ysHBDAiBgkULSMGUAQXESEJExJAgV+BUgp+Pw8OEYI+IgI9NhlIgloVDDQER?=
 =?us-ascii?q?nUQKgQUF4ESbhsSHjcREhcNAwh0HQIyPAMFAwQzChINCyEFVgNCBkkLAwIaB?=
 =?us-ascii?q?QMDBIEzBQ0eAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANpHxoYCTwLBAwbA?=
 =?us-ascii?q?hseDScjAixCAxEFEAIWAyQWBDYRCQsoAy8GOAITDAYGCV4mFgkEJwMIBANUA?=
 =?us-ascii?q?yN7EQMEDAMgAwkDBwUsHUADCxgNSBEsNQYOG0QBcwekZyUgATxRAYF8DU4cl?=
 =?us-ascii?q?hcBjByiaweCM4FfoQ8aM5cxklaHb5BUIKJGhUoCBAIEBQIOCIFjghYzPk+CZ?=
 =?us-ascii?q?1IZD44gDBaDVo96dQI5AgcBCgEBAwmCOYgpAQE?=
IronPort-PHdr: A9a23:QG474R+2rfNSL/9uWXO9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8Wxx0LLDTf8kzqZLzJrnegl/c6gRbdN8fMUoEvch6I7
 JhPQUPTrB4iHmQ/4lyC2akSxKgOiT6rmiB5yI70OLvIbuJ4UYjlf/ozak9uD+VrSyVMK6jjf
 ZoIPsQ6LLlAvY2itWsWjDK3XDKjWeDvlDtJrWX3jKln8r4ASwfa+BN5QvshvHv0qNPOC44vc
 sHsi4nywijtTc1N0zbxtJDSawIwi6qvDeopfurW8UskRi/ihWeMuaq1IDKU8P03olig17s5U
 u2ft1R7ghxhsBrz/d1rl4TXiYM+4wnf/hRa0IdpcI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0HxJsqxBeFN7qJaYGV5BLkWuuLZzt11zppe7O60g676lPoivb9Wc+9zEtQo
 2Jbn8PNuHEA212b6sWORvZnuEb08TiV3h3V6uZKLFpykqzeKpU7xaU3mIZVukPGdhI=
X-Talos-CUID: =?us-ascii?q?9a23=3AaIYws2o7Y/kVfHlCd0foPl/mUfhiQECB9EzOGWv?=
 =?us-ascii?q?mJ29Wd7aWeW2I4rwxxg=3D=3D?=
X-Talos-MUID: 9a23:I466hQkFeJUGhUh1xFaGdnpPCpp6waOEL3kOrqwLsMfVaC1fEAaC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,272,1695679200"; 
   d="scan'208";a="5192953"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:38:44 +0100
X-CSE-ConnectionGUID: 1sZalnPLS3C4g3DKMY97iQ==
X-CSE-MsgGUID: nW3SOYqaSbugn0zBDGauWQ==
IronPort-SDR: 6579c1f3_PjPxJ/FApAP9GnbEAKH6XO7j3/p003LpLTU3Ez2JPGpRrOd
 4LeLY8Ux3WiQirCOpr1j7iArnSU/zQwXgdL45VQ==
X-IPAS-Result: =?us-ascii?q?A0BCAABtwHll/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBFgcBAQsBgWZSBz6BD4EFhFKDTQEBhE5fhkaCITsBnBmBLBSBEQNWDwEDA?=
 =?us-ascii?q?QEBAQEHAQFEBAEBhQYChy0CJzQJDgECAQECAQEBAQMCAwEBAQEBAQEBBgEBB?=
 =?us-ascii?q?QEBAQIBAQYEgQoThWgNhkYCAQMSEQQLAQ0BARQjAQ8lAiYCAjIHHgYBDQUig?=
 =?us-ascii?q?l6CKwMxAgEBoiEBgUACiyJ/M4EBggkBAQYEBLAbGIEhgR8JCQGBEC4Bg2GEN?=
 =?us-ascii?q?AGERYEhhDqCT4EVNYEGgi2EBoQYgmiBU4IThHo8BzKCIYJ0XYM4PiWNG31GW?=
 =?us-ascii?q?hYbAwcDVikPKwcEMCIGCRQtIwZQBBcRIQkTEkCBX4FSCn4/Dw4Rgj4iAj02G?=
 =?us-ascii?q?UiCWhUMNARGdRAqBBQXgRJuGxIeNxESFw0DCHQdAjI8AwUDBDMKEg0LIQVWA?=
 =?us-ascii?q?0IGSQsDAhoFAwMEgTMFDR4CECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2kfF?=
 =?us-ascii?q?gQYCTwLBAwbAhseDScjAixCAxEFEAIWAyQWBDYRCQsoAy8GOAITDAYGCV4mF?=
 =?us-ascii?q?gkEJwMIBANUAyN7EQMEDAMgAwkDBwUsHUADCxgNSBEsNQYOG0QBcwekZyUgA?=
 =?us-ascii?q?TxRAYF8DU4clhcBjByiaweCM4FfoQ8aM5cxklaHb5BUIKJGhUoCBAIEBQIOA?=
 =?us-ascii?q?QEGgWM8gVkzPk+CZ08DGQ+OIAwWg1aPekIzAjkCBwEKAQEDCYI5iCgBAQ?=
IronPort-PHdr: A9a23:hbo4YhUkdSStn6SMds7S6TRM0LTV8KyzVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsL28QTGrPQgyBOxBdGqF5EpHm2dq
 K1hcgDZkwwtHT0G1GiLsehJqYsBpgCc8k8aocbeNai5PsdCeKjdXYsgGDBZWOl6by5oK6yZQ
 NosNfYIMM9z8JvsoGoglgrhHRuoW/Hf0h5hjybN0vA507olECrc3V0kQvNUkS7SsPHqbfo7f
 uy67K3O9grqUtB3gHDd0ofVXDIfuvuNUe5oa9PD2GN0NFOd11qwrrTnNGK58e8/r3i9v/VhV
 MS2sX8XkDkg+z+g9vsW1qDUlpA3lmvesjh03ok0DvThU0VKQs6lTM4D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCdpSBwTu5BaCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
IronPort-Data: A9a23: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
 uWEuBDS3Hi4FX0=
IronPort-HdrOrdr: A9a23:eS5elKngTr+RlPiUraBYzXbC2KHpDfLS3DAbv31ZSRFFG/Fw9v
 rPoBx4vSWftN91YhwdcL+7Sc29qB/nmaKdg7N+AV7KZmCP01dAR7sC0WKN+VLdMhy73vVc3q
 8lXrRkANb0AXR/hcb+pDSiG9wjzMKm/cmT9ILj5kYoZRprYKklyRx4BAadGlB3QwcDLYMhEZ
 qX7tdGoT3IQwV0Uu2LQlEfX+PK4/vRlJznZhYaBxkorDKDhTatgYSKcCSl4g==
X-Talos-CUID: 9a23:qGw4O2F5w1yuGbkYqmI+73wdHsYdVkaG5yvfeGObLFc4F7ysHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ARlecQAxO1rKLfzirZ1q8Sq+A4emaqKKRU3sqoIw?=
 =?us-ascii?q?PgMOZOiooKR2xoz2qfbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,272,1695679200"; 
   d="scan'208";a="804750"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:38:42 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 13 Dec 2023 15:38:42 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.168) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Wed, 13 Dec 2023 15:38:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBwayfhh0YN0OKbdUUhT/e77vBk2MCWwZX1XCaE2BmjMU5liR+LQV+zQNMfgRd6oO2BA9DaK6bU4mpL27BdXdwMkQ4HcCKYWVn6rCLYh5JOY2yDBD+1H0iSmylDSQW+OspWwaS9/BcPJUG466hpgZHrJJLxZbeTnXJ4q8ZuGlY84xJOSpQ1IixA5gfqExXKNX/7Fdnb+b8ygqgNpWMMaP894DeW7dk9BFgfopFB4oBey9qkl2mqORWRmX+cr5UWvae5FP1ubOtX0mpHUu5tcVMrzJ+aU+4CLe3eRg4h5DaOQyTAF0581HUJXMAi5T0leiUYi9A/0WlZRKGiGrvBeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+GTrv5xRCPt42Iu/1W/bbRwYsCBBkWLa4SLQMA2nzU=;
 b=c1axGrYg3nNwqGnkHdRLUH9kw2ZaZvfwjv1Q3Apq3Hoir0kAh31yPjnIbpUwUdsRfkzdtAykA1iJMdDb17JFXsYpuipeccxLrx3w7yxPdawaI0wPtWQk1ZVzIciAFs0H7bcMI8toSgneSp055IsnUgXmx3ZJvMrkWker1AlQqxVBuzgYZY/7kCEN8hsnDaTnaoNTqwKYt9S9anTtbdCPDOadljNAEaRDeTByBFe0RVhPV0QW/XnlTI8d3lIthCJPApAio1AVmzpNWmEGtsiieN71zgegke/gKhMR8Dg/E4IYVOvHHK3eWAKDHW2tNVMGXC/dgmHRfzXkvgFLo3dI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+GTrv5xRCPt42Iu/1W/bbRwYsCBBkWLa4SLQMA2nzU=;
 b=ADbUTnchH0R52pnGCPjAAGMG9KRtaeAC7zyoYFSy7pzl7zXpIAa1Sg5kh6liCri9l5I2I2ntLw15AGdgHlnSWAUKI1/HRguFJVsbid4prqzyB3K801gHoPjc9DOcZtxN8wiiNqRyXSP91ogXTR4AuxzJ4Sr/uevgiCA1scYKxi4=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR2P281MB0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:38:41 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:38:41 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
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
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<gyroidos@aisec.fraunhofer.de>, =?UTF-8?q?Michael=20Wei=C3=9F?=
	<michael.weiss@aisec.fraunhofer.de>
Subject: [RFC PATCH v3 3/3] devguard: added device guard for mknod in non-initial userns
Date: Wed, 13 Dec 2023 15:38:13 +0100
Message-Id: <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FR2P281MB0026:EE_
X-MS-Office365-Filtering-Correlation-Id: e944c049-f14d-46e7-3a43-08dbfbe9335a
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqscTcZr0vvPN8GzE21vhgJ3/Rk9QZNLl42t4xQNkXWSh2s8hK+i3nxJ7i81T+5VF7fi5GTDLtRcK4rXR+nIaywztHyEUBPeUYV9VJkj1w6y4PUrF8Xnz3rdPyksDk1Y/+pVjtspgiLI9aE6SU1e47Q6J1h5xcyW9sZ1VTkDe4Zn34loOCLg2uaGL3MVYGH70SNx0LhfufJw0iaMZfekwBO9SZAdhdjUwnjga1qSKFbJsfw5p+5r1KTMomG5YRg/LAJf2jOdyqpa2givu5ftpzmOAdGNVBtPH9J2pQeCv9i4/rPZXWBCrTXSwEwxSCILNU6/oqbMjsk4O0p+sGa1R9GZZYThp2Bn3haMdl6weFXUKNLYp2shT7Rcm3p6P/gfeNuiRYuLOHtePITYOWllNlxfDUh+FmFYXAtbG9o+IvTaiS7ZQAKezFiMWgyIBZCCDERLgY3kl23iHKGkoYAZInbANPFGFmEXDwXKRU7rkq69jGi+1xmrNji3HdcXNATyWVjYk+32p0U0xvLLqaHrwjM5iYC8v8G1Bd3tOdXLInYBHeADNgVTAjRBwvua22GjeSd3q51sKYw8R1Qf+MAw1t//jEVMXLfCnMAyQgqbvHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(107886003)(38100700002)(8936002)(316002)(54906003)(8676002)(2906002)(7416002)(4326008)(5660300002)(66476007)(478600001)(52116002)(41300700001)(66946007)(6512007)(6666004)(6506007)(110136005)(6486002)(66556008)(2616005)(1076003)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5FNURreFdkMjBZQ0hVU1R2NVowVHV2K0RtK3NhcG4ybSs3YjRyNDQ2eHlX?=
 =?utf-8?B?Y0ZDQWR3RmdJQWw0N29ka0tWVkRWZGcvdkZMWEEyK0RPN0NzWE54bHV0VW1m?=
 =?utf-8?B?Z3ZOZkoydWlXWmIreExycVIzZzg1c3Z6SDJvTVJNQncyTC8rUUpoeitUODBN?=
 =?utf-8?B?UloyZTlYOWR6dDFZaWNWQlNpOWhyNXBydDlaYlJEQTBjV0VkT3JPUmpndGt1?=
 =?utf-8?B?ejFvVnNpTkRpNGk2dnNVYit4MFRERjhTTFFqeklUSXprRUN3cEZwdmhOcUhD?=
 =?utf-8?B?N2k5cXBGVXlPOCtrcjVtbzhheHlobnlKd1dvNVZWem1aZXkwbklONHQzV05w?=
 =?utf-8?B?a21xUFpqL2JWd3p2SUV1YUtIR3ozVGg3bFdqa1RuT1lRVzA0TFpxd3FzUlk5?=
 =?utf-8?B?Y2thWFNNS1phb2R2WTZuQStDUVVQVmtJOXZWamtvUitDcmREYVVRQTY3QlFu?=
 =?utf-8?B?TVJpRTZrN1J1Y0dpTzhzUXQzMHZXOXF0QmV4eG9BaXB4MHJudGNkZnRnUHJN?=
 =?utf-8?B?S01URDNWNHNSa1RHWncwZHhGRDJFaTRuNFhNcCtMamRldlpwdEdPZGdwbTdx?=
 =?utf-8?B?aFQ3cGZlOUJVSUlYYnFOQzY5cXRDMGtZOTdTeEtQKzk4UnlKcXBSMlhqdEUv?=
 =?utf-8?B?WkpxSi9nVnM2ZzhSL05IWjVJK2JzcGtRbURLMUFPdXFoUFVjZmp6THhUa0cx?=
 =?utf-8?B?cFdOZysvdS9OZnlOMi81aURHM2doRi9Sbm9XTnVuazVIemhmU1h3cHQxZDNG?=
 =?utf-8?B?T2ZSNHQyRlhLSlArUzZiTkpydlpVRm9xTzFWQU5YT1d2TVpmN2hIMVlVdzZI?=
 =?utf-8?B?c1J5TDVDQmhGVXBIWDFaVmlmS0VDWXNNQXY0LzhCZk44dk1RZEhJN3NTNUIy?=
 =?utf-8?B?UG1jUVVCaXNPVE1kWFpHWFpObmxVS1h4S1M1dVRzOEZ2azZOZUF4d1VlT0Nk?=
 =?utf-8?B?S0U2ZlEwNWJsbzRjb0xyVWJ4bkFDaGZndG15Um9TK3hVOTdrc0tLWU5HeHVX?=
 =?utf-8?B?akRLRzVJSXk2MFEyZlpiV2FXQUNrR21KajhMMGc5VllOaTEvb25CV0M1eEZB?=
 =?utf-8?B?ejZzUzM4MjE0VUc0aWZIdkdXa1FZb1ZhcGd6RFlTcC9vRmRVQU9KR2xXMUx1?=
 =?utf-8?B?S09Gekxxc3k0M2k5bTBMbStwQ2dWV0QrYkNYOC9YYm9kWmVJVkYxcmdDdE5i?=
 =?utf-8?B?MzBYeXZyZVZ3YWU3WSs2bkRlbkFYSzh0SXRTMlJic2RmL2pUeW9yWjJkRkJN?=
 =?utf-8?B?SzVvVmJXYzVjWUJlK2dTRGs2MUV0R3hZUjdORmhsQ0M4NjhaQjVBc2xrTlda?=
 =?utf-8?B?MDRKd1FhemFFd3F1aTdmS3dFRXJWSDZ0VHhjWjhWOTM5RlZhbUtuMjhTMzY3?=
 =?utf-8?B?Vmh3UkRwR0ZYTjJqMlovZEdSbVNmeDU1aWZtRjlEeHJXSENQaUU5ait4Mlkr?=
 =?utf-8?B?dGgxS0JuZWpqK0JPakxaMGM1UElQT2Y2dFY3bHpzeE5iVlgyK0Z1QW5rbG56?=
 =?utf-8?B?Mm10cmEyYjBFc3JpWTlxbTVYQitudHBBaTNDaUNBK3hjRWEvaWFtZDBjcS81?=
 =?utf-8?B?MzV3bE5haGNubWwzMjFYTkhwcjJ3ZnF4Q3lyMU5qeXhwRzNoOHRQWnZmdHdB?=
 =?utf-8?B?QlZ5TW5ORXZhb2dUcU9oaW0vUmFZWStXMHdGNzErd3JtSTU0R0ZHTXJnc3Zk?=
 =?utf-8?B?aVlVVS9nT2lKYVg0aUg2U0hrNW9OY0doZTZPZTlERFJwQmRFaDhlRTFiUU5H?=
 =?utf-8?B?TCtmcmgvZG9mMHlPMlMwSFh6eDFLOC9pZjV1NlVpZks0N0VKWUhmRFVWUDBY?=
 =?utf-8?B?ZkxlZHE0U0grdDhvOEx3ZGhIM1M2Ulhyc0FjQnFmRk9IKzZWTEk5d2VwL3ZP?=
 =?utf-8?B?ZjU5ZEJLeU9nckpjc3NsYm0rY0FESFlPNXR0Mml4ZExXVFZvMHVFS0hIR3ND?=
 =?utf-8?B?ZTY2WWhNYTNoNk5lajBLZkcwd3NiR1U3MmNRejJzSVdCQkphT2tweFhORGFB?=
 =?utf-8?B?bVUwTzlCQ2VGdDRQRXBISzl6dVh2bnVjT2pLY3k2MUU1Q0g4RzFlR0IxVnFX?=
 =?utf-8?B?WjlYTWppRHFrbkZWZ2liUEJQQThCbVpwZXRzZkR1eit3cTZ2VVpacUNYaW1I?=
 =?utf-8?B?VHpDYzk4L3JueVE1Umx5L2xiN21yN1A2ajZaQjhOMzlCZjdyODFrTmowcE4v?=
 =?utf-8?B?MHJHbW0vSDBNM1N6TG90aXZnWEZoblJyVk5pNlZna2ZZdTN2R0ZwK1JqeUZl?=
 =?utf-8?Q?EYUlW3cOClGfDCUqJI3LMOVcENR+KoFfsMhUL/a4L0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e944c049-f14d-46e7-3a43-08dbfbe9335a
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:38:41.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ez1huEXXHG6DmmwhKA0c1uIVf/lfkGVJKTVDHk7hn3N9xTSaxyQKTVuiBvtgw+z0JgrU6WUlxL8DwunpZd0hHuzLsIlOQWTK3usQ32a5zu/IJh34w76VvlJ0fgv4Veog
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0026
X-OriginatorOrg: aisec.fraunhofer.de

devguard is a simple LSM to allow CAP_MKNOD in non-initial user
namespace in cooperation of an attached cgroup device program. We
just need to implement the security_inode_mknod() hook for this.
In the hook, we check if the current task is guarded by a device
cgroup using the lately introduced cgroup_bpf_current_enabled()
helper. If so, we strip out SB_I_NODEV from the super block.

Access decisions to those device nodes are then guarded by existing
device cgroups mechanism.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 security/Kconfig             | 11 +++++----
 security/Makefile            |  1 +
 security/devguard/Kconfig    | 12 ++++++++++
 security/devguard/Makefile   |  2 ++
 security/devguard/devguard.c | 44 ++++++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 5 deletions(-)
 create mode 100644 security/devguard/Kconfig
 create mode 100644 security/devguard/Makefile
 create mode 100644 security/devguard/devguard.c

diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..7ec4017745d4 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -194,6 +194,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/devguard/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -233,11 +234,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
+	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf,devguard" if DEFAULT_SECURITY_SMACK
+	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf,devguard" if DEFAULT_SECURITY_APPARMOR
+	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf,devguard" if DEFAULT_SECURITY_TOMOYO
+	default "landlock,lockdown,yama,loadpin,safesetid,bpf,devguard" if DEFAULT_SECURITY_DAC
+	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf,devguard"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..82a0d8cab3c3 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_DEVGUARD)		+= devguard/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/devguard/Kconfig b/security/devguard/Kconfig
new file mode 100644
index 000000000000..592684615a8f
--- /dev/null
+++ b/security/devguard/Kconfig
@@ -0,0 +1,12 @@
+config SECURITY_DEVGUARD
+	bool "Devguard for device node creation"
+	depends on SECURITY
+	depends on CGROUP_BPF
+	default n
+	help
+	  This enables devguard, an LSM that allows to guard device node
+	  creation in non-initial user namespace. It may allow mknod
+	  in cooperation of an attached cgroup device program.
+	  This security module stacks with other LSMs.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/devguard/Makefile b/security/devguard/Makefile
new file mode 100644
index 000000000000..fdaff8dc2fea
--- /dev/null
+++ b/security/devguard/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SECURITY_DEVGUARD) += devguard.o
diff --git a/security/devguard/devguard.c b/security/devguard/devguard.c
new file mode 100644
index 000000000000..3a0c9c27a691
--- /dev/null
+++ b/security/devguard/devguard.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device guard security module
+ *
+ * Simple in-kernel LSM to allow cap_mknod in non-initial
+ * user namespace if current task is guarded by device cgroup.
+ *
+ * Copyright (C) 2023 Fraunhofer AISEC. All rights reserved.
+ *
+ * Authors: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
+ */
+
+#include <linux/bpf-cgroup.h>
+#include <linux/lsm_hooks.h>
+
+static int devguard_inode_mknod(struct inode *dir, struct dentry *dentry,
+				umode_t mode, dev_t dev)
+{
+	if (dentry->d_sb->s_iflags & ~SB_I_NODEV)
+		return 0;
+
+	// strip SB_I_NODEV on super block if device cgroup is active
+	if (cgroup_bpf_current_enabled(CGROUP_DEVICE))
+		dentry->d_sb->s_iflags &= ~SB_I_NODEV;
+
+	return 0;
+}
+
+static struct security_hook_list devguard_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_mknod, devguard_inode_mknod),
+};
+
+static int __init devguard_init(void)
+{
+	security_add_hooks(devguard_hooks, ARRAY_SIZE(devguard_hooks),
+			   "devguard");
+	pr_info("devguard: initialized\n");
+	return 0;
+}
+
+DEFINE_LSM(devguard) = {
+	.name = "devguard",
+	.init = devguard_init,
+};
-- 
2.30.2


