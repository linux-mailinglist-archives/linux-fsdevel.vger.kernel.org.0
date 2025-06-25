Return-Path: <linux-fsdevel+bounces-52867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB3AE7ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87293B875B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAF27F18F;
	Wed, 25 Jun 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k2qiGP8X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U6Tb5dA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0620C030;
	Wed, 25 Jun 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841433; cv=fail; b=VVqU4+aAKE8sjB7CtHl8bUKhUjjNi+KBxRbrJSiMPbZIqgZTiMqB/HzxlJkLn7OusoGiITa9oH/IZU1cVgKuwDeZ184yPGq7KB7YHJCMaluepFaHoV8O/a6KkWzvlyPDhMfUAN1h5x3e/xfA2ixMz1ws36IsSVl0qc+GhDmwWfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841433; c=relaxed/simple;
	bh=AcckUv6dWDlpbVi6zSfQbiYoI68/d1cdVxMUuoNJpx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fSos7Aq7RW1D8g1M97+GUz+GKYiwctei0V3T4T7bfC+EPf+9LPMGBdp2IpodXWuJ4U5G2OoQXB4uZA67tZdfzOkaAWFziKvKlSI7BQ/GzS0qWjV7RnrdggFVJQxoeEo8/nOIBAcEMEcTei1auAQEv2Oc+dlzsSuTTiOMJnjg5MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k2qiGP8X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U6Tb5dA7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P7fgsQ019246;
	Wed, 25 Jun 2025 08:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AcckUv6dWDlpbVi6zS
	fQbiYoI68/d1cdVxMUuoNJpx8=; b=k2qiGP8Xpn9W++FOCLUzf5g79kDsb5+I+F
	oKu5dFqwBR5d68B+8zk+y1DisW7cIwJWQSvTFA+VLghpHEQWMYvLoGJ7UJ6kZi54
	xJ4DoEcB4M+FcWG8rUGqMYh8Mmn5yXXn5AtmBnq357BfoJphKBvFC9yEsnhEOsWP
	5JPyEgJL1ttpgeLOVORSPzaKDyLR/VC+hTBYWiaUrKN7a3GgmYPxfgv9MgZqUoVf
	1l0H5251p1LBil/6W4nPgejkizjgVWN0LOk9y5EtCtlAPYpSccHI5aSIDU0+DgKQ
	pMZlesEpaIlPDToe6+T5/p0Wv5JP0OZXuux4Jsali8n/SJ4y1Ttg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87xyg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 08:50:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55P7ONVr005791;
	Wed, 25 Jun 2025 08:50:01 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq4t8y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 08:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVjx/z4JNIxztiuPHqp81daRxq5jtn6dMsFc3GpmVsj7jawpP2J9aN8tYggk9wBkLXoSyHQzXQ9hR8epBhgADZfIt7w8vZfUJyXduSYaz/zSze/jUbO/MQ5cFO8AcJS6uilsgvDqNnRgGBRky0E6qo1VlVNlNk6btP10Cu6UCjGUkt6knt5BhKaPAiWv+A2AewWKMkbmK064FjF6hKXDNcjYRtsXVaZd67ANl0n7k4IDn/5zFeleEvNc2sUDv0Bv/AvqWYdrpIZBsZrStjH4CFAGeXCmpVsRe5pKddUjwcUWqAEiBXskzc5ym3BzYZMjloWh7FAdFKfR1QlCLKBIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcckUv6dWDlpbVi6zSfQbiYoI68/d1cdVxMUuoNJpx8=;
 b=vn60QLMoHR0nLqur35dz2CEfy/eii57Wlfl/tRNCO5dOlkd8WURlbTcN4xinBkkaF7MkQWJUodazvbIVSk5fLbiKLIUIMTn/sxnC1BRRdp/at3H60vHH3wfJHPA8o21v41+L7vHwcbgWo2tA7WsK7nA/RtK45SGx+B6+KCpbzk/FzSSv/x3WqjkIhjByx0WSdtFxq3TIjnZYo21JSME8bSa4HMVTJ+MLnrYUtGIEg4HRxPA5CbKMmT5j/GSIrC3lYwjm7pLpOOH5SSfQVV/nXnAPQAwkKOXXfKhNmIK1K9OsbtdDzXQeA26Hb2yaTXnGKvIl0DnN3hq3hfsc6Ae6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcckUv6dWDlpbVi6zSfQbiYoI68/d1cdVxMUuoNJpx8=;
 b=U6Tb5dA7F5UERiw6VucmNmeqUQFZ1kHPXFV5zxuwAXJVqwOVZTxmJ53RbT5j6mz6KTiIlKYvIca3+03zlBq8ZpuFMJBPMGS2KKU26kkKw2lejqqRhdZRI+QwPb+tUNb+levkG2RAezS80gahS3vIhtjJs+hHLNZTIYD3FCUGZa4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4742.namprd10.prod.outlook.com (2603:10b6:510:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 08:49:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 08:49:58 +0000
Date: Wed, 25 Jun 2025 09:49:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH RFC 00/14] mm: vm_normal_page*() + CoW PFNMAP improvements
Message-ID: <06a2d665-0f1b-4e7f-9747-b4c782395dc0@lucifer.local>
References: <20250617154345.2494405-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-1-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0160.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3ea7a4-411f-4dab-46ed-08ddb3c543db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NL9yIYczAP75hirKeL34S5bCHfyErqwltix0zBbIsUYziU8lEoAAWjeNt+Zq?=
 =?us-ascii?Q?nv5R/Vt3Ep5fEmCFAhESpobvXtyl4ljTXxRzVtt4CHS3mA63Aog5ngJAUZmW?=
 =?us-ascii?Q?3QPGL6vSWz3gFIh2lcZHa7/5oV0HFOOt4HhRzRbakQIQ6+beVcsv9yembRQI?=
 =?us-ascii?Q?4pxZN/1jc/sSiX15qUY3+wlEliT2Y/nAzgBBXqZRPf+vFObiw9lBPngJNUQx?=
 =?us-ascii?Q?pEEYk1aeEDtdIRlNKumQSbav7rpTNnFNxg8ZU5ITcjPQ1BHclUotFllfHbLi?=
 =?us-ascii?Q?oiH2hGXwZU/JoJ/uQwjKgVJg42Nfyn7THbjbeoxjMedEFs/KsljMbCOZFsYp?=
 =?us-ascii?Q?O7qp+ajo9Wz8fbjkhrle7QYL+gBk+WMiG2XEu/janI4Obbmtx/EMgSIRJeO9?=
 =?us-ascii?Q?UeJfoloH6QnHERpaTqCi1H+kaaAy1TCR7iXdLev67ItgiiGxQA7BkPfp5pEC?=
 =?us-ascii?Q?uNlI2idupHxFBzQ2o3OnwhuwLvir8tSc0jQDId8m5uu4xWuiDy8jhvFRv/0P?=
 =?us-ascii?Q?SOR7D7B16X99l6CUUAIY+x6QZoo42ePspscXgE1l3szl0n99ma3qwuHzoxj3?=
 =?us-ascii?Q?Lv624HaUsjC1LBfRPXMHx6AEX45VytjNFqny6cseVgK2UQUXxTPTQqD42vGR?=
 =?us-ascii?Q?DhZ5izbQHx2BA1y1l08UpMXH1AePWS0RCXNZ82Uy2vxN/a8GITPNq7innuNc?=
 =?us-ascii?Q?moRIbMpA6aowygXlpK7SgNLdTN/Am/SMvq6FYLor6y7Ht2naNoa5fSWv7JhC?=
 =?us-ascii?Q?oX/6WvgoAWuMK+lGhA/URbu/GsYMXe+JqKnKvqma2zogo8tsTOjuLe8nraKG?=
 =?us-ascii?Q?k1x9EK9iJ9eE18OTyKFsZB9FwDNtGW2btbVR78UHv2N7ER5LieHREDjp1vdn?=
 =?us-ascii?Q?atf6a6V3+vRTgqi20v3xZyFb2V1FSEhQBOx8pJmx+FvhKXeqej7LE9hdFHhw?=
 =?us-ascii?Q?nK9Ye0ACEL5CwS53A/cvDiWwxtBwcPTtb0ZFL2PBdByLBAACAIGvt0M5oOu4?=
 =?us-ascii?Q?dsbg3YeXzooIDZUyPSwwiiKk6L3DdUkKRfyPlGrzBkypfcL4GXgmGkmDIjrZ?=
 =?us-ascii?Q?08W0CZWM9g2VXHPepSAv0ZI3yXP7fIpMJNuoDpK98+ENsEs98Vb+3OKLvblk?=
 =?us-ascii?Q?t1ej/RGKBgtTPnfGkU8vwnw+oaMmHaKDoIYRqMswZHpfAksQSKCjL6ymJqjb?=
 =?us-ascii?Q?vsuBJRdDF0EHhnpLJgQzHcjBAwtcKK81YL0gKzF9kzfGjWqgIz/757l3WTQN?=
 =?us-ascii?Q?kCkkWmtl5OzsZ/o/UHhFmVehs0CAy/Tt7IfYcjNwsTAAxBROebQ+zptIikCM?=
 =?us-ascii?Q?yC2xYQ96IyNOmwoKoxgP0B7+8sfbpCaY91U19TnEbuZDxUyrdpRHSZHNI7Mc?=
 =?us-ascii?Q?1tCr7L5RQE8XKtdoOjIErQ7x5Cb30MWPtiFt5HzeKj8bX3eSmNtkOP7d/gaG?=
 =?us-ascii?Q?hxoHc7rZaMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfI4gjbfN7E5kDbMsJjUbwN8OPK/ccJfAxFzGHHL6brpU0kh96auMGU/2UBT?=
 =?us-ascii?Q?/QG7b77l3k4XY1JeE81yXeEZz3/kMmI6RDrUyNch5se9RyTJLLkDgdagyO+W?=
 =?us-ascii?Q?fkDU/u3nboy7h9H7bcCi/yWtrldHbr/UiUWWKkrwzNWnWBtCs+eAb7S6UEhG?=
 =?us-ascii?Q?G9CgdibUhKza7t1SbbMu9G68N3ktkyRSlURDGKDpA+F+oTeShVvhFjRWm0kQ?=
 =?us-ascii?Q?ZhGG315rMXgZPaw7IFcc33uKD0fgc9j7GO+ou8PXTRwxkcxu7OgczVWuHsTm?=
 =?us-ascii?Q?1I2bw6JoB+L0qyLQnxRJ1hrId1/jZwRN501kkC4qwi15DGelHYkPhZJZYI0Y?=
 =?us-ascii?Q?uApRtROLV8QgtHCqHoAOuk6/uriQ6SdezLVc1BL2atwaUlKgYqPeXK2OnH0d?=
 =?us-ascii?Q?v+pnSKlQIDpReJz/qmVlbEsA1LE6x7eoZ5AKe36X/G+AVXnoMHoPxv+hCWSG?=
 =?us-ascii?Q?R+kzEwB8lfEqGM/Aox4OpwcNpDzFm5ZlIozdQk+HnrruqUMPrDPeorG2HU4r?=
 =?us-ascii?Q?Vla5e8hCwq/RL/tSjo0d/ZBJbU/7FsEaWluwJqJpXakTfEZWFWyxrs/9V3Tf?=
 =?us-ascii?Q?yINf154TiuZpC9+/lE25V6Ju4dt74AY5KitE6yzC46KlYdk1zheGn9iVK/ZP?=
 =?us-ascii?Q?/Hq2EOvAQ4MXtkOAek+eMq8ykDw1x41MwHGH8pNcpfjTBnLJi8qQ3GCAHFBr?=
 =?us-ascii?Q?z4P4dO1TKMl0JAzPDy8eV0IYe+oFbpK/b+pL24kKpQmIl4do5b3eGfAWSdAT?=
 =?us-ascii?Q?H3ok25YbFehwDqW4EJYKvY4SGG+mCiFZiGlekVE1o8ZDyFEz2vuldENPNFoz?=
 =?us-ascii?Q?RXgBWRv1j/DYD7Qz4ySeLybvpLfpCa+w/M1Y2UfcQJ/3XP4PIyxJdMm7UkZU?=
 =?us-ascii?Q?2WIJF8fTjYjVP46GIe3cQUXs1XtH9rfu3s4Pf+FwyhfMSurhtMNgOLH2/zd8?=
 =?us-ascii?Q?htGCBXoI6aKgWrxuucJ0BwwFSJPG/tNj245PK7h7+RbyUIfWGYlsU03ZYTup?=
 =?us-ascii?Q?AkOmIoMOYya78SaOVsBEQn2R/ebRKVxzUfk3cWFd85BfkJ/tv43cpwJx0Tsb?=
 =?us-ascii?Q?fP1TkZnRqXL09lFIbODs+yK3abvqQvny019RfLmvde+7k4mSczvaavw+j4XL?=
 =?us-ascii?Q?vEQBlUF8vbWZg8mnmBSymn5Cl1R7jkyxB7tF1WAN9opToZG3cRb3NUiL6KPp?=
 =?us-ascii?Q?jwaSLwkauSBLHImjatxYGvrSI3FBTZW4hcrThxUFcEEak2yLGy09L4oyS7mn?=
 =?us-ascii?Q?mwMysw6SNfAnfxLftA1B9pA4ZBRYps4Bq+xOoF/+SFGmsQH5Xs/LhH/idcZA?=
 =?us-ascii?Q?rLMpv0Io9Yrf7zm3/ChP758hC/F4rweGfjxutfTmf2x5wG1oVOW7sJH+jYF0?=
 =?us-ascii?Q?PBuw45oPJn/r9sLo6kXJylgfKtuqqWauVdejTLv6Eg5Pk6hkwx6YHcqBmdoB?=
 =?us-ascii?Q?bwW6fXU2knfdRpHEMKvbWKTYRHlOO9yXGOZUCyGuAz58x0/cNmdwLKsBiiBp?=
 =?us-ascii?Q?7pW0+3brel4G4EL6TIJKogjW8R8zGjd7Ss5oJYHgFFg07M/ec/kyKCi7Umxo?=
 =?us-ascii?Q?CE/70dDiNl4A9sKh0yRq6SaEjfl8PRNB505nCzWnR3dQr5cjr0pXhC7OGFJZ?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SmNglDDlFLRDSi/9tdo27TFyRhiG5cXZhib67m5i7M4952HB4DhJguNR+DfTfj8uisV/L0c92XzcPr8E1pDsW7+1rix4q8izKxulWDlUgndejhzRH+Y9m7B5w2t2NKFe3//0WEuSlwRZuXciTsduG0Yv9WcHzKk16in+BeNASZcrxyAIOy7yUuWESgqvy34Boa0YLlsrdJa8bu+X3XdACCaUMP69LdXo4F9bGKyHeR7yGJjgKhkrJ9d953FLtoOf0SASJb4J6HlTs1QYFedOmF2tIpncHVMC+aCT12hCYSHVLzWLFGfjukkRVcIbgWqpJSqHtBg139LqPjldRuhNb8+1YHn2omZj3CSYmMJD4d5aL7lt2lGb7QpbH8ogXUXKYwQo2lZjrYAwJL0M6aTCLpXoKLyRZaQiZRmwrSjaBTMNPiEA7n8FoQotXTu1FCQe6pi5UgCq2ECx/y/dZR58MwOvS/v3IJD9cmTT7ZYhEUCaYkeo5QJpZboZqT6rPb96YseQg1V3bbRFkZ6aSlArveXQxkEJXG9589ShygycLeuR8zFN4gMiChS5wmswrNbLJY4qGvw3Hcpy9SgY1aNS/7a9rEkfS+pEuSwHZVv8uYs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3ea7a4-411f-4dab-46ed-08ddb3c543db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 08:49:58.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Mr3pvbiJ1I+iGMfOW67FPL2/vp1z5Cxvrxho7AECmoX6rsOk2tOh+kdh9lGxy7Bu4tQZT2jZ7IZCyQtravk7zAKrcxRvudUIewjzEB4WtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=738
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506250065
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=685bb83a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pRTzhQGNCHfYP-fJ50QA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2NSBTYWx0ZWRfX8MUsMPKcwXby owwltJxrz2Tvt5HH+EExZ/WEGvD7oMjDHmQgmzylmih7HmeYd+3QoHK/xQ1oHgGVo/2GllLJXfP fWcrImNaHxJJPIQHRBZFXQi4jpFrhDw2hROhmrDqc0K+RjEQj0dlgxdWlSCEpAPRarCqE3EDcLS
 3zQTsfva68X/zjMdG6/Otky124tGTHl5FU74kdfZTSOllZEVtijTMMP6E41ZAMCoPR9cE0pV+Ew egQp0vpzUhB2+XNkcO+o7e9Qh7awa8oF5Hp3/+h5xz+9in+s4RqKdhW6jpmVAwzyQhRfv9FGWfA kJrTIdlXUaNkSH/qo4aJJ8zPeb1Tcof58wgsd4sM427DR7WWujvE3OiiQws+iqgMDzmkn5lVGS/
 NCW065bhsuoe4uLEIS8H/G4lPSh383Njrn453bDDukw9pXeQI/q1B9fI9y+HcMtmapJIkdl1
X-Proofpoint-GUID: 4xenQpfuyVo37b19HU5hak8PirQ69sKf
X-Proofpoint-ORIG-GUID: 4xenQpfuyVo37b19HU5hak8PirQ69sKf

David, are you planning a v2 of this soon? If so I'll hold off review until
then, if not I can get stuck in when I have time?

Cheers, Lorenzo

