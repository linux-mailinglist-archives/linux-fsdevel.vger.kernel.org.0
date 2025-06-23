Return-Path: <linux-fsdevel+bounces-52598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF88DAE46B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E741899FAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A447253931;
	Mon, 23 Jun 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mbwtfVg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234611DE2A8;
	Mon, 23 Jun 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688929; cv=fail; b=MdvDMt0qdhjxmQmESFoeUS/DULnlaAZFuLX59kPziAkKK+W5zJscTAIMlMoVJs7rHsGprsOlDv4zhFCy1gifd2na0LAJmXestn8xMNlp58cfIoHlyZFiQvSoWxlFDt0MxqeN+3ZtwApNdPPaRfr8bGqqBsL12EA37zAGhxhT7+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688929; c=relaxed/simple;
	bh=jV6GR6gtT9pKlsN9WsMa4Vy1w+27EGlM71wo4qZRsR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tO/GWHLH/gWbRzM0BcCD09nQokRo8ZpA3BAYZ5RMPT2gbuodWuGyvVGH+reA507pI0Cz3HWnKQfEz3SPA/Km4Me8rD2IwH6S6l0A06T/8V5KCPI+N/Ty7e6twocZr+bSdY1OqTeT94+a+Hkm4kdcP/szjtrozRalCIcZ0OvkYgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mbwtfVg2; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oz5wU8tpjjsw9kkB8zvIfI6jgmWjjNvSzVfp4yHQYOSalyV5R88UCBKp3bR4Ph5pQ+t7fVc0euB816H3tKjpspbJArRtVyn90rop0To/tcX6AjUfeWIF+CPKfFLKC502xa46gFa+qLEFp2+8P4rgsj6sUCHvZy8lXuRi810LiKHCsRDS+u7+tRjE3xuFjd/w09jBUgwud8uhGhFM1VPor0PbABXFxdEtmhcw51p7duB81dyz/zrAFVi9AH9K2ks6FY1FqLmQ9WU7wE2dnKlFKVMz8O3ggGCoEFB/KewuXMtcYStAFwLDeCbHmJPuKf277zLGOyGh9i0+v6oYTMikLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3byKriXNQENGCPIN7VsI4Rz/pkNWde3jeasyUU/GvHU=;
 b=p+PyfZVF5oVzM6cBxbzqEMPKdWT35axWBgxMho6HqqYcvlSdiKP/kBRLgNFaxYBiL/e5/mfNtImIGt9MX61/JY1frifXaQWHddP0fj2msrWH3pVBMdja8dj+nL/s4/iBptUJA+LIJ0iTKaGFA5m9gcm1cNyTMDgO9Y6TPAEphFYL3lHughDakILgYtmi11e9Tu2zb/4pNOHxmr1dF8X1lbFvDK/XkSElJ8MQsK7vTqP0s6Op3guOUwFFdWesdDCq175tnZ60F0nB7f25lxCfqeR+xqfoHThcZKtWI5ts2zdFxgzZpi7q7iMCAlmDk7b/S5Sq1eTe/foprWxl37SCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3byKriXNQENGCPIN7VsI4Rz/pkNWde3jeasyUU/GvHU=;
 b=mbwtfVg2z1+o0Vh98wwi5Sagy3VH363Btr5pdMY1DWmUc7jRMiD/lx3bkPyRmMmeVJ1fOWe7kemz2l5+WPNRhjMFCo2rxpqPMfqlYJUAfBnZ/qX+ErB3e0OXb8vmuog4ucnp2GD0zcNTeV+14cXS9asl3kqCl0o28taL0vzW/Z9ATzg39eaJjSmjRdnZlhj9TnO8LXC+av+Ak5e9fWN6w3i4MwedSet9SkKai8P0RoXTCMaKZExyXdgLjby67J8C3lUk7Dub0nVPomyCY1X6WFKBLScitE8QXv0tlJoY7SZHSP50HEX+friig6v4nhOHEkuF6Ibu6zEGIlgTVJOQag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 14:28:45 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:28:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 27/29] docs/mm: convert from "Non-LRU page migration"
 to "movable_ops page migration"
Date: Mon, 23 Jun 2025 10:28:39 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <CFAC8375-2F72-4CD4-B96C-1D489E3DA974@nvidia.com>
In-Reply-To: <20250618174014.1168640-28-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-28-david@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5c4ae6-6064-4e8e-4d13-08ddb2624265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMpqVdOoXB7ghW3z6ELVIG3SzXFJ28yY2WMGfMu7oMH7f81enCNpEVtmXS9u?=
 =?us-ascii?Q?nueyVFqN3CQjVjlCKhCH7s+OguLJ+s1WLS5QlJAHnPojz7Q3IQug4Xh6vmkt?=
 =?us-ascii?Q?zXKFm7EOfUKQwTCVGdWNw/V4cRRcGh+4WBYSI8XvaibFZym5aXnuz986ewks?=
 =?us-ascii?Q?pyzRVuRh4yfk6QCNx/xdvtfX6m8VPZhH9hcn4E5fD+EgOX0oAczU67pKaYQq?=
 =?us-ascii?Q?HW9aRftT7MXjKQAnxl5yaQ9L9mW29LoBZtGN7k0ujzb8ScQfcbwyQdpGOaqn?=
 =?us-ascii?Q?ZghtJYVrv4x6n6qzE3Q0pQEC1rq7jEhvL2qlO2+uD5OMWBWw8Cx6FK0TcZk2?=
 =?us-ascii?Q?TpIg4rWsJprNRnDx04oGxXVO1/fcRLJfoXWLFOpByYrx7ZSqHkBq317o6zpH?=
 =?us-ascii?Q?TsJYRtLKCdwvGL52dtgtb1wYArWCAd3I5jphmuBQa9ErfSrqxfysxdP+hVXR?=
 =?us-ascii?Q?FBJTDfmWFB/pJbek/1k7sqHuhhLEM/nVpKEw1Rei3bz02Vs/sw+aOBkdJRZB?=
 =?us-ascii?Q?bieG2VrqZbgthp5m/Rc8/oYLkudrtQA4a20mOOfOK0JFhm7NgjvJK70XJK4B?=
 =?us-ascii?Q?dUUqA1NE4wqtnjNOXX1wyP12lezqraur4L1AtmDUYi6+jAaKquHVnuqBODgo?=
 =?us-ascii?Q?Gbr+Lew7JvD7o+xs2dvi2vx1KQm5iNlUs2EqwX2a/BysGGVcUNv1xXvxQUaT?=
 =?us-ascii?Q?txBk+iu4kEi83b4JzAMGQ4y7BT0BW83g2WnkzEg67PasBy0b77aXVMWduqhp?=
 =?us-ascii?Q?mTa5ztU87VWtG07wW1tav4wPKVeSXQxl50HrXyXa83CwoPPtL//diA87k6xp?=
 =?us-ascii?Q?BU8Ywi9WUJrgQ/7/oDJQ2JJQkUStaXAE1mk8GnP8n8qU/qIuOlF7s7VSLw+A?=
 =?us-ascii?Q?5nMhlEnuRedHYcMp++SO0bXsyCuVZ8+U1HtwKDylrNvAWz8Z7t+EuchO30yK?=
 =?us-ascii?Q?vj17lpffWwGVltjx84lxKNo4JuC2TyPBSaptC7z5QvNyhcyzLawHQHDr2d+M?=
 =?us-ascii?Q?wITpfL54z6GoYeIu/g822dNWGZ+JldwuFhM3VSz6mycdxIGGyAu8WCJ/kMTd?=
 =?us-ascii?Q?sDnuXFy26pGDEnzsYeetqec8aoprYpnattgUKQWlleSI/1r/FuFJt06t6V4E?=
 =?us-ascii?Q?l4w3KVXoCTA/HDMZKGkg2BdcIZnTkn34ulN1RXhA8FYQgDn7cCu281MtKhvS?=
 =?us-ascii?Q?R3v4a/NqZvIufwAAYo36NFVJ6TQ/zWzn7Xw5I7ISl9IBfpuGb/mXHtiTFw3K?=
 =?us-ascii?Q?E4FWe8loX73tkq1uyKFmRWj4AcfnXAMJlxPHMYlLDZoMYCIoDIK4+7VqUzf5?=
 =?us-ascii?Q?qrCX4QRWJHJQFk5gC+T744MgerkxC6RYNE3o3UW80b0qDSjPKISf+k8ToTyD?=
 =?us-ascii?Q?gs3vS7OcZ9+yBiHlVIQwQ7aHBTjO/CwTJcdmMI3pnpLf1ifI1twhLyf4SBjq?=
 =?us-ascii?Q?wiG6rxWM/3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YdNm2z7RrdscpiPO47iq5v7zHkZS7Uq+KK+xOYIM44EBU5yfHx3N9N8cWkK+?=
 =?us-ascii?Q?+SmX3oLqWKV3T4iQ26Jj6y8yy363nnDzzsoqCaZ0mohFRDxXX+L08UGXhP5T?=
 =?us-ascii?Q?5Dfu6/8F4iOCnaggkECzVNYAUPz0qlojE0y94lJiq9XxR3WVdWGXwB6kPYsC?=
 =?us-ascii?Q?zdshuVrbycujjoZUVboHIxutZNDO1Rmmcctyh9UpcJd/UiKesK22F8TqobS7?=
 =?us-ascii?Q?BXZ+CS29Gr+BBqr4ZS9nLdaPNH8Pj22ifvUmDjgeV5YNMuE9+2pxM/vMPYG3?=
 =?us-ascii?Q?RS47foW2mMaCq+5bn3nf8cZjMTGv4LaRBE5A9gKpti2UQhQEZzbaXO9+8rYR?=
 =?us-ascii?Q?fJBV/OSEc3q0+mhSp8hmXO4E07Xf5VArYnygsbng7WodNALItg6/oQampxZH?=
 =?us-ascii?Q?f6pZB0GhoIOvqRjXwVIKEBHmf3XotzBa5AfUAnS7BQE3gd528UM28Sv5ne2o?=
 =?us-ascii?Q?xdj0undBfGEyjLyjG0NVVRatGVSAvyQmSIet+aTikoPWjECAY7/H7HYNUzYS?=
 =?us-ascii?Q?J0h4a8/m5k/5qNEfUwiHZe/uIwTLH7YiWtFQHtIY931haD2ffFRaxonYOScH?=
 =?us-ascii?Q?dQu7BFvu0XFX0gFQs5GcM4ki+B8oxRzZPOE4WU/AYDQ/H2X1qrEWRaHUxVT/?=
 =?us-ascii?Q?ztOuO126/uLgQ1FQLrKLYzXQUNp0aT0xT6/Xcwm3JTNR96giVvAcraQTiCDi?=
 =?us-ascii?Q?2rSmCXPO5cMlzR3RuobZ5T7zNT/PiWOO8TZaK9eINdWHRXMzrPyCOemz6gzz?=
 =?us-ascii?Q?N2CMRU+Udj4iiiCcU7GmY+0lJN+imHzL0B3ZkRmWS7x2YA4EZmRni7CQBUyv?=
 =?us-ascii?Q?WXgdCSZm8Oq275JY0X5vCaknn27g3lEs3OJxjFQ/gKWL6nj2WKIuDhCkl/aX?=
 =?us-ascii?Q?Q38ZfOyQnXB1bDpwUWKngWW9/P91RKinzzA1lq63nQ4HhYDGrXrS5QqlHw/h?=
 =?us-ascii?Q?Cz3Ji4RoPxcQX7pLbm/TMqae4ic0UKgEUrf7cPh+HwZklkMMHW1CPq4OOoT/?=
 =?us-ascii?Q?R8LFCZom4beVQc8UzNqJTPUt+g1RYtsiv0vWxJYO/HTQOwOxHU6lWirJRcPv?=
 =?us-ascii?Q?SiwZRKxHpiNW9T/qPBqrHL30CV6Qjh6bEng4SOmfq/HSO5z1XVWTMbNYsN1i?=
 =?us-ascii?Q?TWc05p4LPP5wAMWAwK+5SN0uiRmK1kBlHn6woZVBqmWjvClWPyXdpQdnQaQP?=
 =?us-ascii?Q?6xSC51YMbosnA87A+ulmGUenTOC4RKukp9k/HMOwtJQfAgZy/x8W4z58kL+3?=
 =?us-ascii?Q?SbC01G5MFAW/2jYEHrLk10VCg1nAVMhQJx2bepwk9QfAN/BEsuirca6hJkSJ?=
 =?us-ascii?Q?mM/Qi3m3DYlNnHF2hLmDO6Y9eEMG5MjfRqoXL4GyoEACnnyTg74nAy8bfEL3?=
 =?us-ascii?Q?KvzdoQxvQOVkXnHHSFIEXfjI+NzI12q/MIG6y8av0YvCrnXbjWP3qCaudqln?=
 =?us-ascii?Q?msoigtdn8x8HntfEwCNHXA3Y0Jsx5Eye5o1qshk9M5JZ0v9c6/fryurC97QY?=
 =?us-ascii?Q?R2e29g3p7fYm4Acpzr59tFlKg83d+oZwznq6YvGjjwOnmNtXvF0t+z5+6cmz?=
 =?us-ascii?Q?PCmfErSUBm4IYaSvkeE3J+Wos2oAQ5tpxXd/lGlv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5c4ae6-6064-4e8e-4d13-08ddb2624265
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:28:44.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47xiaHPJcRngZ+B5so4VGeb0TbESRd98Jmr6VVk7RgTVfNXz/xr3mjC/IvIXNYe5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

On 18 Jun 2025, at 13:40, David Hildenbrand wrote:

> Let's bring the docs up-to-date.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/mm/page_migration.rst | 39 ++++++++++++++++++++---------=

>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/pag=
e_migration.rst
> index 519b35a4caf5b..a448e95e0a98e 100644
> --- a/Documentation/mm/page_migration.rst
> +++ b/Documentation/mm/page_migration.rst
> @@ -146,18 +146,33 @@ Steps:
>  18. The new page is moved to the LRU and can be scanned by the swapper=
,
>      etc. again.
>
> -Non-LRU page migration
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Although migration originally aimed for reducing the latency of memory=

> -accesses for NUMA, compaction also uses migration to create high-order=

> -pages.  For compaction purposes, it is also useful to be able to move
> -non-LRU pages, such as zsmalloc and virtio-balloon pages.
> -
> -If a driver wants to make its pages movable, it should define a struct=

> -movable_operations.  It then needs to call __SetPageMovable() on each
> -page that it may be able to move.  This uses the ``page->mapping`` fie=
ld,
> -so this field is not available for the driver to use for other purpose=
s.
> +movable_ops page migration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Selected typed, non-folio pages (e.g., pages inflated in a memory ball=
oon,

This is a great clarification. Thanks.

> +zsmalloc pages) can be migrated using the movable_ops migration framew=
ork.
> +
> +The "struct movable_operations" provide callbacks specific to a page t=
ype
> +for isolating, migrating and un-isolating (putback) these pages.
> +
> +Once a page is indicated as having movable_ops, that condition must no=
t
> +change until the page was freed back to the buddy. This includes not
> +changing/clearing the page type and not changing/clearing the
> +PG_movable_ops page flag.
> +
> +Arbitrary drivers cannot currently make use of this framework, as it
> +requires:
> +
> +(a) a page type
> +(b) indicating them as possibly having movable_ops in page_has_movable=
_ops()
> +    based on the page type
> +(c) returning the movable_ops from page_has_movable_ops() based on the=
 page
> +    type
> +(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page fl=
ags
> +    for other purposes
> +
> +For example, balloon drivers can make use of this framework through th=
e
> +balloon-compaction framework residing in the core kernel.
>
>  Monitoring Migration
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

