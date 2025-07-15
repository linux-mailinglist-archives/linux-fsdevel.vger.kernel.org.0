Return-Path: <linux-fsdevel+bounces-54923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A396B05437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C733A7C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A52741D1;
	Tue, 15 Jul 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m98lIBEf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a5H/fYZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935E230BC8;
	Tue, 15 Jul 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567103; cv=fail; b=lv4SQY50Yqvlik6wgYJJMh2qKQxhs9o1cRYieh0RWmDzTXQLCLBFO4LquL2PdrgSGCie8kRCiwbwiqGNJbSaRdxo3BM7u47KTyzfEWsLT9pOt6UVg0Yd08iE1IHJCAje5L8GVKboKMhUu30TxD97hUU2iLQ8YQ6ud6AtSCg3HjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567103; c=relaxed/simple;
	bh=1FT+/0DC/OaGa8PspeikRJc7qPH5CGgJs+pQUBoYPG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXF4tha2XBN7+wTv1e99jzsMfOYnPFL0BIA65PHbO4AUDrtUTf03w8NuPaIYl8EihtM6fFf7Q4kqcuLmZMMKpNbRkDXlhxorz+U+4+ArmRfoIl6RJpU+a9+IHe0S/ToXyyxQxjLL5Ycm6ePW+0byhM/xZOgevWTTXuYmJUAMmgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m98lIBEf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a5H/fYZ0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F1Ysau019642;
	Tue, 15 Jul 2025 08:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1FT+/0DC/OaGa8Pspe
	ikRJc7qPH5CGgJs+pQUBoYPG0=; b=m98lIBEfMgKEh0GK7Cf2kYNX6c0uhNJ18Y
	/7bMEfMGmwAALnBl8+w9nwKgLL4mTRNRxMP/WbnoW2rMHK61O1Txp8DSSRGdk0LU
	xSLR2AbOel2ytxysgoH4+gaLaTjsCRqwkJnVsWkVVPHu6H00RGtmv/pilvdp8qhm
	V9dpxxBNah17ACGPuAp5fgZ46Wpf8gFL4jWbwspP6De3csxBlO0lFMr530Bg8q8p
	TbIn9XiiRIbj0+Hi13ckjM0vhZmcDA4Y8bMhGVCFYq3wc/fc9IrPvBdT44Bpq+q+
	nzjj3l69WK6FqFwTlnfVLwPfhaLGNc7Cd8uNkfVdjZKL57Pfk+Aw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4p2mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 08:11:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F77fS0030340;
	Tue, 15 Jul 2025 08:11:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59mqk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 08:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4MiU2Baf5Uda0NfNYpve8s2RAVxkziJPjWR/0zeaR9plMWpADnBOZ4cznaU9jacibZ7FMPzlpu0bsZTxa1aLmRxDkutrM2Yo15a/xAA5kdc+hI1v6uoGcEsMcZebv3dxacmngxJU5LBTBb1uMprWVguZerq3Emjpj4xl3m0GbDOed9TJQEYJ1S0b3KAi89LFeDNJdQczpAxSscU0GOZanG55/XcUzu/zdvH922BNxJ8JNLZgtM4/NrbYjY7Fp63z0lo5ucz2Yh7I4DPpy+sP9R8LRYX9p0xGkttVknH4Vpqkc06cUp9mMATjZRGVX0xFA7nG0aHwYuTxWjG160hwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FT+/0DC/OaGa8PspeikRJc7qPH5CGgJs+pQUBoYPG0=;
 b=vTJv88n9osBU2lCrcA035kn45s2xHdLBTZlIcD+qQEMhH2joHbI8Rsl2aTTvgi+fqqmvj+4D/siKQXCD8BtoW49Ll8vddnWppWDRfPwSkCUE6mFiVcQP7yh7ammYirlBPYB6PuNTaWtzRqpfNvZwe36W769YedPyHFAm/LbzSc30gKLDxFHVLc+GnOBMSKMpXxS7+URFNtZ28uvD8o/xHHUA+vFCR3wLkaREG8qyj7/3BMKUiiWhyKf0aFu0VCaK9Gn3IHToQPzdGcVOB3/PdU4+LWnY5weNuauM6puKXgxGI+8P+36RRrraJOTHQp+sfrzWrbYVLlYUnUdZIyIFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FT+/0DC/OaGa8PspeikRJc7qPH5CGgJs+pQUBoYPG0=;
 b=a5H/fYZ0w48K/fNVsye9vIZJRQdqSe2moNIJasa9rIuBNyOh6g+4C4bk2drEg1oVdMWbkN3DMKUrg4bwzT8r2BcwuwqHyRrW2c+c/ZGahqjYQ++1tPeYDvKXNv+kQmgpo1e5+9hYxy3EwfY8ureKOjdrHXG440aL8TSeuyRA4+w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 08:11:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 08:11:00 +0000
Date: Tue, 15 Jul 2025 09:10:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 0/8] use per-vma locks for /proc/pid/maps reads and
 PROCMAP_QUERY
Message-ID: <f53c4df5-da8a-4ca0-9c6a-acc3e6fc3acb@lucifer.local>
References: <20250704060727.724817-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704060727.724817-1-surenb@google.com>
X-ClientProxiedBy: LO2P265CA0440.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: d7eb8bb1-158d-4847-a037-08ddc377229b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwPmK2zMYUTNViK5DYvmPFCYjTBV1JRJ2qGMLJM5F8NVabaX8EW4B3HqLISy?=
 =?us-ascii?Q?tUXwpmXicU04sEJXfYJsGjf0OZaVZdrpq++frh03CrcxEi+8gYk2OwVaiFb6?=
 =?us-ascii?Q?1SyL1g4ZURLEAfsSxgiBErILOpGUe+3yIf1oOXNbAzG+CPgJDKHlAF+jPeTB?=
 =?us-ascii?Q?G54IbFq022VVF95/Cme2r4q+7zYzN1xgCKmHcMwj3OEJzv/pnt2Us+3ea8x0?=
 =?us-ascii?Q?8D+9qDqPJMD/7O19IPH37lexdVRUIWFdrMm9r1nIsCaoQ+dYciZVVHRxYZz8?=
 =?us-ascii?Q?dGMrubekOW4BTlgdSl6onJ6J1Tpa4wxF4kBVSlRxnFIeTJHU/pPtPpyvPHVQ?=
 =?us-ascii?Q?EKgOFpqVWz4GIRhVeboEKZDQQ/AZ4oPeYzi/EY2T0MyANhoe/ml0NxG3DFqm?=
 =?us-ascii?Q?InptgKct0lR8fIfXy+Zz5UMd+89pFsR2buAxbKw3MvGdzkQQp+KUbjFCc19H?=
 =?us-ascii?Q?Wfp89mCq5X4+I8SoNIpMW0QA0uIleUnw5EIkvuTkcFhUv3L4FV+iLgidepy+?=
 =?us-ascii?Q?gkESMTnSQbgr1ztIOw9GQ+2gfuke4X0sot5ioR405apWvV142WvpVh9Jhm6L?=
 =?us-ascii?Q?wKsz3QisRkMMpGUp7R1mg3A46GMoqhRr2VEcsciTjaDRBhl0xfOxxNx4j6nR?=
 =?us-ascii?Q?XhDRe46i1v1ePVxd+aTokJ1T6fSJLPZTngMhJZE/7xoM4OpK/+PfCHfkv0Pn?=
 =?us-ascii?Q?BEZnrcrSJP6B/8opYGlTKuoU+ooZroJzeYMUr3bfqKp1OLBg4NShgXjuccRo?=
 =?us-ascii?Q?206so4HZtBFvb2hHOd3j0bHmSB+AVd+FLK3rpxKLODAAk22DjA3gOhGxKSgT?=
 =?us-ascii?Q?31NMwZKy5HjVZIHXS+WLj7B18v3ElnDk0DOv0c1M/3Yor2O9kSNocANRAhNT?=
 =?us-ascii?Q?+LSER0wB0V+sTa5aAvQ3ATaftmvtMohmBRqyOLcapBpPh1yBReClEhLPZ8P4?=
 =?us-ascii?Q?SnIHi1hiwjQtk3tGDcSy7fa2c6cyaU340tbgc981mP9K5yYwOXngs5nGvctg?=
 =?us-ascii?Q?a0nzote5dcLaIP2CSRQdrQdJuvioASsEmOulEwGV3v+SNFgeaow7LneI84yc?=
 =?us-ascii?Q?SD8ODJ7DafiSyB/1z8weJhsAoEDTmcL4X8Fi7VLxpwvpj0Qsy4f4ewWDxBJw?=
 =?us-ascii?Q?6Fj59svmG9xY8IfL8v9TtevqFRlGKODcGHZyV19gKfralpj71R5Qhg8RGxgI?=
 =?us-ascii?Q?32TuD5euke0Y3PNgjTaAC9EYVxCFJqVyCYBuHmWXKD5zN7Fv0HMnhx0Vh1eC?=
 =?us-ascii?Q?6nwAlNO9oZF6ryCIREutTnd8xyaw1kRHiCd0ZJPnE4D4moepFzzAIxmblca+?=
 =?us-ascii?Q?av5KpOqQv4j4jjaEhisXSXC0TrnDJNtpWjKLz66FuqRNqYD84QeSCLzDIIRL?=
 =?us-ascii?Q?VU0gYkxvHzs/w1FD5xsT8n9wKVC+zf5xFJsTPlC+YFH+cdsPJap/FBGJXe4J?=
 =?us-ascii?Q?WOZaLQuak4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KG5lFT/zM9XyNkq38lXUl1UCS6qXO6RCSX0U/CsDKwuGAybw4YVfGfzCZZjR?=
 =?us-ascii?Q?m0LN+IKKwANONZLEnA24yWeFI7yItuNMDz1e3RBmMZGAgSbAHlNtE5m2uFcL?=
 =?us-ascii?Q?p3CJ5+x3WWvLJ7DJPmac+LQLd/Nln5KPvXca3CJf+Bzm56S5cr9XkX5TsfoG?=
 =?us-ascii?Q?4UFUR2bdJtL9JNMsdzqVdK1lxvC/0h2vBM+H14rBmCWrwqHgoiemj6O6R7Bi?=
 =?us-ascii?Q?gy/8jTAypvO+F19f/EsyZccHzGaDEwjJ5+SKfNWw/6KqPPLa0UyguAxblGQL?=
 =?us-ascii?Q?VhsP7k0NtwDLENtrU9/3EIRCNtl2dmhJXrm26AhJEyJWlEXxr3QGK3NC2our?=
 =?us-ascii?Q?6XREX2qt9ZgAc5ovWSw/ugKevxj5Ur17c4MxkwTGi7t/qT6WIjFmjMdm/MRW?=
 =?us-ascii?Q?Dvp6Ek+9vzn2rvAzc0jiIrICnfsyVP1bbGhrMY/iXjHoibculFbgKpnzVSpE?=
 =?us-ascii?Q?uQIwjk+GoRdwrWeaIt+sAS7UwUn00p0FB2g+YHrr3BS3dAibah746B2JJwwD?=
 =?us-ascii?Q?E9dgkwv/xZI4I6BMNaHsJGBj+BIqEE86RLFSRIzxJsZ6zOmkNen11vmTWffg?=
 =?us-ascii?Q?gWAhMyFtLAISvM/Rv3xgYbPSWMr13d+zpXM9EswFlBLe0SfAaLfTCh+68okS?=
 =?us-ascii?Q?ZTEifho2pcE/ZULNhbLtiZ8LSK1w6uLCEIhggDLC1KN5+mDH+ZoW2qywxbPC?=
 =?us-ascii?Q?70nP82uSlZinBeShW+vxOeBCJLn85rRAzsC30sOAQdpjerciPQ8x8V0DM3go?=
 =?us-ascii?Q?cdwRZUT/XknE/Jt3ID7rrYs2JkUFR4CgIm4jZf4+ySgi/g+ZYxLJVGwVlfyK?=
 =?us-ascii?Q?Ej7ibbIAJ3y2wfySVrc/vDFOV7rDsYMIQS8Z8zR9HuSKjr+PCzJmFYIy6AFH?=
 =?us-ascii?Q?0LQM0ifdI5lzHthPIl3VFqE9EnUPU+2j98E62cZ1KKKxqhQkwVCbWsSvQZoC?=
 =?us-ascii?Q?xWzk9Z0XqgckHE1vieCGc1YNIXiPuai+fq4QVcJ3xhzvmZPK9vH8aitzwXIB?=
 =?us-ascii?Q?GwQYPNTIBaEaW8SPzjZDbZt+vL3v/XDGkfvawRXjzjMpUg9fGurOXfIaNZtN?=
 =?us-ascii?Q?xG71xazSjJmyQCzELS6EZW99kSgihkIzEdjW6qkVh5OET3r5trofRNcC5yJ8?=
 =?us-ascii?Q?ZEQWrPmkT3WW43KnpNil1FPaJ2ONAqUSfqEYwX5xdMMq96GimaEdVgmIi/nf?=
 =?us-ascii?Q?rBbSklrJXaTaldAzgGWY1J2Y+iRkAdyW+pjJRV21p81rbfDASxUX4QvIPnoQ?=
 =?us-ascii?Q?V42daJ5QRNM8xGuIQuQ9Rz0r2VGet3yEGrTxZ+SaTuuYtlWheJZUmfmsqBKr?=
 =?us-ascii?Q?va+YABYm4KfitylvnakMU9yz+N72omrmJB2s7ph5Uu0JlXEg3nrttthg52Nn?=
 =?us-ascii?Q?c1L/4JfiPBF13CwxDCTgnvF8OfVEJPZ7Ap9PPo28hY40VfM80LhxAjHlVMgh?=
 =?us-ascii?Q?AO9k7H6uI4vBEhVSZeodji0KKavX2SOjluL9KCmKZwmg7HHnAeEBGbt2KSLI?=
 =?us-ascii?Q?8iAZpBPtjN1CWIsEuzXanAebtdC/1gvI5KqsQwHWwa/w6e++0Fk2lJIUvwTs?=
 =?us-ascii?Q?11y8i+ssbZv6vniPiuXaLRa+ZyzpgrzsVxf756r9f4FgPXFuKufj2vKgb+A9?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8R2Ra7Nv2mV+Pm3twrdkFuQIrhsGGndR9Xw3SNSFnKRgyfrR4X/FUE2m60DAMQpQXXV2BGg8sHXHVbdCTePMMG2v4JFak1bimHwrncj4lxKbmjBP5ev6GcpzhoOWpXM8VIn57Oub2/7GOqpaaUYippclOxG07K/Kv+KqsuPle/4bvvZQ8JPIgzKMSeSFE/Cj89HDQw3R0XqBZ4Rx3JpS7/X4QiD9e2YK82DDycSpiSl60MM51v9KMVW4Whu1c/SMNPuMeDhYDyaZCCNljtdR3PtbB0AtoCd7L9q3dmyPmgTknXCOFtqjWuZz3gvH9wyLqPGY7xVDP8EwohNIwe4D+aL+eQQMRVuiuNa9BxUPANdAqN6dGHHZLK60OyXH6Uc6YIMAo7V7l4B59G6yohFuCmfy+ulfZSdq7meYmb0XM0CtxgZgLSugQmV5mxpK42zh+cdIbhlVDeNAK/D2SizIVWhtBgRzioxWNdyNgMpmLVMLhL7hfyNOedVtMzUqd246ir3HVSa35dG5pmQqYabcUKO58d28e1yTf1g6bWVSUg94s2tvHemBaFOASHCXUTYgjsjKni6PefgC7mMqE6VHaJPxE2p9ZL9XBEO22Et4sgc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7eb8bb1-158d-4847-a037-08ddc377229b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:11:00.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFbVE4b1FXYzmvikT5qd5PZt0X1Kj+pp6w6PFo5k10EniKIxARErqNyA0QuE5t9qHcaOcw2NJ+nNv+qLfO/7/AUn3s1+Upl+cKNvGtNo38E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=557
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507150073
X-Proofpoint-ORIG-GUID: y2BMC4QGPcqcRoxJ8nu6tyDliGxNMVCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA3MyBTYWx0ZWRfX6zUzI1FGShEn +l0BygKnL2QucSbzEBZPdOb8l8VAPoLO7mWrGBX2JdQHoHAbqLekzc3tFAqW8Q1ZcbHt9mywwE0 MMGI0exPSeN/ZJhFR0SLhK8m+2FxDUtBQPyEnV+DyJu8hJdwPcO39zhKT+MSXrGkzqLLbR7JXtR
 O6KczuUnda2lVeT8UdoJC1Ou4CB56TrZ9Z6flWTSBIbypqBdeeNFPZl5tunS3DadDLSObAQj7Dw LxqcyLa4AlBGogmXSiSSGNQVuHeD4kVyI6Qkq8AFO5X1Qr6Mkw3fm1I81mZGDj7WUJ2mLTkk/1d e1tBNdJnLcdObewrTB3/VhsodA7KfU/bM6NPis/5cLiIsNiAqB0cTKmPcMa6legCDuhqAZ7awya
 qvy/pn0o8lpiKmGCUqUije+dgPJkEKJrWnX8yzhrTnuRSEXc43GaehEEPbuAR9p2P9+CCdTc
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68760d19 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Jl1qx2dl9ALVm-tGbpQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: y2BMC4QGPcqcRoxJ8nu6tyDliGxNMVCD

Hi Andrew,

This series is causing syzkaller bugs and needs to be fixed, Suren + us are
looking into this, could you drop the series for now?

Thanks, Lorenzo

