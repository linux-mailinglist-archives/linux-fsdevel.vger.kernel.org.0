Return-Path: <linux-fsdevel+bounces-69896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB2C8A586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02B03AAB13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B130274A;
	Wed, 26 Nov 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="JSCMIqix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020092.outbound.protection.outlook.com [52.101.201.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DBF1EA7CC;
	Wed, 26 Nov 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167504; cv=fail; b=aNkfaBSjC75XFHrpMLqk9oiNiceJQvqoft0O2hYVmzGhbdA1qutl4F2DAuElPoWjgo653qcIWOFsi5Owj0fkDvm7Tc9dDPWNikOJNL50YVSM/K0ATMhBZq+4hj7F0vbP5c9YDXUFu/iC3aOduvXqTySoZZrHdtSNf1YhoRsFN9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167504; c=relaxed/simple;
	bh=970OpFDWvFh10tFfN30X3ritpeuSIOvR15K5JmxqsO0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hf6JGrmW16AfC62VrwfHI8Dq7KmQNkXfLnfc/CkS3zgWSvi4OAw1/FPaahtnnhdmqD9tRuyDqqGmTZijMmLmDKoHGJz0Thcf11Lj5PkaZ6YakhjALBhYClvwamxE9/voDIod128BMvvDLKk9g3kx4K4Y0D+WB3oB/Bt/bJVBaZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JSCMIqix; arc=fail smtp.client-ip=52.101.201.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVMwFdXm3BW0BbYBHENTn0fNbr8ZZ+96huHFTZbmTdDKLv4OBpPH/Z18V1n1+eXQL83xB5auu+oC3lWRptfeswXW2erNRVu6UqA+gz5knAz2hz7nzJ2eq+JxI9Q1mRTV38pz8b6nxEij8OsFpF9RHUrwtwK4c/GPXdGmLxJx2FtF2mqtBbXB9/NjHxOQQgVhpYds8ZKjlX0KVt5Sv5VwfoWpsbKuUs053zUOVNFFgTl9MR36Y+Qi4O/wfoPAGOxU6zcu8szPzjF+7LATxdce7o3czS53jZeV/IiS/lMGc7+k0oWznGJoPzjf2Gji2roOdgSVFrtdTrqw7P8IIBMZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tljJKVYEwS38ghdLInl12yptoIxPxm4Cs8i/4SVekVg=;
 b=B447Fp+obt37HH2zge+7TR91bOtI+x1ZFGQphW+HHPL/5k57ft2996GXRN8pMPraoRouzBWq87P75ziVFDPpTYvthw1nE02jMNrQiJLWdsvykEzZWES4B173aC9ZTsGFzFntniJEvQlm3F5ffKcXYDdjzD+j9WcVPZOeJ4MJgLtRYslFzV3BoF2RejXG+o78fdnw15+r9bCxoehlvk18eq86Yy5zCLrg7e/XppMlqhM75VRqSDHViSZkwWqkzDfleCyqSJg7ZAnpXwvnyeK+r+lDYk8cuxfGb1wa7ioMUDvNHOhBOmqfGZVDuo0MLdH4SV6REQX5gvbpNriqXu7ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tljJKVYEwS38ghdLInl12yptoIxPxm4Cs8i/4SVekVg=;
 b=JSCMIqixm6J05VR5OR5//XehkyUP1zJy34UMkHa3hBMJULkH0uZ3OQSCLA/VZto4FvY0iFI0BwaUvHyb7mrmEMB6CCljCidyMIhcXJJPR6T8FLzy0x16xDUzj6S9vrMH6QgzE266rEThabC8YqZoQBwihGrBR+W1l38jQlSsGAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by IA1PR13MB7519.namprd13.prod.outlook.com (2603:10b6:208:59e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 14:31:40 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 14:31:40 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/3] Allow knfsd to use atomic_open()
Date: Wed, 26 Nov 2025 09:31:33 -0500
Message-ID: <cover.1764167204.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0041.namprd17.prod.outlook.com
 (2603:10b6:510:323::24) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|IA1PR13MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c38b49c-958e-4837-3a32-08de2cf8833d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VpSgOVlz1/S8mRjQXpF2gIvCi6QS7hgJ7BiCjE5FfsAUC9gelqftO2kWf5wm?=
 =?us-ascii?Q?U9RLBw8TbxspkSj4y0qcO5TqHMrtpRmgc+qOfHxm/OmkcoiZqv/d3DrZTD6F?=
 =?us-ascii?Q?g3eTvaVNKUMMIvnzOTpUEHSDnHfIfF5nV1JSWtVU07PBWLS+Ag/0bXNtJ1/9?=
 =?us-ascii?Q?GwjXKz4nSE4i0HSqz9Hybxhb7nP/Mh0g5qAnxTqOOw7NWba8SCx2C36EDQiK?=
 =?us-ascii?Q?wDzBu891eDylcX92Nzwttrk7D+KiSbyJAyS/Z2HxWx391pC8/ejS30CJErbm?=
 =?us-ascii?Q?zSnCwjNfqt2WUE/ukO/pYzG0D3sB2wV5cwN2g2lirAxNHTdMbOyH4HpVI5wU?=
 =?us-ascii?Q?zf3NsFlU8+GBlQnzV3lPeE8zm8aUGZD52+cOl+PLhlmZ5nyQu9TquB0KvxO1?=
 =?us-ascii?Q?YpwaLDJDq6xPRRrIEjt6Ltabpz0GOaGmekYMRfyGDo9Ov+0wdUZ8SSoGgrw9?=
 =?us-ascii?Q?y+niw21T7w3cP5ok/kZsoYAqLaV6TOrD9irVpVnRiWjuYio5OzQS/aBfUjfB?=
 =?us-ascii?Q?W8ljWXegnRmOYsHrg6UGvYC1ruVK2s5zuNbNl0thvShuXpae+w9kNDm/RAkf?=
 =?us-ascii?Q?D+Xng11tivx0RvLJtZLMz/Kt+MpKa0OsgploPu3TC+p5EOiyqPNOExW8NskB?=
 =?us-ascii?Q?8OqTiDt5shdSDAoh7FMCv/1urOQtkulF8OB9OHkeJ18RCi6d/c5B7N2/PGhe?=
 =?us-ascii?Q?bYiOWYqo9CM77RN8y602mot0iLfIOLpDhvTDMXEhc4W1oUnRjsF7wnarYVz3?=
 =?us-ascii?Q?ORyfAGnONQ8Wg+gOI2z6SpgBu1cjs3oekveNq5Mq9zVaeuDaZV4FkNlQ9XGS?=
 =?us-ascii?Q?wd+Q/EXjNu0ZZS2SXGBfrAXQ5XmYfAXdq++F7SgHuE3QRdy8Z2ULwQkU2F4N?=
 =?us-ascii?Q?0GMGYHJbs6DW9tnia4mYEr8H8fx3HZoK+snrc58tswyzfvCMmjHQBj1pTQvf?=
 =?us-ascii?Q?kYYQwxqituBefdi8w++T9dlL/8TWd5NxvhZw596rvxzz/ds3en+hpvcyhNhK?=
 =?us-ascii?Q?+8hAXpxjqXHmkMimIYNYA9LOMfZ6NafL/+xdVHKOJdNJXpGS23zMcsP6KWAZ?=
 =?us-ascii?Q?ShzbqZ/xjf/NzsKk+O8norZNfNWwMm9jmSgkiZKm/On7/DuXpE/t5NB3SKRZ?=
 =?us-ascii?Q?Aax+ILfvPBQFG5N3uBdKJw0W3z7iLp/ueKe7IaBIZ6GHI///LvDzB1ZjppVF?=
 =?us-ascii?Q?7aQJeSe6w4+lAu6L1Dzyglvs9i9K29h8TKyLAlxurqUa48E+U7fx3CqTobVs?=
 =?us-ascii?Q?uJBHv4ZwjwfQPSxC3NNlJwm0AOciB5vjeDwXDPuq10cwqcHv1T6P/EcdbX2V?=
 =?us-ascii?Q?8QTP2SdNJE2aLMqnZAxh8e8IF7hi9nWUlQjMRwHOESns7tOYwau7pyJ3J6d/?=
 =?us-ascii?Q?+QvkpFPy7Dfisv4QLdy1WDpipQvLlvV2v2YmAfu8u1zuLGYwF6vjTfXrQ2Ws?=
 =?us-ascii?Q?kxdGuE5HqGaGj9wKCzBHa5AfhHY9nejzjzmfDMYJvToN/RrXcowRKevoGb6A?=
 =?us-ascii?Q?5EZ2f8av83CoeeQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4MyADKIISlaCMGFzEP9dVg4z1/5M8hypl3ZVexjF0lCUkIk6risqJcZFOfGD?=
 =?us-ascii?Q?/NhM9WJI1HTIHExT9dpHaRToYkS573OAyp9vjazvGO9fc6QoY0/3Q5l0koTx?=
 =?us-ascii?Q?m7PoO48t2aJrIF05BtMSxVn89xucnZD/GfLvlgsIlBr8MJ4K+JoBnfkEvRx6?=
 =?us-ascii?Q?wb9RKVIhzD1abfGYIiS6Me2PoqgZB2ETijoTtdl4S3bc/YhY2Gd9YePjaThI?=
 =?us-ascii?Q?JtKAk0s0DSYJP1PHHBFKeU2DRM6+TfWGBKO+TCt+cPCP8Q9/mZYoSCe8B6lS?=
 =?us-ascii?Q?ZIZN599y6fcnwPbf7q0gZe3PQ6bM5DQstK3inzzK/9JRgcFXwXlV/Tsm65cl?=
 =?us-ascii?Q?AnuVjaMxTboFdH3kunhADxTJ+j5G59OLLwuGaWw4lyHRyGR9GHSnx1MU/yxo?=
 =?us-ascii?Q?RwWt7tx6es42DrSFH+RJ72ff1MivGBAI6VcmvKEKY5tTMmCE6xpNXizJJJM3?=
 =?us-ascii?Q?/nL6Vk/wTUF2xhDnFgYg3MJcxjv5zF0J0uS17k4muyIRDjqX3S9uJ9M7lW1y?=
 =?us-ascii?Q?XhczJQ42nYMLAKkoLoK0hEov3Eqd5gAipGnsclo7w+K3BgEWyFje8lda9Y8S?=
 =?us-ascii?Q?gwJ9DNGnyovwUOmRlbaeSJtSBXHn6ZaRyM3FeERxmRxzCmdxj/XSVDBTYVrM?=
 =?us-ascii?Q?1w7hZO/VcqKjy907MZ1RuHUSZqt/L5cX21sWQP+dfKEQoO+AMC/dJ+tAC8S8?=
 =?us-ascii?Q?V1oFD61s1PUEDQtdNYazGBgrzTO6feCegY1OnAoVE5oj1SyO/FZsXHiT5oiX?=
 =?us-ascii?Q?OsWtfbUVkiCar+FbvWlRxSz6Jf3OxesvVvWxs0HrPpu9Zs+/pwOFxvzJqALL?=
 =?us-ascii?Q?e1+kxFs/JKOPBjaiV/xGNCdqb6nxtTWCJRz8vI/ulilUp1a7ZJ68FOo5B0qE?=
 =?us-ascii?Q?bkAVWusYJjL20AvpigCoR1OYGSDsvz7zjC2enMfX6AEt7aQ+bomdIGqPVYGI?=
 =?us-ascii?Q?Is3Z/bpJlzQGfZh0SYpcF+uac+41xudwpcXQShilwSCnz1kCOGKhZloYeviy?=
 =?us-ascii?Q?LPPz6W8oM+urBOBIscpmheE8U1zXClWl6inPVH7ULWHnrcTr3WvuYH6iARGw?=
 =?us-ascii?Q?EeV7pCc+ancgUozzZQOnAKrhItz6b6YVfghUqIssIwq8CedYVuziPrFlFVcB?=
 =?us-ascii?Q?0eqE4fCo9lYDGJ4A0pGRHdJ//GHlzjLYneioeIenXAL7li8mcoxEFiZHiULL?=
 =?us-ascii?Q?vMy2svqcXHoRwTo0qtFn56DiuSXm7Uv+ysgfG/Yx/5CKm7rvi8/lXvpYw1mA?=
 =?us-ascii?Q?VdnYbgT8xjIuXGiOHV9JjV5wH/8ZUbCMY3MHalrncQ6HdXf47kjwLk2a41JV?=
 =?us-ascii?Q?jt9UEd7Hu9S/JZx2q0FERljWELMbjha+ZOVGTu6oDZXFFO/dcGp/gKEFf80t?=
 =?us-ascii?Q?beM8+jhYOsApXczQHtqGZ8wKJAHxoCYc44yp9bUuzpHzQVzJExd3xyB5F1NT?=
 =?us-ascii?Q?RU5siol4Q8Qye4KHNScGyYmTHXGn3CnQ+x8dcBBmRcGyU03oMCYtI7nCDEft?=
 =?us-ascii?Q?nW18WjIflFeqhAW2z2T+lSTFi/6IGeJmr5W2OhmaixhA3i5VKcADj0ACqSVh?=
 =?us-ascii?Q?gBgsnZW+a+pENhWgA7pQk1VgdOWW6GVJ+guOZOzPxqmx65UZjee3iWqlkVKQ?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c38b49c-958e-4837-3a32-08de2cf8833d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 14:31:40.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB9pyAL1FOiOovc3lL1rCskHrqU+ja5ksy/lh7yhZYFuTTbcWRuFNOGr8LYHUOxploeuA6mcbKTbt0oftHKjlE1S9lVjUkzLf9LKNN67KmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR13MB7519

We have workloads that will benefit from allowing knfsd to use atomic_open()
in the open/create path.  There are two benefits; the first is the original
matter of correctness: when knfsd must perform both vfs_create() and
vfs_open() in series there can be races or error results that cause the
caller to receive unexpected results.  The second benefit is that for some
network filesystems, we can reduce the number of remote round-trip
operations by using a single atomic_open() path which provides a performance
benefit.

I've implemented this with the simplest possible change - by modifying
dentry_create() which has a single user: knfsd.  The changes cause us to
insert ourselves part-way into the previously closed/static atomic_open()
path, so I expect VFS folks to have some good ideas about potentially
superior approaches.

Previous work on commit fb70bf124b05 ("NFSD: Instantiate a struct file when
creating a regular NFSv4 file") addressed most of the atomicity issues, but
there are still a few gaps on network filesystems.

The problem was noticed on a test that did open O_CREAT with mode 0 which
will succeed in creating the file but will return -EACCES from vfs_open() -
this specific test is mentioned in 3/3 description.

Also, Trond notes that independently of the permissions issues, atomic_open
also solves races in open(O_CREAT|O_TRUNC). The NFS client now uses it for
both NFSv4 and NFSv3 for that reason.  See commit 7c6c5249f061 "NFS: add
atomic_open for NFSv3 to handle O_TRUNC correctly."

Changes on v3:
	- rebased onto v6.18-rc7
	- R-b on 3/3 thanks to Chuck Lever

Changes on v2:
	- R-b thanks to Jeff Layton
	- improvements to patch descriptions thanks to Chuck Lever, Neil
  Brown, and Trond Myklebust
	- improvements to dentry_create()'s doc comment to clarify dentry
  handling thanks to Mike Snitzer

Thanks for any additional comment and critique.


Benjamin Coddington (3):
  VFS: move dentry_create() from fs/open.c to fs/namei.c
  VFS: Prepare atomic_open() for dentry_create()
  VFS/knfsd: Teach dentry_create() to use atomic_open()

 fs/namei.c         | 86 ++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4proc.c |  8 +++--
 fs/open.c          | 41 ----------------------
 include/linux/fs.h |  2 +-
 4 files changed, 85 insertions(+), 52 deletions(-)

-- 
2.50.1


