Return-Path: <linux-fsdevel+bounces-55429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78011B0A467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338F3A82790
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887E191F91;
	Fri, 18 Jul 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KeGd1I2v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gkJS/iMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63A5695;
	Fri, 18 Jul 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842763; cv=fail; b=qX6t/tAuUwcdt+e2i0Zm6KfKF1VxZEnk/FRQk5tU1ckzrpu7FrAuRWvB7pyYQZQxpxwrPKHLdrCqhDLkn1gTth1entZDBGUyZjFa1wPUD6kNV9rAOoY2fGIKxViGIyiGePCyO832aQ/xqbcirI5047M5lF1jp/QlQj2r+ZhTZN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842763; c=relaxed/simple;
	bh=aFRGUUk9zJFEeJz3R0yT4r1GxXpqkgH49s1ni0ONisE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GreOyd1PLz9K3OI7+u8Yznkjn05Stodn7CqF3ydj0DbnTj9eEf5hZw6CSylmZqTL5I54cRhl+MJUw8KDGLPy9cBqqg49SLmLBSu0FzLu4vbQpm/WH4l8mPh+BhTFZI8IL9N8cZRsaS+Ec/XunmPPtVXMxNgfdtWND4Hz5WM6uKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KeGd1I2v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gkJS/iMs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8ffAh022807;
	Fri, 18 Jul 2025 12:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mRbte1Ja8g0hfJ+fj8
	9iBw9tCWBmZa+qTohmOd0Lmvs=; b=KeGd1I2vEec3DBP5eOXihklmqONUnn+QS6
	FUQmFKBHLXBb5sXCIfgYhhfUUkA7U8acZPY3ttnuVHtTTtWM4yVT6mfHBpA3Oyl6
	KDU6gHbU3NRZWe7METfJQFlQUupwpJZfbJDe8jH/73Mmatw7ibq1WQja/USnIxsr
	uHlOJ9279TL1TyyHkUEdts2nYcJMc3IDnck9+fCsAhSiyNhaKATsZxiTAaQEiwxt
	woG6Kc8lRZeF4zlrP/nRnrDtiK7Wz3sad6PXR3Lxxgz+A7d0N34naOdJCg+puxpr
	l+HrOXE8dKezun1ckCRhL3/3b5zwvEs9rN8MyKBjgbLdOpnC9C7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx856an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:44:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IBh3k8012988;
	Fri, 18 Jul 2025 12:44:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dj4dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prDwcb3yjkvYN2IfYS/YRjCzzr5KBdGOKDy4WexbGR20DAHpsp1hlKnciFFbnIZJ+CpW0GK00XGLsoddXhcwFcs+nnNDy+YPZZ8mL4NrJZdvvM2RiKzVVxMW310qlJY5JkfvEr5AKnTPMhS6oy3VRUrP1zKUVgSko8dHhEkiVbRzVz+1MBpctqAe0sJtIDMlxuuLNDC/LN8Dc6CKAJWYSd4Py7lyATlRcg1977Er/ljTmza+OowP65BnouMr8wYZPPlo8ZnxeoVbuD14/QLiQAJVfQaK1kM1tG0cksFhpG6O6VxZHSwxKNvG70+9+rMLInjWTDc1B/FY9XbqOidEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRbte1Ja8g0hfJ+fj89iBw9tCWBmZa+qTohmOd0Lmvs=;
 b=xLPkzvP9eS7ki47/OpSCaFa7sda4dYFcVCpzcY4J2hG+jkQOivVri2d3WhZNM2qOYfhVDkhAzjG+h+pvq3XELjGNSjy/AHpad2AzfR3Ya3AeoVye/8h9nwa3+baCvdzKHKu6qBB82UBcdS9c2kDqqNocwyGuPAphHoTinOZsoUlf+xmv6xLg/C8xW/tSCxnPhfBJOu3BiMlurFebr4xCizRDvKB85Bz/f1xpImFEARzr02UhyfQfgBAfVl6jwE2Ma7iM1COWQ+Vb0mVuhrkXbX8zyRqTJMQSYr0TqrAlbx7AtJfF5idwdbHevBK0MESgqK/bb6lf4jdUpurHu95q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRbte1Ja8g0hfJ+fj89iBw9tCWBmZa+qTohmOd0Lmvs=;
 b=gkJS/iMsZiStIiOe3mmt+MSPzlZb36NZJx/7T3vxb3qRqLLECi91U1Ja5BsDZrOU4pba8ZJKrsYtmGYfpgZTCxZKAlfhaCwPQ5ZJMTvm42nK6Bh27cj4dkL52hQZ+UyvWeWiV2q4YdqEJtpTh3KuxotvLfkgkcLtDricP+vH6eA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 12:44:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 12:44:27 +0000
Date: Fri, 18 Jul 2025 13:44:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 8/9] mm: introduce and use vm_normal_page_pud()
Message-ID: <c578bdc9-38fc-4811-b69a-a734a82f073f@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-9-david@redhat.com>
 <4750f39e-279b-4806-9eee-73f9fcc58187@lucifer.local>
 <fdc7f162-e027-493c-bfa1-3e3905930c24@redhat.com>
 <15adb09d-4cdb-435d-927d-0c648d8239dc@lucifer.local>
 <889dade6-8b3d-4cce-93ec-827886f7cb2c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889dade6-8b3d-4cce-93ec-827886f7cb2c@redhat.com>
X-ClientProxiedBy: LO2P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 2269f7b8-d3c0-470b-8331-08ddc5f8d550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l+929gn85iK3wkiBLfCcBu7nudKTqD55ybJ6PW9Za4r+q2XEekSlPi8w7jr6?=
 =?us-ascii?Q?U236rgwAL76qXAg6sF2wDrGfEXGixojVGp+0/ijNRkiu6q//PmESSR8z4Q5b?=
 =?us-ascii?Q?hMCVV6kgtl8YWDM0U6VriGT7aXpxfOFybL1bCfSxwUNR+FbJz266mtBwYNzD?=
 =?us-ascii?Q?KbGJtC47M25+ruJZZ70C/N532KqissC3DMcuoBrn6vrZmauby0GKv8+2twkY?=
 =?us-ascii?Q?gePWorlpk1Q2QixUbdU5MN2RC/a99IT0EO94wPr1u5UKyLPMmDKkHo8k/tw2?=
 =?us-ascii?Q?NZC0ZsrEB8f3C2RzupIa65/9HwAFylOaonvwFpx9yRi8qoH+1W/awNRkt2fX?=
 =?us-ascii?Q?pMMG/IxbeLMX5cTn6avYnEKG+WogZg7V9PGINb79zszGo8DBi+KYUrub2hX/?=
 =?us-ascii?Q?NYXCQuWAGWUXV2jMTzBuDrAlrYEeQlXgz7vXYec8dmC352jlMLAvtRTLBSpm?=
 =?us-ascii?Q?J2a/UT1TGq9seLtpyIL0FSkMK4B3EhRn8s++wJ7qiTR5R99CmJNpC2knzq0j?=
 =?us-ascii?Q?/F7WwGLLeSFJ3q4OJ0rx4t7wUJulwSnc7VyGb2cp87GABStq00mYWGulXZdB?=
 =?us-ascii?Q?FW2LD0LiAmsg7MrDnyRvaPTtqJmxJ+4DcRsrbQ751fj4xULlADnCnbsjwMRU?=
 =?us-ascii?Q?rEqceOn6dshicA02m1VrU9MOL3q2ZiZI9KDh5kBzLmIwseWfs19LK/8oPakP?=
 =?us-ascii?Q?jbE8aJ3ajFSzoJeLg55qHsOeSNCD3vK5e3wbO6lDhzH4V9ifv2C3GbB8qeuy?=
 =?us-ascii?Q?PTq81zdMLAORtMf/+RZQKSb6MLJyMT7/TGGn0uXSEuuk4I+WKvhwgx6VkzX+?=
 =?us-ascii?Q?NYwojwqNzV8EqTmK/ig+KmRf4ph4Bg5b3OMOzw7zMcwao/TDrEY8xzhy9Xyj?=
 =?us-ascii?Q?h7lsCjeWJy6/jufH1tQicyO6ukjBix+/3kXlxUBpxNA3gowC5LoybqU0tC1m?=
 =?us-ascii?Q?IRfhgF2oEpSMtUUttzZNiFf9BMEF2REQH1+j6RGy9EPPNe5rH5DD65bsJafN?=
 =?us-ascii?Q?VhOHMZZ0pawbUP2b7yGRnyKSVvXn/ess+wyxpYjhoMh4lze5lgNEhQzogVRm?=
 =?us-ascii?Q?HgvNpnhdBeVdNEjiDS4Rg1gvUupA5Uzp/Za0B3kO5Nvd6of3N8AIUHi9E78q?=
 =?us-ascii?Q?/ceRGnOMPlCHoib5kkNGnvWtMiwze3KMgFWkwbSPrEkdw2+l7nmlBoPk8FRD?=
 =?us-ascii?Q?wxdAwMMoQfGspO6ZcRJBygokkX9TeED4ICH8q9EUIFtpYHWRX98+9vS3SmrN?=
 =?us-ascii?Q?E0pZUzoT+Xx4VnDqJ+D++wAc2DiQW/DfLgfz/c4lz8+nZABmTjWmbP2RMljB?=
 =?us-ascii?Q?0Kk4EqgXhBqaMj84aOymYhdLy8hJpsoWWaln/wVplWTgbZJlzyKQwsycDNG+?=
 =?us-ascii?Q?yd+C3YD/usdFcQ7PZU2U+w1pSpmtdTD8QJMUcNfiEEfUT1184a7KwP13O0vW?=
 =?us-ascii?Q?BDOBFwQsU1U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSieQYCEfoEVLfT/3a7v6FtfrZJmF4bxBSHceYg8srm/Ki5VSHJe1sMphNkN?=
 =?us-ascii?Q?2bfoamY9w+rIsyDol+tpxPohGvtolxmG+8JS29lEDH0GEy+B6kAaH8HptSyU?=
 =?us-ascii?Q?0eiAI5bBwHfZZovkY38wyBlZnDxGMHktsEo/FDNp8+iocXH6CuTkRF7wMTMw?=
 =?us-ascii?Q?nevPkhgA4lGVhWOa9NpNqeHaAe61tZP7MGH/1OPK0iUic7ljEZKzm2DnmUpr?=
 =?us-ascii?Q?IPOgHkwYThPvwquGd88Ikxd76ISB/S6LT2RNDnHMlDLOhlcVDRRTKeXD6X28?=
 =?us-ascii?Q?IsAO/eBO3WP/qOYMSl69MgX3HcmnPFLLf6AtKqZxlUq4Tp4Ww1eTJnlTXl5G?=
 =?us-ascii?Q?tUL632VYvCtiPFUjuapZDCPxMkm/vgOSDezxAReVl0qLYOrJ1oNdyX0C9s7E?=
 =?us-ascii?Q?Sfws11Alxt92M09wLiEKVrHgVfk5JFmBAFlxLA7O01OD2j/i5N+i9d2rda2J?=
 =?us-ascii?Q?1rED8CHeAxhHQ6vJcxbvKyQ+acX1wL/O/1a4q5SAApVz5E2D9evWjvhu5VGN?=
 =?us-ascii?Q?dSbl0L33Ij/2emZEDaQ/dCV3YOZxVs4Y3ekRpM7xhAHyQ8tZC+AGaHBm1W0l?=
 =?us-ascii?Q?jvPHro3TfCbcPsJW/5oLrdkZgVjlOgvhFk8BF+XanPSW+7LSf6gR+jisZGWf?=
 =?us-ascii?Q?792OS2p0Sxd8xX2LCKq7YfCXeFC3lHREAil7p8FV1HPfiOpnzEKKueDbeFSF?=
 =?us-ascii?Q?vuNHed129hImuNb6Z+wGv2/tEAwe7U760iR3y8Ffpj6/yqyf8ckObdUJEIDv?=
 =?us-ascii?Q?a/AeGlahphmPUWOboZrD9YvlUHr8z8BZvVOXRX6WT30LBA10OWtp+36szU2d?=
 =?us-ascii?Q?hYsXdpFPkmUoThJHPBbRx6kk9QtL5VskFs9s7ruqUi6JA+cbZ213VcQEv5nF?=
 =?us-ascii?Q?mYwL8FQdADav0dqFlG2ek6HewNkF3kmr4vrl603c/bQ3SiEl/2z+NVptAUra?=
 =?us-ascii?Q?iDayuVdHp7rL5j3dg++d/0gxkQDzbd83FyJh1VzVr4JPY/SBMB+hSFaMZADj?=
 =?us-ascii?Q?nglJp6g/EVn266+GHegyxak5L1EXq2U1z1z7xYjhXkmAZKHjeu4bQuraZdl9?=
 =?us-ascii?Q?ryPYpavnrVHzkQWtrofOGuIeiTJ4HvRUEH37Z84ZOyhDDSaNeAlXOCZ2hvZH?=
 =?us-ascii?Q?P8W1XLBUk0Z8BES6xAGsGCmL/ACrtyF1KYpsOdGMcFdSKHDzaitL7eu1Ktmk?=
 =?us-ascii?Q?4DKsmCsF6dNdFOVJy+IDp7nsYA9aQqgQzWFlTiNg1IW9EQaPpCmaxmA27sp6?=
 =?us-ascii?Q?XAy3qwi35h5ccCNWr7xzV0HlGbtchXTGhbf+p4ECDFsKjJ41N2RWKQfNkrI4?=
 =?us-ascii?Q?hio7elf9U1B6Bx6zmCdAxJW6Fk9+DlLt5hfjxzbhITeU2W6Qo3bYG3KcoOYH?=
 =?us-ascii?Q?o31pkh5YPmEaKjhG6Zy694PcPx1964YqfD0I+andYqJV5Nw1Kf3corFaTwUG?=
 =?us-ascii?Q?Ae8BOpq3h2ZEFHcby+pUZ8YzWtbiJGtW1Xn8RwOkkgywZVL5tNjRsTqvbP9T?=
 =?us-ascii?Q?SrcwroZEppYLfj+x65nsjzEx8VCyH7B0NaY4TYCXx5sZWktPHEp5pLQp5Hk8?=
 =?us-ascii?Q?2ihKlNzmmWUMa1KGeHTg+JXmzSjmoAF5QyJ8N/GbhuOKZUXmwdAdtrxO2wb5?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	00VfntyMWRadyjnpX8Cu8DpUV7JDEk2DkwhygKIbRIKtD3FrdiBxiHFsWeiDdBgx53xwQ6ouMJU9Rs02zWEZvdWstbz726vXyNFT6DwXMqeg4iY/EFRLqqrNhLJESGcl+Dk06xbFiN45TFMz+vaFeOROxH2AaEah9/mo1iW8/0pWuqPxhMAqnkkm3jIb/76OioKK95GHlYVcZSJ54SmUUIrvxSG/bWqSuNFDz5+3hfpmUiLLMty7ZIKzD41ZMMMqBo0sBoy/Pz5uPjIWbNKVgvIHafVVauqpZR0D/4ZXBVEo4DzE49WctlQRW0xfhwRtZAMukAdezb3NEt5cSPdd04v86QzciSY7Va+C1Sf2FFxUnkzW+C5n3eaPbRhp5/ITtbGjJu8S6cWJ04Om36gEOjJsTUjUQR7r0be/31a2vlv82S8MFJys8SQGp8qxIf4Uy1iJ5sRr2vHmbluMscXyQ5P9hs3duQM09AsLwUfY7ThNpROlRSCIMZclYxolx4PUBoMx28aWPumGMqp3gdhMDPbC+nQ5d1Te5gnohY7hrE9kn6NWAIl8eI/01gFul+dhNWSOVm6jpcQrjG1AEGmUuNU3Z0OeyMn0v4bsWf4CGIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2269f7b8-d3c0-470b-8331-08ddc5f8d550
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:44:27.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+FqGnaf4b3LFPxPm9httnW/SnmvmEs0jvRJoe2zVx8wN3UWM1tCZHpZPLTiHASE3KkXB5zOsfjONPacW2uYC/ld2QYgRIX9RMAhN1yxJMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180097
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687a41af b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=uWuDcTv80Iw9tG3iXO4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: TFu4TcKNzEqA5XXVXooy4QLMmJImZrys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5NyBTYWx0ZWRfXylse2Q3+KCtG jJKYf7EqYzOczxzL2hV4adKOc0tWZXHEgKkqJ2fodViqsLRVVHiHbi8e5PGieS56iJdaTe6EsSS 7Tp7AUZDBjiTbDa9L84UJgboIcLQDHwvKu0UwNvGvdmbVd+3VRgZ6LuKFlQvB5S8CLvoigFt12r
 /9iLM3QOsLmgZOwFKy8f7ijyLEpXMYbMaSk076Q4qGvioOB9GQO9p0FfVh7GGi/Mk+H5l5XXjn6 agwinyuIULyoPze9SJk10M7UDsirJ+IdotHsMGaM/W3RYK8sTBQpYlawdq7d28wym1PE95Ik57g OdxGvCeOebx0oxw5K7UhHkCqJiyNXyD60x/MiDTeVKbMwx3i4DE09yD4JBUmlJNQgnF51Ql9KeV
 IPsSc9u9Cvb1/jM50Bf3cW7otJE70SRNnFtS8AuKT8YToiCHcpIcgCh/oq/EdoBQMTqmkEcu
X-Proofpoint-GUID: TFu4TcKNzEqA5XXVXooy4QLMmJImZrys

On Fri, Jul 18, 2025 at 01:06:30PM +0200, David Hildenbrand wrote:
> On 18.07.25 12:47, Lorenzo Stoakes wrote:
> > On Thu, Jul 17, 2025 at 10:14:33PM +0200, David Hildenbrand wrote:
> > > On 17.07.25 22:03, Lorenzo Stoakes wrote:
> > > > On Thu, Jul 17, 2025 at 01:52:11PM +0200, David Hildenbrand wrote:
> > > > > Let's introduce vm_normal_page_pud(), which ends up being fairly simple
> > > > > because of our new common helpers and there not being a PUD-sized zero
> > > > > folio.
> > > > >
> > > > > Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
> > > > > structuring the code like the other (pmd/pte) cases. Defer
> > > > > introducing vm_normal_folio_pud() until really used.
> > > >
> > > > I mean fine :P but does anybody really use this?
> > >
> > > This is a unified PFN walker (!hugetlb + hugetlb), so you can easily run
> > > into hugetlb PUDs, DAX PUDs and huge pfnmap (vfio) PUDs :)
> >
> > Ahhh ok. I hate hugetlb so very very much.
> >
> > Oscar is doing the Lord's work improving things but the trauma is still
> > there... :P
> >
> > Also yeah DAX ahem.
> >
> > I'm not familiar with huge pfnmap PUDs, could you give me a hint on this? :>)
>
> vmf_insert_pfn_pmd(), called from  drivers/vfio/pci/vfio_pci_core.c
>
> Essentially, we create huge PUDs when mapping device BARs to user space.

Ah makes sense. Thanks!

