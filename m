Return-Path: <linux-fsdevel+bounces-529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109567CC554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EDB281195
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B3143A88;
	Tue, 17 Oct 2023 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RNTqD1Td";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XZP9WYTH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803D436AA;
	Tue, 17 Oct 2023 13:58:08 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540A131;
	Tue, 17 Oct 2023 06:58:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HCrqV1013879;
	Tue, 17 Oct 2023 13:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Q17Igu5oXWZqYAtIWp9B9NOu7/zNbensKDhhMwI/otk=;
 b=RNTqD1TdLBJNoE46gx9SlCMwuz8sepDMK3DN5LGAJ6FSuifPQlIedKmbW60BO9dcKM92
 4um47A0Iyj1cNDLUowy3ho3YCg2O4AeJDL4IHHPeXyhiP+UFlM2b4EUDWrd7T3t/Yaw3
 NNBSvxwpA3mIKARvSr2arq1T1xxuh7DIJzlwLvhSxL9YSWw2MBXgYzuY8vAOjhf9yaoI
 7jQRU/+kN9ylRSqMmBJralHTKCd4cM8G/khfvXeweaqQinAZ6O+c7seviMyDkdGNBUB9
 K/AH/8Kv03fZuE3zCvhVAscXoibtaZaHz93MamTnA7GyVi3qJpLyxs7C+ZysmV0m9BQ/ nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28n9d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 13:57:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HDeX1u010606;
	Tue, 17 Oct 2023 13:57:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0mu16e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 13:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3TUUA3xbKi6V0QGVu/EqPXnyfZaxUUVNmzMMcEZFnado0OEj38imXHnl/5YUxtdwNK8d5w08b6ZH54To3F/sBLc8cBCMYv0DR1+IOLPqYKreNbMStfhMawS3ZcTrlMIYxEiWrG/golIyvQVv89TTP1IW4hTrcvPVX9hnBg32crYCGhsbKjMa3IhTurchdZR8BMc/pcKmuf4irBn7lgDmzBVMleSUCJiURjkJEuVB8mMSRIbyhrnUAuEBP8q0gkLrPhNLD7ecRulRcyJqHnOvh2bf7pN5Kszw/Utl6kg5Fd6KzyYw3TBVW4fL60SnqA4a1gqPkDd6Y7TXrLFKz6z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q17Igu5oXWZqYAtIWp9B9NOu7/zNbensKDhhMwI/otk=;
 b=bC/oE+tgTdVrpQwwnUrFJNRGIxIiCeV+rKMEMOLltfcyj9mqHWS48KB8fILZVaS8cssn4sOeXXYxpFl+nr2vHEm9Q/uHyJOY4wPtRZvcrBjm+LoaESM/LlGqFmC5G1K4r/n3AYofVCfBPVo7HYfYMmi6dRIcFuWynl8SjssXILui1XxBjsjpBlHDtlYX1AGPSZoX7f45r5nWPoY4V+uvltnDY2Bkc2hIQKMF0lcq4fgpGqa23oB1ujPlwEsHhLDpCosarINTldv8DASkD5dgzV0cXB4QyAobuiTvisNVaCT+BPXSMRGxooJ4UOkg2bAbtl9MBI7mFx6fHgB6iV2VuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q17Igu5oXWZqYAtIWp9B9NOu7/zNbensKDhhMwI/otk=;
 b=XZP9WYTHC5A+To5c8MtNkZO4bupfhT4HNqSTVv8KDvMAmAYE5zBXbBqsmum6SPqtskUK8vUdR5okZVngOrwzgbGEdqThy1ysfUHNLdrhhIkGF7jHhIzmVKhXbenSAGXNBliBrZ6eKC5XXUjk1Wf0gCp9QFWSsZ2c7KVEEA8DV+4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6545.namprd10.prod.outlook.com (2603:10b6:806:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 13:57:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 13:57:21 +0000
Date: Tue, 17 Oct 2023 09:57:17 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <20231017135717.2iipnd37pgaswzdc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
	akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
	surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com, npiggin@gmail.com,
	peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
 <20231016032226.59199-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016032226.59199-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0328.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: e32a1337-7a0d-447e-52db-08dbcf18fbbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FbDKeEaPK7QVqAvUwL3KHzVq0XO9n16LlEjcYkaRFoWMCtitgG2qVWTZpQuc3wy2Tu4gBdpzdSSjKhKV3wOhiaf81Rdyg9i/nX2ErhZJQLJWWUbY8JhPOlpgvYWWmzAWRz6Gpmbyq9+ovdkXP7KLSCPGNgGvH8af0K6CZXr/K6eCBpPOczr2ZqFu82LXQDoct1PYrA+Qm52lhwsGeKlQbomf3SfcTVlXLyKMn065TAjUg5P2kBRBuBZNgtmM6p9VmTbSisvOOuv04LeEMZ3/vbSCJSvuei1icbuulN7pHx19NnfMLCJANuavCBQioltlmsLWq8EURdtgMgPU8L8yhKv9MKR6DZO+xdpK1x/nFqyRuRh2Ugqmcqw+aNtCqHI5tV3Ciw+DU8rxPoS6ehvCfGwtlKIwj6pXud4MkUrfdPjVvBkrYQByBsof/Fh7BlBYIc3LLvSn1eQnpvUXj6ICPT/xrGa+iZGay4SWWzYNhLXLptdB+Fvwp8o/zOgmnZFVrgZCR6Wry+1welZ3pDOt0DDDE8jPTXvUqIBpLWXJlEnzEEjaBven4gdPlgXE0XdayN+JLTc+0z/RbSZiLC5LrSizcd1eb+w+VXrTipZ5iqs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6506007)(5660300002)(1076003)(2906002)(26005)(83380400001)(30864003)(38100700002)(86362001)(33716001)(6666004)(9686003)(6512007)(7416002)(6486002)(966005)(41300700001)(66476007)(66556008)(6916009)(316002)(66946007)(8936002)(4326008)(8676002)(478600001)(404934003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C1htRLlkOcOuT3zObA25bJILgxA8vqROdky17XapinQFnyZh0cKiGm1N7dpU?=
 =?us-ascii?Q?QNr89PB2EKY6kDg/Cp30KUbDyH7mFyU/rFGy1N8ORiTL8zwrzA5/zJi4kdqU?=
 =?us-ascii?Q?mTYFY90+V5vjbNuRWHxRZEasGLPu2LxoGvrZR75sz4HDsP2PAT2y84T5M1vw?=
 =?us-ascii?Q?MvrW7yxmJl6BTfQLex120lJfIl8iGVSM3PJmI2C/Hu9eC7NQotx0pRrQ5cne?=
 =?us-ascii?Q?gbvchG/+/s2feWF7e4HQg9s/J1HxDsPgNoRo7oSylxO3Wd8v1loHBZuVD4cB?=
 =?us-ascii?Q?6tgA/15bJuJh5UKWorDO4vsZdPL/2tSsMRr6RxXRsOHcuKFbWmLCP+vGf4tI?=
 =?us-ascii?Q?O1TxjVwKQaC2uvtbtNIimQUrWKjpm7g2ONmpK1lJYxYKA8H5s9UZLaA6MjTF?=
 =?us-ascii?Q?c+1mSsiCWwfHj0PbIad4OWLNI5h059oaak88hu92d9qqfmL2BNnZ5sQZiD4G?=
 =?us-ascii?Q?g9MUDG5Oyn9i3o1pPXYJ4Yv/G6B8yXjdSW4kuexBK7LWAvmEIBUz7p050IMj?=
 =?us-ascii?Q?o8YzG98zfTvFqcep5r4T6RcBTXlTQONWP4gx7CZoa0zQy3BPsqz7F+G2nEZ7?=
 =?us-ascii?Q?kDvb0VD/FFbIXwSIQgEHzc8vcQw87sYyYzYL0CTXWV3590lwQKmxBV7towK4?=
 =?us-ascii?Q?FEpBu8CN93fBqHQmuFzjxk0PstDvRs+t/rRsdFqgQoxx37M8spUm0F1cxqeM?=
 =?us-ascii?Q?NWXhP0c3UYSVl1m7NVR7u+tOI9o+6Eg5Om0gfdoI8mbX57s8Z76pDiJ+xyG0?=
 =?us-ascii?Q?3KxHrlNkpyxtmwHB2x2UofHj4RyHAzYhUZdH6DyhgQm+ReRQITKb1xxLrrF4?=
 =?us-ascii?Q?3Ms4RBPmAOLKK8u0Z3fcKQNyP+z523C2n3VlQ3slDG5a+nh+pWdXYgN18d9m?=
 =?us-ascii?Q?Rdbppzf1iSA7lzHwEvouq8gaBCzssVeDaiLdWchOZE8myfRptjM0czghzXm7?=
 =?us-ascii?Q?VmT/7gHdFIALIK1nBpPwC3oEGSnfBzcLazTrFS3FfId6d3tLKasbTjU6OX3r?=
 =?us-ascii?Q?+fwAndXpqePcW3YjNRvl2Z66fqdUzMIHE2VGJbmgZQLkrzYGsivjyUKTLRvt?=
 =?us-ascii?Q?WlXoXPRJ4gj1g1KeDmG3WBOi4QsjzOjFz2E1vBN6IBJNhodENOBOHWH3JRfX?=
 =?us-ascii?Q?NULOxk0hjfiYsQ0bvWb8Nhz8lk1oB4zv7Aa9gYrr3eXQQmc8BMa1/QovQVR6?=
 =?us-ascii?Q?H2OLd3FV4Co2Aa626KSW+xcEMI1L/N38wWOrQ3+uBv7A3hZ77MmFYSZzk5de?=
 =?us-ascii?Q?qhdCE3bUo69u5dfw8nowWapomvP18HjsfWikEfMbR3Zem+DRTN3odeEmAX4j?=
 =?us-ascii?Q?U54TuMjdu3zOGrc4EBt3cwGzg1ErS41tO2H8bvE5MW2eWkdhXsjOBRCvWpPM?=
 =?us-ascii?Q?D8RYO9muqpVfYcAFmDYO19VFwOdyHxAKu7Te57lTHeP7G7s7JG7rfzbcB6q5?=
 =?us-ascii?Q?fpO9r/R2L2VpfeTPNhvzlMuM4ox1HJdDJ1MbxlLDP1ztNB9o9jmy8jKu5FpI?=
 =?us-ascii?Q?sUwYeCFkgvem7ZTZkXhGeLI56oTPF2grvGOyW7lyX6DVWo45LL6Jw0DRTUC1?=
 =?us-ascii?Q?oqvgZrfwcWswBGLOLb83p+jqqb7ScrB8uTKgI4NM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?LMqTj7dyA4yqh29TnRDwQu2THJxHYjS+p6onfwHHHp+Gd+Eei07VLZmkOpPQ?=
 =?us-ascii?Q?23YyE6gO8ueGTPDJL4inUijNBc6Cy+jEpMlEsmGaep+0asbs4GPH3OOimZKI?=
 =?us-ascii?Q?KWvyTqBnRHvI/0Hv5UKNAHNaGToGDCeHhP5d0mQ7PfZG8WvFZoRf5axDncMH?=
 =?us-ascii?Q?0qgMWaLoyNDs5elwn/M7E9ao3niROQz28dK+ZoRfqfD5lzh+SsNeMj93dATL?=
 =?us-ascii?Q?n27Q4z2yZuZmm8NWE5Xy73mQpw4uxwQVfIDKkoI+fSw4YCQkSK0eD/raWKvn?=
 =?us-ascii?Q?hOttGmazUzvKMxLl4HcxR54fWuNg0xbmRc4RpPq/SsNmh0YRl/fMv9qovTLz?=
 =?us-ascii?Q?t1ILx/EHveJb//VDRtYG/30bQcAP84eoLFpqJHkqsx/jbgTNGKIBOS5f07oD?=
 =?us-ascii?Q?VIgcm1K4dpiR9Ba9hUkNcBUKglGa96eJ6vAvMRRsupes+zhRtAvw11iR1zMy?=
 =?us-ascii?Q?9BkC80T5Aeg2uCDugYB80WbKc1/RFcAC/m4T/s25gbXvfpbyQkMO2kRnLRnQ?=
 =?us-ascii?Q?5avP6zpWrsxsK9qOVPH2OmfnuI0aFqmBTQLFXO2u0AyIcsrPE1/Rww3O+ydC?=
 =?us-ascii?Q?E8lNvVDGtCYwMvza8f45ghQjBBzSEnSRICCEuSvTeptyLfkhwva0Rw0pJaOt?=
 =?us-ascii?Q?aeHnIw8Sa0EtIX1BEfcaxWpm4KCALeBFxD94TUPmqaqfRoFVqiirg4cLt2tE?=
 =?us-ascii?Q?nMwCJo1Ol0rppuDvfeFTlhEl3f0c00BnGoNlBoD29YQIb1mhW6nVIAI72Dpy?=
 =?us-ascii?Q?iaVOX044Yb9Zf5otIZjXcMiSJPcUYZkk/GTGHhezxTAbSzk+1LRIhOzkEM1B?=
 =?us-ascii?Q?YlC1wdnJJeVvdmhrwzHfMljuEiwNN6KMqOdpnViYRfCwSorCfv9BEJQAZRfC?=
 =?us-ascii?Q?AsSCOchGV1i70mKViqGxSr9eYy0BjGwvQfXM7OR2C2LpkAMzuxfnaZObVfAK?=
 =?us-ascii?Q?qRXuVxEua4KRVHPCt54hNiVk3Jl9GPdj2NB7fYe3f0SGQrKOa8+yqwW1lHzX?=
 =?us-ascii?Q?aeB4wFK5oqGTk2aevR+HRA2PDCVKp/kOgbt2/O52NCrt6JIdQdEPA+k/EG1x?=
 =?us-ascii?Q?sM0sOFi6WSdPNEKQpMpKzNa6mxVaAIBCIo3Jsti+O92SSS9rTGozTNUx0S8/?=
 =?us-ascii?Q?atg58IcwwvzkJb3i6PtUKmpKHz1E8L8QEe0puMCh0Bg/ZI3SHnn/kdA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32a1337-7a0d-447e-52db-08dbcf18fbbf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 13:57:21.4632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwPTw0ltZI3LJXs3e/3vYV7bpGaT43KwMyg4V6gI/EZUmEysrVw2w2roueu8qBw/c+ICcsLXBkDUgiVDSOwVrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170118
X-Proofpoint-ORIG-GUID: 3z3IqLS5oXAXNkVoXm0donyHsHFNsySi
X-Proofpoint-GUID: 3z3IqLS5oXAXNkVoXm0donyHsHFNsySi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* Peng Zhang <zhangpeng.00@bytedance.com> [231015 23:23]:
> Introduce interfaces __mt_dup() and mtree_dup(), which are used to
> duplicate a maple tree. They duplicate a maple tree in Depth-First
> Search (DFS) pre-order traversal. It uses memcopy() to copy nodes in the
> source tree and allocate new child nodes in non-leaf nodes. The new node
> is exactly the same as the source node except for all the addresses
> stored in it. It will be faster than traversing all elements in the
> source tree and inserting them one by one into the new tree. The time
> complexity of these two functions is O(n).
> 
> The difference between __mt_dup() and mtree_dup() is that mtree_dup()
> handles locks internally.
> 
> Analysis of the average time complexity of this algorithm:
> 
> For simplicity, let's assume that the maximum branching factor of all
> non-leaf nodes is 16 (in allocation mode, it is 10), and the tree is a
> full tree.
> 
> Under the given conditions, if there is a maple tree with n elements,
> the number of its leaves is n/16. From bottom to top, the number of
> nodes in each level is 1/16 of the number of nodes in the level below.
> So the total number of nodes in the entire tree is given by the sum of
> n/16 + n/16^2 + n/16^3 + ... + 1. This is a geometric series, and it has
> log(n) terms with base 16. According to the formula for the sum of a
> geometric series, the sum of this series can be calculated as (n-1)/15.
> Each node has only one parent node pointer, which can be considered as
> an edge. In total, there are (n-1)/15-1 edges.
> 
> This algorithm consists of two operations:
> 
> 1. Traversing all nodes in DFS order.
> 2. For each node, making a copy and performing necessary modifications
>    to create a new node.
> 
> For the first part, DFS traversal will visit each edge twice. Let
> T(ascend) represent the cost of taking one step downwards, and
> T(descend) represent the cost of taking one step upwards. And both of
> them are constants (although mas_ascend() may not be, as it contains a
> loop, but here we ignore it and treat it as a constant). So the time
> spent on the first part can be represented as
> ((n-1)/15-1) * (T(ascend) + T(descend)).
> 
> For the second part, each node will be copied, and the cost of copying a
> node is denoted as T(copy_node). For each non-leaf node, it is necessary
> to reallocate all child nodes, and the cost of this operation is denoted
> as T(dup_alloc). The behavior behind memory allocation is complex and
> not specific to the maple tree operation. Here, we assume that the time
> required for a single allocation is constant. Since the size of a node
> is fixed, both of these symbols are also constants. We can calculate
> that the time spent on the second part is
> ((n-1)/15) * T(copy_node) + ((n-1)/15 - n/16) * T(dup_alloc).
> 
> Adding both parts together, the total time spent by the algorithm can be
> represented as:
> 
> ((n-1)/15) * (T(ascend) + T(descend) + T(copy_node) + T(dup_alloc)) -
> n/16 * T(dup_alloc) - (T(ascend) + T(descend))
> 
> Let C1 = T(ascend) + T(descend) + T(copy_node) + T(dup_alloc)
> Let C2 = T(dup_alloc)
> Let C3 = T(ascend) + T(descend)
> 
> Finally, the expression can be simplified as:
> ((16 * C1 - 15 * C2) / (15 * 16)) * n - (C1 / 15 + C3).
> 
> This is a linear function, so the average time complexity is O(n).
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/maple_tree.h |   3 +
>  lib/maple_tree.c           | 290 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 293 insertions(+)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index f91dbc7fe091..a452dd8a1e5c 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -329,6 +329,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
>  		void *entry, gfp_t gfp);
>  void *mtree_erase(struct maple_tree *mt, unsigned long index);
>  
> +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
> +
>  void mtree_destroy(struct maple_tree *mt);
>  void __mt_destroy(struct maple_tree *mt);
>  
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index ca7039633844..6e0ad83f14e3 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4,6 +4,10 @@
>   * Copyright (c) 2018-2022 Oracle Corporation
>   * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
>   *	    Matthew Wilcox <willy@infradead.org>
> + *
> + * Algorithm for duplicating Maple Tree
> + * Copyright (c) 2023 ByteDance
> + * Author: Peng Zhang <zhangpeng.00@bytedance.com>
>   */
>  
>  /*
> @@ -6475,6 +6479,292 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
>  }
>  EXPORT_SYMBOL(mtree_erase);
>  
> +/*
> + * mas_dup_free() - Free an incomplete duplication of a tree.
> + * @mas: The maple state of a incomplete tree.
> + *
> + * The parameter @mas->node passed in indicates that the allocation failed on
> + * this node. This function frees all nodes starting from @mas->node in the
> + * reverse order of mas_dup_build(). There is no need to hold the source tree
> + * lock at this time.
> + */
> +static void mas_dup_free(struct ma_state *mas)
> +{
> +	struct maple_node *node;
> +	enum maple_type type;
> +	void __rcu **slots;
> +	unsigned char count, i;
> +
> +	/* Maybe the first node allocation failed. */
> +	if (mas_is_none(mas))
> +		return;
> +
> +	while (!mte_is_root(mas->node)) {
> +		mas_ascend(mas);
> +

Please watch the extra whitespace.  There are a few in this patch.

> +		if (mas->offset) {
> +			mas->offset--;
> +			do {
> +				mas_descend(mas);
> +				mas->offset = mas_data_end(mas);
> +			} while (!mte_is_leaf(mas->node));
> +
> +			mas_ascend(mas);
> +		}
> +
> +		node = mte_to_node(mas->node);
> +		type = mte_node_type(mas->node);
> +		slots = ma_slots(node, type);
> +		count = mas_data_end(mas) + 1;
> +		for (i = 0; i < count; i++)
> +			((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
> +
> +		mt_free_bulk(count, slots);
> +	}
> +
> +	node = mte_to_node(mas->node);
> +	mt_free_one(node);
> +}
> +
> +/*
> + * mas_copy_node() - Copy a maple node and replace the parent.
> + * @mas: The maple state of source tree.
> + * @new_mas: The maple state of new tree.
> + * @parent: The parent of the new node.
> + *
> + * Copy @mas->node to @new_mas->node, set @parent to be the parent of
> + * @new_mas->node. If memory allocation fails, @mas is set to -ENOMEM.
> + */
> +static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
> +		struct maple_pnode *parent)
> +{
> +	struct maple_node *node = mte_to_node(mas->node);
> +	struct maple_node *new_node = mte_to_node(new_mas->node);
> +	unsigned long val;
> +
> +	/* Copy the node completely. */
> +	memcpy(new_node, node, sizeof(struct maple_node));
> +
> +	/* Update the parent node pointer. */
> +	val = (unsigned long)node->parent & MAPLE_NODE_MASK;
> +	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
> +}
> +
> +/*
> + * mas_dup_alloc() - Allocate child nodes for a maple node.
> + * @mas: The maple state of source tree.
> + * @new_mas: The maple state of new tree.
> + * @gfp: The GFP_FLAGS to use for allocations.
> + *
> + * This function allocates child nodes for @new_mas->node during the duplication
> + * process. If memory allocation fails, @mas is set to -ENOMEM.
> + */
> +static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
> +		gfp_t gfp)
> +{
> +	struct maple_node *node = mte_to_node(mas->node);
> +	struct maple_node *new_node = mte_to_node(new_mas->node);
> +	enum maple_type type;
> +	unsigned char request, count, i;
> +	void __rcu **slots;
> +	void __rcu **new_slots;
> +	unsigned long val;
> +
> +	/* Allocate memory for child nodes. */
> +	type = mte_node_type(mas->node);
> +	new_slots = ma_slots(new_node, type);
> +	request = mas_data_end(mas) + 1;
> +	count = mt_alloc_bulk(gfp, request, (void **)new_slots);
> +	if (unlikely(count < request)) {
> +		if (count)
> +			mt_free_bulk(count, new_slots);

We were dropping this mt_free_bulk() call as discussed in [1].  Did I
miss something?

> +
> +		memset(new_slots, 0, request * sizeof(void *));
> +		mas_set_err(mas, -ENOMEM);
> +		return;
> +	}
> +
> +	/* Restore node type information in slots. */
> +	slots = ma_slots(node, type);
> +	for (i = 0; i < count; i++) {
> +		val = (unsigned long)mt_slot_locked(mas->tree, slots, i);
> +		val &= MAPLE_NODE_MASK;
> +		((unsigned long *)new_slots)[i] |= val;
> +	}
> +}
> +
> +/*
> + * mas_dup_build() - Build a new maple tree from a source tree
> + * @mas: The maple state of source tree, need to be in MAS_START state.
> + * @new_mas: The maple state of new tree, need to be in MAS_START state.
> + * @gfp: The GFP_FLAGS to use for allocations.
> + *
> + * This function builds a new tree in DFS preorder. If the memory allocation
> + * fails, the error code -ENOMEM will be set in @mas, and @new_mas points to the
> + * last node. mas_dup_free() will free the incomplete duplication of a tree.
> + *
> + * Note that the attributes of the two trees need to be exactly the same, and the
> + * new tree needs to be empty, otherwise -EINVAL will be set in @mas.
> + */
> +static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
> +		gfp_t gfp)
> +{
> +	struct maple_node *node;
> +	struct maple_pnode *parent = NULL;
> +	struct maple_enode *root;
> +	enum maple_type type;
> +
> +	if (unlikely(mt_attr(mas->tree) != mt_attr(new_mas->tree)) ||
> +	    unlikely(!mtree_empty(new_mas->tree))) {
> +		mas_set_err(mas, -EINVAL);
> +		return;
> +	}
> +
> +	mas_start(mas);
> +	if (mas_is_ptr(mas) || mas_is_none(mas)) {
> +		root = mt_root_locked(mas->tree);

mas_start(mas) would return the root entry if it's a pointer and NULL if
the tree is empty, so this can be written:
root = mas_start(mas);
if (mas_is_ptry() || mas_is_none()
	goto set_new_tree;


> +		goto set_new_tree;
> +	}
> +
> +	node = mt_alloc_one(gfp);
> +	if (!node) {
> +		new_mas->node = MAS_NONE;
> +		mas_set_err(mas, -ENOMEM);
> +		return;
> +	}
> +
> +	type = mte_node_type(mas->node);
> +	root = mt_mk_node(node, type);
> +	new_mas->node = root;
> +	new_mas->min = 0;
> +	new_mas->max = ULONG_MAX;
> +	root = mte_mk_root(root);
> +
> +	while (1) {
> +		mas_copy_node(mas, new_mas, parent);
> +
> +		if (!mte_is_leaf(mas->node)) {
> +			/* Only allocate child nodes for non-leaf nodes. */
> +			mas_dup_alloc(mas, new_mas, gfp);
> +			if (unlikely(mas_is_err(mas)))
> +				return;
> +		} else {
> +			/*
> +			 * This is the last leaf node and duplication is
> +			 * completed.
> +			 */
> +			if (mas->max == ULONG_MAX)
> +				goto done;
> +
> +			/* This is not the last leaf node and needs to go up. */
> +			do {
> +				mas_ascend(mas);
> +				mas_ascend(new_mas);
> +			} while (mas->offset == mas_data_end(mas));
> +
> +			/* Move to the next subtree. */
> +			mas->offset++;
> +			new_mas->offset++;
> +		}
> +
> +		mas_descend(mas);
> +		parent = ma_parent_ptr(mte_to_node(new_mas->node));
> +		mas_descend(new_mas);
> +		mas->offset = 0;
> +		new_mas->offset = 0;
> +	}
> +done:
> +	/* Specially handle the parent of the root node. */
> +	mte_to_node(root)->parent = ma_parent_ptr(mas_tree_parent(new_mas));
> +set_new_tree:
> +	/* Make them the same height */
> +	new_mas->tree->ma_flags = mas->tree->ma_flags;
> +	rcu_assign_pointer(new_mas->tree->ma_root, root);
> +}
> +
> +/**
> + * __mt_dup(): Duplicate an entire maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate
> + * new child nodes in non-leaf nodes. The new node is exactly the same as the
> + * source node except for all the addresses stored in it. It will be faster than
> + * traversing all elements in the source tree and inserting them one by one into
> + * the new tree.
> + * The user needs to ensure that the attributes of the source tree and the new
> + * tree are the same, and the new tree needs to be an empty tree, otherwise
> + * -EINVAL will be returned.
> + * Note that the user needs to manually lock the source tree and the new tree.
> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
> + * the attributes of the two trees are different or the new tree is not an empty
> + * tree.
> + */
> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> +{
> +	int ret = 0;
> +	MA_STATE(mas, mt, 0, 0);
> +	MA_STATE(new_mas, new, 0, 0);
> +
> +	mas_dup_build(&mas, &new_mas, gfp);
> +
> +	if (unlikely(mas_is_err(&mas))) {
> +		ret = xa_err(mas.node);
> +		if (ret == -ENOMEM)
> +			mas_dup_free(&new_mas);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(__mt_dup);
> +
> +/**
> + * mtree_dup(): Duplicate an entire maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate
> + * new child nodes in non-leaf nodes. The new node is exactly the same as the
> + * source node except for all the addresses stored in it. It will be faster than
> + * traversing all elements in the source tree and inserting them one by one into
> + * the new tree.
> + * The user needs to ensure that the attributes of the source tree and the new
> + * tree are the same, and the new tree needs to be an empty tree, otherwise
> + * -EINVAL will be returned.
> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
> + * the attributes of the two trees are different or the new tree is not an empty
> + * tree.
> + */
> +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> +{
> +	int ret = 0;
> +	MA_STATE(mas, mt, 0, 0);
> +	MA_STATE(new_mas, new, 0, 0);
> +
> +	mas_lock(&new_mas);
> +	mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
> +
> +	mas_dup_build(&mas, &new_mas, gfp);
> +	mas_unlock(&mas);
> +
> +	if (unlikely(mas_is_err(&mas))) {
> +		ret = xa_err(mas.node);
> +		if (ret == -ENOMEM)
> +			mas_dup_free(&new_mas);
> +	}
> +
> +	mas_unlock(&new_mas);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mtree_dup);
> +
>  /**
>   * __mt_destroy() - Walk and free all nodes of a locked maple tree.
>   * @mt: The maple tree
> -- 
> 2.20.1
> 

[1]. https://lore.kernel.org/lkml/20231004142500.gz2552r74aiphl4z@revolver/

Thanks,
Liam

