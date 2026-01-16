Return-Path: <linux-fsdevel+bounces-74131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA394D32B40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE0D83082AE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC28639A7F9;
	Fri, 16 Jan 2026 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="gUzGThdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022084.outbound.protection.outlook.com [40.107.200.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76F392C53;
	Fri, 16 Jan 2026 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573963; cv=fail; b=QdYxSde8BJBeqaj5HygNrLwK3LjQslmxOiZxZTItKwPw346JCmgSpBINgGi8dHZPX3i50UBPG5yLDv63T6HEbchgrSHCLhCWzOgWnh1l1fYbNE80gt3hWmAtgMITWuy1aGMn2Q+OxQe4PNVqr2391Kc75fVddNqH8W1ujHfo7zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573963; c=relaxed/simple;
	bh=apu0Y67DtEMERYjM/GKk2m/NWA34gUsKMQsN10mG3cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azgXju9MvffaTxcjmKm+08zLth29j/WyyaAIaxzLNmIt1hITSEz2y7Zg1Hn3QRiO0rqKRtrL58pSM6dNsojQVAj3kPjO/mv/Pk8gMB25U5cijkRroibUZjMvDAhJBJFHCPBbxWefHQESceTIWiDZZSbVIfhSHh7WInS7/zucvfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=gUzGThdo; arc=fail smtp.client-ip=40.107.200.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os5YXkGBXvvuFdygCOBhifss7oqc74BgtZziR3Bqt+FGO/rjCqdpk69qAqwupswiWdXTwVuSQWVCK3e5lton3Zp0MUdEJsHAZpQ2Pndi5qWAAyJZmZQOazQIY7gbu8B40lGtuIztMoxDdxfIFSi3cmWEroRZwOqhMWoPqe4nMp9vZaZrIrmcMU+um/vLpTSVP1n9/f2OX0jxr7ZmHdq9AkIEkgvlx+WrD0bPnf971tP6pGi3JxUIfUxI89vKZhvCQvKybz2M/hm+TYf0iJzXsmm3sxOqPwLlXq8Arybkmb8pbcuwBllolfHvy1QJRTTTsCz4tT35Q2sQZRF9EpXtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPH8tdXVEXQlguLQb+pZYTIu1XtaUeNFyeZ+c79m3cM=;
 b=bbPdRZDeFlftqWLaewsZz7VH36NsUyxFlQhjr1rnlRHWweVTrO4P/nKXeh8LVfi2t1Vldz5jdF0js+AE6AnXUdORUjiXCrDsA+WOG3HBN/kWHP4iP+TPkoRVR1PoraH9pkDY/IQ8luVaNHt1Voqzx8Dl5l3If6muA+G+oDToWrwQgbxxmkBjIU3ZCiZyRokOqOJt/jCp3lONPUhw+BsO/l7BXD8jrcdZiWt6c0wSS2NC/zbSBcIkCl/oJchNWPA4qmyJCQ+ZNRPv+xhpHDW4rGfZbq2bh/rgRqIbBlk7nLFORj8NSr2FVkLOz1Jko1fEWIYfD6s7T3Bl9miw4zL5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPH8tdXVEXQlguLQb+pZYTIu1XtaUeNFyeZ+c79m3cM=;
 b=gUzGThdo/mTGVhL0AOVGecCC61he+Sjyls0T2VEIt6OhgN9QBsG83K+A7P7LHj8dUvE56fZ4F1mmjdD0PijnBHrIUBiY2ZDye0voDxfrKdMcdijijRrjYe8rHFU5RxQgAAOGImJYTlwTgLBCUgNWqqFtOBB24R/9KI9bdH1vs5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SN4PR13MB5280.namprd13.prod.outlook.com (2603:10b6:806:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:32:27 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:32:27 +0000
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
Subject: [PATCH v1 4/4] NFSD: Sign filehandles
Date: Fri, 16 Jan 2026 09:32:14 -0500
Message-ID: <9c9cd6131574a45f2603c9248ba205a79b00fea3.1768573690.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
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
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SN4PR13MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfd0ee2-5e2a-4c15-ec0a-08de550c1262
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bh3CDt/JbNNhNOh5G09qk37Q62QKwBtk8/P1DR825/QVdPB4otiApUSYgIKO?=
 =?us-ascii?Q?UKtnhlinPu+XglZIKX9dkslWWdksHk+tMgYPdA+EbXiwcQb6uG/kAOGXdY3b?=
 =?us-ascii?Q?SosQS1nCjU1ZjpFmoJhqpMMXHMChO50kLO8T54YCpN99XSxE4oIBC8LpyK6d?=
 =?us-ascii?Q?QSgrPriCKASH7MAS2WnKfQvolOnPROi+6XriRpPPxX1g+84JJYiX3zgXVo9G?=
 =?us-ascii?Q?XnzSg7MmF6QqVSvdvWnWqnIoshXdy4yd0yOHqi0Go1WA+pQtSP5mN20zn5mD?=
 =?us-ascii?Q?Hqicn77/NDwd7bg2bkZzd9L6HlPSl87RZrl3Qc814XfcS1Wl0C+nGdKYS2tS?=
 =?us-ascii?Q?7h752Ol4Qt4cjAQJNASEFzRWMc2CcDgFq9tGR+Geq6M3nZCtgCrIe2PwxhVv?=
 =?us-ascii?Q?oO3WfW/G+bfkEdr3ROo6q1WKIt5jPdWgm1ZwdhOMGYW7daYIGGCTc7MW0COm?=
 =?us-ascii?Q?W9O6NS8w/hGg8VqZIpATbKORZsHJMVj4GNfqYgPLWd/knFANCyKIvrHEPW32?=
 =?us-ascii?Q?WZvHpoFASfcXaWyxEnX/OFVP8Z/gcYFvCcBc2RZvxoItcmgIwfvoFFv25LD9?=
 =?us-ascii?Q?gZyRzKqS/sLQPh5U5x8P6AsHRcADfliB6B6qUx5gpcqXRWLW4gJkQnPgZ6oj?=
 =?us-ascii?Q?Cf3mVUnXXziAKrlJNrnADFb/ti37Y4uFWRCzgE/GyANZ12GdPLX+kFsX+FKN?=
 =?us-ascii?Q?DsM/vrVtS9vqzlglqyAtGb4grEi30GeOsHV4X+wIB56gUToM0T0E25q/+0Hu?=
 =?us-ascii?Q?sY8ibeDheqwHwz59Yuq0QSrSwo6wm6I4Mws6y3Kxy6U6lxpnrjxrppC6nG/b?=
 =?us-ascii?Q?Yjsnv+U1uU1slBarAFIywFLZ+23Ra0daW1aZ8x9sC4XZK9szjaZCZ/9wFHU4?=
 =?us-ascii?Q?vtOneSNOlVp5/Pc8unRM5w7T8WoaAjaxUtI0scMVS83R7miFjNTik0nG2veX?=
 =?us-ascii?Q?b97thr/rtU9WdFdcrBhT6O/PtzZvFinoIbXYS2M83EsCRDq49hfL46PYV+pC?=
 =?us-ascii?Q?7btCruSFvYVnDebquAkoebzxaYr6BcxIZu4ezg+hE4HTZtTa6C/cAD7Bliy+?=
 =?us-ascii?Q?ymebSPUPiuGvcvxtSxJ9QUwyzggUg2GU1XqZQ3arJtzOdoeYlyAyZYxF30pB?=
 =?us-ascii?Q?pHckgQE0OREAr7sJ6TkAc1ucCyET0dsqjXcTYfiOy48kFx7rstLAVh7qwdBJ?=
 =?us-ascii?Q?3LrYXPKzVKwTS/JWXlZlC0mimuFQ+yo4a6QumOSMKIuLDAFLyUXN5YaEQQf6?=
 =?us-ascii?Q?D9IFJhmx2QY+CD0nKtD+NCP3+MRNKF2xC83O/h4iVUWi+adIDeZOCTzq8lCe?=
 =?us-ascii?Q?GZgL5rxZPYWJ5E/5i5tRGcFLKmhLENTRChENouGmkHEgAyH7c+9raNt6r8af?=
 =?us-ascii?Q?Sjth6LJhROBdzm23b2nonuQJoGCfLBqEt4XZr4inMX/v2NWzxLSmE6lUDhyE?=
 =?us-ascii?Q?GIbhSoFod/c7bcbSloK1WqwLkDsBcSvOj0zNzZxd0kPYoXt3XsmhyRVv/Ow7?=
 =?us-ascii?Q?TOFaSll5pNfEq5iyEGhHrVni0oqnqIThBY3sdBquvuYbdJPPA4F4mUuxm047?=
 =?us-ascii?Q?iDK+zLWl0bG5Yp0nwVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9hXxpfSmF56XcVlKQ9N2NlANLqvx3U7AJIg3qK8UdZSs0i4t02Kf+JkQ9Gw/?=
 =?us-ascii?Q?8xfiJCoOB3cEgoOKNbz3BrGn4VjJ83KVnJPaS7YI/fbY9xcUGL0AbY93N+k8?=
 =?us-ascii?Q?gbEi94WURRT9jaGi8V3E0mbhaj9wzNWcWvKH2d48bmUHB5wDqS4B229coQA7?=
 =?us-ascii?Q?JhrGikaZ4FaE+6n4/8UNRKH/hRExwYEPU9rOmOhGf1YzqC9ZJvCqsq2+CdJW?=
 =?us-ascii?Q?4mi6mj8SbSDw2ND52rEH4Igq4zh4yI1cUdm9xm0JAHk8BFAZZFVUZClMt9bU?=
 =?us-ascii?Q?UKR2wg3TZyqwK/CtovncpdLFBAzVET4sKdf5KCQr3eZ1fsuaowwj76U/Bm7q?=
 =?us-ascii?Q?kV4OHceSC+lvogc9hULOXHsEz32rUSXyutqeTyX7ha9Uc/j5Hc9wxiCkOIXN?=
 =?us-ascii?Q?C3bSv6R8FViLUv+FswlgkDRowFWA0dvWDxiwa3h3/unEa9VB80DVj+e7lJNM?=
 =?us-ascii?Q?hCdQOXoJSOjuoNVEGMiSNfQ6XbSF6coPQQ9XUqDcoWK8qn3Egftfd6vwdBq+?=
 =?us-ascii?Q?9fZxrNeiGpUgJAImWhVLzy/fJ5kTTI/5Ux1rbj9sjZu9w7/djOj6rLZLajL9?=
 =?us-ascii?Q?MJxdpdHPOdgIxuwkPf2u6qEdkHtNgo5vLdOw5wKGfD5UGyvjS0yEwcmgl6zM?=
 =?us-ascii?Q?x5YJ5g/yIZAUajeylxALyIR7wawWIvYCr7UfuxL0qCgdbjMmDI+y5NCFULVH?=
 =?us-ascii?Q?IqBNssTZU+3amB8lb/iCamUTsIUWb1Vpz7AWRm45k4lLEAy8NU9wOni5ieFi?=
 =?us-ascii?Q?4UkSqVIOUa9HH4nRMHW2v1owJUcH8X1iNblISto5n4XFpeNwYuD7gZVxDbjf?=
 =?us-ascii?Q?VNnHZCdkL53mjG9kBIBpJlcHHrt2fL06+klLt7TNR4pPaO1BgF0Zc43a1q3V?=
 =?us-ascii?Q?coBW5msRllKokki8P4VPO6eGBXrwKtvXYuU4H1bgMcoIaVRMeydp4y6fne4h?=
 =?us-ascii?Q?xC2LJf0YmBhwiBYBhsNH/pHVq41cscXL2XjitVR0IjFzrsiM7pooYn+sogJi?=
 =?us-ascii?Q?fFUW+VSR2+T82v2X8A+VbbYFE3DYrzuDz84iJAtYBw5g2Cr1/c82ZCoNk3Zj?=
 =?us-ascii?Q?8f4knFtBSqJTwElY6pvJsekbnbVEQf/ErTN/CxnjlogGiDEwdFqvTpGywKpY?=
 =?us-ascii?Q?yxVzS1YTF5hxF1BzMi+1ED5reVfe4M6jgo6AqWAOr2EWX3RZzRipCSVPAwTb?=
 =?us-ascii?Q?Mq9brRyjaNCtJU349FdtWJacRdojOp2HMfL1drn60eBT0LUiHx49uL/K2zmu?=
 =?us-ascii?Q?ghbEeKYbwxs8CeD396qYqECFEWPSsv0nrn8DpGZBteUCGFuZaaIx2Ts8tLX2?=
 =?us-ascii?Q?yLEQU4H3zTagA18AsD8Q7G4ANCAC7/H4EcwxIuTxkW2vvl1nGqt9le7oO3jC?=
 =?us-ascii?Q?7AKfxVWvl+4TvMzCALtjc3jVnY4bGMNcV0r7SO0AgIIOb8kDlrgUfR15YBYK?=
 =?us-ascii?Q?+sooGYiH01KVSyVqkD8bIRVvmURA915gcIN3f7wiVcQGTJ2VfixjwP6QVdbG?=
 =?us-ascii?Q?A8kwsh633LAycUYYyKCmRfb3i4oSVS5sIFQSejHyBU42gNbXP8OaMM7l73vo?=
 =?us-ascii?Q?yr8ZZuxp9dag4InmlFAFDagOXKkIwfsYD7s96LOPd6bOfProZ4cKLHolVb/+?=
 =?us-ascii?Q?T0l63JDLeAmwGKkD23tVmTNApxaFwcoEcUsZZ6la2yoFoMvCqG+Kl1hZcKUx?=
 =?us-ascii?Q?/jYVtIG+Cjl6nGwxskkV4d1YVLlKYDnMkcFBPcRSA2S2xvSYH/D93jdhu7qp?=
 =?us-ascii?Q?HbngK0fwMTPTVoLn+DMffdFZQhab5rA=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfd0ee2-5e2a-4c15-ec0a-08de550c1262
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:32:27.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb6DrOvoSdDvIta2sgnECaEFubBx2Q7DSyQTNpgYegAJt1Ksb9YOGXEIwyKok0xhIRa9MKs6C0jljUvItxWUySob18An23KicB+2RmcFHds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5280

NFS clients may bypass restrictive directory permissions by using
open_by_handle() (or other available OS system call) to guess the
filehandles for files below that directory.

In order to harden knfsd servers against this attack, create a method to
sign and verify filehandles using siphash as a MAC (Message Authentication
Code).  Filehandles that have been signed cannot be tampered with, nor can
clients reasonably guess correct filehandles and hashes that may exist in
parts of the filesystem they cannot access due to directory permissions.

Append the 8 byte siphash to encoded filehandles for exports that have set
the "sign_fh" export option.  The filehandle's fh_auth_type is set to
FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received from
clients are verified by comparing the appended hash to the expected hash.
If the MAC does not match the server responds with NFS error _BADHANDLE.
If unsigned filehandles are received for an export with "sign_fh" they are
rejected with NFS error _BADHANDLE.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/nfs3xdr.c          | 20 +++++++----
 fs/nfsd/nfs4xdr.c          | 12 ++++---
 fs/nfsd/nfsfh.c            | 72 ++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfsfh.h            | 22 ++++++++++++
 include/linux/sunrpc/svc.h |  1 +
 5 files changed, 113 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ef4971d71ac4..f9d0c4892de7 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -120,11 +120,16 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status)
 }
 
 static bool
-svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
+svcxdr_encode_nfs_fh3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+						struct svc_fh *fhp)
 {
-	u32 size = fhp->fh_handle.fh_size;
+	u32 size;
 	__be32 *p;
 
+	if (fh_append_mac(fhp, SVC_NET(rqstp)))
+		return false;
+	size = fhp->fh_handle.fh_size;
+
 	p = xdr_reserve_space(xdr, XDR_UNIT + size);
 	if (!p)
 		return false;
@@ -137,11 +142,12 @@ svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
 }
 
 static bool
-svcxdr_encode_post_op_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
+svcxdr_encode_post_op_fh3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+							struct svc_fh *fhp)
 {
 	if (xdr_stream_encode_item_present(xdr) < 0)
 		return false;
-	if (!svcxdr_encode_nfs_fh3(xdr, fhp))
+	if (!svcxdr_encode_nfs_fh3(rqstp, xdr, fhp))
 		return false;
 
 	return true;
@@ -772,7 +778,7 @@ nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_nfs_fh3(xdr, &resp->fh))
+		if (!svcxdr_encode_nfs_fh3(rqstp, xdr, &resp->fh))
 			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return false;
@@ -908,7 +914,7 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_fh3(xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_fh3(rqstp, xdr, &resp->fh))
 			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return false;
@@ -1117,7 +1123,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres *resp, const char *name,
 
 	if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
 		goto out;
-	if (!svcxdr_encode_post_op_fh3(xdr, fhp))
+	if (!svcxdr_encode_post_op_fh3(resp->rqstp, xdr, fhp))
 		goto out;
 	result = true;
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 884b792c95a3..f12981b989d1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2701,9 +2701,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 }
 
 static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
-				   struct knfsd_fh *fh_handle)
+					struct svc_fh *fhp)
 {
-	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
+	if (fh_append_mac(fhp, SVC_NET(RESSTRM_RQST(xdr))))
+		return nfserr_resource;
+
+	return nfsd4_encode_opaque(xdr, fhp->fh_handle.fh_raw,
+		fhp->fh_handle.fh_size);
 }
 
 /* This is a frequently-encoded type; open-coded for speed */
@@ -3359,7 +3363,7 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, args->fhp);
 }
 
 static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
@@ -4460,7 +4464,7 @@ nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct svc_fh *fhp = u->getfh;
 
 	/* object */
-	return nfsd4_encode_nfs_fh4(xdr, &fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, fhp);
 }
 
 static __be32
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..b2fb16b7f3c9 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/skcipher.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -137,6 +138,62 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+/*
+ * Intended to be called when encoding, appends an 8-byte MAC
+ * to the filehandle hashed from the server's fh_key:
+ */
+int fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	u64 hash;
+
+	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
+		return 0;
+
+	if (!fh_key) {
+		pr_warn("NFSD: unable to sign filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
+		pr_warn("NFSD: unable to sign filehandles, fh_size %lu would be greater"
+			" than fh_maxsize %d.\n", fh->fh_size + sizeof(hash), fhp->fh_maxsize);
+		return -EINVAL;
+	}
+
+	fh->fh_auth_type = FH_AT_MAC;
+	hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+
+	return 0;
+}
+
+/*
+ * Verify that the the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	u64 hash;
+
+	if (fhp->fh_handle.fh_auth_type != FH_AT_MAC)
+		return -EINVAL;
+
+	if (!fh_key) {
+		pr_warn("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	hash = siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
+	return memcmp(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, sizeof(hash));
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
@@ -166,8 +223,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 
 	if (--data_left < 0)
 		return error;
-	if (fh->fh_auth_type != 0)
+
+	/* either FH_AT_NONE or FH_AT_MAC */
+	if (fh->fh_auth_type > 1)
 		return error;
+
 	len = key_len(fh->fh_fsid_type) / 4;
 	if (len == 0)
 		return error;
@@ -237,9 +297,15 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 
 	fileid_type = fh->fh_fileid_type;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		/* Root filehandle always unsigned because rpc.mountd has no key */
+		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
+			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
+			goto out;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..d1ae272117f0 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -59,6 +59,9 @@ struct knfsd_fh {
 #define fh_fsid_type		fh_raw[2]
 #define fh_fileid_type		fh_raw[3]
 
+#define FH_AT_NONE		0
+#define FH_AT_MAC		1
+
 static inline u32 *fh_fsid(const struct knfsd_fh *fh)
 {
 	return (u32 *)&fh->fh_raw[4];
@@ -226,6 +229,7 @@ __be32	fh_getattr(const struct svc_fh *fhp, struct kstat *stat);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
+int	fh_append_mac(struct svc_fh *, struct net *net);
 
 static __inline__ struct svc_fh *
 fh_copy(struct svc_fh *dst, const struct svc_fh *src)
@@ -274,6 +278,24 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 	return true;
 }
 
+static inline size_t fh_fileid_offset(const struct knfsd_fh *fh)
+{
+	return key_len(fh->fh_fsid_type) + 4;
+}
+
+static inline size_t fh_fileid_len(const struct knfsd_fh *fh)
+{
+	switch (fh->fh_auth_type) {
+	case FH_AT_NONE:
+		return fh->fh_size - fh_fileid_offset(fh);
+		break;
+	case FH_AT_MAC:
+		return fh->fh_size - 8 - fh_fileid_offset(fh);
+		break;
+	}
+	return 0;
+}
+
 /**
  * fh_want_write - Get write access to an export
  * @fhp: File handle of file to be written
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 62152e4f3bcc..96dae45d70ca 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -267,6 +267,7 @@ enum {
 };
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
+#define RESSTRM_RQST(xdr_stream) (container_of(xdr_stream, struct svc_rqst, rq_res_stream))
 
 /*
  * Rigorous type checking on sockaddr type conversions
-- 
2.50.1


