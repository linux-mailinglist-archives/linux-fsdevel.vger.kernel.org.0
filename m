Return-Path: <linux-fsdevel+bounces-9457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CC48414CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D85E1F25767
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C615705C;
	Mon, 29 Jan 2024 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kUc16F6z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DQ8agV1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E279156967;
	Mon, 29 Jan 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562040; cv=fail; b=ARdCPl2mcad5wDpKSnSKQtIdRGhlKJBeVgCt18InoiYkmVkZQNXzmgBRdJgZ7wqj30vtEP684WDYeTUIJGiVmjdSbSaMx1Kys5rcOkHVR3MZruff1mbKrqQdztFE86rPyYbuuCamUgYoUFv9XmukBuFIpiDiS2S6wIkh2Z/bGh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562040; c=relaxed/simple;
	bh=B1QgGSiXGq2Bucm/6fpnf5EshT0pgTi8EwfmAkPPmQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l77y/BuLNh9r8LijeL1TntaH9nwAZkTmEpj42ShTwQdAJFg/rQkYx5PLmLpVo7UnTWkC5v816s0Ci5P7lsrt7p7BMpfUDD3znpaNNeHS3nfnKw9UWrVPCcbmDGM5NMCW4k3F0crEY6rcpLwLrJeM3IGhLn8hs8/jEaPhqoOm3Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kUc16F6z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DQ8agV1s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi0HA029557;
	Mon, 29 Jan 2024 21:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=zDC4EZ9EkEK0Q1bukInjHo7JQfZuYUaDxR8SLTcv9AQ=;
 b=kUc16F6zJkJjk722bCa9zvyJ89n51ndQpN3w5TNCZ/N9HI9OsR3469w3TDDDwj0NEmwv
 4/g7DSSBshJdXZ2dfG9MlGoIPZu1AW9BIRzjzRU6qi0f5VVAAZdsRKEz28Y5h7FxNw0Q
 q/QNXkBULTehi8KS6KjxaJ/Mk4RFcQwo4m6/yP7GLs0KqeUQa6lkIs9ooQtZF9AWgYaC
 XFfU3EOfJEmI583Ya/hNNH2r6DZGUNgRYmXWiIZL789akPpHH1meWrq8Y7u4cWs6dwKE
 8PgydlfkxzLKXCdiU7A5dFrwbnhyLbZUnd/+z3HN9R+Dg1+UZqMNvaJb3gUBy+HRbHhr 5Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ecx9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:00:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TL01bm014554;
	Mon, 29 Jan 2024 21:00:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr966nb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:00:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMzA41ds18vZkwdXulSuDF8SCo/gYq9oCwodH5FMufzTWbCb77bNrCkZ3jFvFbnNc85S0wcv8jF0riqUdcosXD+8e/ZIPBM0ZOnpFjkS++oIFnJl0l80eCgoObrbrLifwpBbmpnRTccrLLuj3NDhhhf7StYgtm1eEOhIQL/VNpYYNOEedGnpyp8/kvORk68UsM6Wv8OPDJ5rVLId7IfWwGMA9AncXeOUFW5s3I2PfJS/wew5zMJqzGHJMn4jcDMuofaEIh+6YfQZiC50txAOo0tQQWwV6qNZWaAQYaDHktWdXFClLmjnfSlV6qRn+Q3Ec9YRYiHQSPkV74xXtBOyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDC4EZ9EkEK0Q1bukInjHo7JQfZuYUaDxR8SLTcv9AQ=;
 b=DKNxW3XOMtLxDaPXxLUCVuwpYRmdYqEX3ket+o60/IbcYFYDsJD2F2zZgJvNgojjQv3ahUFHUlgYX1Ka95iWOJKwLEmwoWIdWMhs8y/AoXtxsq+6Q4voLVsNFVnmpSRqq8plq8v59rw1N1AJEz9ywp2F+I7JKc79fVziD4YFgfX6ehvfoLkZNUf8A9211JYiUw2tP6++gOURnFsDeKoWh9XLVox2ic3ATjKSgB9jOUM2ZJwmo+SMwEDndadKNubFlLBXyxiIum1l+0K/ycpM1JAEpvyvyZGItPWm7U4n55qCoehzkp5DTyPKL2Ig27dsYKpElLoRcJfaNh+UT2ekpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDC4EZ9EkEK0Q1bukInjHo7JQfZuYUaDxR8SLTcv9AQ=;
 b=DQ8agV1sBQA2yuqLRrEyIVv3KBdW5IW+OJtxbJO+J45JmzyLlmQaS+NvhBN9mCNTL6lwEbuV9CPTQB0TOsRZgOs13yhl9xs7v3ALq3xhbMrWjHehUnCVFdEfFl2EpYz/ApuuzVCk+7ERKse0zgiRlFGXj6lufNppFraqhznlnC8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 21:00:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:00:17 +0000
Date: Mon, 29 Jan 2024 16:00:14 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in
 userfaulfd_ctx
Message-ID: <20240129210014.troxejbr3mzorcvx@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129193512.123145-3-lokeshgidra@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BLAPR10MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 974abe76-f460-4cf3-abe8-08dc210d4bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Vttkpic6xtfDN1EsN6dHcb0AcHYN3lhvIzZNhgp0/7y3P969TQ6dRZkiMI4BF+6WMYykfz0QT2QKg610ga9Mb41vRBWF38c1+KBUQGsos8FyXkt7CVw2RoNTmcyAPYrgK9wbKgFOQ233KIVbukWzbC8RIIHmPeXgwJutUIsPl05azgf9mZnomZFome5H3xpoA4xWKVhxsrocS3DMkPzDfNRwft9+aYWntFz6Kg0iHrwdwbQNs8CQCGxcWun4pCvqo3UnZO4U/0lpOnuV0OXKJfDBp6BEWdK9NPAKikfIfoxTjKjw1LW3YP3q/iT+Lj3zGb6f0EtGd3dWrSmGQWwBk2qoG4LP2KfQRXzNa0tWDyLPHv50MBR7ifP6SBT6p+gFSdlQLeXcByLFU8ozfe4z+E+ngPKM08Le7iF/C0UPhLwWCF8vyZtIH2iYJ2//By3XijiVmX0EWHSmlbekVMp4dvyNIneC9c2LWhbK1vVMqZ0EkVFFzqNKvbuwL5tlAJq201t2tvI2FRgXtkzak5rJwzWxdqgKyXq4rOIizgVAf4BWZs6+Ep1FYE75EFsFNULA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2906002)(7416002)(30864003)(5660300002)(33716001)(66476007)(6506007)(66556008)(66946007)(6486002)(6916009)(86362001)(316002)(6512007)(83380400001)(9686003)(1076003)(26005)(8936002)(6666004)(478600001)(4326008)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SM3cDjUIOpSs5C+A0MbyRcz6SXf4doh+BPXX5ea13LoKTKDGh8bnacEKuiJe?=
 =?us-ascii?Q?I+IYrv/5JEn1441elJB066orhTc2Jq9Qt1JdrgO9PqPq4Yf6KZrWEfNDI4R8?=
 =?us-ascii?Q?A+2P/3kPU4voQWLw1oQ0L4d877oKBbNSofcg7IYGN8hoeiSShxrrfQPXumpc?=
 =?us-ascii?Q?WtWRP7kcSEhC/REhvpyo7v6Vu75yAZ8GzDa3QBq9rI2xG/lq7nH1uuV5/gEk?=
 =?us-ascii?Q?Xte1Jtu+vqqPMTGZeyFao12GkqMOdDIIShZlI1sZRkiov4Sc4EvUfWmXS6lu?=
 =?us-ascii?Q?zVmnTM+QV1UKd2M6Ctz/N5V3jrHhSSv3jdRmLnUn7/69H5IszFBviWobsccC?=
 =?us-ascii?Q?I5nkpJOhpfjmL+Gi1FyRWH+5Q+Ml+0k2AYpzrywU0HIdMXcKyMKv1KK3QSLY?=
 =?us-ascii?Q?7eWZbqOrNLf3QV5A62ZQ/Cpxzf4zCTIr/81lRSe7WOmmcFiKvRJ/agSP5F3K?=
 =?us-ascii?Q?UF0jti1tOkyBUUfdyUQU0wdHB6K/zHm0AgK42rkkI7myBKfijAS7EIV5hyDO?=
 =?us-ascii?Q?NPHrZLfOnaRhwy60mvWX8rfeeJ1XJ4QveBDijdsH+Sm31momuz99Mu27nQE8?=
 =?us-ascii?Q?yTfFvT4Aj7DT/znl/TROFe7xbwEI6bHaW3fltA+x6pkfFvyqiMfxkFhLXBD5?=
 =?us-ascii?Q?HhIaqCaa073XVoTJUoW+aqkUzDaqPt6uu7VCAWuRr9MrMViee4UO3wOoiWIn?=
 =?us-ascii?Q?eFeJM6w+goHEXWdYSFHxyAUEtGuQMWUqJhKIHuuRc+6QEvM9m+NV8u+oCehH?=
 =?us-ascii?Q?R9uM2r7xYK6997D7cgj9UwEul4O+/ubvajj83zwWe1MZS+rcX9eA4yRBtrRo?=
 =?us-ascii?Q?DkWLBwoT2TF1YxClaAOI5EHZ/Hx0YjDsJJTrOELWxFLlSWJRh4MDKb8TbUBy?=
 =?us-ascii?Q?SdMPyDSKshVpTX5bcH8x9V7NKsb+/L2kbXxIa7nJAbeO9wc6DH6T/r+F/CQV?=
 =?us-ascii?Q?rUZPS4PyxkGGs06igcyjMlp+KeR059joeRE4avRnGnIFAiX1SpoafUfZ+Z3u?=
 =?us-ascii?Q?Qt92J01Wi8K9jQJRgozM5XyMuBBlzXE8lYs43oRBiFg67WnSf4wEM/DMNqvD?=
 =?us-ascii?Q?6u1ovzNPo2XBNUyJNtGU0NlBOlHC/WkKt/rFrScjO6EBA7sM7g+tiPIj0ylR?=
 =?us-ascii?Q?oOaVRRLSsHp+ClpRhUceiB4ul4UqUyrqRz9B9Lwrezb0ZOusEtI2DG9RlgR5?=
 =?us-ascii?Q?gSvOsUPJcHQflkabcaEWDfbBqZ3QwR4ng5JUivk8kijNxSKlx+HF/37wewDy?=
 =?us-ascii?Q?Hq+seItcA2Xy2GIrcZ/7ih6VoDhLWBc7qTIbxCHhlplgFOtYqL0Hbeex+3eN?=
 =?us-ascii?Q?+62hhVZPPfPtaMGHXiLRAZttQSMbI2XxyaKBGluKv1bc53t7vLEz2yrKx/Fj?=
 =?us-ascii?Q?8lLyo7udk/kbyS7Kz5pNfDZE4BbfUWf5cT2z5FEY8bJm6P25udN7E30dzeAC?=
 =?us-ascii?Q?VhiYCsKp2hFlV8a4106CjEprarKg2f/JF5gxiuXzZrNixQNlzNzUX3RfRp1e?=
 =?us-ascii?Q?bqequc3msJxN9ytjhHu6wnuZqIkhukhGVPOA+6zw3o+McbAUUuTk0OzsKkat?=
 =?us-ascii?Q?LZkkhD63jEMW9rc2mHzWtizWZUVW7HsRgfxVBsPf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2kp84BZYY/oHy5JcfUp4SMkK6eNsGSUae5mDfGf6vLni/GVEyQIrQpJQlqNEUsKocxLdTlaD+ctWU7iUbL/guRfzJO29DFzWFwmYOHhcS3m1WudU2ldbf8RAZtgwZT8BKHEf1QwEqFHxk3difw7BTbx6SrpqrOrA7WTDLfrAq19c657x7N7CTEuqSZgcdfwIeDodofPMxPd31p2t2ojT6S4A7S3eZO7V7UzYdn5LyBfTCfnxIo10+voQ+bm30uSRUsL8i0uNfcKwVanbLIp3oOrCwVaRjsCrCbeEKztg4NMkpW04n/2ZxA5hA8NMg/Ssqj7t8TszxcOBj4YfkQoa6/GHCaBzTrqnEA6alF84eSSh00dETd3ibsWIu8IKeecj4rvaKOvSPG3csfOaouUn86NOETs+DJg7CBrYae4QRKYAUlRDtLtqT9cRVbrC5jh5T3sKZahUVu8pP3a+KSHAX+XyPB1XbQes6TQlmbu56WmJJ+ipYeppV5Xpa0arAhnbKteC8mm68nfT6ynfaPqUktptr2NYj5ei9u9BI5uMntApdV+EDIX3Or435A3C9PtHT3aD3FdUH2auBzGhN9S3iXhYD9Bj42gw8XwCrSXjOF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974abe76-f460-4cf3-abe8-08dc210d4bb9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 21:00:17.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hcgShjpeSsfsxnxwgwZyUXDmO94LI1fdNem+aTf/f4e2XwjM/1huDbQrYP645yAcjlse7JZQuZxpLDlDLN+Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_13,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290155
X-Proofpoint-ORIG-GUID: IIGgdu_bMTOWbFV4KqA0fMntT8Dv5j_U
X-Proofpoint-GUID: IIGgdu_bMTOWbFV4KqA0fMntT8Dv5j_U

* Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> Increments and loads to mmap_changing are always in mmap_lock
> critical section.

Read or write?


> This ensures that if userspace requests event
> notification for non-cooperative operations (e.g. mremap), userfaultfd
> operations don't occur concurrently.
> 
> This can be achieved by using a separate read-write semaphore in
> userfaultfd_ctx such that increments are done in write-mode and loads
> in read-mode, thereby eliminating the dependency on mmap_lock for this
> purpose.
> 
> This is a preparatory step before we replace mmap_lock usage with
> per-vma locks in fill/move ioctls.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  fs/userfaultfd.c              | 40 ++++++++++++----------
>  include/linux/userfaultfd_k.h | 31 ++++++++++--------
>  mm/userfaultfd.c              | 62 ++++++++++++++++++++---------------
>  3 files changed, 75 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 58331b83d648..c00a021bcce4 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  		ctx->flags = octx->flags;
>  		ctx->features = octx->features;
>  		ctx->released = false;
> +		init_rwsem(&ctx->map_changing_lock);
>  		atomic_set(&ctx->mmap_changing, 0);
>  		ctx->mm = vma->vm_mm;
>  		mmgrab(ctx->mm);
>  
>  		userfaultfd_ctx_get(octx);
> +		down_write(&octx->map_changing_lock);
>  		atomic_inc(&octx->mmap_changing);
> +		up_write(&octx->map_changing_lock);

This can potentially hold up your writer as the readers execute.  I
think this will change your priority (ie: priority inversion)?

You could use the first bit of the atomic_inc as indication of a write.
So if the mmap_changing is even, then there are no writers.  If it
didn't change and it's even then you know no modification has happened
(or it overflowed and hit the same number which would be rare, but
maybe okay?).

>  		fctx->orig = octx;
>  		fctx->new = ctx;
>  		list_add_tail(&fctx->list, fcs);
> @@ -737,7 +740,9 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
>  		vm_ctx->ctx = ctx;
>  		userfaultfd_ctx_get(ctx);
> +		down_write(&ctx->map_changing_lock);
>  		atomic_inc(&ctx->mmap_changing);
> +		up_write(&ctx->map_changing_lock);
>  	} else {
>  		/* Drop uffd context if remap feature not enabled */
>  		vma_start_write(vma);
> @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
>  		return true;
>  
>  	userfaultfd_ctx_get(ctx);
> +	down_write(&ctx->map_changing_lock);
>  	atomic_inc(&ctx->mmap_changing);
> +	up_write(&ctx->map_changing_lock);
>  	mmap_read_unlock(mm);
>  
>  	msg_init(&ewq.msg);
> @@ -825,7 +832,9 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma, unsigned long start,
>  		return -ENOMEM;
>  
>  	userfaultfd_ctx_get(ctx);
> +	down_write(&ctx->map_changing_lock);
>  	atomic_inc(&ctx->mmap_changing);
> +	up_write(&ctx->map_changing_lock);
>  	unmap_ctx->ctx = ctx;
>  	unmap_ctx->start = start;
>  	unmap_ctx->end = end;
> @@ -1709,9 +1718,8 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>  	if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
>  		flags |= MFILL_ATOMIC_WP;
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
> -					uffdio_copy.len, &ctx->mmap_changing,
> -					flags);
> +		ret = mfill_atomic_copy(ctx, uffdio_copy.dst, uffdio_copy.src,
> +					uffdio_copy.len, flags);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1761,9 +1769,8 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
>  		goto out;
>  
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mfill_atomic_zeropage(ctx->mm, uffdio_zeropage.range.start,
> -					   uffdio_zeropage.range.len,
> -					   &ctx->mmap_changing);
> +		ret = mfill_atomic_zeropage(ctx, uffdio_zeropage.range.start,
> +					   uffdio_zeropage.range.len);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1818,9 +1825,8 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>  		return -EINVAL;
>  
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mwriteprotect_range(ctx->mm, uffdio_wp.range.start,
> -					  uffdio_wp.range.len, mode_wp,
> -					  &ctx->mmap_changing);
> +		ret = mwriteprotect_range(ctx, uffdio_wp.range.start,
> +					  uffdio_wp.range.len, mode_wp);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1870,9 +1876,8 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
>  		flags |= MFILL_ATOMIC_WP;
>  
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mfill_atomic_continue(ctx->mm, uffdio_continue.range.start,
> -					    uffdio_continue.range.len,
> -					    &ctx->mmap_changing, flags);
> +		ret = mfill_atomic_continue(ctx, uffdio_continue.range.start,
> +					    uffdio_continue.range.len, flags);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1925,9 +1930,8 @@ static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long
>  		goto out;
>  
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mfill_atomic_poison(ctx->mm, uffdio_poison.range.start,
> -					  uffdio_poison.range.len,
> -					  &ctx->mmap_changing, 0);
> +		ret = mfill_atomic_poison(ctx, uffdio_poison.range.start,
> +					  uffdio_poison.range.len, 0);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -2003,13 +2007,14 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
>  	if (mmget_not_zero(mm)) {
>  		mmap_read_lock(mm);
>  
> -		/* Re-check after taking mmap_lock */
> +		/* Re-check after taking map_changing_lock */
> +		down_read(&ctx->map_changing_lock);
>  		if (likely(!atomic_read(&ctx->mmap_changing)))
>  			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
>  					 uffdio_move.len, uffdio_move.mode);
>  		else
>  			ret = -EAGAIN;
> -
> +		up_read(&ctx->map_changing_lock);
>  		mmap_read_unlock(mm);
>  		mmput(mm);
>  	} else {
> @@ -2216,6 +2221,7 @@ static int new_userfaultfd(int flags)
>  	ctx->flags = flags;
>  	ctx->features = 0;
>  	ctx->released = false;
> +	init_rwsem(&ctx->map_changing_lock);
>  	atomic_set(&ctx->mmap_changing, 0);
>  	ctx->mm = current->mm;
>  	/* prevent the mm struct to be freed */
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 691d928ee864..3210c3552976 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -69,6 +69,13 @@ struct userfaultfd_ctx {
>  	unsigned int features;
>  	/* released */
>  	bool released;
> +	/*
> +	 * Prevents userfaultfd operations (fill/move/wp) from happening while
> +	 * some non-cooperative event(s) is taking place. Increments are done
> +	 * in write-mode. Whereas, userfaultfd operations, which includes
> +	 * reading mmap_changing, is done under read-mode.
> +	 */
> +	struct rw_semaphore map_changing_lock;
>  	/* memory mappings are changing because of non-cooperative event */
>  	atomic_t mmap_changing;
>  	/* mm with one ore more vmas attached to this userfaultfd_ctx */
> @@ -113,22 +120,18 @@ extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
>  				    unsigned long dst_addr, struct page *page,
>  				    bool newly_allocated, uffd_flags_t flags);
>  
> -extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
> +extern ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  				 unsigned long src_start, unsigned long len,
> -				 atomic_t *mmap_changing, uffd_flags_t flags);
> -extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
> +				 uffd_flags_t flags);
> +extern ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
>  				     unsigned long dst_start,
> -				     unsigned long len,
> -				     atomic_t *mmap_changing);
> -extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
> -				     unsigned long len, atomic_t *mmap_changing,
> -				     uffd_flags_t flags);
> -extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
> -				   unsigned long len, atomic_t *mmap_changing,
> -				   uffd_flags_t flags);
> -extern int mwriteprotect_range(struct mm_struct *dst_mm,
> -			       unsigned long start, unsigned long len,
> -			       bool enable_wp, atomic_t *mmap_changing);
> +				     unsigned long len);
> +extern ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> +				     unsigned long len, uffd_flags_t flags);
> +extern ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
> +				   unsigned long len, uffd_flags_t flags);
> +extern int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
> +			       unsigned long len, bool enable_wp);
>  extern long uffd_wp_range(struct vm_area_struct *vma,
>  			  unsigned long start, unsigned long len, bool enable_wp);
>  
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e3a91871462a..6e2ca04ab04d 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -353,11 +353,11 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
>   * called with mmap_lock held, it will release mmap_lock before returning.
>   */
>  static __always_inline ssize_t mfill_atomic_hugetlb(
> +					      struct userfaultfd_ctx *ctx,
>  					      struct vm_area_struct *dst_vma,
>  					      unsigned long dst_start,
>  					      unsigned long src_start,
>  					      unsigned long len,
> -					      atomic_t *mmap_changing,
>  					      uffd_flags_t flags)
>  {
>  	struct mm_struct *dst_mm = dst_vma->vm_mm;
> @@ -379,6 +379,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 * feature is not supported.
>  	 */
>  	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> +		up_read(&ctx->map_changing_lock);
>  		mmap_read_unlock(dst_mm);
>  		return -EINVAL;
>  	}
> @@ -463,6 +464,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  		cond_resched();
>  
>  		if (unlikely(err == -ENOENT)) {
> +			up_read(&ctx->map_changing_lock);
>  			mmap_read_unlock(dst_mm);
>  			BUG_ON(!folio);
>  
> @@ -473,12 +475,13 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  				goto out;
>  			}
>  			mmap_read_lock(dst_mm);
> +			down_read(&ctx->map_changing_lock);
>  			/*
>  			 * If memory mappings are changing because of non-cooperative
>  			 * operation (e.g. mremap) running in parallel, bail out and
>  			 * request the user to retry later
>  			 */
> -			if (mmap_changing && atomic_read(mmap_changing)) {
> +			if (atomic_read(ctx->mmap_changing)) {
>  				err = -EAGAIN;
>  				break;
>  			}
> @@ -501,6 +504,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	}
>  
>  out_unlock:
> +	up_read(&ctx->map_changing_lock);
>  	mmap_read_unlock(dst_mm);
>  out:
>  	if (folio)
> @@ -512,11 +516,11 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  }
>  #else /* !CONFIG_HUGETLB_PAGE */
>  /* fail at build time if gcc attempts to use this */
> -extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
> +extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
> +				    struct vm_area_struct *dst_vma,
>  				    unsigned long dst_start,
>  				    unsigned long src_start,
>  				    unsigned long len,
> -				    atomic_t *mmap_changing,
>  				    uffd_flags_t flags);
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
> @@ -564,13 +568,13 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
>  	return err;
>  }
>  
> -static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
> +static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  					    unsigned long dst_start,
>  					    unsigned long src_start,
>  					    unsigned long len,
> -					    atomic_t *mmap_changing,
>  					    uffd_flags_t flags)
>  {
> +	struct mm_struct *dst_mm = ctx->mm;
>  	struct vm_area_struct *dst_vma;
>  	ssize_t err;
>  	pmd_t *dst_pmd;
> @@ -600,8 +604,9 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  	 * operation (e.g. mremap) running in parallel, bail out and
>  	 * request the user to retry later
>  	 */
> +	down_read(&ctx->map_changing_lock);
>  	err = -EAGAIN;
> -	if (mmap_changing && atomic_read(mmap_changing))
> +	if (atomic_read(&ctx->mmap_changing))
>  		goto out_unlock;
>  
>  	/*
> @@ -633,8 +638,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  	 * If this is a HUGETLB vma, pass off to appropriate routine
>  	 */
>  	if (is_vm_hugetlb_page(dst_vma))
> -		return  mfill_atomic_hugetlb(dst_vma, dst_start, src_start,
> -					     len, mmap_changing, flags);
> +		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
> +					     src_start, len, flags);
>  
>  	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
>  		goto out_unlock;
> @@ -693,6 +698,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  		if (unlikely(err == -ENOENT)) {
>  			void *kaddr;
>  
> +			up_read(&ctx->map_changing_lock);
>  			mmap_read_unlock(dst_mm);
>  			BUG_ON(!folio);
>  
> @@ -723,6 +729,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  	}
>  
>  out_unlock:
> +	up_read(&ctx->map_changing_lock);
>  	mmap_read_unlock(dst_mm);
>  out:
>  	if (folio)
> @@ -733,34 +740,33 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  	return copied ? copied : err;
>  }
>  
> -ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
> +ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  			  unsigned long src_start, unsigned long len,
> -			  atomic_t *mmap_changing, uffd_flags_t flags)
> +			  uffd_flags_t flags)
>  {
> -	return mfill_atomic(dst_mm, dst_start, src_start, len, mmap_changing,
> +	return mfill_atomic(ctx, dst_start, src_start, len,
>  			    uffd_flags_set_mode(flags, MFILL_ATOMIC_COPY));
>  }
>  
> -ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
> -			      unsigned long len, atomic_t *mmap_changing)
> +ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
> +			      unsigned long start,
> +			      unsigned long len)
>  {
> -	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> +	return mfill_atomic(ctx, start, 0, len,
>  			    uffd_flags_set_mode(0, MFILL_ATOMIC_ZEROPAGE));
>  }
>  
> -ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
> -			      unsigned long len, atomic_t *mmap_changing,
> -			      uffd_flags_t flags)
> +ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long start,
> +			      unsigned long len, uffd_flags_t flags)
>  {
> -	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> +	return mfill_atomic(ctx, start, 0, len,
>  			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
>  }
>  
> -ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
> -			    unsigned long len, atomic_t *mmap_changing,
> -			    uffd_flags_t flags)
> +ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
> +			    unsigned long len, uffd_flags_t flags)
>  {
> -	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> +	return mfill_atomic(ctx, start, 0, len,
>  			    uffd_flags_set_mode(flags, MFILL_ATOMIC_POISON));
>  }
>  
> @@ -793,10 +799,10 @@ long uffd_wp_range(struct vm_area_struct *dst_vma,
>  	return ret;
>  }
>  
> -int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> -			unsigned long len, bool enable_wp,
> -			atomic_t *mmap_changing)
> +int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
> +			unsigned long len, bool enable_wp)
>  {
> +	struct mm_struct *dst_mm = ctx->mm;
>  	unsigned long end = start + len;
>  	unsigned long _start, _end;
>  	struct vm_area_struct *dst_vma;
> @@ -820,8 +826,9 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  	 * operation (e.g. mremap) running in parallel, bail out and
>  	 * request the user to retry later
>  	 */
> +	down_read(&ctx->map_changing_lock);
>  	err = -EAGAIN;
> -	if (mmap_changing && atomic_read(mmap_changing))
> +	if (atomic_read(&ctx->mmap_changing))
>  		goto out_unlock;
>  
>  	err = -ENOENT;
> @@ -850,6 +857,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  		err = 0;
>  	}
>  out_unlock:
> +	up_read(&ctx->map_changing_lock);
>  	mmap_read_unlock(dst_mm);
>  	return err;
>  }
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 
> 

