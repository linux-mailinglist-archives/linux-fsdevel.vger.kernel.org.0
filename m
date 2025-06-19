Return-Path: <linux-fsdevel+bounces-52187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA4AAE014D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD801683AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AE265CAA;
	Thu, 19 Jun 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dFZjEWXC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gVqN291d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240721C9E3;
	Thu, 19 Jun 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323938; cv=fail; b=MntEKpKs3d32I2MYE9kSnykbSLI3w+Ev/0okBvFxrnTeOXbfiS2kWwGJ8oxAkZa4hmklz7l55GjTM4pfYRxTCg5he1ooKAmJsAVclFzccczdCHYjCKsg7+laMlSKGhz6acVYUSFZSSANya1Kceko3x8ANp59i41YWMtq1748zuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323938; c=relaxed/simple;
	bh=F9J+JrF4eTTerJAkWYhEyxqLdKkO8QnMAll3veB+39E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mbh/gzy7TPO3Fh3nbomNUD0EPChbKPx+bNVCG2LY54vzx6FaBAf1nyH84Y3brJfOKJlM3rw/go0yVsuo16s/bRWIPo85DZWrAHlP5GVZO8fdzpM0tHANy1uQSlgWOvWMM69RWreULWN/gwwK/eWP9jSjw5Nzuw9TKWOsJNhUfH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dFZjEWXC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gVqN291d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J0fpjZ031468;
	Thu, 19 Jun 2025 09:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=4PHrvorjWOyLFQiq
	Jv/4i87CPmBx601f7HnQ/P8epk0=; b=dFZjEWXC/FwL6HbPZnXRWrlj6/pPLZSx
	zeCRPWwFSIBGCAQwnWHo5VU6kdSMpT+7wEkY8wyQ65xL9Bne2M88PKOIzDKbAgO4
	hBYD6/bwuI7C9S7wBn1iFi8grPETdcYDB83wUyP35W5R+IjKP2I34vQWaShcHzyz
	LDmTkzOPPP3xneN8FTcHaJrb+TT4HYkqsOSE2zqP6ihSoEfFPPqVxoVxPtXjvTn/
	CRXxUV1pmaA/bAy345eztmzPsKkwB0RSf0J2O97Aam3VBCzJrBerz5LxwRQ5o486
	S04bB6zoKeBPLZKJFGp+nMwQ0RnC4IBPIc+Q4cTPM5yU3lMzzyOmOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900f1khk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 09:05:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55J7KTiw025985;
	Thu, 19 Jun 2025 09:05:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhhxs6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 09:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLpKy3N9MZdjv+9EoC2Aq3gXP780v29kh3GSqP39IFW83B6h7QFvHZ64Qr38gMOOsCnt5H88PFSLFmjVYljrP6thhYn0l5Pb5Ci7sF2Uo9vkNb7Q4LxpqdC9IVsOrl52WlbyLr1sevItmQXwJ4oQcwuJEDkgmKwh9IfHHCj062L9RX2pBEfwqefbNhJRGtz595yqv66dpjcT7XU6M0zMb9U6QkRm7/ntoM3X5NqBqSBsIDbY6pBo21ETfhgVUQKH+s+BIRtE1jlkwPtaPaJok2We8UqV1TjBLdAuoBmfFER0LaRP/K7o6Pib/FgBY8QThopmV2d2VaJDoIvA/pEdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PHrvorjWOyLFQiqJv/4i87CPmBx601f7HnQ/P8epk0=;
 b=lBLT2OWRKDaj9O3ucWHnoRfCI7lQHzj3YCw+3cCh7MyaekQ4yutqPiT6wpReDYVf9FyKvHi99cLu7UeOylZnKLGqWRQfN3UhhwFyVXsi7vKajZyUj+l/QflrbvhwEUxVjRj8RrsbdmGoBWE+2SrCn4OAcElUscc7jvZXmj6+q9T6JScx9f3eSHM59GvQFdIHTBwujqX2IOHSs5W989LaYwr1a+qHQXrEn92+6TuAGmCMDphhRMqeDAnc32vuva7TTK5F4bFWWX1bkk+VR90YfWr2T024FP72UTyDD5zb0tbPpsh6cU7bjpsiPJPkVFFlZj640at1WjiN8ILP/EETKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PHrvorjWOyLFQiqJv/4i87CPmBx601f7HnQ/P8epk0=;
 b=gVqN291dvzV5yPgnP6flRVvT9mlb5ped45w7PJQPjN1FnFwntJ92jbimmEQQWfy3tfMQmrGRfxLiX7mf9QRhkJf/Dv3as4KE3Todmte3w6xNP7rTIV8yIOUMTD6CUJhUdHGuXRMXsgZmxNLpyWo9tYuu/kcsAFopOaCnbnkg6kc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5779.namprd10.prod.outlook.com (2603:10b6:510:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 09:05:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 09:05:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        djwong@kernel.org, linux-xfs@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] statx.2: Add stx_atomic_write_unit_max_opt
Date: Thu, 19 Jun 2025 09:05:10 +0000
Message-Id: <20250619090510.229114-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7245386a-12e6-4f40-d317-08ddaf106d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?317lnqOCfY4ag4g+nBEtNfo0nXp65EOfj6xGVfhmypInejf8XTTwVRdcRatI?=
 =?us-ascii?Q?UvaZeIHktg24BgSpFtMbW3PcbgZKf7jOhq8Qgx1/0hFUlkh2Da5Cjo5lLxKo?=
 =?us-ascii?Q?Y6AiU1Z5qLKt2MrHzHlDzWmG3pQLdZlmNZKIuARVlD3hTm+THhPRPPQmm9hw?=
 =?us-ascii?Q?Q2FkXx/Dav//5ZJlyht0AqpuluaQDB2L6aNfkOxxTa9b5chbtshQUIE1hj+g?=
 =?us-ascii?Q?QG7uRpfxRwXO8n7qn07JG7sAyRo8q7Ibob2NdlmUaQdLoNO6IhZuLA/ZytEa?=
 =?us-ascii?Q?VcvOWUEw46w60GL5uVqdV0uhdQZ87s7bh13UFoJjReowysonL3ypk8q3jf13?=
 =?us-ascii?Q?q7hM7McBc6TukzbNGNgxXZfch/z7nBZZKKytxBy5A/52WwQ9Q8Inu/W+f5p6?=
 =?us-ascii?Q?JqKJvIGzqYmf0CSxqw4Q/niec4EjyFS9ylK1wEVO1bD4/dYgnDNKxTr1jmzf?=
 =?us-ascii?Q?u3OQH85sB89ulFicp3iCnOQHGl71cHldyKrAayXAzTnA/nCCDYqMGQ4VaBYN?=
 =?us-ascii?Q?3/3wvdmNfnt18oudfm2AnrF6AZsL1COeZSm3Vex/0ocq8sTRyhP3JUSqrYE2?=
 =?us-ascii?Q?Xt1vlLGJ2GVxIe4odKjMPStN6IWd8g/SFnofIBZhcd+xBVdApy70kkUt2EoS?=
 =?us-ascii?Q?/mLw8Sb5MusPPC5cUsTI9wBUT0Iw3lImaAzRHMCvbpnWuWXqgav5qju3nvuD?=
 =?us-ascii?Q?NzBp4p4Uwmy49WrLmVYzXGER6gYXboT1CMogBCclQ08XRanLgyAYNfZhp6Mg?=
 =?us-ascii?Q?2vIP1j4b93dpSPiFulxI2ouB+jvWd7Gyo55MkBgPQUYAUM4ZWflXAq1V99ML?=
 =?us-ascii?Q?9k+wepoDg90GR1zwgNQmPumauddOyDGWE1F7z0HEagxXLW+4yXBJfaOwxVQY?=
 =?us-ascii?Q?QYY7UTjXLPF+n6mwUks0VmY5JtN650UJMhytKPELih4LzXvhSOpfZchSPv+y?=
 =?us-ascii?Q?ghlP8x1pJ+oyu7087IJYCyIF4u75ols0ASNEZkXl5gUK4pU3soQ1QPMDjHn9?=
 =?us-ascii?Q?gvnziwraZU3B4SsycIrqN27TFSFsXbUJ5FctR13OE+jXJbbKt3fhESzcd2kS?=
 =?us-ascii?Q?Vf6EOsY5L03f5N2pEdeGbeYnSAiA2OP/v4o4Kuh6uW+ESjl6url5lvqBPYL7?=
 =?us-ascii?Q?5j9CuL0o2sy75z7Q5rTuyWJYG8WLa1L9XT43CiDgh+SSHqLbmcCqKJFdaqpN?=
 =?us-ascii?Q?8HSAa4ZZ8UR1kOpY0nSTfd8R/2Z6vAjO8aCt7itFOblxQBfTcCvO8T3mFlxr?=
 =?us-ascii?Q?M105BbTYjWl7SIlO95ZOfj4CBuM4d7GW9uFK0SjWpllqrqB6+9Dx57njLUJb?=
 =?us-ascii?Q?hZDxijJEGZrg4G05bfw4RlBwX1KcUtNCvpGRzTKv+VB9rM4o+2fDN4gDZI9E?=
 =?us-ascii?Q?4CHDka/GkpxxydLg9JZuNwsBDCWHc8vlNH+PH5UylWzMa70ru6mr6CM/UioL?=
 =?us-ascii?Q?rKefKh7uR0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9A3CbIl04SlBIX5FZzClS9yWBeFDzBZJEBRQRRIPDM737ABG3Oe9hjQnyuli?=
 =?us-ascii?Q?Y6RYuj37CUZG2eDRtb5fRzj94GxAcFX75onlBmB4R45iCcXRWCwv8EIARe0I?=
 =?us-ascii?Q?BnjWZuzf8mMIQWueIm1eOWObbXIg71LeH/zOzHjQ/1ugjJClZklncMbEMZCu?=
 =?us-ascii?Q?Kkgjs+Ynz6HyjXjnL4DkiZ1jh3Jh/rt6BeiYDKupISgBkCex0nmRe5E+zuQ7?=
 =?us-ascii?Q?psBEpy1H1qz9PZmJ6LQJVDkN8RAjJU6OtRSrWQXv59ZjvVRFqGoSmJ0tzWsJ?=
 =?us-ascii?Q?3k0ykuHrfDaeN98/PoO+5FUy3O8XLwCm0EKjBbY93oXz8HQlLuZ2iqkH7hQj?=
 =?us-ascii?Q?0iKewzulW4pnUr2iTGiKKy2qy18SOPoAIekk+uA7eKYDeMeS1qSzBh5YJFy1?=
 =?us-ascii?Q?l+BZi+aFEJCmEJH5ysWENfAM5F1dd/aq4BsRulZOAfb5Sj9EYNVKosX5YNJm?=
 =?us-ascii?Q?ftFVBM4VHNfgW/CsgpmOuPja/SDFSnT1J33XSiOj55SS7dUQRMy6xwHc8IYB?=
 =?us-ascii?Q?GgZbIi2SI8StEgdvmRayvUYOb+lMov1CzUHZiNAjngopnxX6dYp0CQWK5rzv?=
 =?us-ascii?Q?UQKW4D4OtbHiT+ZmwRdW1sIUG80t4rqZDsziXzuG3TN43PbSog04JkJ7FZyM?=
 =?us-ascii?Q?Y3Hi0mXbIXkVHF0qASHyJ+bjhgOym63pr3W3BVtYsc+5hIeUAgBJ89HMfDFr?=
 =?us-ascii?Q?8mPq2FV2Dim4kD1Q+KqwutbsolzJ+HV4hLIKlRex3cmj56fNcyopUVA2KAkc?=
 =?us-ascii?Q?YF2e8UfBcg6JG8HxIflgpDXezOsyBQnEBxvFkuSiN2nXhVHbucpzZ3HE0xY1?=
 =?us-ascii?Q?uuq2/uKWB68P7bF9MhFm/xU+Slv/kJ4QD9SaFuoT5ZA+YJ2lsvjK1aqn52Nv?=
 =?us-ascii?Q?EYL6lpVemIcaDT2YEC2q0zoS389UXNLNN0zbpuo80StY5uh1ksyfwa1Ia65Y?=
 =?us-ascii?Q?vKsni/UZeJ0HW2j6042aKGMH//BCSGaI5oyIrNY2i/GfO/K096lGoqkQOLng?=
 =?us-ascii?Q?TzTm7jeAaoyDjYPKaFD8vN/yz51MbKHm1SCTbrgci5hHNhfcumfiDVfdi00f?=
 =?us-ascii?Q?yI+BVPzbhjQ7rieTXWdFCsgav0dwxP21EGGVx9RuHIE1dhhKBfdAtLHL8tMy?=
 =?us-ascii?Q?ZFO9Rd8xvvhFauf0utnLbiwEU1ECFkZ9E17RUrJ2xarsin5jPSAh4wrr+Tg1?=
 =?us-ascii?Q?9gAnTQSp8jVzh7aC/bZ0Ni95SQYRJ4r2tEQ00KlLwBa7OKV11retpgY2a0Zi?=
 =?us-ascii?Q?9E9o8QpTwTTbSl/kjS+hci8fVABFjDtszd+CZPG7ClPQW/W+DhnW1AaqSdJh?=
 =?us-ascii?Q?3DqtDyuwnEdzjCfL/of5SQRubh2Vo6TWUgD+pWea3zxAeKW+Rf6PucWa2YYZ?=
 =?us-ascii?Q?1F1AQR68yIRrRb4vzr70UveocXUI0vOigQKt083qYvmIHTgouaAQXZ2RUpoJ?=
 =?us-ascii?Q?mmsQxVH2649zjgLRA0j7p/Q0echUwb1iZFKBra+vaS032I7B/9c8iSPEKF3V?=
 =?us-ascii?Q?B46ISMgxS5UdXVbzFx/Fob7TCn4m0suW7f4UwhA44ie4W+JZb10B9U3QGZZD?=
 =?us-ascii?Q?kDhFCrC17t3mOk1K1dF5gb6pHk1Jkg4qh7TN3zid?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RYvl4AfWBJjN72v0fGwE/AwkgkF+pdXPkS+ZsUBXLgZc2xA9zDlWsNBk9iGGFoilXh7ptIwUI3REKaKzHv9UVULijciTG9igvEsBu6GMC+K6cJ7HJEPonlSTeeEjQTr1cMK1jQp7dpUFLgvWQfjq+1jYr1+KUVchd0UsCOYtUS561SZel6OSyE1u8UkS8aP6j8S0prfzgegGa6Uq9nhgGO5dLc2j5zaWuZuEvMqV21jqyfok9iCgTWVfUr4nJ2S2gLTpdDEGWu2f2PB/ORbmolVEXqgkuJxb+e4u2lYItYiKrca1r3LSScIKVEd0DnoEprkY6m1wFQ2My4EDSdoC4I8J8outEBVrTIdW6T9OOOgkr5AhgLy0O1U8WMllxo2o0/BVZZ2NsJxuZOfeWSVpLubPtM+9+0FkjYfowMcAR/6b/OsegLIKcq69637W1JV97PknvcJXH7Iq0C3z8f7qC1AAZohBlVFSgdeYYq3/jCxEogtnj/zG6qeE0v1pJ+qOw68C1Xsrimo4qKL1vY4DfO17x1XDjKQtixHkE1/FKi0wUH7ntfebxGzT0/8QnHDiZgCXCD0tbC7/jfpZ2lIQvdTNB2hpCx/+lmk7XYET7dA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7245386a-12e6-4f40-d317-08ddaf106d37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:05:24.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfsQPUyqna4JJkQO0ECFhNlSgJ2d7KHPQrZVxSSqT3J9J9fiaVg/HmiEI7mlTxLmGZ1WXUD0pgYXPB10okgENA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506190076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA3NiBTYWx0ZWRfXxTt0tRYoxZ3N onnW8IeeKlEoM1tOo6m7rJotZ0Yz63hKyci1LnwW/tVhqagwUodeIZ6t/tJhbx3H6pNsOIa9J5v B/8g9XPCnqRmQazHv4AWzDddDuqWNCXJ4uF4IUl5GU3mxR/deOrHOhVzl5izQzIIRtfoRK4Ivu8
 8a2UkT6kbd4SqvswuX6Cbt+poGH46YydCSVwS6vmljb8Ab9hUyHh5MYyhECUQql+yk8J3NAn1Oj Ypg3cVljABUEdidbboJNjlWey7cPI75DtxHPaFrDcKEzjyK1DZ+uyq9ufK14MpDp+ZvjKITpw0D lo/ZaEAzRgg5BCV10pnA6R8Tg2MwJbPHDwR8FRZy2fuc5hWYdj11lX0O3eBveSK9zykngLc9nvU
 nuQbgm2JZgM5WH7xdchFekqx4lIlPaykoGzN33zaIebQDtylb+Vfm4IcSQNOkklfYMp7H7el
X-Proofpoint-ORIG-GUID: hJ6SYi_jdcT7_tI9WoEyS51rUUoEc30S
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=6853d2d9 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=YPMGSOLgfOs9S9DtvGQA:9 cc=ntf awl=host:13207
X-Proofpoint-GUID: hJ6SYi_jdcT7_tI9WoEyS51rUUoEc30S

XFS supports atomic writes - or untorn writes - based on two different
methods:
- HW offload in the disk
- FS method based on out-of-place writes

The value reported in stx_atomic_write_unit_max will be the max size of the
FS-based method.

The max atomic write unit size of the FS-based atomic writes will
typically be much larger than what is capable from the HW offload. However,
FS-based atomic writes will also be typically much slower.

Advertise this HW offload size limit to the user in a new statx member,
stx_atomic_write_unit_max_opt.

We want STATX_WRITE_ATOMIC to get this new member in addition to the
already-existing members, so mention that a value of 0 means that
stx_atomic_write_unit_max holds this optimised limit.

Linux will zero unused statx members, so stx_atomic_write_unit_max_opt
will always hold 0 for older kernel versions which do not support
this FS-based atomic write method (for XFS).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Differences to RFC (v1):
- general rewrite
- mention that linux zeroes unused statx fields

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index ef7dbbcf9..29400d055 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -74,6 +74,9 @@ struct statx {
 \&
     /* File offset alignment for direct I/O reads */
     __u32   stx_dio_read_offset_align;
+\&
+    /* Direct I/O atomic write max opt limit */
+    __u32 stx_atomic_write_unit_max_opt;
 };
 .EE
 .in
@@ -266,7 +269,8 @@ STATX_SUBVOL	Want stx_subvol
 	(since Linux 6.10; support varies by filesystem)
 STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
 	stx_atomic_write_unit_max,
-	and stx_atomic_write_segments_max.
+	stx_atomic_write_segments_max,
+	and stx_atomic_write_unit_max_opt.
 	(since Linux 6.11; support varies by filesystem)
 STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
 	(since Linux 6.14; support varies by filesystem)
@@ -514,6 +518,20 @@ is supported on block devices since Linux 6.11.
 The support on regular files varies by filesystem;
 it is supported by xfs and ext4 since Linux 6.13.
 .TP
+.I stx_atomic_write_unit_max_opt
+The maximum size (in bytes) which is optimised for writes issued with
+torn-write protection.
+If non-zero, this value will not exceed the value in
+.I stx_atomic_write_unit_max
+and will not be less than the value in
+.I stx_atomic_write_unit_min.
+A value of zero indicates that
+.I stx_atomic_write_unit_max
+is the optimised limit.
+Slower writes may be experienced when the size of the write exceeds
+.I stx_atomic_write_unit_max_opt
+(when non-zero).
+.TP
 .I stx_atomic_write_segments_max
 The maximum number of elements in an array of vectors
 for a write with torn-write protection enabled.
-- 
2.31.1


