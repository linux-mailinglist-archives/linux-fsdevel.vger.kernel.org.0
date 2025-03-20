Return-Path: <linux-fsdevel+bounces-44547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102CFA6A42D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2272C480D9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E325F224B1E;
	Thu, 20 Mar 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Msr55MZN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ApUmagpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84152224B08;
	Thu, 20 Mar 2025 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467912; cv=fail; b=CfVTYopv/vjbOVSwTTjK7jlmzxbF12we9eiYwIjpO7WUCZRFWuQYjspGtxINRy1uKvfS3VJbPskc++Q4CN+8whmX9szekEwJ5IIVoJ6kP8rnjnAAKWH8gdGfK0h4ug2nvrKUMWmlXhY3/r0uPIPR/t7jc2RUS0hbkg/Q4PICXJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467912; c=relaxed/simple;
	bh=x2xxZwxQIixMxr/s1j7o6s/AERIRei38BptQWRlKDg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ji6WtU1h8RC39QzvC+111BPJGx5Ztz9c+C4usHJo3G1df3M7PvIDGQLQyQxvdnrJo2IIBtr2fyG0HGPsToIgJIkgEmahvw0Lqz0OV+I9CIdUEXkdVhopqD+bkLVR3pWWey1f8KQ8RwrJ2Ho4n3kHXDDTRtvkyuNTJnevukCWrUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Msr55MZN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ApUmagpK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8Btc5030528;
	Thu, 20 Mar 2025 10:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=oL8F959W+A0it7bseN
	Gr8KVak9yhBADSockqsKHc3u0=; b=Msr55MZNEEHowmMcrDbjBPIxanAfXL3TT2
	aLM2euamSg5tjbxubUexBvi7bGbGHnL+8L+fXY4f419Gk106rWpCHH/aNUtRS4Ud
	kN7AHbtLBCOCsN5+A/BeMu9ZjZ7wo7QoE45mu9ckgJMSbWJbJJxSxHa5cnUcwQaX
	BnDDPkDzEMsMgIGPs2a72Nh8KXYtPH+XXbWFfjtAJTROP1gdOwiI/Tt1U4SSv7ar
	TyZqp31sxa6LKhiAuJjz1bGrUSV6mmkmpkty6tvM06YVrRJ5vL7n1MXlgXcfeYhl
	ZdKt2jaypNqqX6dkyaRxcYnvg9V3LeOHgp8XevGsXVdVYwdX8Ymg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s5u7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 10:51:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52K9ncX1024416;
	Thu, 20 Mar 2025 10:51:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbm7gyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 10:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGaxE0GBIQCDoVhRsFIYEgQzHGSxh7Tz/k+eu0k0p8NXrtdcADTvAK6UKM3Zflnz0RWogty+UGu4A0+kZ5W1IfffQJfJgbeLuYozlFAq+ocmKzq7PLs7Zy9ZjxhT7XK90iNlzY6dABpKGXlKkLczHbBl8Qt4/OVBkn8y1+tbFPqwie6LQop+Pm9m3ItFcVYUq+Q6LFgN+WSlLhX832Yi7LcFqR5R7qVAAZAaEq6zAvAmJ1qoi4/iJYQ9ln1hqnPBaYs7rdqy54doQjomJ4xe1wW0D8OfRj64YFAf2AvLK/eubuczWRLMBBlsTXYP2HZYMk7EwsU3vkVCjP5yR3SHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL8F959W+A0it7bseNGr8KVak9yhBADSockqsKHc3u0=;
 b=EnOp7I95y9H3osnO3K6xllLAvheyjaV27BUxtGjc2my1Jml2ZWMcDsaJyR19YyDMYaB6NIRf09K2uYuQz7CzeSa/2AevWjAfMPBUY/OpFXjxtRcnbq26z9y2o0ejamvfi+sC8Lm3MjN8bBCECf9WdIj3gDC4sZLVnNDqoB+lRIiXlia6NaXfOGRJXa91cANG2sLlRJAwd0zLC4BZHpQ82UhwcukJpX/CsMpHoleUF/iA9v91q7c/GEo0pPy9Eloek85s/ExmHxGEDCxOwtP/t9FONFsLF9ZOuOGRfU8m0MoUMjaH0Cx2G1+lm+nIJk+emAvSNg9zzKhsUGGVZ6lXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL8F959W+A0it7bseNGr8KVak9yhBADSockqsKHc3u0=;
 b=ApUmagpK06+F0SgCfUXr2WFXum8y7+pPOv+afSv34p8ZLHC34JzbCqx1Ge9gRVrMnjLs1F8qi1MI0J2sD09HXbu/2GYzvHqBsj/bYTeJLba/YHvxVbqPukKIj0FIUyjDFIokOfzuLdY7wnVuQjQViV41zBG3IGVjKTnkBTJ7GSo=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 10:51:26 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 10:51:25 +0000
Date: Thu, 20 Mar 2025 10:51:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 1/2] fs/proc: extend the PAGEMAP_SCAN ioctl to report
 guard regions
Message-ID: <971623e5-76a5-426d-bff5-6a4ea1ac3992@lucifer.local>
References: <20250320063903.2685882-1-avagin@google.com>
 <20250320063903.2685882-2-avagin@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320063903.2685882-2-avagin@google.com>
X-ClientProxiedBy: LO2P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::23) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ba9add-b9a7-4126-e716-08dd679d28a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ghEoq125yj3au9ud/7lReVhsOf6gdKf5iXMgqn/E7jf9pUNu/68513MKACYF?=
 =?us-ascii?Q?UAdRN2Rwbp8n+tOm8ShgwqbTKB+G5DvCUo/To5hkiT4AgIde7v3AHcT+XDVR?=
 =?us-ascii?Q?y3kFOKhQUDl+e7XawX3DPbdQvfgVTAXN7cRh6hkHkX48RDY+e0nyAdlfS8/p?=
 =?us-ascii?Q?MnVmfqgY3GIOEelVFnnS0vKYkvI4VNJPSyIP+gukS9d6MTfZzCdaq7ogXMNv?=
 =?us-ascii?Q?0SubKPxQOKSmvhc9GJ/0Vpknb/qh2AZHbAYWK5RWOPuqgyPGMEj65cAJslYd?=
 =?us-ascii?Q?tAqyLOR/CJuDMEKJ+buqY4udgumrHDQJ/SX1lUwSN7R+wpIHmL1J8ernMQ04?=
 =?us-ascii?Q?Q10shecb9+1Mp2oqzgVx7qxsMRmLW4RP2m0WwJLLHCTFTmzf9I3AlB7YiLhg?=
 =?us-ascii?Q?mcvpr5I+p9EHYuVIPaAfH/ExZy6hgaAFxQ9ibrpRIynrsh4A2iEAbLB+H3wb?=
 =?us-ascii?Q?kB7JNJdria/EhWAaNDycNrvTn+u7NR5GWdN/q2QtnNuNLAS6d/Yg7p+Nn/M5?=
 =?us-ascii?Q?yG42W9pY0zPXFIVZGMHL9TejFyOfI8frdqV65wSmcV31wW/rUmzMgQnF5pdX?=
 =?us-ascii?Q?GtdG8FiqnS/AB1ha51JVEYU4sjs1IDa5sEg2SfhFQtZf2oIwRGGlEmE6GKqL?=
 =?us-ascii?Q?pdeVMWq0B51BvmdWkBkn7ZxAfX19O7kkBoCs6RGuuCFcbOWgKRQ16Uh4BZ/Z?=
 =?us-ascii?Q?TNCdntZKV6V4SU+xywjSYsVM2vM7LQLJJbvxe3bKj28182wc02zRloIQhMQm?=
 =?us-ascii?Q?JxY8JU4nCeplkmQI2bHG8kTNfNDJ79gzWouTXwyiJwvsYul7T4JkxNJrnxRx?=
 =?us-ascii?Q?lo4cHmkhcxQWxd1rA1siM5/8WWiGg+cEOehG1n7qZqH4t3T2z2gXyU1fd/wk?=
 =?us-ascii?Q?EYWpEOPY8m5xIfkGXEr8QjMYaJaEuFvBuD2nfG17LaRWa6oj8x0IuqXzMqNt?=
 =?us-ascii?Q?G6/bjnOdhQ8R4V1k0peEoBQoBSsBTUxZt0It7s1oQN8Jbxzl6BDyj1lgomB1?=
 =?us-ascii?Q?pScOJHbju0Y/22au0SsgiapmUaSt0lm0rR+hLtMiGKL1PSRNgPQiABLllQSH?=
 =?us-ascii?Q?RR+ZYi8MfGTgdfbXW8xszTA0Ec8enajLfo3EzNy3oogBNnN4ur+FrRZX3p5Z?=
 =?us-ascii?Q?ap3fHjIeJ60gGkXIp73sH4Kt8l5OErk0jTAVic8WHK1pLHsgA2C6cOGyzTWl?=
 =?us-ascii?Q?4YU/BnnUdGQQFOnxrAX2I3vcGMhgVu23FCOZglZDULyIG5C8uVJv824X5vU9?=
 =?us-ascii?Q?1h9x/tP0/iDto5Tv0v1S3h5LFqt0ZkomIKyDYbp+ctTxfyXBOeXA3YbY8gm1?=
 =?us-ascii?Q?wHbHIg2E4pKwMvtoKyVXfahEy3lD8cNw9jmFVIny5tI01GvdL9mD83xX0hM0?=
 =?us-ascii?Q?ImrAJDuSIT76rgHB/G1nekJrN7vT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4wzuano0qACnAg8kdn6ivLWVcH0gHIknT8RoVxh+sDtbGfivcnmB3gQ6d3gq?=
 =?us-ascii?Q?271vZBQEzjeg7Nohqzmin2cixg6iF0e8WW2jHe6B5tGUb0WjVbz5JFMD8IQv?=
 =?us-ascii?Q?dAqi0RdQP4nEn0sAXDsrrQCq5QPK/EAtt96sjJx8g7xaTdJjbl6jaVeDdon0?=
 =?us-ascii?Q?Za3Y241mLftwkfpGLw8AZikVbfGbWW4wKeFJGHF0PcOtW77p8N5egRo5v3mX?=
 =?us-ascii?Q?FBil3FndsGYrqp9/RuNCql9FRYQKcCyUKiRrIWtoGpOP+C30b71vr9BIhSJx?=
 =?us-ascii?Q?i7RCeNmOJmCStLA/Z38vh0y4zfJM4JwZKcAw9EZjhpLNVVg2Tyk6qQmOlU5a?=
 =?us-ascii?Q?R2j5N/tdo59Gv3m32wRN+bpaGpuFTuhjdO4EMkySTnDbs9nDR//7YbYtWSV/?=
 =?us-ascii?Q?1PGUiEmq5WIOp/kXbrLZ1HbNBnSfbJeX2FruGNrpFJw9c8kniISn/GHBZhTC?=
 =?us-ascii?Q?h1O7Gq+W51j9Tl5Hm4vrjmuOUJcm7GkVnCVfl4dGml/O7c8/js7LSY0InCTt?=
 =?us-ascii?Q?wgiXC6NCQ4dvgkutdhQxsUd/Kczc0Ay6EPRWxaNkDMl4hu2jUnOFyQxxeZuP?=
 =?us-ascii?Q?xHdeyR1I3yJZcY3/9nRiaVus1CyXvbFQfAStKrGExfp8M4IsgbOe/pngwNei?=
 =?us-ascii?Q?pCFnHzCN+P3zJkYyCm7XGQXc0beTs2538cJaiDQv6nDZp5VSIDrMzNXI/RKQ?=
 =?us-ascii?Q?MK/ZbAwW+vxbe/YwzGJRHp5OXkBfsczwbQIKLVAQ0njRYYPNVF2NuEhC0BD7?=
 =?us-ascii?Q?JRX/I9JQYNu1kTc+98bienqsbmnewKmqozJkKED8DeAmv/2Yp3lDgCg6bCFm?=
 =?us-ascii?Q?kgSwVjK1pHf/9D8GK+GKWwFdEXgqSrFrzr0C3Z4nkbQSdWTPg+juu+U/FjtK?=
 =?us-ascii?Q?qpjdo8/4a21o/na3b5d5pmx4FuqRoxFr4rZhnOkXWLHvVWcfhuDjV/V1US5B?=
 =?us-ascii?Q?mjNlLZM16Gb5OeGZiUz6vbKAvzL2ytySVIbHIzL2qzf2MZcnK5fwMkAzQ57r?=
 =?us-ascii?Q?J0g5prFpKP0nvyDdkzrmXZEkKHs6xRQw0LpO4Y2Sjg4DzX6bU6aINrngLYge?=
 =?us-ascii?Q?dbHmRUQy530GS8ulMJnfmS3xeL6uc/nB3srzNceplaJ/wpr+ea1Pmh6bdDx8?=
 =?us-ascii?Q?fh7ahaasXMADaVVvDi8xphn11WBd0Li5CeG7u7RLLnaP9zvQjFpEgiK2m2Yc?=
 =?us-ascii?Q?MAEEAzR44qcFFkFuY23BStPtxSfX8fBVTcV44Qoant74xWRAtMZRWPjHaemO?=
 =?us-ascii?Q?IE1cOUTjuF3FoT+PDMEgC4WzqNyvJFS+LuXJSUe/BraJ+ak+XsJEl0RdWKsC?=
 =?us-ascii?Q?bcq4dawzaFr/nO7+we9igQ2ytTSxm1dLAeBVVVcXljIvEIU4NJc9HlSRUVmO?=
 =?us-ascii?Q?tt4JRj6eJS3wj5wmPr8iW9PIw6/uBOuqMl3KBKosPb30fP8yj46JcfT394bm?=
 =?us-ascii?Q?4nNHYDbjRhsd8DMoZii70mjiXADkJO8aJAHcSjD7YbZr697HO6AYOPbr6CZr?=
 =?us-ascii?Q?kEyd4DzP3qe5ldnXGzuuWFrwfU1lNk2fDB0Cm+eQ0//KbSXG9fHuMknR/VfW?=
 =?us-ascii?Q?bx6uCU4NC8mZXKN4S8aUhhMDpizJq/XnvaB/d5aK10orY0hNn25wJfuiAnLp?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RGXt2BxtcbXjHnlvJNAOVuLideaRfOPz79Ja9bDh/ON8S6Is+d5h2wGXlvr4gvRjgBj+cFh61ZECh4LyHWj8HfzMgKzfR0W7A3Xc3UDLy4fgaT820wZLZS4JQiqyogsuuaGE/cMI1dgtvUuHffdkTvrAcN9CYX9f2Xj7Co/UIrR8LkdjSPZwG05N3q3j23m3XniAIxpBOpcQ9ojC0pdJFZSpg8N36EF/Ky1uQY5qGrj8VH8YSDqqGhFJz/PySEoK4MwI4TtbOAiVI4SbmJAfgB+QgRheBmEl/ljjU0XN5eilYhGySqen4ELcNSjoo2SN1WpJt1fmuXFAxtU0bpjSVtOCeg97GapH49YTW3hoLyWaqhqgBDocPbJn5WL1dQVSa+xBp8F4aNh42k5UHEbIgWbffLf27I2CZ5t+Hgb2BsiCOxBCh3i4Yr6ukOLs8mFie1qDazMDo2LI6p1Hs1eVSU8IWlEmp+NpZupcz4/MZsrV+Bi1j17xyYAK0Q8uF0ASCzNZLnQ+vLmFtTF2p6Luy6ZNeJmAm0w6NlFOV/rJ3Bz8AXpXVTIAH0NtWNp+xzZhVPX5Ih4FOsozXJF7+wGQ0CWjLyjbo8TOGVMq1R1S2QA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ba9add-b9a7-4126-e716-08dd679d28a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 10:51:25.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U09tQuhwFWKGu3yTPtKC2JnIzAhko10JzWnFh5TXjRxKmBgDqH+xllOYsHDU6VYj4Rw1CM7DyvvF2lp5FCWqEee1FFilXCweliwWNital0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200066
X-Proofpoint-GUID: t8irIwb4HUltYK1hOzaJbQue3gQoaHhL
X-Proofpoint-ORIG-GUID: t8irIwb4HUltYK1hOzaJbQue3gQoaHhL

On Thu, Mar 20, 2025 at 06:39:02AM +0000, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
>
> Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
> information about guard regions. This allows userspace tools, such as
> CRIU, to detect and handle guard regions.
>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

This looks fine thanks!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  Documentation/admin-guide/mm/pagemap.rst | 1 +
>  fs/proc/task_mmu.c                       | 8 ++++++--
>  include/uapi/linux/fs.h                  | 1 +
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index a297e824f990..7997b67ffc97 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -234,6 +234,7 @@ Following flags about pages are currently supported:
>  - ``PAGE_IS_PFNZERO`` - Page has zero PFN
>  - ``PAGE_IS_HUGE`` - Page is PMD-mapped THP or Hugetlb backed
>  - ``PAGE_IS_SOFT_DIRTY`` - Page is soft-dirty
> +- ``PAGE_IS_GUARD`` - Page is a guard region

NIT: 'part of' a guard region.

>
>  The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c17615e21a5d..698d660bfee4 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2067,7 +2067,8 @@ static int pagemap_release(struct inode *inode, struct file *file)
>  #define PM_SCAN_CATEGORIES	(PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |	\
>  				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
>  				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
> -				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY)
> +				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY |	\
> +				 PAGE_IS_GUARD)
>  #define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
>
>  struct pagemap_scan_private {
> @@ -2108,8 +2109,11 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>  		if (!pte_swp_uffd_wp_any(pte))
>  			categories |= PAGE_IS_WRITTEN;
>

You don't show it, but kinda hate how we mark this as swapped even though,
you know, it's not... but we already do that for uffd pte markers, and
equally the guard marker for /proc/$pid/pagemap, so yeah it's consistent,
but still weird.

But fine, I guess that's something that already happened for uffd PTE
markers, and somebody searching for swapped is going to be shown guard
region pages too (and _right now_ would).

(This is a grumble/mumble rather than review comment, really :P)

> +		swp = pte_to_swp_entry(pte);

Total nit, but prefer either to add a newline after this or delete newline
after the block below just to indicate swp is used for all.

> +		if (is_guard_swp_entry(swp))
> +			categories |= PAGE_IS_GUARD;
> +

To be honest, nit-wise, I'd opt for just dropping this line... :) yeah I
know, the most petty thing ever! ;)

>  		if (p->masks_of_interest & PAGE_IS_FILE) {
> -			swp = pte_to_swp_entry(pte);
>  			if (is_pfn_swap_entry(swp) &&
>  			    !folio_test_anon(pfn_swap_entry_folio(swp)))
>  				categories |= PAGE_IS_FILE;
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 2bbe00cf1248..8aa66c5f69b7 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -363,6 +363,7 @@ typedef int __bitwise __kernel_rwf_t;
>  #define PAGE_IS_PFNZERO		(1 << 5)
>  #define PAGE_IS_HUGE		(1 << 6)
>  #define PAGE_IS_SOFT_DIRTY	(1 << 7)
> +#define PAGE_IS_GUARD		(1 << 8)
>
>  /*
>   * struct page_region - Page region with flags
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>

