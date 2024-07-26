Return-Path: <linux-fsdevel+bounces-24322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA3993D410
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A097F1C208A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA51917BB24;
	Fri, 26 Jul 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ia6ADz/Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CcTu8OYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26B78C8D;
	Fri, 26 Jul 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000078; cv=fail; b=dE4jihYGTf949MGCB1/sf7KZ48iLVYADNf+2z5hn6RXDHQOJbQPwczpuBiwh8hDT+LHD8aINkmxqp2irU7Z4kn+I4QjL3vCHzMGngjhjp+7cdfz1S4Mll/25WP1xe/lrgjLJqxlvyXb9oLgpj0/zcKx6ZuwJDF1EvfMYLSZsu1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000078; c=relaxed/simple;
	bh=ldg8xDbYBGP7SpkG4zF/8gLpyl7Q2o8pFbKT56LTbGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCitv0tVz/mLT7FdiWoapWczAn8MIIGz8t9syeMQqrKtCd6QIMtrKnXpwhoRrbQ1plGU0qOF+cfdy3xopbVLZr9q4IekNUKilElCt9wIzwJ33ZXkAHlgbUf6H9BEizV5WS9it8GJX+fdJNImNpy2eVpCyaGn4fH0ZberA1TRWI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ia6ADz/Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CcTu8OYT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8tVh4011792;
	Fri, 26 Jul 2024 13:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=ldg8xDbYBGP7SpkG4zF/8gLpyl7Q2o8pFbKT56LTb
	GY=; b=ia6ADz/YIEEtizOJmg2CmiUrOhrAl5RgEV81M1d/IvZRqyZCKe8K6BoqJ
	6ZF6rn5+LFiKQOuA6eJ1kWsX6RfZr69OVhJZ63lv233LQX1xTRteug3hye7kwUPk
	tUu5CCBXgoPN2Stk4ma2I/dA5tDgOkCioNwb85Ag0z3gqVhe4ij6OOnu9gZnCRR3
	1dM9yh9lIRd9b/PLRM84xVcW2vqae+fUwXDrRbV8UfLI81eOC9tdQlQmUPfcfkl9
	Bif/6ZMffqnWXdmWkSkSSyZjV8+Sb3/GCfgktZWyAiFqD+ycwXymLUshJzM8d8r1
	eh7ABQ8yE4fF1c7R954y4mA07Nz3A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkr5evg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 13:20:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QD9d0J038877;
	Fri, 26 Jul 2024 13:20:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26rnr4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 13:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGc3WmlUCjBX9drG2L7vAd2ntZcHMnVhn/yRsL6PxvD3rJjSChz4uoiTeqkzfp4hsy2m9P1qo77gSvAHEorPMbhVn3DfCOtFrtZL/0ug+ekr1GwAoG9wS+cc9XU9/PWQAX+3IKgvU9kyb+VrhSxb8oPh9wpw4JGWiACJ1rmvoGAz/zLZWdmRb0U8xLgehqLe13rfp+YFQV5s6KwVy6Qd1LedJHnMvzzgqXxLMj2rSTQpjrSnOq1o8aPFpc/0wiw98PKnOtB81IQdtjtu5mGH2rzcnM21qYwFZLukJo7Kiqc8Tvmei6aRMkzjy2SJW2qRLFWbvGcyMbc4SYUVF++f7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldg8xDbYBGP7SpkG4zF/8gLpyl7Q2o8pFbKT56LTbGY=;
 b=NPoirTHc0pdLmSKcS9xedNIz4QgI6Rl2KTJYpLQKdT+CFqQ8KZdl6tuJ8j1SMy/hvEU666iMBPy7HYzMsHz1uLND7ZFefWTrfIUpLCegvTP7TAxsEQzcDpVv74oaGL2nBLArnwfmceV9U5qT7z+U6NXvdabnQmsYAI5rO7qes8+aNu99h5goZ3OW9WYmBN9iS8IBDGy4exc6BNoE2AllGaDtwAhSAuoQze/bvM9nhRJN6hZ8yKQ0RoCcQWbonbGw56EAf6RhuVa2Wwp2OHiO91smIGU/kTJRJZkbmqDd0y/veeXzyj+MXmGsdfwIe2YAyvONEVcttKk7tq8OFQ41lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldg8xDbYBGP7SpkG4zF/8gLpyl7Q2o8pFbKT56LTbGY=;
 b=CcTu8OYTP0ji3OK5GnIg7XFLaDMCdeYhHMfl6lmRqjhTnqa/Cl78CDJsK5rHx/YdD+4YZ76kIGUOfqxB3l/wQRBVettoa5O6AJyQxlZTIe7JIol/6TeIoWgqXL5peaof8vZLysw8JtyvgMZ6J6mf9mtchWLmrgcu90CH/MppwBI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7331.namprd10.prod.outlook.com (2603:10b6:610:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 13:20:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 13:20:52 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Hugh Dickins <hughd@google.com>
CC: "Hong, Yifan" <jacky8hyf@gmail.com>, Rob Landley <rob@landley.net>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "bugzilla-daemon@kernel.org" <bugzilla-daemon@kernel.org>
Subject: Re: [Bug 219094] gen_kheaders.sh gets stuck in an infinite loop (on
 tmpfs)
Thread-Topic: [Bug 219094] gen_kheaders.sh gets stuck in an infinite loop (on
 tmpfs)
Thread-Index: AQHa3vf2+GP3L9MReE+CSba3TfSX8rII/0mA
Date: Fri, 26 Jul 2024 13:20:52 +0000
Message-ID: <84DBD5CC-BFA9-497F-8545-48D181FCD517@oracle.com>
References: <bug-219094-5568@https.bugzilla.kernel.org/>
 <bug-219094-5568-fyOeXKhNmt@https.bugzilla.kernel.org/>
 <a2808893-d257-e6b3-e168-0478d7255621@google.com>
In-Reply-To: <a2808893-d257-e6b3-e168-0478d7255621@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7331:EE_
x-ms-office365-filtering-correlation-id: 526670eb-b26a-41bb-3d36-08dcad75c618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3VrVndYbFBXbUIxSm1MZ25zNGFDNzMrN2s4SkJSWEQ1b0pWYnRRMDRLRGsz?=
 =?utf-8?B?YnJJeEp0Sk1SYWZiOEFtSHlqS082NmNpbEFKSEZXUi8vRUVHRzVkZlMzczR3?=
 =?utf-8?B?QVNwdkVEQndxN01QTWNKdVRBaFdlNERBZ0ZGMkNpN05BM2xhTmVFS09UeHhU?=
 =?utf-8?B?Z1UrSGMxbktYa0FWRXdRTWVzSWtSTWVPdDcwRm5sV2x6anhkTUNFanZPYmVx?=
 =?utf-8?B?cGI0aitGSDNlbmpEMnlpQTlGaUZ5Qlo4UThsY1BTT2pHTzZmWWF2WUZ1Ym5I?=
 =?utf-8?B?Kys1TUZJTDFUaVNvTDZLY1NRMUNEYkFtSkk1bTNXK1RIRStMZVVRTmtXazNo?=
 =?utf-8?B?bjBSaktYYWhPVVd2WkdqRC9weHFUdWdITnJuWVl3MTVQckRjdGtFYmdqdmda?=
 =?utf-8?B?MDU2UGpDQWEyQmRYL0t3dFZCcUdUSVE3MEx6Q2lieGZDeXgwM256WnQzNWZl?=
 =?utf-8?B?NmtsU1VwMDhabURhN1BYOWp2bkxhTU5OOFZIZ0g0VVpOWTZCRXNjdXdoeVZj?=
 =?utf-8?B?RlVZWmRWQVdYZnhvRkhmYklRQnBTWjZSTHNSZC8xWW16dUtZdWc5VWtUbURK?=
 =?utf-8?B?dlpyMlV2YmJtVmJPVU81RXl1UVZYVzhmQm9zUnRicURHaktmUExoa0RqYzkx?=
 =?utf-8?B?eHg0S25VTVJ1SkZ1SncwWFlUTUJFb2ZERGpTM2FWTzNYdUFjTkZROUNKRlpV?=
 =?utf-8?B?QnBjaG82UDBZWGh3M1ZpN0t0eGVHUk5OMnNZa1BscVRpNUFvSWxqTWQxeUNw?=
 =?utf-8?B?OWFoK3VremYyaURRcVdUUUwwQ3ZrUWRFeEpLT0xsUEpWaWFTMFFJc0dlL1Bm?=
 =?utf-8?B?cnA3MEFCTnVCNnlTSVlNOGFZMWlTVEZlR0NUT0s1ckxVb1ZNZmM3KytwZ01F?=
 =?utf-8?B?Z0JxbTFEcTdnM1BjdG8rbHNYeEt4aXdJaWRHQ0MwQmdZcDZPOW5PT2pWZ2x0?=
 =?utf-8?B?WEhqYmU3bElYeGo2QVp6STQvYWx4REcvaUZVS0MxZ0tlZVJVUmMvR2IvdENL?=
 =?utf-8?B?M1JmOG1hR1d5ZloycFFlTXFiemtZV2RNV1hLcWhKZ1llSGROL1ZEdTFhR0k5?=
 =?utf-8?B?WmwxREJIbUFuMWoxNVVWZzBMVVpZU1dOTmhER1o5ZkhtZjUxQzhmbjNremk3?=
 =?utf-8?B?dnNpMHY1Sktjc1hFa3ZlU2VGNi9MeWxqRkZ5R2UwVUoxdFNuRnRESTZ1R1pm?=
 =?utf-8?B?T0Q4eEhDZ3gvTGN5UXFSVVV6dzFoQkI0bUkrdG1ZYWtoejR2a3owYlJoYzFJ?=
 =?utf-8?B?cCswaU5VRlNWSmlqK1ZPUzNNY0hxMjQ0RisvSEJCQzd2NkRzVHdSNXRISk1T?=
 =?utf-8?B?N2ozdm9heVU0L2xTNDVubWFQTUNWRlljMXZMU2NMcWoranVEaDVaZWt0aUJi?=
 =?utf-8?B?NnI2Rko5UHFaa210Wm5TVGx5OUtPN2NSdlcwa21XSjBWaDdNRnVFd09ZcVRp?=
 =?utf-8?B?Y1hOaTBldXhPek9WWkFrL28rTkl2c1BOaTVqajlrSG9XT1JPZ21FUlJwcEhU?=
 =?utf-8?B?Zm9UYTJEVVROajBmTDRwRkxiY1FGNmxPOUgwM24rcm5tRFZqN3RheDBJZVZZ?=
 =?utf-8?B?Z1Exb09RUHlqS3BIeEM3QlAwWDJZTit6UUhURDUxTFB0VTJkQSs0Wk9IZWdP?=
 =?utf-8?B?UjhvOHRlZlZQT3ZUVXA2WC9jZDZwd0lCRjVQYXZPSDE4KzV1VVhCZVdVSXNa?=
 =?utf-8?B?MVJadDRUU2pPWGd2QmdhVlpJMGRFQncyQTdJUHVjb3NTWXdvTThMcjhqQTVU?=
 =?utf-8?B?STNvTDNkWHNmTVlJWDBiVHRYWW1JaGJvbjJ4T1BTOVgrK1VNOHNCZGFhSm5k?=
 =?utf-8?Q?ycCw5MAdHoJaduR2cIu/Axku7JozaKQ/6QsB4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm9iV2ZPSE54K0k2cEJXOGJUQ2h4WUFnS1NJSmRyY0w4aXdoVXBJVHhCaVZZ?=
 =?utf-8?B?VFNoRUlRaGxEY0xDK2dreWZ4UWtva3NXNnJiUmtlSXBDVjhjWEQveE5RNFEy?=
 =?utf-8?B?Mmt6Z0tmK3MwdU41YURuR0RYcGlOd3UwbnNBdEJuK21sdUYvNGN0b3VsSjM2?=
 =?utf-8?B?eitKdEwxd0J5ZlFZQkdoNm9vVkVGMnVSS2hLWE5ReGtwTXd3NW1xdjJZUUJY?=
 =?utf-8?B?NEJIUks5VFBTN3lJRGxMeE9DL29VQkNtTjdabkpyS0VOQmtRTFlCVmo4aEx2?=
 =?utf-8?B?VDlkWlB4d1Bqb0kwKzBBcURKNmtrYTVJaXIrNkVDWDN5RGNpbWJZaml2WUlK?=
 =?utf-8?B?c0N4MUY2VWY3N0x6ZkpUa2RlckRwYWM4ZjRhRGl2S1dlK0dIRmpON1BnMkRV?=
 =?utf-8?B?MFAwNllBeCtaL3FubVNkNmNoRXdRMjRyTmxheHJMTG5NTFE1N3ZJcWhxNkpU?=
 =?utf-8?B?QVVvR1FZNnljZzcyck9rSm1KWjIyZ3U1NmowOXk1NmNnQzkrVGRnazJCM2RD?=
 =?utf-8?B?RnRtWmJJOFZBZzljM0hjSzRmMGlQZXdiVzFUWkpLTklBeDdYWElQSDkwZGZ0?=
 =?utf-8?B?a3JoZWlibVk4cmZyVTF2dnZ5Zm5BRnM5d0liWnlUdWVaVUxVazJKQzVDRjhq?=
 =?utf-8?B?Z0pEUDlwSysrTGt2c0o4ZkpkNFFGME1qWk1tRXIrZ1N2RFVab1B2WVBQWUVK?=
 =?utf-8?B?UithOHZvbUJzemF2L3V6RWNTZGVRYUV6eExmMUpZMGdqK3hHTjVtYXVXdW55?=
 =?utf-8?B?N1F0ZUJoVWtJcWtldHFPR1hhMlZ3cVMzVHkrNmlHbGliOGFNRFFyVjJUaUNY?=
 =?utf-8?B?RWJacUpRY0owc0lWeWIrVksyc1hxR2M0MUt5Z29JSlNoUXU4N0xUcmwzZ3Zv?=
 =?utf-8?B?a20xSVE0TU42Yk5wdlZCUTBZODFKcjVqM0tkU2hQeE4xbDFhdmIySXhWM3Vj?=
 =?utf-8?B?Z3p6OTlMZmtIY3V3N1ArL3BIZnZ3Q3B0WWxtVE1VWjd0QTNINXJsN3UvK2NZ?=
 =?utf-8?B?NUlyRmczdllqYVZ0ZkpzVUpzQzNGbWthbzcwZjNmVEw0d2trR3g4V0J5Vy83?=
 =?utf-8?B?REErTEIyY1QzWmd1S3IzZFBNNmlFZG9DSVY5cVYzcEdsbWQwalRUYlRsd05j?=
 =?utf-8?B?NTlNOEFRWm1tWUJOMFFaejNvWGMra092SWh3VGMvZkVFdDJNbm9aNWtBMFZP?=
 =?utf-8?B?R2RyaW1WUmE5MjEwWElEVkg1NmhyQU9ZckthM2QraUM2RDJoRU0vSmJyQSt0?=
 =?utf-8?B?QThPb1RIY25uWmhZVWpzVGNSaDg4WlppZ24wQ0NxN2JLQ09ENEQycWxoVTN6?=
 =?utf-8?B?bTlNM1lUcTkwQXJZMTlhSURKL2diVjNSWVdQd1pqSzZWbGp0REFWTHREZU1N?=
 =?utf-8?B?Qy84KzV6aUQzVFl6QnA3d1RVb2U0NTdhc3V3SHVHcm1IUkJTUG5YN3VXTXdo?=
 =?utf-8?B?Q2ZZbklDbzVVdDlDQThtek96K29LNHBuQjRNSXZBQzlHbkd3VzVZRGs5eHZ2?=
 =?utf-8?B?MVFHaUdLZk80MkUvT2hCdGV2MDBnb1FKSERyTC9zSWYvWFBON2xqTDQwdjUr?=
 =?utf-8?B?S3ZnUXJSb2xHZTMrZTZtRHlOZk1nMUs3ZVRSSFRnSFZ0VXZFNjUzMEtTTmsy?=
 =?utf-8?B?ekNpS3ZsWlFVQnR6WTN5YzNOSCtCaWJTcGgwM1J3clFDKzB0TzFCU3pQVFpu?=
 =?utf-8?B?djVzWmlxQ2hlWFJwSmRNTUNrQjJxc1lhek1NWGpwSVV2TldWekM0dWgxSTBy?=
 =?utf-8?B?Q0pGc3k5eDVQdmVUa2Z4RmV6WXFwNjV6R3RoTmRXbGdidjlUb3N2K2lOQkhs?=
 =?utf-8?B?N2gyTE1UeWkxbWRoSm9CVDRBZFcvUElML1ZCRHJ3UmY3UERQNlJFQjlNbVRW?=
 =?utf-8?B?RjNQTVBVakNpVFFUVmVuSHlWRVFRbys4aHZTekZlMlh0UjBHTm0wV1hoYkI0?=
 =?utf-8?B?b096MjZBMW93bHhsMmdWRWFJakdLblRpZHZXZzA1S08xa2pJS1ZtWmxqSTFM?=
 =?utf-8?B?RjlYUHFWdnVjTXNRQ280MGdpZ1BvQVNheTcvTnd1TUliN1A4RDU0TU1sZ0tl?=
 =?utf-8?B?ejR5WW9QdUdxeS9MbGtvVVNTNGM3eWllM21vSlZVL3Vtd0lSNmF1UjFBa2Q0?=
 =?utf-8?B?ZVVrWDcxTUh2N3h3azJXRFdNbUdwUmFzMGZxaksxR2VxNExJQ0p5VElGNE5N?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1E1D52844889B40A4505539D5BAFB4D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UcRpif0aUtGFXqFOHN3ii8QOTeTdAbY9teschYJFAfghXyOf8S8NmLK9fMgJHeIk3oZDTg+zXAnTKEk7TlkqG3uv+6NZ+q89Qp373Q3jxNQqqyxNghmb4d8Ap99pwdxmjpEvudeRAg1dtrMK9XbF+zkUFoSKn1y0S4zatu7MUuRuP6OLLAFlShno0A9vJVqXJlRtAIiS+an7WiJiaOG1IGB2hmrOYJn78+9BMM3PdQmjZYWcnhPvN/kdN9GWRzFlsErX4xdRWfCcyvm9rGXshxf8lOeqMi16QeDNchbY9fsZCpq9wwP4n9+V012g6in/4CrI9S0nNZ+auoe3jFYZWzB7W9yYJgPnOXNP0mWr/eI/SymmoG/vPuKcZSDtd7qj6U6bT0WVFuW4ujywRJoZCApWEzDgQfjv238ofGlCPEOTmziqZCMU9BmIY5LRr5eF81HWhhlIMruHt3NRlHGH3tlk6WCFwi1otz4xOC04N5xuf7nPAU+FWJ7gxcfF/UMLW2UEB8HDT2NZdJBOsfRbdFtGQeLoANothtnpbodlatbxO+9cNak7tlU/rBZ8U5FwB461rc0npOKp6YW0txEKNssgV3D6jTzRb1sHKIM2a3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526670eb-b26a-41bb-3d36-08dcad75c618
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 13:20:52.5712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNcIvbMwmgcIzD4sl8R1kA1mt20tAy1HJA2rVwe84SqHBLw/ANmXk2wtulFUZKXtUwT6DBJRGJNHZXeVN1rDag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_11,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260090
X-Proofpoint-ORIG-GUID: xXsq_JdVYUVOaNoACe5qBpeg7KpLJO0z
X-Proofpoint-GUID: xXsq_JdVYUVOaNoACe5qBpeg7KpLJO0z

DQoNCj4gT24gSnVsIDI1LCAyMDI0LCBhdCA5OjA14oCvUE0sIEh1Z2ggRGlja2lucyA8aHVnaGRA
Z29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBQbGVhc2Ugc2VuZCByZXNwb25zZXMgYnkgZW1haWwg
cmVwbHktdG8tYWxsIHJhdGhlciB0aGFuIHRocm91Z2ggYnVnemlsbGEuDQo+IA0KPiBPbiBUaHUs
IDI1IEp1bCAyMDI0LCBidWd6aWxsYS1kYWVtb25Aa2VybmVsLm9yZyB3cm90ZToNCj4gDQo+PiBo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxOTA5NA0KPj4gDQo+
PiBIb25nLCBZaWZhbiAoamFja3k4aHlmQGdtYWlsLmNvbSkgcmVwb3J0czoNCj4+IA0KPj4gSSBo
YXZlIGhpdCBhIHNpbWlsYXIgYnVnIHRvIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MjE3NjgxLCBidXQgb24gdG1wZnMuIA0KPj4gDQo+PiBIZXJlJ3MgYSBzbWFs
bCByZXByb2R1Y2VyIGZvciB0aGUgYnVnLCBmcm9tIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MjE3NjgxI2MxOg0KPj4gDQo+PiBgYGANCj4+ICNpbmNsdWRlIDxz
eXMvdHlwZXMuaD4NCj4+ICNpbmNsdWRlIDxkaXJlbnQuaD4NCj4+ICNpbmNsdWRlIDxzdGRpby5o
Pg0KPj4gDQo+PiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPj4gew0KPj4gIERJ
UiAqZGlyID0gb3BlbmRpcigiLiIpOw0KPj4gIHN0cnVjdCBkaXJlbnQgKmRkOw0KPj4gDQo+PiAg
d2hpbGUgKChkZCA9IHJlYWRkaXIoZGlyKSkpIHsNCj4+ICAgIHByaW50ZigiJXNcbiIsIGRkLT5k
X25hbWUpOw0KPj4gICAgcmVuYW1lKGRkLT5kX25hbWUsICJURU1QRklMRSIpOw0KPj4gICAgcmVu
YW1lKCJURU1QRklMRSIsIGRkLT5kX25hbWUpOw0KPj4gIH0NCj4+ICBjbG9zZWRpcihkaXIpOw0K
Pj4gfQ0KPj4gYGBgDQo+PiANCj4+IFJ1biBpbiBhIGRpcmVjdG9yeSB3aXRoIG11bHRpcGxlICgy
MDAwKSBmaWxlcywgaXQgZG9lcyBub3QgY29tcGxldGUgb24gdG1wZnMuIEkgY3JlYXRlZCBhIHRt
cGZzIG1vdW50IHBvaW50IHZpYQ0KPj4gDQo+PiBgYGANCj4+IG1vdW50IC1vIHNpemU9MUcgLXQg
dG1wZnMgbm9uZSB+L3RtcGZzL21vdW50Lw0KPj4gYGBgDQo+PiANCj4+IFRoZSBvdGhlciBidWcg
d2FzIGZpeGVkIG9uIGJ0cmZzIHZpYSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1idHJm
cy9jOWNlYjBlMTVkOTJkMDYzNDYwMDYwM2IzODk2NWQ5YjZkOTg2YjZkLjE2OTE5MjM5MDAuZ2l0
LmZkbWFuYW5hQHN1c2UuY29tLy4gQ291bGQgYW55b25lIHBsZWFzZSBzZWUgaWYgdGhlIGlzc3Vl
IGNhbiBiZSBwb3J0ZWQgdG8gdG1wZnMgYXMgd2VsbD8gVGhhbmtzIGluIGFkdmFuY2UhDQo+PiAN
Cj4+IEkgYW0gdXNpbmcgYSBgTGludXggdmVyc2lvbiA2LjYuMTVgIGtlcm5lbCwgaWYgdGhhdCdz
IHVzZWZ1bCB0byBhbnlvbmUuDQo+IA0KPiBUaGFuayB5b3UgZm9yIHJlcG9ydGluZywgWWlmYW47
IGFuZCB0aGFuayB5b3UgZm9yIHRoZSBlYXN5IHJlcHJvZHVjZXIsIFJvYi4NCj4gDQo+IFllcywg
aXQgYXBwZWFycyB0aGF0IHRtcGZzIHdhcyBva2F5IGZvciB0aGlzIHVwIHRvIHY2LjUsIGJ1dCBj
YW5ub3QgY29wZQ0KPiBmcm9tIHY2LjYgb253YXJkcyAtIGEgbGlrZWx5LXNvdW5kaW5nIGZpeCB3
ZW50IGludG8gdjYuMTAsIGJ1dCB0aGF0IG11c3QNCj4gaGF2ZSBiZWVuIGZvciBzb21ldGhpbmcg
ZGlmZmVyZW50LCB2Ni4xMCBzdGlsbCBmYWlsaW5nIG9uIHRoaXMgcmVwcm8uDQo+IA0KPiBDaHVj
aywgSSdtIGhvcGluZyB0aGF0IHlvdSB3aWxsIGhhdmUgdGltZSB0byBzcGFyZSB0byBzb2x2ZSB0
aGlzIGluIGxhdGVzdDsNCj4gYW5kIHRoZW4gd2Ugc2hhbGwgd2FudCBhIGJhY2twb3J0IChvZiBv
bmx5IHRoaXMgZml4LCBvciBtb3JlPykgZm9yIHY2LjYgTFRTLg0KDQpXZWxsLCBJIGRvbid0IGhh
dmUgdGltZSwgYnV0IEkgd2lsbCBpbmRlZWQgaGF2ZSBhIGxvb2suIDstKQ0KVGhpcyBkb2VzIGxv
b2sgYXdmdWxseSBzaW1pbGFyIHRvIHRoZSByZW5hbWUgYnVnIEkgZml4ZWQNCnJlY2VudGx5IGlu
IHRoaXMgY29kZS4NCg0KTWVhbndoaWxlLCBjYW4gSSBhc2sgdGhhdCBzb21lb25lIGVsc2UgYmVn
aW4gY29sbGVjdGluZyB0aGVzZQ0KcmVwcm9kdWNlcnMgdG8gYWRkIHRvIGZzdGVzdHM/IENocmlz
dGlhbiBhbmQgSSBoYXZlIGJvdGggcnVuDQpmc3Rlc3RzIHJlcGVhdGVkbHkgYWdhaW5zdCB0bXBm
cyBhbmQgaXQgZG9lcyBub3Qgc2VlbSB0byBmaW5kDQp0aGVzZSBjb3JuZXIgY2FzZXMuDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg==

