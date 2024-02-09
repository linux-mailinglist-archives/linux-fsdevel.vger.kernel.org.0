Return-Path: <linux-fsdevel+bounces-11007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96C84FCA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF27B27236
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030188286E;
	Fri,  9 Feb 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XQYFSkIV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QA/C85Fg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298BE57861;
	Fri,  9 Feb 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505606; cv=fail; b=rlXXrs0y/GqrzDDCOMglN0+xFqL8N7r+ozapd18ZFEcfRDqYHWXBBC1qv7aOlwrAim3xGWyEZagEEsPpO+HFXxllMXGKsQi885zxpo8q+8hpFAPOY2u9Fy5T1GMPu8gwu31V9lqhUrbByPEMPyHBG2fIuUEujr5nKG+JtC2Bhuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505606; c=relaxed/simple;
	bh=ZjDo2y09z39CoaDEA5SGBZAHnlVBpaeodXF+8Vi+QvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BBr4BhlDO5cz3Jgrv7F5MIDbLoW0cOJdSDdgYlEGWsRwMHf9CTcFv7h84P7I1XDyY9zQirrnJjHDDdQmw/nTxPE7XyRCGMvMHl/evd5Rtky4ti22wyXPf6gf62eNuuYs0BEsJDPzMom/rIWkAi/EWN6WJKHb3KNsmgD5awmmg7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XQYFSkIV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QA/C85Fg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419IZJYK031428;
	Fri, 9 Feb 2024 19:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=furuaxAW+AXAGOmzCtNi4Jfes1nI4igQ9ABX6p+T+ts=;
 b=XQYFSkIVSXBhW5K9EngVQsQxLzbUOylKNRj3rXhmUJkYkF4e12W31UruAfKwhJjEB+tv
 oNF0MvNYilvLZJIHGhq02MNOgQmyde+MvyOkRE9YtbkbBN9WUjPWZwWfXT0Q/EGHh0Eh
 R4Cfono2+S4UYoPaY2TJSsDCMgriyfSOh4aWzmSdNyy4/R2tBAtwj2v/ae9cA+txhRQw
 u1zfK/rYRaEHh1Hm//xg2kgNkOTPG6M01MdnEA2gaGhC0JsRP7xBaRi6JgfxXoU86Y/C
 1cndxnm7IgJUaVBORXVRObsLoNVBQ9x9Ufv6bPIleb/B+6QDaYlKw4AOTBHOTkVgFCr6 dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w5sexg20t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 19:06:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419J4GqW019694;
	Fri, 9 Feb 2024 19:06:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxjvgaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 19:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X95ucOg8mwND7UymUnNTIRQlUM1IC15GNscvvy91HY534YebhVXPlNaxMYdV+Pde4cb154Wlw9rSP/bqfhmiLeZRtxjn9dsTyjXbKL9SKs6Ei7bNd+Yej7KxaZa0eMPwltvC8NY40xe36IYlbnFPUWqiGFfzuudbXdfxrmBbSdECv1XwduhNmsRUrxECT3aW6R6Cm7tYc/faIKcTm7pt/ySVxuSCxD9GVTtNBDn7cvy5M0q6YXN8aaP1uqotTZbodi1l6RCg/5FmpGL7Dw5RI5LB5lxrhQGi1bYiazRBm79BiOe1HGEIpr1cf40S6+2im4WARCVWfx8y2TGOCbU/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=furuaxAW+AXAGOmzCtNi4Jfes1nI4igQ9ABX6p+T+ts=;
 b=djJ3EB21hIzfoPPzyZyZJUMzL3PyNnz+9oCEe5jp8z+YLlUwnheNTTWu9avqEc2GQBIdhG6IS4Df+mETQ8NWKxJ4WVnueX+/pfjJOX9k546fG9gs/MXL+8HZL9Xa0/yGhZqc6TNgR+VLse6YS++eER5L5hxkYwpsyM8G8IBqcHoxoAnwCDDPotI8Z3AwL1ou9pVzBWuk1P6bfIP3CKwNAMW0LlXsE1m5r8u7iiiT2fYQEaXGYG2eW/9WMdRFkN5qwBjQ4kbPbjgMo+5uhdUVsrWN1ETd+8H76Rn1O9KbmKuAgKThiBiQ/UUk9dObr7tBF/p7CgOziMBfCn4eJixMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=furuaxAW+AXAGOmzCtNi4Jfes1nI4igQ9ABX6p+T+ts=;
 b=QA/C85FguVSXoSiMxzAyGER5wKLi8gXUYafWtOZjOT98QHvjR2+YJzw0ARFCto33b6QKvb1yu6uGolxRtL+/r7HGxlBncrVLS2N1ncQQVjy5rksiKGZZmqfvWhS/wOOgdkVu2NApbnoO8jkUvbwzH0PDfz3lnnU/rxblg0a2Z38=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by CH3PR10MB6713.namprd10.prod.outlook.com (2603:10b6:610:143::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 19:06:09 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 19:06:09 +0000
Date: Fri, 9 Feb 2024 14:06:05 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v4 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240209190605.7gokzhg7afy7ibyf@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240208212204.2043140-1-lokeshgidra@google.com>
 <20240208212204.2043140-4-lokeshgidra@google.com>
 <20240209030654.lxh4krmxmiuszhab@revolver>
 <CA+EESO4Ar8o3HMPF_b9KGbH2ytk1gNSJo0ucNAdMDX_OhgTe=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO4Ar8o3HMPF_b9KGbH2ytk1gNSJo0ucNAdMDX_OhgTe=A@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: CH0PR03CA0391.namprd03.prod.outlook.com
 (2603:10b6:610:11b::10) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|CH3PR10MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecbae07-4dbf-446e-53e7-08dc29a22cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NZfHW/NRr+F54klJxqtYIUdXXSUngbDgwo4HF1LtTL/fRkaKLlhmXsPK95t4M8qJbTQ8d2x8oAEnWa70NLT3o1Qh1FcNsPH+aA1Js3iAJ8oVqf03EEwg0ZIi6Y9K4+wc91hSQVCAIfe6iKjAH9GWfsSHgdBhm8J3IKhG3HIHXw9q+skFA7OTEuoV+P7c8Ik+sL8etGgkgCSyeDdSasJdR5ufZ2Z6x65NtkD8LUSfyi9qa8wMtwXImS74JbcDUe0E+64P1zJDq3+AvXR2ICwskP14PhojqtBOvoW15iXh+vgTUfk0/z25tvj4Gzh/9zN29rvvs71HoDVFxZZlmJhuxotkfxkLI+PzjY6QwAw7x029Itazx59mPm3ZfH1MAuGTYPKG+BVOL/cbV+k9EWbys0lLrktjUA/RGFL+phph86V6Tdveh5yMOxcLJNzGKN8SI/AboLv7AwO1qw1KK7jR9kOy8UUwmJrcNY8yCml50xXU7ni6yaQykZjrMxAbeZR8Op1ws+9TqIO9VdKmul1C+LJ7OB2eY5FM0lK0Z/kznzKtv5SASxl9BcbtXBjKkouT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(9686003)(6512007)(6666004)(6486002)(83380400001)(26005)(1076003)(5660300002)(2906002)(30864003)(66476007)(7416002)(66946007)(6916009)(316002)(66556008)(8676002)(8936002)(53546011)(4326008)(6506007)(38100700002)(86362001)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cXlLYWp5VWNZS2gwOUgvOXBMRGZsZ0ZxWXloV29QTThQWEZiZEwyNFhielFP?=
 =?utf-8?B?d1lYd0w1blEyQm1KK3ppRlB0SGJpbzIzTW1zdHpkRUEvc0hhOWlxQTVMbmlK?=
 =?utf-8?B?SUtVUGUvaG5NWXJReUdNNjNKb2NPWFAzL05veWNNUW8rMmlqV0xsbGRQaHdk?=
 =?utf-8?B?bXNLbVRFWkZIQXZDaE03eEx5WlZ3MkhnT09kRXRYMXh5WEJreTJERnY5TGRw?=
 =?utf-8?B?RTVHSFV3ZFJxYUhza0NIb3VhZHZFb3hrRWVGem90eXBMVzZ1MjhMQXk3WWxq?=
 =?utf-8?B?d1QvYW4yU0VlRW13N1NObEdKK0VMZHpzbC82TU5QRGJkVG82UmZlTDZabW1W?=
 =?utf-8?B?RVh1UXp0N0NQMU05MVptOGtyRDZrMmU3dWtCY1JKRk0vQ003dm9pQW1LUE5W?=
 =?utf-8?B?MUprV3pIMmtvY3FTZ1A0NzRGRk1GdHQzek55aFdrM3JPVFF3NkR0OGFtbE1O?=
 =?utf-8?B?UGg3NDRHallvN1AzVU5TRXk0STVvOHNOODlaRXBzUFp1ajd3ZUNITGlZeVAw?=
 =?utf-8?B?ODh4WTFYVmN1SjV6S3hSNDdEeHlCNnJLWUJVNkQzZTFFb1QxVGhJSG9xL1lH?=
 =?utf-8?B?bTkzM1p4bE01SlhQL0EzRVQyeU85S0J6QVVpMG95MWI1bG1rZUlwZTFVT0VU?=
 =?utf-8?B?MU9RUG9RamY4U1JIWTYwcmd0OUJwc0Znd3MzemdyUmhDS3pUT3FUd0xkTVBH?=
 =?utf-8?B?SitGeE5OWmRlem9LNTBwTkxuNWJrZ0d2S2tkVkh0MEtjOVlFZHNBdS9pRUgr?=
 =?utf-8?B?WHRzMUFmUjVtRmhiMS85MitBOGE3UnU1SjMzWlN3YkZDTEdLOW5JTjZ4S2hq?=
 =?utf-8?B?ZENTN0JsQXZqUmd5VzNOZUtEZElYS1dVU2RIQi9BTUt1L2FkZE5mVWRnOWdq?=
 =?utf-8?B?WGZSR25ONU9zR1BkVmR0Q1V0WWZ4Nll6dGRGZ2dmbjJUQ3FBVytQTDFiWWZZ?=
 =?utf-8?B?YWE3Tzc4VG05bnRFdmNDOVNNOTNRTllYL2RabkVPT29CWFJoYjVQYXp2aThj?=
 =?utf-8?B?MkJ1ekgvUWEwaHNzMjJUZWJmZTIyWkR0bnJVK2RkVk43cVZYaG5VTktXVVVP?=
 =?utf-8?B?alFDYmRxTTMxbkthL0hYR3prRm9tMUVVVDhBRXRYSDB4RXI3WE5WTjk2LzFp?=
 =?utf-8?B?eG1Fd3hhRUQ4amZxdUJkVlJLd2oxcEZaR004MjlpMDQ4VTJBYTA2NU5ZOHRD?=
 =?utf-8?B?U2IxaTZ4TmlPYVR2clg4ZGd5WDBWem5OblRQV1gvQkhVZS9DUFBUeWgvQi93?=
 =?utf-8?B?NjRnMjIwQTZJaEh3b0Z6cGc4bittU0kwT0ZTTlcveVRmdjlIZDN4SHBoYzFD?=
 =?utf-8?B?bFl4NnBHaWR5QkttVXptblJIMEt5Rmt6TXhpRllIM2xMRTFQd3hyVklRVGdr?=
 =?utf-8?B?VVlTQW05MWw0R0pHM0VVa3lUL0xnYWdXMnRpYlhUTTV5aGFqTTV0bkh1WS83?=
 =?utf-8?B?RFlITWJULzROYldoS28xYkZPUENNT0hsVm9HVHp0Nlp2NCthTGYzTGdJM1Z0?=
 =?utf-8?B?R1hTK1BTQndoaU56cWVPdDR0Z2hMUklOYzdwK0ZGTTVuTVdLOXBOU05NdUx1?=
 =?utf-8?B?U201ZHpCdEVtWWpwUTBQMUo2V0ptQStEdThKSTJHc08vWWNIS2E2WjI3Z1dT?=
 =?utf-8?B?czFQdUJHR0dOQVFUM1UxSGFHaVR0UVM4WWFTQnJPS0g3MzRMTnd3cW1hYUVz?=
 =?utf-8?B?dXREbjFJMVUwZ3NiN1ROZnBvVUV5MTUxVnNjQVBDZzVpckRGOVNnVlVsRWFi?=
 =?utf-8?B?dTEvMmUveEh1c2FlTFU0QU1CaTRncmZXLzNjZjhoVFN5bkptZ2lrMUJXN25Q?=
 =?utf-8?B?d3FPOThXK3RxQzg1SHUyblNGb05GbUxRcm5aRmdmNVVvVCtqREt4eWl2TFp2?=
 =?utf-8?B?dWEyK3Vad0ZtdUJIVzdDdTZsK1NkRDZOREo2d3NCeFZLVG5YSjI3YnUyVE9t?=
 =?utf-8?B?dlp2aWwycnVuWEtaZmpkYWZpTC9rMlZxV3FFcER4V0UxUGVGWGpRZllmODNo?=
 =?utf-8?B?SDNSOVhZYmJhNXlKZCtSTERaUWdmQXVURnRNTVUyd0NuYzFZcUJjUXc5azUr?=
 =?utf-8?B?eDJzYzBnUld1VjhucnNTRTFqMUdWeE5mYk9JZFZ1eE1uNjhSQzdPUktyOTJD?=
 =?utf-8?B?S0dvdVpvUVhYQWdlbzlSYXdJRmFxM2k0dm5teHgzK3Mxcmh3c3pFYlRVR3Va?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	64VX7wD/hwCQnt35PP88tEnLnSNm2DFrm5EJeCRKSYHWv89iJdcCqL2vuCAjLu8EfmFYMlq6yrid42qvgRG1opu6I2rVz/eoDpd4dZ4um++OvKa/2H82RBvJTPApcffsi32V42CFGI6crlrBB+87Wd3KeF1yLznbQWc7XEQLsLGeedfqyuyffPHAKsUmrBbX4kkPtOLMEOUIiQu/o/8ncArlvuxIghq2BI98CzytBZtGWSFIbm5VTTKw+gh62ieK8acVJrYpqhzT37JzEAo3NnRzzhtEAv5wabsdkVpp90iwwIwU8790N+1NI+iya18j6b6cjktAO/7cTKKsR/DjlunqFbKNjGQx4pAMdV1Vn0noIhYfBfUa3NZKt41vjsvWWQgQo1OVIQq6fMUugDTOz93jjm3YKfZAki16eruHJNglxLyanCiBaPQdLnB2c3lzVklU7KSqUMEGkhjSKFh+uPdNQFmuk3QUjuMCkcH8sKVCWNiLqFeUyzY4hT5GVx7L1UZGn3wUMw4lCVfwvl6KFBOJWOd8EGqD/ZtcgUx0L/whch2+bVXSxftR5EWEHliUEvDQ5182GytiA5DGLfwMGHFjBl4eXewESbLwKuYTiEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecbae07-4dbf-446e-53e7-08dc29a22cee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:06:09.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1qonP2TLWm7GokwahzR2XhvZclq1Y0FUdGeL0Hw+UXwpUqgIa+TPUjUrVykQm53QroBJLql64dlI4LYF2WWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_16,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090139
X-Proofpoint-GUID: 72w-Lllc1zhwieEf1GCkeTvnvhvxePis
X-Proofpoint-ORIG-GUID: 72w-Lllc1zhwieEf1GCkeTvnvhvxePis

* Lokesh Gidra <lokeshgidra@google.com> [240209 13:02]:
> On Thu, Feb 8, 2024 at 7:07=E2=80=AFPM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240208 16:22]:
> > > All userfaultfd operations, except write-protect, opportunistically u=
se
> > > per-vma locks to lock vmas. On failure, attempt again inside mmap_loc=
k
> > > critical section.
> > >
> > > Write-protect operation requires mmap_lock as it iterates over multip=
le
> > > vmas.
> > >
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  fs/userfaultfd.c              |  13 +-
> > >  include/linux/userfaultfd_k.h |   5 +-
> > >  mm/userfaultfd.c              | 356 ++++++++++++++++++++++++++------=
--
> > >  3 files changed, 275 insertions(+), 99 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index c00a021bcce4..60dcfafdc11a 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd=
_ctx *ctx,
> > >               return -EINVAL;
> > >
> > >       if (mmget_not_zero(mm)) {
> > > -             mmap_read_lock(mm);
> > > -
> > > -             /* Re-check after taking map_changing_lock */
> > > -             down_read(&ctx->map_changing_lock);
> > > -             if (likely(!atomic_read(&ctx->mmap_changing)))
> > > -                     ret =3D move_pages(ctx, mm, uffdio_move.dst, uf=
fdio_move.src,
> > > -                                      uffdio_move.len, uffdio_move.m=
ode);
> > > -             else
> > > -                     ret =3D -EAGAIN;
> > > -             up_read(&ctx->map_changing_lock);
> > > -             mmap_read_unlock(mm);
> > > +             ret =3D move_pages(ctx, uffdio_move.dst, uffdio_move.sr=
c,
> > > +                              uffdio_move.len, uffdio_move.mode);
> > >               mmput(mm);
> > >       } else {
> > >               return -ESRCH;
> > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultf=
d_k.h
> > > index 3210c3552976..05d59f74fc88 100644
> > > --- a/include/linux/userfaultfd_k.h
> > > +++ b/include/linux/userfaultfd_k.h
> > > @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *=
vma,
> > >  /* move_pages */
> > >  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> > >  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm=
,
> > > -                unsigned long dst_start, unsigned long src_start,
> > > -                unsigned long len, __u64 flags);
> > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_st=
art,
> > > +                unsigned long src_start, unsigned long len, __u64 fl=
ags);
> > >  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t =
*src_pmd, pmd_t dst_pmdval,
> > >                       struct vm_area_struct *dst_vma,
> > >                       struct vm_area_struct *src_vma,
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 74aad0831e40..1e25768b2136 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -19,20 +19,12 @@
> > >  #include <asm/tlb.h>
> > >  #include "internal.h"
> > >
> > > -static __always_inline
> > > -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> > > -                                 unsigned long dst_start,
> > > -                                 unsigned long len)
> >
> > You could probably leave the __always_inline for this.
>=20
> Sure
> >
> > > +static bool validate_dst_vma(struct vm_area_struct *dst_vma,
> > > +                          unsigned long dst_end)
> > >  {
> > > -     /*
> > > -      * Make sure that the dst range is both valid and fully within =
a
> > > -      * single existing vma.
> > > -      */
> > > -     struct vm_area_struct *dst_vma;
> > > -
> > > -     dst_vma =3D find_vma(dst_mm, dst_start);
> > > -     if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > > -             return NULL;
> > > +     /* Make sure that the dst range is fully within dst_vma. */
> > > +     if (dst_end > dst_vma->vm_end)
> > > +             return false;
> > >
> > >       /*
> > >        * Check the vma is registered in uffd, this is required to
> > > @@ -40,11 +32,125 @@ struct vm_area_struct *find_dst_vma(struct mm_st=
ruct *dst_mm,
> > >        * time.
> > >        */
> > >       if (!dst_vma->vm_userfaultfd_ctx.ctx)
> > > -             return NULL;
> > > +             return false;
> > > +
> > > +     return true;
> > > +}
> > > +
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +/*
> > > + * lock_vma() - Lookup and lock vma corresponding to @address.
> > > + * @mm: mm to search vma in.
> > > + * @address: address that the vma should contain.
> > > + * @prepare_anon: If true, then prepare the vma (if private) with an=
on_vma.
> > > + *
> > > + * Should be called without holding mmap_lock. vma should be unlocke=
d after use
> > > + * with unlock_vma().
> > > + *
> > > + * Return: A locked vma containing @address, NULL if no vma is found=
, or
> > > + * -ENOMEM if anon_vma couldn't be allocated.
> > > + */
> > > +static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > +                                    unsigned long address,
> > > +                                    bool prepare_anon)
> > > +{
> > > +     struct vm_area_struct *vma;
> > > +
> > > +     vma =3D lock_vma_under_rcu(mm, address);
> > > +     if (vma) {
> > > +             /*
> > > +              * lock_vma_under_rcu() only checks anon_vma for privat=
e
> > > +              * anonymous mappings. But we need to ensure it is assi=
gned in
> > > +              * private file-backed vmas as well.
> > > +              */
> > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> > > +                 !vma->anon_vma)
> > > +                     vma_end_read(vma);
> > > +             else
> > > +                     return vma;
> > > +     }
> > > +
> > > +     mmap_read_lock(mm);
> > > +     vma =3D vma_lookup(mm, address);
> > > +     if (vma) {
> > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> > > +                 anon_vma_prepare(vma)) {
> > > +                     vma =3D ERR_PTR(-ENOMEM);
> > > +             } else {
> > > +                     /*
> > > +                      * We cannot use vma_start_read() as it may fai=
l due to
> > > +                      * false locked (see comment in vma_start_read(=
)). We
> > > +                      * can avoid that by directly locking vm_lock u=
nder
> > > +                      * mmap_lock, which guarantees that nobody can =
lock the
> > > +                      * vma for write (vma_start_write()) under us.
> > > +                      */
> > > +                     down_read(&vma->vm_lock->lock);
> > > +             }
> > > +     }
> > > +
> > > +     mmap_read_unlock(mm);
> > > +     return vma;
> > > +}
> > > +
> > > +static void unlock_vma(struct vm_area_struct *vma)
> > > +{
> > > +     vma_end_read(vma);
> > > +}
> > > +
> > > +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_struct=
 *dst_mm,
> > > +                                                 unsigned long dst_s=
tart,
> > > +                                                 unsigned long len)
> > > +{
> > > +     struct vm_area_struct *dst_vma;
> > > +
> > > +     /* Ensure anon_vma is assigned for private vmas */
> > > +     dst_vma =3D lock_vma(dst_mm, dst_start, true);
> > > +
> > > +     if (!dst_vma)
> > > +             return ERR_PTR(-ENOENT);
> > > +
> > > +     if (PTR_ERR(dst_vma) =3D=3D -ENOMEM)
> > > +             return dst_vma;
> > > +
> > > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > > +             goto out_unlock;
> > >
> > >       return dst_vma;
> > > +out_unlock:
> > > +     unlock_vma(dst_vma);
> > > +     return ERR_PTR(-ENOENT);
> > >  }
> > >
> > > +#else
> > > +
> > > +static struct vm_area_struct *lock_mm_and_find_dst_vma(struct mm_str=
uct *dst_mm,
> > > +                                                    unsigned long ds=
t_start,
> > > +                                                    unsigned long le=
n)
> > > +{
> > > +     struct vm_area_struct *dst_vma;
> > > +     int err =3D -ENOENT;
> > > +
> > > +     mmap_read_lock(dst_mm);
> > > +     dst_vma =3D vma_lookup(dst_mm, dst_start);
> > > +     if (!dst_vma)
> > > +             goto out_unlock;
> > > +
> > > +     /* Ensure anon_vma is assigned for private vmas */
> > > +     if (!(dst_vma->vm_flags & VM_SHARED) && anon_vma_prepare(dst_vm=
a)) {
> > > +             err =3D -ENOMEM;
> > > +             goto out_unlock;
> > > +     }
> > > +
> > > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > > +             goto out_unlock;
> > > +
> > > +     return dst_vma;
> > > +out_unlock:
> > > +     mmap_read_unlock(dst_mm);
> > > +     return ERR_PTR(err);
> > > +}
> > > +#endif
> > > +
> > >  /* Check if dst_addr is outside of file's size. Must be called with =
ptl held. */
> > >  static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
> > >                                unsigned long dst_addr)
> > > @@ -350,7 +456,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, =
unsigned long address)
> > >  #ifdef CONFIG_HUGETLB_PAGE
> > >  /*
> > >   * mfill_atomic processing for HUGETLB vmas.  Note that this routine=
 is
> > > - * called with mmap_lock held, it will release mmap_lock before retu=
rning.
> > > + * called with either vma-lock or mmap_lock held, it will release th=
e lock
> > > + * before returning.
> > >   */
> > >  static __always_inline ssize_t mfill_atomic_hugetlb(
> > >                                             struct userfaultfd_ctx *c=
tx,
> > > @@ -361,7 +468,6 @@ static __always_inline ssize_t mfill_atomic_huget=
lb(
> > >                                             uffd_flags_t flags)
> > >  {
> > >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > > -     int vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > >       ssize_t err;
> > >       pte_t *dst_pte;
> > >       unsigned long src_addr, dst_addr;
> > > @@ -380,7 +486,11 @@ static __always_inline ssize_t mfill_atomic_huge=
tlb(
> > >        */
> > >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > >               up_read(&ctx->map_changing_lock);
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +             unlock_vma(dst_vma);
> > > +#else
> > >               mmap_read_unlock(dst_mm);
> > > +#endif
> > >               return -EINVAL;
> > >       }
> > >
> > > @@ -403,24 +513,32 @@ static __always_inline ssize_t mfill_atomic_hug=
etlb(
> > >        * retry, dst_vma will be set to NULL and we must lookup again.
> > >        */
> > >       if (!dst_vma) {
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +             dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, le=
n);
> > > +#else
> > > +             dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_start,=
 len);
> > > +#endif
> > > +             if (IS_ERR(dst_vma)) {
> > > +                     err =3D PTR_ERR(dst_vma);
> > > +                     goto out;
> > > +             }
> > > +
> > >               err =3D -ENOENT;
> > > -             dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > -             if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> > > -                     goto out_unlock;
> > > +             if (!is_vm_hugetlb_page(dst_vma))
> > > +                     goto out_unlock_vma;
> > >
> > >               err =3D -EINVAL;
> > >               if (vma_hpagesize !=3D vma_kernel_pagesize(dst_vma))
> > > -                     goto out_unlock;
> > > -
> > > -             vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > -     }
> > > +                     goto out_unlock_vma;
> > >
> > > -     /*
> > > -      * If not shared, ensure the dst_vma has a anon_vma.
> > > -      */
> > > -     err =3D -ENOMEM;
> > > -     if (!vm_shared) {
> > > -             if (unlikely(anon_vma_prepare(dst_vma)))
> > > +             /*
> > > +              * If memory mappings are changing because of non-coope=
rative
> > > +              * operation (e.g. mremap) running in parallel, bail ou=
t and
> > > +              * request the user to retry later
> > > +              */
> > > +             down_read(&ctx->map_changing_lock);
> > > +             err =3D -EAGAIN;
> > > +             if (atomic_read(&ctx->mmap_changing))
> > >                       goto out_unlock;
> > >       }
> > >
> > > @@ -465,7 +583,11 @@ static __always_inline ssize_t mfill_atomic_huge=
tlb(
> > >
> > >               if (unlikely(err =3D=3D -ENOENT)) {
> > >                       up_read(&ctx->map_changing_lock);
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +                     unlock_vma(dst_vma);
> > > +#else
> > >                       mmap_read_unlock(dst_mm);
> > > +#endif
> > >                       BUG_ON(!folio);
> > >
> > >                       err =3D copy_folio_from_user(folio,
> > > @@ -474,17 +596,6 @@ static __always_inline ssize_t mfill_atomic_huge=
tlb(
> > >                               err =3D -EFAULT;
> > >                               goto out;
> > >                       }
> > > -                     mmap_read_lock(dst_mm);
> > > -                     down_read(&ctx->map_changing_lock);
> > > -                     /*
> > > -                      * If memory mappings are changing because of n=
on-cooperative
> > > -                      * operation (e.g. mremap) running in parallel,=
 bail out and
> > > -                      * request the user to retry later
> > > -                      */
> > > -                     if (atomic_read(&ctx->mmap_changing)) {
> > > -                             err =3D -EAGAIN;
> > > -                             break;
> > > -                     }
> > >
> > >                       dst_vma =3D NULL;
> > >                       goto retry;
> > > @@ -505,7 +616,12 @@ static __always_inline ssize_t mfill_atomic_huge=
tlb(
> > >
> > >  out_unlock:
> > >       up_read(&ctx->map_changing_lock);
> > > +out_unlock_vma:
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +     unlock_vma(dst_vma);
> > > +#else
> > >       mmap_read_unlock(dst_mm);
> > > +#endif
> > >  out:
> > >       if (folio)
> > >               folio_put(folio);
> > > @@ -597,7 +713,19 @@ static __always_inline ssize_t mfill_atomic(stru=
ct userfaultfd_ctx *ctx,
> > >       copied =3D 0;
> > >       folio =3D NULL;
> > >  retry:
> > > -     mmap_read_lock(dst_mm);
> > > +     /*
> > > +      * Make sure the vma is not shared, that the dst range is
> > > +      * both valid and fully within a single existing vma.
> > > +      */
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +     dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len);
> > > +#else
> > > +     dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_start, len);
> > > +#endif
> > > +     if (IS_ERR(dst_vma)) {
> > > +             err =3D PTR_ERR(dst_vma);
> > > +             goto out;
> > > +     }
> > >
> > >       /*
> > >        * If memory mappings are changing because of non-cooperative
> > > @@ -609,15 +737,6 @@ static __always_inline ssize_t mfill_atomic(stru=
ct userfaultfd_ctx *ctx,
> > >       if (atomic_read(&ctx->mmap_changing))
> > >               goto out_unlock;
> > >
> > > -     /*
> > > -      * Make sure the vma is not shared, that the dst range is
> > > -      * both valid and fully within a single existing vma.
> > > -      */
> > > -     err =3D -ENOENT;
> > > -     dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > -     if (!dst_vma)
> > > -             goto out_unlock;
> > > -
> > >       err =3D -EINVAL;
> > >       /*
> > >        * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SH=
ARED but
> > > @@ -647,16 +766,6 @@ static __always_inline ssize_t mfill_atomic(stru=
ct userfaultfd_ctx *ctx,
> > >           uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> > >               goto out_unlock;
> > >
> > > -     /*
> > > -      * Ensure the dst_vma has a anon_vma or this page
> > > -      * would get a NULL anon_vma when moved in the
> > > -      * dst_vma.
> > > -      */
> > > -     err =3D -ENOMEM;
> > > -     if (!(dst_vma->vm_flags & VM_SHARED) &&
> > > -         unlikely(anon_vma_prepare(dst_vma)))
> > > -             goto out_unlock;
> > > -
> > >       while (src_addr < src_start + len) {
> > >               pmd_t dst_pmdval;
> > >
> > > @@ -699,7 +808,11 @@ static __always_inline ssize_t mfill_atomic(stru=
ct userfaultfd_ctx *ctx,
> > >                       void *kaddr;
> > >
> > >                       up_read(&ctx->map_changing_lock);
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +                     unlock_vma(dst_vma);
> > > +#else
> > >                       mmap_read_unlock(dst_mm);
> > > +#endif
> > >                       BUG_ON(!folio);
> > >
> > >                       kaddr =3D kmap_local_folio(folio, 0);
> > > @@ -730,7 +843,11 @@ static __always_inline ssize_t mfill_atomic(stru=
ct userfaultfd_ctx *ctx,
> > >
> > >  out_unlock:
> > >       up_read(&ctx->map_changing_lock);
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +     unlock_vma(dst_vma);
> > > +#else
> > >       mmap_read_unlock(dst_mm);
> > > +#endif
> > >  out:
> > >       if (folio)
> > >               folio_put(folio);
> > > @@ -1267,16 +1384,67 @@ static int validate_move_areas(struct userfau=
ltfd_ctx *ctx,
> > >       if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> > >               return -EINVAL;
> > >
> > > -     /*
> > > -      * Ensure the dst_vma has a anon_vma or this page
> > > -      * would get a NULL anon_vma when moved in the
> > > -      * dst_vma.
> > > -      */
> > > -     if (unlikely(anon_vma_prepare(dst_vma)))
> > > -             return -ENOMEM;
> > > +     return 0;
> > > +}
> > > +
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +static int find_and_lock_vmas(struct mm_struct *mm,
> > > +                           unsigned long dst_start,
> > > +                           unsigned long src_start,
> > > +                           struct vm_area_struct **dst_vmap,
> > > +                           struct vm_area_struct **src_vmap)
> > > +{
> > > +     int err;
> > > +
> > > +     /* There is no need to prepare anon_vma for src_vma */
> > > +     *src_vmap =3D lock_vma(mm, src_start, false);
> > > +     if (!*src_vmap)
> > > +             return -ENOENT;
> > > +
> > > +     /* Ensure anon_vma is assigned for anonymous vma */
> > > +     *dst_vmap =3D lock_vma(mm, dst_start, true);
> > > +     err =3D -ENOENT;
> > > +     if (!*dst_vmap)
> > > +             goto out_unlock;
> > > +
> > > +     err =3D -ENOMEM;
> > > +     if (PTR_ERR(*dst_vmap) =3D=3D -ENOMEM)
> > > +             goto out_unlock;
> >
> > If you change lock_vma() to return the vma or ERR_PTR(-ENOENT) /
> > ERR_PTR(-ENOMEM), then you could change this to check IS_ERR() and
> > return the PTR_ERR().
> >
> > You could also use IS_ERR_OR_NULL here, but the first suggestion will
> > simplify your life for find_and_lock_dst_vma() and the error type to
> > return.
>=20
> Good suggestion. I'll make the change. Thanks
> >
> > What you have here will work though.
> >
> > >
> > >       return 0;
> > > +out_unlock:
> > > +     unlock_vma(*src_vmap);
> > > +     return err;
> > >  }
> > > +#else
> > > +static int lock_mm_and_find_vmas(struct mm_struct *mm,
> > > +                              unsigned long dst_start,
> > > +                              unsigned long src_start,
> > > +                              struct vm_area_struct **dst_vmap,
> > > +                              struct vm_area_struct **src_vmap)
> > > +{
> > > +     int err =3D -ENOENT;
> >
> > Nit: new line after declarations.
> >
> > > +     mmap_read_lock(mm);
> > > +
> > > +     *src_vmap =3D vma_lookup(mm, src_start);
> > > +     if (!*src_vmap)
> > > +             goto out_unlock;
> > > +
> > > +     *dst_vmap =3D vma_lookup(mm, dst_start);
> > > +     if (!*dst_vmap)
> > > +             goto out_unlock;
> > > +
> > > +     /* Ensure anon_vma is assigned */
> > > +     err =3D -ENOMEM;
> > > +     if (vma_is_anonymous(*dst_vmap) && anon_vma_prepare(*dst_vmap))
> > > +             goto out_unlock;
> > > +
> > > +     return 0;
> > > +out_unlock:
> > > +     mmap_read_unlock(mm);
> > > +     return err;
> > > +}
> > > +#endif
> > >
> > >  /**
> > >   * move_pages - move arbitrary anonymous pages of an existing vma
> > > @@ -1287,8 +1455,6 @@ static int validate_move_areas(struct userfault=
fd_ctx *ctx,
> > >   * @len: length of the virtual memory range
> > >   * @mode: flags from uffdio_move.mode
> > >   *
> > > - * Must be called with mmap_lock held for read.
> > > - *
> >
> > Will either use the mmap_lock in read mode or per-vma locking ?
>=20
> Makes sense. Will add it.
> >
> > >   * move_pages() remaps arbitrary anonymous pages atomically in zero
> > >   * copy. It only works on non shared anonymous pages because those c=
an
> > >   * be relocated without generating non linear anon_vmas in the rmap
> > > @@ -1355,10 +1521,10 @@ static int validate_move_areas(struct userfau=
ltfd_ctx *ctx,
> > >   * could be obtained. This is the only additional complexity added t=
o
> > >   * the rmap code to provide this anonymous page remapping functional=
ity.
> > >   */
> > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm=
,
> > > -                unsigned long dst_start, unsigned long src_start,
> > > -                unsigned long len, __u64 mode)
> > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_st=
art,
> > > +                unsigned long src_start, unsigned long len, __u64 mo=
de)
> > >  {
> > > +     struct mm_struct *mm =3D ctx->mm;
> >
> > You dropped the argument, but left the comment for the argument.
>=20
> Thanks, will fix it.
> >
> > >       struct vm_area_struct *src_vma, *dst_vma;
> > >       unsigned long src_addr, dst_addr;
> > >       pmd_t *src_pmd, *dst_pmd;
> > > @@ -1376,28 +1542,40 @@ ssize_t move_pages(struct userfaultfd_ctx *ct=
x, struct mm_struct *mm,
> > >           WARN_ON_ONCE(dst_start + len <=3D dst_start))
> > >               goto out;
> > >
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +     err =3D find_and_lock_vmas(mm, dst_start, src_start,
> > > +                              &dst_vma, &src_vma);
> > > +#else
> > > +     err =3D lock_mm_and_find_vmas(mm, dst_start, src_start,
> > > +                                 &dst_vma, &src_vma);
> > > +#endif
> >
> > I was hoping you could hide this completely, but it's probably better t=
o
> > show what's going on and the function names document it well.
>=20
> I wanted to hide unlock as it's called several times, but then I
> thought you wanted explicit calls to mmap_read_unlock() so didn't hide
> it. If you are ok can I define unlock_vma() for !CONFIG_PER_VMA_LOCK
> as well, calling mmap_read_unlock()?

My bigger problem was with the name.  We can't have unlock_vma()
just unlock the mm - it is confusing to read and I think it'll lead to
misunderstandings of what is really going on here.

Whatever you decide to do is fine as long as it's clear what's going on.
I think this is clear while hiding it could also be clear with the right
function name - I'm not sure what that would be; naming is hard.

Thanks,
Liam


