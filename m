Return-Path: <linux-fsdevel+bounces-10484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7784B809
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58CBFB2B93A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F6412F395;
	Tue,  6 Feb 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNY/O714";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cWJzBEYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA222F1C;
	Tue,  6 Feb 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230135; cv=fail; b=aAQHkYDKMmUKury3VY1zOy3XJMsH8RO9Far/rcu907z4qg2jkhFlTpE3Xj3Iz+BQM8z20Rf/0aM/X7RwS5IbXHrGuJWp5cWHjWsea42my51BHrMEraWRJwqPjZvWTYo/r74WnmOtOM5/O7LKSGLU+RG8AQg37hW4vbmvFVOF3vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230135; c=relaxed/simple;
	bh=pf1iQyeMthLpfhNS4cdCjd08JVkWSjUMR5NzMWyrFxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ljgpTdypMkp3tv3R6a1Qh4R2Qp7YdDFMPe7gKUVHdKImqN7+Q+thVmYA0uCT95DrvSuopT1UDRj4KKJFFP/54KnaVVVdLsT2WR7hHXw3R6vdrzGDIljBcUZ3rZwEkBNEfwPMb7JQ/Np8hXIFzhoVP0I/d61hVdf9cfhWTUixyzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WNY/O714; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cWJzBEYQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416ARa9T002551;
	Tue, 6 Feb 2024 14:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=pdzakK67/3gRh0Rcbhrqgtig5Cqm9XthBW6tCOPo70Y=;
 b=WNY/O714PWIDFdelatX2iVbje2JwyWMuoTWMapaakdufs7d4pXBTBLDIiOOlLMYMH8lW
 kPkDbyH0nBXhzUmPVN8JJZTlvNxI+ftKoKcG6Ac/uSivPWGtxGt4wlAKAVKfmGymUiR7
 cTP3FrfqRcGqlxzz9ABo3Ivy0qDAaGZs0wFnsCwrLiFlx52uN4bSzQKXMPCqKyitd+1L
 0JTMXxLCKmn16c74Z7+iQ+gRHz5kcbcD7K85kfxk6lNJXlNs1cueYfoR0kmxP6HFupof
 8FPReAMeu50TJaVu0RZecqpdvo6GHjzOLq2hf5Z/dykjLwyL2avIPy4Qljs8TRY7ZFsO /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdcy1vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 14:35:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416DWEO7038324;
	Tue, 6 Feb 2024 14:35:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx76912-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 14:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey00k43gumn1qZLsIm9CKw5RMVwli6LZJEFq2rAU8+5OSe+ng89EnHIITpRmsZZQcohwTgqDQUM/dgps5LyKfr5wEyzkb70mfP0e/fWnPcbylTQr+xearuJEOgIDvURV/bbh6gxw5yoAtc6Cwgb0ZKzjkQ1gwrMD7HKdrVlQYX6wV/9xgXlWHRXOYp01dmhcif2PmwbnTZUy5mwnoU+VTGImhmeBzc3U6FvT9wJG9yXI5XsylvvOuyBLwCJnS/mozNnGF6pwq2bei/9BjuGsDR0mhaAARTeuhPBVsRzDkIskp0CBH4RVqVfjcusobSECaBba7Z9gZXJMai6Pi1qH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdzakK67/3gRh0Rcbhrqgtig5Cqm9XthBW6tCOPo70Y=;
 b=KIlk+T6HO6d9yQpU1QIJzq68B/k0eR/IiaHgmPLDYpJDTHnPQCQ3dsx5p/774PADX2y/gXde1VqnDbRldb7uVqPO/i/K4uvAlS4AhvCHguciXmWqfvOGvYx2VFx4Jluaw9D1O6+VyaAGyo3dY6KaVQGC8SuW6WyKXNqEXLI3UMXEszAJayqUiVNb8kQAGuJpFm3owieQfL5wi25fpCOOHrG0vaT0hic9RpCG/aOKOh44v4VbR286AhWM32VcbMBwLZznQJxYAYKKllHeoeYXsk2XQ8kpLKZGSjZTV+20QMGBKhNrBVR4qdJ8LOixVHKoHlKku4X4ztmCyL/nT/4KSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdzakK67/3gRh0Rcbhrqgtig5Cqm9XthBW6tCOPo70Y=;
 b=cWJzBEYQGufF4Twj38KzqU4AmyGKOMZZTV34Wl5yHmdFViS5XmxPi73LWXlrr5PRWn9fFChX+FxXbwrglzW4dJ8xfjvISgAqXdTieQp5m5mW3anL4tkfosC/xGZzCMgG7ZEKupGWBRs7GZ//eCsBj1K2kLXoDKstWI1NJMq+KvM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 14:35:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 14:35:08 +0000
Date: Tue, 6 Feb 2024 09:35:06 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240206143506.6zsj2gktu754gvl6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver>
 <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
 <20240131214104.rgw3x5vuap43xubi@revolver>
 <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
 <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com>
 <20240205220022.a4qy7xlv6jpcsnh7@revolver>
 <CA+EESO6iXDAkH0hRcJf70aqASKG1eHWq2rJvLHafCtx-1pGAhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO6iXDAkH0hRcJf70aqASKG1eHWq2rJvLHafCtx-1pGAhw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 996c907f-7f15-41ef-359e-08dc2720d15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aR3zvMC3FyGV0pMGijsLHxpU2dqb77Tvl6Xc8cMzfaVZK4zZXpEvtakF3ZM9CKxqKCUO37VjtwhFj+JzJ5qLMo5FwGKhyO+4SAg3o8usFmTRtqlaN3ZIiNvXlIF40+R9iR6YGHDS7Fz6a84N90+VVOJ54Jc0FZjWrblYdBTwWyg5N08xyVwT6o/KYqeJqRNZnj/nvSdfdkvHD5novUOIdOefNxy9j0Np4og14OnIBjTepbMU4Q/fJhN9H/FfL/toKMd4Idn/ANmBC2KCpTNrd6cLcCALCoW53ZZ724OmThkaYIfk+zNtsXVwle5nemBBqYj108lUkIEx7FPJdZX9d7LxrSHK8LJdYcIpF7RH6C1f9KC8x09yi/ntTojjCZIHBA6p5BszOmM375hklQHKxpC4nhwQSPWtYeAwsrHrvV9iQyZ2pEzN4gcvhA3KmliAfY8mzRqljRa5KqAlL8M4cZMPoH98PpVsQuaOemrnUpzAe8A7P6pnLLTNnwOFI8KuiO6hU1jtLMfORaZW3CiiFT3hNHHWK+tF/mOSsIwLbc+DKMDN5r4gcvz9IrfOFxKb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(316002)(6916009)(66476007)(66946007)(66556008)(8936002)(4326008)(8676002)(38100700002)(86362001)(33716001)(41300700001)(6512007)(9686003)(26005)(83380400001)(7416002)(1076003)(5660300002)(6486002)(478600001)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUdhMEpLZFMxa0N4NGxuSU82YmpkaW4xc2h1UWUwZFQzc1hrdzI3N3JvS3l6?=
 =?utf-8?B?VEYxZ0RBd3hSNkFRbXF3YjN6V01mRzZvcWIveXdzdUhFYS93Znd2VDd5Tm5x?=
 =?utf-8?B?WFBmUU5DTFJxTzZ4bDBFOTZSdC9WN1AyK004M1Qrb2x6Ukp6WXNqNjlyK1ds?=
 =?utf-8?B?TjBWMTVualdxVURKWTZQYlI5K1hDajdJd1lic3dOZXhuV3ArUjRXSXd2czRx?=
 =?utf-8?B?Q3JsRnVoVFZmZ1MwemtIZXVoZTROZytKY0NSL1o1ZCs5cy9rSHFRa083dzk3?=
 =?utf-8?B?WWgzNFg3dWJGLzRWTTZ3Z2NtYm5TUk9Ua2pLR3lOdmZXMnN2OS84a3FqVzlB?=
 =?utf-8?B?SzNoU1J2b1MvTGtLbE1obTYydDdVdm5OU3ZmNHJrWXZ6aFVtVnErejZSaGNr?=
 =?utf-8?B?aHpSeVFoZ2MzRStNRHNMQ0lXSXR1QmdZTEIwR0djOENPRmdERTBhOUNXTCtQ?=
 =?utf-8?B?RWI1TWUxMG1DTUlWdldoUlh0Sk5rMUZYaWNMRFIxRGQrS1p4Qnh5eVlyci9Y?=
 =?utf-8?B?WjRoR2hMdzZKNFJHZGM5clhEQmg4UmlscksxbzVwN3BsbHZQQWNyakJKV2gr?=
 =?utf-8?B?ajAxQlh5RytwZlVtL1ozRnYwZEZVL2xRK3M1MndwOGFuYnB3cXcxa0lnVkQw?=
 =?utf-8?B?ZjdpUUlHRFk5blRMYmN5eDRUaVlEb01IaWtwOXJXckFKaWtOVlN0cGY5U2RX?=
 =?utf-8?B?Qy93REN5K2VCWUhPV1BxYktmanZLY3NyT2prY2Q5em5rd0lCbklMeUUzWkhI?=
 =?utf-8?B?V2RjSGZ6eWVVdnBRRXd2L25YaEZYcTI2bkFCSGRlRWhPWUN0cW52NTVCZ2xT?=
 =?utf-8?B?QTFhKzMrYW5kbXlzaEc0NmdHVFVPNjNqRy81V0tzeExjdlB6Y3NtUVFObFZD?=
 =?utf-8?B?RDVmZlhoaUZJUEt0dmNoZ1NqbWtPOXE5RDRNSTFidmoyTkEyODVEMnMyQTZV?=
 =?utf-8?B?UWNGa0drcXlxOXBUeEpHNkdHNWtZQ2ZOVWN2dFF5N2dSRGJabzI2c2pNZ0Vw?=
 =?utf-8?B?bjU3QTBQd2t2NHJ6UVIvcHNSQy9mR2Z6M2JXSXF6enVkbWlIaWMzVUdFdDR6?=
 =?utf-8?B?MXFKMmFDL2ZIaWxwMlhIM1piaDRsYk42RjN4QnhNWEJCTGVMMllvRko5d1V2?=
 =?utf-8?B?NnJQMlpKUkYwcktETytaQ2tvSmt2YVB0bGxnZENmUzVWTDBRVDJzZkNkc1lY?=
 =?utf-8?B?aGlJTnhkUnpTa05WdmNrb1BZVVliUGxzR0dyZDVEZnV1dFhiQ3RhcXFjNTcv?=
 =?utf-8?B?OGIyTWxWZWlYcGd1YlBzWWdhZmNqNWN1Yi9LZHZjeE0walVQZk1tUVUvdHJl?=
 =?utf-8?B?ZVUrOHAxKzd5Q0hMUVFqaVFPU0xNd3JrTUFDcm8rR1NySEFCZ1lMMFhVMFM3?=
 =?utf-8?B?ZHhFbUR6Y3QyMlJHMkpXZXUzZVlNYk8rQjd2Y1FWMkFGN0JkWDMxNnluVWkw?=
 =?utf-8?B?TmtDelhWR2ttaG9IZWQyOGtQNUtpdzZBZkZnSGVsWmNxUGtwWmo2S3JhVVZn?=
 =?utf-8?B?UkYxRDZUMHExcXlLSndlcmlzTHZjMGNGdDRZWVl3RmkrWFBFa2FKOHNNUE1w?=
 =?utf-8?B?VDhJNWJDeXZGUWw3MC9pTTlGSVN1bkxWamtuRVc1MnJYaU5wNnpCem5zK1Bs?=
 =?utf-8?B?bVZ1RllBckFaN0NVM29vNDRFekc0ZFBGQzl2QTJReUV6WUFWb2VVMVRhbFgr?=
 =?utf-8?B?bmFFOTN4Z1NnL0E5TUQvaTcwckxaM0FVVFpwc0JnZ0VwdWxzOEZNMEE1R285?=
 =?utf-8?B?OEczVHRiaE1XbkdTOVBHTmZuTSthc3NwaTlWZHN3eXkwdHYyUmxXT0V4K2tp?=
 =?utf-8?B?REdxalp3Vmk4ejlTLzBUdUkxUTdvOVRZNWlFdFViaEFIY2RlMVUvQ0xqaldj?=
 =?utf-8?B?V3pJWUpYMSs3WG02YTJJVXNFa0hEZGNuendSYXpvdUhxdlBtZ1M2SGFBRVBl?=
 =?utf-8?B?dHFiQUptMy9RZkhjZFFuVTN3Y0s0VU42Sm1pUElMQXQ3dTJqcU9QQlgwS1h1?=
 =?utf-8?B?QUVzeUhqSkVhYTRZeE1KU2MyVTZOZEtzZDc3dlRiTDArNS93MERhRml6TEI2?=
 =?utf-8?B?dkxTN1BKS01KUWUzbXBpd2lGWXlyTVZjMU9vRW1ZeUUwMTQ3b0R5S0VqZDhj?=
 =?utf-8?Q?NFgUwmvWpL1EU2rBxNxW5L4yR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qwwPcF150oB9oV1sgSE/ecW6M1LZOrJ/V9gAVZJKychAscpFkOvidofgZbT5goDEaIryTdjRqAIC4Merq5LGkG3tq8xlc9GzPYPvo8FYWK8BJJwwMHGQmdhDUzg4wYYCy9piaHoOX2RHdjYRC7BDHwKBro2GMJ7aaWywGI71jeHa5QOf+VdZF28cmDEqvbxpxx7bCt9NUdoiKq6NWLT+KVvyfPbUblwW0BgZGP+vik6KHsSxuyKCprMUpB1erQMVtn7GDTUCY2uL9a6MCUbV61EbA2MzPHOAEV/pFrbZP3hIfuY+kRfJuSeWtOU2vMI4GiV65D+IFUO9m4ek2J1cnp+/i3nCsUB37YXYgWdydhjtvpEpu4z1+mX72f2vN6qTRP3NlWpWpmt6tJjXU4Os9LBPn5neb2FqThQDT6IURpiExIFGzmpKXF4v4uQK69dK+5TnEWfV8Yt0FAEDNCF2C3tUPhOPu/HLF1Q3Gpa8to3YTMVwNMoRkD3lcl4XMKwzKnKwbcvRdM4bxp72cq4Shdre1tXv1xUZoRULVo6jcHPlcY4pVlBzbi4vOR6lkGfJNrpDXKULVSOuHHgMPTmTI9ZkAcqNjyA97Hoql128jwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996c907f-7f15-41ef-359e-08dc2720d15b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 14:35:08.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaMTVqJ+xUFkP7hVhEIC03A2wVo9J0RK5QXVBan7Vv+LYPzZUhzDKRJOln3TfMa/3uBetMrP0M7IZtasFNSdVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060102
X-Proofpoint-GUID: blVphmwaddQEX6dT4iK19uLpHVxWXE8n
X-Proofpoint-ORIG-GUID: blVphmwaddQEX6dT4iK19uLpHVxWXE8n

* Lokesh Gidra <lokeshgidra@google.com> [240205 17:24]:
> On Mon, Feb 5, 2024 at 2:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240205 16:55]:
> > ...
> >
> > > > > > We can take care of anon_vma as well here right? I can take a b=
ool
> > > > > > parameter ('prepare_anon' or something) and then:
> > > > > >
> > > > > >            if (vma) {
> > > > > >                     if (prepare_anon && vma_is_anonymous(vma)) =
&&
> > > > > > !anon_vma_prepare(vma)) {
> > > > > >                                       vma =3D ERR_PTR(-ENOMEM);
> > > > > >                                       goto out_unlock;
> > > > > >                    }
> > > > > > >                 vma_aquire_read_lock(vma);
> > > > > >            }
> > > > > > out_unlock:
> > > > > > >         mmap_read_unlock(mm);
> > > > > > >         return vma;
> > > > > > > }
> > > > >
> > > > > Do you need this?  I didn't think this was happening in the code =
as
> > > > > written?  If you need it I would suggest making it happen always =
and
> > > > > ditch the flag until a user needs this variant, but document what=
's
> > > > > going on in here or even have a better name.
> > > >
> > > > I think yes, you do need this. I can see calls to anon_vma_prepare(=
)
> > > > under mmap_read_lock() protection in both mfill_atomic_hugetlb() an=
d
> > > > in mfill_atomic(). This means, just like in the pagefault path, we
> > > > modify vma->anon_vma under mmap_read_lock protection which guarante=
es
> > > > that adjacent VMAs won't change. This is important because
> > > > __anon_vma_prepare() uses find_mergeable_anon_vma() that needs the
> > > > neighboring VMAs to be stable. Per-VMA lock guarantees stability of
> > > > the VMA we locked but not of its neighbors, therefore holding per-V=
MA
> > > > lock while calling anon_vma_prepare() is not enough. The solution
> > > > Lokesh suggests would call anon_vma_prepare() under mmap_read_lock =
and
> > > > therefore would avoid the issue.
> > > >
> >
> > ...
> >
> > > anon_vma_prepare() is also called in validate_move_areas() via move_p=
ages().
> >
> > Probably worth doing it unconditionally and have a comment as to why it
> > is necessary.
> >
> The src_vma (in case of move_pages()) doesn't need to have it.
>=20
> The only reason I'm not inclined to make it unconditional is what if
> some future user of lock_vma() doesn't need it for their purpose? Why
> allocate anon_vma in that case.

Because there isn't a user and it'll add a flag that's a constant.  If
there is a need for the flag later then it can be added at that time.
Maybe there will never be a user and we've just complicated the code for
no reason.  Don't implement features that aren't necessary, especially
if there is no intent to use them.

>=20
> > Does this avoid your locking workaround?
>=20
> Not sure which workaround you are referring to. I am almost done
> implementing your suggestion. Very soon will share the next version of
> the patch-set.

The locking dance with the flags indicating if it's per-vma lock or
mmap_lock.


