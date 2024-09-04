Return-Path: <linux-fsdevel+bounces-28555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334C96BF49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB29288BF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098131DC060;
	Wed,  4 Sep 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lrBt2E30";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k0INe8/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B221DB92F;
	Wed,  4 Sep 2024 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458226; cv=fail; b=GmLkuUXpumge2Mvu4OQvXr5oGQqlraIIvhemNsqrBE/UNElIgigQVV06pIzLKBTjtyUvnHFZz5LB/QijNAUf3m4HbfCMpHA/eSZFfII/Da+ti5R4ntGKmK/iWyifcdxnuGjF/6NWch+q+k+/pi9TScTrpNDuLm+dFQSfq9fh8gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458226; c=relaxed/simple;
	bh=TYUy7PKmr7aGF3B+lJqtoovMPLsJ5TMAsB0ds7KwnsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G2B07APvfHoEvnTG87HU+n/STSopHendtR55HhorqC45QkSAW33Qqs3fnjQzd+D/CSkn/Kr1NIMSKGGk/mGMpYDWFW2t+2ndz5AblgO4+gSCGPWayQ4SqaOQLWDcihkSJozfAheRlbelnnFFPK7EcD7CLLnXKdcjUtdwUHMXZ8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lrBt2E30; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k0INe8/u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DXTtI013246;
	Wed, 4 Sep 2024 13:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=TYUy7PKmr7aGF3B+lJqtoovMPLsJ5TMAsB0ds7Kwn
	sY=; b=lrBt2E30uUbY6pBEPBE8jk4lEuBQJdDd6Yxws5Ixp/cnd3oo+ZoFmZZ4W
	cM/I8cWP6OEDy5Bb2WiG7IvSDwwVPj6YQr2R1TPFlXZcMYeTVZH4CnC1++PIqMDm
	VyqnjKpwCGfdguavapFXhaIE1LTNreIrV2cV3UwFIlo6bFPb+WnoeRRFtHsbEPqZ
	4U/4b2abHLlvWNo/M5W0+IYvHotkaXK4hig+nNvyGucAV5btnlepyGpFypZmsmJl
	W6Yrlcaq/33rrhFHqp2yHlJ8PxQ3+D0G13G62iXqfm759cEk9G/aABEOMQ/tNHQI
	IpgGsucIiop8ffAJwa3+KFOin92Dg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndkew7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 13:56:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484DpUUL036757;
	Wed, 4 Sep 2024 13:56:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsma47m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 13:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcgS+IxqjFupCWkBhNQZ+0rK0D5oyb2mxUGvsD5Z2bIJ1lS+1iX34CDtvj7UVC4+R0xg5jL050pT/Q9kpjz5EkCndp/ZIiZ9HwXgCx0R+dERPtOE+ixHl4goEKldPUl3k+g2HEhOGLmEi6wXVvudFIOO/I8eRlCS/zZwoHJWiAmDYdhIuWYYPPc83L0rE5Gptp9WDRwWH4YUUMTbZYtad23PSJSdM+6AOciTe2YfFF6eHKYNGe2TyB4WnTOg1wcKx8mBsVDEPYlowNiAk/NQRIDJ7g87zOhuZYKEinsJUaO/HvGLFwMU4Q6McfezGnIcv27z8iqePPpO5vYl8tELgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYUy7PKmr7aGF3B+lJqtoovMPLsJ5TMAsB0ds7KwnsY=;
 b=wcDmIixVv39u2oE0cACKXhrHw7l07SO5kn7Ii5M21OWV4W13nbTH2Pl0QO0jlJNZEQ6PQn9bJaSEv+gAydGM+FQiyfKuwM6v3/QIAY4uDfDAhgPCZZ6kU1qHsuVqAcVwt6/r1e67Hgg9IZOymnQHdK+RmoEPUomFVqN042lBNGPugk2RXvuh9ECNgSYKEnTrzdh/I32CW70Dx6RkQYrk3uu77P/LJCMXElHu0TQbUZLHhJIlqN/m95ljUbZ22hWojgurNjPaoZbQp43v4uP4EsfKXjx5FQXb/tvyrQuu0gYEdgHIsu1vyUSE7uSVPQ08PKHsKwmDupdDaqGFOOxbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYUy7PKmr7aGF3B+lJqtoovMPLsJ5TMAsB0ds7KwnsY=;
 b=k0INe8/uyUlaXUYGL7vHLwhgYWSTw2dCwi0y/7fK53c56WdDaeYLZsgwSf1eNdtQ+Wg+XYZDpCrzfnzdjMclnvkTcKo6BVOVaVyyJHhOrgt8EGv6BOKFnw7Ixeq06yKOzDb7KHWp8koxomyYxMXk8zedNzXbiAQE3B6IjTNAP40=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 13:56:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 13:56:53 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>, Mike Snitzer <snitzer@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Topic: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Index:
 AQHa+/Z8NjJpiHCGJkyIBxPv6nO2sLJGJLQAgAABzwCAAAV7gIAABX6AgAACqoCAAAhmAIAAbZ+AgABs/QCAAJS5AIAAAL8A
Date: Wed, 4 Sep 2024 13:56:53 +0000
Message-ID: <82BDFF80-8288-48B8-877B-965A5D73D2FA@oracle.com>
References: <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
 <172540270112.4433.6741926579586461095@noble.neil.brown.name>
 <172542610641.4433.9213915589635956986@noble.neil.brown.name>
 <86405a95e604281c4a14d1787bf91b02dbc2b115.camel@kernel.org>
In-Reply-To: <86405a95e604281c4a14d1787bf91b02dbc2b115.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV3PR10MB8108:EE_
x-ms-office365-filtering-correlation-id: 49b25e40-931b-425b-b7ba-08dccce96eb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUlwR1FzQTdJbTJlZ3VCNVFMU0cyN3VxYURyb0lBNStTdFNKL0NON0tJaEUr?=
 =?utf-8?B?L2VIVHR5VnNMYnk2NTlZeUFkd09pd21ocVBJL1lOTFpuR0RXTkIyeUpaSEhn?=
 =?utf-8?B?QjhIbTRVb3VkK2x2QnhpTDAxTE1lZTNha0h3d1VWWEVNL2x2L294M0Q2L3lw?=
 =?utf-8?B?YmpJQXZxM2NyMmJPZ08xUVpzbGZLTHQ5NGk1SnkzdmRLTW54M2l1RzVZbzdE?=
 =?utf-8?B?eGxqRHZDWXRGTjB6Q3czL2JrcVlJOTBOMTZMNnNjK0x0TWk1a3YyRTBGeVdl?=
 =?utf-8?B?TGhDamExaE5qS2hESWlyR0ZUZXBFN0Vna2xUMlpHQUgyMzN6UzdDQVlnYyt3?=
 =?utf-8?B?S3Vyd1lFTDRHNGEwdWsxY0EyWll1MGhDNEdDamd3d0ZZQU9vMzBYNDY2Ritm?=
 =?utf-8?B?bnFJcHVzTWxXVFJacjlKYnV3bS9EU2VNM3hNanhQL3BKTExnNXVZc0ZDMUNs?=
 =?utf-8?B?QkFuMGkvNWE0YmJpaWxReFdjMDV6R29ZZmVrekc2aXdnRUFUU3RYdDl6WDAx?=
 =?utf-8?B?aTFxNW9wdFJrR0E1eGtpMVdkSWo5RTNwOW9Ydko1QVBBWVkvaXpwS2NuOVJQ?=
 =?utf-8?B?YmtveG9lQStzc1ZtV2xJa1NJbHdjc1QzUHZHMzgyd21HQ01TeURER3hlella?=
 =?utf-8?B?eGR2SnBEV2kxZkZlQldkRzhGMFhFUFk1OXgxTzlJN2pWOTMvb3JJSXUybkRI?=
 =?utf-8?B?YWF2eDJISVh5L1FnSlJIT25TczhPV25EVkJRNGQwaXNiVFZDNisrdk0yZHZo?=
 =?utf-8?B?a2F6b1pEeVd2WGZ5Q05SNjJyOEl5YnB6eGNRdEtKS0V2NkxlZE5ZV3M0eGo3?=
 =?utf-8?B?QTI4a1BOQmxlU3pNeks4aE8xaEQ1U255SUF2K0xlU21CNlZhYmFMN0VEZUlW?=
 =?utf-8?B?aFZkTGZRQ1ZPQXJYWk5nbmVGU3dlbEN6QmVtQndqUTgzLzV5aHVxTTFWOWI1?=
 =?utf-8?B?Q3A3d283UTluekNXczhub1ltZmwrWjQ3U1pmd2ZhdTl3R0hHK285RXQ4TTdy?=
 =?utf-8?B?eHo1Y3BpcEVLb0tabEZqb20wR1ljbmk5MHVDdWlDVTNRaE1IM3QrUURJTGhF?=
 =?utf-8?B?QVUrb1VOTTZ4ZldaNjRBR3liZVVjMmRuRHFqR0xjeThFcEtFcnl0WGhMM1Iy?=
 =?utf-8?B?SWtUWEtHelcrbzNhbE1VM3doZFFmaFdKbjdMRXdvcnRDRStJUU4ySTUwQWQr?=
 =?utf-8?B?NjNTR1dvc0NpY0tMeEtaTHR4R09UYjNUS2EvY3lmRkVWV09HOVJrWFdMTzJN?=
 =?utf-8?B?UDkrQmk3TVNiKzJKc25ISmtPL0tyOTQyVUxkbHNaZGZubmwrQjNMMTJPU1Mr?=
 =?utf-8?B?ZGtCQ1ozOUtFNFdCMkxPWnJCYithZ0t6M1pYc2UrUFRibjROM2dLK25LbTJF?=
 =?utf-8?B?bENERUJjbnBMZEI2OXptaTAzRVh1N09WWXlDLzEwdnNqR08rKzNXZ3FkQWNv?=
 =?utf-8?B?UHRjMW1XOVBVUVdtSE41SHFoaHovK0RSK05MRkVhT3I4S2JDUFo4ckZpY1Vp?=
 =?utf-8?B?ZmZra3lqb0x5SEZZSUlYVkRTOEcwMlN1UFVCVFB1dWlXMDFmM0VaaGw1NitZ?=
 =?utf-8?B?RHh0RkZHenY0NklmV0NqMkJPRy9ReHlzOFRaTGVIV2dqbFB5ZzVrSi9XLytt?=
 =?utf-8?B?Q1B6ZzAwRC9GUVo3aEtqV0t0MWZ6eXBPZ2R4bE5DOGNwWWRLSDBwWE5yMXFE?=
 =?utf-8?B?OHQ0Q0xqT3R6c2VyVHc2cnIxeXhBUXN5YlBiOW9ybkt4eDdVMUc0c1RJK0Qx?=
 =?utf-8?B?WlNxWnlQbG1BY3VCWkJwSzhNdklvd1dwbmpRek54UEVXQmtjN3EzSTgybktw?=
 =?utf-8?B?ajZZVzlPTXozVk04YnVrMlVLcHNWSDVFVmtoL0ZxcWRpdkhCTFBOY0VvenJm?=
 =?utf-8?B?SEpnbUY4bTVUTHd0b3UvTm95SzlGdmxtU2hFdTRoSkhQUFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVJIT3lKQlhiMkF6NjFFVzBMa3Vqd0dyRUlhcHJtTWNOeEc1OXlVS0xiNE04?=
 =?utf-8?B?K1ozdnBKckpxNStXVlpoanl4aXVDY28zdDN5b1VSMzhpczlJSlpEQ2s0dW1o?=
 =?utf-8?B?eUo4QVFkL2pnUXltS0NyOS84Qit6OHU3MTJTaWpVYkcrYjRkZ3Q3akdWK3BR?=
 =?utf-8?B?bEs2UmRWZnFGRmRJbGE5QllCZlNvWHdlMTBkbkIyWlNPWEhOci9QUHdmNWlj?=
 =?utf-8?B?VExBeU9mOEJxUlByMWppZ0dPdjZxTE44QzhGQTg4VzNhRCtIc2R5eTlGc3Vs?=
 =?utf-8?B?UytLSi93eGdNcjN1VjB0T0ZGM3RBVHFsUTlPanYxdzNLWkRDMHVIVzg2NFlM?=
 =?utf-8?B?eEw0NkpqUklXNkd6ZmxFejNOWUROV1AvVHdMa1hML0x5MnVkTUFqTmswMlEx?=
 =?utf-8?B?THdIcnVrcXVuZk9jN1VIQURGUG1VWXBOU2QyZjV3ZVpKbjZjTnd0clBuT3lm?=
 =?utf-8?B?QVV6V24xV203SkZLaEZCemlmVXVtM3lsQ3pCTUNQckEremFuMGEvUWhVVGdZ?=
 =?utf-8?B?Z25RQ29GWTBHaFVyL1F3cWNiaWIrS2VoMFZGNUF1Q3hQUG1MYTJLSklySTR6?=
 =?utf-8?B?RHhjUlVyN1o2ZGJ5Q21KeElicVVjdmFUZFB0TWtFZ2ljVzNwVkJvbXYyeTVa?=
 =?utf-8?B?YldPMUlSZG9mSWwrTkQwbHk2TVh2WEVkQUt4WjFDbkx2RDloZlN1S1locGJr?=
 =?utf-8?B?Q2MzWWRsSVNNV0Rhc21mQWlsOS9tdFArLy82dUdtdmZVZzBHOGNtcXBLRm5B?=
 =?utf-8?B?SEM0MnlGVFRlVUl4VnFwelVyc1NFR2llRDBrVlFwUXAvQmd0N3pNQ1cvWGQy?=
 =?utf-8?B?cEp4bVVmZndLZUJ2eGtZWGY0a05QRGlQd09ZT0pRN1lrdGZRbS9HeERaODNN?=
 =?utf-8?B?ZHNkQjZpVnREbFdMREZnQlg3SDlKR0VjYzdrc3dGbkVFRjlmNWx6aktHTlo2?=
 =?utf-8?B?SDZ6bTk4d25DMkFYWlU0MExJUXhxcFVqQkNHVlZ5NWVKeDYwdXVWekZMNnBS?=
 =?utf-8?B?a2crSlR3U2t6T0J3M1hZMGUxK0xUWVJ3LzhJQTgwdjZSL1lSZXozdk11dUlU?=
 =?utf-8?B?d2ZBbzRFcEdZZDhXUWMyU1Jjb2FkOWN1ZkMwRklsQllwSHR6SGt1L1JlWmRF?=
 =?utf-8?B?SEdicWtUcXpTMnFtMFM1WVpONHMxdEZ5UlNZSm9PS200RUhxTXA3d0kxd1pZ?=
 =?utf-8?B?OEFYd3c4WkpZVU82Y04wSE9FZ1p0S21WVkhFMzJYSU42ZzZ6UHQwdWluNE1s?=
 =?utf-8?B?WUQyUFBva0NnbjBoN3NrYTNQanhTVFVlYjF5dTNKRm56NGhsaWREL0M4Yk82?=
 =?utf-8?B?UE8xUk1KMmpRU3hxQlNZeGZMcEFMMXZxYld0eGJDTi9DSmFtRHg2MmZCNzN0?=
 =?utf-8?B?ZzN0ekFFVHFMRGFaTFJsTCtndzJxdGpMYzF4NzM1NmtycEFTUFNKMTRXaGlN?=
 =?utf-8?B?bnhmUzYrcU1yL3YrTjY1T2FWZi9Ec21tQi9OYUhYak9NVnBsSFNGUFNaMHl3?=
 =?utf-8?B?TnNmeVVEdnRTa28ya1FINXRqMzY2TUJUWlJDVEhHdUFLTGFTSFN5ZEhtZ1Jr?=
 =?utf-8?B?WCtZRmU5cTRFNkZPWDNKVDRGbmZ0bU9hajNoRHVQNDB5VXN2R05ZRTlsVEd3?=
 =?utf-8?B?eVBUS3dlYzNyYnVTY3phcmZoOXN3T0JlNnZuV09UOGwrYlhJc0cxMlBFL01m?=
 =?utf-8?B?MDFVaGw4S0dlQndhbGtsdmdQQkQ4UDBDelVoWFlKYjFHeXlMTERvdE1KVmth?=
 =?utf-8?B?dG4zOEJwR3JmV3p5QWFvVk9vNUQyMkJBa0NwZWJOVnY0UjhuNlpjcnc0L2Q1?=
 =?utf-8?B?cHl5OHY4UUJRUVBrL3J6TjBteStBbHo4TzFReWtUdnlYcFNNTzdWS29JeVQr?=
 =?utf-8?B?R1BOZ0ZkNUp1SUdIc25EQlZGWnFjdHlvSUgra1UxZzVVR0lhdUoxQTh1WDM3?=
 =?utf-8?B?M1drWG00ckJkYmpidHZHZFhuTGVwZEJLWDM2RVJWQUNHbHBIWkF1b0RoSnJr?=
 =?utf-8?B?d0hnQjdKTWl6L2hoOTFTYjBXSE90aUhsS1B2dXllaWNOc2tHS1drMGhDYmtQ?=
 =?utf-8?B?Qy9NTTNlbmVxaXNOam9ROUhpLy91RXcvVjhsNDE4SUgya0Q3R2tpb3hkUmdn?=
 =?utf-8?B?Rk9jUTVhQ0N1NEpMbTdJbFFxSFZVaTBUSEpyUEEyQ0xhencyZmx1U3dPQUxn?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6D625FFC1AEC44C9C29AE70FAE1BEC1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UGA+n0aXen+EQLd1QFzrYJ5XXkAlXANpSzvYKa1u5fOfFRynIblOCiwa9bvs7Uw6oJx2qFB+lmJhELLPbTZ5RF88/YLDt9TP3LNO/NvWcQF3nhSGLU84pT1HTGMMB0bPOp9/2SLvVWnZmTgS6U++l0qaMPvXoefY1TPHUiwESoJ73VYb3y8N+j2sYeQPYP+bcXKdMVdWtsgwAYKJfEguKYrX3xV44aKpWlieYEiVaIpjLGG5ZovHbhb32m2ypncaV1lpx4Ys0eBEEeY1TumwgqyOmY88jCoBxMksw0fqW9qkLlK3Kjllml5MJ6uCEbiEfaQIhCs7dmGLVWdOWp/f2kUFgwEgauPlGcSnsH4TDMlqDS9koc5C4SuC1trjHeMlOUiIlS3NWqFnRY0JVHfeBv5X28beKhLYiHMq11fJD+nF2hOsvNq2LQxwzkLQnXnJOfQc0F5PHCbUVxuYuxq/5BA1TomrGaD7dmkkGTd3k0qp1/vghw6APQmQgYY6Xhua2wEBfkObdC2CYQn0Yk2GVsJekWKGn9FZ8qrxOkJ2HTnlj0E8om6d/YfnMhljmz9cjqR7f5wb26G9WuOpM9Z9z+DZFdfYolIQScXkjAapUw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b25e40-931b-425b-b7ba-08dccce96eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 13:56:53.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOiFIR9JiGoQfW8vdAklPALVHLI5gd4kTzOeEGtptFh03IsT+NNW4h8v8vpQuKK7HDfBAQi7AECgdHPdWkML2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040105
X-Proofpoint-GUID: 3tTK1EHcdAdK7d_K3bVgQF1Rrq-g6oFm
X-Proofpoint-ORIG-GUID: 3tTK1EHcdAdK7d_K3bVgQF1Rrq-g6oFm

DQoNCj4gT24gU2VwIDQsIDIwMjQsIGF0IDk6NTTigK9BTSwgSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDIwMjQtMDktMDQgYXQgMTU6MDEgKzEw
MDAsIE5laWxCcm93biB3cm90ZToNCj4+IE9uIFdlZCwgMDQgU2VwIDIwMjQsIE5laWxCcm93biB3
cm90ZToNCj4+PiANCj4+PiBJIGFncmVlIHRoYXQgZHJvcHBpbmcgYW5kIHJlY2xhaW1pbmcgYSBs
b2NrIGlzIGFuIGFudGktcGF0dGVybiBhbmQgaW4NCj4+PiBiZXN0IGF2b2lkZWQgaW4gZ2VuZXJh
bC4gIEkgY2Fubm90IHNlZSBhIGJldHRlciBhbHRlcm5hdGl2ZSBpbiB0aGlzDQo+Pj4gY2FzZS4N
Cj4+IA0KPj4gSXQgb2NjdXJyZWQgdG8gbWUgd2hhdCBJIHNob3VsZCBzcGVsbCBvdXQgdGhlIGFs
dGVybmF0ZSB0aGF0IEkgRE8gc2VlIHNvDQo+PiB5b3UgaGF2ZSB0aGUgb3B0aW9uIG9mIGRpc2Fn
cmVlaW5nIHdpdGggbXkgYXNzZXNzbWVudCB0aGF0IGl0IGlzbid0DQo+PiAiYmV0dGVyIi4NCj4+
IA0KPj4gV2UgbmVlZCBSQ1UgdG8gY2FsbCBpbnRvIG5mc2QsIHdlIG5lZWQgYSBwZXItY3B1IHJl
ZiBvbiB0aGUgbmV0ICh3aGljaA0KPj4gd2UgY2FuIG9ubHkgZ2V0IGluc2lkZSBuZnNkKSBhbmQg
Tk9UIFJDVSB0byBjYWxsDQo+PiBuZnNkX2ZpbGVfYWNxdWlyZV9sb2NhbCgpLg0KPj4gDQo+PiBU
aGUgY3VycmVudCBjb2RlIGNvbWJpbmVzIHRoZXNlIChiZWNhdXNlIHRoZXkgYXJlIG9ubHkgdXNl
ZCB0b2dldGhlcikNCj4+IGFuZCBzbyB0aGUgbmVlZCB0byBkcm9wIHJjdS4gDQo+PiANCj4+IEkg
dGhvdWdodCBicmllZmx5IHRoYXQgaXQgY291bGQgc2ltcGx5IGRyb3AgcmN1IGFuZCBsZWF2ZSBp
dCBkcm9wcGVkDQo+PiAoX19yZWxlYXNlcyhyY3UpKSBidXQgbm90IG9ubHkgZG8gSSBnZW5lcmFs
bHkgbGlrZSB0aGF0IExFU1MgdGhhbg0KPj4gZHJvcHBpbmcgYW5kIHJlY2xhaW1pbmcsIEkgdGhp
bmsgaXQgd291bGQgYmUgYnVnZ3kuICBXaGlsZSBpbiB0aGUgbmZzZA0KPj4gbW9kdWxlIGNvZGUg
d2UgbmVlZCB0byBiZSBob2xkaW5nIGVpdGhlciByY3Ugb3IgYSByZWYgb24gdGhlIHNlcnZlciBl
bHNlDQo+PiB0aGUgY29kZSBjb3VsZCBkaXNhcHBlYXIgb3V0IGZyb20gdW5kZXIgdGhlIENQVS4g
IFNvIGlmIHdlIGV4aXQgd2l0aG91dA0KPj4gYSByZWYgb24gdGhlIHNlcnZlciAtIHdoaWNoIHdl
IGRvIGlmIG5mc2RfZmlsZV9hY3F1aXJlX2xvY2FsKCkgZmFpbHMgLQ0KPj4gdGhlbiB3ZSBuZWVk
IHRvIHJlY2xhaW0gUkNVICpiZWZvcmUqIGRyb3BwaW5nIHRoZSByZWYuICBTbyB0aGUgY3VycmVu
dA0KPj4gY29kZSBpcyBzbGlnaHRseSBidWdneS4NCj4+IA0KPj4gV2UgY291bGQgaW5zdGVhZCBz
cGxpdCB0aGUgY29tYmluZWQgY2FsbCBpbnRvIG11bHRpcGxlIG5mc190bw0KPj4gaW50ZXJmYWNl
cy4NCj4+IA0KPj4gU28gbmZzX29wZW5fbG9jYWxfZmgoKSBpbiBuZnNfY29tbW9uL25mc2xvY2Fs
aW8uYyB3b3VsZCBiZSBzb21ldGhpbmcNCj4+IGxpa2U6DQo+PiANCj4+IHJjdV9yZWFkX2xvY2so
KTsNCj4+IG5ldCA9IFJFQURfT05DRSh1dWlkLT5uZXQpOw0KPj4gaWYgKCFuZXQgfHwgIW5mc190
by5nZXRfbmV0KG5ldCkpIHsNCj4+ICAgICAgIHJjdV9yZWFkX3VubG9jaygpOw0KPj4gICAgICAg
cmV0dXJuIEVSUl9QVFIoLUVOWElPKTsNCj4+IH0NCj4+IHJjdV9yZWFkX3VubG9jaygpOw0KPj4g
bG9jYWxpbyA9IG5mc190by5uZnNkX29wZW5fbG9jYWxfZmgoLi4uLik7DQo+PiBpZiAoSVNfRVJS
KGxvY2FsaW8pKQ0KPj4gICAgICAgbmZzX3RvLnB1dF9uZXQobmV0KTsNCj4+IHJldHVybiBsb2Nh
bGlvOw0KPj4gDQo+PiBTbyB3ZSBoYXZlIDMgaW50ZXJmYWNlcyBpbnN0ZWFkIG9mIDEsIGJ1dCBu
byBoaWRkZW4gdW5sb2NrL2xvY2suDQo+PiANCj4+IEFzIEkgc2FpZCwgSSBkb24ndCB0aGluayB0
aGlzIGlzIGEgbmV0IHdpbiwgYnV0IHJlYXNvbmFibGUgcGVvcGxlIG1pZ2h0DQo+PiBkaXNhZ3Jl
ZSB3aXRoIG1lLg0KPj4gDQo+IA0KPiBJIGNvbnNpZGVyZWQgYSBmZXcgYWx0ZXJuYXRlIGRlc2ln
bnMgaGVyZSBhcyB3ZWxsLCBhbmQgY2FtZSB0byB0aGUgc2FtZQ0KPiBjb25jbHVzaW9uLiBUaGlz
IGludGVyZmFjZSBpcyB1Z2x5LCBidXQgaXQncyBub3QgbWF0ZXJpYWxseSB3b3JzZSB0aGFuDQo+
IHRoZSBhbHRlcm5hdGl2ZXMuIEkgdGhpbmsgd2UganVzdCBoYXZlIHRvIGRvY3VtZW50IHRoaXMg
d2VsbCwgYW5kIGRlYWwNCj4gd2l0aCB0aGUgdWdsaW5lc3MuDQoNClRvIGJlIGNsZWFyLCBJIGxh
cmdlbHkgYWdyZWUgd2l0aCB0aGF0OyBidXQgSSB0aGluayBkb2N1bWVudGluZw0KaXQgaW4gY29k
ZSByYXRoZXIgdGhhbiB3cml0aW5nIG1vcmUgY29tbWVudHMgaXMgYSBnb29kIGNob2ljZS4NCg0K
DQo+IEx1Y2tpbHkgbW9zdCBvZiB0aGUgZ29yeSBkZXRhaWxzIGFyZSBtYW5hZ2VkIGluc2lkZSBu
ZnNkIGFuZCB0aGUNCj4gbmZzX2NvbW1vbiBmdW5jdGlvbnMgc28gdGhlIGNhbGxlciAobmZzKSBz
aG91bGRuJ3QgaGF2ZSB0byBkZWFsIHdpdGgNCj4gdGhlIGNvbXBsZXggbG9ja2luZy4NCj4gDQo+
IE9uZSB0aGluZyB0aGF0IG1pZ2h0IGJlIGdvb2QgaWYgd2UncmUgc3RpY2tpbmcgd2l0aCB0aGlz
IGNvZGUsIGlzIGENCj4gX19taWdodF9zbGVlcCgpIGF0IHRoZSB0b3Agb2YgbmZzX29wZW5fbG9j
YWxfZmggZnVuY3Rpb24gaW4gbmZzX2NvbW1vbi4NCj4gVGhhdCBzaG91bGQgaGVscCBlbnN1cmUg
dGhhdCBubyBvbmUgdHJpZXMgdG8gY2FsbCBpdCB3aXRoIHRoZQ0KPiByY3VfcmVhZF9sb2NrKCkg
aGVsZCAod2hpY2ggaXMgdGhlIG1haW4gZGFuZ2VyIGhlcmUpLg0KPiAtLSANCj4gSmVmZiBMYXl0
b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

