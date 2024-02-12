Return-Path: <linux-fsdevel+bounces-11185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0922C851E7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E1EB26FCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E30481AD;
	Mon, 12 Feb 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCN1/9Bu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dE+tIYn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149447F64;
	Mon, 12 Feb 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768721; cv=fail; b=sY0OB0hfTlZ2UhnLn7u2ZuLxDTad6lP3ik61gc9u+WWbTHQD7sI6ZuQpWQwvRHxP4Zu08bIXpYREiSGx6IHGLDtlB02Aet0XzGwDlxr1zEwIk7UoPuXYRBHMBEGFB73AzY3VIIkza1gBFBMGuUkjPDBQ1W/d2w1UPujOcO6hUe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768721; c=relaxed/simple;
	bh=I/e+2LSNhozvMowMMK2yp3IqkODLhAYx8pnU4fihkHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lJGOg0MTbvGwlU7ToBHH5pRJvaZ+wfsQ/0YZ15g473Dr6a5R4glOWfZwNKDn0JTLum/cyMujOinJj+MjGQBZdJA/0owHByVJm31+cbgcn0AcIZCfhEgIIvnwbQ/E9BLvMC0mWMgASkq0oo7xCAnQesa+b5uQyiL7qlFoTN6dm38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCN1/9Bu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dE+tIYn1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CI7bfJ003005;
	Mon, 12 Feb 2024 20:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=lT9QDZYnHZU/dZ4DOG+m2FsyuEUHtgTyrnxtCORxWLk=;
 b=NCN1/9Bu5Sq7C6vmIBk4qnsnAAzOr4/vW7QbcepSp8Coype585VhgmibQKHrq/u+Hs2x
 C0PWZE0TI9BXfX4h7iIwesvgL7x8Cl30o6y+rXeImuWhxkLukmpv0/2FINVQKBf29eOz
 BzgpHci5l15A/sm2qnFEk5lXHRTaq9AtMqR1XwePKs8kIjf86FZr4dOjsVL5H6o0RwLd
 R8HG8l3bPZiWxJFB7DRr68+MSMI2TCpq4eh8sTAC9jeIWFgyxVemX7dsOgrja1rs9xT7
 /eksNeM8lVjDDrWPwEekxyUioCZ/K9HVlQkOrdBTo9qsX+9S4scPbIK7oaDD2AUBsSC1 MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7mpqgy1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 20:11:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CJf9TR014963;
	Mon, 12 Feb 2024 20:11:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk612u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 20:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLJEpm1ofpFWKTgSc8E3+PuGDFv2nmv+VEGnrNK+Mz54wusgCSrVGZ9XvyHUHlihzWfTjd05UD98iA+JtZLmV/SctalWiisoe2Ta7aN8lh+67OZ7o37w6YCH3WJ73LkwGG9HShFYNPGI+F2nkZ2rlTJXTKWEz16XKHXZu/i1WcvZR+eI/cUhgV6Qj8MuCQDETxnZYiLI79E2gQCWLPOWSAQw1M5KMxoED1kaxNoF4USAg3cUGFzskbfmqq8VR8VbsQzA1Q8cIofVqsD8zumvGUDK+IRrfRs6JCibz57A3Tv3jgVkOygpbqKk/AR9iAdpvADcd6gJkCbBib6YcoXnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT9QDZYnHZU/dZ4DOG+m2FsyuEUHtgTyrnxtCORxWLk=;
 b=feKuAY30/DN0PhLn4JVUUr6vt1jQ4qmFV1k62D0/3UXeLezujWagVCzRrFtOhf88qnEZEOgX3n/N3Qif3m3S6DbJlxXVbqan0HizpNalrg2LChTt8P00Yrr+r9BfC6cbFaquMo+lUGGv2ZlAsQYSvjojAK7fDagXyAVQgWn7CedzJB49y+th1hbzOEYW2gurpkqGRFZJNZBT2tB8aEbs0wcKoOtJG+HBwrPx3/Oarfq2FjsdnF6saYNhhgahXXujAWpOc3eNrSuyF0J2r7/aYcJICBeYGfoLJEsh/+glPivVT99GMCBEM/NUwaoOXg1NE5mA5gJwOYk88caoibBJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT9QDZYnHZU/dZ4DOG+m2FsyuEUHtgTyrnxtCORxWLk=;
 b=dE+tIYn1sAkvCLg9/bXaeJTQG1obO/5NzjYV2ZdaDvto/gTrvGXcIiStYs4jWAzgkhiHoUu8aRyLvkCzMaKji3Xfh0hgXq8Xd7SezEZTUVhZf4ElOE4LKLGjRyNgj+s1YzMX9+6QgtMNQlX3L5vtASzVmoNASMZpg8zczaNzIN0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4783.namprd10.prod.outlook.com (2603:10b6:a03:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 20:11:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 20:11:37 +0000
Date: Mon, 12 Feb 2024 15:11:34 -0500
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
Message-ID: <20240212201134.fqys2zlixy4z565s@revolver>
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
 <20240209193110.ltfdc6nolpoa2ccv@revolver>
 <CA+EESO4mbS_zB6AutaGZz1Jdx1uLFy5JqhyjnDHND4tY=3bn7Q@mail.gmail.com>
 <20240212151959.vnpqzvpvztabxpiv@revolver>
 <CA+EESO706V0OuX4pmX87t4YqrOxa9cLVXhhTPkFh22wLbVDD8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO706V0OuX4pmX87t4YqrOxa9cLVXhhTPkFh22wLbVDD8Q@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: CH0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:610:e7::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c11eb21-8190-4443-1641-08dc2c06d129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	csGKsKrT/d+bkDCOEC2KYcAxQkgc7CBmiWJy+a/gOOkLDbjrTz3J0opIraDa5tAQvPUJDpg5+gl1xhY9lefiR41pqb1g4YTcnvygqIP+my/oS+xF+2jDVqUBdmeo69o4cjT0VvZer76pPzkrTCJ6NCbSomKtis3sS2OUmpQI1z/SOdmZzy52XtxlTaLSBFLItuGEkGWm54dthlzz0WjKUK4u5WAogsQsfPTBXNMqf0QhmKtsY/xS1i3ZmHbvj+v54cAsrb43ghWehe7tqnZSu5+el4dQWu3FiWXRSMfIZMIL+xhxl0VWDOXbtcuXGa14qnPztjfDzMsaShznBr1wK62Kv67wWNJcUYphC0+Mo44oQbnXIJdT22aKox1dDzjjKFzwaH7fH1EBJ4iX1cml43/ctuYfVK1UKfNtarcs0dtMUWKA+7pEWaSVTB1/yGRhXiskNivu1jMPuDBbJx0LOPrzcO4TK4lt4I4ggpiO+Lgh8218HRngcR+sKyxWJTZdD7PMHrOlavdDekArDwWESmnnSbCNSA2pMSTuUyG7LJuBiZ5Kd/4+zNOIafG/nu8m
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6506007)(9686003)(478600001)(6512007)(6486002)(41300700001)(53546011)(33716001)(5660300002)(7416002)(4326008)(6916009)(66556008)(8936002)(66946007)(8676002)(66476007)(2906002)(316002)(6666004)(26005)(38100700002)(1076003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHM3elpuU0sxbm5jeWw2STNwcXdkOXFqTlQ3dHlsK0NDUXF1ZzBUdks0NjlT?=
 =?utf-8?B?OW12UXhkaTZVZFJxSW5maDYvTk5HK1dQamg0c05sNjJOdVdQdFVLeUduN2tZ?=
 =?utf-8?B?QUxMaFoxSytmWjBkVzRWN0hXSTBITnYzMWFmQXlXKyt1SWYyUDNwc2pFaTIw?=
 =?utf-8?B?NTVYOXJ4ZjlGdGZpenpWZVpUSk5rcXVGblVGY0lzTzhxRlI5b0c3VEJXVEZT?=
 =?utf-8?B?N1J6UnRXWWR5K0ZrdFZSaU8zcUY3LzA0TzY1QjJUakNnWGNIUU1zUUhjL0ZB?=
 =?utf-8?B?ckFwRzVLUWpRWXM1LzBiY0lhSE0xQ3dVVm9SVFNEK0dieTFEVXNjQUlTNElK?=
 =?utf-8?B?bkJ1MERRN21qRHVEd3RvTk95YStEYTNHZnNQN1JLczkxNXFyQ0ZuOENRWUdS?=
 =?utf-8?B?UmVwNzdvd1Ryc2tvazN5d0ZQZlpEakhNWU1pbndBQWc1MDZpOTRWRENrR0FD?=
 =?utf-8?B?WXJSNnpKUlRHa1pETTJSSDJacis1OEhQQm5vT292WWtmNkk0RXN5eURsQ3N2?=
 =?utf-8?B?aUtleURaYTBreHNlajJ3NXdXK3ExMVlELzF6dzBaaWtkQklvRGgyNFA2T05X?=
 =?utf-8?B?RytoeXh5N1FCTTZvT2Z4K2ZtZnhCQzc1a3FCSmNMcXJWM0o0ZkZtdE15MWlC?=
 =?utf-8?B?ODJTTEMzdjJQSEJjR2JmVVhXVSs1b1J0aENRVEk1aHBCNmVCQi9nejdsY3B5?=
 =?utf-8?B?VEFlOEZ1RmZ4aUVaYUxheWo0NFRsdTVxdVZCSFJrTTM3cllZdlFNSUpLaGl2?=
 =?utf-8?B?NXNkaHF2WEFLcndUQXlQU1hnQ0VpYzAzRVU0UU9NcDRTdkY2b1NNdnpEaUJo?=
 =?utf-8?B?c2xyWTh5OTl3OTJCdVZjT3g1V2p0NGRlWE5kWnVyaEtyU2I4Z0NGeFVMaWZl?=
 =?utf-8?B?Vkh0bVUycWlFSTJ5OWdmT2Zialo5K2J6WTVLdWcycFdmSkI0UW1sR2d3eFJj?=
 =?utf-8?B?b1VZN0p2cjJwcmRBcVRCRFJFQWxxbWxaTEtqR1ZwMDJ0NVZZeFR5RlFpKzZh?=
 =?utf-8?B?dzJRVlhJZ21PS3JiR0MyYjZLM2x3Qjk4TFoxTTNiR2hzL3hYRnV2ekw0VThX?=
 =?utf-8?B?UGl0NzNqaUl0VkZzYlFPRk04S0FKMU9HSW5GMk0yU283Vkg5d2JBdjVudWls?=
 =?utf-8?B?STFSbzMwNkdWZ2NiTjJETEhUamZEVTAyQVF1UjMxUUV1N1dZeE1Dc29RN2F0?=
 =?utf-8?B?UmN5QmVjeTlETk1IS2NxeHk2QnRNanJqOURHZ0VFWWVWclhSbkljcnYyeWJp?=
 =?utf-8?B?ZWdoMWFPdllBSzhiakIrbVpmdDVBSGFNcVVVcUhNU1lLV2QxOHh1L3pQd0Mr?=
 =?utf-8?B?azBoRnhmTWRjWXEyN3I3cWVUUkdDdWxwalZZUUg3cGRVaGZlYlVjczFZc09K?=
 =?utf-8?B?ekFYMXovZUdTRHRrd0ZyajNnQVF3bWtXNFJpVEw2SStTMlJtVE1SSUl5VUlQ?=
 =?utf-8?B?WnRXdVBCUFhEeVh5YzE4RW9JYlJ5VkkyN2JzUW8ra3M4ZzVhQWhoNzRuTGRU?=
 =?utf-8?B?emkzM09xSUZkVVpRNXNGckw4L3huenZTSTNEbDNkMU1nYzdYS01yTEszcEMw?=
 =?utf-8?B?ajNIa0ZTOVNJYmM3MmUzNFBFdVcwRWJRTVltazd6R21NSzJTaHVZUWtSVWdl?=
 =?utf-8?B?RXlpalVQbGwxdUVKeFd2N1NaRW9WN2ZONzlIdGdHWklFKzIyQ3VDTHNlL1dx?=
 =?utf-8?B?VGNtdlZGa3lsYXc1UVRvc1FDRUo2SHVCRVhWaFdicDRjL3BPMlBzeXdYSU1x?=
 =?utf-8?B?ZnBQL0JxMGo2NUhGVVZnMG9yV3hxK2dRekY3QjVybGF5NlcwaE9ocVdQMm5B?=
 =?utf-8?B?WjZ4eFRTVGIrdWovbVJWQllpWHh1UmVPN2c5dHVUU2dxcjNFOEN3dlhUM0JS?=
 =?utf-8?B?ZmJUUFRzcHB4cSt3MTVlbUVyamhXU1FDU3hvbWxFRHBFNVBxRC8rR2c1cFJR?=
 =?utf-8?B?Qy84VXlEOGdZaGY4RHN6dzVsQS94b3dwR3lVRi9FeW5jQzl5NHhpK3I3TUVo?=
 =?utf-8?B?ZkdYYW1yc0tXbU1oa0ZRYWxKbytwUFlwenN2cXZIY2dwRFJ1UC9kYy9jdkE0?=
 =?utf-8?B?UnloWWFGU2NkZmRhNTc1SlhKUnZmZ3hLM2p3aXFkeXFxMGQzZE84V210alds?=
 =?utf-8?B?dmZYdERHRjJZRkZqaEhqdXFvOGpCcU0xVldlZEdyRXpETUZKL1VZaTV1QWQz?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P2G1IM4qAzfP1fCM3V7uRC78mOpEw3Tb6NM34QOV7COUz4xMdBCMd08gNBA775MvpNTSe3DLf5QlX4No0Pqi/R2BtMVhbSwDsVk2HOr+grtemDCORzleyG6p98oEC6wYFuB+cO8J8JseTpqL3qYLXjrzHHoXOevtNGRBmDOhHmEQYO3MiKmiyLxcJRHIzSRks2I7WtPWVSqCRt15yLT4WCAA6YddmGRVZPccictMFR22u+yUdmkoTJLOP7jfSGbQbSWfKkZGyyKmqZVK23maXx1W8JbfASZuHEGRLY99f/YgoH9LemM01aN+AcW0tuQEErb5gcVKBVsT+JAohHq6JrBgG/7fsIzdcBbO1NYa9S+jejI9Es/NvyMxH1Yf4M1xeyb7nQxO2dNEaCQ7nC3mjPmQv1Uf2hbAWDO4NN3+e2Zfkgg9SB+9M63qLTIE0UUn7JIk1yae88IA7a/zZpISUUJkCOvyF12JWBjbaSUP3y/w+XAaf6W1rH4Bjm4gshtLjYctMyXbS4sIffsF9ElUCtNxDtBhCHpOzVuOt53RbbHtDEt++2O56JAm0+m03A6kANaJDGKJf32bVtXY5Grt8JowrJCe6ALbWjfs4JYeSeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c11eb21-8190-4443-1641-08dc2c06d129
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 20:11:37.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRwYC2yh1+erD7+yG4uiUBbBVt2YxmILLZ1hfpPcQwEPpvHX7cZfKDvb+7zNyPnrN7WVZ+wHj1mRl02xwXLtog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=905 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120155
X-Proofpoint-GUID: LQFMh-nLFgZOkdn7_6msO5d_n3ta0ywp
X-Proofpoint-ORIG-GUID: LQFMh-nLFgZOkdn7_6msO5d_n3ta0ywp

* Lokesh Gidra <lokeshgidra@google.com> [240212 13:08]:
> On Mon, Feb 12, 2024 at 7:20=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
...

> > >
> > > The current implementation has a deadlock problem:
...

> > On contention you will now abort vs block.
>=20
> Is it? On contention mmap_read_trylock() will fail and we do the whole
> operation using lock_mm_and_find_vmas() which blocks on mmap_lock. Am
> I missing something?

You are right, I missed the taking of the lock in the function call.

> >
> > >               }
> > >               return 0;
> > > }
> > >
> > > Of course this would need defining lock_mm_and_find_vmas() regardless
> > > of CONFIG_PER_VMA_LOCK. I can also remove the prepare_anon condition
> > > in lock_vma().
> >
> > You are adding a lot of complexity for a relatively rare case, which is
> > probably not worth optimising.
> >
...

>=20
> Agreed on reduced complexity. But as Suren pointed out in one of his
> replies that lock_vma_under_rcu() may fail due to seq overflow. That's
> why lock_vma() uses vma_lookup() followed by direct down_read() on
> vma-lock.

I'd rather see another function that doesn't care about anon (I think
src is special that way?), and avoid splitting the locking across
functions as much as possible.


> IMHO what we need here is exactly lock_mm_and_find_vmas()
> and the code can be further simplified as follows:
>=20
> err =3D lock_mm_and_find_vmas(...);
> if (!err) {
>           down_read(dst_vma...);
>           if (dst_vma !=3D src_vma)
>                        down_read(src_vma....);
>           mmap_read_unlock(mm);
> }
> return err;

If we exactly needed lock_mm_and_find_vmas(), there wouldn't be three
lock/unlock calls depending on the return code.

The fact that lock_mm_and_find_vmas() returns with the mm locked or
unlocked depending on the return code is not reducing the complexity of
this code.

You could use a widget that does something with dst, and a different
widget that does something with src (if they are different).  The dst
widget can be used for the lock_vma(), and in the
lock_mm_and_find_vmas(), while the src one can be used in this and the
lock_mm_and_find_vmas(). Neither widget would touch the locks.  This way
you can build your functions that have the locking and unlocking
co-located (except the obvious necessity of holding the mmap_read lock
for the !per-vma case).

I've also thought of how you can name the abstraction in the functions:
use a 'prepare() and complete()' to find/lock and unlock what you need.
Might be worth exploring?  If we fail to 'prepare()' then we don't need
to 'complete()', which means there won't be mismatched locking hanging
around.  Maybe it's too late to change to this sort of thing, but I
thought I'd mention it.

Thanks,
Liam

