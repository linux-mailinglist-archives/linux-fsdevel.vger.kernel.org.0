Return-Path: <linux-fsdevel+bounces-6180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9D7814936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3918285966
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F82C6AE;
	Fri, 15 Dec 2023 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="cqHKUuxt";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="SQg9Urz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeDD24.fraunhofer.de (mail-edgedd24.fraunhofer.de [192.102.167.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA92DB6F;
	Fri, 15 Dec 2023 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1702646894; x=1734182894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TOe+ca6LuakNqbdxlxOGfg8fQelBX94kgRxz2MEKZvk=;
  b=cqHKUuxtKH/H6qTFIzuz4f6ei7iLbjVqjavSRMcv1UUVrzSLTToQT+AS
   Hjyx7WiveZWVaCsxHouM0QH/xW1tHwp618p9kJCJpVgg9yIC+zWlLzcoX
   B/CsRsESQscPT8nBXZ/wIcoqf+8y3Fh/H/k2To1ls1VOXIJt4h+vSjkln
   tG2njrCelgfoSCU0Cf5gwEx5JmvG+M1w4sipMZIXLmB4+UwzvGQ4kRHUX
   8DsNgru15C+8gwQ2Pf2LbdqFmNCfOrnE1SK6e+UbcfN3GCw6YlEetJ0GR
   miFx2LGU1h/0xPYK3tkFsqTdTTmIVLwzRME+IAlXGMc1ZtQpawPlZNdty
   Q==;
X-CSE-ConnectionGUID: h6/Ayd9zTk27oBe2phXyZg==
X-CSE-MsgGUID: AzAW6k3JQjW9qIZ5dWQwQg==
Authentication-Results: mail-edgeDD24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2FVBADIUnxl/xwBYJlagQmBT4I5glmEU5E2LQOcU4Esg?=
 =?us-ascii?q?SUDVg8BAQEBAQEBAQEHAQFEBAEBAwSEfwKHMic2Bw4BAgEDAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBBgEBBgEBAQEBAQYGAoEZhS85DYN5gR4BAQEBAQEBAQEBAQEdAjVTA?=
 =?us-ascii?q?QEBAQIBIwQLAQ0BASkOAQ8LGAICJgICMiUGDgUCAQGCfIIrAw4jrl16fzOBA?=
 =?us-ascii?q?YIJAQEGsCMYgSGBHwkJAYEQLoNnhDQBiiCCT4E8DoJ1PoRYg0aCaIFVh0gHM?=
 =?us-ascii?q?oIhg0+DN2ONR1siBUFwGwMHA38PKwcEMBsHBgkUGBUjBlAEKCEJExJAgV2BU?=
 =?us-ascii?q?gp+Pw8OEYI+HwIHNjYZSIJaFQw0SnUQKgQUF4ESBGobEh43ERAXDQMIdB0CM?=
 =?us-ascii?q?jwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMAUNHgIQGgYMJwMDEkkCEBQDO?=
 =?us-ascii?q?wMDBgMKMQMwVUQMTwNsHzIJPAsEDBsCGx4NJyMCLEIDEQUQAhYDJBYENhEJC?=
 =?us-ascii?q?ygDLAY4AhMMBgYJXiYHDwkEJwMIBAMrKQMjdxEDBAwDFwcLB0kDGSsdQAIBC?=
 =?us-ascii?q?209NQkLG0QCJ6VFLiUhPIIsIncvA5MJgl0BrwwHgjOBX6EVBg8EL5cxkleHc?=
 =?us-ascii?q?JBVomiFSgIEAgQFAg4IgWoGggkzPoM2UhkPjliDQI96dQI5AgcBCgEBAwmCO?=
 =?us-ascii?q?YgpAQE?=
IronPort-PHdr: A9a23:fFru9R1ZCpoqpU+VsmDO+QUyDhhOgF2JFhBAs8lvgudUaa3m5JTrZ
 hGBtr1m2UXEWYzL5v4DkefSurDtVT9lg96N5X4YeYFKVxgLhN9QmAolAcWfDlb8IuKsZCs/T
 4xZAURo+3ywLU9PQoPwfVTPpH214zMIXxL5MAt+POPuHYDOys+w0rPXmdXTNitSgz/vTbpuI
 UeNsA/Tu8IK065vMb04xRaMg1caUONQ2W5uORevjg7xtOKR2bMmzSlKoPMm8ZxwFIDBOokoR
 rxRCjsrdls44sHmrzDvZguC7XhPNwdemBodWSqe9SPldLjIghnKmstt/CS3MtKuUawoUDT44
 ZhIdRPiiwheHhso/H/o2pkj6cATqkeanhMu/pTGPrPMd+tMRK7EZd8ia3NiAc9WXjZdHYW3U
 bk0NuE7FP5W9JTdvAsNjAXhXiTwFNPIlxhoqHzJmvcF4s4fFAaB7QwHQswP6nv3k/T3NfpVY
 +yw6a/1wzqddehngQvz1qeXSR0iudqobKpdbsHb1kUGGA/Ph1yZhoHCFj+Rh7okolLFqOlsb
 fuBp0QipTtB8wGKzZcpkIfuv5BIzXnE1BlVmKorJNLtGwZrJN++F51IsDuGcpF7Wd4mXzRws
 T0hmdXu2La+dSkOjZkryBPzR6bbNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AML6eZ2j7zpx1Lp3xF2xCXpXjhTJuciOa5Wbccl2?=
 =?us-ascii?q?ECjw2T5eYE0eQyLJWnJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aojki1w0PsBRiTLQAGTb9OgiFWTUjyraHNx4Oyrc?=
 =?us-ascii?q?/ufbVLA1CZjuitSuOTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,278,1695679200"; 
   d="scan'208";a="75033688"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeDD24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 14:27:00 +0100
X-CSE-ConnectionGUID: jal4sYvVQ/ymrehvkVE1dw==
X-CSE-MsgGUID: Dzn/DW6uSJeGUOyAEdrcqQ==
IronPort-SDR: 657c5421_j//SjoHt5+XQcBp57Q7k2Vww+24m7sVhAfJDIw/dT0iOP7o
 Cd5YCEmiz/38e6a6bH89jPEub9KdaILs7Q5R1jg==
X-IPAS-Result: =?us-ascii?q?A0C9BwDIUnxl/3+zYZlagQkJHIEqgWdSB4FNgQWEUoNNA?=
 =?us-ascii?q?QGFLYZGgXQtAzgBnBqBLIElA1YPAQMBAQEBAQcBAUQEAQGFBgKHLwInNgcOA?=
 =?us-ascii?q?QIBAQIBAQEBAwIDAQEBAQEBAQEGAQEFAQEBAgEBBgSBChOFaA2GRQEBAQECA?=
 =?us-ascii?q?RIRBAsBDQEBFBUOAQ8LGAICJgICMgceBg4FAgEBHoJegisDDiMCAQGibgGBQ?=
 =?us-ascii?q?AKKKHp/M4EBggkBAQYEBLAbGIEhgR8JCQGBEC6DZ4Q0AYoggk+BPA6CdT6IH?=
 =?us-ascii?q?oJogVWHSAcygiGDT4M3Y41HWyIFQXAbAwcDfw8rBwQwGwcGCRQYFSMGUAQoI?=
 =?us-ascii?q?QkTEkCBXYFSCn4/Dw4Rgj4fAgc2NhlIgloVDDRKdRAqBBQXgRIEahsSHjcRE?=
 =?us-ascii?q?BcNAwh0HQIyPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIEwBQ0eAhAaBgwnA?=
 =?us-ascii?q?wMSSQIQFAM7AwMGAwoxAzBVRAxPA2wfFhwJPAsEDBsCGx4NJyMCLEIDEQUQA?=
 =?us-ascii?q?hYDJBYENhEJCygDLAY4AhMMBgYJXiYHDwkEJwMIBAMrKQMjdxEDBAwDFwcLB?=
 =?us-ascii?q?0kDGSsdQAIBC209NQkLG0QCJ6VFLiUhPIIsIncvA5MJgl0BrwwHgjOBX6EVB?=
 =?us-ascii?q?g8EL5cxkleHcJBVomiFSgIEAgQFAg4BAQaBagYvgVkzPoM2TwMZD45Yg0CPe?=
 =?us-ascii?q?kIzAjkCBwEKAQEDCYI5iCgBAQ?=
IronPort-PHdr: A9a23:XaHP4hRDvVgGVoBxRBozlB/TANpsovKeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C83T6TLIqcBS4RmoDeHXXZQ5dDu9t
 7t3VBbo0ik4FAM1+mL40+VVna5Fn0L09Hkdi4SBW7iaZcdkbP3vJJALd1BMR95dbwJYIdy1a
 IIVE/UHNthqlLD2nXIWo0CjJRL8B8LxlWRl2m/G+vAd88oiLkac4z0KIdcJ90XUi4jrNf0dc
 t+UzqiVigfPatZQ5DnytpLTQ0gdr8+jAol9ctL67Xg3OhzOhEqcgIPpNTqc38sAlEGX67s+f
 POV1SkkpzlojBSFw8kWutjwo4lFz0rK0hxrnYEcJfyEZBZXf9+rRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gry0izEuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
IronPort-Data: A9a23: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
 VFAO0QDOXk=
IronPort-HdrOrdr: A9a23:1MhV2K48Uo5sM3fkfQPXwTCBI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc0AxhIE3I6urwQ5VoIEmsgqKdhLN+AV7MZniBhILFFvAA0WKA+UyXJ8SdzJ8l6U
 4IScEXY7eQbWSS5fyKozVQeOxQpeVvhZrY4ts2uE0dKT2CBZsQjTuQaW6gYwhLrFYsP+t/KH
 L4jvA35QaISDAyVICWF3MFV+/Mq5ngj5T9eyMLABYh9U2nkS6owKSSKWnQ4j4uFxd0hZsy+2
 nMlAL0oo+5teug9xPa32jPq7xLhdrazMdZDsDksLlcFtyssHfiWG1SYczOgNkHmpDi1L/sqq
 iCn/4UBbU415oWRBD6nfKi4Xig7N9k0Q6e9bbRuwqeneXJABY3DNdAg4VCGyGpkXbIFusMkN
 MM44vejesSMfqIplWC2/HYEx5tjUa6unwkjKoaiGFeS5IXbPtLoZUY5149KuZ1IMvW0vFULA
 BVNrCo2N9GNVeBK3zJtGhmx9KhGn46GxuAT0AY/taYyDhbhjR4yFEEzMsUkjMB+fsGOuh5Ds
 j/Q9dVfet1P7ArhIpGdZc8ffc=
X-Talos-CUID: 9a23:NQJ4EmODvSSKYu5DWiBjqFUlBP4cNWzY1nrQPUyGJD9lV+jA
X-Talos-MUID: 9a23:66M1+AUSVxmf+Fvq/BP+gnZOC5l12IajJ30qgLwrt9OPLBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,278,1695679200"; 
   d="scan'208";a="1156445"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 14:26:56 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Dec 2023 14:26:56 +0100
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.168)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Fri, 15 Dec 2023 14:26:56 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzisg4FMn/O7yOVHeuenry9WxB1VOfFav5Ij0vY9yroUoZvGH8+xpEUsHoeVfp+ZxrZ5VTwGkcrYLGcx7Ca3bkc+AkCvQNz8Eh3pp7mdB72K9SDO5/+hCXN32vUEcpKJTx42B0ZR7IwoSbo/wIUCNht9DFOGUvY5lFGq+aEmhWjyt21RPB9X7gxGv+jfd6TK8w2K4YaWbIo/hjeVKk1bBZ6hu6xZDoHVSMSbbmvHdkSFJg6XxkoSDOcLEd+C881C/F1lb+hzW0V29RBfEeckB/hBiV9ludSY5jviCOg/IIvbBwX+mlERH9cxXPl3U+OHYMJWZLLQ1YKJ5B2A9RaoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J3qZwBGQXZXDIxLeEgw0tttah2fWKUdbkG1AMydvW8=;
 b=WAg7rkbeRESsp9fYfiW8FGmGdsZWYMGjt+VDXttsOT5Ivn4yVRifmlz/aIxiS+XyORyTTX0WlXf+Ee0Jg9corjLmXULcMcL5NqhhI8qC/InPXNsxGA35XRBHagsV9wOc5oF7JjAZL949fabBzcxBU8sw088FONzTdVAJ3YGF88lU5LsHE4tpxbZ8wsnklXqM0GSYQJtS75tke7BW9BwYCU2Vxm7NzmAK+eGxHzd6HHhpu3kcDbQaERP1Da/5K8OHTfLRo0iZt7a49DxkZSvuAyI2EAAzuz2eCM1UTVI7CtSeypmRM1gX2Cb6JLUoesLjNKpLNYzezm4HfbdO8SxTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J3qZwBGQXZXDIxLeEgw0tttah2fWKUdbkG1AMydvW8=;
 b=SQg9Urz6Z1+yZReqpdPFqK7aoartwncVZSQcRApf3uHs8kIv73E4xXO5OHFkW/2WYBVmo/YhO5vi2gKWIji5/ZdmMnUfg6rsY0TfVG7SekpCLYpEwcbwdAgdbaaaGeOAdl96AyR6/kdPqFDBmfRX9QMc8mrfOQz5oAhITD0Dvig=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BEZP281MB2373.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 13:26:55 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 13:26:55 +0000
Message-ID: <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
Date: Fri, 15 Dec 2023 14:26:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
CC: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei Starovoitov
	<ast@kernel.org>, Paul Moore <paul@paul-moore.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Quentin Monnet
	<quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, "Serge E.
 Hallyn" <serge@hallyn.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
From: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <20231215-golfanlage-beirren-f304f9dafaca@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BEZP281MB2373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e09a8d8-79e1-44b9-9828-08dbfd7181b6
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xp+CLyjB+ThQviIVieL2LVgN/9BUXMT/NzPev53pRGNg6ryht7nkRCozNb1malRX3H8+KsI0nABKMCPvMN77vDJMiwYZovG4PSW9XhLLz4WslSiQ44OBLia889ggJzEBHdEuMdfWAhgMp25i1VFrlE2mPTTLRSml3s9iFAmE9tSoaRc3ZAEH9E6XC/VAVfCr12unea7HqQZ5AKRG5wbNrHXNtF5GsUOBO/Mj/jL6NUQA8zJZRZryKy0nkTYN4mj0Z5sflSAThy8VOKIGotZzvkAKsLOwKxjTc/7REEVF3Kx704vVFQfOayFjupZszB5+NSWLjdz1wUYMwC35uAee3GivXglHfFpQ8i8wEbJgOadWHeroKy1Jh4fyaNNExrhZ15XdJYRfc6RxqPe1oVlcaRO6/h4WQ4K3ksk5cmMN3mGiaxlIHx5Gamas5+XKgiGsM92hB+Jb+sOZmVMF84lRhM9DFO8kxfcbqP31fdj/gNbg/B6Mr3G/E7HGRTm0LwWlEV+ZBfawvSgATdoQZmo8LPTgtEgpuk2H7iyv8+B7ebyr5qHYZgBptXkverwjHMKhD5uHlaxo3CNgRtnoA+HEGHUffs/TAV31YUTR7Twyh1AwGsKKHuoF2u4xRleUZCpbNhK0XBBNAw4wanovJl/pAxoCRZYsrJTDzX2fFcAgVHSSfDsP60WgsZTAiVRKyVAJixWeaD9Ndt98XcCaiSEUew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4326008)(8936002)(8676002)(7416002)(2906002)(5660300002)(478600001)(6512007)(6506007)(53546011)(66946007)(66476007)(54906003)(66556008)(316002)(6916009)(6486002)(41300700001)(38100700002)(31686004)(31696002)(86362001)(82960400001)(107886003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FpTXRWQ29qWVdTZWZrZEVEeWZwTjVpaStQU0F2Umh6R3k2SHRFS1FlUXYv?=
 =?utf-8?B?dXNqcHN4OUplc09oeE1IeGVLb05NZEpBZmUwdlNJcUw5Mms0Szl6elh5OHh0?=
 =?utf-8?B?WWNKK3NFUk5VRGtGcEZiME1qY3BRYm8venVKVW9yYWM0blRFbW54bjBPL2U2?=
 =?utf-8?B?Z1RGSlpvam9ma0kxVFNEZGZ1MTE3MC9SRFpyVWFodUZwcmhTSzhCcmh2VVlC?=
 =?utf-8?B?RTgvSlExajRENHNkM2ZEenJiMHA4TjdaVjJMK2JZUDZ6REZNRXBTUGZXT2Jl?=
 =?utf-8?B?QlpLR2MxdmVZRFB5dGZGQUhlTzBIRXJBejF5MGNWcVdxeDZtejV5Z25XUmky?=
 =?utf-8?B?a29EZTBxTVpUYmppRlNsZi8rL0V5bkRJa3ZsdFZ1bjRQQk9SVEJRaXZRZm1v?=
 =?utf-8?B?eTVsZTdtTk41MWxKRk1yelR3czZ3eU9tanVSY1JuN3NrTE9lQlhMNStFMnlC?=
 =?utf-8?B?QkhGNVc4U3BmUCtwSG83V3FOVlB4REVkTWcrdEJ2ZThhRHNMYVVMTnpzR0Q5?=
 =?utf-8?B?bE1iNUJCVjRyMzU1OVAyRlJ5V2phVDdFZEpJYTBBRExsdHJSbEwwMWVpd0pr?=
 =?utf-8?B?VEpPUTJrblZITVBhSS8zZzVabDlQVkZ5WTN2MW43WUtRM2lud2RYUGROQ3Jk?=
 =?utf-8?B?a284TU9EZTdTV0t3MzA1MEhucXlzKzAwSXpENHhuTkxrT3kxdE1pcGNNeWFq?=
 =?utf-8?B?eWdEV2FDZFhYSzZoY1NHaW1qMHRna0xQczJEZWYzbDhyNzczbUVWMmRCVnV3?=
 =?utf-8?B?ZGxhZGFsWEhMWGgva254Yzh1WmQ2V3VDSWdySU1GekZyUVI5cks0U0YrS3g1?=
 =?utf-8?B?Z25XTHl3VFgxOU50V1FCNlFwR1lwcGVFclEyamJNNnQ1WS91YmZvRjVzYWtB?=
 =?utf-8?B?UmdXc0wvMFBsQzQycUp2YllRaDNQSmhJZEdzUGNLd2pPQ0JXMDNFdGNLc3BI?=
 =?utf-8?B?bkdOQnFXb1BvL1lhOXpSNDBxQUVuZmxaNUlOMzRXcTFGUFE0WmRTT2FOMWFD?=
 =?utf-8?B?alFuaXdHdkMyQmQwK3J6aW40TlJRcjdvdHBiQlNMZmNyb1YraGlsNGtyYURx?=
 =?utf-8?B?ZjFqVnIzeVZQZTc2b2p3eDArU2hQd1d6TEZhYVlxUGV5Qi9yaDZLM0pHcDMv?=
 =?utf-8?B?TjRCdHRzU29Nd0FUckprODNTT2s2RlUxS054bExxNHZVK1JkT0VUdzh0Y1Fx?=
 =?utf-8?B?RDlPY1VMTzM2djBpcm5xUGxUVTk5YzJOU2Y4VktBNW5uWHB0b0JkNXR5RmFa?=
 =?utf-8?B?TjRHeXpHOGNieWtlYzVHSFkyR012c3JwSFNPMGpLZFZrc3JJbStRdGZMNzNh?=
 =?utf-8?B?RGQ3UVU0dG9EMXd2Z0ZQVGhjc2ExZnY1aU56eFQvU0lqVFdaU0VxZGtuNmlQ?=
 =?utf-8?B?My9GMm1MenVFcUNiVnhsOHROam1iWGR1dHdtSjBoekYwSm1hVllBbDlNc01w?=
 =?utf-8?B?dW5KM2hYbE91RjlKRTBUcjZuVWdZR2huQ3RHSGV2ck11QlNvMDBKZmNGdnZx?=
 =?utf-8?B?bUlsaEZ6Sm92K0hnTml6N29yWEdDN21EQXg1QnBpWmcweCtlRGRyeWI5Tmc0?=
 =?utf-8?B?aDBvaDB5REFXZTNhTE16TFNhYTBpOUozWFJwaVZQQ2lOL29tNnYxTWZuUGdx?=
 =?utf-8?B?MUdSa213b0ZFblU5QXljUGw0OGRIQ3F4cG1ZTlI2OW5WVmRPT0lMb3NhK2tY?=
 =?utf-8?B?emJ1SWhTQXFYbkpMUUU2N1dZMkg4Nng3YzhKS0JTQ0MvQjIrZUR0RFNKaFdl?=
 =?utf-8?B?dmRkSnh1TksxdlROQzRTMlMwTjN2aTF0eUdVYnpRaG5QTUQxeGYrUG5DUGMy?=
 =?utf-8?B?aUc3UUZVN1Y1eHBLaWVHTnVHdFJJUEliejdycHd3THl0M1lVb0xuVzMwQlJ1?=
 =?utf-8?B?K3dDL3Z1aHc0NDYxY2FUUWdYT2M0WDNLMWVJS2RCNDl5WGNHd1FJWWNadjJY?=
 =?utf-8?B?M0F4VEdXMHlLMnBkTklZSGdOS2RZQkxQclpOQXF2Ym9VT3NBcW5qeVlHeW1i?=
 =?utf-8?B?UFc1eXNORHk3eWFZQkRIWENNNHJrbjZZMWJUYUc5c05VNzZPdVo0UmFVY2s5?=
 =?utf-8?B?WE9xMC9zenh0aFFmclBZUGZ0VXF5TzNFeEpPbzJtRkNvV29QWkZHRW52ZlQz?=
 =?utf-8?B?K3plOEV6aEVnSXE0bzg3ekdoMXhiTzJCNzM3Tld0TDBud0NpUU54aFFoUkFK?=
 =?utf-8?B?M2hiM09qSzQwVHRFSStPdkVhZkF3dnVCZnA3Qy9qeTBmT0EwQTZGa1lJbHpr?=
 =?utf-8?Q?72Hko2QL7WokrAvwcgtkFkP/Vs81HkXOEifV9puuvo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e09a8d8-79e1-44b9-9828-08dbfd7181b6
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 13:26:55.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9VzmOMvPfacXyaNbH0fD7cKU/nCDAlFS94heBgYeQnntXiLn/VLS/bavyzmV7G6ZeEfAwIKMVsRA72t4l2LHyTsW1ejKrDDt3OiCFMYUoANRxzm9+GknQJOCDYmaOMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2373
X-OriginatorOrg: aisec.fraunhofer.de

On 15.12.23 13:31, Christian Brauner wrote:
> On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Weiß wrote:
>> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
>> namespace in cooperation of an attached cgroup device program. We
>> just need to implement the security_inode_mknod() hook for this.
>> In the hook, we check if the current task is guarded by a device
>> cgroup using the lately introduced cgroup_bpf_current_enabled()
>> helper. If so, we strip out SB_I_NODEV from the super block.
>>
>> Access decisions to those device nodes are then guarded by existing
>> device cgroups mechanism.
>>
>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
>> ---
> 
> I think you misunderstood me... My point was that I believe you don't
> need an additional LSM at all and no additional LSM hook. But I might be
> wrong. Only a POC would show.

Yeah sorry, I got your point now.

> 
> Just write a bpf lsm program that strips SB_I_NODEV in the existing
> security_sb_set_mnt_opts() call which is guranteed to be called when a
> new superblock is created.

This does not work since SB_I_NODEV is a required_iflag in
mount_too_revealing(). This I have already tested when writing the
simple LSM here. So maybe we need to drop SB_I_NODEV from required_flags
there, too. Would that be safe?

> 
> Store your device access rules in a bpf map or in the sb->s_security
> blob (This is where I'm fuzzy and could use a bpf LSM expert's input.).
> 
> Then make that bpf lsm program kick in everytime a
> security_inode_mknod() and security_file_open() is called and do device
> access management in there. Actually, you might need to add one hook
> when the actual device that's about to be opened is know. 
> This should be where today the device access hooks are called.
> 
> And then you should already be done with this. The only thing that you
> need is the capable check patch.
> 
> You don't need that cgroup_bpf_current_enabled() per se. Device
> management could now be done per superblock, and not per task. IOW, you
> allowlist a bunch of devices that can be created and opened. Any task
> that passes basic permission checks and that passes the bpf lsm program
> may create device nodes.
> 
> That's a way more natural device management model than making this a per
> cgroup thing. Though that could be implemented as well with this.
> 
> I would try to write a bpf lsm program that does device access
> management with your capable() sysctl patch applied and see how far I
> get.
> 
> I don't have the time otherwise I'd do it.
I'll give it a try but no promises how fast this will go.

