Return-Path: <linux-fsdevel+bounces-40433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BEA23537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32452188827E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C681F150C;
	Thu, 30 Jan 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iT4TF+rV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOByOcZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A158196DB1;
	Thu, 30 Jan 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269661; cv=fail; b=SN3grfVojyDVl7JG+4siOBEEQ9paqyPpO986BcSULPAe+qtJOwYxbOTgZsb4RGMmG0kFAfxFa6g/6ii876wPqsVb5JlsbTFsTdBcmfYjptRG/6MnERRTfzxLWXDbjh/KnlvElMU+s0dxlJrxSku2fzMxa5yJGO1vAJtOkKcXrjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269661; c=relaxed/simple;
	bh=iRA/0hkf6a/kgkw6I4c73WI2GiGtTtVmI9lePLQKUOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0McEuM4RiFqJt8GOXTDKWlMxjfURwXxdTGwLSHc+5ulpDWbD9Jg253ojTV+40V+g7sM/S+C0IDcBKL8IcXgbF3vBIw7kDz/c/syoRGvKutPxyYXAaWqkhQaIKR5FgJOHsPWp0ocaQGkZIsstPquU0M1FRajtPeC6Brt74f3ta4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iT4TF+rV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bOByOcZS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKHJ9Z027216;
	Thu, 30 Jan 2025 20:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dPJtjvvQZ3Lra/UAEbGgucANXzUDJXoWlZKWCd1+jBY=; b=
	iT4TF+rVwlr3tcYdisEPnNJ6InyDIE/rE9LB0Pcdiie5zWxtVctCWYUfYsDc6Z5b
	JKIe8HZHDVEsC62KANZ8mkU0PLBgoYtge7KFuboDgJB6bAwZMwIdtyA1fI0xM9jZ
	QNDiggmPxjLy0zG3dYBPc2EmpCEz2Q0TwZDECDuXBQ0vXVFBWb+R/I0AYU1/3CMH
	FmrOR8ynogNHyXF5oNW4bfxQ3h+Nnmdh/lrVJEMC/0GB1lxsKK6dyNld9iDzb6dB
	AJap2hyXF7sFHPQD9063cDmghq8xyXJKjduSfNOR9e/y+pCNIsLBM2bhe8s8CiBb
	isYNExcgL/UFZ0Kch3rceQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ggaqg1u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ4pdr032289;
	Thu, 30 Jan 2025 20:40:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44gf933y11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5oBPzSZNZj5yuNYiOa802BKR2nkptiO3R3dYqUs0mNVqrSDzocRVV8dQ85G6bhCj/BJ4w9yBbsJWQ+H/bN8ViCyIOA865AhwG62HEopsmzUtCJU1qgOadbNnHie2AbFii9fwFkzinmgvD2ig6ZxQQg386gQt9Kpiag/CS64Gv28/m3ikLtkdYFTVxT1oohOTVCI0GuECsRtiO4GbkseZWXYzmnID8JPkpRRlD3LWgVI9QGS9LlhqvHHfQtg/wnrAOhl42QLVP53Gs4TywzCH+uGv3KPI0/IljmIMfwRz0Y20lmKPRMPU7nXpDPEY81mx7UVrXEDV/8s1nEALSv6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPJtjvvQZ3Lra/UAEbGgucANXzUDJXoWlZKWCd1+jBY=;
 b=EDKpqQHTazcRhhRqepXjFj16cHtwWSPLp+RcwVo0eLy9B3ISAZ/jCHuCR81mf5oobc2q5FPLy8oHjtyXDpsJEd+JNhecA4FfUFY3LpYmfma70WhnICwdpT46s9zOuiCS9TWzJ2+Bho2ZLSc+mfHcLvnqXRRMGYTwoxa5Zz0F0j2eC9GrjiuD/7zDuR+5uKDbXoQIkStymC+qGPQmQQG6wRU0rBH3Mp3zxjgopRD7lzvz1nuESWLQc6mJdks2XpXxlHnbbUqVqg9Mx/VGc33E2i7x22xIn6qAaiTKFAd2oNsp3DB+Sdg+wmgSNH/EClACDYsMK4aLP9X/A/1quHmxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPJtjvvQZ3Lra/UAEbGgucANXzUDJXoWlZKWCd1+jBY=;
 b=bOByOcZSrCXPWEH7yHEcyrjfnTFyMu6YDx55E1OadJ9DzlxAxhRfIYYkI9HnZtgyZoTnuEQRwlC6jHnZGlkfl/QYtrxVnnLzm/gjex+F2oK/vekFP/zcHCS2xA3flwHxktHLge/OG8GQ2tVi79VMGnmdxujh1iQTo+cg2C6RlkM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 20:40:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 20:40:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v7 2/6] selftests/pidfd: add missing system header imcludes to pidfd tests
Date: Thu, 30 Jan 2025 20:40:27 +0000
Message-ID: <fab8843ea8664b5089f95ccfdcfd5bd7a5a6bb0b.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 924c1ac0-c788-4100-f4fd-08dd416e5c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YcxMBomw8EwefaAtqIPxLNVd5EVa7sdtXbJE2xRjQZwmGVjIEW7WHuzOvlDG?=
 =?us-ascii?Q?zyAv8+qem8fJ3+V65di555ecefzBPTDMU9MIb1nocHvZG/dwwrr0R3vBU0Dv?=
 =?us-ascii?Q?bfXlrxxsLjZ8TRgpu/46Gx0F2L5QLD4e4AwXzwFqfDa3z35ElBQyGfZ0ZBGh?=
 =?us-ascii?Q?tVCow8N7EAaNdjRWOEjr1Yo8GeJj+4zOl0/JqwZf03/Vp+y5eRet45uYZYqe?=
 =?us-ascii?Q?FOGtm+1ZpwrpsjXSCBlQS5dbVeev/wSp+M6RacQX5V/7nMUiJtwa48UGs/gi?=
 =?us-ascii?Q?sENoK6I5EYE4nVqfwo4Pg7XuMEbTclOtHwMGdUyKSSjk7YDiSc3T0UtMoZJJ?=
 =?us-ascii?Q?XPiMqufqYvSKzIs6CTLapxfMbJgdyU6dQ4Q2MVmnWD/BIMG+XWmgEELjk02U?=
 =?us-ascii?Q?4c8VUMQPHmnvAhmoE7udmB9gry4Fv1C1fAEijVDoFh9BWkzJVY5I/i7kuNZF?=
 =?us-ascii?Q?pdX3YMzHLfga7JWLPYxd9/vZeHDDHcWdCDW8e+BPSaBiJbrzSGMYF5uSr0YG?=
 =?us-ascii?Q?Io0Alvb42bGJaYXYt0F7xmyf7Q02g/JIAjYqLpx3khOUaW687pxtTPPubWwO?=
 =?us-ascii?Q?GPolZYYA+0waGnf6Lou25XcFmJ9vw4rJL5FJ3rKATl/EXvaOYxeKRu/ojS3x?=
 =?us-ascii?Q?sYRtA3AwnoUT4HBFB8jad1CSAKUtxHy4fRRObPAHK5RW0SIZEM4qwAToVpGs?=
 =?us-ascii?Q?o2lG1u2sOa10+eSPVkJTHGYKTwEFzyi2p4FY+U+c6/dhMcIyDl18Pkh9ULbj?=
 =?us-ascii?Q?8AZN0gLx4rkH/h/15cRK0McpFFHxwvOP2kZCdA1Qd107AFwF0DEyutaFTARA?=
 =?us-ascii?Q?cJ9Ssd7lYCXVctsTk5QYoPB0Lec2L9VQSTNS0kMxblI3zW+ZqrC8BXXA7CQJ?=
 =?us-ascii?Q?ckLLQuckqJmzIQdP/rWxM9R+ZDlvn82EHA4lCDoUdu5pt9I8TSD59r/c77vQ?=
 =?us-ascii?Q?H7HITgjzdPLVpxLI8nCcQiW5kfA4gls4mqUFXRmRYdbuVLB8nNPVcV+wwI05?=
 =?us-ascii?Q?xBdQJdwfMn96PyAQqKrdvTntgNC/0UBq/fCR/S1uvaE9xGw0uJtM/z87Yyo/?=
 =?us-ascii?Q?2hZAXRDVHgWjpOWoxyAc7RAN8DA2wqhObKKeoewJXkRDcAIlZx3S0Vim5T6F?=
 =?us-ascii?Q?hCAP+Qx4rYxs+zoD+O5EFDozO8me1irs9j79IUGvQm2U/M+FDLWlI3zjmxvY?=
 =?us-ascii?Q?00X4RNGquKGHXmSRPwa3SQmqjnE8hZxvWmSi6CLApMWaB9T5mD3QFBPFGRpT?=
 =?us-ascii?Q?r0thmnOdxS67dLAqhghpFJbVuY41ItV+tIYBKUU8urXFdESt/4uBTCL5EvXF?=
 =?us-ascii?Q?aVkm+mUobgt2/VhQI9PsAz0hMZ6i6Y+CKPxwmejMyBC74UJg9CebpJetho4V?=
 =?us-ascii?Q?neMkEsUjY7uWeZNxA6yhLkm6OE9P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s8Di3So8K8KjftcTe/GWZ3jlLIWSJIkm/ufLWFqNla5R373pGPzXFwRYvfMo?=
 =?us-ascii?Q?dDn73OejbRpYlxmCOsZlhebIRWAMAcjsHOKtqvCu2JsT+HTWDnxdh5FqWdev?=
 =?us-ascii?Q?dMaBJAUx/ReKDhnnRwjhaTxBvI6VXuhUHg+Ag8JR+pzoP4z5amM2s6lVyYAE?=
 =?us-ascii?Q?r5HD3ZE9WNx9ZVEC4hm0Oo2NgoFc/KgEKeh8F6l77ULMchiX2qSYmgC+fJ9M?=
 =?us-ascii?Q?xrwVdLvuKmMNRHW/h4oigwX1xFzKPpTyHW28TCBJHvzY2LLTG+oNCmsiCnwf?=
 =?us-ascii?Q?n2y9SwANZzFUPDHbwEBGlVWp4+URidC7GXbSCDgc+OTyVc0zQZN4TMtSz3ia?=
 =?us-ascii?Q?G16a4JolYMViYwEJbbYu6yuxydHmxlDCvU6Rgt5RaGYHsq/UoQDUIYn02cnL?=
 =?us-ascii?Q?LO4j3b0ntFS77sV3B7pepRtWPv55FQ8soZ1r8/0HsX46vwdjNVZNwUvV95qm?=
 =?us-ascii?Q?CLb3ohwSuvHtdjZAcvcDOTLPR04ufDe1D6QbHAHU3rx/vpBilMjuGWpf4aDM?=
 =?us-ascii?Q?OfjzdzB4VZvyL5FpSXAco2CESBuxfuud1xMiUgjkj0BOdLYikNiKuvqcWbBp?=
 =?us-ascii?Q?1OSQTsg6M1RihfiPAhCPGSLyzq4gmAm8sR9sH8gft3ipxk3ISSO+9NaxqMpw?=
 =?us-ascii?Q?+QzPDLPEt6pE6b8DiJgqjnbNJBVPdjJlnOJwWCXX2+GMBsowvjRVHfB8dEeB?=
 =?us-ascii?Q?HKd14puAb4Ut5rc6bvLWspLZe6JLMIzQvt53CoPP208wKw4+U7cCXCvSGpEC?=
 =?us-ascii?Q?HsehGsWrOId9UbEbuTgE6fHn1nE7GYaD80UNLcbb3BsdIqlAZ92N/rOoHBRN?=
 =?us-ascii?Q?VM0MhIfItN2fOEzRsfWv8aAn5OZWROHMEHSpgJotM6cVPwpTGCNewUhvtsEY?=
 =?us-ascii?Q?BdUOIqsD2mTrdVUMIAN7bqr5KUcetNyaozP0SHeY25wxAyHBXlUitOyuMsgG?=
 =?us-ascii?Q?foaMBv9s70rVJFLD1ODPWcGIrIs7On6o0uss5PaqBjzg/SZso3QPO1npeuw5?=
 =?us-ascii?Q?YUkAaoo/kHGAw869bGR/cuzoln3YQEyoplBrzTg1vKMxk1V/1WcWNlwIsqa/?=
 =?us-ascii?Q?p9vTbuKNlkFu2T8frPr0jQ3EPO0dxV6cUFaL91fgh+w+mcZzNmMzfdI2n5v7?=
 =?us-ascii?Q?ezHUBnPaLM6hXxvpWK6Yc73uGGJeStDkhgPHucs0ArBAuGijcRErMExUTt5Z?=
 =?us-ascii?Q?vrmNObWVYbaG3mqnFgPO5Co/G/WSQCs+3EAzyP+RIPEonvkyyl7UTsQIXdXo?=
 =?us-ascii?Q?i7Myzs3ZgcUmkCXqznBYBwW5jV+fP7KqLYJS4fBVnJKtqxs35GPpnZL0UZgA?=
 =?us-ascii?Q?dyftFiLF5ve0DPl3IrjL+oMM7kMXHCRP/CRE3ckxaIpdHGUwozAa2LWSrmjw?=
 =?us-ascii?Q?0ER746trTjk0VHNKhO5aTk4qDvGjOG0sZL0IJz463afdgz+6o+N3SL6ETvt4?=
 =?us-ascii?Q?TkFSrbcNBKNRRoVm8uEcziAfcrgomQ3Unh31r6/08Aqi7nBtz3OW470m31Ys?=
 =?us-ascii?Q?ctT/7lCeJe9wGZ961b51ydtNnGTl0rYx+7BYT7FNJLByqRyGFtoc6ws30dTb?=
 =?us-ascii?Q?yrB292WD5lGrzq5MfLIkuFhaRACY7tzX6E2yLuFOx+IDTosr1CngDg3uCE5s?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EkALtNtOfSUMwLN1GF0WepEc8+X7XZOmXiNXdkM+9sZpkgJzIN3K2Yz8JsCZ2qKy8KjkG+7jAcSFXh5r6x/afZrioEmQhQDapuR7uHFdJwebWsJ20Xy2oeL6Tb3m/bBCof+oVG+DC2jlwtHsLCtC4jazGGlwtlypqRR9de+uQ2uSvfG3eBQmaGbwcyX2wGNhLOo5OFLcIiVVgTN64mExw5lcvp4AgUIwQscNu51Y7YC0YakHgkY/uvTUC36C5KpNhqiYJb1jv4rE2hESAw52XNKWGpcrphxyV8h1jyXe95yYtWAlMrkAhzBvAG1ZROdxcF5JL9IsfOTu0vc2Az3JtvQI2rw8CI493QHQ703DQNFf4HW2OIAPP9RIAmKhQCAVob0ejNh6uiCleJCcB8/QUD3FUfhkancoju+hNVGfbh2kSbT9qMlSxro3CoCRixveakXl5lEHtsGj+h7CGkPH4XNGCYoXvfyqlf461eAldAqC+k/XgGPsABEC5hqJFqSnU3DdedpPl7+uxe021U2/M5lw+okdiy++47j7t8rKy44bXNR7vW3UhI6cGPfAAWfR9DA5pHWMr+XAhzdvFlVQOWOKx5SkTD62jkJ2ahbU5sk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924c1ac0-c788-4100-f4fd-08dd416e5c00
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:40:40.3981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJAKGlXMzQflyVa6TlHSHULgGIpqx0f+cnYIwsZ3P6xWNu+AO8hWGF6QUbapuI/pCYqi9jZ70TSaisPtjoqwLoSlRvaCRH84bWf3b+MnEU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501300158
X-Proofpoint-ORIG-GUID: UzroupIA3wow-Tie3e_ryVGE_tQOMcma
X-Proofpoint-GUID: UzroupIA3wow-Tie3e_ryVGE_tQOMcma

The pidfd_fdinfo_test.c and pidfd_setns_test.c tests appear to be missing
fundamental system header imports required to execute correctly. Add these.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 tools/testing/selftests/pidfd/pidfd_setns_test.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..f718aac75068 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -13,6 +13,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 222f8131283b..a55f6641e0b6 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -14,6 +14,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
 #include <linux/ioctl.h>
-- 
2.48.1


