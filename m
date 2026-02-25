Return-Path: <linux-fsdevel+bounces-78366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOZAGm/wnmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:51:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6338197A0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBB63031AD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDBD3ACEF9;
	Wed, 25 Feb 2026 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="f6cCiwda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021109.outbound.protection.outlook.com [52.101.62.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9AA39902C;
	Wed, 25 Feb 2026 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023905; cv=fail; b=EhiXkIEJ2phbeGUeseXLg5tmS2wXRgET/8krZmRBRnXgx//ACww95Fy9gGoO2+4plJKQOk8V+3Uo5eHLhz5tVg0QK/kawfWm9EqXH3mlx3t/AXjJiopmPM0Y3AlAEXL3AXS0hanwNS9BhJx/SI3eqnz4DvxoTcUDuAQin7H9U40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023905; c=relaxed/simple;
	bh=0emsP+3cICoyAPXF2seRaT5BfIaH4whaUb1GRNdRLCs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AaOOiw2WAG1x01EBl4cvKycQhfnx9JjQjHbbxf6vXlZzV0FM0ZDLpQjSuuuPYlaQ6cKEUIl1ZwiuhcDiUvP+fcYJeb2WVWOmrUg593A5xOOKYdry90ShkJWgUhSpEwsUqWsZjfPppkAuqLwM3WIHkj5/cE195JaGtkgiM9Z7D40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=f6cCiwda; arc=fail smtp.client-ip=52.101.62.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udtWRJYOd9KYWcFxd6XzmeUcCh8gVhI/ESURkU/+UKMNuZDBp9QZ32YcUjHEo2y0St2U6m1k6xPDxka9zr3Vb8BWIVxvtUEXJSaI8V6B8pNaZaIZyOl071fjvafFsqTJqF1nYWSuaG1kNQjJSbcxvsAPhlY7Q41MKAws3DyJZA9+px7VLcBEERpMIZ6FiHaxiF1UYEegGsEdaUcvftLrSwO87zbnlihm/Y2bD3fPbBWDrQeAEjm2kO4x0iCncxZsMBLKuFGFBB+bpoZldYRqFIW0d+HVRrrcLNvZTscIh8LfURJVCPCjjDybolTd4JePUPlejpWW4gvCsPrRkSo9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpe64Y0PsCpt72rPqYj1lNGl9bAaa/J2ahrRD5o9ncg=;
 b=VXjaQ+dtgRT4yo4FLumZxvhUjKteTHSPTTrKQuNgIR6WAQp57badQmDG+J/EY2b239Dq236ZcB44zkucK8OpcoLqGLcCex7zV7jZwz+rACtYnjk7H1AqkGZMNLJJeN7nVkJNKnTfNEhKD0aYdiOUQQTuYE8GazUuitTq7dQrxR0X0fC3L4aZvd6c7SVjnOMa59JXBxykCfszAlKXWOLEtxq1uI1/9AVXKdUFuodaznKZRJI5Soup2URlKevjmnYi5jRuZebFtyMidbuJZ5NdlP4or6kR0wA3t3k0B5SR31CTFT1C6+0eXACVkxk7aTFUvIm7SI3CrqwzXOvWvHPGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpe64Y0PsCpt72rPqYj1lNGl9bAaa/J2ahrRD5o9ncg=;
 b=f6cCiwdaXFX9oSYoZ0vOKKNIb63uojoCURrCPz5fZ9dwUdWElzxz62k89fmv4IbBG7r0lBKwQTJ/wnWPGOVVsjJg1Cd8Navs+iQkNJH+vR0Mi5YAo0thum6D7bN+8RPDCmbESq3DDNg6ypKvyffDVxfBhtf2z7gMA2sde29zQEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5206.namprd13.prod.outlook.com (2603:10b6:8:1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 12:51:41 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:51:41 +0000
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
Subject: [RESEND PATCH v7 0/3] kNFSD Signed Filehandles
Date: Wed, 25 Feb 2026 07:51:35 -0500
Message-ID: <cover.1772022373.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:208:e8::32) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM8PR13MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: df96f92f-92ba-4767-b79d-08de746c9f4f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	YwYHGXoARuikoTHEQyrO/vktdCQMlVLiLvWpM0uGFWKNefo7qdCiwEwxaIc8WQrailVz+0v8tjiDrfukjRQUWVJHvm4mgpoto6JtyG/dywdymmSWfAhqtqW+c21LDf73rF8RljziyR2AY5enHjHmY5egSrx369niWvBRkOO7AJn2V3ilWiIiwNMVvOXWNydw69//UPCwJ0IycCrhPpbBH6oWX+iJBFd5FG1JwbPPVFh2rJbITQU2MSFDiSTq09jhXExtaLO9rLQM1wEkxTkbppvlyo+7N7niwJB6icul7h0U1a6LuOJK7u9Y9VA+4DLL/joDaydVPBsbqZoGB9J/4HykfLFefrH+OdBMy5/UeNzwr+ZCMBKHCY393Vabv9KYDB74KBMOj1fESkj6+Pt3fGRpC5VrV0ti76KrWmTlteo/OZogfTo3sNUe2OnXU7/5Zjw+VqBYrreBzX9q93BfRml48gcCS0H6maQNARL2fr37v9AqAOkoirHYw3YjG0jcp93PEt6X2CPcdg6w15RrVQCMwZCjdti058489LJj22RN5lZVdGxP4eAaJ9KFSmP1lxLBQZakamGgZ/CWAkaJGXGwlNRJ8Gkf5gLlNkSfRTedJ+QeIcof0lE7mT/3ldCcASDZezl/Uu/0FwNqlXENVx5NzpALXWwCGqSgM2AIiBclcqulTPpTfEBWU93IT76Qa+gqSS5EhwcIztZlmB3VtelGjD03myxEIuO3Xw5JF2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIjhELjS/KuWtBarCmsckiLycEdlGlve5FIW/9NT78S32E369mmNBSk96BM9?=
 =?us-ascii?Q?Pva5lexLv3XeukxC+3dKl9qEAOZ/4uxskuULE9247fz+yp+YR0IhTojhAI1E?=
 =?us-ascii?Q?heB9tiy9pB5cq19tPMGor7FIpVdwhi5nma1F8qkDU5dfp5yJ0b9vRCCabVGx?=
 =?us-ascii?Q?yOFlkXmWzjJxspP5Q4s+aid9aWeWTdA6umUIPHM+SzjpfB49DYEn6GpHRTuc?=
 =?us-ascii?Q?HyortErdJg+3Nn//A6xO9lwl+M2wpx07dNXdxi6ow0Oe9KTTrasq0ZQ1V9nQ?=
 =?us-ascii?Q?iBnCVrnFpZSJLgtRWhIarrrptEA+YIDvX66hieJl0+2t7+RMrq9e/HhtWvKF?=
 =?us-ascii?Q?qd4t5e0AdlYt/OVFyzWnp4aikU8Vumhj09c+DVYyEVIPVv1lVQy9A32piEwr?=
 =?us-ascii?Q?r5nmedlsU1l2b7s85UpPBuhC3xFDKb5QPfxAjoZj7AbX1au6A8AowxnlLHEJ?=
 =?us-ascii?Q?lfpFGKcIRR/ViBl7o+nOtkH8k1THbjZ4tcOnIrzTDPXzu8UOmt4Hz8k+j5Va?=
 =?us-ascii?Q?k8GLKY+FFuDLY+WezC3OOP4ncFZmS33B84rkmusq8BK7CPwO/jIOrgBkbduF?=
 =?us-ascii?Q?fS4/LLTe5uwKy+mzGQY/2pNM8WrrYw7dlCbL4Y0nAS0EEskh6r8ASg7Sam84?=
 =?us-ascii?Q?t+Ty2YZH0YeD+tyWQ5R8nLmu27u/E1ShmMWmgTe3OjDd8D7samK3WGPbppC7?=
 =?us-ascii?Q?PyTxm8f9yEu36t6ZJdS8M9G0RYkSjZfobvvMOn1Uk0VQDpLoMSJcs+Vl4Nv2?=
 =?us-ascii?Q?PxDVZWUULVvJliMdAOHM/W4SWWS4a7y+vGhrjlXsNM0KAaTxKbX1Qekn88oi?=
 =?us-ascii?Q?7SgUJLjh0dTLC+rQbpYmBHkuYW9LP+IN1naoGPmAPPWZo1h564t5Je/jTk9L?=
 =?us-ascii?Q?eplUwivqvUGplo0xd/uz6tdyTZAa/fL34C8q6uZ2cjjkF8ukYVJxl70XCTXd?=
 =?us-ascii?Q?XiKl0FavVc8rJ3hiRFN0qrkDNxYg9UXqHVomrvLNHb6X1XQPsWXRN0qIqNL+?=
 =?us-ascii?Q?Y1oFzEgJkCwPtkfQXWWqxwghjZhUQBgXW3HE7OD+NRkXmDteCsV1KfsfTSGy?=
 =?us-ascii?Q?CGPN0vyTAlCGDqmyHX+5a3IuKQtdoJ71fBf9O1953u/1Mxdmz/IFWiVuumlp?=
 =?us-ascii?Q?fF6qF1ow9fvy2iICSdULNtFiHarMeBVOOOEY2CkXcyUn8diJZVkwHh9Q7sPD?=
 =?us-ascii?Q?x+bLw6NBnDfuKDY9x7PCudUBZishyLa206aOBq/dXvV9ritf7e7nrkQE1rLD?=
 =?us-ascii?Q?WwZ9PrCy1+q9hf1cH2z8cL3mqRaWK81UcPRA6hE36ZBjgnE5mc2rwXDk9a57?=
 =?us-ascii?Q?Q34NFSbAHm6p7ddO018SXjW6U2M8MbFGANEZcNY/JOAy9hHPgNiNGCOGKLdH?=
 =?us-ascii?Q?slZApnIPRDof4XM/yhIVk+YeIYBUagqHn4wNdZ40rx40bZYOktKhau5BhyRr?=
 =?us-ascii?Q?p8LPTKuPqynqaJIgns8rwjkF7RGO0/fOsfvmk4mdPrLkjvw1touaZWACkoG4?=
 =?us-ascii?Q?5nsAllkMaJRr1gWh/WsDBcBEUGKFXbPjXra6e2j27sy38f/MTtuy5E6RYr1E?=
 =?us-ascii?Q?g4AvTRaP3AXnME6M7Og7eNU7Dcp3HRJ8fbhtzmoCpjkfIJppFs9s3vgc8htb?=
 =?us-ascii?Q?DskWP+TlmMooupvNa1Ud03fmgJ6b9lNxXTOA8x4SGRNKgNvlpQILwdqLp9fD?=
 =?us-ascii?Q?8Pkmop669fNr2DMsztxi87HWJBllIlaw8UbLtmkc5mGd9LOxG+WQdupe6HoE?=
 =?us-ascii?Q?RGzNmJZcGFAnnwxZSG3EIy47VEp4dZ4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df96f92f-92ba-4767-b79d-08de746c9f4f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:51:41.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKFIQf4A9zFMOH6gX3oZcY52qqUgFOPpoKME/URE0IgeuJ3X9HPE45/Snfi1pYYBvzI1q3hP9CRKnKbaJMaaakz9r1MKEcm5e5GO1Pqv6ik=
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
	TAGGED_FROM(0.00)[bounces-78366-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: C6338197A0F
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

Changes from v6 posting:
https://lore.kernel.org/linux-nfs/cover.1770873427.git.bcodding@hammerspace.com
	- rebase onto current cel/nfsd-testing, take maintainer changes
	- move Kconfig "select CRYPTO" from NFSD_V4 to NFSD for crypto_memneq()

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 Documentation/netlink/specs/nfsd.yaml       |  6 ++
 fs/nfsd/Kconfig                             |  2 +-
 fs/nfsd/export.c                            |  5 +-
 fs/nfsd/netlink.c                           |  5 +-
 fs/nfsd/netns.h                             |  1 +
 fs/nfsd/nfsctl.c                            | 38 ++++++++-
 fs/nfsd/nfsfh.c                             | 74 +++++++++++++++++-
 fs/nfsd/trace.h                             | 23 ++++++
 include/uapi/linux/nfsd/export.h            |  4 +-
 include/uapi/linux/nfsd_netlink.h           |  1 +
 11 files changed, 232 insertions(+), 12 deletions(-)


base-commit: 74be0455c8fccc56f668c443f3e6c784f1b7dbc5
prerequisite-patch-id: aa7471b70863a8d50f76cbe59a459e2b174b9bde
prerequisite-patch-id: 86c22e04dc3f7e13012f7df35062332662aabeb1
prerequisite-patch-id: 785b66a20e714c68c70b2bc5d04ffecd3f5e8886
prerequisite-patch-id: 0e1bca4703bda3ea8cdc22c4f9aaef8626d412e6
prerequisite-patch-id: e2cadbb6b38006e1ddefc537800d63755e519534
prerequisite-patch-id: 70b31c12fec31e7608ec69e81d0e69ae191eecd8
prerequisite-patch-id: 70e076fbc3d74787f486f6498a43aca06be10a5b
prerequisite-patch-id: 20cd3620f99e8c4f883b7edff4bfebabb449cea0
prerequisite-patch-id: cdea6cd214f376f123ca91075407d47713d502c0
prerequisite-patch-id: ce569f2d71f639ba0de805756b8c562211d02b65
prerequisite-patch-id: 2b9b54ebcf4937f90118efc142f0b34552cb47a8
prerequisite-patch-id: 6e6e2a8341e922efb72f04bab7498451600295f3
prerequisite-patch-id: 833653d35ba03741e6a0181d20941e9f91438ff2
prerequisite-patch-id: 86b33df9b7b7682c118623f5d2714560d9c90c6a
prerequisite-patch-id: 2659cfe2294725cc8038264888fd59a850e70451
prerequisite-patch-id: b8bc9d34cdaf2b215634944621e560acf7cd2f4b
prerequisite-patch-id: 390396f3d28938249168c0bcd140c1c7ebe70b72
prerequisite-patch-id: 13387919d55666c852d129d6fe3f766754c3bae5
prerequisite-patch-id: a8ec6d86976a9858d7614aa0c42de1e8420d02de
prerequisite-patch-id: aab718e5cc8e166f2b7314a20e4d36bb08d3a505
prerequisite-patch-id: 1ddf7fb4dec908557e2f21bbcadb3121d47cb217
prerequisite-patch-id: 7ddf30b5167554d95edb645ee02178a1ae4116a1
prerequisite-patch-id: 5b6b107835b937d683ff314cf259ee37ac3e36e6
prerequisite-patch-id: 3f5805b2cd187262c3c04d0a316a003a61258655
prerequisite-patch-id: 03dcee5b42778363e76d2cc41a5a9a38bef7e6ce
prerequisite-patch-id: 54fee412c1056676539d98531fd5c9cc38f7a452
prerequisite-patch-id: c99d5e206d7c832360fd5e5b87fb452155eee43b
prerequisite-patch-id: 34f61e845328b7f669759988d952a1eee2df51aa
prerequisite-patch-id: 91080c262771e2d108185ba18ee8c4ad62067284
prerequisite-patch-id: a0ecf2b16e4e2729e85bcec7b38140d6690cdf4f
prerequisite-patch-id: aeb1879e01039209c6e1e82f01027126c9caa5f6
prerequisite-patch-id: 5c2ffb43f148547ad3e44411a2150fa9cc1c1317
prerequisite-patch-id: 367a74e761b36c68545db41051e1e7831b1cfb18
prerequisite-patch-id: 0ed88b7a0fbc9ce65f3f7c5110221fe137cdba33
prerequisite-patch-id: dd337779d72bd16340d6addb49f472f816ab0095
prerequisite-patch-id: 9827cb023f9277d52951fb89bf018d400455dfd7
prerequisite-patch-id: 03dfbd11d7665cde9c7f2ab55abe67d81bca00eb
prerequisite-patch-id: df5a4e0d677d46ee7a1f7c24ae0982b6a1dc7479
prerequisite-patch-id: a668a219b466ff8a5f3fdde3c39b807eb4773bc4
prerequisite-patch-id: 7af5afc30a82624160fcb5264334f5aac6af023d
prerequisite-patch-id: 61f6e24aecec981d6e9e86841436191d36a0d66a
-- 
2.53.0


