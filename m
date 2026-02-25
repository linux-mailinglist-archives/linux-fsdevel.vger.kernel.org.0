Return-Path: <linux-fsdevel+bounces-78362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gl9N+/vnmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:49:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEF1979A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FFD2304C612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B163A63EF;
	Wed, 25 Feb 2026 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="L9QEmpvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023103.outbound.protection.outlook.com [40.93.201.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF723D291;
	Wed, 25 Feb 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023734; cv=fail; b=BU8blrlDguxUsykMEYkm8zmBJPignDMJKl3Uk+aPnCTS7+k8F5hJPPzh0MyR/GyxjBsI+KGS587CSH+XU7dYNQejvFXlydZrWYzls5ETw+3c+p11JCSUNkpsLU0PUldnxTxdHAzqEv6pXcj/5X5gHfpnF8jJ6LYDg6nDYGZNAYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023734; c=relaxed/simple;
	bh=Pfwv5bV87Am7Y59Qj23XjbMiiVNOAuO4/7EP9Vxqn5w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cuFvlcWXtwVBicDJC8NmZutf1+ebyTL7erQnmVjPbPXDKpS+2zITZuIMPmG+4DdHWbaIXkJZ1CtLx6R2QYLUZnIdf5tsL5vKCu/etuIhMrvDOWoc7pE/owKhH2nueCO+g1Qkhj2FqjqMRGJ0tkqijPX7yagXU3LiNH1d+htqXKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=L9QEmpvN; arc=fail smtp.client-ip=40.93.201.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwQrow1FKdyc5/VH0pptiZEhqdgAVVMIjhca5n/juBCkPr8FgXcYQd3dCxJvOv3Qb28QK3kWRx+iXOA97zLsHjKk0pkm4tv+0bTCLbnKZs3qX4usVdYljyfwGsYIReMBgowApx0sttMalqSNYwHfYJGXGok/VObJVZNV0e6jfmHWRLjPq+GLpZSYSB54Tt0yiyYzOSFWPdIXwbbMgKH1zM2undkNpSl+5bjXUej2jN9PocxSbOwO5zGjopKIJisPjCwV9nOMdm/quSADQVIib6neHLAfYBv06nsxNXl/XPNznfZhEX+0rVD/IzQpOSCcPFrHOglTyM8Jnw14msSq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkeI5jkkFejz48yN6uYjWP3zvvkxC2bWqm+FfACFHyA=;
 b=GwjXpmxNwU5Y6zqKz6+XfNAjTC8SQsr3Z0IOpxjfbEweLtT2GjPM24qUUj448oL8OWSNv95yZzsYZjMnG99ZAgnLcvgZpSkkuCC4dMVmrqLiGLv1rxABnpEVK5sBuCTxAp5VCrWflOJxwqFhHXFDoKXUltb4jbuQ2niBQoXArUP8v3nVgPwo7Tg+hmQtXu0vPXoBE1HiCzT/roQcCBxvWs76oZf6YWDsgukCF2SFYawvtrP7XeEKuNNqrGRBOu+ctcKwLbg0LAs65WKmsQeSbEkxs/BHGthMX+tBmK0pAQOA/QxYzUj9TCuQoVXvxYtLyW37dJHpO22y3al3tBb1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkeI5jkkFejz48yN6uYjWP3zvvkxC2bWqm+FfACFHyA=;
 b=L9QEmpvNNQWtliNXjTzISzPEa6WvIFL2gCH/+PF+d0KfOgeAGxffkx96qef065/wcjZQ4YRZHYid1Y6CTsxTmoDZVlW4HN5RUoSKm53WvKOVesCrl3Jh21GCYmmPa++F2w2f8Dsu9bBSCFDKHd8GwOFEfGXpY7FnGA9RjcO1zB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5206.namprd13.prod.outlook.com (2603:10b6:8:1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 12:48:49 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:48:48 +0000
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
Subject: [PATCH RESEND v6 0/3] kNFSD Signed Filehandles
Date: Wed, 25 Feb 2026 07:48:43 -0500
Message-ID: <cover.1770873427.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::13) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM8PR13MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e56291-8b64-42a5-fb58-08de746c388f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	30syvuPPSVoihRa6EB4vAr+DKh/r9IhPIg2TSHqIjBhgESbtBcJX24ia5KTOpxBKrCxSfFLUOxYLjvBDywST5V8O6S7w/QN/XvBC0vzp4hay647Hudj6jpUtaqhV9OQLqdw8eHYU2ZOlySnqQSS8ghDr6WIF5RAicKdom8KaSsW5gQb40tA0G9D2Pmvmwg9iLn2GnJnYGv4bh3+qyp6VFIRtRxtoOA1OIVlMsJ/cPj0bMuzMzpCLxbVORPfPAoY+T3WRc2ZT6OxKoWgQPziBvNxbzkhkHE7riYHkHYAbenAjIn/Cdw9m/3zqwMql8kuZ9L1UeTUNswOkle9hL2tE9ix1ygZiGFw9y9i/HC78Dlrxb/hX16WApQgR/y/eEehoZ0qSh4u8lGYkKHTvNAnugqxILI2BhEa+01TEIV80OxRe6RBx/JC3Fae+OmjMDi3fsYYIij+PjjtcrDR7G/fSP2Z5u2CYylRGluJwmKFVPnNc165ca7i4f7a284icko4p9KHXKy8A5LqnwVKIvBrpAkmHB8OJ1rTuWbbELfwl+8dlvMdaBRdtiOliz+L462lVRfLiL0X+99FmslI6VnUc+ENwvSqGAIYSjsP4QxST7oES/6hTmcZ9sTtTGhFhp4qoJWVP+v9eQraMlGgsfusadwFdtW2ipElAaznz5Xrf2jjiN8NI6eHhfceCLqbNeDLBxROWGoiDig0tybWgCgUgW20wKYM2KbtRLg9Sd+LREIE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lvSE1xaafFoWHWywSfMS+qscv6NmNhJnpoLlgcMlVWKKk4UmF/JWZJlIqu34?=
 =?us-ascii?Q?qu3BRK4rLWlRw2s54GELY6rtMFz+fl6WQim8vx2VkCd8xMujexuyxSxji6j0?=
 =?us-ascii?Q?+tkL9/8lsmNojr1wl+UwbF81eSzPht43mEX/rSMUtW4QKJo9D15GDdj8wkPX?=
 =?us-ascii?Q?Oed6ohLOUF1vlwomvlRmHkwOChTe0fRBgxuTVbCa6V7hsSGX/KsopRyXxpNI?=
 =?us-ascii?Q?1am0+RVSmp+cPtgdOofgw/LHK/r0GKjPvqFD3ZkrSzmx+mk5qc1RlJ0OivkW?=
 =?us-ascii?Q?5BZdo43zPkbXEC7bhd8sPJQB/QkhN38uD/1tDjL3SIisyvDoTbkVP9UeJTTE?=
 =?us-ascii?Q?yczLbkamI7WF5Xqm/nAen2xGB/s4BWwGhAsFfSNRW3vVaKOvve27+ZcHAr4M?=
 =?us-ascii?Q?k9Rh4CHDwFxeysT2k9u2/UvJmQY6FSSYED5cMyYZHdprV2e5MuxfyILMFhjT?=
 =?us-ascii?Q?cvm2Jpav/zeE7iL4WFCOBBkzIToC8lBS9h/GCqV2wAQAQ5UfqQ/uO5yxd1NK?=
 =?us-ascii?Q?Utj+BpkJNKGsG04rWqWkkWwtZc7NlcJGpHJoLTucAxyI0YyrniFwyoCS+qvC?=
 =?us-ascii?Q?8uBa/RNyK+Oaojb+s7IGVMJ+xFvnGiMuJZLiz+EfUdtlX8KKPBK6KWcx4Xe/?=
 =?us-ascii?Q?wQ6Liy3Ev8NGYz4TSHkSCoTBH0m9syl65x0s+zPzcQZXK7ZS0FfLSBZCnl9M?=
 =?us-ascii?Q?3VxUz+lWiDmz6vwaPxDAjqPMl+ECCXCexqhxAdwQwJTo7rZDtUuvC1yfj6E3?=
 =?us-ascii?Q?p4xQZKltkZgVHQSQLaBix0i3X6SaFyofCCUNXQCmxb0FZzCjaDJ+LbOFV+2K?=
 =?us-ascii?Q?cjCNlGAOdvgTOlrq6wGXO+Zw4u6QoYAMhFvgH4Q59/9Isem1dvf/5lTcdDY8?=
 =?us-ascii?Q?T3oFh7F8TCqHDg5zxCIq5cPSMZRCPMDUYHx0zk0aTdPKM5EEUMpG97FzoVeZ?=
 =?us-ascii?Q?b356iHWhWF0pQNh+28YQzmZ0UzZ8xiBWwHXWx2fsmPe/jEgAA9Ss/wcrNeec?=
 =?us-ascii?Q?QPhhqtjITTKyTrnvGimu2glQHyR0Hitz6I7lpZSxzAaxMJMqslN06Ds19nlq?=
 =?us-ascii?Q?GQMEwO897s+j3Y/X0KsnPdGpAHu/34FDNoFk/ZuBNQX6cT/7v8RkXVtq8NFB?=
 =?us-ascii?Q?8bM7Fdt3APjmhd4tU9Mqfy6Nuu2WbiquE8GTtGGg9SllwQsne300jasdx5wD?=
 =?us-ascii?Q?W3bumNY8roh+a/Ma4e+CJyZZGn3O9VbUmDij9oulPQGl/sjZF0NERMLzj5H7?=
 =?us-ascii?Q?OC6aX/DcK63QyFjoCEbJid8p7m/sc15NIH4PAr3q1MK9kLal4BYsgLxYamxZ?=
 =?us-ascii?Q?VJICImique3A1TUi+sGRaspAtmttLRpTkqZP9cUpu6tbZqMoxs4071bftvsc?=
 =?us-ascii?Q?H3Okz95rkrLNt+Kte52v2kSZZkP4AT+EazPkKLK0c+zASZh/fq15dV2/Lcf0?=
 =?us-ascii?Q?J9F17Mgu6V3e+TDCAXCqPD5XZgQrgIGfdZ6e6fAQoB0wxjTYxZcnAQZJMCNG?=
 =?us-ascii?Q?Y/A9saXBNnj6a1ECJoz5vACtuDaDDtn5iPlSSrT4dC+LXH6hNQjckbd7ROwD?=
 =?us-ascii?Q?BaOuVvUh/URQ15FhGCWSmQDWN6fp0uu1gLiwjoM/Xxv1gz5JvlQgq06Eqiek?=
 =?us-ascii?Q?6BO1AOmWEJxztTOxsE2qWEi6BxModRowU6Yx9971JinclKrAyqUWtECw4myx?=
 =?us-ascii?Q?lZdUzbanHq+zXfeBzWaQsidPdF+zvKeocyD47latNXOLos0+j2xRE2gv/tzW?=
 =?us-ascii?Q?LQCRr6X22L0ZJ4WCi1ip0JKzMiE0TEU=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e56291-8b64-42a5-fb58-08de746c388f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:48:48.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHpCEGsCgtlMW9VkrflVf9QoFMMuUrUO6Kc4m4ZdEicdHSBnnM86Pe8nx82VFPbyn8B/iTVqyPWXKjceDJnZqw4Q6vYkBGHLq/zOdzGlja0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5206
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-78362-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 41EEF1979A8
X-Rspamd-Action: no action

The following series enables the linux NFS server to add a Message
Authentication Code (MAC) to the filehandles it gives to clients.  This
provides additional protection to the exported filesystem against filehandle
guessing attacks.

Filesystems generate their own filehandles through the export_operation
"encode_fh" and a filehandle provides sufficient access to open a file
without needing to perform a lookup.  A trusted NFS client holding a valid
filehandle can remotely access the corresponding file without reference to
access-path restrictions that might be imposed by the ancestor directories
or the server exports.

In order to acquire a filehandle, you must perform lookup operations on the
parent directory(ies), and the permissions on those directories may prohibit
you from walking into them to find the files within.  This would normally be
considered sufficient protection on a local filesystem to prohibit users
from accessing those files, however when the filesystem is exported via NFS
an exported file can be accessed whenever the NFS server is presented with
the correct filehandle, which can be guessed or acquired by means other than
LOOKUP.

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

Simple testing confirms that the correct generation number can be found
within ~1200 minutes using open_by_handle_at() over NFS on a local system
and it is estimated that adding network delay with genuine NFS calls may
only increase this to around 24 hours.

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

I had planned on adding additional work to enable the server to check whether the
8-byte MAC will overflow maximum filehandle length for the protocol at
export time.  There could be some filesystems with 40-byte fileid and
24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
8-byte MAC appended.  The server should refuse to export those filesystems
when "sign_fh" is requested.  However, the way the export caches work (the
server may not even be running when a user sets up the export) its
impossible to do this check at export time.  Instead, the server will refuse
to give out filehandles at mount time and emit a pr_warn().

Thanks for any comments and critique.

Changes from encrypt_fh posting:
https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com
	- sign filehandles instead of encrypt them (Eric Biggers)
	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
	- rebase onto cel/nfsd-next (Chuck Lever)
	- condensed/clarified problem explantion (thanks Chuck Lever)
	- add nfsctl file "fh_key" for rpc.nfsd to also set the key

Changes from v1 posting:
https://lore.kernel.org/linux-nfs/cover.1768573690.git.bcodding@hammerspace.com
	- remove fh_fileid_offset() (Chuck Lever)
	- fix pr_warns, fix memcmp (Chuck Lever)
	- remove incorrect rootfh comment (NeilBrown)
	- make fh_key setting an optional attr to threads verb (Jeff Layton)
	- drop BIT() EXP_ flag conversion
	- cover-letter tune-ups (NeilBrown, Chuck Lever)
	- fix NFSEXP_ALLFLAGS on 2/3
	- cast fh->fh_size + sizeof(hash) result to int (avoid x86_64 WARNING)
	- move MAC signing into __fh_update() (Chuck Lever)

Changes from v2 posting:
https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
	- more cover-letter detail (NeilBrown)
	- Documentation/filesystems/nfs/exporting.rst section (Jeff Layton)
	- fix key copy (Eric Biggers)
	- use NFSD_A_SERVER_MAX (NeilBrown)
	- remove procfs fh_key interface (Chuck Lever)
	- remove FH_AT_MAC (Chuck Lever)
	- allow fh_key change when server is not running (Chuck/Jeff)
	- accept fh_key as netlink attribute instead of command (Jeff Layton)

Changes from v3 posting:
https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspace.com
	- /actually/ fix up endianness problems (Eric Biggers)
	- comment typo
	- fix Documentation underline warnings
	- fix possible uninitialized fh_key var

Changes from v4 posting:
https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com
	- again (!!) fix endian copy from userspace (Chuck Lever)
	- fixup protocol return error for MAC verification failure (Chuck Lever)
	- fix filehandle size after MAC verification (Chuck Lever)
	- fix two sparse errors (LKP)

Changes from v5 posting:
https://lore.kernel.org/linux-nfs/cover.1770660136.git.bcodding@hammerspace.com
	- fixup 3/3 commit message to match code return _STALE (Chuck Lever)
	- convert fh sign functions to return bool (Chuck Lever)
	- comment for FILEID_ROOT always unsigned (Chuck Lever)
	- tracepoint error value match return -ESTALE (Chuck Lever)
	- fix a fh data_left bug (Chuck Lever)
	- symbolize size of signing value in words (Chuck Lever)
	- 3/3 add simple rational for choice of hash (Chuck Lever)
	- fix an incorrect error return leak introduced on v5
	- remove a duplicate include (Chuck Lever)
	- inform callers of nfsd_nl_fh_key_set of shutdown req (Chuck Lever)
	- hash key in tracepoint output (Chuck Lever)

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 Documentation/netlink/specs/nfsd.yaml       |  6 ++
 fs/nfsd/export.c                            |  5 +-
 fs/nfsd/netlink.c                           |  5 +-
 fs/nfsd/netns.h                             |  1 +
 fs/nfsd/nfsctl.c                            | 41 +++++++++-
 fs/nfsd/nfsfh.c                             | 75 +++++++++++++++++-
 fs/nfsd/trace.h                             | 23 ++++++
 include/uapi/linux/nfsd/export.h            |  4 +-
 include/uapi/linux/nfsd_netlink.h           |  1 +
 10 files changed, 235 insertions(+), 11 deletions(-)


base-commit: e3934bbd57c73b3835a77562ca47b5fbc6f34287
-- 
2.50.1


