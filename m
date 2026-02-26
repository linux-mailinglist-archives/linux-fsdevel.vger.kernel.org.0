Return-Path: <linux-fsdevel+bounces-78646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JgoGYa7oGnClwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:30:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE651AFD27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D920031519C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6545349B;
	Thu, 26 Feb 2026 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NTzCbC4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676C43CEC1;
	Thu, 26 Feb 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141227; cv=fail; b=gN4QvDizAPGl1H3maPxknURecK+sPiOzz1u9gyegvjmvHy+SEOnTlXXKGaDgwB2ksvCZo9l3QFOoXj5lng449UAPynSqCEhIov+75BKfRed1JO+ddDu54JsgnoRY0ynUgPxf7+JzkScNdbBWh+XM+V76nZymXz0ZEnO4RP6ebjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141227; c=relaxed/simple;
	bh=83MIDY3yuYfN2iYNTnSIqAs5/mTkbOfMOA3O1etM9LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdX8mgngfRgYPd8T/+kCiCrUd4a8etIMytU457gQ+vXwJNeK32q6HGyOGEkbRvyoes2lXUTDmUMcm47faenxX0EQ4tVPHr7bQhqu66FYorRyZH7BLu9qf9eh2bi4c8Sw5eamPXJtQqGxy0V8CqUr2D6dPA2M1glB0LviKldO8d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NTzCbC4z; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUiRWSmT3BX68D7q9R1Kahv2QBfewkCN0MKvCGwzYhWbPezZdcQ1ecBQX9yoCCCYXlWJy+r1RpSzGTkBpcbXqmhGTECiI84Va0MgYffZIneMN/3AtIZfygNPWXXGBvDR1DyiIM6lNH6GGql8gPooc5sYXj0pZs4gFqdaGp3qphkJ9AefvGYj3iRzsJw+Nyhop/fPxdBtVNwd1SCjvxFgHT1Bh7ROGos8KOo919j0vTHmU0va02u94SXmD2ZIKuIJGtaWJ9CO3OwBP1cJ319+uTYIst/DVNXUqFCimTUqm+qSNSQLtWOHDAb7+9/+A9w0Lc1DYXSJW9VWBsPPNe1D2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rM/1BmA+PZAWoZM5grA/Mjk0zRUV9ElpVm9qFatzyc=;
 b=Bn3SixIWutP1X/r+kR34ajeuJhte2lyxNX7+aQ/mcikfmMSDgWzC12XVFIQIKNREvZCAZu0uK54Zc6WsoUhSXoKuBcm9Hf/0Q+uCwbVeXdkbOFZ3AVmQwgS+hCF43tUm4Am0Gn7N+1RWo+wG7DDNWrdqiaS6HVFjciJERnmx27Ok6CM94eZnfSn9Bqdg5Psm2mvXxc0qD74nrUcq3OommbK7wJzUVXJa3I8bou4G2HBWYd3IIk8uyvVk5QBipS/g7/a5g893GO5TjR38O0s6GE7G5wOqtOUAtK411NwI++4Y7D6Kfv58chJaeUwJw6nbzJElUiQdNpy+Ikqx+7yTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rM/1BmA+PZAWoZM5grA/Mjk0zRUV9ElpVm9qFatzyc=;
 b=NTzCbC4zK26Ou9M5vbmyA3i+fod1QpkDQOZMVWYat96ovvHpbMMqyjlPgdhPJmifcQF39OPaoovRQZ9YRnf7cyKwv7W+hZ2Ox+EfEh4SSX8fzF9YVP3qBqbdOotJfdv08I8Gr/URza5VwmVsj6LQlD/QVPm1pgs32hshRBoaTD0prFR/9pcddkIBDIT0VdRlvBR2vmFmC5YI8kpMuqGAHMKyeBVYiXhGZ1fQKk462Xl5Bp2dD6yE5U3tLBZJmKQyInXp7OfEloDEDAibHwP5oK378yWjiK7L4Fvx5k/o0rQ18cqYfEdk6kipYy+ZiJ49yLDSs0c5sPyAbel4JLYcYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 21:26:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 21:26:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Paulo Alcantara <pc@manguebit.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Brendan Jackman <jackmanb@google.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-ext4@vger.kernel.org, netfs@lists.linux.dev, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
 linux-nilfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v2 3/4] folio_batch: Rename pagevec.h to folio_batch.h
Date: Thu, 26 Feb 2026 16:26:42 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <9208B145-365D-4502-A97E-A88F19EC2EB7@nvidia.com>
In-Reply-To: <20260225-pagevec_cleanup-v2-3-716868cc2d11@columbia.edu>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
 <20260225-pagevec_cleanup-v2-3-716868cc2d11@columbia.edu>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e728e8c-669e-4321-ea8f-08de757dc4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	kQ6l35SQMirkvsRLXGIe3u+dPlvi468e5ni2B8fD9YCbRZc2DvsiTa3lWLpo2xuEFjvio/HfqWTTccCZhCCA3znB92bN8H2jSrrVwFXlw4MGE5sB6YnVk9VXbJEqs+BYn8+vceCFQPXEqzqDslbzNccfR1/tnUw+n+xrDejSOtaCJET0eY+Hl9BWDybXkWZsg8PaPcAPBgOd6z5eJWlyPAx2eVFxgFXxh0KhYj4qqzIjQX7dnsXolmtimoXKRuCbyVPYECqziROIiD+EMgmtc/XZHqnen1IqfILKdJzl8M5YcPARjvEy9T2NBkxaYm2f6Q6/GUocvxcTW9HCV7RgiZP21AdGpueVbz0Nu5gJDyLO/Y9dZpKSqkjkdrlXQnvrjOOyZyQIpCBA5xCp+K00G5Q4eXP6ufGsNd3WzxYr6d+qrKCcoHZ7UC6YM7elpvMm4q5Ax2wIjtbb6Us/A+0DRH9StlIwguVxuRMd4tUb7RgqumYZrezMSQC2BTUKnpYVEIfq+gtfjX9iV5oITCZp7R1PnqW61ap3jy9MPiqY3lzPSMHpVDlC0l4mUKiuw+TbB82wphFWkB5O01NaeQyQwD2W/nYCqSpn1ApT05NdCp7UtNoAONIPSjmH9cW4gkekZjCrf5A1l/223aODWG3Ax0y3Vib/WxP1FMEPhKwD4LK6zVmFSK2XO1uAVyYp7BpA+eOIN1KTtc9xH6b1tweyeyK81/UEOOHrKXb9SkVNEnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j5fmxgyJGUjwbJl4YQ6dkjauhR0PjA1UGO4sF5OBApKHkMdKKXP7wVmE9QiQ?=
 =?us-ascii?Q?Lt4E0WyDH2y4eyaAwxBGn8bSDGJLMYsoRxy+vnBXSmwsZ+Y4HVuDJcuVKoDF?=
 =?us-ascii?Q?alVdUuvpLY/yrsTbhhOaETHzKPn5U88dMtplk/KEAnxLstAz4JS7drzl+ZKI?=
 =?us-ascii?Q?GK2EwTgRr85AxA/9rmbaj+VDIJjow7wA/KWZ0Rt+iy23UXoZsYeP0kqt239a?=
 =?us-ascii?Q?JSJgBqVc9OshXOloR9h4hlq5tjT+Jf3tccM9f6xB+RaMxHtytd7mgwEvjR3O?=
 =?us-ascii?Q?Wp68U0J6QrMuo5zu6kyuuJvY6JL11gTIKy0hvC3WVrHqduzr3Khp8ZXGHnm/?=
 =?us-ascii?Q?b5GS6h1ioTyYJv6vDtbcdx56idI5Q2CSLXuvIX4x+Lum2a7WN5F6aD1jV6rs?=
 =?us-ascii?Q?7WxG33z7OPXhOD/feXPvb9jX7tENQAc7RjvrODkqOpP1lg0lAglfOlm4wx3h?=
 =?us-ascii?Q?b9tBPj+kH6DQbDJJ92KcFEiXWHgkHFKTSADH5PQexxcPozxWFQCa4Kb9WPvz?=
 =?us-ascii?Q?MVhqH4chU2izKLSgXh/QzzkIzLs6MYO2EPtGz8u12pbwahJAw/7kWQ2G0WwL?=
 =?us-ascii?Q?xEbDQg8hb3AAqO6Ev5WELHHQTgyMmzM6tlwWPnQPirvogb/ZamwGWkmiq5vz?=
 =?us-ascii?Q?XkHfDksHgPdOLyjOkWIiW1tECMBo9CIRNhWdiM2ii76A5xJ//18TWrZd78N4?=
 =?us-ascii?Q?IfbI5DWbJjin75TNe90UGIQkCny/4fwbMwKIwMy3t5WTTk92Zg/ZhwHTWSAC?=
 =?us-ascii?Q?MOL3nCs6Fo+pKWdOVuvMQ0Ue3e1MLu9XiSTKrKBkzWsvNmfANZtqsqRSUFav?=
 =?us-ascii?Q?owHHuxKz20J0X8V7WfjowAzh47+zn4YAKMAZbcfk6thnQRfahKv+wvF9Sv8e?=
 =?us-ascii?Q?FBQqbkNNl1Bh7sArqU8CvooxbFBET1i4wwV4tmPWnnI73g0MeJK0b4GPjFQ9?=
 =?us-ascii?Q?Ayi7MFGJ+Guu2kmJJctdSF1Ra30OJVZNyGfg6HJlch8qtTY1fxDP5lguz+Zt?=
 =?us-ascii?Q?ecNtQOMJtidq32jyH+j7+gNdqIYEdBCCzoQcvASCXSy+Ona3arhJTzZT2gfF?=
 =?us-ascii?Q?Kvqm4tNaOq51Rtca7nKyKr+XJo7i1qofgE4TUlqWs1vEYO74Lm34o+BQ297Y?=
 =?us-ascii?Q?nSyRywAx5eD7q2JTrdWVPzFGdTT0qSV3pnFu4R2dmSwUCsPc1gQAlbrUYCij?=
 =?us-ascii?Q?WAJZKHHgoq+YhfJcOUqTXSwXAWvd/Mz9iXHou3q6mHtjOviQVEAQYXGWXZ5s?=
 =?us-ascii?Q?4YSo23ll0I2Fkfcfy0BloUslGxywXAI7zELXOuOQJi/01yD3IzndG226i+yb?=
 =?us-ascii?Q?d1lBaj4w5v7yQFUxasZyFbgEkHe8vIfV6mIkkInKhhPTdIinmRmNDLyDF6MC?=
 =?us-ascii?Q?reBuc6EgTJnN1scDYaUdVIn/DPmB5fW5vdsh/3RKC3ze33SWL4FVtOrFKIRt?=
 =?us-ascii?Q?PexA3Vt/tTNEF089Kx6MPdXLt4OMHk54Z33sFTpK3VIrZ5Gv3SPydzP8GEwJ?=
 =?us-ascii?Q?Ci5vKzwIU7KxFlO4Agd5eD8pTKX1Vm9nS73dLeKkSS3ccZwqjGstTvbtXyvv?=
 =?us-ascii?Q?xwazIEnEaHQHT8nYozHjn3NU2wwcVI5NN50izyxFA/Q4Vns5dGfBUr7D6uZr?=
 =?us-ascii?Q?TsXj1ajUY9JR01a7ffDitUwCe/eqSF15eOaBHx9LVlD8VfA95KVVBg5aNhRf?=
 =?us-ascii?Q?YZm4kmO0VZjzCIhhw2z4vEDzh8WwIhG1wp9785pFMm1DrZfW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e728e8c-669e-4321-ea8f-08de757dc4db
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 21:26:56.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jenr18HfKHbKz4HQm4TCl2fMsxVd7fcik5qHhR7FFRxWO38/ehINumbRHg2R0gBt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78646-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu,dilger.ca,manguebit.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,ursulin.net,fb.com,dubeyko.com,linux.dev,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.954];
	RCPT_COUNT_GT_50(0.00)[96];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,columbia.edu:email]
X-Rspamd-Queue-Id: BFE651AFD27
X-Rspamd-Action: no action

On 25 Feb 2026, at 18:44, Tal Zussman wrote:

> struct pagevec was removed in commit 1e0877d58b1e ("mm: remove struct
> pagevec"). Rename include/linux/pagevec.h to reflect reality and update
> includes tree-wide. Add the new filename to MAINTAINERS explicitly, as
> it no longer matches the "include/linux/page[-_]*" pattern in MEMORY
> MANAGEMENT - CORE.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  MAINTAINERS                                | 1 +
>  drivers/gpu/drm/drm_gem.c                  | 2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c  | 2 +-
>  drivers/gpu/drm/i915/gt/intel_gtt.h        | 2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.c      | 2 +-
>  fs/btrfs/compression.c                     | 2 +-
>  fs/btrfs/extent_io.c                       | 2 +-
>  fs/btrfs/tests/extent-io-tests.c           | 2 +-
>  fs/buffer.c                                | 2 +-
>  fs/ceph/addr.c                             | 2 +-
>  fs/ext4/inode.c                            | 2 +-
>  fs/f2fs/checkpoint.c                       | 2 +-
>  fs/f2fs/compress.c                         | 2 +-
>  fs/f2fs/data.c                             | 2 +-
>  fs/f2fs/node.c                             | 2 +-
>  fs/gfs2/aops.c                             | 2 +-
>  fs/hugetlbfs/inode.c                       | 2 +-
>  fs/nilfs2/btree.c                          | 2 +-
>  fs/nilfs2/page.c                           | 2 +-
>  fs/nilfs2/segment.c                        | 2 +-
>  fs/ramfs/file-nommu.c                      | 2 +-
>  include/linux/{pagevec.h => folio_batch.h} | 8 ++++----
>  include/linux/folio_queue.h                | 2 +-
>  include/linux/iomap.h                      | 2 +-
>  include/linux/sunrpc/svc.h                 | 2 +-
>  include/linux/writeback.h                  | 2 +-
>  mm/filemap.c                               | 2 +-
>  mm/gup.c                                   | 2 +-
>  mm/memcontrol.c                            | 2 +-
>  mm/mlock.c                                 | 2 +-
>  mm/page-writeback.c                        | 2 +-
>  mm/page_alloc.c                            | 2 +-
>  mm/shmem.c                                 | 2 +-
>  mm/swap.c                                  | 2 +-
>  mm/swap_state.c                            | 2 +-
>  mm/truncate.c                              | 2 +-
>  mm/vmscan.c                                | 2 +-
>  37 files changed, 40 insertions(+), 39 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

