Return-Path: <linux-fsdevel+bounces-11012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACCB84FCE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356461C212B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB8883CB9;
	Fri,  9 Feb 2024 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cXFOgD2u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AF24ei2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961874E3A;
	Fri,  9 Feb 2024 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507103; cv=fail; b=tcKSU9RXMsyoSQfkM6gq5ht0Vkq8a6+CTpnKO2AjX2EAZrLyCX0T5nnIEZ9EqmUs6jev12I66sH8eRT+/jl0eXo6mZLfPmVFd38X+/olAqIZSYBVF3iP6Dn0kOxUq5Poo+oov8Xv6KOu0audPgNHVlPleRorqyZ1qLa70zhnhT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507103; c=relaxed/simple;
	bh=9B19pXpapZhna8O92iaVbSCXwWRKpOMfTNjAAflYWSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZWjDA1NuhPuEwC5xLfheGO4cNEN7iaYKAFM6T0i6vTLZ9M2HS1AnSXlsDJxSjZhSktMarIlDbmj+OA8AU4WAgipOzG5U0IrIPyQOpnmqEddfJs+J8UlGeLGNCV5UshCJ9PvQEBNIFpoB4rx94WdulT2ljLaruBloQwFojj0nt80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cXFOgD2u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AF24ei2b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419JGjDX025489;
	Fri, 9 Feb 2024 19:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=sgDQgjwuT+PBX6tpiUEuSFWkGNLRifcNHPzwHm2MqDY=;
 b=cXFOgD2uayWjzE1MtsKohTHmH2OKoS7D1YhL/3CUWQzNXqbAfuVywiDwftz4tel1FPdK
 JTnSWgr6vLzrGUGlIhJHVt4VA3G3EcHpiGPqV7IdyShzttzR8aOW/b+SYqQc20iVJBh4
 2c8dVDasuBIskS/+oLQgpnDyYGrOJv3/O+lqmuJyxUxWuJlDUN5rBHar+tjNcFev3Z6R
 t6ow98v2bWrfJYdqzjlXiQHKEQx0ujgMRwCsIui/wdFmOeXVRNxNxnXVrHh3cPCsiAXe
 7r7GgMz4UwTjBRlIIbW3GQDOuSk/46Ju4hBVsL2w8u60dhp5fdGYMgraQQcTeycpI4jf Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w5sexg444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 19:31:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419HhjZw038420;
	Fri, 9 Feb 2024 19:31:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxcjvqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 19:31:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3uyfp7PneHn+W46AlJO80WAQtwLcMI+VCAnvf4qGIQwATIKZPx/c2TwRCvs57ghxyzBv/WKK+1hY4JghGkultnv+gwaiRbiaQMa+fkxb3KHDR5k4yNgVsXtO1wMFn5ARCrE5PKd/KK3Ah8Tjm3fkocIMNQFzLenFVll1RJAUTTtrK4fVOgYS40Krq2QYqfOA6mrI+xf6hIgYXGSpSKiXJijb+vBjc8T0wPuHeudFDu6A7Fv+c4wigEWN/WOv1HuvJmavga0Ixevel5SbxheOzrgFWL2cmvD1BE2zW66tL5efm3oBKJ0ttGPK3mYx1S3DP02BtMxC810ezbaiqSIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgDQgjwuT+PBX6tpiUEuSFWkGNLRifcNHPzwHm2MqDY=;
 b=bvaQP0JRMvFqj+BId6sb/Nk0mSfr3Dlwn7fQQl4WBKLjoW2hg4BwxGiSX+22FQwkUuWfruKSnqnew8xzDxM35GpW8eezVWBnRxSfFZEqSS7MWJChVnvJ3ai59H/yUnaqmBO5Rd2Y+gn6qfu4GzqpYQafNiOgjGVAl/K44mLQ7WdBadmEnmvgqnOc5XYsJwuFFfGofCaDU88e+B+UwlUGMV4CcVcdH+L2YccC4VZyocUJgem3yA6vHdHNF97OeWHExn8NtjegIakDIuIELxW51gN2e6Lulir/c43SrlAR3qxl6Nu5ev30q4F1tTWpoe6sJTINwtH58Pc2o+tgrWSX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgDQgjwuT+PBX6tpiUEuSFWkGNLRifcNHPzwHm2MqDY=;
 b=AF24ei2bq53KISXjpUP7L63i2qiDeYJKPtwstYGQO+cILFEdx4k91AyeD8HmCX5b2lzaRBkQDU9z/Kw9D9N/0jodPftSb2RdgFHhSqvxAyUd9qHX7ntVvf2JqOmdbOPqpDyH3MyDoN0MSjUDrWGaNbQb/jmhGew3UpLVEu3JVh4=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by DS0PR10MB7067.namprd10.prod.outlook.com (2603:10b6:8:145::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 19:31:14 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 19:31:14 +0000
Date: Fri, 9 Feb 2024 14:31:10 -0500
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
Message-ID: <20240209193110.ltfdc6nolpoa2ccv@revolver>
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
 <20240209190605.7gokzhg7afy7ibyf@revolver>
 <CA+EESO7uR4azkf-V=E4XWTCaDL7xxNwNxcdnRi4hKaJQWxyxcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO7uR4azkf-V=E4XWTCaDL7xxNwNxcdnRi4hKaJQWxyxcA@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: CH5PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::29) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|DS0PR10MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b4a7cd-e5ed-446d-b963-08dc29a5ad8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4k/oBb9kk5vgaCkAo6aED1ldzRNztv03nYPaAqatFuCGlB4Xll3oQhewAvBdsXjr4iiUS65H23Kyd7T9AEIOq8CTbbGMYlspkKmA/jsWLebVjoH2J7ouWPaEqTMomQzROO5/FruLZ9bzTw787EhRCiT1zg8RzwGmFQSO2k4mQECFNrRkQDWIMXGgn7nEtfRI5f0OUNmQAIBwFfWbIOwxCBC43GcKDtkhZg1VIi83b9HQroC1BaZDECtwg7ifvzeqAO7rj0//9Q2xfAEmkeZr3NmDP1t7t4qlYxIDZZuGQ5wvOPeNeTVwmHRU7olV+GQVQEkp0xpHiqULmUlLXVvRssNajKlDyPi4knjQB2S8DYN+0B06yqOWTihWIkOQerAaFFkT24iGHRjOGtWuoDOxHOarACWRDnU0Ou5J5NXkU+T9cBbXkdJvyoymBn6ZCYOfUy+hsHqdy2iBynkE300B+mug4Ia9msRIWxPaxY3g0kmMlwH/ie1UFDcq/VoPF1ZYrMe10HGtotrAMIa0QcX81cIM5sOYzx7rAtfmWu7cG6th856G04InlSAbjDWi4s76
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(33716001)(6506007)(6666004)(478600001)(53546011)(6486002)(66556008)(2906002)(30864003)(66946007)(66476007)(5660300002)(7416002)(26005)(1076003)(9686003)(6512007)(38100700002)(86362001)(6916009)(8676002)(316002)(8936002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlJJcFJIVzVlTElwNVVqbVN4VU9nbzJ3Ky9JREF3Qm1zSTE0YjltM0ZpTU1M?=
 =?utf-8?B?Qmd5clNNKzVCaFRTbnY3SjF0K0RmZjBweG81QUxiQTd3K1B1Y000MG0rQjNQ?=
 =?utf-8?B?ejhXZjZQaGRFZWtKNnFvQlJDR2JheW1xWnlpV25EZDF5My9YQnJpeFZJcGpH?=
 =?utf-8?B?NDJ6ZU1xSXF0bUdOSldpNFlSVFBOQnFTRVVlSGRtVm5yTlhnUnBjV3lPRUpa?=
 =?utf-8?B?MUE2Q0s1NmQ0VVNXZXZ1cEVUV0xhTEVUblN3djJyczlwREg0MU96NVlsTHZ5?=
 =?utf-8?B?cnF6NGdWa2R5VktGYmxRWGFSL21rTjhybVkwb2hHaVVkRUxOOFJSVml1b0pi?=
 =?utf-8?B?MDcva2d5TEYrMUxYVnRhVGQrSU03bjhMMGoxMlN3MDQxcysxY1MyVUcxOEZn?=
 =?utf-8?B?NFdodGd6Y2QwMno5Y0lRTGY3ZXBRSE9mR2xVNXZ1SjlDN1gvNktLN2o3d1Vq?=
 =?utf-8?B?SnhDVUc1VGpmaFdtMEdxeFhqMDR1ek1JSG44STM5YWpRZjV1K1lqajFrb1Zy?=
 =?utf-8?B?YkVqcitTNVVGaCt6RWlOOTJ6T2FZMndnRlNlTEpYdk5FOVdrY1BhUGV0amJE?=
 =?utf-8?B?NFQzZXpnZFhHME13L09WT3JTc3M5MWMyQ053bDRnTGo4VXk4WkpzZDc1bEEv?=
 =?utf-8?B?MG1xbkVKRzAvVDhLaHpTLzQ2MTFiSnVqaW5pTVJsOTZmdDlMN1JMSWYxQXRz?=
 =?utf-8?B?NzF1RXcyOGcwdmhpdjZQSk9TUDlDM3Q2c3BNa0p1VDFJSW5Uc2MxYXZLZUty?=
 =?utf-8?B?ZHM0S0VmQnlGVWIyMlV6KzJvREN1OTdGTXFXOHZ3NVVDL1JRdUhKbUxucit4?=
 =?utf-8?B?YktBRjQ3R0hmbTFkeFdmczhwZDZ0ZmNmekxjczFrWElZdkxXc1hKSUJaN3py?=
 =?utf-8?B?YXNvcml6RjA3ZUNtVDFJQVZrYVYrVFp4MnFoL2lZVjFsb3k2UUg2RkM3UXox?=
 =?utf-8?B?UG5HZjFHL09aeXdTcEQ1TisrMHFlVmwrSkhPc09jMGQwVTNmWFVaU1VweUFN?=
 =?utf-8?B?bmcyS1ZpV2ZFNlBnakNvNkxtazc5T1VETzYzUmdwS1hISFBQb1pOVWtiWXhx?=
 =?utf-8?B?cWg4ZmxIcGkzTGdoNmUwa3VwOHcwTjR0d0t6VzliOTJrRmJLVjRvMGh2TmFy?=
 =?utf-8?B?azR5Z0M1a2NjUkNzSDJEa3o5dWJvL2xsSnlEZGlwR1duQVJwZWUzYXp2UkVl?=
 =?utf-8?B?bUdpRVo5N3dhYjdISWs4emk2K24wR0tPeXJqUVVPMisxWkZkeFVjL2RDWGYv?=
 =?utf-8?B?NlpZT01CM0RyZGNBT29FOGowcVZvcUdmNkVRVitpV056bTJ4U0JVSThjTzFM?=
 =?utf-8?B?WW54VTUvc1FTYzl5a29EWm0rM2x4eVR6eitwbGxlaDltSys3S1lWMkFvR3oy?=
 =?utf-8?B?eHIyWldOTUl1M2pMU3VIV1FIdGdWQkNZQklGeWVybmg1c1FRN1IyNW5WZDVq?=
 =?utf-8?B?M0pSY2RtTjRQYTVVV2ZRTXp2ZUVKOER1UDNGd3B1QnBsK1FLRHdMaFA4WVIy?=
 =?utf-8?B?dVJGSDcwY1diNjdpQjRxTmNaaUd0bGtuSXhKWVoyM01VN1hkWG52Rkx4ZjlN?=
 =?utf-8?B?VjhQN0ltMnl0ci9teW5BVlBydENmR3JXY0Y0Sm1ybHVnS3lERGtzYm1DN2lp?=
 =?utf-8?B?ZHhqUjFMcmhFS3FpeUVoRDA1MWRrVzdFZm9Db29WUFhmTWZvemJpam9NMlNF?=
 =?utf-8?B?a1Q0TFdrczRiZUdxNkpDVldZaG5hbDRUQU5pN3k5YjZHZjhHN0JDKzBYWE1R?=
 =?utf-8?B?ZTJaM2hoL1VnOUlsK2FGY1VqMmZmRXZ3WXBPR1VrcGFxMGZCUHUrcjNkQ0Rk?=
 =?utf-8?B?V2VzaXpTNmppLzZPNU1iTG1uNEMyZ1c1eE9RZ1FkZUNSVndLS09WWlpycHA0?=
 =?utf-8?B?RW42ZVNheU5hOElZbFNaSC9QcnJ2UGpEZVNRK3FoSmFpam8vTDI5aWY5M3d5?=
 =?utf-8?B?QjZJbC9YY1ZyenBtcDRmQ25mbDRZMlBUNHVuNEo5c3lCRmNWMDE1OWFTLzhC?=
 =?utf-8?B?ZXRRZUpac0ZhYWk4OXJEdTN5SkV6SDdESlE4cEJPeWkwVi9BTEc4bmtMK0h1?=
 =?utf-8?B?VU9NWHd1MVMwVWdmblVLQVVPRHhxOEQ3b3BaVllMcnhtVEwvclhmY2JaY3Fa?=
 =?utf-8?B?bEpQWUxkYjB5cnhNWXkyOXEwY1RkeGlMdisxVkRsdCtYY3BYSTZtSVhTcVVt?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dfBc5iwkDCMxSJZII3755vMy3pVhVzpUStIrVxVgB00/M28tHyShKfOkP0+NyHDzs7G2TpI/bVM4QQdaNgt3VguO+FG+7sycYYLEDVO5Mxs+IFt+E6RUf7U0+/Wwo76p3983y7MYhIFsfinzMd4dibSg4b08TmKgzeNXkFoozZfqMH/LssNBcaBCeJ6GqP1xOxqi05Xz4yJIYBIy5D3kNz4GDLWgFO7IeiunZ1kHO4HfEKPvalKUpOIidt2ThatfgJxwNTeACALnwcD/AKdltiJO5oux4HcmJ0klilDLbKGdVbUONDXPKT7m+5mQNkmB/8fnPErtBz2lmd3S4dWW3QHZZOkI9e+Oc1RlNSDrC7WEiVyXTzy9oJLkxJ5tvnWPG5wGESeKKyeSXC8ZOpSKT9t/gQSRK1fnUEKDKdPAsRE8hT4VBVDCTIUEnVyhIRXJ9PzMjEnMsAkJtXoyjUibwjNtOvxGqhKTgjLNYbZVC6n0dD9iRsSLW1r37BayimrnmX3eWdmjepagu9SrtTONL5ADetE0zKk2nKeA9Ee5uBGQDDhnyMQws64M8yZKcfReXFJxgVHTUalOVue/x14n84uMZ3ejrWoUz5SzqH7cgjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b4a7cd-e5ed-446d-b963-08dc29a5ad8c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:31:13.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0OFTn9vovFMIsRJHi1pt9T2u9HnF7fSPbGrjiqz3bDh5wLe0oJ7stJhObfzBbtHbifgVKRe0oTVDMzuHiY7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_16,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090143
X-Proofpoint-GUID: E9TrmysLBHzr4pLerAr7D0TEdm0RlB-x
X-Proofpoint-ORIG-GUID: E9TrmysLBHzr4pLerAr7D0TEdm0RlB-x

* Lokesh Gidra <lokeshgidra@google.com> [240209 14:21]:
> On Fri, Feb 9, 2024 at 11:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240209 13:02]:
> > > On Thu, Feb 8, 2024 at 7:07=E2=80=AFPM Liam R. Howlett <Liam.Howlett@=
oracle.com> wrote:
> > > >
> > > > * Lokesh Gidra <lokeshgidra@google.com> [240208 16:22]:
> > > > > All userfaultfd operations, except write-protect, opportunistical=
ly use
> > > > > per-vma locks to lock vmas. On failure, attempt again inside mmap=
_lock
> > > > > critical section.
> > > > >
> > > > > Write-protect operation requires mmap_lock as it iterates over mu=
ltiple
> > > > > vmas.
> > > > >
> > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > ---
> > > > >  fs/userfaultfd.c              |  13 +-
> > > > >  include/linux/userfaultfd_k.h |   5 +-
> > > > >  mm/userfaultfd.c              | 356 ++++++++++++++++++++++++++--=
------
> > > > >  3 files changed, 275 insertions(+), 99 deletions(-)
> > > > >
> > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > index c00a021bcce4..60dcfafdc11a 100644
> > > > > --- a/fs/userfaultfd.c
> > > > > +++ b/fs/userfaultfd.c
> > > > > @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfau=
ltfd_ctx *ctx,
> > > > >               return -EINVAL;
> > > > >
> > > > >       if (mmget_not_zero(mm)) {
> > > > > -             mmap_read_lock(mm);
> > > > > -
> > > > > -             /* Re-check after taking map_changing_lock */
> > > > > -             down_read(&ctx->map_changing_lock);
> > > > > -             if (likely(!atomic_read(&ctx->mmap_changing)))
> > > > > -                     ret =3D move_pages(ctx, mm, uffdio_move.dst=
, uffdio_move.src,
> > > > > -                                      uffdio_move.len, uffdio_mo=
ve.mode);
> > > > > -             else
> > > > > -                     ret =3D -EAGAIN;
> > > > > -             up_read(&ctx->map_changing_lock);
> > > > > -             mmap_read_unlock(mm);
> > > > > +             ret =3D move_pages(ctx, uffdio_move.dst, uffdio_mov=
e.src,
> > > > > +                              uffdio_move.len, uffdio_move.mode)=
;
> > > > >               mmput(mm);
> > > > >       } else {
> > > > >               return -ESRCH;
> > > > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfa=
ultfd_k.h
> > > > > index 3210c3552976..05d59f74fc88 100644
> > > > > --- a/include/linux/userfaultfd_k.h
> > > > > +++ b/include/linux/userfaultfd_k.h
> > > > > @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_stru=
ct *vma,
> > > > >  /* move_pages */
> > > > >  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > > >  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct=
 *mm,
> > > > > -                unsigned long dst_start, unsigned long src_start=
,
> > > > > -                unsigned long len, __u64 flags);
> > > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long ds=
t_start,
> > > > > +                unsigned long src_start, unsigned long len, __u6=
4 flags);
> > > > >  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pm=
d_t *src_pmd, pmd_t dst_pmdval,
> > > > >                       struct vm_area_struct *dst_vma,
> > > > >                       struct vm_area_struct *src_vma,
> > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > index 74aad0831e40..1e25768b2136 100644
> > > > > --- a/mm/userfaultfd.c
> > > > > +++ b/mm/userfaultfd.c
> > > > > @@ -19,20 +19,12 @@
> > > > >  #include <asm/tlb.h>
> > > > >  #include "internal.h"
> > > > >
> > > > > -static __always_inline
> > > > > -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> > > > > -                                 unsigned long dst_start,
> > > > > -                                 unsigned long len)
> > > >
> > > > You could probably leave the __always_inline for this.
> > >
> > > Sure
> > > >
> > > > > +static bool validate_dst_vma(struct vm_area_struct *dst_vma,
> > > > > +                          unsigned long dst_end)
> > > > >  {
> > > > > -     /*
> > > > > -      * Make sure that the dst range is both valid and fully wit=
hin a
> > > > > -      * single existing vma.
> > > > > -      */
> > > > > -     struct vm_area_struct *dst_vma;
> > > > > -
> > > > > -     dst_vma =3D find_vma(dst_mm, dst_start);
> > > > > -     if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > > > > -             return NULL;
> > > > > +     /* Make sure that the dst range is fully within dst_vma. */
> > > > > +     if (dst_end > dst_vma->vm_end)
> > > > > +             return false;
> > > > >
> > > > >       /*
> > > > >        * Check the vma is registered in uffd, this is required to
> > > > > @@ -40,11 +32,125 @@ struct vm_area_struct *find_dst_vma(struct m=
m_struct *dst_mm,
> > > > >        * time.
> > > > >        */
> > > > >       if (!dst_vma->vm_userfaultfd_ctx.ctx)
> > > > > -             return NULL;
> > > > > +             return false;
> > > > > +
> > > > > +     return true;
> > > > > +}
> > > > > +
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +/*
> > > > > + * lock_vma() - Lookup and lock vma corresponding to @address.
> > > > > + * @mm: mm to search vma in.
> > > > > + * @address: address that the vma should contain.
> > > > > + * @prepare_anon: If true, then prepare the vma (if private) wit=
h anon_vma.
> > > > > + *
> > > > > + * Should be called without holding mmap_lock. vma should be unl=
ocked after use
> > > > > + * with unlock_vma().
> > > > > + *
> > > > > + * Return: A locked vma containing @address, NULL if no vma is f=
ound, or
> > > > > + * -ENOMEM if anon_vma couldn't be allocated.
> > > > > + */
> > > > > +static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > > > +                                    unsigned long address,
> > > > > +                                    bool prepare_anon)
> > > > > +{
> > > > > +     struct vm_area_struct *vma;
> > > > > +
> > > > > +     vma =3D lock_vma_under_rcu(mm, address);
> > > > > +     if (vma) {
> > > > > +             /*
> > > > > +              * lock_vma_under_rcu() only checks anon_vma for pr=
ivate
> > > > > +              * anonymous mappings. But we need to ensure it is =
assigned in
> > > > > +              * private file-backed vmas as well.
> > > > > +              */
> > > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> > > > > +                 !vma->anon_vma)
> > > > > +                     vma_end_read(vma);
> > > > > +             else
> > > > > +                     return vma;
> > > > > +     }
> > > > > +
> > > > > +     mmap_read_lock(mm);
> > > > > +     vma =3D vma_lookup(mm, address);
> > > > > +     if (vma) {
> > > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> > > > > +                 anon_vma_prepare(vma)) {
> > > > > +                     vma =3D ERR_PTR(-ENOMEM);
> > > > > +             } else {
> > > > > +                     /*
> > > > > +                      * We cannot use vma_start_read() as it may=
 fail due to
> > > > > +                      * false locked (see comment in vma_start_r=
ead()). We
> > > > > +                      * can avoid that by directly locking vm_lo=
ck under
> > > > > +                      * mmap_lock, which guarantees that nobody =
can lock the
> > > > > +                      * vma for write (vma_start_write()) under =
us.
> > > > > +                      */
> > > > > +                     down_read(&vma->vm_lock->lock);
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     mmap_read_unlock(mm);
> > > > > +     return vma;
> > > > > +}
> > > > > +
> > > > > +static void unlock_vma(struct vm_area_struct *vma)
> > > > > +{
> > > > > +     vma_end_read(vma);
> > > > > +}
> > > > > +
> > > > > +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_st=
ruct *dst_mm,
> > > > > +                                                 unsigned long d=
st_start,
> > > > > +                                                 unsigned long l=
en)
> > > > > +{
> > > > > +     struct vm_area_struct *dst_vma;
> > > > > +
> > > > > +     /* Ensure anon_vma is assigned for private vmas */
> > > > > +     dst_vma =3D lock_vma(dst_mm, dst_start, true);
> > > > > +
> > > > > +     if (!dst_vma)
> > > > > +             return ERR_PTR(-ENOENT);
> > > > > +
> > > > > +     if (PTR_ERR(dst_vma) =3D=3D -ENOMEM)
> > > > > +             return dst_vma;
> > > > > +
> > > > > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > > > > +             goto out_unlock;
> > > > >
> > > > >       return dst_vma;
> > > > > +out_unlock:
> > > > > +     unlock_vma(dst_vma);
> > > > > +     return ERR_PTR(-ENOENT);
> > > > >  }
> > > > >
> > > > > +#else
> > > > > +
> > > > > +static struct vm_area_struct *lock_mm_and_find_dst_vma(struct mm=
_struct *dst_mm,
> > > > > +                                                    unsigned lon=
g dst_start,
> > > > > +                                                    unsigned lon=
g len)
> > > > > +{
> > > > > +     struct vm_area_struct *dst_vma;
> > > > > +     int err =3D -ENOENT;
> > > > > +
> > > > > +     mmap_read_lock(dst_mm);
> > > > > +     dst_vma =3D vma_lookup(dst_mm, dst_start);
> > > > > +     if (!dst_vma)
> > > > > +             goto out_unlock;
> > > > > +
> > > > > +     /* Ensure anon_vma is assigned for private vmas */
> > > > > +     if (!(dst_vma->vm_flags & VM_SHARED) && anon_vma_prepare(ds=
t_vma)) {
> > > > > +             err =3D -ENOMEM;
> > > > > +             goto out_unlock;
> > > > > +     }
> > > > > +
> > > > > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > > > > +             goto out_unlock;
> > > > > +
> > > > > +     return dst_vma;
> > > > > +out_unlock:
> > > > > +     mmap_read_unlock(dst_mm);
> > > > > +     return ERR_PTR(err);
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  /* Check if dst_addr is outside of file's size. Must be called w=
ith ptl held. */
> > > > >  static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
> > > > >                                unsigned long dst_addr)
> > > > > @@ -350,7 +456,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *=
mm, unsigned long address)
> > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > >  /*
> > > > >   * mfill_atomic processing for HUGETLB vmas.  Note that this rou=
tine is
> > > > > - * called with mmap_lock held, it will release mmap_lock before =
returning.
> > > > > + * called with either vma-lock or mmap_lock held, it will releas=
e the lock
> > > > > + * before returning.
> > > > >   */
> > > > >  static __always_inline ssize_t mfill_atomic_hugetlb(
> > > > >                                             struct userfaultfd_ct=
x *ctx,
> > > > > @@ -361,7 +468,6 @@ static __always_inline ssize_t mfill_atomic_h=
ugetlb(
> > > > >                                             uffd_flags_t flags)
> > > > >  {
> > > > >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > > > > -     int vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > >       ssize_t err;
> > > > >       pte_t *dst_pte;
> > > > >       unsigned long src_addr, dst_addr;
> > > > > @@ -380,7 +486,11 @@ static __always_inline ssize_t mfill_atomic_=
hugetlb(
> > > > >        */
> > > > >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > > > >               up_read(&ctx->map_changing_lock);
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +             unlock_vma(dst_vma);
> > > > > +#else
> > > > >               mmap_read_unlock(dst_mm);
> > > > > +#endif
> > > > >               return -EINVAL;
> > > > >       }
> > > > >
> > > > > @@ -403,24 +513,32 @@ static __always_inline ssize_t mfill_atomic=
_hugetlb(
> > > > >        * retry, dst_vma will be set to NULL and we must lookup ag=
ain.
> > > > >        */
> > > > >       if (!dst_vma) {
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +             dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start=
, len);
> > > > > +#else
> > > > > +             dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_st=
art, len);
> > > > > +#endif
> > > > > +             if (IS_ERR(dst_vma)) {
> > > > > +                     err =3D PTR_ERR(dst_vma);
> > > > > +                     goto out;
> > > > > +             }
> > > > > +
> > > > >               err =3D -ENOENT;
> > > > > -             dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > > -             if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> > > > > -                     goto out_unlock;
> > > > > +             if (!is_vm_hugetlb_page(dst_vma))
> > > > > +                     goto out_unlock_vma;
> > > > >
> > > > >               err =3D -EINVAL;
> > > > >               if (vma_hpagesize !=3D vma_kernel_pagesize(dst_vma)=
)
> > > > > -                     goto out_unlock;
> > > > > -
> > > > > -             vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > > -     }
> > > > > +                     goto out_unlock_vma;
> > > > >
> > > > > -     /*
> > > > > -      * If not shared, ensure the dst_vma has a anon_vma.
> > > > > -      */
> > > > > -     err =3D -ENOMEM;
> > > > > -     if (!vm_shared) {
> > > > > -             if (unlikely(anon_vma_prepare(dst_vma)))
> > > > > +             /*
> > > > > +              * If memory mappings are changing because of non-c=
ooperative
> > > > > +              * operation (e.g. mremap) running in parallel, bai=
l out and
> > > > > +              * request the user to retry later
> > > > > +              */
> > > > > +             down_read(&ctx->map_changing_lock);
> > > > > +             err =3D -EAGAIN;
> > > > > +             if (atomic_read(&ctx->mmap_changing))
> > > > >                       goto out_unlock;
> > > > >       }
> > > > >
> > > > > @@ -465,7 +583,11 @@ static __always_inline ssize_t mfill_atomic_=
hugetlb(
> > > > >
> > > > >               if (unlikely(err =3D=3D -ENOENT)) {
> > > > >                       up_read(&ctx->map_changing_lock);
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +                     unlock_vma(dst_vma);
> > > > > +#else
> > > > >                       mmap_read_unlock(dst_mm);
> > > > > +#endif
> > > > >                       BUG_ON(!folio);
> > > > >
> > > > >                       err =3D copy_folio_from_user(folio,
> > > > > @@ -474,17 +596,6 @@ static __always_inline ssize_t mfill_atomic_=
hugetlb(
> > > > >                               err =3D -EFAULT;
> > > > >                               goto out;
> > > > >                       }
> > > > > -                     mmap_read_lock(dst_mm);
> > > > > -                     down_read(&ctx->map_changing_lock);
> > > > > -                     /*
> > > > > -                      * If memory mappings are changing because =
of non-cooperative
> > > > > -                      * operation (e.g. mremap) running in paral=
lel, bail out and
> > > > > -                      * request the user to retry later
> > > > > -                      */
> > > > > -                     if (atomic_read(&ctx->mmap_changing)) {
> > > > > -                             err =3D -EAGAIN;
> > > > > -                             break;
> > > > > -                     }
> > > > >
> > > > >                       dst_vma =3D NULL;
> > > > >                       goto retry;
> > > > > @@ -505,7 +616,12 @@ static __always_inline ssize_t mfill_atomic_=
hugetlb(
> > > > >
> > > > >  out_unlock:
> > > > >       up_read(&ctx->map_changing_lock);
> > > > > +out_unlock_vma:
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +     unlock_vma(dst_vma);
> > > > > +#else
> > > > >       mmap_read_unlock(dst_mm);
> > > > > +#endif
> > > > >  out:
> > > > >       if (folio)
> > > > >               folio_put(folio);
> > > > > @@ -597,7 +713,19 @@ static __always_inline ssize_t mfill_atomic(=
struct userfaultfd_ctx *ctx,
> > > > >       copied =3D 0;
> > > > >       folio =3D NULL;
> > > > >  retry:
> > > > > -     mmap_read_lock(dst_mm);
> > > > > +     /*
> > > > > +      * Make sure the vma is not shared, that the dst range is
> > > > > +      * both valid and fully within a single existing vma.
> > > > > +      */
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +     dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len);
> > > > > +#else
> > > > > +     dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_start, len=
);
> > > > > +#endif
> > > > > +     if (IS_ERR(dst_vma)) {
> > > > > +             err =3D PTR_ERR(dst_vma);
> > > > > +             goto out;
> > > > > +     }
> > > > >
> > > > >       /*
> > > > >        * If memory mappings are changing because of non-cooperati=
ve
> > > > > @@ -609,15 +737,6 @@ static __always_inline ssize_t mfill_atomic(=
struct userfaultfd_ctx *ctx,
> > > > >       if (atomic_read(&ctx->mmap_changing))
> > > > >               goto out_unlock;
> > > > >
> > > > > -     /*
> > > > > -      * Make sure the vma is not shared, that the dst range is
> > > > > -      * both valid and fully within a single existing vma.
> > > > > -      */
> > > > > -     err =3D -ENOENT;
> > > > > -     dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > > -     if (!dst_vma)
> > > > > -             goto out_unlock;
> > > > > -
> > > > >       err =3D -EINVAL;
> > > > >       /*
> > > > >        * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MA=
P_SHARED but
> > > > > @@ -647,16 +766,6 @@ static __always_inline ssize_t mfill_atomic(=
struct userfaultfd_ctx *ctx,
> > > > >           uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> > > > >               goto out_unlock;
> > > > >
> > > > > -     /*
> > > > > -      * Ensure the dst_vma has a anon_vma or this page
> > > > > -      * would get a NULL anon_vma when moved in the
> > > > > -      * dst_vma.
> > > > > -      */
> > > > > -     err =3D -ENOMEM;
> > > > > -     if (!(dst_vma->vm_flags & VM_SHARED) &&
> > > > > -         unlikely(anon_vma_prepare(dst_vma)))
> > > > > -             goto out_unlock;
> > > > > -
> > > > >       while (src_addr < src_start + len) {
> > > > >               pmd_t dst_pmdval;
> > > > >
> > > > > @@ -699,7 +808,11 @@ static __always_inline ssize_t mfill_atomic(=
struct userfaultfd_ctx *ctx,
> > > > >                       void *kaddr;
> > > > >
> > > > >                       up_read(&ctx->map_changing_lock);
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +                     unlock_vma(dst_vma);
> > > > > +#else
> > > > >                       mmap_read_unlock(dst_mm);
> > > > > +#endif
> > > > >                       BUG_ON(!folio);
> > > > >
> > > > >                       kaddr =3D kmap_local_folio(folio, 0);
> > > > > @@ -730,7 +843,11 @@ static __always_inline ssize_t mfill_atomic(=
struct userfaultfd_ctx *ctx,
> > > > >
> > > > >  out_unlock:
> > > > >       up_read(&ctx->map_changing_lock);
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +     unlock_vma(dst_vma);
> > > > > +#else
> > > > >       mmap_read_unlock(dst_mm);
> > > > > +#endif
> > > > >  out:
> > > > >       if (folio)
> > > > >               folio_put(folio);
> > > > > @@ -1267,16 +1384,67 @@ static int validate_move_areas(struct use=
rfaultfd_ctx *ctx,
> > > > >       if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma=
))
> > > > >               return -EINVAL;
> > > > >
> > > > > -     /*
> > > > > -      * Ensure the dst_vma has a anon_vma or this page
> > > > > -      * would get a NULL anon_vma when moved in the
> > > > > -      * dst_vma.
> > > > > -      */
> > > > > -     if (unlikely(anon_vma_prepare(dst_vma)))
> > > > > -             return -ENOMEM;
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +static int find_and_lock_vmas(struct mm_struct *mm,
> > > > > +                           unsigned long dst_start,
> > > > > +                           unsigned long src_start,
> > > > > +                           struct vm_area_struct **dst_vmap,
> > > > > +                           struct vm_area_struct **src_vmap)
> > > > > +{
> > > > > +     int err;
> > > > > +
> > > > > +     /* There is no need to prepare anon_vma for src_vma */
> > > > > +     *src_vmap =3D lock_vma(mm, src_start, false);
> > > > > +     if (!*src_vmap)
> > > > > +             return -ENOENT;
> > > > > +
> > > > > +     /* Ensure anon_vma is assigned for anonymous vma */
> > > > > +     *dst_vmap =3D lock_vma(mm, dst_start, true);
> > > > > +     err =3D -ENOENT;
> > > > > +     if (!*dst_vmap)
> > > > > +             goto out_unlock;
> > > > > +
> > > > > +     err =3D -ENOMEM;
> > > > > +     if (PTR_ERR(*dst_vmap) =3D=3D -ENOMEM)
> > > > > +             goto out_unlock;
> > > >
> > > > If you change lock_vma() to return the vma or ERR_PTR(-ENOENT) /
> > > > ERR_PTR(-ENOMEM), then you could change this to check IS_ERR() and
> > > > return the PTR_ERR().
> > > >
> > > > You could also use IS_ERR_OR_NULL here, but the first suggestion wi=
ll
> > > > simplify your life for find_and_lock_dst_vma() and the error type t=
o
> > > > return.
> > >
> > > Good suggestion. I'll make the change. Thanks
> > > >
> > > > What you have here will work though.
> > > >
> > > > >
> > > > >       return 0;
> > > > > +out_unlock:
> > > > > +     unlock_vma(*src_vmap);
> > > > > +     return err;
> > > > >  }
> > > > > +#else
> > > > > +static int lock_mm_and_find_vmas(struct mm_struct *mm,
> > > > > +                              unsigned long dst_start,
> > > > > +                              unsigned long src_start,
> > > > > +                              struct vm_area_struct **dst_vmap,
> > > > > +                              struct vm_area_struct **src_vmap)
> > > > > +{
> > > > > +     int err =3D -ENOENT;
> > > >
> > > > Nit: new line after declarations.
> > > >
> > > > > +     mmap_read_lock(mm);
> > > > > +
> > > > > +     *src_vmap =3D vma_lookup(mm, src_start);
> > > > > +     if (!*src_vmap)
> > > > > +             goto out_unlock;
> > > > > +
> > > > > +     *dst_vmap =3D vma_lookup(mm, dst_start);
> > > > > +     if (!*dst_vmap)
> > > > > +             goto out_unlock;
> > > > > +
> > > > > +     /* Ensure anon_vma is assigned */
> > > > > +     err =3D -ENOMEM;
> > > > > +     if (vma_is_anonymous(*dst_vmap) && anon_vma_prepare(*dst_vm=
ap))
> > > > > +             goto out_unlock;
> > > > > +
> > > > > +     return 0;
> > > > > +out_unlock:
> > > > > +     mmap_read_unlock(mm);
> > > > > +     return err;
> > > > > +}
> > > > > +#endif
> > > > >
> > > > >  /**
> > > > >   * move_pages - move arbitrary anonymous pages of an existing vm=
a
> > > > > @@ -1287,8 +1455,6 @@ static int validate_move_areas(struct userf=
aultfd_ctx *ctx,
> > > > >   * @len: length of the virtual memory range
> > > > >   * @mode: flags from uffdio_move.mode
> > > > >   *
> > > > > - * Must be called with mmap_lock held for read.
> > > > > - *
> > > >
> > > > Will either use the mmap_lock in read mode or per-vma locking ?
> > >
> > > Makes sense. Will add it.
> > > >
> > > > >   * move_pages() remaps arbitrary anonymous pages atomically in z=
ero
> > > > >   * copy. It only works on non shared anonymous pages because tho=
se can
> > > > >   * be relocated without generating non linear anon_vmas in the r=
map
> > > > > @@ -1355,10 +1521,10 @@ static int validate_move_areas(struct use=
rfaultfd_ctx *ctx,
> > > > >   * could be obtained. This is the only additional complexity add=
ed to
> > > > >   * the rmap code to provide this anonymous page remapping functi=
onality.
> > > > >   */
> > > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct=
 *mm,
> > > > > -                unsigned long dst_start, unsigned long src_start=
,
> > > > > -                unsigned long len, __u64 mode)
> > > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long ds=
t_start,
> > > > > +                unsigned long src_start, unsigned long len, __u6=
4 mode)
> > > > >  {
> > > > > +     struct mm_struct *mm =3D ctx->mm;
> > > >
> > > > You dropped the argument, but left the comment for the argument.
> > >
> > > Thanks, will fix it.
> > > >
> > > > >       struct vm_area_struct *src_vma, *dst_vma;
> > > > >       unsigned long src_addr, dst_addr;
> > > > >       pmd_t *src_pmd, *dst_pmd;
> > > > > @@ -1376,28 +1542,40 @@ ssize_t move_pages(struct userfaultfd_ctx=
 *ctx, struct mm_struct *mm,
> > > > >           WARN_ON_ONCE(dst_start + len <=3D dst_start))
> > > > >               goto out;
> > > > >
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +     err =3D find_and_lock_vmas(mm, dst_start, src_start,
> > > > > +                              &dst_vma, &src_vma);
> > > > > +#else
> > > > > +     err =3D lock_mm_and_find_vmas(mm, dst_start, src_start,
> > > > > +                                 &dst_vma, &src_vma);
> > > > > +#endif
> > > >
> > > > I was hoping you could hide this completely, but it's probably bett=
er to
> > > > show what's going on and the function names document it well.
> > >
> > > I wanted to hide unlock as it's called several times, but then I
> > > thought you wanted explicit calls to mmap_read_unlock() so didn't hid=
e
> > > it. If you are ok can I define unlock_vma() for !CONFIG_PER_VMA_LOCK
> > > as well, calling mmap_read_unlock()?
> >
> > My bigger problem was with the name.  We can't have unlock_vma()
> > just unlock the mm - it is confusing to read and I think it'll lead to
> > misunderstandings of what is really going on here.
> >
> > Whatever you decide to do is fine as long as it's clear what's going on=
.
> > I think this is clear while hiding it could also be clear with the righ=
t
> > function name - I'm not sure what that would be; naming is hard.
>=20
> Maybe unlock_mm_or_vma() ? If not then I'll just keep it as is.
>=20

Maybe just leave it as it is unless someone else has issue with it.
Using some form of uffd_unlock name runs into the question of that
atomic and the new lock.



