Return-Path: <linux-fsdevel+bounces-54370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E78AFEE32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F64E640201
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203692E974E;
	Wed,  9 Jul 2025 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dREQJnXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8D23B60A;
	Wed,  9 Jul 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076518; cv=fail; b=lx9OSIvSXdXbZl509x+Uj3ZXC+r84RM4mKpv+qOJ6fipgfy03bIxUGm0Oga+i9aWtiv90IgJ4KCGkcm5wIk2LeBZh8kyKNUVNbHhl8ucNCXgbBnUuDjHnlH+VitltHR+qLXR6OJ0A/6uNt7LcaH0jD2rizyHw6XnOvkF9Qv6lTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076518; c=relaxed/simple;
	bh=Y0FhM452ksL2zFvaTHbSN5/05C33b9zeZkZNqPj5G5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRld7flKuXpyYtsW4yuCuSqO1LvDsY2034IZ5UuZkklNtb5BS7J4GbjJy7SHnQvuAN7/+gkLDekHXeC5HIxrKaaVJOY0GKKgwyRuhtIUxzX7rW09tSfDDWUaVW4yMjDrfZMpaAeqVwL/kkAk49Gy6Zbl0uHckCuiXJz1ApZNpcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dREQJnXa; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkhVi3uApvdeTARdcfI7kZMmFj8E3KUWMo+hDfJclDl+UcySKxAdM69Bdmlk8A0QUGD/0s1e42U59/cKx8Rw8Fj0xSW11NmR+mspWF0w9lU6FRRrKmr8Oy9mkZrKMTpGse7+9OUCAbEs6titoFANN0i7cAca6ifqRQeza+LprHe1e5T9o1WW5nWmn+Gzv2k4eFuuzQHGkdBm/ruTqZ4KWLf8R5SyHyzPqSCabfXYARx8fYXwMBhoZ7O/Rpuuc1rSmowtwMGtlyCB3yMKP57+/sbqckax2LHqozB4HPGNxzqN9S/ttVS8khFBF3z9SC/jDWNgFD+3WRbPgokNob7bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8Sw3FhaADdIAZVwJ8BusqJcEJ7rqv/06eyQzedou2M=;
 b=lDWiKp0pPmWeZ6kSp3ErT5QCcxkNxUNxlLe6nR8Gy0bg9teo0XsBLcBkUbd5U9xFn4fhhZaE7eflqskKZP7tqsZ4sSfsXUjuKp8QavWpSurLfqDF1MOw++UiNBtJqZb4Idl/nMjlHV7NWjLwP7G/7lQ0cfS+MESpXw18zi+riOkpWem637mIfOpF4tjGYZuEzRk8BCBwFgRCgneRmokucqpU6oORJ1NthZ9QJtqqt2kYqZvDCw1qfmYVD2esD+KIU0oCManpbeYBJ2XMyehrl1Y8tUnlYwYcDyKJFp69QfPb3KTP47/q2/yn4TThzjQrJHjKcaLpS5pWOiGeGkw/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8Sw3FhaADdIAZVwJ8BusqJcEJ7rqv/06eyQzedou2M=;
 b=dREQJnXaVYl9x6ZIBrUXCPFuqy6WUH/nwlxOSsxheKvwz9Nw8yVI2I/gR8dDQ9demdnVCUhbVgXWdL7+wYSVvEw85RR4DKfjxEFAKfzetb2bQMDvZtJfk3m/0mDHaa/w3j4sVUT0C0DGXkkYfOBZNyv+yXgnYfGPk5PuPSQQEGk4EY69JNAMEwRdm4OqhZ1H5KWd8g6WrHEq3EKOFkNteTGs9i03Gm3adZTZfMRYI/m5wcjQZFhWQ0NBuexpJyxjf0LlKWA/42WH00/qYobinQv/EEqkOpNrYL8fRipWuWgt9RGjGYjVC7UNKJzYcsIzH544eQys3xMfRW/AG4uFTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.33; Wed, 9 Jul
 2025 15:55:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 15:55:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
Date: Wed, 09 Jul 2025 11:55:05 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <2FEC9844-D448-47AB-9AD1-5DE9C43D40A5@nvidia.com>
In-Reply-To: <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: e5af1e7c-4091-43fa-9ec8-08ddbf00fb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3WPZYP/Qp7Jg/goJlQ7R6Wl7ZrQJicEnRmbj5qpESBdi3lURv9/Qp9S4zWFf?=
 =?us-ascii?Q?bi51meN5DzDJizDg2vgwztdZXdjD4DGDPZbnBu5w56hAGLRk+g72/CpM4wsv?=
 =?us-ascii?Q?hEZHItDT21WH2WJgvaSY1o57bbShj+Xe4GnXxgGpLVAleJNE5j5FRMC0ZXRl?=
 =?us-ascii?Q?+Bzx5V7on5QXpnPDXN06Kwb5cSDzj2i2BvleYZPqGqSugkTGcM80GCbrSBgw?=
 =?us-ascii?Q?AsIePYA+ZIAqgvvfiS/N1cD7aywHxaR/Eu+pbvHEDDZsLUrkDQIiYXo+BUm3?=
 =?us-ascii?Q?Q67f0Vui3TB37KqYxMpwDlDU+IygsX4l2Hoz8U3qGl0Eydn6k+1tzBK4EJ5g?=
 =?us-ascii?Q?JYE5yLJWEEcLI9hzGIRUEAykf5GRNaMm0EeqsTavHc628schnYczMKcrifmW?=
 =?us-ascii?Q?FF85+H4g+juhKPG+/Mh4IJsMXhRPthoM0ySSe2wMMy7Tw+BSrlCPmvviv5No?=
 =?us-ascii?Q?PpxDbfkeUVi1ROKgMeR6siG0+FU3oZhPJSVb3AjLRPGmYsWdyOqoBvxM2xx1?=
 =?us-ascii?Q?9bvjb5r90H4BOENu8NfhSXsbbSoxBRZiLEGOfs8r0+T28e4j/cEUefi1Tv4j?=
 =?us-ascii?Q?tiNRhwEJaSDLLptJWo5StMakMIREMVx0Xy2xoBOI0mv//KYXMmuBUcmlesCJ?=
 =?us-ascii?Q?AQCw/0MnOr1RuzJ3s4PAlEtZAQa4yw5d7NaK5K2E7Woo9Z3H8Cq0G2dDbxwR?=
 =?us-ascii?Q?qrnU4fHSGH2JGm9oCNZDkY9qSeyorw4OVMgY6g1v6h+XalRfQ/tcWfMZC5gG?=
 =?us-ascii?Q?yd91eeLcoQVUK93DbfYxrV+tm1v+RO8L/spjvSbKGl4TtC3LoHjdZevUAkpG?=
 =?us-ascii?Q?STgM5Fxs4s3KZ7tv0E7NFpQSLHpj6ho+cnjGVsvC09TfgpCRIahO27J8P2E2?=
 =?us-ascii?Q?DytZR7zgDknlqCUs+dSKJIvoIVzEw4ZtI1bf19EyHGKRqPSVP833ray4bGhy?=
 =?us-ascii?Q?lQb9sLBYnhLmA/UauUx8WhEw6zFfKZMQ44BqQYsyjDCIATPOyqPe6Lh5CEdz?=
 =?us-ascii?Q?sadExJnf3dSApVvjGsU7P3qIEtWU3smwi53oBSRHBT9s+YJb0UPWAKhXb5/o?=
 =?us-ascii?Q?pnnsj1rLL2nq1xOLsiZGael9FSn7Y78ym3lmIgMEmf1N8nFptCFQHAVY7qL4?=
 =?us-ascii?Q?YtQd2LOzwKHnHbf1gdGMH6qHVpGazBou333itC4ceUKyKTB1W9Y17dS1uLEz?=
 =?us-ascii?Q?w+dqzKgxKFTj6O4A3XsS/Sbxf5+X0MU5soxX0ztAXdAuQeshoPpSiOzaIxFW?=
 =?us-ascii?Q?pFD6cSj0DRBw4pHKP0tOBN5rXJY12nVIY1xX+4j+otBdDwT1swKG+vxfDcjr?=
 =?us-ascii?Q?52/eMU+ZORGXXcQuFcIAWDUSie/Ua7JdN5uLJO3tVQUIywhdNL7Gd5+XlPHq?=
 =?us-ascii?Q?F/SQAYJqFFGWhuw6eSvxF5sp7yjClGBHufs0ZRGLay9pcFN2fJs0NGwahaJ2?=
 =?us-ascii?Q?QlWBrKgF284=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xxP8znvZHbWMNATzwvUuIWqqMUk7MbgzQTnEqra7+Igj7ckkY2+lQYCb+KqZ?=
 =?us-ascii?Q?374ksv16R+D/U78O2g1lijc3LbmGVwwpHRTBJ2DZhMDUXYTijZz0zmUTerUx?=
 =?us-ascii?Q?vJQux94YvJXHo36iu7rUEdOM0HpL5W4AbNvNWb4uhy8B+9tPgj8Lsesn4WRi?=
 =?us-ascii?Q?GrRfoMVrSphOaQrJeNz9P/akDPyUSlG4nFeAA4YjDwCzfsR/R7d8/o+fDWdt?=
 =?us-ascii?Q?wjrPaRIF2vwvxpdK+Iea/2aBdrNBozq70aLCX5WWE+LfzjeojTtvlzg3Tntl?=
 =?us-ascii?Q?Cb94VVFKhQuIWDyxhsWwdHaLTuKb2XlnaFOpMV4pRrh83yJGFFqmv42AVaj4?=
 =?us-ascii?Q?zWc4nrhR25xpr5n8volWOGDUNYSTNg2auohaKI8F1NjQZOipS7uqzDp4wrdW?=
 =?us-ascii?Q?42Gi3p/9cfv4dGmY046tQxJgz7KdZT8PlU461zqO+qN5vwjvZ3AUU39VMo8Y?=
 =?us-ascii?Q?virtEf+laRHGITKfCpevaHz2i2MvsTGiaIAB77DnQy1DM/Mu4Grp3tvcH6vD?=
 =?us-ascii?Q?SyRQY20YQx2MF5/Rws5KkEv3wswPfDnQX1L4p1DC5kbyPhrtHKuy1oRwLEoM?=
 =?us-ascii?Q?CIe3tF80eLGMu4kMTruKsxyyKzkvPxdYAb3uPqUJIaj4IVHE0ye8YqVogK4R?=
 =?us-ascii?Q?qeuJqGWfgoq/NlJu47TxKlgDsrsHkeCNQTR7Zkl4GP5IFoYqH7tiFrRxHL1x?=
 =?us-ascii?Q?MwmVZJYcXDKUQQGcioK7jIYCsVhytc+XWGx8qn/cqj3CCAPJuqpG3oYUybt0?=
 =?us-ascii?Q?R3/eUN9nzQKQLNWdQUFMqXhTsP3H4WyVicYh0CjSxFs+KfqAez995M1ewCgt?=
 =?us-ascii?Q?J3hLTphCKHpALtA6lj8dVTGadi6MJew0GhCLdrfDVEBlb6XIrSpJt0lkf/fy?=
 =?us-ascii?Q?TZT1LWi5c66J4+cn9kiud0MXyRRA1tpc6I1/6Roi/ri7dr/fdQ4xcEXAFlFF?=
 =?us-ascii?Q?1xSFU4kGuTNvqVzrovj2j4q5ikSCa+81cF02ckU1bY71Fh+fyDkQVBAC5irY?=
 =?us-ascii?Q?Cn6ipun2wkPy7SQO+DinK+Bt5ygsEoz6QzN9xYr0QGafsHTYAaLcSgx0HhIO?=
 =?us-ascii?Q?TQSk2vRO/t00p3DHubh4NW+Kga8NKpiHO5KczsY6i7CyNYeMYxgijCv3pREt?=
 =?us-ascii?Q?7ASqXERs5lpA0PYwgt9gw3IYS2Ltc/naa0RqvCWoYGIcm3/m/xz+gZWerzWO?=
 =?us-ascii?Q?MjX1Fw1bZxIOUlVpB/ZkgPb2BaEgLipeUWFGpFjF9lBMPGuETZq5F6CwcCCi?=
 =?us-ascii?Q?lA/dwZg0tXVInS9gxejubIIs82AVVLUDdQL3TXdgpDtONznI+FqIyI/Jxwp5?=
 =?us-ascii?Q?IAnOQdWuCPpDXEEsCfCfoDgtAFvlNw7MaRYLOgYZkdexgMPdcPAW0Dv96D78?=
 =?us-ascii?Q?J1LToJ4QUzjMmcWXlG704knCKEySwds9NM4/DniWvKGcrVzXDav+OHY5QnN+?=
 =?us-ascii?Q?d8AdPwXxd5i86FrCa4g6iYiNscCHM7trJGC4WLmRQ0XkJNXYQnRzm08VdnC8?=
 =?us-ascii?Q?zAo31ioKomPmJofVrMX7D/Q6YFriG2Xy+BVHNcKxdYazGjW2nTR40KANNzui?=
 =?us-ascii?Q?Sa+jdFyYkNh4lp6anCGfT7o3aTS2spwdculWtz+U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af1e7c-4091-43fa-9ec8-08ddbf00fb86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:55:09.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqcuaYcexnIk3v75ma63BXzC4lil/2qZN8nf/xqbfSTNXhiAaQwpbHkhXrwjQbMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

On 9 Jul 2025, at 4:03, Pankaj Raghav wrote:

> Hi Zi,
>
>>> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate th=
e huge_zero_folio via
>>> memblock, and it will never be freed.
>>
>> Do the above users want a PMD sized zero page or a 2MB zero page? Beca=
use on systems with non
>> 4KB base page size, e.g., ARM64 with 64KB base page, PMD size is diffe=
rent. ARM64 with 64KB base
>> page has 512MB PMD sized pages. Having STATIC_PMD_ZERO_PAGE means losi=
ng half GB memory. I am
>> not sure if it is acceptable.
>>
>
> That is a good point. My intial RFC patches allocated 2M instead of a P=
MD sized
> page.
>
> But later David wanted to reuse the memory we allocate here with huge_z=
ero_folio. So
> if this config is enabled, we simply just use the same pointer for huge=
_zero_folio.
>
> Since that happened, I decided to go with PMD sized page.

Got it. Thank you for the explanation. This means for your use cases
2MB is big enough. For those arch which have PMD > 2MB, ideally,
a 2MB zero mTHP should be used. Thinking about this feature long term,
I wonder what we should do to support arch with PMD > 2MB. Make
the static huge zero page size a boot time parameter?

>
> This config is still opt in and I would expect the users with 64k page =
size systems to not enable
> this.
>
> But to make sure we don't enable this for those architecture, I could d=
o a per-arch opt in with
> something like this[1] that I did in my previous patch:
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 340e5468980e..c3a9d136ec0a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -153,6 +153,7 @@ config X86
>  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>  	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>  	select ARCH_WANTS_THP_SWAP		if X86_64
> +	select ARCH_HAS_STATIC_PMD_ZERO_PAGE	if X86_64
>  	select ARCH_HAS_PARANOID_L1D_FLUSH
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select BUILDTIME_TABLE_SORT
>
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 781be3240e21..fd1c51995029 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -826,6 +826,19 @@ config ARCH_WANTS_THP_SWAP
>  config MM_ID
>  	def_bool n
>
> +config ARCH_HAS_STATIC_PMD_ZERO_PAGE
> +	def_bool n
> +
> +config STATIC_PMD_ZERO_PAGE
> +	bool "Allocate a PMD page for zeroing"
> +	depends on ARCH_HAS_STATIC_PMD_ZERO_PAGE
> <snip>
>
> Let me know your thoughts.

Sounds good to me, since without STATIC_PMD_ZERO_PAGE, when THP is enable=
d,
the use cases you mentioned are still able to use the THP zero page.

Thanks.

>
> [1] https://lore.kernel.org/linux-mm/20250612105100.59144-4-p.raghav@sa=
msung.com/#Z31mm:Kconfig
> --
> Pankaj


Best Regards,
Yan, Zi

