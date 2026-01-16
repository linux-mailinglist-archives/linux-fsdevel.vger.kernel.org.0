Return-Path: <linux-fsdevel+bounces-74127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D0D32B46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFA5311D271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EC9392C4B;
	Fri, 16 Jan 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XkhZxCJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022142.outbound.protection.outlook.com [40.107.200.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6913B293;
	Fri, 16 Jan 2026 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573946; cv=fail; b=WceRb7HnIkeB2UkcS0Ye+BJOqWj71sOiNM2QdeDppYjnHWlJXuJU2EYjA3QsWf7xKgkJwGfm17hgJrLWzkmlJjVGhs5CmVNHNem0YOglW5HCzGcXhKmqAJXzdRvM5VFMwlz8Rl5smBL0+pFUG7KNXMhQOZ/3KoZsCWh7tqUIlBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573946; c=relaxed/simple;
	bh=+P3jdG6oedeQzFmsvLlc4BCnnISylb4RUVAlrouawec=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sx0iMuVopJvMQOxxdFUr9ZKeN++ZgxqJurNFfU1Dcnne3mqkfN97WZIxD7lcqPdslqGs0FSRueUpP8FxwoopIrU48CMhRuPEKXUSP/IMTGW/6is0ygpmA/P1VEHxlMOlUPHO0Qrhm9Rbai6CL7I5QzL7MIz98Jq+tfqtgZo+CqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XkhZxCJC; arc=fail smtp.client-ip=40.107.200.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpOrsS7R8iNudere5ldRRGtXnORuksAnW4N6LvANkkX+wStfQ0XeInt4SH9y6kfn4W+c6PoPAHwIweZb2Hg5iH/wnl3NF89QdZJ8eKtjVeKQbqF5DcJVQRQ7bzkM620gfHF9q94VXOyHeNIrB1ogXcnU4upotuNrm9CT8tU2h5NaaODmxYE36daDDf/lXQMQeOztHcjENISZVc1y9pD+pmsjlxUSHBVVARlTgr0jB2/oA4C1rD37YhuqOVt749PP7FUswKmUBM+Kz3Izdc+6Mi9HLYnvnBy4+ZVpn/UhQi6BVkQMTSaPEfsaTWpPaWNZqDb0cQY/24ID7KEZ1FJySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lWnzUk/g6u2AcySFDZ2TN5jN+E0ZQtMEWgZJpe6uAw=;
 b=K2rdSwm/DC2KZBJYcLMmYi7aKwr3jIdcNk6gT9F7veHWvXBtSGxEJI/1JVSxxW14/++rrTWZh0Sg7cZ4pVj1lJHfyEigc8PART3e+qmyEwNkA2LebqFni8wvOaqA5HDDUOtug0qKvU6B50ZYz7WA4CLY0y9r92p4I3F61Uvas+juf/xyJHIWBbvny6ObvNZDN1PXVnOEhrYJKvvPQiaTXtjcVGkzf/acKPGh6NSJzvBYwSQLz9t5uVAYDo9h8GXzVCHNpocWnANYncOfg/auYgnkr9KWx+u67d4lPFvhSK0sOBXh/tIomqOhU5BNBhWWkFF/SGAUWWPaROzghG/t2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lWnzUk/g6u2AcySFDZ2TN5jN+E0ZQtMEWgZJpe6uAw=;
 b=XkhZxCJC5y87kz2rIT71zGF1NBJzNye5797/lZ0oZtTw5VWOYrsZ6tHnexqSX18qnoVO7LucPaxTTPDSlVqhsg3p6n3iPvOcQs4a9caUCNkhaGSaNLEBjPxB2bBBKjPcZu5WgbCFGP62o+WmmpD+jm2TgX8iQouKzlmaHM6gFDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH0PR13MB4716.namprd13.prod.outlook.com (2603:10b6:610:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Fri, 16 Jan 2026 14:32:18 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:32:18 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v1 0/4] kNFSD Signed Filehandles
Date: Fri, 16 Jan 2026 09:32:10 -0500
Message-ID: <cover.1768573690.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH0PR13MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8e57b2-e5c4-48dc-9875-08de550c0d1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fg9o2gvNjlU+6u9Eyud/uQrMjvIZk4fttdq3YItgL6m7HYPN8FOdw/2Nsjnx?=
 =?us-ascii?Q?kJBN1GNnZnjbASCqCcHNJOVJCu/KfRxU1UuQGwx+J0TfVPSvXmLrudwp24+S?=
 =?us-ascii?Q?qHh0lfb88QtcwcGdzOoxjnfpkD68QGMdKL/7XYUU0HxYKmwS7fwPq9V8ot8r?=
 =?us-ascii?Q?SF3CStspQX+1FjMoa13pjeQifctoy3c+ZLin0EuYfFwRktI3pfoQBCSJRoji?=
 =?us-ascii?Q?SReUBDHEa04JyEnI7tYloSd2Wi0D/2VNw/KTOler2MKpvmN/U6XKi8BTSKOA?=
 =?us-ascii?Q?d0ZbYivDl3AvBwXw7vxuxSwHbm2v/aJybzYQmFSqHOp64mOrQqTgZt3rHjP1?=
 =?us-ascii?Q?MGB1tYWyU3nYuTpZAEpR1vK11BA9VcoQQOMPlo6JBBeAu4ZYYb6ap5n6r8rx?=
 =?us-ascii?Q?5kTWPMMv+1fVr9KSuJHobK+x+XEk7kmCPB8LstLtAVt7bWy7+slzHC1Z6gmS?=
 =?us-ascii?Q?fMWACHaH8i9JgK8IlIKgL68nUNAQxwmYzwzF8KN52zTjU9auNriOYyFFHX0j?=
 =?us-ascii?Q?0wdngDyjNGAAPR+ViHYYWJNO3On/f9Ces8BzY4eQJzkNjU5NiFmu25oSGSlo?=
 =?us-ascii?Q?9XyCf5zBazBq3/38sf5jdMeicHpumCRez5eUcCk1z8+7AMjCdZhC3qJkYEFX?=
 =?us-ascii?Q?hZF6HZrYwivwTxSaayYnTw4P7RAItH3+JzO0f5tP5WbygGDkd7A8XhXHwrYF?=
 =?us-ascii?Q?yLAtD6KuwTVfX+D4fEGReXSCHWiMsdIijNeUn1hyyoyrq1vMVyfKQGjxaRBy?=
 =?us-ascii?Q?jp3pU2pxftsuhk6ZhYP+okd+AzCTOU5UFt5ZWxq4NxVBAhxnWY1uYVX7Nadj?=
 =?us-ascii?Q?grkkzeX5ZQ+1BPN7S77E753QzsNUn+7Iro8N9FHf47AIe12FUM4AANzqD1x6?=
 =?us-ascii?Q?BaZX18pHOP9E73yqlNi/wGsriatGbdpGrED0ZqCjGEbpxuUt2BoxbwR+hHVW?=
 =?us-ascii?Q?sq4AHrwaBCvqSQ5bHOuvYJAePnh8hTu/hVRH/A1IcKczvJxPaafVsCxCl/7c?=
 =?us-ascii?Q?X8zpiGAzHx1nlAvaO+1DA/pQzPbyLgGhIXaZ621k7nqXc++YOL2WLI4Kc80w?=
 =?us-ascii?Q?3OvDNPHdd1oh4xC0/QoAvaMEaX5fTyazELId04x4YRRz6JtvCSX4PDew5Ak8?=
 =?us-ascii?Q?o6jU9s8FVmzTf90A0oo8WzFme2bZOOdjp+mnfpOB4Dm9EfP4snMpBC7KxSKv?=
 =?us-ascii?Q?IIoVG6jPYsu7Ywq5KF325IVaJc0m/c2/wZJr3aDWMTIOCVGwgsjNih3tu4Kj?=
 =?us-ascii?Q?IaUxw/zttC73T+bFMUgKKVbwz5pGd/MHNuBQqBTgosq0hpP7EURrjwEGWEG+?=
 =?us-ascii?Q?TylWM3O0VpHy+rhH+MmL3JUy+BIKLUL+OdXng2zcZihJs2d6EyjvVAewlY4Z?=
 =?us-ascii?Q?GzWlFYA7D20yxUDDqVQgxKcBXrL9cGGbo4yR2q8XLYFgk/xuk78Qoh8ATX/4?=
 =?us-ascii?Q?4aQXQ0gMJ26OY0Lq08Oq6RYM2Fm2TIS5VNZn0m53SgNFN/ke8e2312peA/Ja?=
 =?us-ascii?Q?dIv5RQF4lPbJ3wMbTw1hr0UH5eApExacDe0h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yuetZRzfAysHxMyEMNBvvWH0QF/2uJ6+JHZCZGXasrXcWk7nnf17nFVspBOm?=
 =?us-ascii?Q?t00v5hzw1oGf/u0Uaaf6Q87wrbjITsFrTzprtgb+cpnRw+9I4JwO5Rc/PNFA?=
 =?us-ascii?Q?pqKa1CnH+z2XELzlhunxlC4c/xD2rSvijNMvDjockfcwWr5nAn8nB6YDMzjq?=
 =?us-ascii?Q?hUC18kpFQaTpQfa9kcMbXlomOnlnGFn5qf6vaJ6NYll/PlL4OsBWhG6gtl15?=
 =?us-ascii?Q?Vc5gWtVu+V9QCDPMRlf/i+J6tB7HPav/HwyVcvOE3LreqfoW7tp8QBSNjzRG?=
 =?us-ascii?Q?wqp4Jo/M1TqNyli5xy50msyGw5O2zjIcXa2XttPN+si4u8mnNtTi3x3Hc9kE?=
 =?us-ascii?Q?H4SRnr0rQPcnNu0JIoDh/EmXhUm+FzJw3bWaDV22NvsJd15LC1kPUUKju1g+?=
 =?us-ascii?Q?f5e8dXAMKO+tX0txYVAnoxGgPQlDQUbGabElHaC8sh4TkHz464sSGUMgFvkj?=
 =?us-ascii?Q?YtyZw8PhfbW+TKn9JfXvPrbbVlgujvOKxFtBiFABH+1OVNrzEbdZ9+dY71Ow?=
 =?us-ascii?Q?id9qM4tkVOyy9sOWUDvl7KDYYaktDL3awB/mHbVkllK+D9HKB8pJv0vq8cvQ?=
 =?us-ascii?Q?+jS9KcWxtKuLlM7wSTLO9AROe76wFw22YiELQ2Slp8hS6dy2+y0YuclOAdpH?=
 =?us-ascii?Q?mtV9jQeJ08yjhSKhRPw/cH2cQuWgSMhEECLAqYKJuArtr0CFDpOuIMfZlFsd?=
 =?us-ascii?Q?mntoSHpamLY+ahfWFVxyba54hG/wtjHGxCMEq3+nrJYr+MgKWKATKgGP2esF?=
 =?us-ascii?Q?2AHP0sw4Q+BEj9xwgKOSzHsS7UYiY2/oYDc+1MfzAbY/AEKCAn9XCdC2mzNt?=
 =?us-ascii?Q?mrOaDUVmjcVk19ErqkpgNEEI0+R8Lx6ywCHU2i3rPwv1IyEsc8bGZhl3anUg?=
 =?us-ascii?Q?qJ43hfcKWe/QFBeu0u880G3j+2SBgzQVoO0SEtDKHcZ+8wmQ91ixH8E8AMM9?=
 =?us-ascii?Q?Fft6AlgWMnRpPlh36UQx48sVX41oC5Q8q0dTu/cG0Sg/L3AJD3N/S3yk9pHR?=
 =?us-ascii?Q?MH5s81oS+pRZCF3FT9w34n6GDUEu6+VmdX8vpjRIDhJixUiyrMDEcESaRvG6?=
 =?us-ascii?Q?bsKYodJHSUSJUUOjNq31qepqZwmdvOE1lbutKNH+co7SDSCDUL9dr+psv07Z?=
 =?us-ascii?Q?FAs/wq8ITDrnXI9fi3imIinCZLjo/JTufGNd1vLvrlpzQWCCY1ut4Ie/++2P?=
 =?us-ascii?Q?F20mtaf5BVQCIg9BEmp4nCEJXCsYmF4+3a2wdoDBkCxgtXYBHDMRi8JctKmW?=
 =?us-ascii?Q?DLfmaa9Na4T3Rgq2urFQSIEWSWV5Vgnft6XZhZrOITbhxTYMgPaGkdK0A1wz?=
 =?us-ascii?Q?qC00ibeAWg2AM+wrzNRM58OXEtPvSwKhWzzdo6+yU5rtTnoxRgH+o4aa+Paj?=
 =?us-ascii?Q?oq8FFyfO64V4pUiIxD65njyxPys+4CWT3aIIIPES80uAHkJd8GgJLhj9U+Ut?=
 =?us-ascii?Q?xjyhdtEa0WDYWXW6DUnaAU45GQQuzPD94HgqsNulNLWW+4soNeTmsICF03m8?=
 =?us-ascii?Q?BEtJyTrld3h0p/WNqZSbRQPygnJIetO1QdhG2nkCh255Put05Jcgne36m9ep?=
 =?us-ascii?Q?FonVsgT16hpf7fTfF+8K6NnO5CrPnB11BnBp+uOvS38DXM2Nl7gI/OfPNg3v?=
 =?us-ascii?Q?Yc4SfY/xiNOWKSZP3VZ6iFY+gTAvxD/CLF7yZiYbyU8SKbgtCaZh/wTLbpX5?=
 =?us-ascii?Q?u2foIw3D+iUMxuWRyySjUhFMWg/NbmWBb03KMeB3ksaMui9yQ33ziDVC3Ly8?=
 =?us-ascii?Q?BIGjJ8Q8liv2gbe3gjyJ98UpyOa6hog=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8e57b2-e5c4-48dc-9875-08de550c0d1c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:32:18.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTednS4C0HL4DCZSzzos1WHoScWLoQwtYWO+2BRLvyETgKLIe9BNIrAhF1RR3/iZOsMd3PE1LTA072gugE0J00TopUqCg/o8upseI7aiF2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4716

The following series enables the linux NFS server to add a Message
Authentication Code (MAC) to the filehandles it gives to clients.  This
provides additional protection to the exported filesystem against filehandle
guessing attacks.

Filesystems generate their own filehandles through the export_operation
"encode_fh" and a filehandle provides sufficient access to open a file
without needing to perform a lookup.  An NFS client holding a valid
filehandle can remotely open and read the contents of the file referred to
by the filehandle.

In order to acquire a filehandle, you must perform lookup operations on the
parent directory(ies), and the permissions on those directories may
prohibit you from walking into them to find the files within.  This would
normally be considered sufficient protection on a local filesystem to
prohibit users from accessing those files, however when the filesystem is
exported via NFS those files can still be accessed by guessing the correct,
valid filehandles.

Filehandles are easy to guess because they are well-formed.  The
open_by_handle_at(2) man page contains an example C program
(t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
an example filehandle from a fairly modern XFS:

# ./t_name_to_handle_at /exports/foo 
57
12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c

          ^---------  filehandle  ----------^
          ^------- inode -------^ ^-- gen --^

This filehandle consists of a 64-bit inode number and 32-bit generation
number.  Because the handle is well-formed, its easy to fabricate
filehandles that match other files within the same filesystem.  You can
simply insert inode numbers and iterate on the generation number.
Eventually you'll be able to access the file using open_by_handle_at(2).
For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
protects against guessing attacks by unprivileged users.

In contrast to a local user using open_by_handle(2), the NFS server must
permissively allow remote clients to open by filehandle without being able
to check or trust the remote caller's access. Therefore additional
protection against this attack is needed for NFS case.  We propose to sign
filehandles by appending an 8-byte MAC which is the siphash of the
filehandle from a key set from the nfs-utilities.  NFS server can then
ensure that guessing a valid filehandle+MAC is practically impossible
without knowledge of the MAC's key.  The NFS server performs optional
signing by possessing a key set from userspace and having the "sign_fh"
export option.

Because filehandles are long-lived, and there's no method for expiring them,
the server's key should be set once and not changed.  It also should be
persisted across restarts.  The methods to set the key allow only setting it
once, afterward it cannot be changed.  A separate patchset for nfs-utils
contains the userspace changes required to set the server's key.

I had a previous attempt to solve this problem by encrypting filehandles,
which turned out to be a problematic, poor solution.  The discussion on
that previous attempt is here:
https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com/T/#t

There are some changes from that version:
	- sign filehandles instead of encrypt them (Eric Biggers)
	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
	- rebase onto cel/nfsd-next (Chuck Lever)
	- condensed/clarified problem explantion (thanks Chuck Lever)
	- add nfsctl file "fh_key" for rpc.nfsd to also set the key

I plan on adding additional work to enable the server to check whether the
8-byte MAC will overflow maximum filehandle length for the protocol at
export time.  There could be some filesystems with 40-byte fileid and
24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
8-byte MAC appended.  The server should refuse to export those filesystems
when "sign_fh" is requested.

Thanks for any comments and critique.

Benjamin Coddington (4):
  nfsd: Convert export flags to use BIT() macro
  nfsd: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/netlink/specs/nfsd.yaml | 12 ++++
 fs/nfsd/export.c                      |  5 +-
 fs/nfsd/netlink.c                     | 15 +++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/netns.h                       |  2 +
 fs/nfsd/nfs3xdr.c                     | 20 +++---
 fs/nfsd/nfs4xdr.c                     | 12 ++--
 fs/nfsd/nfsctl.c                      | 87 ++++++++++++++++++++++++++-
 fs/nfsd/nfsfh.c                       | 72 +++++++++++++++++++++-
 fs/nfsd/nfsfh.h                       | 22 +++++++
 fs/nfsd/trace.h                       | 19 ++++++
 include/linux/sunrpc/svc.h            |  1 +
 include/uapi/linux/nfsd/export.h      | 38 ++++++------
 include/uapi/linux/nfsd_netlink.h     |  2 +
 14 files changed, 272 insertions(+), 36 deletions(-)


base-commit: bfd453acb5637b5df881cef4b21803344aa9e7ac
-- 
2.50.1


