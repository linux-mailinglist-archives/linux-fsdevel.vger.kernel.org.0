Return-Path: <linux-fsdevel+bounces-41652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D4A34116
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC48C18874F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDEC26EFF4;
	Thu, 13 Feb 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R1Kk6Xp+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lu6KztvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49A269811;
	Thu, 13 Feb 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455047; cv=fail; b=p4Vd3DlWisHUYmlc94yx3nAMGkg4WGEGmClQFnh4vnQh3Bbo21TR3eBWsuLzagVhetAC509M2ozfN1X2NJy9JxAB0PrfkZD93Ns13v+H8DxowOWcMQhUpnLTvYxKdH8EN1QVKJkweVn+UuGPQipMu+/neWuhRv5MJYNhNS1mX2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455047; c=relaxed/simple;
	bh=gDBb9MYt66a2D7yCy++c21isBV3p57d4fcHwulxKnRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayaLX2psUZE7v7vpJd8zKFLu89GIRm8+dCFarsKX2aYu4QQK9Z+LTJnl2HIP7oYilAPoqx0j9ts2xsdF05HJZKhv4aw1twu9q5keLnVZ4Q1RVFPmkn1IrsgPD+DWaznOYAGoN7NynkZTWKnwyQ0x70/tjzxS2CDLoQPrnaAi5dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R1Kk6Xp+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lu6KztvX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8gEbV015810;
	Thu, 13 Feb 2025 13:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iFDJ1JOi3dh0g6CYEgXzvF+W7/GH2yOMfbfCh9AQY/E=; b=
	R1Kk6Xp+Aydpg1rLfsQSixLky9vNQX9YyytLzKKKpbafdLfy9iR6ZXXqNqRECFTl
	aAluesxcVDO+9uR/bM52jZzFEhR+l0f+4cL7cl1cLvWgTOSRb0zIL+MJ9nzwK+KY
	D3adQQY2A9fzenUFyUWedWvcst7Tby2FDSbT0YTZZlZH9l1jmkwuySMjwmeyAEqi
	I2DuGjzoqQyt5aHo5PGKkxCsxHywLtc4XjI9WB8YfdFH/flbggfA27m5K2/KZWR7
	n+TkbQNMcA2FXH43z6nwYm7Cxt2l6opdi03U2WHi7BQ3NnA96z+43TYGv5fIb8ph
	G18h52HmD/v1IkLYGlCOJA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2hnny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DCwq5k026955;
	Thu, 13 Feb 2025 13:57:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbprcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sn2Vc89G/UsOy4n4cwjBT5jmjMDfClas+L1+pMuAEuBGFikYlmVCl6TA2GyTS9FMW6HSKNN+R1gdZIFkPZ/4AlOfI/F+QJXlFpJzgS0QuqXvmQz4dHDeswnffgdvO8PjEUxNYh4u6LlLGGa1hJXUxI2zpKcEx/FP1/obJfPeGbTY1cJbdfDnbSrjNCGvGvIb4/0rkG7UYJDXDTrzoJmauovZCxmrzN0q+9jz8uvSEcx2lhFfUyfGqNlMEXYcLJgLVtE0tin2Cxikeo3ZLLrp/AhaF2srcLxZyZ2zRFHWbQgFrAbCrOkGqJlvOLv4DehPOHOZZbVSXj5UAcMWSWZseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFDJ1JOi3dh0g6CYEgXzvF+W7/GH2yOMfbfCh9AQY/E=;
 b=uGnHF+0n819iL1/u+jerjUxVNXporg59z4huftJufWLDvzk8NKCcOK2XW99iCt6PQIrztygOkcNI2UFMIsneCieisw/Ww29YHGfgRvcZbZg47fJa2a9Fyprce9rjeXvegQ3PNj6/BKa1jZ48uheTIkMeSGheBNZT6GwbgmyghtqzrEOW/6xHBIY2evxQy3b+ItHxek5jgsU9t02050tm39qF7BPVO2GinGHXyV2E9ts1vUI2+FPUwrQznIF3Szh53Rz/oZm7DgHvWChRbjKv8btPlYWW8QGtUtvfKjbMAI+dwB+/GY4LpUknUtLqZc+tgc/YpRRP1I1ZmH3RZa01fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFDJ1JOi3dh0g6CYEgXzvF+W7/GH2yOMfbfCh9AQY/E=;
 b=Lu6KztvXIRgDpLI3/YMHbtHwILift/L67ipA1XBAJB5MlbehCws5FFrq78I07+xr33TggPQap5dfphIuDuHGPwo+ytbz8Zs4OB8GS06Z4np8GTsRnIox9XVdBhirlS66Q9WuwyF0onoFfHmRQc7YprK/8yDsrrt2MxPKG564g6U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 06/11] xfs: Reflink CoW-based atomic write support
Date: Thu, 13 Feb 2025 13:56:14 +0000
Message-Id: <20250213135619.1148432-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d4aed9-df99-49fa-864c-08dd4c364e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+NSaZ7M83+j1SYeLR7m6bQ5uGY2PrQLkpHiwMb9DQryV0ffDK8pFXsC1YKCR?=
 =?us-ascii?Q?xjBUC5dwqPxiYfwOk197AM/luhWgDS1poByWDsoSSRSWgifeJv9lfG9owJjl?=
 =?us-ascii?Q?hoKW01NC1TLlyJbjXztbV2UQJ5HEewwVIyl06FD9zF8wfJ4qCrAsEx5FgEaH?=
 =?us-ascii?Q?RV35CwiaKcc3jjLRqGDDXw6guxhQGeuvF8misC7xaw6lklayU/L4NJsa+Etw?=
 =?us-ascii?Q?6e4tK46nld2dIE4wqRahaawCLbtqoh1wtYF7RDl1HhBqkB/FQKh0gK53nNyw?=
 =?us-ascii?Q?R35ra6XDruqSciNoPK1CQr93oHi0qBhvLrKCHgbNqLf1khkRxW8S8CtkLrKn?=
 =?us-ascii?Q?Ej0JcHhbNiwsVPmiO/S8N/90FfQQr+phrDY0fUi9RCp86H2AFyY+CJHWflpx?=
 =?us-ascii?Q?bOio9b8gGCHPk7Ys3DSvE3NKaWE45p2inRg43nqlXa+T/uU3gC9g9CtcLSUR?=
 =?us-ascii?Q?2LhZ8PCG8WL2shlmjd3pIyBfVAbLeFzT2oUuvkupJSncgmKk/LrG9ZLNZIGK?=
 =?us-ascii?Q?a0JaarkEbyHhuetxP8IS/9lPZ2yPsEhxw5EhZ8zhrNw42GmM/ZPmWD9zydAj?=
 =?us-ascii?Q?bNYZdAwZ8e6NAe/le7ajm7cVY3rtMItXR/w99qJTIQL/X5OTchs/su3NDXjt?=
 =?us-ascii?Q?8SMA5taAV4xoawmrLF/ASgLrxPKtOf4WZf7nblCneCkigijroUGMv3vOJE/7?=
 =?us-ascii?Q?ijml1zGRz2V34WMcS9ZrdhgUZiXhmjHkeX8TyPeRYB8r3W0cNh3whYp+Nmtw?=
 =?us-ascii?Q?IusJtB/dAiUMqWMyd65Tj6ZuLUuV9F9bAvCYQvL8Mv0zSz3EP11B2MdDU7yh?=
 =?us-ascii?Q?snFWETyW7c5H12qbh/C4+FKOsIfUropQZUdgr3pGvl6g25L4etaVq+dIxcdi?=
 =?us-ascii?Q?xyk2iRJjgbPvOjWDxh7Yc3SZBRcfSmzebRLvpsJfGBLMAJpIhh3Pp9xUgDIC?=
 =?us-ascii?Q?gIIJv1Yx5nOliH/OtlAeRbu0YLXBLV9jpWLPIgcg5UzywklFOuhO7jyGFPDO?=
 =?us-ascii?Q?lYQw0ohm8m7/RGnUvsAjrmjoaw8S86QrXzQF9ddml+QsCKl45zaHBaxM7aYH?=
 =?us-ascii?Q?SCgO0+HkxP05FFpTdgluvhKRd+Zx5RvmV2+CdFm2VOfPW8dIfeM5Arzs8+pq?=
 =?us-ascii?Q?7w7MUtOnvYdzLrV137v9pNOcmWGP+f/sQVI/HIXXqoA++CMWd6t2UvAJSGCN?=
 =?us-ascii?Q?YQAN/xqBEKpe73xrKl5Wio+3+HaDj2jvN2iIVZLGf6DvEf8CMNaiA6ariDiV?=
 =?us-ascii?Q?niqx/LkuEbjTlVD0AZAd4ZIXMUH8V33jODI2NfsAjrIXMBDw7yzH+fMxACRM?=
 =?us-ascii?Q?IX7BP0imfqwBdYP5uHKSyRyFReIrageg5x/e9vyWasIYdDVvh8fRLo8wWXYw?=
 =?us-ascii?Q?aYFU5qZzXwKqcDiDuPInJcvFTGh+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDkkfhYUFpg2Bhk7LN8Gwmvb0CanVxIzglNE6MlTz2zufpYJWM8MTGDg44Dd?=
 =?us-ascii?Q?kGTlQy9Aw2hz/wA2Y52Dk+8EBPqmFm0yV+kRaZO9i1fxIVnynWii+sltv85a?=
 =?us-ascii?Q?4V+yDUCL85adUqN8fmDhxcV0Cxp7cUnX7KXkut6+owQS1jIEZ4tYnJCEEC91?=
 =?us-ascii?Q?/91t4OWy9DdqbIsE9azjmxqixe5jmKd72R86YRZx4gVeRynDM9meS4Dpy3Wt?=
 =?us-ascii?Q?qQP8rOUjJOCseHeFTENnH1TEciE9xHsCXS7WJ517IuGU+mAVGEzJUxw9gr5u?=
 =?us-ascii?Q?aLt1CM+MJE8bVZTVW4nus3DCE6eCq862RWvqPXIDsjmkL5py++09Rm+3wK1U?=
 =?us-ascii?Q?rmkgmLe647UUycauLzkngTn09PfxnwIE5oCBIhVkT08DOd1IAH2RAjVSSPsN?=
 =?us-ascii?Q?gFkpXMmkwcIyE00yY51waj6NXTAFb3oS6XQpKSOZZ95op+IlC9L/PNLdB425?=
 =?us-ascii?Q?xA0U/It9JWW29OLDEtvOINoL4IDA+EhZI/pYSi4jIGwVTVKpgdZiLjxdIXnl?=
 =?us-ascii?Q?galb4MhEa8lSD4Tkldf3oSYE+g8m3e5UsxfGpFjuRFgcXS0xWwh4q/Afm+aH?=
 =?us-ascii?Q?/GEBnmKuKuKhLWGr5YTvRZcy6clf++Kda+PdqyIxUeO6Wld+7OyTiwIOYTYT?=
 =?us-ascii?Q?NIIdPZhfR+XNvXgJFrEqHq0oo9uXk3Tzz1rC3VBFkcXjCkRcFnRwbam9m449?=
 =?us-ascii?Q?nesW2B9PZhGUUxuUjWrwwTkLOGrVn7exA8fqMx6vmY5Li59xqfCVklNuZ711?=
 =?us-ascii?Q?SvwGJDRAEoeykNqaYmqqH6hUkPia23ls8X8h5HLgX0q+JURDGEaXrwoNnNUN?=
 =?us-ascii?Q?au6dqaiqYdcRwDXvmf1vrVfgByashix3JdT2paEpsHfkLQtG1moSyGBc6DC0?=
 =?us-ascii?Q?GslrC/FG0d0rnf9LwYQTqyoS9f4v7C4Rc5L4cQ+umFJ0aFj9tBkgYImtMESb?=
 =?us-ascii?Q?a9rgbrFysoBV1oytGTbPqBbrujq/q/95spN/hE17HML8sgeIb6DVa9JfJjxE?=
 =?us-ascii?Q?ZnwwoPTxXcPiCZx3exW76Ie4HLUPCt2bEx5GziYai2xR9WzIOs5DZ+MXYL0v?=
 =?us-ascii?Q?0xYaGkEpEchWwNnLn4EcW/pDK8XGCfgDXydTetDDfPs1rmX1Wwt6d3q45w6I?=
 =?us-ascii?Q?EojFUXWeJb44ZOguComW6fE0Spe/fGqks2phuX08l9gs82KEScOxeNOVEaJr?=
 =?us-ascii?Q?o3/zZsoZ3mF3dmjCfx6Qrfnj6kzZe91W+Y9F/2yJv9/szBzA1pW6r+e22V/a?=
 =?us-ascii?Q?+CLLx8AvDCO0hIHdjy3yb/A7/l+e4J4Z+1GBUINp9iX1xhfMDrRgKdybhMI3?=
 =?us-ascii?Q?LhFMdx0IHZUmyLXkXn9IDiYVgRm/s5Ti/LDSHpqtyTkGal5D6LCS9abR/UWe?=
 =?us-ascii?Q?aQYUVkiM/F2lU6mgUXn6GzWs/9b5huoCCx89xBd0Kvq+13SU3SeVoGIwNUV4?=
 =?us-ascii?Q?qCFe46a6yPJaX5mKxEvJyA+5hdw6RHQkMpW6ffootdKWlfWvKl1iqdRNuIC0?=
 =?us-ascii?Q?w9WyVK1m8C1rVzBJQXtpyEPKArwwBM+Wg87RNz30l6zS7lvIsBys6SkN7gLi?=
 =?us-ascii?Q?tb69CBmdBLUo7B+egYFlao2ofnqHw7y5sv615kQp5NMXmzxN5ZYx4yYBUNbx?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WNBMTYx6zPvXDzUIpHS2JQIpGkKUt2yfxB2b3YhMUk7lw3GqWmq7JBY44ZcccQu1AjwBCC6U77TXmKXguF77ZaybRBw+eCo69V5bFowdw9qrNhoz6wDvaOkrSGy71QD5x4jL0hcS+QIyN3HYj/6Or2AN/CRio/KfuMkbWQwHOzGcS27J4rm1nXF809IThNjuYIzwI3SaTuCDXtUIjZATE8U44N3p4SNnfGuEmKSLkJE/1/PO8+pXAvSRyp2+jnGKsa4JbiXKE6p0RhHSc1yZM7TIDVthyY16OnA2CdmWrTIIub0DBV4v2ohwPsJoxWuK16y4nUaLjdcfDkpO9zfB6bxtjbfD5QVMSGy8HyqAKxmtcm/pbNaEX6cD2TDsdTohldMYGZbhcBffPxVAcunAs/JLgb+qCeRU1/AyTsv9gnGEbXkWxScuCO+z0SYEKTWM8elnI0XKeXEQsXloLTcDpISSEbLjSk87NteVQ1RgquAKW7mXmqGyDglVrVrfylH8SORtUGbROPpdslJkITH6+HdS+qPWdXiVzaG+TgN2sBfBpyBe24rRf5xXiF7x0TzU6kIoG3LF4lzFYbGEozbuNrj2teKc4RPbr9KKQEvbtR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d4aed9-df99-49fa-864c-08dd4c364e96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:08.8691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1Et7kMDmKWTsRJruifipvKyvOFEizODi2S4fqMQJu/vQvUeqTjSpkxo4ITHLby5SrLqFL8V7WvY8aDpTrM1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-GUID: VkdNGPLcwzzzFuK7wgBXYYw2RT_dJDJd
X-Proofpoint-ORIG-GUID: VkdNGPLcwzzzFuK7wgBXYYw2RT_dJDJd

For CoW-based atomic write support, always allocate a cow hole in
xfs_reflink_allocate_cow() to write the new data.

The semantics is that if @atomic is set, we will be passed a CoW fork
extent mapping for no error returned.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   |  2 +-
 fs/xfs/xfs_reflink.c | 12 +++++++-----
 fs/xfs/xfs_reflink.h |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index d61460309a78..ab79f0080288 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -865,7 +865,7 @@ xfs_direct_write_iomap_begin(
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
 				&lockmode,
-				(flags & IOMAP_DIRECT) || IS_DAX(inode));
+				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
 		if (error)
 			goto out_unlock;
 		if (shared)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 8428f7b26ee6..3dab3ba900a3 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -435,7 +435,8 @@ xfs_reflink_fill_cow_hole(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	bool			convert_now,
+	bool			atomic)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
 	*lockmode = XFS_ILOCK_EXCL;
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !atomic))
 		goto out_trans_cancel;
 
 	if (found) {
@@ -566,7 +567,8 @@ xfs_reflink_allocate_cow(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	bool			convert_now,
+	bool 			atomic)
 {
 	int			error;
 	bool			found;
@@ -578,7 +580,7 @@ xfs_reflink_allocate_cow(
 	}
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !atomic))
 		return error;
 
 	/* CoW fork has a real extent */
@@ -592,7 +594,7 @@ xfs_reflink_allocate_cow(
 	 */
 	if (cmap->br_startoff > imap->br_startoff)
 		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
-				lockmode, convert_now);
+				lockmode, convert_now, atomic);
 
 	/*
 	 * CoW fork has a delalloc reservation. Replace it with a real extent.
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..754d2bb692d3 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -32,7 +32,7 @@ int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 
 int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
-		bool convert_now);
+		bool convert_now, bool atomic);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
 
-- 
2.31.1


