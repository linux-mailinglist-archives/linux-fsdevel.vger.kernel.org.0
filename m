Return-Path: <linux-fsdevel+bounces-11426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA2853BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0771F24661
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA860B8D;
	Tue, 13 Feb 2024 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WCv21YYi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oemmPk8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6D60B85;
	Tue, 13 Feb 2024 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853912; cv=fail; b=I93/BO0dpDc9elulYXHpmimXoDDSwnM0yJw1mU1Debwxowj01oaz14agCBWb3YJOiS5BsaHgE3waXPCp7g9yh/7FPMpZKNXJMZvjGyxfzAs8nCRdeW2AmDLrOFKbdRUGuuyzC3z75BL4CKlb58i6Xjl3OW8ADiKTB5HstnWDnTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853912; c=relaxed/simple;
	bh=2sfk9XmYE76CUZiNBwL3RqDwURTnQLoqgrSJyCZsbPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F83Wtg/cTZPhEUlIc6HyNgY3+Xm8zeAR2zJeeIDY0uR8FtvZudzxUHqLXOn3lJ9TheVfnie2BbRp2z7qJX0H5RSqL2qembzuCWsjcB1YYrf3Iq0CO/VDQgTPXfEtvD9swSgkBB2Sxb1TyzIynzyOe0sOsZbw5Z3amGAcLEvPmw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WCv21YYi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oemmPk8a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DIj3IX018242;
	Tue, 13 Feb 2024 19:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Ktwy35BjXYTXV8Vk5AV4l5is0qqQjVjVt68lL5V+Noc=;
 b=WCv21YYiPlBqianVw0PBHWBBgNTT7FKC/d1FYmm8pZWxSM6JwJ4yrGB1bLe1VbZa3qm5
 zRG+lUXr4LMvcAiLdYAS7FwZzblSjfeaqwgXknLnJoZRywwQITWC5Ep2Ub2zE6J1qGYK
 nTmUsuzRT7O89gegeiDWnN0VQMSME/Nvcdiutvl7AnvVBc+x/Zyh8oHRQHcVsNkC3fME
 c+HiOvIALkMRkJOh5h3S/JyjTtcVHzmI63OW/pA1wPLNexzOIOYGd/WN4rw1iITB613N
 gqyFrpRcgWZ54p0ZmggFGivb+7yIvzDkFk+fqyljfzgiF+kk8CgqCbnI9vHg8Pl6qoXQ Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8dyjg4nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 19:51:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DJMluk015037;
	Tue, 13 Feb 2024 19:51:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7v4j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 19:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4Thb6egZg5jr7sj17ksVoNTIl+j2CBzQI1XNyl+jEc0RiaQ9xLrgXffsIVZXIPRQLYdRiSdtmKzXaA3VVbW4MQxODkAlmEN2h3RF9b5/jbplVWuLUBO3AaMOB1qHU8mlvmLv496iRKiZLOshwp7jFkGf51LYukD3htJw7b9XT/2nURbVCwHe8JJOTd4XfrsuG8NklNRTAZvYCJVsmc08rUU/nlfq6Pi4dTN7bn2EwBnALPE7thSXEeP6ZFz5DUP7eCSRsQDNk+Tze6ndRKAYqPsIJ8/NwCPbxARvsLu59jteCSTk5aaLvH2+TcqJa/V51j3jbpuFS0LbigBNzhPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ktwy35BjXYTXV8Vk5AV4l5is0qqQjVjVt68lL5V+Noc=;
 b=YINVfAI89vKASvMsWB36DJAAMG3VujqI6sN63R27evxEYjBovAiBF5uANU39CcejGNvuewB8upWOjH4Yf9d1FOfECuHAkOzSzVtBU5Ed/gzZxxUcr4MrwkDEEINGY06dqUVQQSnpnKEHbGHPBnxHzeW3jyfEZEP7JZv74EnnjYD23fQdWKlno0eC8v3CJwcNQW2coDXtpfjx6LNNFZsxCswqahwGKiLt467PLzdlzxVRI8ZuH1a2mEfe01G+p1Edr1ZQo6Ezix1ryBkZp1lppKN1VuvOnf4uAr/EmJulKSniDYvhTMcBUcKoXQ0piO2rwUTubz0jVl81AWCor2uH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktwy35BjXYTXV8Vk5AV4l5is0qqQjVjVt68lL5V+Noc=;
 b=oemmPk8aKI1ouzk6Y7rGc1SujhND3lRfIdBeFFT4/bGm8EE26gKu2QV71Srs0OI/zj7xp7cJF5eQtP7XmSAy0GWwmF9baXwhTASdjgVuRWZTCOuqCO5xWdJcHOp9SxcpzR9wh6QotErlVE98fjS2H9Sq7fivK/cI3XFF3EUZbP0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4319.namprd10.prod.outlook.com (2603:10b6:208:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 19:51:27 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 19:51:27 +0000
Date: Tue, 13 Feb 2024 14:51:25 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240213195125.yhg5ti6qrchpela6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver>
 <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver>
 <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
 <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com>
 <20240213192744.5fqwrlqz5bbvqtf5@revolver>
 <CAJuCfpEvdK-jOS9a7yv1_KnFeyu8665gFtk871ac-y+3BiMbVw@mail.gmail.com>
 <CA+EESO6TowKNh10+tzwawBemykVcVDP+_ep1fg-_RiqBzfR7ew@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO6TowKNh10+tzwawBemykVcVDP+_ep1fg-_RiqBzfR7ew@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a533691-06ac-4d26-387f-08dc2ccd2a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pAtzD0bVuRic4DRyhDxTZh4+aRTy+K5NLZeA6NvWSvnLreG08yDnzvRERSGQ64X1+WTGI2bfPpsDkouz0RXkCJZO2nERl3J/kDMg/tEVcav8ZpU5CdlPvr1mQJNrs1eTZEzRWP2cLYTMEsTugJDGl6qiJ3LDqGIdRlVH0fs9drUY6RkOHT+SpW1I0UoGaU5vzyQPKzxpD7Q8R72RVG6XbNahBBVKWaPpjKlAlAnQ0tAcANDxMtCROv5gO3ja0Xw86Pu9VXmBre7OeyEYvjFsyR58Obdofe6XZzkGbTo1+CvRY8hQSP/qlU3bb+ESMq0AiytZcYYSevgdFNcbdXi73+5tMovYeSP632T6K+Kf6LG7A85Mg8mOibrk1hLMwLAfMUF6uAOqQzmmoaBBuGUtScrFlQ9qv4fDyqOHd7OojVp8iz2qS6ddj+AvaC4cGJb3vfxGCuK5G+UjnfPiTeUYSoD2HBk9JLLNOa46otwzuoVyA8SDiUu6TBvqG9ku4c/yCe/ev3Gee4Myqg2Gb13+pDWostCC5zPQGWtQK4xQNBS5bi5Ps7zeT0rRVUx1DgMs
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(7416002)(6916009)(66946007)(8676002)(8936002)(4326008)(2906002)(66476007)(66556008)(83380400001)(1076003)(316002)(26005)(86362001)(38100700002)(6512007)(41300700001)(478600001)(6506007)(6486002)(9686003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z4Qwb4K+iIL4HobHmLSoonHhOBX0e3xlQbOnU6jikkxxq9PAwKP6HR5BXmBk?=
 =?us-ascii?Q?ivM8OYOUjP9uTdXG+8sgDvDRlljdvAlX1RLMUbjfFQSao0jPQHYxHwuky447?=
 =?us-ascii?Q?uqgm8K4alhPL2ayoFtGM9tnf/231hV5ojpbwLiZHgEbwDJA+10bjPfwfELDD?=
 =?us-ascii?Q?Wb8fJlH1EnggFuiQt4VjIzVozZGEOqaCberu2iq63gSzX6yCCzWbDd9vowjS?=
 =?us-ascii?Q?VqZ+DZeZvu+3S3armTDhZyJ7DcZqt5ysj0FjnxeB+TYt7rDm0s2SBNUrd8Kj?=
 =?us-ascii?Q?ohniq9QUl4JeP+wq8QsOTsYRVlPe5Q5/sPJZP/ZIA/Ay9In69y4Vtht2mhMU?=
 =?us-ascii?Q?KfOHHoC2+UulKs0UOfAf184k3USOtjzERYrMFWxrTh3z+JUN5FZrWIbafNXR?=
 =?us-ascii?Q?L5ld7PWSIxnGgKO5j2/MMOyy/wk0GzFDok2R9tTnr6KDI6+cDRfDA9muJdr8?=
 =?us-ascii?Q?XZvpwB13ufrZnFJ2LuVwqECML2SFHInDSN85FcrBor/r5VpGJaSKyB5rO6Ll?=
 =?us-ascii?Q?NZGC/AF03vzCMaH5Qq/6ZX5hGw39SMo0NSXVuhbShwgDHiXyafvr1eOmmm5V?=
 =?us-ascii?Q?FAjEF8apoI2s+/3sOx+2+vR5Fp/3yOO8YSR5wVKb2PxoBH3bbY7ZEkqegzV6?=
 =?us-ascii?Q?x4zO0iNoEIwjVjCYQH8ZM+FsNS3PdZCxZ8zPGOZdk6W3DsFngULyQ0U/MTX0?=
 =?us-ascii?Q?VMOZnP1vCDumqPV8HSQ7uzltjk9ksVGUVXv0rZPbl5818XewD9pzzgZtUCiz?=
 =?us-ascii?Q?aUELOrsrlWJKv1BsPIZQej73o2fF1oJ9cX9+OsHuHX08qTM+6tPMYNFLCPbq?=
 =?us-ascii?Q?PnqjgBim4L4pL2WFvXDX69mEIg2nksWC6oCKRVMrZSjhkmZOWk6mWe1C4TPD?=
 =?us-ascii?Q?hw1LVtSxHUCptzbvD0aViqqLcPq6dt1OGEFmCXDcyxF75jCd5kPATjTxAGBj?=
 =?us-ascii?Q?bvYfngN4eDZkvkYrmyAWF9ZeZHePWpUeqzpVEpJRROHedYdO+a3rmCPE6Fmx?=
 =?us-ascii?Q?CZrueeY/92o0AlGqPAUHWXOk34RPH5MKVwdlDhRoNdv/8x7TwtMzqEmzUoBc?=
 =?us-ascii?Q?0Vdk+WKC1fAAHxMOFyqAfPSm0cYPdmNKd1AIUON/G1nY4k1zABDHcHI9DdIP?=
 =?us-ascii?Q?lAS7Doz+8lGnsGuu5xSJTIfxzXW4R+deNgc3xaeU7VPWqQHwR7w8qhHcikmZ?=
 =?us-ascii?Q?mjAgPbJoxJifKm7HcCqbiMJ/26reynO3uuG+S5M1ObF/E8s4p/BK7ETsdc4o?=
 =?us-ascii?Q?9bUICQpEsZEPt+9J/r19xQJiDGC7UIxW4EAK9+plwMrmYqDPnQWf6b9ONX3p?=
 =?us-ascii?Q?x7mgYh0mrszdbjqaxrNaDqEIhJeVwKHymab12zAUjFRemBGppKBHAC9OnaM8?=
 =?us-ascii?Q?OziZVVUV7mDzrhwo3KB1T7IL+2PPJYlWsHKAOviW2olMgJGuuIevBOXlszCi?=
 =?us-ascii?Q?McOkx/gE+ZETSJ7EvKYQ6/Z8pBOUlRiQOAj6vwnfsUh2+Px8vqfDvtF8Ujo7?=
 =?us-ascii?Q?rZfb4GLZ2XWBi5pWxGFe4UbNrpYeShWUOivfA1e13WQdz65izLnhGH0iTe4F?=
 =?us-ascii?Q?3NwSYgFq+X34Vn1jJ8vo8YxP7PcLLCfRv6JM587wKy55A8M6ijeN9DvfHJPM?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0GLB1mu/Yb3AqxhTp9E2bY17QRY2M+gJf67nUmgrqUOOb/FAetz92ozY6gb/cZJxUT8mVTQVgWBUYoo7UzWbjtZxSzwmxcc1umk/GhGJuAzS7ZcDj8ppaPw2Qz4OjVQiMWsz2F/2tdDq1JcEPEfEbnV1t0l63P/4i6RpW7T0JDYCxME53jQ7XunT/8oghzy4z2/aZd+KuEPdw8HTWy6jWXTUjulJ6InXm/2qzBT8lw7sZ0t5IhUcbtRcdK25VOCoEwProoj1WXKly98y/AZmFlMvVv8U3z5bmIpn4JkmJXIa3zVpV/Fx8idZsbH8SD9M8f3i205wJNLjKZ01H+Tn3v0JkJHX10kYl5mu7VwJWbUFgvgfuQ/5yRMm+F+dAHvkqTfkCzjDxMdGPio9Ivybp9zggHrk8q1lvZpLLE72oTS5Sn0zz2QPzVlS3S87nkYUJW8nyswXSarm+C0jjT1Why7w/yWWw8//C9IhZuiz7m0mDFT7eUOghTfOYC3z68/AnWu1n3s/NaK8W4wwvjbBJ0UlqmFbf0Vppi17NUo5E046YLYrrSWpCGpxuLSx//2NmSyi5cPgt0eqTKW8GolXY/odl0hvTMo1Hnn1pVbk5X4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a533691-06ac-4d26-387f-08dc2ccd2a98
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 19:51:27.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3v+jECGxBOPmz2l5OzqH0y2O+//CxmIvAgNM42gsbhysH3G94BBdava0CRLfqUKCZl8woij2k45iE4kCeWzjkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=623 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130157
X-Proofpoint-ORIG-GUID: 0nCoDfDfgcAiikicCJLZ7GJbTc8VPNsk
X-Proofpoint-GUID: 0nCoDfDfgcAiikicCJLZ7GJbTc8VPNsk

* Lokesh Gidra <lokeshgidra@google.com> [240213 14:37]:
...

> Asking to avoid any more iterations: these functions should call the
> currently defined ones or should replace them. For instance, should I
> do the following:
> 
> #ifdef CONFIG_PER_VMA_LOCK
> ... uffd_mfill_lock()
> {
>         return find_and_lock_dst_vma(...);
> }
> #else
> ...uffd_mfill_lock()
> {
>        return lock_mm_and_find_dst_vma(...);
> }
> #endif
> 
> or have the function replace
> find_and_lock_dst_vma()/lock_mm_and_find_dst_vma() ?

Since the two have the same prototype, then you can replace the function
names directly.

The other side should take the vma and use vma->vm_mm to get the mm to
unlock the mmap_lock in the !CONFIG_PER_VMA_LOCK.  That way those
prototypes also match and can use the same names directly.

move_pages() requires unlocking two VMAs or one, so pass both VMAs
through and do the check in there.  This, unfortunately means that one
of the VMAs will not be used in the !CONFIG_PER_VMA_LOCK case.  You
could add an assert to ensure src_vma is locked prior to using dst_vma
to unlock the mmap_lock(), to avoid potential bot emails.

Thanks,
Liam

