Return-Path: <linux-fsdevel+bounces-47347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31B8A9C5B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7543B8EC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12523D28A;
	Fri, 25 Apr 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A2/CXGbb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E0E01IEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7123D289;
	Fri, 25 Apr 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577626; cv=fail; b=NFfGNIQvv8dJrzTBJA3IKdP8dan152za0VYgb8ajT8GCwIW4/lusMS90o/Guao27q3bXHk2VFpgRou1H3TIQ5J/bIEIBskLhLBXWTrxf4p9J9sJjqpTZ5QYydG4HRI1VV7Uvnrx2xu/6xaktxvWxVvauNjlGMbp1Pn5kSfLDk/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577626; c=relaxed/simple;
	bh=qnGqkdtzDPWS6/yOD7UsBuNBYK4zVSJyvm7w11t84So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rp/DHKNoC1TWowG4q4Cqcm2OPoqTqdGlO9iC2Sk61O+SywKElxwiHhPWany/L4cSpeK2r9FAsy8tMB9S5IG15Bc5vxVz7yx4Mgf6rhw9qggxH1hhBTyYrTTWqoHqdOWr70/50hkW9LeHhogxmEN6/lTVN5QYfRuejVtjpVKNCz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A2/CXGbb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E0E01IEk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAXeVi004979;
	Fri, 25 Apr 2025 10:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zDw8Vx48GvGn7M9MUH
	PQtwXtGNEGWbokvwP25OSiqww=; b=A2/CXGbbw2yQjButzKb5gsD0uXuQ0gAvmf
	ygywv0tUq4xTzgMT5cIHr0TJjla0ljRew/zNCwqm0mMNHQjGdaQUT3fQZ1CGvy2X
	EdVfKzLuwL89GlhyLrJ6S5S9E54EPvF/kw5Auz4tWYaIKk57RAVqT5sLWtK0hYIL
	hUPJw3Z94uBQVAExnJWf/xST+6UCJrcOJmrIHVbTs1AMB2DUmgfKU1kI++A5ditd
	QP63fTyapI8qDV6kIpJTf/0UX0bd51aNfbXIDMqCWeZt4kM4rEyZ3GkUPFj5arcq
	jXJRoOLbutCOxDHw6FraBaJ0p3qn+g0u9k7IES8G/AP3P/XMP2cA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4688qn809t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:40:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA8F2l031751;
	Fri, 25 Apr 2025 10:40:06 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010002.outbound.protection.outlook.com [40.93.20.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfsjgxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:40:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKsFYB0W/d2syKRIBXcjY1L9JoPiFk8WI28fXhMiFdCOW99jFTNIiYLfv5MaAZynW/4KgvmZrsjCJ+HlnSIdwgwnrr7L6+fbmkONeuKEf5Tf2/DZehQuMVwkkyodiG13vhS3mtun/adrEh/wjkXYsjE+kPEAc/30Xar3w3MPXmrunX1fzpM6QMagGEPyk8xf6gUUxYr78Eprhe14eXB3Kz9u6z7g1jGc4tF+XKDLT4jRFAhIjhn95gIrZvywThvKXYRfKR/NubklyaJ1aB4gGx64V5tJX6ks1oM8zp+OW3Q3VRBLMqmBBVy+lQmh3wPQWz9ONAMThwT7/qRUoewLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDw8Vx48GvGn7M9MUHPQtwXtGNEGWbokvwP25OSiqww=;
 b=pNgrHPkZ/ih4YpukdbdpFI+KCzWDtrJePErC8seAU9ClYydRDUtadMx0EhvrA6Sdz1RuSVrdB/xnX3UqxsG+pLmX8AGyymKmfc+ZYv8ea48b9oUGgFr4zAQT9VfXq/1P2sY+zN0yLoLOoKSiYp8DC1L1Vs9A3Ym1UPzvXfEHCCZmX2/PGGPvAmObiR3/JjM2ztTWyphpBPjnCpwfWEc60YVdoldIxZ2R0PNAVXsU2nhPqYEPvloYhjtOZE1iLrwRpEOKSHXxViKNlUdmh9iyI0XUtcN+O8X75yd017Z3fBuChcNpfXyeXsSjZgWJ3g+owL7iPRT0CQ9HKFOnnKKScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDw8Vx48GvGn7M9MUHPQtwXtGNEGWbokvwP25OSiqww=;
 b=E0E01IEkqCoAO2eldlUL/2DLaFvpjHQU6LPCUaD7sheuAEeZ/IUpbY13WuJU0hSN8jo+IucCi89Eom1fZUAtG+UdiOFYIr+WO5VpEDqoeFQQUePQhymChSw+XdE4Kcjq4fW7GddskMASzIundek6cqI8lZ2XrQ3SoXUPOR12eNM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB7916.namprd10.prod.outlook.com (2603:10b6:408:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:40:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:40:02 +0000
Date: Fri, 25 Apr 2025 11:40:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <7212f5f4-f12b-4b94-834f-b392601360a3@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <51903B43-2BFC-4BA6-9D74-63F79CF890B7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51903B43-2BFC-4BA6-9D74-63F79CF890B7@kernel.org>
X-ClientProxiedBy: LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: fed56f91-d483-4005-42a5-08dd83e58907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+pXvGxKLBx0tcDY+eZSABKORAhote1PW5exuCCKZLENb7uZAqv9VG8ObASU?=
 =?us-ascii?Q?NNpncXAb1OEaFqrpRU52v94lIoql2MDA9spPw77QdN/KCKBJjF5diZnRBI7d?=
 =?us-ascii?Q?oGgpBbbZbEqJ/BfUEpxdrf1TTHL7T3SVMETAWCZMYEI9J9dNqgx9VMyzE37b?=
 =?us-ascii?Q?z6x+9KjkFQi/acKNiDtffZZ4l48YFIs5Jl++zf9UNb5t0+tOA4mj1pJc96uE?=
 =?us-ascii?Q?JteSqftIlfMDvEjtA6Wd4Qi/HSx1LjDsJVh/NeOgbaEYW0rtIXHvAvw467kg?=
 =?us-ascii?Q?nRxztoxrckmXbkHDWJyX0ieCo/mAKfrvwvnXnQkBkljbk0R5Q9U92SlSNOB1?=
 =?us-ascii?Q?CGbCr7Vj41++MkDJr1ks2ICuOToVwzlhfcJ72q2BIQZbpqL8aaLYxlpGRsaJ?=
 =?us-ascii?Q?m9BwSlHNvMXUnBtPNRjn49KlIaKOtTh8NDmI6jZvvv9QWFAfhYpvpSrEMIDz?=
 =?us-ascii?Q?KM13acwlGCDwJnSiMVCOwbVyapPxpPQdkqXnW8RqpDWA4kkaXtI35ER4r0ed?=
 =?us-ascii?Q?YUaKB3Fq3veRTtjGVC0l7s8AkYrZdJ9tp37CXQpMEaEZsAOylafVadjg/ivH?=
 =?us-ascii?Q?jdgrNDUUa6R/r0tUXLgyZ2XPJ+TaDGTQPRc/z59eeXpG0sUl6rKoTbCkERmU?=
 =?us-ascii?Q?ZmkV8Igl6vvqPOhX3aiHhy52CuQ547RhFijtgrJUybXvhtbVDwmhYEr9YCKz?=
 =?us-ascii?Q?uXNDJ7JYLmci1btiDN8R4cQJpMi5cudPHJ2O6TYqg3ST6Ox3zRdtYclHgaF7?=
 =?us-ascii?Q?Vh0NjdN05uGlJc/MsokGlwd8mHYxIC2uz+KscTJFIi+zWL/GP/Y+TCPPZRvQ?=
 =?us-ascii?Q?h9cBaMVHxc+x3SZCMpt7/VC1VyzNkFkKbWIvl2I8zInZInh7XL67RLKGkyw3?=
 =?us-ascii?Q?pFKkzgZ4Pw/9HLp2OJtQeIXBJdpEdXqqb4mJiLGh5g1SXnUJ97wjCkbtSqmZ?=
 =?us-ascii?Q?cx7cmsjdHa1v8PhDFtkicI2G2nOXexMWh2qWz5rfEW5bJPJOI7tUq00jM9ow?=
 =?us-ascii?Q?ech/3EYU04X3NDzEOUqY6659pMby3vrm3G1PlYHDv88RTNGNR9dul1FwCz5w?=
 =?us-ascii?Q?YwLA36KDRQ63gnWlZsZ4EHbHtQtZI/MoUWb8yL32ewnFvr+Q8XNmNz0SQM8A?=
 =?us-ascii?Q?yZlDzD19Tl/VtvHpZKJ9dpAGlzia4M96V0FbTjugq9c5otSxI7xNX4hxNL6z?=
 =?us-ascii?Q?CWxI6mMIrkr4Z2AD/uKw24c7vMJsdZaYCSS35ZPz8vwGWQLu38KZ6j3+z5R2?=
 =?us-ascii?Q?TUtB+dH4PDWITjEtc6A6tZenWKIZD2KC4mvs9MulMYANzvwvsDoxLOsaWeTb?=
 =?us-ascii?Q?s1/tpmQag9Xvh+2hNd8v3cWmIn0N7/Q2uWXFFpiUDATU0PkXTLiaoXxIH+D1?=
 =?us-ascii?Q?qSezYoJFQVYd6UCI9eL8g+QDaGFdYmGJ5V83uAswG3/I1MDTrlQZKfdBT3AU?=
 =?us-ascii?Q?OzLxq0CNrMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N+tDTZwIJFDJdWL2lOIY7EU+ZiL3rpzK71dze7cXlGEgxTt0wY8TmHYZrloO?=
 =?us-ascii?Q?dZdX7RnUVOcjpTRWnphN30HclnfP4OCiEfbqmWU7FySWZsTfj2g7Xummt3Uh?=
 =?us-ascii?Q?xZJRx1p7XdGVJe5OF/gmoR2eE2pRYybYw5yqyQbZPQdIqZVfOtN0pN4IUkln?=
 =?us-ascii?Q?Y8IG3Jji4C1lANRwx+sh5q10D9MRXEoB8UwZu0q2laoqpxY06yk8rRARQuup?=
 =?us-ascii?Q?ucQgLt3TwPDjIpTZqGy9tbbyZ0LsvbCy7UKAs7KJzazV+7E7TwCAQANqDPNd?=
 =?us-ascii?Q?joSqJUEJN3KICVnfuD2jNlPI9HlVmyi7e5iIW/xdniidjXdnNcecbIIeAidl?=
 =?us-ascii?Q?00NkQ8CnimpYfG+kyDM9/iknGUM2LTCNyh1huyQ5sXJIRIzX17pz7gK0o7a9?=
 =?us-ascii?Q?1Ojfu/AmmcesdmaDjZkVDqogQ+cqIe1BzNMqq3Gjg2ZDDHdovOo+PPJdvQNF?=
 =?us-ascii?Q?l/FSujGEYoO87R49r1452qGTCaRprUPGHok91DwHhTgA/TUe2NqMdyrKK4+q?=
 =?us-ascii?Q?7xaaQBXolrCQS4QXrAZmKeQz2bNmuGV9JUzS+UdBoZ3CQ+2sOREnTpdbA8sd?=
 =?us-ascii?Q?3dalk05sPVScb1WITaotRms9gsqzbmC9hhn4QaxGxnMwJSyt1e7KZkZSwFnD?=
 =?us-ascii?Q?DPyxtiUH23p5WX7x2aybVCeY/kaI4gJx43UBjTuyKnlpaUOYk6CqZs+OhSpS?=
 =?us-ascii?Q?GaB74S9dT3+GcwJ7OQhTZ+/xPRafzXEl5rByW6vLiXHgshVZS35zthhlHoio?=
 =?us-ascii?Q?BHrWpJIWH3DZFaSlWpWlTFFn3FjkiKDtVzW64kc6RZGAFtxUxkKgf3lqpiBQ?=
 =?us-ascii?Q?7fCZQlmUwRG/W9BHTItoqWO4O0a+c2rUJ7I/y5kwp/IPkX58+XwDC8s+32Gr?=
 =?us-ascii?Q?pfRKWAYbZpxtS0qMzHCpY+AXcP5vMLe5PXjCJrVYIu3e33lOq9WjVdZ3nB+U?=
 =?us-ascii?Q?MW3JsUbfJdCuRw0mxG5u86zyXsZrrMfp7Lndt2USEmzk6MsS9ZD5Jymm5wwn?=
 =?us-ascii?Q?VIgpQn/a0IwGHsEeSZLfq69EQ6JcpBDtf7xf1wSN3fAQzY5i8MKH7m/RC0TB?=
 =?us-ascii?Q?SE/Asdh4RlzgCfzmb6oxscoR/aVHAtuVANVDudE/Wdn92Qsi/yI/TxQVvCmF?=
 =?us-ascii?Q?A9f4tHg06y0ZCp1OWhsTDI0H0gVbE4MUyycRzrmarhbldteBSN4MTioKQQqN?=
 =?us-ascii?Q?A3QNToEkkZBX0fKUPu3ZpEwtR9DvWgmjQH0oKaEkCK4CsOrzfO85KIG/Mm0g?=
 =?us-ascii?Q?CJ2Aa8HBFVutYC19zb/wcNkTNKEKFNDZoty+2fFHjKJLgmS9kIdM/tLr8k9J?=
 =?us-ascii?Q?TTwwrYMpAyuzC3xlgKTXAH9kH2X4KWtyg5UJO1ITX/XI6fDfGOgO5Sq0eiYP?=
 =?us-ascii?Q?N9qQiI8UzXrtO2HNlyqwtDOlydrXAjLRoZ0tKkF6egErLjWTWFuIyyeVMYf3?=
 =?us-ascii?Q?hyeGk3psXEkW4xp4uUPvvFp/i7eVHuMOvksamrcetT0/n7Z9UMwrYzVy1+UF?=
 =?us-ascii?Q?wkaMuW8wjEbo3a/Eh67ITTv/Nhn4SlXs3ViZ+7owSBGrEQ3UNEwVaceZjzDM?=
 =?us-ascii?Q?+09YJoEoo+jLEXj0fAIDJ+sHVrGoYQ38OffpVc1nr0WmeKGkVGoVPXKmE/W7?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UUlHPwvTO34K/edVYKOO2IsDK2IgYLbz0um0oD3dQunZNC9cd1gP1EHCJCHDZJBXU58/zEwYWtm2jVg7wlQruVYMEFsyA4zJHp9PQ4P3F1FrFM0McF+ixwOkrPeP0I5ZBHsC0T0b5iV8qOIUPocHnHk2ObCrc5R6FiZN7EY+RtszaBBLkDVf2FFOUpoHzplucS9sZ1q+99PTzxf1vU1lxCmntl7R+As41xwfz6Oy0YsFZq5i4Xw3lmc3V0el9853RPdS0m6cXmJy6TXN1AOan6Uu1dImHq1obQvL0JedzNJoxj6geZMUeKJuXMMKUTGrA+FEHSUlF85ARhXjDbheKkNfr79rmQ4QVHeVAB4FTJ79DE7aAX9o2YSVfdXqoYlqOX2u1x3+dXjJNWECgqohH4jgqxopYD+4XXPlxvXfDY+gwezwiM2pCiYDNjPZh0Zl4me6PHpK+S1qiEp3vUUG/SOrDxlTuaeUytTCgUBq7dz0KFVVXY0JrvUqk10gO1E9rlItM4Q0s2tPAdYORedlsYwGzwPaIKDyHc9IFi7T5mjjfZfB14JaCVxjsHHOZ1uKtQDYQZwlBgKunK14m2PEDI6HVAUIFbbRC8XfxSMrjYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed56f91-d483-4005-42a5-08dd83e58907
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:40:02.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l/dnx8m4V98KJYZ7dyxzStz7OK/AByF/GWZ13wPS2g5Iizbpvl/eozzYL7EfkK8XqJ297xDAGRoDYa/fNfAAQWLHYtF9ZsSVjGXB6V+/AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NyBTYWx0ZWRfXxynhF0c8qWrq uwZi6Pia+ROe1hGgEoPp2uEQPEUK9ttJiZ/XwFhWPhVv6VETK9eKDOTJgCT/YwK78j5M2I/Ycyc YgtbPK7k4jANo8g8QCQV9QQro413JuTHJseAGCR3HsUm3EP+62M/c7H5qEy0wws6sesYZb5C1xW
 IaOU34J3v9SCvinNT7u1dyMfdrtoIYO5RdcX6zK/lBU9sIQcUa/3fZlhOEiGJMtwCnFKzi2MyJx iU+uzzZvvqjjxkcEg9DChRZ+YkbhtKwwiyevAST8J9DCjnW5QKIZbJ+6gq8Cs2SvXwvjD+6ptDl tsO2SH13WByE/87UMX42B1vQXQUTjP7kkD6JGduUm/W8SpdL0Oaj3jJhv8VjfEVlsUWK77LI+bS v6Vz3z/R
X-Proofpoint-GUID: jJzWx4N4cXYKagQRD-WsDp_jCi2CEAut
X-Proofpoint-ORIG-GUID: jJzWx4N4cXYKagQRD-WsDp_jCi2CEAut

On Thu, Apr 24, 2025 at 08:15:26PM -0700, Kees Cook wrote:
>
>
> On April 24, 2025 2:15:27 PM PDT, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >+static void vm_area_init_from(const struct vm_area_struct *src,
> >+			      struct vm_area_struct *dest)
> >+{
> >+	dest->vm_mm = src->vm_mm;
> >+	dest->vm_ops = src->vm_ops;
> >+	dest->vm_start = src->vm_start;
> >+	dest->vm_end = src->vm_end;
> >+	dest->anon_vma = src->anon_vma;
> >+	dest->vm_pgoff = src->vm_pgoff;
> >+	dest->vm_file = src->vm_file;
> >+	dest->vm_private_data = src->vm_private_data;
> >+	vm_flags_init(dest, src->vm_flags);
> >+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> >+	       sizeof(dest->vm_page_prot));
> >+	/*
> >+	 * src->shared.rb may be modified concurrently when called from
> >+	 * dup_mmap(), but the clone will reinitialize it.
> >+	 */
> >+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
> >+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> >+	       sizeof(dest->vm_userfaultfd_ctx));
> >+#ifdef CONFIG_ANON_VMA_NAME
> >+	dest->anon_name = src->anon_name;
> >+#endif
> >+#ifdef CONFIG_SWAP
> >+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> >+	       sizeof(dest->swap_readahead_info));
> >+#endif
> >+#ifdef CONFIG_NUMA
> >+	dest->vm_policy = src->vm_policy;
> >+#endif
> >+}
>
> I know you're doing a big cut/paste here, but why in the world is this function written this way? Why not just:
>
> *dest = *src;
>
> And then do any one-off cleanups?

Yup I find it odd, and error prone to be honest. We'll end up with uninitialised
state for some fields if we miss them here, seems unwise...

Presumably for performance?

This is, as you say, me simply propagating what exists, but I do wonder.

>
>
> --
> Kees Cook

