Return-Path: <linux-fsdevel+bounces-50088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D83DAC8196
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3241882397
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3B231836;
	Thu, 29 May 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cyOKBma3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xw8pgmG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635D230BC6;
	Thu, 29 May 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539002; cv=fail; b=RW3SSJV5cWsBgVCIwNFdG47HcgtA7hGU6kzANbSP+FARsy49Yn/cfwwi/08y2CukD/bhkbJBNjeIYaOV1OrScfqmGr2ziuremtju0P9RgGRKJ6EmRjVhipqn5P2BcaXHYIc30eXYYg8x0f9wTBd6wYjb/elA7hZ5wJPNTDlzdW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539002; c=relaxed/simple;
	bh=r+h39V/M1VoTa8GJDlQVV9BJSVj+bEVIFWOF9JQfA0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bEMuFmKBvyONBhvP3v0tQtjFwg0vJtwX3oW8ESTtHI2vmqm0KcPnISMbDcmsA7vnWUBgp5l7M+Ztg19ZpvpqFUD1Ps4tx1Rw6Np1f2H5ghPHkU7AtTZIr0hsG8qxvnylAMcV0V8xGBCgz3AFdRx0O3Kcp3FCtDgMwIkXP4pKavw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cyOKBma3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xw8pgmG+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfwVx020992;
	Thu, 29 May 2025 17:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j1Zy6cAGSbC1TKi8DWFl0e6qULnOj5/MKyYsqMFr7wg=; b=
	cyOKBma3luS+mSoNXFNQ0p/jfu16ArqfFrIj/sy5alIZQNnBryOlVBf2im1F62Jb
	h2of/oLkU7hNlA+hqkmqqDDSa8apHPh259ojsOeoPtrjMRlg3iSuYHqvjmgHeRRS
	DuBpYHUJ+rurNUMlescQMilut7rOXIUzJQ9AGlzbED5CvYaARHp+M6D6qgxSmf9d
	/bTyZewVbMJTY8MinykUQ3DADf6vOJeeluwmSVPwmUopTTxYvTno5M3W1Hc2sBuc
	igViCvLms5O0vMOWtpdE2rTjbeh4D8klOowsbiFZXaQboffFshi0mnfdeHGAChTa
	IDu7gbcs/wYIi9khRUG+7w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcmnue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TFl4u1019193;
	Thu, 29 May 2025 17:16:17 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013041.outbound.protection.outlook.com [52.101.44.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jc7usf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV+/c8Gd+3piwIzBOsKkAGp+xzw0BPiwl9GcX82ON6wyVa7C/GUZANMbvuXmUj0zUcoJ9tSf9QgDx6u+H0JRL4WXs6Sr8gvtpNDGwCHWOGNaLChtUtk/SfqEOFjOdjTb2dlLtXxQF9YURSo62eSo5Ta0C2L0xIumP4qG1uChX/SxlFF1e1faN13DqABZKqKN4UtBTwdOxTHuF3axeppIF7M62kknZyc0POIJX/NArKM72R189crADRIzQE8qyzbNnclrWTJTU1JB1MvCj4B375hjUYFSRcRDKeVfM5VG2DA19qKD4in3bNF1lu8149b7M4VsYNUyur77TcpeAR4SSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Zy6cAGSbC1TKi8DWFl0e6qULnOj5/MKyYsqMFr7wg=;
 b=qYtLk8VYtjoBeaDgwiYzJXXtf8DEoleZSLYQKnsD0VRMfNJR1A6SolhgrDi332xnlvPKE+8K1MfRvZmQuDJ3R8YQ+tfb3I0WfdYWQF8V//SVUeG9Oq4kOqQNWaYA1kPbpAuHRCFmMkZDR78xyyiqN0kfQHjQVnYRSnoCu2mLarU3K0NKslCu8LIQDqqdsjoOs7Nad0bHmQkcfR0XyJGfjsZAi33QASAccaFOR+g/F7beyUSdDu9baY5lmvP0T0GfxnITdf067JJVSnnLE5SK3LHHRaeCuiVA7v8+tZCcle+McFUoLxtIN/T0zoLTGFBpW43aDyIROdEdqLPOmuqzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Zy6cAGSbC1TKi8DWFl0e6qULnOj5/MKyYsqMFr7wg=;
 b=Xw8pgmG+gcnPAEob47ElL9ej1Ass3ZXD8ytFQpe8G+0MkBMNHgIxPX9sG/WrgJLPxpv80V2mn2rDFmY/WbeQ6DWkp9Q8pQnuvxSD28l0pGzy35Nl8qAwahvaogNdW6D+DPzLnEv/VyHz7/epCEyKx5Jknba9bdJDdJM25rTqtKY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7991.namprd10.prod.outlook.com (2603:10b6:408:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Thu, 29 May
 2025 17:16:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 17:16:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: [PATCH v3 4/4] tools/testing/selftests: add VMA merge tests for KSM merge
Date: Thu, 29 May 2025 18:15:48 +0100
Message-ID: <6dec7aabf062c6b121cfac992c9c716cefdda00c.1748537921.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
References: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0164.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c72220-1580-415e-ad5b-08dd9ed480a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CeeMRyG6v9bRLXTf1lPMNqEH5EKV36siOvUa5LFEHBh/XW/ZH63H2naNs+Pm?=
 =?us-ascii?Q?ZMnoOk1E7bWI/a06NqC9qAYhkkfaWtGrK3Pc3A4vwVibBsCuPsRI2G8I6zcA?=
 =?us-ascii?Q?WdNTQd7qGV98sFgLE6sniPfGjI1qGzyCHu+GncFdOyTdeFgg2nd7dGHIfwRh?=
 =?us-ascii?Q?/rnL/49ExJTwtp65Nhl58WkdHuvnouqyg9GXx+R5rma/WURwGkkYgBa1t0/x?=
 =?us-ascii?Q?EparIuh/OcZikQEne71Xb/FIVULP27axh/A1WPnwnwrzKYK2szzVfYwnEoPm?=
 =?us-ascii?Q?92hKcSabVlEW3cBmGpH9y6c/GAEL5/b8TBlrbtUobJKudf/M3IbTNQiXxOsQ?=
 =?us-ascii?Q?59+Lg4yRWcL/JCjcZRawGMGxPtAyC7engnGsOtOF4lDfnt8SRyG+iYgG9QZK?=
 =?us-ascii?Q?jKxJkQI1d8TVqM/MEFjgneXjAJZ2BVSm6rubhmk+w9V9bpOokT0meacxDyCn?=
 =?us-ascii?Q?D2IOuGoZ2Nu2emO3j4qYu7WITdp9JdzMuaV5e0Wggj2gWgyI1iLSBcHpSAr4?=
 =?us-ascii?Q?ZNjh8/CNidw3/Xhp9XLez0hkn9te2mOyOE5S629ZUvzSbZo3+OOTFnxq70Jk?=
 =?us-ascii?Q?3wcTP4NgGn6bEhPYFZR7rehi0TP6abhiTKZP+NcAKTQX5Uu+8fcnwBxjA3HO?=
 =?us-ascii?Q?vVTUpkruLS3NW0N+FUTrHA2NDVO8eEEvayA79+F8fcwGskqGqwa2bhH4lsQj?=
 =?us-ascii?Q?tDaA8hl9G/FDG0gyKQMRAX3W6ESBUlV/7jKGZB9rDmzskmS45qiedQHwilGN?=
 =?us-ascii?Q?7uo+OCCKMZJ5CpTCpf3zN8XWIWLNIPGqKtdZFQxy5MJLlWi4VzHmFkoij848?=
 =?us-ascii?Q?/tNCMKjL0wlIOaYlp+mbLvXm8VJpookAHiHHN1om1uiJuz/zaKCdXP/U/Ymq?=
 =?us-ascii?Q?Rv/Z/N6NHiMl3EoxAg2SyibCEU8cVlge53P/E3bx1LHSA7iFetiFiGziLko9?=
 =?us-ascii?Q?RbSIHdOlTvsnypO8D9EW2ZUejbQafaildvxTeCW97ku8jrefUYNiBvSbB9K0?=
 =?us-ascii?Q?EFVhfTsv6w4h9vNR0W0KhGtgvwvY/kEnP/kbSx9Ot4brfz0u85kppMshzJrT?=
 =?us-ascii?Q?V8nA9t3bhb4C0/b7TiWTE3JlobapcBED0KYm/GLxVDdUNsTeLBYPNWIsZU7r?=
 =?us-ascii?Q?wIvSeVM0MDuSDZkwsKM9yaMKLXg52O46iGo8kmh6YXBWdnqdqGE4+7AgMWoj?=
 =?us-ascii?Q?YgpqSy7lLadJMtljyO06cjvi/HrZUDjLzkWAZME+Pr1Kll70wGkFFavvJBRo?=
 =?us-ascii?Q?m+KygRbAL8l0wV6pw9DujDOcdZS1wgGgj7lfz1N5HK+L1VlGuXDjBXBcmOZ3?=
 =?us-ascii?Q?avPacJMlalrRzTxLZCSDvZ1TYtxqJs2FkcsOvfsA+OgpzfzzX/6FxhqctNLP?=
 =?us-ascii?Q?C4F995JLHJYXwsBfMeOeKwnnEzp7RW8SoFe6jGytPjCyrL2z2sUHV4osggpo?=
 =?us-ascii?Q?2HUpACzbpjA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MAMY8r9BKavXOquUDCYxmkHN+nx3vsIV6xP9ZFiqG3ciAPP2aWDLtG2YtGA8?=
 =?us-ascii?Q?w00tmvqXeJkTh9U4jmdwQgzt8+tnXGHEEYkkgUtX8KxF5SH6V5yTWIrvB/+v?=
 =?us-ascii?Q?S0YYU+HwFJiVQLXfgnylc0IZB9idskCiujKxidIUzMIpNueGXTUvxyKSyUyx?=
 =?us-ascii?Q?PoaGc0xbZVUbUz5DTWClrX9ZxMZ7d9Pki9zrWhDHfvyAFTsTveHfTWyPAsMI?=
 =?us-ascii?Q?pUdJ0ZQVMlwNA2Gi7nTdXHjCsgDuApMT9dmDxj3GsjLU2Us6tlPUaP8Qwowu?=
 =?us-ascii?Q?0E40NwO/rEElsHc9HaPE55Imdd0B4kZOPT6d7bLOxQEzrlxYcxLhq3cTaWfX?=
 =?us-ascii?Q?KvRs2ZMAMUo1ZFgFkYYyNsIP9TbGO1lqtwT5dFHsNnPH466FdFMItjeJJINT?=
 =?us-ascii?Q?iIr/WEoHHfEKivkElLKWc6ueixYyEpOootyoR4lokl/dJ9/3yI73H5VF37Db?=
 =?us-ascii?Q?oEnJAtvedE5BAfjt8+is1BTTbxZT61cfCc+kRhZDoFoP+lnnazzebjZ5a81Q?=
 =?us-ascii?Q?8X44/JVN6U0Oa5MPGBfJwF2qBirWI0yQvmG9tLF5xEDboM39MrAwDeWqST0z?=
 =?us-ascii?Q?xwjiIAHDhHLhveqWtS7fCwsLuHotNA1eDUofup9yJS3UTUo5tKiiv0ha7WcZ?=
 =?us-ascii?Q?h+85tcX8Oj6RyEiYzzlTdkk9vTlNfO6L62N7Oebwl/3i7w6pvumaLiPsHyt1?=
 =?us-ascii?Q?U7aHF2BuLMrMW7Sxf5Q08N/H0FQGGejDt3ErXDe6mtUAdI3NZcy/4GIFjgsg?=
 =?us-ascii?Q?fnwzsFGpKs67EI6yBDKqfzdn/ZhP0s2q3R2N5yEx9mo3iAVChf+uW2sSQouP?=
 =?us-ascii?Q?Xo5HqclH/q1tgLeqK8Pg4G76yUzaK9hImNztpqB/Clbr40WxCKnIN0MiF6rO?=
 =?us-ascii?Q?KAW//+fcmRpZHZIDNqjc6l/LtVEQ37xTf8WZ73q78Qvlts5zpJEfh6Oedca7?=
 =?us-ascii?Q?xe7BiUd/hH46cunjDuLkmuBRfOGrPoslEfjIFOAC9hAdg562bsYP69e3mfjl?=
 =?us-ascii?Q?bqgaLeQVeQyHf5dqYto2gVz+0iIWY+nqXIz1Qa4zMaHS3SUTdosUdRibNxmj?=
 =?us-ascii?Q?1eDS46uHuPcrEHW3fbZOgj6LYsvF3xnCXnp/Teupjg2JP0+js25ng5YE6+ru?=
 =?us-ascii?Q?vpZ/tNGD7HmE5gm1bVVgJem5maNNKpNwGXCxgqSZWSnBW1hhLSIK7ljbWaC3?=
 =?us-ascii?Q?KrG+K0UlQMgR5QKgYfDRMQswRr+xPf/5tsKqrqD2rboA1ETAAoZoiOjLVqkb?=
 =?us-ascii?Q?k24kSTvlvFI573UibPyfy8Reg65T92+6oBAxI89Pr5753g5zzZwOSR9W6u0Z?=
 =?us-ascii?Q?tW91LywXbwEWDSeRVSZcHw9v55BrSPXe5cQHJ3/O30XXqvvE3ph8FYPAj2/w?=
 =?us-ascii?Q?C81c5tYp4nGMT2KLutIksRU6Whic+SwutctyTZZ1UjfDrv76wkpqhzJRaGPw?=
 =?us-ascii?Q?2TJSw6nkiE1SoxOpdOy/7URPkDT3Yr+X+f3TCGz8FO/pFpFD8EFwz1HLaRMC?=
 =?us-ascii?Q?4gq77lYbAsDV3eOqNRfYIN74qVw0GlWR0alhuTyrzX5ds3nN9Tok/ipp2/WF?=
 =?us-ascii?Q?vSc5Y1Vpw7tNR/1S099KysP6Ta4scL/YgH8OPOC0gJwL81S+l5oY843Ypk9i?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t/1fmczoaKHOJnljq880AExYSQsOtU9jqcH1tLD9jiDMGspgLEMgzqCE2j7n63hX5oWPn55jbLZ0qekM8BJmjnedY978bliGaAUOOfgxa2Byk1yByq8mQJVQltCOYObE9oeqgUJ5EvEIJer4GtPatAUtTG+VXa8WIoLBQXTPxX+krjSNwAFi4xky1wHayIZiq1yuMYFQzh6sguoG8EsocOxrpblVw6kv5FOfIW2XTJHlwcMETcq+Ak9Pta556ApjqT5jIt2gHyvemBH/XuGSI/hkQeK7fy4CLINn/s6ub8gHm6xiAVko5CTJOlWhv7hwSrEC8ExrTIsPfKItiKvpiOqHZmOQ3X0CVDPyNqb8q1nBqNJOnzqNo2MXlpeD44lG+aDnnofKdSURWvAbZXJUjJGmuVzIK1wKIOTo/WjMyvXuXWguJjn5bvS9XAiKpkEb24z6TzLHAjavsyyIVP/PR7VLvp3fhlgQzlkuMlQgHt44VTjhAIox7eF4eLjO8Nhh8OqbO1ZZ1MntVZaGcu6e1gw56nbOYIuOacJ4eGQrwtUpJwlZ2F8kZH+lYLUfTW1DFDX5jPXc/pta6Mwyv43dfSjfogOXpG/7BEwK5DkrIb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c72220-1580-415e-ad5b-08dd9ed480a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 17:16:08.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKmb6TPcOqwJVHIi+KfrCgl66aZ1RyubUk+RWO5mU/KIqnQpJCIAL5rLSXUZRThjeu0ONpwB6nQMyeb8FrYUjywgw5Q5cO251di9EMBvBsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290167
X-Proofpoint-GUID: rmJmrVVwDyp_tUSFnPhj5jeOtwrVSQ4d
X-Proofpoint-ORIG-GUID: rmJmrVVwDyp_tUSFnPhj5jeOtwrVSQ4d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE2NyBTYWx0ZWRfX76nQ3WMdYlVH dQMRwuwzGWYDByN0J6atDPKMW5ZCZsBqO5tE5ZXeTiw+f1vL0PcI6PqA3zjjRUGgVqpAKJYowit 1gFOcOa2ZElnMaNP4y6E0ZMnc3wj7+bZ7IVERY8zRYoAwUlAuZPJscxpiggYZHmMa4aNWxLwRhH
 /EIfw5bwmSnG5f8k21dwBDHjKXTTILSu0QyD+2x2x/ajG617iuRjZTBLeo1YhErRGfHJsGMpccL XJJF7Au2Y+y2tNM98YnSfcW9RCWTOTYkIxQXuMIDTT7+HHUSCTiIM3/xJrYjY1yt4T7wgVDDlxb x/2HRMAvXQFfTFhefSg3ZGNn6FArY+08quDvhpmA4dKI5r6rWl7vLD4jTL11toQrJHZ0Hcc2XjO
 aSnKF1V5FkQaUW0uYkCiry0sd6kCw/Uiq2vEEi0V9MnfRVtedpE2S6wOxOz5mDrktLkomXVi
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=68389662 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WX__GcUTe9ZGzPOcXVoA:9 cc=ntf awl=host:13206

Add test to assert that we have now allowed merging of VMAs when KSM
merging-by-default has been set by prctl(PR_SET_MEMORY_MERGE, ...).

We simply perform a trivial mapping of adjacent VMAs expecting a merge,
however prior to recent changes implementing this mode earlier than before,
these merges would not have succeeded.

Assert that we have fixed this!

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Tested-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index c76646cdf6e6..2380a5a6a529 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -2,10 +2,12 @@
 
 #define _GNU_SOURCE
 #include "../kselftest_harness.h"
+#include <linux/prctl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 #include <sys/wait.h>
 #include "vm_util.h"
 
@@ -31,6 +33,11 @@ FIXTURE_TEARDOWN(merge)
 {
 	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
 	ASSERT_EQ(close_procmap(&self->procmap), 0);
+	/*
+	 * Clear unconditionally, as some tests set this. It is no issue if this
+	 * fails (KSM may be disabled for instance).
+	 */
+	prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
 }
 
 TEST_F(merge, mprotect_unfaulted_left)
@@ -452,4 +459,75 @@ TEST_F(merge, forked_source_vma)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
 }
 
+TEST_F(merge, ksm_merge)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+	int err;
+
+	/*
+	 * Map two R/W immediately adjacent to one another, they should
+	 * trivially merge:
+	 *
+	 * |-----------|-----------|
+	 * |    R/W    |    R/W    |
+	 * |-----------|-----------|
+	 *      ptr         ptr2
+	 */
+
+	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+
+	/* Unmap the second half of this merged VMA. */
+	ASSERT_EQ(munmap(ptr2, page_size), 0);
+
+	/* OK, now enable global KSM merge. We clear this on test teardown. */
+	err = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
+	if (err == -1) {
+		int errnum = errno;
+
+		/* Only non-failure case... */
+		ASSERT_EQ(errnum, EINVAL);
+		/* ...but indicates we should skip. */
+		SKIP(return, "KSM memory merging not supported, skipping.");
+	}
+
+	/*
+	 * Now map a VMA adjacent to the existing that was just made
+	 * VM_MERGEABLE, this should merge as well.
+	 */
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+
+	/* Now this VMA altogether. */
+	ASSERT_EQ(munmap(ptr, 2 * page_size), 0);
+
+	/* Try the same operation as before, asserting this also merges fine. */
+	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0


