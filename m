Return-Path: <linux-fsdevel+bounces-11291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E468527C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 04:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA48D285C29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 03:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62987A92E;
	Tue, 13 Feb 2024 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZH3BuHl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rmll9OZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CE8F45;
	Tue, 13 Feb 2024 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795227; cv=fail; b=TQ+54b62aDLzlcV8vGQQaYBIHAI1Gx9dYx4UMjeJjdAzCT0ABWz5zir70NBTv9Pf9KCmj9gpbX0mncJqQydfKaQi18O+/VrYdso4NL62hAQd7W4c32CZkxXGASPTA6WvabBOit6xMLb2KGHI1/tc3tYcyNWLuDuOB1nouTgCIng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795227; c=relaxed/simple;
	bh=Um3l0M4VdSjGx7opZZ3yfPAi2yLDnFvDhD/p5xJGosw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rWvHjkVHfChzKSnir5bSJkLm5W13kAsPT4yqVOV2Tq6Jad8rLhSwb3aHdstLd+i8SsYcUZdTGeUS1IhxrE1JwQWAcdPvCBjx461u1KHEwZ2iV4YqQ8JSSWRjgd+Ktk57fsrGBXMBaWP4/iASTx1wYYe8dTMWDTjylVboSVq92zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AZH3BuHl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rmll9OZe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3KPBk006888;
	Tue, 13 Feb 2024 03:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=goXbVLGn1Uls5GgCnwwxp7WAHrQQD4E1MfnT1U2nCeU=;
 b=AZH3BuHligli8YKiqIBQHuHKaXLiXAp1Q+D1BD3MI2OdKHvs/g3gIKt7DJvOYKSilJT8
 08JVknu7t9WUfP/wDly7iPYissYgKE6GaTvZo3le+7dV6vQwgL3QHZuAYWWYoMP/IK3M
 P4whcly8+1zs+4Kw5fPA/TFC986lnxU/K2faf3bWREgNeA1Tn63tzr7LYGwyifVJa8P9
 htusSErKNao8fXAm9bruqPxaI7RaUMttcVG3Z+ciKiXbjVb09iEpVhlMtECdFNTiSSw5
 nMpJK6QBKKQIX06LQ82J/fF5/JI9DOX0mSle7l+tMEh6avMo6gTkd5tCRKcGO/Mmmp55 wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w80e100g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 03:33:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3KSu2015207;
	Tue, 13 Feb 2024 03:33:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6qn5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 03:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqPaN5/Eml9T+IuCRIdmiNUC4X6o1SnhAsuPDioADs0pAr3ovAW1Ao8GyR/4IVyWrNz3zPoFbDiV7P3pDOTlHQhaHu073n1ep2D+JR+LpiZKfeIDyHxywzRnFnpOF7VIWQaZBqUpzGc/1C0qBJN4y8NganOyM9Q99HBUoDeX+o+VbTavgkeAc6sDqumvYkiGkhxOo0I0EjiGREu4FK/IeVqzgID2i2ckjW6xLVxOoVa59aiXYfrKnxeRfYzlXd94WRoe3G3FgZqVECl2oMoYx9M2kyeHOqq2N2IUrql/PH/KXw1RA8S2/TEi8GnuuA758C5rm/tIVGE6FhmHOC8q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goXbVLGn1Uls5GgCnwwxp7WAHrQQD4E1MfnT1U2nCeU=;
 b=SYVpMe+qzpUUfHurNOHYy+7ArZdM96GNGZLfjvMsGAIXCgDdoKavzweijnpYRaNuAXl1EDPgVRkESEREoUUHsqIp6pIgXuhojqvewu0JctpaCPJ4LUL7wl+Q9faFGyz/mwYEdvOXKWrSIteHPq0r8UDYWTaC1faiM9SrWy2qj8xmm1mEzI82ayx+MIT5Wqguo1VTj92xlOEuIQgHQPMY+W89j60Im+aBIlKYhv0YWqeQQFYDlloWNUoM3fBcXzKohzh1VojCv8nEKaxMjU3YKogdLDuhrbXZxIz7MF4HuNZhPn9vvuASRDORkUuPOMQ24gTm0ekTHmGpMUP96lQZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goXbVLGn1Uls5GgCnwwxp7WAHrQQD4E1MfnT1U2nCeU=;
 b=Rmll9OZeaCPnPi4I9XSjF1bIui94lwGBS6etdbRGUpCpeg3CyO3qPAK6JL/l2Qwu/fMKJRileJu9jTP5gMD28kHRv6EGd8lGDGA16R67XviSfXekwhp/z9S3u+sqv+utk6aFs04IEio4kAPqIBdmkWASPysbhTaOO91EJ1IdsDE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Tue, 13 Feb
 2024 03:33:10 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 03:33:10 +0000
Date: Mon, 12 Feb 2024 22:33:07 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240213033307.zbhrpjigco7vl56z@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213001920.3551772-4-lokeshgidra@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: CH5P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db9f876-79f0-44ee-a894-08dc2c44801a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zwwBlHd/3Z3zc9ZI0zu9cQ7YfTIoqv66dNaEE9SWGw9rw67d7m72FU5NI795zj1QhJwWW+i5yMdvYQUw/dKa9+461d98rlGGHrThsxfwU/T9wIpWE2M0JjYX95zHZ0UZUFywMCte9bKxHH3tNNigp7Sneg9C+Ch0T4aWH764CJ0XeApidP8pP10o6HnW5SKakK4UQT6/sK23ntECQ0dgJO3GZGj0D7+PmrO3f2g6i2LX8SefGX0jZqNKjmlPSCDOajw+EFtwccU9Ke3AMmvrOuZ1e60U/R3uL3165QXwv7EgtUkzB2Cm4eZBr15jzHNHXmOQ710de5Zot9jGVhPKY2sJmavjCTlLjwo7IOp5DdF+OmsBQ9lwY+X4JOqPWUsjl5Qy0jBILpmDOfwD9w+NfgOaCY+r///HKko9iHcQEjcW76+V2wCOaCfEUMpmkZkYpQNIjZV6Uxr03mq9B7p85Bps1rBVBreIHDiVmMHfOZ4/36s2BUlVwePKhSiRTbStsqNsNXyl33c8w5GAshWVLutPCwAnx+ilmL3yXfq/EJR8dZjx0tFsLZPcmX72gW8X
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(7416002)(41300700001)(6666004)(26005)(6506007)(6512007)(9686003)(6486002)(478600001)(1076003)(4326008)(86362001)(38100700002)(83380400001)(8676002)(5660300002)(8936002)(6916009)(66556008)(316002)(66476007)(33716001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OI7wi9622aXP3xyc0MXu7T3GiewACXMrxUkSK7dqmUb39NJQbQhjNR8pPyxr?=
 =?us-ascii?Q?I4dI4WGKD5mCDo7fMzsOR51NEaqJ6TW7W4Y6H5R5m2esyvN8G2v/JDklQKZn?=
 =?us-ascii?Q?wOeKT0MY2Z6B5zkEw/MWHcd5gmdo0r75pYlQsFqxVv8lTpH3YPsan6aFIZoH?=
 =?us-ascii?Q?nNoiHkSfrZ7cbiPRyeKqQIe9v0tJQ2Ob2PVZHbexsPquTWAKfPzMQqBWVy7t?=
 =?us-ascii?Q?EQtIurMEBAiIg9KSEPjN8HVDLrl+4yFC+CfZlViP/4fvYHp7hafuYZXC8iVl?=
 =?us-ascii?Q?VoKacVuAs/bCwCMu2d8H5rvVBovs2f9mvUUdsCfinBNUwlBwW8GI/fG7hfri?=
 =?us-ascii?Q?qSYco8Uqe9IbdfePkcJPhlGzOg+OFpF6x5tJHhFRpWYpwZtlmezzZhiyv7ma?=
 =?us-ascii?Q?gsG7Hc8tMR2GICVFkGbnu2TctwmjXu/2q9YgAaWRpxxswRBwKdgmvSDzU0QP?=
 =?us-ascii?Q?KLUXruK1dfV/kxYEINvavC8E3zt81uWBnO4UqHBULUoP6/O1+Ah8X5roW0JR?=
 =?us-ascii?Q?ETzrRa9ej/Hy4UH6I47FZBUQyBZFbrZ/q85KCfLPUlvrwtZhKGxVfO6amccB?=
 =?us-ascii?Q?JrHGG9F3TN7xrhCMYd/lpHTU1I8m9+cXjmIfRtb4XtL7PmbS8tR6DZXGEXto?=
 =?us-ascii?Q?5xxg2iHJ9thiVbaC9tT0rzgKM4tTApaEw3UxEqUvkU+QaqsJJT+s9Gi8RwkY?=
 =?us-ascii?Q?Xis9nYu6eiLfzr8eSV255sm6L2KkPStDjmXcOfZWOTzPAzV1Qug1GaR3wdAG?=
 =?us-ascii?Q?pfzCPyEf9YKXB4f15scyiJrXsZAGT3YnfSAPfjpRIFceGIu6odtZGJ7iu8DU?=
 =?us-ascii?Q?kIXsquKZ17Sgc26vHMHHU4Pzq7jUYMxv+y9Zw9w2Aqe5Hj4jeiwQDqHO1doy?=
 =?us-ascii?Q?mYrl/NLiDpdhWHIlFK/hnf+ER4MJeAMFEkh1sdBVq/CZ+P9vqjTXyVJYkqR4?=
 =?us-ascii?Q?WKD8OWYGzHh+Ez9ZSSXLnRp/kFy30AQxYYpd2U5sFylW2ieR6Pcr+6/qSWff?=
 =?us-ascii?Q?0GsJ9wrtP2hE8lXQ9ILIOYoD+ZFzjGL3Z5jCi/KLb2C8r9Sx4Ey1FlopFxkE?=
 =?us-ascii?Q?ZO2G5ZE3R5qwdcR2qOtAKvT/Spom2Dl7z56UuuagDe8QhzcnzAKEM7naULdi?=
 =?us-ascii?Q?DfxF0zlbP2TbLsPgnYKyd4tc4LGw0HhNjC9gZaQ2EMVDsD4DbT768nHDsTvB?=
 =?us-ascii?Q?2lg9UzfFicvOipptC3n7dPR78MzSbrTg9BwS0QJMdf1YGz68kbUcXy5/ooNs?=
 =?us-ascii?Q?TLk8DNuxAAB8Vk/05MzD7//YDJKqDP2Eg1xY2y42KeF2Y5HaX9GJuWqIpfZD?=
 =?us-ascii?Q?6zCGWNp3o86o8yOuYVpyJheaa4fbdtbdWKwoQ2fz1ltnzExn99W1khouUO0e?=
 =?us-ascii?Q?usWHxpQYdl4rswxK1k4iYZwoRjhdYV6crasgkZqPuIBgL3CpukrcaJH/4fIO?=
 =?us-ascii?Q?Yemun3hGesIySCIFG/l4AFrWHD6XdQ9xk0oidVoNmucLjLMwhvtLvAuwC9EH?=
 =?us-ascii?Q?7Z+slTqgVaSuBBbCF7w6oqrhrbJyiHT1ma+EgjgsNBVxDTHFrZYarg327bSS?=
 =?us-ascii?Q?Rga4wX6E/sL8Ej5INND8wioCkkV3YRBmf54NJTE9I+V2xk0y1dNuTansAb5I?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ywVDlB47Qn+XLELbsi500/cPBMDWr5QhuuiNr0FzmaHmrWuqTixhkKiN+KOeT/gqgOjVvQL8emPceih7G7PEgjscUwvc2ZFiIkJ8lv3jkMOh1OOD1ZgpRa87nhV5M2H2vGVJqnoNVmpxBS26J0Ts1KrL3gsy9anxZ1NVyvjgnkuR3NMwJsl26V096Q+hqp9oPHeYasgs8/2fQN5XSCcPV5XxztR9O4ApzUXsJP5mKttSks5QHNULa0PPs2uZ4gyWZD6TnlTrH8FBmUJKETd9IPCYX1UGCCfvE06p/37u6LJ56mBcAM5IF8wAxlfVO9LAEcxU4NppBsJX0MoaJQMzlOVZ6Ss7Upv6+LfpVSUNT4nK8A0mTOiiLgK47vwNoU4/Jfe5M9nroagHQDrbSVWK9L3wO22AFUS2eGi4sBIvf4KKdz2ZyKpSJkJhErnI6okt5MtAnfIOZjTjVEZHR3Yc1uYeDJyLFjTcYw5jHUTfct8Yh4B8zo+g4vBjwHWlVl/FxEBHn1kv88AqmrrzN3zGeBL4juFxyO+MUUXmexK/HElpjHMw/4l/6SSmBUe1ZWQ3oXevH8PrrWUPsO0fqQT614BEeJjX0Lq+OqCFELRhKLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db9f876-79f0-44ee-a894-08dc2c44801a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 03:33:10.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDZB0glLSxCo2lAJsg2LjV/TOULMikzzVgwyxWgy3Kt2uubZwAVa57tNMONki81TajIRXZRts05pzjmB88bH2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=480 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130024
X-Proofpoint-GUID: -eIMHdBhzgIX5EhvBdfki-Fn1spmN2JZ
X-Proofpoint-ORIG-GUID: -eIMHdBhzgIX5EhvBdfki-Fn1spmN2JZ

* Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> All userfaultfd operations, except write-protect, opportunistically use
> per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> critical section.
> 
> Write-protect operation requires mmap_lock as it iterates over multiple
> vmas.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  fs/userfaultfd.c              |  13 +-
>  include/linux/userfaultfd_k.h |   5 +-
>  mm/userfaultfd.c              | 392 ++++++++++++++++++++++++++--------
>  3 files changed, 312 insertions(+), 98 deletions(-)
> 
...

> +
> +static __always_inline
> +struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
> +						 unsigned long addr)
> +{
> +	struct vm_area_struct *vma;
> +
> +	mmap_assert_locked(mm);
> +	vma = vma_lookup(mm, addr);
> +	if (!vma)
> +		vma = ERR_PTR(-ENOENT);
> +	else if (!(vma->vm_flags & VM_SHARED) && anon_vma_prepare(vma))
> +		vma = ERR_PTR(-ENOMEM);

Nit: I just noticed that the code below says anon_vma_prepare() is unlikely.

...

> +static struct vm_area_struct *lock_mm_and_find_dst_vma(struct mm_struct *dst_mm,
> +						       unsigned long dst_start,
> +						       unsigned long len)
> +{
> +	struct vm_area_struct *dst_vma;
> +	int err;
> +
> +	mmap_read_lock(dst_mm);
> +	dst_vma = find_vma_and_prepare_anon(dst_mm, dst_start);
> +	if (IS_ERR(dst_vma)) {
> +		err = PTR_ERR(dst_vma);

It's sort of odd you decode then re-encode this error, but it's correct
the way you have it written.  You could just encode ENOENT instead?

> +		goto out_unlock;
> +	}
> +
> +	if (validate_dst_vma(dst_vma, dst_start + len))
> +		return dst_vma;
> +
> +	err = -ENOENT;
> +out_unlock:
> +	mmap_read_unlock(dst_mm);
> +	return ERR_PTR(err);
>  }
> +#endif
>  
...

> +static __always_inline
> +long find_vmas_mm_locked(struct mm_struct *mm,

int would probably do?
> +			 unsigned long dst_start,
> +			 unsigned long src_start,
> +			 struct vm_area_struct **dst_vmap,
> +			 struct vm_area_struct **src_vmap)
> +{
> +	struct vm_area_struct *vma;
> +
> +	mmap_assert_locked(mm);
> +	vma = find_vma_and_prepare_anon(mm, dst_start);
> +	if (IS_ERR(vma))
> +		return PTR_ERR(vma);
> +
> +	*dst_vmap = vma;
> +	/* Skip finding src_vma if src_start is in dst_vma */
> +	if (src_start >= vma->vm_start && src_start < vma->vm_end)
> +		goto out_success;
> +
> +	vma = vma_lookup(mm, src_start);
> +	if (!vma)
> +		return -ENOENT;
> +out_success:
> +	*src_vmap = vma;
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +static long find_and_lock_vmas(struct mm_struct *mm,

This could also be an int return type, I must be missing something?

...

> +	*src_vmap = lock_vma_under_rcu(mm, src_start);
> +	if (likely(*src_vmap))
> +		return 0;
> +
> +	/* Undo any locking and retry in mmap_lock critical section */
> +	vma_end_read(*dst_vmap);
> +
> +	mmap_read_lock(mm);
> +	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
> +	if (!err) {
> +		/*
> +		 * See comment in lock_vma() as to why not using
> +		 * vma_start_read() here.
> +		 */
> +		down_read(&(*dst_vmap)->vm_lock->lock);
> +		if (*dst_vmap != *src_vmap)
> +			down_read(&(*src_vmap)->vm_lock->lock);
> +	}
> +	mmap_read_unlock(mm);
> +	return err;
> +}
> +#else
> +static long lock_mm_and_find_vmas(struct mm_struct *mm,
> +				  unsigned long dst_start,
> +				  unsigned long src_start,
> +				  struct vm_area_struct **dst_vmap,
> +				  struct vm_area_struct **src_vmap)
> +{
> +	long err;
> +
> +	mmap_read_lock(mm);
> +	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
> +	if (err)
> +		mmap_read_unlock(mm);
> +	return err;
>  }
> +#endif

This section is much easier to understand.  Thanks.

Thanks,
Liam

