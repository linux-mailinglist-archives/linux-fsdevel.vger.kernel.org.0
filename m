Return-Path: <linux-fsdevel+bounces-45887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AFA7E225
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEB2168F29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB92040B0;
	Mon,  7 Apr 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oVH0DPFv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dPc6f3s/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348F1A5BAE;
	Mon,  7 Apr 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035933; cv=fail; b=rIZTFe4pHD87UPlYVzyZ/uuic+MQC3CSHPadgmU9QY6hk1yIwCCp1p+lvo4xJDfU8PAJI4nygxpgdwg7W7oaouQ75oEb/2B2AE0muRVcNjXu3pm3MJvJLj7PQQeVRczd/umvSCbGYXsT3F8jNoX3CPAwfWz29HgRy0PE/MH30is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035933; c=relaxed/simple;
	bh=UZ8fmwFadlu3Pcfki5IcDdvJf8nBq181M26goNPi6a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AHh1pN5BtPxu8Ne8EjmZ7dNl1xKqZozvpxmeskjUPmFYPL4dv8G07YQUByz3u8DjVOMYzFNGh7cE1xIwRPrOsWd951TmMqy6QfOq25y4SrSGOjIjJfrEDO+9czqvfU6c9FCcjDhO0XgNGx+rov+SRbmc8coAwPGbiI7qtN3bmQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oVH0DPFv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dPc6f3s/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537DH2Cu000867;
	Mon, 7 Apr 2025 14:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=BrqNKeOF6f13tW3K+S
	j62+Upefw8vNIXNjfVNynqyTw=; b=oVH0DPFvYaZ1QBmlZ3sJXGBbDQoEFG+v9j
	Oo1AnkrKEMr4u6gXJsjgUXW1/GcMwGm3BP+iJKTLiTLRteRmNd4J8iYX9cyUcB3h
	nlQz+aRPXDYptW0yL906Y+1rv4S2v1ksGX9IHZ+0uS9rQIHPXTyiC5Us7sjHDTlN
	seC//IBatN2FvuILU/nlF+cqoTM92d5kpKzFZlj1Q5XyFGQBkOhcMtigv0gyaeaU
	6Dohes/Zz+gvVAFse/W+ziF/b3WIW8copkTQVRFYbqTXuPpzkuoEv3QuDxOL9ug1
	kKc0WUZ1kMXUA5B0F3Ighe7NGUXVvRnMDWkFNDXCtPnPanZm2NmQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41ara6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 14:25:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 537DTUbp020992;
	Mon, 7 Apr 2025 14:25:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttye4pby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 14:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDBertGqFA08t/k1xCYF9+2B+8MZG/ZgasYSM7+IKchJA3gx0EAbxZ8OeCRGiFpx+GGRzO1oqkoL5etKAOej02n8wHxu9oZ53aH/5IusV4GoIzZ6tc29YVAqZZFRTM/J6dRErzDX080HnKioYZE3EG9i5lh+TpPPx2rS56ta8h0AgOYlikv5YPkmSY52A0Pere81iQrXkWpUT0NvhdfIpWNcA1UuAAyK0Zv82N26d5xJEi6N7mKqOX/4FMqnFETYYyeoADOo1a07Mukyj6hoygh1MEWElMgebvbCRHYavarzC2dUrxUyzecF4kJ0/BZcNryNrydYlvoLITBZpnTB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrqNKeOF6f13tW3K+Sj62+Upefw8vNIXNjfVNynqyTw=;
 b=iwOOoDKDuh+LfEOdKkW/VD5nS1AjVztINBVm23Ix+6bmSIMvZMgYXXaloLFSZgwEXZXaiP8dhIEFlKgEcF7mpRDl20+80ablf1e1kRBm7XQxMr1TJ2tjGosDJB4kn7hD9HUmDu4N0qaJWrDCZzmJI5eVXpvNQJ9b5vGTFDxcqNX1v1D+K2f25DaACXmzx8/8yUc8sEKUEk8cq3LttKwfSk+SXUkGCj3gko4G1BRocvzE5AeGNy9AvhOLTOqEVObNXJipw1DA21Rys2Lq2B9lenxjO+mrpLCbeBQZfFnWa6Js093I2ilKFUH/j6SXnZoRieHt0qriT+l9d/TmaWgEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrqNKeOF6f13tW3K+Sj62+Upefw8vNIXNjfVNynqyTw=;
 b=dPc6f3s/vFVXHuO4vHpQKiImdBF9jp/f2Q6GfUnwGRu4zSPMGF+qn3tZjaJGHsXMtu9dA5d6fWP83B3uyHz/sZSHK3oEStKsV9GRZpd89/3MXg83hpqhtAUr0I+gAaHqJ8vQHd9aNsvpjGcPxQEpY6+Ajeyf6LsX7fe3/cVIevI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SN4PR10MB5592.namprd10.prod.outlook.com (2603:10b6:806:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 14:24:58 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 14:24:58 +0000
Date: Mon, 7 Apr 2025 10:24:53 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org,
        pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, hughd@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz,
        lorenzo.stoakes@oracle.com, jannh@google.com, ryan.roberts@arm.com,
        david@redhat.com, jthoughton@google.com, peterx@redhat.com,
        graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk,
        derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
Message-ID: <2bohfxnbthvf3w4kz5u72wj5uxh5sb5s3mbhdk5eg2ingkpkqg@ylykphugpydy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Ackerley Tng <ackerleytng@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	muchun.song@linux.dev, hughd@google.com, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, lorenzo.stoakes@oracle.com, jannh@google.com, 
	ryan.roberts@arm.com, david@redhat.com, jthoughton@google.com, peterx@redhat.com, 
	graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com, 
	nsaenz@amazon.es, xmarcalx@amazon.com
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
 <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com>
 <63j2cdjh6oxzb5ehtetiaolobp6zzev7emgqvvfkf5tuwlnspx@7h5u4nrqwvsc>
 <ba93b9c1-cb2b-442f-a4c4-b5530e94f88a@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba93b9c1-cb2b-442f-a4c4-b5530e94f88a@amazon.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0479.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SN4PR10MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b412ddb-de80-4a2a-521e-08dd75dff9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kbFV3UJ7AMu8AL3PO6SjEN4HI1Bww8N46/nvfk3DySteGYEPR9ZXU1IEkaY1?=
 =?us-ascii?Q?q4wWcHAl9FaRo3neKcXhlf+X9erTE0ay8Sm00ld+0Shl4HBLBkU1vI5uhAED?=
 =?us-ascii?Q?QHIZJyMrmkj1In7nQpkJw8NKj1TU7sOngyT4ibWEXLUe4IhRigfZEjmE467Q?=
 =?us-ascii?Q?2zAYaE6i/rjdIa8d3q6E0WekH+FTloa5k2/rzYU16iCJoD4QseoJAsbGlC2p?=
 =?us-ascii?Q?h+VQDlmycRlzOLCqipdLBWjCsXX3OpqDufq3i4Q19Q5Nivzj7bq31SIJ9wXB?=
 =?us-ascii?Q?kJ06L69DK47Vj0kWTo9D4njH3vO2OvC1WEkrI+ZecEbM1/E+pNx92bVRaunv?=
 =?us-ascii?Q?HnQilD9tA5q//6f8aYx+fOx1+xqXgKVSrugucEdg7+LustTyiXYYDwSzbLGQ?=
 =?us-ascii?Q?MuOPR5nThR9Qyuc0lseGic3qsXLg1n2QMd97NG00I2zdOMwaOzXOOUKn5YP1?=
 =?us-ascii?Q?lnJWZ0PkcbPShsM+VUf1LEorkSkGyvQtQ0Ji1lHkmcYQQI2uE6EB1ePHDugn?=
 =?us-ascii?Q?be1Tolc+cu7GyRupYYJZ3p2Mz5N+9FmNo09MXTEPGDE06YXXnnMxFoWUQyBb?=
 =?us-ascii?Q?ygC3sP18Em8B8uPZmGkYcZ9QsnRWGcTgjeQo+qxIFexnTQ2VFfUogQpzQtwJ?=
 =?us-ascii?Q?z5UqdEtdyEbXbunR/hyg9Y6EdBZia/BrDQXuS9DKYMsB0pdtlQjGhbEN8XkZ?=
 =?us-ascii?Q?/eJB8KlSf/i9+C2YE+6YcySo0hfgV/ciAblIY6RN9lTOTuIYakCLjje6crX3?=
 =?us-ascii?Q?ltH+PNQHDoLseOiyhEcF7ia8+QAPYIxhKsRj/mq/TfaCPR3lwxDuDpyrRLOb?=
 =?us-ascii?Q?aMkHRvzJrto0uZybY2Do/LwLVbrQuNiOb5ORgq99vbd2LxuzZ/vxXHvP4izD?=
 =?us-ascii?Q?VNSGAqINMxiMg3kpCmE8aaW2ENitx8VabVlH7KaPOqiPSttFt2xmZHU3OMPp?=
 =?us-ascii?Q?UJ7NTfgSnCVxnbVROUCEY3oDY8sTXU+ccXYZSIZHlGYKYAsjHvVPZga4Jdvv?=
 =?us-ascii?Q?1PGzbzQ3WYH8Kgn9Zxc+e4rQKXFd00ya8qzTvOXD8iHVS07OdqkdrH0krNY8?=
 =?us-ascii?Q?Q6bjYkhfU0iN9R4ThuXloHi7pKKdbzmm60BkLbHyTDlRPPrX+QZ7fzWoJqWB?=
 =?us-ascii?Q?EMAU+g5Z1sa7fQQ9dffXWSEBE1KH//qd82Na6FImOWhu7P5StRNiPwRZIG4U?=
 =?us-ascii?Q?bttuZGOf/9gdVyUNqSAsxMaZczaiHQoyAcxQ+lwdlcyyGS8PZQXPEkhVcSst?=
 =?us-ascii?Q?sEemIQ3YsnmDwOT0d/GeSiwX3fhJ3dRP0F9dcbzCeq48YgRp2GYwGEkDPHYQ?=
 =?us-ascii?Q?Bqt5cca/YymedQNgwiHBuwBQt99A0OWshZa+cSLR7vQxOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DtRw4/ISegXk13ynxLUOoItB5QIJ918J2MjttcaM1/LF4ONDJ3BCW71gYSRo?=
 =?us-ascii?Q?uvS8ZuEvTH3l0ygsJnhcNsRQgidUcyvmuR1hkGBFP6EqB/Ai0ua4CpvcAour?=
 =?us-ascii?Q?ZGkh6qroVi6EH9a6Uy8m1F+8ClOJ19ZLFH2E1rSSgyfANiZOIOVSpP+vc3Zi?=
 =?us-ascii?Q?PSJAklUTYXfD25ZXpJSMxw+75Iowy+2Gc5IWPoTyOVV+bYvSDnKQaAfvW+vI?=
 =?us-ascii?Q?hO8vspnDdFCZyglaYSBfgZuwBp3tzNVnheTPmdAX+iRmS4RRkt/iVFW451tq?=
 =?us-ascii?Q?z3lgd5q6d40/1m52eWIipvXM/7QZVTwH9GcqYQwYPwZeNz12AfTbhV/0EC9k?=
 =?us-ascii?Q?aKGsaQlugqyIHJVOFB/GDqyhMZoHjBPHZ3aYGi0IP8C5LgguIwBa4AGu/5dY?=
 =?us-ascii?Q?qB3wMo9JKFbi1SMPoTPV+vqEf3YnEphOpVAC+0CHAj4Jku0CnHYU19MWS9ub?=
 =?us-ascii?Q?xOS4ZQo9CXzZrseKX4iRwvFMZWROxClOKfBaZfHF0EZfhEgy6CZov0Q88B5q?=
 =?us-ascii?Q?7rAL0n6rY4Ghp0jiQn+N0r8wi7wOA7SnSqkFi14ksSk1seo8NWzCog9GjiMv?=
 =?us-ascii?Q?PyMdPQmppO5tmNyb8zMXGRctzE5YueUQGyTmsYeeTbDRYVC4Eg3SVCNgMP0Z?=
 =?us-ascii?Q?jrQeHic0fMsxy3LgwKohzNrTLFWXVZ0C2TW21paU8Cxucy7+7Vv7s6+3Lgki?=
 =?us-ascii?Q?TK35pWWgAUa3J76+mfAGFHWxrhXW4rbOLIGKDAUO5fpmE0Rj8yQOMZj9hVlt?=
 =?us-ascii?Q?jDI0m/ZWib2J7TSur7fXgL3zx/sLzwsH0dtTWHwIUUKmBBifDgRrExjZAjXj?=
 =?us-ascii?Q?+07GVLs3qJKu9n4Te9PCBML1KD/cWzGZAQv1+TexXudfq1GFR8qfbWCNV67v?=
 =?us-ascii?Q?zNmHSkH/vUx7CeazGOwYgTdkqOCc5cat851ueRkroEi5qfp6KWebuTXjovKs?=
 =?us-ascii?Q?603XIiMQKByX8jCtdHsxNxEpB/M75FRMD26op5c4B/GUT5wtdAzp349g3xy4?=
 =?us-ascii?Q?Su9COyTLVwWo4chnovvudcBJb3iYX6WpgxD/WNkhO3QIxOPbBzF7ah8t4gYK?=
 =?us-ascii?Q?c+zQ8ZmCCFQZRT7YO+lxM+4LR3hsVkxMsjj9L7zmqrYQ+4ihSM03CtkpOjqw?=
 =?us-ascii?Q?181oOqV57BQI1lvi9nWBTuOU4EPVJaUIZiRE9hb4dgCxFuzCIQ1FnhE1nypq?=
 =?us-ascii?Q?0f1wKqRSYYDvRdb8zs5dHlX7ezgncc8HyNvS8EILCEybvrn4B7lKRsZdLDUd?=
 =?us-ascii?Q?Mu650xCxGvSKYFE2S3FxEwkiSuzmesnRsQ75nxbwyC1x3NK9h+htKD/fw1Cr?=
 =?us-ascii?Q?jbk2pSRsw3aPEkbqnwEtxwItEX370EmazFZjiav64B0dWt7o0aetMt0Z/UDl?=
 =?us-ascii?Q?6El4SUbRe7scYnYnSy6Xd1fLJ0V1izSF6dNQdxZVKWuJY3zac6+8sgF3bApi?=
 =?us-ascii?Q?JWd3JX5Cc2LRZ7dly39cpwZbwUYBaQsGPlJpfE5zzcL6euuiTMvr3TLhnL8b?=
 =?us-ascii?Q?+msKFoYcWT4qrH4r8lWEEabomZBuD+/aV331zWcH5JsUc5UpMolXgw609IVo?=
 =?us-ascii?Q?qhApjsNXUFJ4+SWmUzyf6elPM7P3fKcekwSVVXCg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RcqKy25bZUYXLUbz9XBpiY35bvJYk/bmJ4E5hLQC43M6ftlotqXh3CrstaHWMnnyUVtBs8qe/8BBz+FIx9mmg/nfAuMsK8K1pDb5Rs/1PoYJoXgjwUC1WjOHHLq41q6p+2RkDabtz8+z1nAXZTh8YtE1WlvZF7JyQTO3IFX06tSfULePFvG5MaM2N1C5l5RknQ6d5BdjiKlADc34gqdfYHJCAtEVdzroasyc+AOhB0MqvUWna9ys5sOl5V6QivQXEqL6lAoCru8V3OgBELBcORd014tmhe8JA7FcsStQ3Ip6pxch9f4pTlu9uS7qPMPBEb65wezuBOk9BYpD5PnW/IDBMIcttNlazjshdF/a/P+wptroFofquYYOckencEe/hdqS6LAg8pZRtNONVO3pp0P8du5h3YFRniK9YL4FUMN6eU8Z1Y/qv3vBOMRevep7qchPLzhGNzoLkjibmnPC/9/hYq92y+c7quxUu6gMDk7dS0Qqw2eXybPbAGmsxDrmT/Mz4h0uVCLPvlvf3U/i0WS2rPvbnhacL7ROugc1T7kus7vv6hQAAo9GyLLkvsZ6U2iMRSMQ0tZT7tyGfCg8snvyUiXYVhfuBY1MB1//FBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b412ddb-de80-4a2a-521e-08dd75dff9a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:24:58.4369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doHVcb6FsaBBMDbAv7gk/9W9DIjVU/js6TXXI7SfokjoSr2kRi5drNQjqwiKluT8QerNQOZzo4jwybVyHPt+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070101
X-Proofpoint-ORIG-GUID: sDohRJaxNTwdM44SixXEAt-TKobC96-z
X-Proofpoint-GUID: sDohRJaxNTwdM44SixXEAt-TKobC96-z

* Nikita Kalyazin <kalyazin@amazon.com> [250407 10:05]:
> 

...

> > 
> > All of this is extremely confusing because the onus of figuring out what
> > the final code will look like is put on the reviewer.  As it is, we have
> > issues with people not doing enough review of the code (due to limited
> > time).  One way to get reviews is to make the barrier of entry as low as
> > possible.
> > 
> > I spent Friday going down a rabbit hole of patches referring to each
> > other as dependencies and I gave up.  It looks like I mistook one set of
> > patches as required vs them requiring the same in-flight ones as your
> > patches.
> > 
> > I am struggling to see how we can adequately support all of you given
> > the way the patches are sent out in batches with dependencies - it is
> > just too time consuming to sort out.
> 
> I'm happy to do whatever I can to make the review easier.  I suppose the
> extreme case is to wait for the dependencies to get accepted, effectively
> serialising submissions, but that slows the process down significantly.  For
> example, I received very good feedback on v1 and v2 of this series and was
> able to address it instead of waiting for the dependency.  Would including
> the required patches directly in the series help?  My only concern is in
> that case the same patch will be submitted multiple times (as a part of
> every depending series), but if it's better, I'll be doing that instead.

Don't resend patches that someone else is upstreaming, that'll cause
other problems.

Three methods come to mind:

1. As you stated, wait for the dependencies to land.  This is will mean
what you are working against is well tested and won't change (and you
won't have to re-spin due to an unstable base).

2. Combine them into a bigger patch set.  I can then pull one patch set
and look at the parts of interest to the mm side.

3. Provide a git repo with the necessary changes together.

I think 2 and 3 together should be used for the guest_memfd patches.
Someone needs to be managing these to send upstream.  See the discussion
in another patch set on guest_memfd here [1].

As this is not based on fully upstream patches, this should be marked as
RFC, imo.

Thanks,
Liam

[1]. https://lore.kernel.org/all/aizia2elwspxcmfrjote5h7k5wdw2stp42slytkl5visrjvzwi@jj3lwuudiyjk/

