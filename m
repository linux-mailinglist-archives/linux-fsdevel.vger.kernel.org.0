Return-Path: <linux-fsdevel+bounces-32423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07ED9A4E01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE8F2817FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D13B2BB;
	Sat, 19 Oct 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eS6Y8Cw2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pt+u3SBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696E2770E;
	Sat, 19 Oct 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342433; cv=fail; b=i8G3XbkTnG9Ve32kQHEJpJFWKju8n6aj20RhEXai/rB2h0v3RodCHMfPpn6f62jiRpiYnkxlUV63gBq9mcq7bUs0KneqvTvNYJEWrPWFQaSY48y01qua5FX8pEWa7U9C6tPxe20Y9OrZm1PH+RTTAzWSkeJ7lT2JEaV/x4UqMYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342433; c=relaxed/simple;
	bh=EOxTGgWGNvSBh5KVqmsKi5I5eCDIe2YPdvjUuB0v+j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gLNf0soGJ82VReylmcoItivg/yHdU7LaGahq3xx95MnFuvTPyv3DsCLIx1Jp0U0p6HgM7hoMla+1xmqjRSJqK4lsm8JDZ4uwF2puV8Ihg0BJyDNOANsrFH1v7cLnoJftJwTpBX2FbTpnRZMGa7kTOdPuInnxVOCfUQzOXJiAZAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eS6Y8Cw2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pt+u3SBy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JCKJiV030099;
	Sat, 19 Oct 2024 12:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=; b=
	eS6Y8Cw2o1XJ2/xBV6a1ZBCprILHifHrASzz2FPcTh4tCM9qfZxuvf5yJOA0jfXo
	NyAupuup7IliBmvVPM9hIotoQAdVixQEklJCmoWAy34QiAm2tUA4kMzbxEoE6N5r
	DH9nZ7uwKfLGWMGVom7chece1/47Shq3RgfRNWnhURGbbQ3AMhZMj7tX3SSs32oG
	DG0zjbMMQxXXRW/Odmave1Ex+jfWVYvSJyWq/FjWrfgJUsvOABkFIKpxKVSKwQqs
	FvNu8hfyU55meJKbaGSvF+aXZg89PFA+CrQ4Scjmu3+pVp5/PqnUvB66nr9Jwalt
	rDRsVW3TOqM5aFjUB5QHnw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5450a0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49JB8OLu026230;
	Sat, 19 Oct 2024 12:51:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c374ssbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jC2FWeJ7TFL7uUQeyOw7WUKE7+IH20/1mFTKawOtVyQ/VRk5NOrXwy7B7wn8KjQBfESABFhdDnGNGjbWeUOXARrwKTNmVaASK24DdNiBwx1pX1AdmIo5scRjIJAaUKdfgYzpCGaOigFLxHmie0x1SVgKWjCArvLMRNk7vUmmTh8By4FRqqH/58pw6NBrXmAybTSnIknj3AE4qJaK8/Nru4k0ADAiY1nxULf65y6xFB3hUNTX2nqG0p9ua/wky0K+30OxyujmeIy731kZC21pGGwNJUshmg96maObF1d8IuVszWcu/c7q4+s5I16Bxyr8TTf1l+xF3ubcJcrok/oSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=;
 b=vimY9cFvb18al1sEsfRTzwWaKiFk6geZkO++Nk+VJM4K1msTwQzMcqo9vqPdjdFEyjl3aoQdIo0cOQoS7XQ6KDT6kXorHQf7f83znvJmyG3mqeaXurOPJ7mIWg36N0vL6Av8v5GN4yk9Yt6CPn0AVG3R85xQn+WwpIO7oyTFgfS0PO11iiOnPljqpIQ21MQM+6WcxNfThGirusxLmO7xFVDmV7hDAQZ6Fu0YDnfF1e+wy7WZISn8xCQfVX7MfCViYttLhM8fh2ikl9TDYVJpYI7LVkKw0ye8TuTMPr+9vN8FbgBW7xmrFW0UiZVL54eZ9IfVHOBN+X5fj/uEGUV5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=;
 b=Pt+u3SBykeupQFPBoblwYyasRkX8woXsBvaUFCl+rbdJpmIPXBA0WBcF8wBoAZljue6lSxa2ZOtZcGhkAil6xonaNOqT656O9q6ITChVpAhvDsQYeiuOoKgngIJPStxCguApgQ9+QefqiWJoBfEcYHcoGSRRDxIUAJkmGS0Ti0E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 12:51:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:28 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 4/8] fs: Export generic_atomic_write_valid()
Date: Sat, 19 Oct 2024 12:51:09 +0000
Message-Id: <20241019125113.369994-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0024.prod.exchangelabs.com
 (2603:10b6:207:18::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8259c4-d8bc-49c9-23fe-08dcf03cbf71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hf8VISJb7kFaBGcT2+sY4n/dhmtqcBMLd25bSlxQ4M0cGgs7S6n5iIHf/C+k?=
 =?us-ascii?Q?ZEYczrhW8xXLWlj9b4YepydJUK3ivMmCfQBdZAqpPlwBopHP+IyjJvvJNA30?=
 =?us-ascii?Q?trU9bpc9VhBQkCIgmFRSkDnbctLCjY2aW7+FwwIW4hixebE8zvEe2O6FDb8P?=
 =?us-ascii?Q?MK8ecB5mfTJ9RixkMDuCgMOHk+Ek8KRyTm6D9Z2S+gtKBZt6paMq0OCXFQoB?=
 =?us-ascii?Q?+gHhJ4iE0B+LW+6tEVr98Yj9aROqpk6rUTBp0mm+l3HXE5ua4bbgeuicxdRk?=
 =?us-ascii?Q?VYmfB84AXW8xFvezYoN/ASQKCXZyP/fgSj5gjwBX4C3efCb4staKUd7n5iPD?=
 =?us-ascii?Q?+nyGeEWyrPV0p1Eo3aPtMX7JXkqVxU70CVMu6hDniBbdrR28mHAzSe1yTx5h?=
 =?us-ascii?Q?f1Zm7CQwchqALZ1illoTRE95yHpwKIreHkG37/D/feLqeYulc6t8noevfOOU?=
 =?us-ascii?Q?KPe20dsjG6VVEc5Ox0s017HmwL44yBd+QiEkY/i4q4iAsrNHlvvFKTzuBO+Y?=
 =?us-ascii?Q?p5avYh4jMeTsPZdHXfq0/APYliDuZFIopKYATA6/Ci72qNJ9Dd0o9ojYnJei?=
 =?us-ascii?Q?n1MseMWwIpcg93hAlg9rFT1hMXMdQitvEcJs1ihBxG0TPM2H1pKU4eaQKfhW?=
 =?us-ascii?Q?nzUZqdCtu3ukv5GnIn/aTwrbNm4OWvoBDtQowjb0aVxMKq457ecGObACX1Xu?=
 =?us-ascii?Q?97gIcD7PcRkB8UVWPOFqCS8LBwjtExvcag/rVjDl0nK7QN2/OaCxAcoyUOT3?=
 =?us-ascii?Q?Rl5NGNEejC/OgCB9gcF8yRyUP+vzPBooNleji/+OgQdntErEhwW6ak12AAn1?=
 =?us-ascii?Q?iEUxwXVl/g3xmYOIz3LkLepjkcDwMgAp43xcZaG3tcfWLCdrivbw0mDKmFjh?=
 =?us-ascii?Q?yDxRwbaWbjHizq3ZKeazqLRNmZfnlu5xnFe95L+Y3GK+E63/Ip/fBvvvN36l?=
 =?us-ascii?Q?Coz/pcO0ZXS77KDYXoMhN7yyuCAzMHQwY7z2CT7gMgeLkBZtHi6YPgr0pAFh?=
 =?us-ascii?Q?GY4Y1hrohhnQv3cdOgKea5I302zSEl5JIoFJFzSJ36cOjuSLy1yVeCeR+/D0?=
 =?us-ascii?Q?UGUR51kliYQb6DqZrzj156EEYz9pFVzIHIo5ZRB6thjFstlxAvOOApoyJznd?=
 =?us-ascii?Q?JvH4k+XcQHaxsqJCXlL4HqkRqC3EJlDuWvN1TQ6umerxT6JhksSvKEKjH275?=
 =?us-ascii?Q?5eNET41j9B9IZZQhD+HNnySSjutKvmkWD6cjXqBb2/INEF1+kIeSQXW6YgjH?=
 =?us-ascii?Q?g+p644Si8xjy9txHi+UkQnRfyC/tm2wLCNlhuC1JU6yr2inrgNztEZsmB5Gk?=
 =?us-ascii?Q?ccotTP73JiuRCsZbqZIqoJLc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n+7f1soIMjqq0M+6PVGM0UT3aWzBRLl6pqJmSythzYRbsSYZvS3xF6woCJiB?=
 =?us-ascii?Q?YRhtk2AfxIAREObkoZ3CYa2zbH1fdQmNqD0T3eBrrIpD8/EVvNTiNaaFx4Gb?=
 =?us-ascii?Q?DknhKCl9EjkSuWuZzcavr7tyU3BQKFvdQhjNSResKFKjozG0F2u9VIydakm/?=
 =?us-ascii?Q?ru83TbihbmFCSqCDx2Js4Ox5LsFdYyIG7w8mrMnvuZ5MyEW6U57k2xVQ4IuK?=
 =?us-ascii?Q?0V5whi3yQvdqdy1VZeqDb+kzO9U4sjbVHk8DCUyfcmET/2II/lafI5Knks6t?=
 =?us-ascii?Q?B2BdBPunjscNOBL4RzZrGLmjQzHy7ouNETQdloMGshQwcQyzZoA8CY70Fz3c?=
 =?us-ascii?Q?NmBE62xhqZqMuNL7Ovxa76GxtgWPrGnxMwWT9leY2s1MWUuCFnHLSy584v5N?=
 =?us-ascii?Q?EEuhtEHXMOXSJmbbf0SwuqazCCfWYNatu+PHFRfbqZA/S9dNiCxGFXcB5WYo?=
 =?us-ascii?Q?vad+UeR6kdWyUc2d+lZtohcqFIuufBRzOLFQGwr+4wswFXezESFgAB0+XcKS?=
 =?us-ascii?Q?wSJokQEkyjDEp2BstSEHIEm5jPCsTp3GsutHjc9Zl3rLT2YHJuwk2z+YB5Dx?=
 =?us-ascii?Q?MRDM9PiShEu3qxm+/bZLgID8o6AFqrxRB/+S4YgWgO6GTcjt7SV3/lg1K45a?=
 =?us-ascii?Q?Sxw4Wx1Y31Qp7ErsYd5ZWvE0OGTV3N9oRPYuGFC+/W91BbbP+WURc68bhQ21?=
 =?us-ascii?Q?Ty2QH30UiZ4fK01sW/6b9aBPC5ZLgpWNkQRhxe0tQIIQ1m5kW2woaLff/xVA?=
 =?us-ascii?Q?MBjJorwaceMa5TP4IYymQAg1d0lMdsc0UjRFQqvcStx7hA1hG09erWqFszMd?=
 =?us-ascii?Q?7jRzbAOpkUTqp2VpKL7HdCa9xZXqyYj4iq8SVbO7PC9bBeZNSxUE4kHfj7IX?=
 =?us-ascii?Q?raJWi6dxnSSFA9TEW6FX7AnX+26/9uMYsD8FEiLrVBAcLWB5iTH83LW3COD3?=
 =?us-ascii?Q?lpczJuH4V0x0TXRqkJTrekJrKS8TplQNuuk5wu2nzHiIIYRCSMdeqrrWVIpU?=
 =?us-ascii?Q?8IO+COJufeMdswBdy5KdaXtu/Je9bkmHCvCD7H2XP4TzfCFhWpKftePi2UV/?=
 =?us-ascii?Q?uUwOnaNjMASBJK0PmscBtFyTMRsuTB8CotpzAczzw6UyeEtKuq93MpcCoWSq?=
 =?us-ascii?Q?zoCSFmwol2o33n1XwZ5x/BcMfCmgiP+9K3/K1qSKliIF7ofcEoIi4V90yNaS?=
 =?us-ascii?Q?/z26rADH8mHd/LJO8Kip184Y6MvpQ9wlBfMlFZ/rjBszvlZ8WjfSf46kYRRO?=
 =?us-ascii?Q?z35IL4aBmXrTNLpKUpqpj/NA3dSG/xET/PNZ6bedC/+TulcoYq3mWn5rmuN7?=
 =?us-ascii?Q?MosNCFLlAYCSwbauxCtCUc4LP/kCHL8DeNJ4zkwtjx2pbmfFSWe8Cdr6uoyw?=
 =?us-ascii?Q?EtM8BE2Td4LSy4RLhr89XfQ3iM5RL+EL3hQPTuflUesnwY+onxQh/SPAYpXG?=
 =?us-ascii?Q?1yr1xZYVaEOsO3VWhiHP/mEcKvl7jiAUgwWzQy0Os5txEghJuIS6wxAPP/36?=
 =?us-ascii?Q?BJg9iUVRhSw5PMEiWv91uEGXy50zNitgfm9x7tkIUj3ZJIXzvxLOE952ezsQ?=
 =?us-ascii?Q?egbBEJe+x34WB2f60G73Co3iUPsNR/tFkn+q2lvnQPhBKeJyMYVRiH7U9HBA?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B8kTRNqG09GVG58JQO8O2FmPGIL8QQ76uDEgHVU9otuhtO86p2ojjkuyz/t33tWnCVfnMCMPk9Kuix5e9SUcmIEHLx7Rs6QDOO4NXGRfZC2VX5eh7DCsCAnrHZ5UL1MPwpO865zgBoaAMGYSQ7iB8TGZQl2cYi7CABz0D/fq9x53gww319OScAbNKqOAGIMUTsXl7DBzb1hENpyHfLnvNs6ccfwQgxkHD+K7Fq2ojgApXs/lZmJJ5/9uQbyqhE5k1mYZRoobBFylUv+bpeMfNPKW9IHHpecaqQ1iSHpBV8x1BeQiWaW7Q9nk6d7EsoA7XdLFwtjqXAU22xg3jXK7M5+aCUnmZSSOGyHps8cGpfowKpXh9T6m8PDBVd/UGuegEylm/91ESX9gmQT8xWsAoAV+/3ZsNtd6mRMsVmrpVa1WbF8FRqbnKh40toxtTQYO+ehz0rCtyc423sctADsMsWscWHmjSIHT3cbJpfo6+IID/CL0FEcxAdGS9uCbJ0KMwkDHfySpQjQfSLnqZJieQe6lfLd00XLPYRvgsr62/s1CRhziuF+hpVUXLrOoSWL30MOz5mjhSZBCjit/u4Xn1DSPWzeiHA8b5SjdiKMeUXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8259c4-d8bc-49c9-23fe-08dcf03cbf71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:28.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNRFq1BVb9kF7BHEjKERJszT2RfiknggfyansBc4C3G+laBIFRrM7QG6jL6ugM+NZ8lIqC9nF4Xb0uEmwxSTyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410190094
X-Proofpoint-ORIG-GUID: G9dp5figf8RFje0aTdcuWPT_AWIx--5o
X-Proofpoint-GUID: G9dp5figf8RFje0aTdcuWPT_AWIx--5o

The XFS code will need this.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/read_write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index befec0b5c537..3e5dad12a5b4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1848,3 +1848,4 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
-- 
2.31.1


