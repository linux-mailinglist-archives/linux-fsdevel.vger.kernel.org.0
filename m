Return-Path: <linux-fsdevel+bounces-36476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCAE9E3E93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9EA161FAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834320C47E;
	Wed,  4 Dec 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJayo1v/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pAqya0c3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E51E25FF;
	Wed,  4 Dec 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327048; cv=fail; b=gDgSWYKEB3aiS/nPT4N9i91Duj9Ctf/SBMjLghZbr/nRwYYM5Grni5AKcQ7xfBj5gUvHTfOf5GXoSTjGmdKh67iYovgxfLWHgD/CwP1QtPS1Bi97rWLyFI7dLKWSLQ1IxLugq6B3i6QrOea3/xb2QHmx5CUlwSuc5j4IH3Nezh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327048; c=relaxed/simple;
	bh=HykQhYGJwbT2J02UtCfc6HYalxBak+4F9s4phYdwW8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgIhfde1ZzZFSg8n5kbeKSLHCq/ffho+vrwdD3Kn3a1ZMjb5HKEgLQ4fFrbSpoG/+tOlbajHTVoo51iv7Hoqyh1BOdIO3MoDT27n4ZcDAY6XPP/Xn0LF3B/GC2w+gjR1rVbOhYkyqoBE3R4I4UCx2VXnV1ERk0y07RKnuSEc5Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bJayo1v/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pAqya0c3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4D0xt9027470;
	Wed, 4 Dec 2024 15:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2txTTNxaY+F8dFPfFqSNaB6iRtLZ5mIW4lWycbJcQOo=; b=
	bJayo1v/dC71g1pIblZdWmqOmzL7W2XPAVNF5vtHWDowXVQOt7v9BQUdUnWrdsJ7
	19UTwNBbCZ4ledEWXkfUabDSyxiH3/R+GP+XgC1YRD346xcIRg+bG4/h0/0wSq/A
	D4oNT00EdIHIP0vj2STaBb9KSETFiRRyEGR3T6jEL1mY9pBwxzkfLsI5Ii6V+2Vt
	JyuUBCSxs3Z8jJhoF1t48YLFD6lM2d/iwVPVApZAO1mUClGzh/RPTrGWOtPAEtrz
	GE4U1SZeWXEy9JMYOOb1MNmYS0+eUHcdd84/B+3bOqIaOUXrfpzJ+EzVn2eG+RST
	yp4L0AIcBZnWQZXktHjGRw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg28sgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:43:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4EgW71001736;
	Wed, 4 Dec 2024 15:43:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s59md87-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsJZQOpoB3hPaNxfvg9ssopJL0SoCBhdbxu2UtAE0yEaqUqKscT7LEsmmnF2kb+RC8Hrg2KKGjE9Phr+vHikDESvjC12lVGQOy9Xt9aWtD+oL9ldAjTqrglE2VgbHcPUeDBlXJ0j+rtqarWSRzqxOcEoMqH+LzQU3ACgj0SZ4yW/7845WSoPCoVekIqT54pSCWD3c+grt43UXEn/cPNrpOsX3oCl74zAHPISKhM9P6ekiGa+DaXusf1NBKIRvO1eg3FB7CgTUWt236vtrl5C9Ie8r1tE6VpYEO1dKLZotE6g/MhNK+tvckC9mP34rLM2KuY8KW5bljQlEiSPQn9KFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2txTTNxaY+F8dFPfFqSNaB6iRtLZ5mIW4lWycbJcQOo=;
 b=DnubQlasTR5LePaFFLt6Bm1JezTWd55sR2HkmHMAAGG0kgveYHHBTiwYoUnqXv1TUHwnwB3hztH9YLIwhPFp0mS1YMjWoHSHsS7Nyy2iCPByI0JnD2CV0ItzwJdGaVAkUpHeLtbpDBUWFhWN4usrFCmj5Y8v0gDhl9Q7A72v27lVUaFAHCShXQs/x9Zw16JhlUSFxdNClbgzsBURjPmzsRP3l7aHLqm146aqnhiAy8n8L6Ucg53iJuaxOBX5ezAztgknd9uk2Rth1yux6zCuhcEiLP8+SBB4ZF7Thk6GY4gegqg+qswFpeakr7DvTvIMl8k1VpgvLcPIkqaO4hVuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2txTTNxaY+F8dFPfFqSNaB6iRtLZ5mIW4lWycbJcQOo=;
 b=pAqya0c3Xl760MPaejCi5I3S11LofVtxpTdefAqxydwMsd48+F/fsHvpklXii+tJXqZetR1sMCKDepdAIQZRDAisesUrHkclts1N3cLghYuJ6Yvzh0l0Us5ocP4bH6IVvtaV4phlXlj9cr2IAowjTICypI2cNPuTcpReK6qckfw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB7995.namprd10.prod.outlook.com (2603:10b6:208:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 15:43:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 15:43:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Date: Wed,  4 Dec 2024 15:43:41 +0000
Message-Id: <20241204154344.3034362-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241204154344.3034362-1-john.g.garry@oracle.com>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: fca6d1c8-d49b-46f8-ff1e-08dd147a754f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I0RDm95oxyw489MwQtapIk3jyY/7DVKUM7iCaWCnv/A7Zxgl0xaWXw6URXzQ?=
 =?us-ascii?Q?L60ncomZH7mLMmIZHaXhmlP+Rng/vezUCw5zBDfqyL1YznGmeVfdLPj6pxeC?=
 =?us-ascii?Q?C+j0gtt4WUrn8hoAJOsLiwv7KY47jUPFOdDFqJ7xGn+uwRGQczUwu+rbfa0p?=
 =?us-ascii?Q?CoCqRSA2OtXjSpyrFD9IKcvhtrfhLKGtf56Buk5ankaWCvQZWo7MgcsQknn+?=
 =?us-ascii?Q?+6hRcneghe/y4v/iCXGU8MjNHbtxOUk5dnNZjHFhLG2mzmAqU/rmdjQ3u8V4?=
 =?us-ascii?Q?TNKYm7dnaaumywulc0zAL0fAY/cVfXhxWPTcD5KbMGeHWW2m3vTFTqQrCseT?=
 =?us-ascii?Q?RWTizavgfjIF1I/1MruhJoXkpc/LAjG3xnYLobB2dMvbW/gb3G45+tvJKjD6?=
 =?us-ascii?Q?bY/FeH//dwgiAA/Tx7hci+JlpA/uls5HPjFbkGXmO35FfPgUwWTa+YH1FjFS?=
 =?us-ascii?Q?RXHovzoqc5PoHNEcf9hphLeq3LlINlx7ZkG5k4LnYm2Qh/+Uil35EX5mB8J1?=
 =?us-ascii?Q?++Bgx7DU24Zh5KSjcATgUQq0JIctVUJIAWl0V6RbVdF5c9x1ZKgD3JGUcujg?=
 =?us-ascii?Q?8U/0fpxOCDQkDQJjfVB2Oegi3qhtpEuLFm/MCvC41uFS5zvjfn8j+x5N9e4T?=
 =?us-ascii?Q?ONfgpI8nCyKs003cqzm1i0/PG6vQGnu/VyBox2oA2H/qmqTuIeq3ACW4TTKW?=
 =?us-ascii?Q?IvtSPviPu+WA0r63smV4DLRyVXi8mCWeK9czN9Jv4TKK+vRtAFD+2UAFfGnz?=
 =?us-ascii?Q?eEtfyqukWHpdZW6ZpP3KYeks8sRyNtD6yfAcwXXZAjfn0/KNIsKpxOEkUYb7?=
 =?us-ascii?Q?ixQfcUKM+slw4kcnXf4YDVssWPA5ynlIbjhvSF+Iqn7yv7/SkZ0i3D5M5AlQ?=
 =?us-ascii?Q?Ewiwaj4gVdUtuuqN6bRG54mydDoXK+xQUUJQsZvRCrbqsYihCglKbGJvwgJv?=
 =?us-ascii?Q?MLCQoONf2ei7ZWuhrYooAWgww/9/+gqofRA/pXx8UHZGJNSumlL6xwicEDgx?=
 =?us-ascii?Q?LVkVrQ1odyRhnLv5v0oVvNA3yAAMxR/oTY71FgzfanoiauldY5LaZyxxpArm?=
 =?us-ascii?Q?/v/FznQp+6A+Ssdw+P1LJVGJ4C7MEt1+71JTr7opbm4zeazUoR4jg0S0/cCU?=
 =?us-ascii?Q?gL4ALiFWCV1hZSX0AHB/SXbmqtrQy4RfE5bm21+Ui4/14t8XwrgrvzOlWh8k?=
 =?us-ascii?Q?A0zW0Gbu8g31LvUwZ11T3g5GL+06LVCRLIz8I+8iXlWWvnRJbP/w8BOHMjPG?=
 =?us-ascii?Q?NsLUMRGLPJ9I6HcZjABH8kknhWUSxfnsGgb+lzZfBO5i5nAfiH3EKYHprM9j?=
 =?us-ascii?Q?edWnUpIm3VuYKJR0NXFi6mr6NIxumUDwN4YNK2L6AzwhnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xXZ6T5NrbtZT1GKx56i6BR0RmfzpAUiwdzgOCTvMcTFPXe/a1306tIVj/GQ7?=
 =?us-ascii?Q?S3yLOhcr+NvPi/Y2Cz6nBu7Cmrh2pp7jepZeN3Deitgm1F5T0SlxCiv47X4r?=
 =?us-ascii?Q?4d/wzsRTDuJQsKxcQsixK1+oYeLi0SB4Em7/98uLGmioU8Okbm3o8JLtUoAC?=
 =?us-ascii?Q?bLESdB0avPZCG3GxvylRpeUj8IgfZoYexqW29m0yajqt6Z8K+14R53R5L1bH?=
 =?us-ascii?Q?eYtT3F6EiTVyyEunaEPRwK95/d3/sXsa7y2XUDsiJ8XGLmaX6rKr7ccKzaXe?=
 =?us-ascii?Q?zGV6O61yakF1Pw7Wevwr9pjlwsgxUqTXMmfo76hvJbSqlmCAomTOIqcvnzNY?=
 =?us-ascii?Q?z3hX6T/gvAmCcw1nOqM1XFZfxwS/ZQrWaX9ZJqFuPGaln+7dQHLFC2aUE10j?=
 =?us-ascii?Q?mLgOkW43GzdBZTWsPQtcVteIWVkAmsWns5U9orLyDoLGyw1SyCxAXZHdzut1?=
 =?us-ascii?Q?qLIdV/3llwdLRhgIdy+bV36EBkYclAJuPiIh16rZgXyDKwSL1YyROoArtyPV?=
 =?us-ascii?Q?toNRfGzaEbZm0Ku3Q8HiGe8csbA5XSIXFZ+Mp6NJYvptz4kdM55WeJaCdM0N?=
 =?us-ascii?Q?PWq/9q6EdNhe3zbFDqbg5ndAUNU5NaH/UpwHE3yNlNVJ5slKCbY5dytFbDYw?=
 =?us-ascii?Q?1xwMVzQ5XvMVcIQBhvvLa2OraScNXOCtH11qaRI5C19bBYXBlMGjSMeG8fGi?=
 =?us-ascii?Q?equlO7f7DCTd3x48VDe90wRo1KLodRScQRJvv2xVZGaV8kZLrTMmvbrsWAKs?=
 =?us-ascii?Q?gN7xsw8IMwWtv/xyUbBWf8Xnt4w/AM/+Rvx2vskIVgFb1KNyzvTuy8Sy3GKj?=
 =?us-ascii?Q?8Nmp1Dc2XvX0Jzq1BfKInbUIUhr0ZgoEAndrcGB51Vsa+5HUDQ1eWFIeZwhJ?=
 =?us-ascii?Q?UeFhGr3BUgX9Up7n1isDplNgPPgrVm5fdrScbFexqDhLqnEsfd2hLjXp0LjA?=
 =?us-ascii?Q?vYcaGSySkepQGnTAGjt0o+UHc9TXi/3SdJ08IO9vQJMLQtKAqJruChxDsD1e?=
 =?us-ascii?Q?/uEBUWpNH37UfmPh0AKMTVqgmi15AM3sCk7999yhdNAKNWffFcQzUqiH7jBX?=
 =?us-ascii?Q?/YFdkTjQZuiQCKQO1J7WxHBBpYEloL4+3L7GnmYU/otwrv2RT9e+8iH5MFxa?=
 =?us-ascii?Q?yQEtiYM97HTSAT1Tu2YWg/mJaJBDnt2fi1ArQ3hBj2aZs8dm9Hq8b8Ff63JK?=
 =?us-ascii?Q?miCT1wC4uWiAkW3hSntscuzEdH1AeR+puFo7EoGAsHiSVSNt3fwyqOegkZLa?=
 =?us-ascii?Q?LtqmzldY5TlX4OvXTlbfpYg2lut5gpzyIuhBloWxsA3x4mWH/q7mK3hgajlY?=
 =?us-ascii?Q?BIOXyJNnyhzpsUEXkeJ9nDLEiUteuVSDV//Gd0TBg7+avqiuNNSHqk+dWAmw?=
 =?us-ascii?Q?d/uFrZWTNx/kBdrWdxpCYjoWw7CzPjRjHbV2t9NzHnzXa5F8ZdNfoXKsOc1n?=
 =?us-ascii?Q?HgZ3KdpsmM1FzFbfbb1Ookg6f5ag4fUqHmRcp2bU8z7w7CBg44SGSN1u3yJ1?=
 =?us-ascii?Q?fBc03W4HBZMMp4VJ8W5K5Hqg5jzYLR6UfDzv59j8EzVZt6OBgpVbg9O0lj/p?=
 =?us-ascii?Q?uDM4Vfk0788l8AAdWf/1oHpKO2aDngZ2tfvf4WtAQq9e632WezBeKJViqhyd?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7v8sckIM6b/f3UF+X7FuNoVl2JZvia7kgJaKQsZh6qPm72G9wSW904lNoD+ST6UIgKtB9anDQF8jQZqjRvzAvqjzfx6RxpX0DVA1YPRFrCORvI/3YihxJd1R8m5dBSk8Ee3cmJuHA3nhALM1SRBIi00H9FmyIuSezvaStw0etA3u0zccIDZCS7zR+qJg7ripCsfSc7n9CBzA6RQN7lqSNt1da78TSTHUcKFMuEne34/0fehGdRk+gI+4LQDdI4mvK6aqpPSpA2VYsH4L5Q1VWgb23Dzbu44fVTZwEvL3IcI3WBilRWKudB1o29Z2ef/2TspZsUB7sdOhd2EMyVHYTcCiwpyQfoWg/BaqzN5ZhLR84zjjCZz7lxoPJZ+xWMUJnEyrvYmmwRruQjqYmzq8fA4lzEB/xp+1tc6E2O9cZjsh0KZA1Xmo5saXvEZJKj7kieZUi2Ti2M8xjOJ0SBiB7ouEy+k2PMBPKZF1lCIwStrDb50NGOmRE0DbhfO7QrPytGZeVkop3vrkXThmkCZi6w7NCjxvzq/wFEkevilkFsyrEl6zl4vgQTxb68jrws5CX7wVazaFU0BeZTULFoIRYoXK3DQEoLWLLRllINmuG/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca6d1c8-d49b-46f8-ff1e-08dd147a754f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:43:54.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zgUo2Q80sIbKAl839RB5GJaFY/au3M6tsj1DetvTZQQinFvR4iFhYGRymgveYEqnhhwOxiYEcA2rFTglwtIQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_12,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412040120
X-Proofpoint-ORIG-GUID: 2AZC6FBtpN3R0Yoh7diqny_-sJykBDAf
X-Proofpoint-GUID: 2AZC6FBtpN3R0Yoh7diqny_-sJykBDAf

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Filesystems like ext4 can submit writes in multiples of blocksizes.
But we still can't allow the writes to be split into multiple BIOs. Hence
let's check if the iomap_length() is same as iter->len or not.

It is the responsibility of userspace to ensure that a write does not span
mixed unwritten and mapped extents (which would lead to multiple BIOs).

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
jpg: tweak commit message
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b521eb15759e..3dd883dd77d2 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic && length != fs_block_size)
+	if (atomic && length != iter->len)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-- 
2.31.1


