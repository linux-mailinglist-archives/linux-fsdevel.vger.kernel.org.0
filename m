Return-Path: <linux-fsdevel+bounces-6602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BCA81A763
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 20:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4771C22CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86906487AE;
	Wed, 20 Dec 2023 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="YE5xaskY";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="b5Mjxl+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeDD24.fraunhofer.de (mail-edgedd24.fraunhofer.de [192.102.167.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F5482E3;
	Wed, 20 Dec 2023 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1703101515; x=1734637515;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OWn7xJIkJCGh6ZIaJNI0h9xHdu/Mh3GaZV9RmqKnRd0=;
  b=YE5xaskY/sXTlV91lLClpND0zEwm0SRCh/+XPG4StkWOScjuwyFMisNe
   FlocK5sq3VHfdQJ1u4YDDflBUF0oT9zZTDF4bB7krNveGKtgxdv3SnoEm
   VOe9sSuYaSPTutQh8ROOcX0PHKv4g/cIq3wST3HN3n3/QMwk/OLjpJ7O6
   ryvFQuCA1UjQqoNsigRf/xwTG8PXK5TFC3EJUnezf61WuHGhDj1PhKDbD
   99u7mbt6+4EtMDP/eHoRIBQfhta7hG05OYG8cIthzw2r8YpQP1/mhm+gq
   Vtj5XWtcUJUf8F8FdvjS03BdN7KxdmDV8U70+Bbz+l+qQ7HvmeA59KtaW
   A==;
X-CSE-ConnectionGUID: 3lKIT/alR4O/uiF/mKFnCQ==
X-CSE-MsgGUID: sNQVInihSkm2zh/JCDRqfg==
Authentication-Results: mail-edgeDD24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2EDBQDYQ4Nl/xoBYJlagQmECIJZhFORYwOcVYJRA1YPA?=
 =?us-ascii?q?QEBAQEBAQEBBwEBRAQBAQMEhH8ChzUnOBMBAgEDAQEBAQMCAwEBAQEBAQEBB?=
 =?us-ascii?q?gEBBgEBAQEBAQYHAoEZhS89DYN5gR4BAQEBAQEBAQEBAQEdAjVTAQEBAQIBI?=
 =?us-ascii?q?wQLAQ0BASkOAQ8LGAICJgICMiUGDgUCAQGCfIIsAw4jrGZ6fzOBAYIJAQEGs?=
 =?us-ascii?q?CMYgSGBHwkJAYEQLoNnhDQBiiKCT4E8CwOCdT6EWINGgmiBU4dIBzKCHYNQg?=
 =?us-ascii?q?zZjhhWHQlsiBUFwGwMHA38PKwcEMBsHBgkUGBUjBlAEKCEJExJAgV2BUgp+P?=
 =?us-ascii?q?w8OEYI+IgIHNjYZSIJaFQw1SnUQKgQUF4EPBGobEh43ERAXDQMIdB0CMjwDB?=
 =?us-ascii?q?QMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMAUNHAIQGgYMJwMDEkkCEBQDOwMDB?=
 =?us-ascii?q?gMKMQMwVUQMTwNpHzIJPAsEDBoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCygDL?=
 =?us-ascii?q?AY4AhIMBgYJXiYHDwkEJwMIBAMrKQMjdhEDBAoDFAcLB1wDCQMcCQMZKx1AA?=
 =?us-ascii?q?gELbT01CQsbRAInpVguJSE8gSyBAAUdE0gcLwOTC4JdAa8WB4I0gWCUVIxDB?=
 =?us-ascii?q?g8EL5c0kleHdZBXomw+hQwCBAIEBQIOCIF6gX8zPoM2UhkPjliDQI96dQI5A?=
 =?us-ascii?q?gcBCgEBAwmCOYgqAQE?=
IronPort-PHdr: A9a23:cQ/nqBTxzF8vyOVXJqcbRlZ31Npsou2eAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C8vLriH9teNW/juZLYrGd+8kfS2ry
 q1Ccjq1jiIeNn1k70qI0f5JtItCsR309Hkdi4SBatywNup6PfrYWtgWalpMBZlyUiJ/BLrnY
 ahWVvc/bL5kj7bz5GEpjiWRKljyAdzD92Nx11Dkw/Bi1LUCERPk4yA+Dog1nCj1jY/3EIcgW
 86ty5LJihjpV+h19CnEz6jHKQ8liN6mVoNtLY2O8mUJEgL/rX6pstS/ZG3W3+IIjmyS9ch6Z
 NCtolAslwR9/wCXlsIvss7shL0J8nDe3AVjz5guJfnnSWhjRfSrRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mKf4eFzj65CKCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
X-Talos-CUID: =?us-ascii?q?9a23=3AUijviGnv0/vNxMZPsl0RQ8/AWMrXOSbZ71bsZEa?=
 =?us-ascii?q?8MzpOD6CUZxiV241iuPM7zg=3D=3D?=
X-Talos-MUID: 9a23:P0FIxQgTUKZKgrbRp/9f8MMpL+FR3YWoCUA2kpBcqcnDFwdcAS6Tg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,292,1695679200"; 
   d="scan'208";a="75344924"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeDD24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 20:45:03 +0100
X-CSE-ConnectionGUID: t53aHmfgRwyBiJzFa61ukg==
X-CSE-MsgGUID: REXXI+v5SqeiGjHBom8vzQ==
IronPort-SDR: 6583443d_//X3gXTIWP94wo9DweydeKzdq8M0T1jagoax8oUNfXmaKSB
 o8XhgkYKleEwmJ3LQ6rPwX4oMoJJpT2Z30N0Pug==
X-IPAS-Result: =?us-ascii?q?A0DUDgBgQ4Nl/3+zYZlagQkJHIMRUgc+gQ+BBYRSg00BA?=
 =?us-ascii?q?YUthkUBgXQtAzgBnByCUQNWDwEDAQEBAQEHAQFEBAEBhQYChzICJzgTAQIBA?=
 =?us-ascii?q?QIBAQEBAwIDAQEBAQEBAQEGAQEFAQEBAgEBBgWBChOFbA2GRQEBAQECARIRB?=
 =?us-ascii?q?AsBDQEBFBUOAQ8LGAICJgICMgceBg4FAgEBHoJegiwDDiMCAQGgegGBQAKKK?=
 =?us-ascii?q?Hp/M4EBggkBAQYEBLAbGIEhgR8JCQGBEC6DZ4Q0AYoigk+BPAsDgnU+iB6Ca?=
 =?us-ascii?q?IFTh0gHMoIdg1CDNmOGFYdCWyIFQXAbAwcDfw8rBwQwGwcGCRQYFSMGUAQoI?=
 =?us-ascii?q?QkTEkCBXYFSCn4/Dw4Rgj4iAgc2NhlIgloVDDVKdRAqBBQXgQ8EahsSHjcRE?=
 =?us-ascii?q?BcNAwh0HQIyPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIEwBQ0cAhAaBgwnA?=
 =?us-ascii?q?wMSSQIQFAM7AwMGAwoxAzBVRAxPA2kfFhwJPAsEDBoCGx4NJyMCLEIDEQUQA?=
 =?us-ascii?q?hYDJBYENBEJCygDLAY4AhIMBgYJXiYHDwkEJwMIBAMrKQMjdhEDBAoDFAcLB?=
 =?us-ascii?q?1wDCQMcCQMZKx1AAgELbT01CQsbRAInpVguJSE8gSyBAAUdE0gcLwOTC4JdA?=
 =?us-ascii?q?a8WB4I0gWCUVIxDBg8EL5c0kleHdZBXomw+hQwCBAIEBQIOAQEGgXolgVkzP?=
 =?us-ascii?q?oM2TwMZD45Yg0CPekIzAjkCBwEKAQEDCYI5iCkBAQ?=
IronPort-PHdr: A9a23:74AsVBHG03aaTyw4ZXA9cJ1Gf29NhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuU3AQp32sSLRkPh+yG6qB5Lmaak9fD6L1
 YI2ThrxiWRaKBVmq1PusuVpna0O83fD7xYqydPxYpGRd6N7WajRUuMXHjViW8hvURUaDKDlN
 pYxXrI9HdlW7LPahGUhgkrgADaAOb/WmxBamCKu2vwZ0/YDLi3YzVYbM44vkS7WiPXHPokKV
 tu0i4Ti9S7gQu1v/hfys5fMWz8LqsCRAfUvSub3zEgVNCj8lQ3K8tKmNjWQ6+AEqUqB3thif
 Nykt2sr9jlJ8j2s/oAJiLbVvqIP43De+jtiwKJqJPugbGR0NI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vad/WkWtLWpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eA5B16HCi2woHb9ypLqFcJHXdLJyesId70hD6qkvc3Nom52j+/
 xGws536faVslcssHFJo6H4BEDyewKmyXcT2/hvAV7CZnibhILMFu9fBOTZsljd8kHFh5RgPO
 JbAtVD4b7LfChHZKTBkWuF+r8bqbHtmsDY5ts2jU0dNT2CA5sQnjuRYTzrdXGeKjM2Y6bRWK
 Dsgvau8FGbCAoqh4mAdzI4t6+pnay+qLvWJTo9QzI34giHij2lrJb8Dhijxx8bFxdC260r/2
 TpmxHwovzLiYD39jbsk0voq7hGktrozdVOQOSKl8guMz3pziKlfp5oVbGutC085Muv9FEput
 /RpApIBbU411rhOkWO5Tf90Qjp1zgjr1fk1F+jmHPm5ff0QTorYvAx875xQ1/80Q4Nrdt82K
 VE0yayrJxMFy7Nmyz7+pzhSwxqvlDcmwttrccjy1hkFacOYr5YqoISuGlPFo0bIS784Ic7VM
 FzEcDn4upMe1/yVQGXgoBW+q3tYp0PJGbEfqBb0fblkQS+3UoJg3fw/fZv30vpr/kGOtx5D+
 etCNUeqFgBdL5TUUtHPpZ1fSKGMB2/ffvyChPhHb3GLtBPB5ufke++3Fxy3pDsRKA1
X-Talos-CUID: 9a23:a4Q3rGPYMGdbmu5DRHQ8/W4RFM8fbWz3zVXCDUbmUHtqR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AEM4bZg/G0kpnER1mrHdDPZ6Qf/1F05SPS15Qqow?=
 =?us-ascii?q?LuuaGFQZ3PmeDng3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,292,1695679200"; 
   d="scan'208";a="74808443"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 20:45:00 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Dec 2023 20:45:00 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.169) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Wed, 20 Dec 2023 20:45:00 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaQcQkwXKuVsH7mpG9ZaorHnRVkuRZosInsqFFgOgTIqZbEq0dL3ZUu/T0XJtrOW+14BmBP6u6oF3veNUqQb7ATuFHogFD8r0fih8O+qH8cxwzcLeJwsGTeUUKI2jkHwLNqmGxl4/LxFz2hKawx+QpQoGwR/1vqZNxxjLwypr6JY4z5uJ4p9IvktkyQ40j02xMfCBLUuKI6WP7KcBCFzgcL7aPQ+0ftBcBTxRn5K8cORJ80RxLiQ6NrNPgiWTRVXozKJsil0u5vHCos8xZ3CwfxmBPMXp+y454JLfvQq935NAWUU+6tZlNHw43Ib2im0x7Si7dgmrY6vO7XSBwQHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RtbokaCNzkx/XR7xLqaMbARM5nmqi+5wC73ZQPAqyg=;
 b=JQWBrJwHQ8iwekOXjyknkZZGLD0V6R9N18we5CQphFvsH7mTetCLXJLw71cU1owEzZYDRbD2sKKttg6iuB6RT27xVs2NyXv0YCIoa/io5EdH3PxFoaX3s4PsOi50YE2DkD7TXLElHhsmqHSOGh9UHZ8HuqttDXPOEbIWGsIoHeqTmI7vlvkn5uui3rloiQfbK5VgurWaDxYcBgFk/PTL0BQ3s/a5jnWYplNlpNO/zyfStII5RkB9wXgNiEfThgRK9vQlZ+yA8nadfbY2/N+YiXraYtVFPitKil/3NPNQC8YfAAIy40kTN7TW3T5iY9haGrkUPNUagE8b+ts0yyTPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RtbokaCNzkx/XR7xLqaMbARM5nmqi+5wC73ZQPAqyg=;
 b=b5Mjxl+1mOcdGXe37KmfVnQ3fK11uV90THWf+ROKVGG96mWDU4Q9Gzv50o9KhzJWDvy2SD4II2jLHZbFpoSi/EBPsKEvQOHg3wlAGBcYu4/7SDNmiRKCQs0236+anmUlarJrYZjAVcTmd5PP8mkP/MjWtPHrAHrgvshL7iNpLBg=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR6P281MB3438.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 19:44:59 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 19:44:59 +0000
Message-ID: <69c5a3b0-750f-4305-b09b-715d8f472e67@aisec.fraunhofer.de>
Date: Wed, 20 Dec 2023 20:44:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
CC: Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
	<paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
	<amir73il@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<gyroidos@aisec.fraunhofer.de>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231218171800.474cc21166642d49120ba4e4@canonical.com>
Content-Language: en-US
From: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <20231218171800.474cc21166642d49120ba4e4@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FR6P281MB3438:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6e1c0b-845a-4573-ee62-08dc01942628
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSdDoZuV9S1sDfURCLtI0azX7oExymEQtX1eg5fL+WSbmJABhgRmjL7pTFA1fQD3pWuIC0XCBEWpsBjUYqiD9f6pmDAEmoHmnHc1N6NgQeH4b7X0jICNrj/0Kr4PZLex0V4Jcu9Yn5CGnmIALLCjz686OZYr1zJ+z2V5fukNUYYBESX5tOgUYX1K8Xlwp7+g6dIYl+gJhg/qeVF6sjBP9SPBNua1E9zzmkbfgdcEkQ8v2PzEztaGKhUwc/9zwfwzeeYu09GrCy3MY/P1TUKMCrQBJdYg4JpfToMQ1xURauIooaeR+QWQA0pu4Ggj0JranUQIHsWYs3mQFdb8W+EgsqfKnj0k8io5TnN3NZ1JG7ugFw/XEcJIJ2DO4OLurvqzIkL6XMyDoTQMIJ5tC5NuH/w9LqHIF1AXtqtWgVWu78dVVLqYDayYJVDzbGQQQVPK/oZTG2HSGJfg9swnWnKIdOkaRqNnVdYJPnixZ7H6SuhKGJCmhiCm3rUS5XEXvVHGShzWpWKfpXITPgrmbzDOenyBqOE+nuh1Rjyp29Ceh4tE6osu+z0hcksIvcMgJ1/5h4pXFuj0HNY/Gf/i+KLhnZSHZXV94SeAvLGD3FQQYJtNWT2vktetAImUTE49a6hlhryleMO22o+W1fs854AiXDEiMdwAvsa6DilgAmaJrLLbvs1VDyvKElUTn290W8DHFJrrMMi92FVjp2a8JhvIdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(53546011)(107886003)(2616005)(6512007)(6506007)(38100700002)(4326008)(7416002)(2906002)(5660300002)(8936002)(8676002)(6486002)(316002)(6666004)(478600001)(54906003)(6916009)(41300700001)(66476007)(66556008)(66946007)(86362001)(82960400001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHFaSjJsSFh2N1dwSTdUaDJoVmplQncyazdNeXdFU1dmTm0wUkV3OWhRTkt2?=
 =?utf-8?B?RkdiUjFQeWo1eEd1QnRScVpUdHdaREtVczZzTmk2a2dNMWtOK1ZsZFNpd2ND?=
 =?utf-8?B?V3lDeEpsdkFaSkhXQVlyeU1FcTVIMUpFd0hDQzZ2dkF0SmFBQnZxa1VwaERS?=
 =?utf-8?B?NjkwMjAzYllMck94WVUwVWNrMjNoNnpHK1BpM2d5UkNSdEV5cFplT1ZWVmxQ?=
 =?utf-8?B?cDdwcVhEeUlPK1FkOU0zdUdkSVJ4SGlJK0diMFBuNDVvTGZkOW50bm9NNkQ4?=
 =?utf-8?B?SHZzcEJCN0ltOHI2WGRUNkJOQ1VMWlltNTF0Tk9XbXF1NlhBQlFudnpjdDJZ?=
 =?utf-8?B?eS9ibXlSOGhqMzQyNDhGYU0wT3UyZW1mWWJ5ajdFVExxWUs3MVEvYmREZi9F?=
 =?utf-8?B?ZWNyZy9wL1Z5bTNkUm9KU3VqQ3dtejcvR0s3ZnhtNllrQmkwbzFNdmFiT21D?=
 =?utf-8?B?dUJMdzlQTHkwMmxwb3l2MFhPS1JKT3UyWXloVXdla3g2N1BrN0lRZVhLY0cz?=
 =?utf-8?B?SGw5TzBhdW55ZDF5THlHaktZcUdrVFZKQUVjUGNqRkFpK3RzWDM5VkdxdEhp?=
 =?utf-8?B?MmNZb1NkRGRUem16RnV2WXk5cDcya3VGdFNKVGRDVVY0dU9wOTJZTTJObXp3?=
 =?utf-8?B?OU9RbmJxVDJmVERIbVJkaERCY3QraGFsaWFGMGNLWUdGcnBtSlJSV3VNNDdW?=
 =?utf-8?B?UnR3aWRjcXFLeUtkVWwyOUxnUHRYdU5jNkUvUzNFNFRvN3hZTEtvU1VkWSt3?=
 =?utf-8?B?Z0tpN0xLM0hKZFIwQm91N2FGM3kxSFRveU5HYlh3WkQ1R01oQUJIY1RvRE1S?=
 =?utf-8?B?TkNicFRpcjRGWDIyWityT21hcHlDVk9XNDFHcmhEYUhlMm9keG9Gek92RmVy?=
 =?utf-8?B?S2ZyRGEwU2dTRC94VFl6ZXFLSEtJYnJoQlUyanVpR05kdEtzaE5RWTlaNnB5?=
 =?utf-8?B?cjlRQTd6R0RISkpCSTlqa3JPM2JEVzZ2TldxVzdELzRaaitySTVsdU1HbFMy?=
 =?utf-8?B?dk9IRWV3MEpBS2MzbHMwWXAzUGI2ZkVlN2dpbXVBcDBSa2JEMFFlVWN4OGxE?=
 =?utf-8?B?ZVBLbEZjSmFqUmtsbUFYaHlPMk5jMktZdTQ4L3Vrc2d4eDNOOGwxWlJwV0NY?=
 =?utf-8?B?TEkvWmU1SVhDNlhyR21Bdi81Tit5bndCak9BakdaMWtyRVByalhPd1BjNWtB?=
 =?utf-8?B?SkNiVnR6akRxb291V0FBdXZwTVNHdUptaVNqTzVKZHB4YXhpZmxtSjFCRTY3?=
 =?utf-8?B?QVpaSndoV05ydHNUMWFVR2tNaFN2QzV5b0pnOHdsY2sxUmNHMzRKWi9EdlE2?=
 =?utf-8?B?VDZvbWx3ZUpqUE1wZnJmMzB5K1BFRDJGTk5SVng3ZTFYN1ZJNXJsaTNQTFQ0?=
 =?utf-8?B?TzFjTDdHcm9hVXVHZUJISk1hR0RaQUJPbVBrc1VPZVBFZzFwaGZXRFY3bVVX?=
 =?utf-8?B?ckdxQlEweGlNWWhvSnNFQ2FBcVFNWk4xZ2o0MExsYlFmYmhWb0Zvd0ZEUmo1?=
 =?utf-8?B?M3JwaU1YUDltK251VjZrZ2dRYmNka01iaWNSMUZGWnV3S1ExZE5wNHVaSk8w?=
 =?utf-8?B?SHVSZHAzU3ZiQnFKdXEreHhPUWR5WXdZMGVMcENTclJDcUVmZE02T0NnaVFY?=
 =?utf-8?B?VGlPMXhPTjNTS0dGbjNlUy90MGEycTRodjBnY1BnNnJ0amhKM2xOTS9VeTRT?=
 =?utf-8?B?MG9MektnQVZORHlKK05FTE96ZUNlQzU0NGs0TjlTS3JhR2RJOVRUaW8wTi9k?=
 =?utf-8?B?Y2pBZnVHVDlFbkhjMWk1NGliNEo5MjVxeGc0YkZsbTJ0Vjk0bmZqMFBUWFZK?=
 =?utf-8?B?ZFhxcmh1a0RlcWg1R09jRGw3bXk4RzZsWkoyb3l1TDQzNElzNW15dDgvWkpa?=
 =?utf-8?B?VXJNMDJSMXR1WHQ3K1RYNGRaSG1rMW1aQ1ZYWmNVV29EMHZDbzRsMmdPNXZs?=
 =?utf-8?B?MjVtWUcwWTh3L0RnQ3lHb0ljamVEd3hMSzJyY0dDSkRFenNpaHZsYlU1eDVp?=
 =?utf-8?B?WmNDWHpzOFpXd1NLQUV2VTMvME9BSDgvdDBkMG4yMS8wWEhOZ0VZRC9hUW1T?=
 =?utf-8?B?T2N2V1hGLzJwTlBJNVJrMkdtWHJEQjZKbmdOTERYcnFzUStFTHFJdlRTR05G?=
 =?utf-8?B?QmhIQWRTWmRSNjVWR1FZc2hIbE9XNzdibWU3UWo1cWZmOWdaTERiMHZJK251?=
 =?utf-8?B?eWQ2YVhyNGhKK0VxbzJHTXphWUJZVVBHMHR2aDhxNUZ4bXo3bGNRbFZLdFhD?=
 =?utf-8?Q?w/0djMTRDtBzuR8Ts3Bm01tbNH0k6zIZACOsBbfaxM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6e1c0b-845a-4573-ee62-08dc01942628
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 19:44:58.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOsfOhX2TLn0p0UHkuKuJ14NEgvLMh2NfX69sBcRV+D2hXzQE3Pe+UTsj30P111CllOiUVbTLskj4NiIiPY9MaO2fbggYcXZNhpUkdR9YJ0w//CVrGoJ0yOKS/UftHdm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3438
X-OriginatorOrg: aisec.fraunhofer.de

On 18.12.23 17:18, Alexander Mikhalitsyn wrote:
> On Fri, 15 Dec 2023 14:26:53 +0100
> Michael Weiß <michael.weiss@aisec.fraunhofer.de> wrote:
> 
>> On 15.12.23 13:31, Christian Brauner wrote:
>>> On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Weiß wrote:
>>>> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
>>>> namespace in cooperation of an attached cgroup device program. We
>>>> just need to implement the security_inode_mknod() hook for this.
>>>> In the hook, we check if the current task is guarded by a device
>>>> cgroup using the lately introduced cgroup_bpf_current_enabled()
>>>> helper. If so, we strip out SB_I_NODEV from the super block.
>>>>
>>>> Access decisions to those device nodes are then guarded by existing
>>>> device cgroups mechanism.
>>>>
>>>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
>>>> ---
>>>
>>> I think you misunderstood me... My point was that I believe you don't
>>> need an additional LSM at all and no additional LSM hook. But I might be
>>> wrong. Only a POC would show.
>>
>> Yeah sorry, I got your point now.
>>
>>>
>>> Just write a bpf lsm program that strips SB_I_NODEV in the existing
>>> security_sb_set_mnt_opts() call which is guranteed to be called when a
>>> new superblock is created.
>>
>> This does not work since SB_I_NODEV is a required_iflag in
>> mount_too_revealing(). This I have already tested when writing the
>> simple LSM here. So maybe we need to drop SB_I_NODEV from required_flags
>> there, too. Would that be safe?
>>
>>>
>>> Store your device access rules in a bpf map or in the sb->s_security
>>> blob (This is where I'm fuzzy and could use a bpf LSM expert's input.).
>>>
>>> Then make that bpf lsm program kick in everytime a
>>> security_inode_mknod() and security_file_open() is called and do device
>>> access management in there. Actually, you might need to add one hook
>>> when the actual device that's about to be opened is know. 
>>> This should be where today the device access hooks are called.
>>>
>>> And then you should already be done with this. The only thing that you
>>> need is the capable check patch.
>>>
>>> You don't need that cgroup_bpf_current_enabled() per se. Device
>>> management could now be done per superblock, and not per task. IOW, you
>>> allowlist a bunch of devices that can be created and opened. Any task
>>> that passes basic permission checks and that passes the bpf lsm program
>>> may create device nodes.
>>>
>>> That's a way more natural device management model than making this a per
>>> cgroup thing. Though that could be implemented as well with this.
>>>
>>> I would try to write a bpf lsm program that does device access
>>> management with your capable() sysctl patch applied and see how far I
>>> get.
>>>
>>> I don't have the time otherwise I'd do it.
>> I'll give it a try but no promises how fast this will go.
> 
> Hi Michael,
> 
> thanks for your work on this!
> 
> If you don't mind I'm ready to help you with writing the PoC for this bpf-based approach,
> as I have touched eBPF earlier I guess I can save some your time. (I'll post it here and you will incude it
> in your patch series.)

Yeah for sure. This would be very helpful thanks.
I'll start to sort Christians patches of this thread and get the missing security
hook for the remaining checks lined up from v2 then.

> 
> Kind regards,
> Alex
> 
>>
> 
> 

