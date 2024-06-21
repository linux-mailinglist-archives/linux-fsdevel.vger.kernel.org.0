Return-Path: <linux-fsdevel+bounces-22094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD891218B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27011C22271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51768171668;
	Fri, 21 Jun 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9nCG3QA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nvXkQOxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA487171064;
	Fri, 21 Jun 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964381; cv=fail; b=tSo3KrP6Ng4iDgdtJzEayKu7Gqn090eQp6XAKnEFnER2tXOhxjkx5TiSBHnkUGi887eohhDZUuSj/K7nHhRiTxnFXg2CvWIYMdYqYV8tWi0bqGNmqwFuZ0wHVNCxSeV3vCJciMmNKMkQxnrcVxuwXewmrxm/Pl2KEPGP0qPiWIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964381; c=relaxed/simple;
	bh=RnMh0YZeJy8q7JdsF9hIiJNZlgaibfSM5m+V68y1h1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Awc9gTMgYvF/+OraR4xEUoSIc2ywVilodgW2+hXrf02uRIDgydJcmjw/+1isIrc5yyrgyvjvXGhtAGIoLeHkeYOv1I+kwTRryEB9ctYywnyEYYMFEYksZmZfJtcMGRORPr4YJcPBBHU81RO/HVwwLCgxw7RNvHLvG0X91B0ayaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V9nCG3QA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nvXkQOxP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fQ4B018898;
	Fri, 21 Jun 2024 10:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=wFv5CA8hwZ6yyogfoaBEcrpClZLQUBdq4YjBgutZRj4=; b=
	V9nCG3QAUsSnLKKhWYcVeiCAxS49TtbBvWzMX9pJTYd2cpKcKcnTMmqhwJjClVLr
	ky5yCH97IOyoCnOcNS0v00MFxSfYcS/Lv5P6C7PRwxg8lnWYzZXayZITB3UFbBp8
	5kVPTXPmWXf5oLc/x1l/QdsDQwBK5c66hgHeSs9U13FGrGQbDP43rk3j0kdfMLTp
	tMCVPNRgQ5PeBspxYqTsDHBQtFyh9Y+OPAD5DUNajx2GcMy0Mrt6Ku9MWk8srN5G
	txQ5yUpMsL14lftepKWegB+8xHs4QTPP7Yp2sXF6EMXNNZIjsLAsUhNrhwlEAbeq
	IAgBuIfDUlG7PXuQLE4iFA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfsee8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8nh5l025177;
	Fri, 21 Jun 2024 10:06:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn5wc8p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME4sHj4zt2UTuqCoTxuYNSomn2IKuB+YYl0CwW4feXdFqaH71fzwpsRsYZbdP/7jV2PE6FA1CiDlgo00Us3RQ/oo0WTV6ra8dOlmAyKrGMvGI5+My+QMnMfKrW67lKypevEtyTEdlqzLM+HIabptbMSg8OreQL09gcJDXYUsIP5cW/e/mospj0OboCkETqGPkFzZd2Bnsdz0M/nozydbku76KGxdJsFD9oD/9ckIv4yZovlKIlGlNRFbE/WsQhtgIvzIbP6fEFNp77nMNVSGGdbyRscSWTUK/H+LAduSSSVSBo3RV8x8x26p8sV1Ve7W4VqJEUOBSHCHUt6Cnns7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFv5CA8hwZ6yyogfoaBEcrpClZLQUBdq4YjBgutZRj4=;
 b=BuleZE6cryYtkUuzxg6RX8CTw2MIz0Jz0kXbHgVsZbHLCyXqF12icyApS88v5vZDSTRAYX454HUBhOkW6P2xM/ZrbjMlikxGG7PCp6fMJeqra1mjaErPiyKLFofuFjpoLbVfNgK0HZgOJ3DpQJDrKyJkojmkqet7GgSVLUyLfGhlSQsNqKaEkaNMc7ON5xVoDqnOqNL1v4+FR3/vgQ9h54GXZENh/Gm6zPe386pXC3v1P1DjVHYaRcFk7kofNelFzpdqnBdYBTuW7dpeD24mCXyLiDvvXegiHyNnB12sivq1sUacKegjM0BgoRNPUqiGF8FZgylz46K1uMT+cxABAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFv5CA8hwZ6yyogfoaBEcrpClZLQUBdq4YjBgutZRj4=;
 b=nvXkQOxPQOLcoaW6w1Tx7T2ZMJpzqwIJX6Q0uVtGFgswRGMuYXxeMrd5d2E7Dwkiirzd9g1CyCuHBvChslM16XIU0J4VqZSI1MD4rIMLq3q4NZCwj1nH4oN7jS1wFTmcK5mLsYMohwDUvra//AjIeEnl6IQ5iYsP6AZOPsDSPaE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 01/13] xfs: only allow minlen allocations when near ENOSPC
Date: Fri, 21 Jun 2024 10:05:28 +0000
Message-Id: <20240621100540.2976618-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ae95e1-32f0-4a2b-d806-08dc91d9c17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5cgFsS+7vBXMnLK0rYsMeTguwXhdCBAWpYV1IfzqqQAJ3pecUN/DuG6OYuzt?=
 =?us-ascii?Q?MU0UQtdC6RQuhUNbAoBoJ9OR3UcqUlQZbyHmNokyvten853lbVqTV2eb/Kjx?=
 =?us-ascii?Q?CE2H/2VOf8XpOJytNsjc04elC0vwAHdXENeIgbP83WKOSYn87UP9JKqzjYO2?=
 =?us-ascii?Q?cQb3c0Tnw3hf9O8o8jk2aOehWAnli0qI4sJ4lPstQjPoPdUVqSinzSdEApGS?=
 =?us-ascii?Q?a73bR2+hvZZYRmKv4rd4TDmen16PDInFCGD9b4oTMkbLd2q55m5UtIyLwN8g?=
 =?us-ascii?Q?u5Mp3obZz+AXxCU77sGuu0yusgD95D4cwhZd0XBG47GCkzNXPwBzTgvWz/HR?=
 =?us-ascii?Q?9l06vNpwOhc6UcvDWe0SccnG0h2KdfiV2a+EN5yA32vlaRSiTNdiMeIIHEeV?=
 =?us-ascii?Q?nR9D/QgNW0P1yZnvjdN15SZThTqQT30coJhkQwagEzAzfq4/RUiWBJRtxwnY?=
 =?us-ascii?Q?7EJecHDUw05yvfk+4ITnSxV+o6JUDbvzPNYt9/vHPfHM+nob43Q1a+4PZ9x/?=
 =?us-ascii?Q?G+bdk3NLkUOY/7UVrI8mR7e2S0oP3yGbOINdFRmbJgWLkmA4//7ZWArdoSqh?=
 =?us-ascii?Q?kFrj1SgippppcHA3MBWEPdNfv4B6/m/xHdZl8ls3sFR8RuGlDGiHez4ohfsy?=
 =?us-ascii?Q?CjF+Cp045VRz0ZJDvBGsO6btjW03FxNhNQyZ/aAjDTEHd4kjSSKs/zRqHBQP?=
 =?us-ascii?Q?QSzyB/wzeYA3S0CLm/+C1R90osEPZIDduO2fk5HxBwVGstg0CJVNjfULZ3sc?=
 =?us-ascii?Q?caQ04WDPHWZlnAa9SkFLFQcKgVB6U8aQ9tJdr5JOpfLE02JjrD1Bmp7bKIR6?=
 =?us-ascii?Q?aFfT+z08Ljh0CA4stgyOfnH78Pk2/E8464BmFvXvQoE08ZW3GgvMf/qJ97L9?=
 =?us-ascii?Q?VCe00Tp6U95YVqVVdqY5UwT4CobvRBjUNfLFG3Fo4oE+UlrmMWRcSCiJfQfp?=
 =?us-ascii?Q?4EZ5SLZtmjThonMD7QDxufdjDAOuF8euCwFAZp5z/rY3XZ+CtgRXdoUyODf1?=
 =?us-ascii?Q?kj4c+5iLW3l+6qc79levruf/BHCo8algNhNVCyqfHjvygA9tJfcy0Pw1Ypm6?=
 =?us-ascii?Q?iNozm9062Vgn4MMPWuZxaWIH7nM+d5jznn16Fkp3n1BUL/uDIuS602vJtqPC?=
 =?us-ascii?Q?yegRQ/Pn+MWKjk7HxRNgeLNiEMyPrUkRvx8bIYtDxY6yqsLnnZ0cuKDm7G6o?=
 =?us-ascii?Q?dh9YTbg2Jkoelhs5B1sfG4ARwrpJ8YBiEQbyiieWzdLdwwJoXZfz7V8oi6ti?=
 =?us-ascii?Q?FV75WIpDq/GVcvAGJm3PnrBHB25J5Cb6II7cFR9YsImUJh2YvBl/wTkw21Z2?=
 =?us-ascii?Q?PqMli1T+J8ArA1N4xfyA1zB6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KI3ZRy8LASHmEzalmZwpaW/1cycqXMccKywcVtqo6FJldEfIWqdFbs1lrRg8?=
 =?us-ascii?Q?jVYW3XYyNyL76RYwbPZPTCNA8X6o645Nxjt9dTDQgtVx3oQQWGI4qzz0MwYz?=
 =?us-ascii?Q?F7JAi3Z6OBMe71p2Am9GTy9YGe/eAWJtc5urjAn9imBDoXRevnhmqaLnf469?=
 =?us-ascii?Q?/GWZCwwbmUyoaBrOTb3KxboR+1XU5SeYrIrAHCNz5EB+JbkjKrR1zZJj5chC?=
 =?us-ascii?Q?Br8kgut9/n6cwRNkayezh1g36/njhqt5/YmpyUAsbCzjxlsuVlZal/Z+Lwtu?=
 =?us-ascii?Q?6B30T+PZ6n8vjxQBPQ8YtgOA6RZoFRKE0Rn8VEKmMNgZD6boZy47gQA+uE7h?=
 =?us-ascii?Q?6D69N9J23sfFgGyvOXrU5sHJxMrwvGILgVf4piZgpADYFlgvjv7xWXenvItr?=
 =?us-ascii?Q?xD8cLglHG75rc+Trg5KeWLbjXObmSMCa0Y05NvJk+HSpBYsYDlrO43QAJLma?=
 =?us-ascii?Q?RMGbGdQVOOHoJJMX0T8KXIKi417DkN74Vq5brUGBEk7jMdYHnw6+WYKOeA1P?=
 =?us-ascii?Q?E8lOfCyVShzeApHyN0omLMchMQ0cMBjY3bi4G2DU64sclAkB8F6+dksExvYm?=
 =?us-ascii?Q?OCplILyPOohOIO0gIdB83jQ20+EaLLPYRzVSNrxDDOnUfnB9VuW1zb3RXjST?=
 =?us-ascii?Q?FlDbwoGOBG+bY+y7gFuteXgh9tzd7Lm/P8cKDbGy2Lz4k3l0YNTlmIWLOvGb?=
 =?us-ascii?Q?cSgyzTtSTi/809POna7MNxSJyIutc1u8bhZrMsCNFnfFoEGV/4SMJrdECMpr?=
 =?us-ascii?Q?JHtTLFCmLd6kKw/SWi0rOvGeTZWyYk17789CnHaB5AdSwbkhE7lShqpYuak4?=
 =?us-ascii?Q?Vc6wezzeDvrfL4mTxdUY/4kdCHsdgouuy9TZ9t5EPDCYoUokuCC49hEU+LCl?=
 =?us-ascii?Q?dKL9M59cvCf/rN+vax2N6+Cw2TBlVLn1R5k1gTXidDuQKksbE2VGde2Psi/Y?=
 =?us-ascii?Q?IONDAyV9e3YDIE8Y+OHvtrlPKzd+Jw7Nonp+3h1iGxwje2n2a2yhJ5iLi6G0?=
 =?us-ascii?Q?GwdVyNV+TP1vxaB5IJzpwgx0U7/Wof3jvfzo2U5ciHP+mZmlFE62QryurWKn?=
 =?us-ascii?Q?e9CAG5EUUCNflhLEGtcs7JNcSE1co6LfHZiRn3oc+GVTzco1reH9IWdhKusV?=
 =?us-ascii?Q?nCqhOkk6l2E+HjH9Sk7o2UcFJTN2r7Y9+sQVMMj1ad8YC3doo+FRqKSNLilR?=
 =?us-ascii?Q?JxUsX9H//t7OafQU293sCuhezORpsJHakwXxONS1ytONMjaTsCmSfSk9B5ft?=
 =?us-ascii?Q?esH5Qwkl0ukQHrioJV4LCjGpdWZPGLKTyT013nTaeHNFy3buSz82rhiELYZq?=
 =?us-ascii?Q?7nqxCBjWCAGAOHvUXFSS/3xbaVYxCr+s8dOwR8+T6EKiy+bDWqFoCowEDeJ0?=
 =?us-ascii?Q?yJzTV7gjVZ2ptB2NGL1wFNt2+4mg97I01leWKMC1/6oVF/ZI003dw6IytxQK?=
 =?us-ascii?Q?IMCDkMHGm3V86ySaQLQ2hV1EFWScvciE4z6YCrQF2fHtItVsiEp3OMdO5h9Y?=
 =?us-ascii?Q?CLjF2MvzzL52WzGjLgvoCNiWbypVicCBKIhYdminu+iLtTqYp/e6hc1sYBd2?=
 =?us-ascii?Q?GWGt8KT/Qw1jvjr9FtmtJT925IJS0L299HlDpGfgIgiCHvL9QBoK9yu7HVbT?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FR7PhR75WcJ7sJ2k8RaT3f9lXDSpriyb4OevD8BFpc0+J2Sc4QU+hVMITda6tsMJdT13PdjmZD612EfnVCeDJt1vMzFCrn+h6U4gDFw8gbeRsJwmUMUvfaYoi3rXspiw7tLwbWnHBR+y15gbToFQe4uOTF5TKVDO9FEmSdHgVY34KGc/ENzv0KoZn+4ki9JEs11m1zjplSrat8EAiwmjavOsAnnkJkhAFWnbzkHQnUcRbQSAyFVv9dd29uNBOr1f2cc3aMATqZKVv9j3GZs5sYu/EVo44uQXVcmCeymWJn+luLFxLhoAdUlQph9zudKCNilqbAoLEGDEvVRxUSW8t0iR0cDkvINYUUtaLaBEjETkfNAhtJmnHv9fchy1OqNbTYZc8PgnpernzvxeEe5muBmV8JdDeMNwhEGTf8T2bhrouXSeD6uMnEk6dJjnhUK2AVYss7AxEB+28iBmcCajQooaDCFDwgvPjG6NnAxdTGoMt98OpvzvdIpjBFykCH3CDTvximDa9uT6TxCjy7yXUlGvMzkFMRq7A8AiXbuhM1v/HKe68lTAmSG/+g33kOzcQ88QCAecIvoI0dcMIZ7CeMV+chBb7olwGZL3aZ1ojV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ae95e1-32f0-4a2b-d806-08dc91d9c17b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:02.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EoeKNikR8Ce3ZOKuRWng3nKvEnlphP2zTMxxGPMusoQiTgw/W4OTLZgjwFj5K1XeVoS4cyLsihC5SBGdynRAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: ATZhaPLLBz5TaklbzujKg87BTNCX4pHI
X-Proofpoint-ORIG-GUID: ATZhaPLLBz5TaklbzujKg87BTNCX4pHI

From: Dave Chinner <dchinner@redhat.com>

When we are near ENOSPC and don't have enough free
space for an args->maxlen allocation, xfs_alloc_space_available()
will trim args->maxlen to equal the available space. However, this
function has only checked that there is enough contiguous free space
for an aligned args->minlen allocation to succeed. Hence there is no
guarantee that an args->maxlen allocation will succeed, nor that the
available space will allow for correct alignment of an args->maxlen
allocation.

Further, by trimming args->maxlen arbitrarily, it breaks an
assumption made in xfs_alloc_fix_len() that if the caller wants
aligned allocation, then args->maxlen will be set to an aligned
value. It then skips the tail alignment and so we end up with
extents that aren't aligned to extent size hint boundaries as we
approach ENOSPC.

To avoid this problem, don't reduce args->maxlen by some random,
arbitrary amount. If args->maxlen is too large for the available
space, reduce the allocation to a minlen allocation as we know we
have contiguous free space available for this to succeed and always
be correctly aligned.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 6c55a6e88eba..5855a21d4864 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2409,14 +2409,23 @@ xfs_alloc_space_available(
 	if (available < (int)max(args->total, alloc_len))
 		return false;
 
+	if (flags & XFS_ALLOC_FLAG_CHECK)
+		return true;
+
 	/*
-	 * Clamp maxlen to the amount of free space available for the actual
-	 * extent allocation.
+	 * If we can't do a maxlen allocation, then we must reduce the size of
+	 * the allocation to match the available free space. We know how big
+	 * the largest contiguous free space we can allocate is, so that's our
+	 * upper bound. However, we don't exaclty know what alignment/size
+	 * constraints have been placed on the allocation, so we can't
+	 * arbitrarily select some new max size. Hence make this a minlen
+	 * allocation as we know that will definitely succeed and match the
+	 * callers alignment constraints.
 	 */
-	if (available < (int)args->maxlen && !(flags & XFS_ALLOC_FLAG_CHECK)) {
-		args->maxlen = available;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	if (longest < alloc_len) {
+		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
-		ASSERT(args->maxlen >= args->minlen);
 	}
 
 	return true;
-- 
2.31.1


