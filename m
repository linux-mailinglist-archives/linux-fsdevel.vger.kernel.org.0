Return-Path: <linux-fsdevel+bounces-44444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2A3A68D6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 14:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABED73AE7EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA25254B1F;
	Wed, 19 Mar 2025 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="BT7ytlis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695335963
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389738; cv=fail; b=LYwcl0n/BfLr97gw2n0qZQXU9gvPQgQKkrn2wPR5nmtjcHo90+Fn3p/Wn0qIVUJ3Zud8KeFE3OmNbnvaub7EKvwqwf46HkxdBi4bthhx9osv6mLjYOSm/v0Y/RajrjGzUbs+Iov/8bACN7av73H2Wcq29s/pAGrALbf9DPYJiZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389738; c=relaxed/simple;
	bh=53X76ONCLy1DqcGF8lBnQQCHyKPXWS+m2PJ3XY+OUTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJFvBuLaxEtiYu6zDHO3Axt+maS9T93B2ZHE3X1Dn2Px9OO8l9OsTuyuzYhjtaQ5Tet9wnVNi5Xt9QMIOTDHFKrtdTOnqb8HlDEDdHaiRtOZ5UClwjfO7ctiWuMJnJxS8Met6H0ZTULh/EpkwiZKi8otCY5N1qkixvIIxdcmdN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=BT7ytlis; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170]) by mx-outbound43-145.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 19 Mar 2025 13:08:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCFblN0ZSDfxB1sgIfDELPDlFKATUXZaJjMnPLko/SbNTaCaU8g8zT/JwYv2QNy4PAT2+xdAvnZETxPosFWbDJ7SHgI4kAkH9mbkwrxguKEM3DYvB4HcnSrjT6RadeUVzCEX4BlUjNRP90zD11Zun8UsjgxAyi5IKoV7pkGd8Ng/tymakiuwRiaFqs+QflDH/MVoSAr8KCJ+lBqVZ4iOZucvcpQLePkWmQKcXyn1NR8FfiiXAskIUY7QiXT6WKzBb7GZACY/gRXQ0NzvIDxbdYgG3xbLu+ASjX71gm4ZWPtLCi4W/7wfHY1IqHxcHbHcMnVmfIYUuA9m6JuousfpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVYv6uDWFoyMTYJ1A9JFhexjkAznXLZtvX/5FiuDEAk=;
 b=kovxAc5N7GlcFEu4GR6FtWChLrhuw8CvV3y0Sop9lpC99TNg05qhJGfCjdXXboQ8nGlEt1Zw07CiZn222XedUQTINmRu+02Ungxcz/Yop8CZ6nCUsHvzjulGVmdMS/85QErk2aWhgLjcRmrenv2/8O25jGoA7EVPI3ooKpAKBkUGFFCQ2Ww2Qk2UJnfZ4dFfeaDksp/5sHm1K6QVEehTS3Dxu5pn2oU+DYprQaPFtyNM2V511CDpCUJLGdehiZcXqMIfqh7DM255Bsc1XWdU+snyb1LvGj5o7tp1qHPX1hgIPRKiH7wViJxlWDes57QvD4Tq5L13oYXuIw9aoex98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVYv6uDWFoyMTYJ1A9JFhexjkAznXLZtvX/5FiuDEAk=;
 b=BT7ytlisdwKZoZkKOX3GWAQQLGQoNnCsT6twrLIAuEyU4gyGz0iXRvn5JwUn4AwxymKjESryIQitTCaS1XidlHNILNmKsTDeiNp/h5fcYPGygkPzMEVqo9ASYAQ0JsYDcgWASp4ddtXtDnkMmf5cKmgCKrhg+e7In6HzT8EcOWw=
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by IA1PR19MB6131.namprd19.prod.outlook.com (2603:10b6:208:3d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:36:52 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::20) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 12:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via
 Frontend Transport; Wed, 19 Mar 2025 12:36:51 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id E34F04A;
	Wed, 19 Mar 2025 12:36:50 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 19 Mar 2025 13:36:35 +0100
Subject: [PATCH 2/2] fuse: {io-uring} Fix a possible req cancellation race
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-fr_pending-race-v1-2-1f832af2f51e@ddn.com>
References: <20250319-fr_pending-race-v1-0-1f832af2f51e@ddn.com>
In-Reply-To: <20250319-fr_pending-race-v1-0-1f832af2f51e@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742387808; l=6257;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=53X76ONCLy1DqcGF8lBnQQCHyKPXWS+m2PJ3XY+OUTM=;
 b=dfxjNHznGOgy1s2UdBJOTpbLtjcOyII59SundzVX72f/9C7VnpQHFO7u+7l/P2bmwCTi1l+qb
 PTc14zzvY4cD9QkaY730PC9MwRVI8pWrKopBmfXCu0HiU5AEVfmL5XW
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|IA1PR19MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: b44532f3-89da-4698-6d3b-08dd66e2b99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TGFNTTN5TEJoalVQdW0rVHdTaWYxZTlMUFJyVk9WbVhCeng3RlQ1TkN4Um9K?=
 =?utf-8?B?aThVZXZ6Nk8zb2Z0Z1lqbE1rQmkwU2xCK2k5WVhhNGlLU0ljUDdDWlc2M3dT?=
 =?utf-8?B?TWlsSXlKU0JnZ2JEbmFFR2FWanBXZ3hmU0pCdkxVaGszVmVOTmk5UGVtdjlz?=
 =?utf-8?B?OVZwYkd5aXgrZCtZd3F0VC94YXVsTlBlMEV5ZHJYSy9RTTBCQ0w0U3dQdzE3?=
 =?utf-8?B?NkdkdjNpUng3WmQ2VDRwRm5GUG1Ha1FXNEE5bVc1TXpSWHhWWitqSGRsZ3NL?=
 =?utf-8?B?WWdvZlJWT1d0Q2VmYnVoTG8zb2dETDFrZkpTNGZJcjRTYlNZMWpzNGcwUGtL?=
 =?utf-8?B?ZjZyM2IwYzBhQUZSSmhZM2k5aTdYdDZobmR4QSs1akJWM3pSMjFSVXFuR1Vm?=
 =?utf-8?B?VkZ6OGRNTXdvbCtFaCt2djNVNlB3WE9sZk96ekVTOVAvQWF4bDZ3N2tlMFUx?=
 =?utf-8?B?MEMyb0NjWHdlRDV6YTJVd1BtMS9Wd1c2aFFaSFhWYm5EV285OTMrTytJUEhR?=
 =?utf-8?B?M1FMa0FjYi9ZZHVtcEROZ1dzZ1JJWGsxMXN2Z0JLZUFVN0s4VkZPU1pzQ25E?=
 =?utf-8?B?MzZzdHVHZExTZTJabE5uaDhrellybVliZ3Q3eEJYdFlLK3oyWG5SY2VtZEw1?=
 =?utf-8?B?NU9sWjFTZURMNjZMNkZ1T1EveEtJWEhPOE5FTnlZem1aay9TSkpocHZuVE5Y?=
 =?utf-8?B?UW10ZkV5Mk5xS3RFRTNhRzJUd1YxSHJOcGJ2eHZQdVZXVHhSVzNHT05wZlVJ?=
 =?utf-8?B?Y2pLaTM2WjFiR0JJQ0RNNUNyL1krVWxQaFFzTE1ONnc5K3hHRWVjeTdOQndH?=
 =?utf-8?B?RkhvN0hYYXd0YVIzMUtMTEtCYVNqQjQvbVFZTkl2VmVhdlgvalFLeHhyTVI5?=
 =?utf-8?B?Sk5qNysvVVl1OFFndHJxSnlMc3lSbDM2eXI0ZXVPQjNHbXFPcXZ3aEVJd2da?=
 =?utf-8?B?QmZ6dGFFUDRKY05RYVdSbTY0OFRiQTQxak1nb3pZU1NZRlg4S1FPUVJLN3ZT?=
 =?utf-8?B?SERramcvSDBXY2JPNDZvQWpPeG44dUhZTXV5RnkwcWlyTXJDdW9CQ1dEelUx?=
 =?utf-8?B?TDAxSzJ5Z09OSnB6OHhGcnhYd2dEakZHdW5YTGlnZzB0Mnc5Ump2U1VzbWs2?=
 =?utf-8?B?UnBvUmJKS3JpQ0ExOTRCRzZxTjJYUEpCYzFuU1RNZDlselV4R3Z0SXA2M0k2?=
 =?utf-8?B?R1Y2UUtUOGQrUEdQTFAvU2t4ejF5Rm1WVTFmdUdrM21RN2FmTDZsUUwwTm5N?=
 =?utf-8?B?YWpITHZIUVdRd1RnYnk5QkNUMS94YlB5a1Jra245c09GbXJLVnRnMGZwdTRl?=
 =?utf-8?B?bW9PM2JBTzVpZFI3TWY4M0hLSzQ4bzJQVzQ2SXFjM2RITGtpRUYySHVKSldJ?=
 =?utf-8?B?QVpqNzFTcEdnOVpsNktlSm4xbHk5dDdKb3Rqdi8vSm9GZU5YR0t5UVM5TDFp?=
 =?utf-8?B?UGV4amg5bytKK0JkV0RlR28va0ZRV0k1NUtCQkJPSjRVcDhYWDB0b01zUU5E?=
 =?utf-8?B?akI1V3hZN2FXMWZNZkhJTnhSYjFaUWZ3MVJHSUxzWnFmYWRlbWNKcXZhb3pB?=
 =?utf-8?B?WGsvcElPTTNUZ3FUZnhuU2pDNmhkWXltMitsM3pDRitOZExMYXdPR2cxcTAr?=
 =?utf-8?B?OEIyK1VyYUE3TEJneFVYb0dURFptWWN3SEUyYnJqc1FKcExvZ3lyS2xCWWtC?=
 =?utf-8?B?YWZnbWs4Y2lmTVp5YlZpTk12MU03K2pSRWYvWmtFR0w0N1RSZU0yY0JhOVpG?=
 =?utf-8?B?WmczTytPZGtHUUVrNTFiRS8ybWNLUHVjazRocmcvTWQvOFQ5KzNOc0JYK2cw?=
 =?utf-8?B?bWZHTVMzdnRUL1JqdDRqYmg5TkRlalRkQ3cvaWRrMjhUR0Znb2VVbm1uQjBV?=
 =?utf-8?B?OEk0LzJlRlcxZ0drTEFIRGp2ZC9PaWx1blRDcllEMmliK1I3MXBoY3l3MWJr?=
 =?utf-8?B?S3dJREZUMU9JbHdkOFAyTWd3YzNCZjlOVnVLbmkyeDRjRGYzUEg5RUFjQ2N6?=
 =?utf-8?Q?RZtOWG+JzgZs//rBE4o6zdgGFrbDe4=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 qj8EZUtKbDUx21+bT49TdMAAda5q+lwO0D631iLtcG68bOn8d6ztrU5xzV6S41XpS1C39BsCmArv7Pn3apZxVaY9y/8X53SWRha3lHDoSjiso/XA3/2ZciV1OgDEjq5+9LwurCrslTIAEmtp2aVb25DbmCMGmcKt49tDSrR5T9n4TtCb9pWZ+NcxT7+bUDfklRmV6zJxAegAKIyTlpHr8FqUN4Uhl56dkQxE2W0OfIomoWd25RWe/6X+A7Fsg/R/lX/R9zfmrLWUBl7O61L88yEGeFV5puKpt5cy0OKdR87pqCXpbG6mm4doorVtbJY7vEPtwwzghXpbNv0mZ9ukgJ31fE9ESht4s0sqZh2ETlmFOuTiDSeRXVJK72ktNdyCLD0HPXaBcGI5VNS6WLBokcMl5JLppK+mipDEFe+DkCIvTvLtyUaBjYqmxAP4n1dI1Vj+trSy/DuU/hjMpf+NDNtrWHsHYGaKlRQQRldOrVaoUVi44ss85H0uf9Dv4czPCBEhNiiXL4bPDYOU8hGXXkuIkCBAKDC+ugRg4RXjqyEVXgUt1OliBysaHk40VMWRSExHezF+gYtdyf8PK7f1iAxZlxpucoOjhf73APK4AizFY8nReyCATbvxlEcKrmO4GXrmey98afQSqRGiUprJpg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:36:51.8572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44532f3-89da-4698-6d3b-08dd66e2b99f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6131
X-OriginatorOrg: ddn.com
X-BESS-ID: 1742389731-111153-7688-9050-1
X-BESS-VER: 2019.1_20250317.2316
X-BESS-Apparent-Source-IP: 104.47.56.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYGZiZAVgZQ0MgoMTXNwjjVON
	kkycg42cwgNSUtzdQ8ySzJMtEg2cxYqTYWAGQF9JBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263265 [from 
	cloudscan17-151.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

task-A (application) might be in request_wait_answer and
try to remove the request when it has FR_PENDING set.

task-B (a fuse-server io-uring task) might handle this
request with FUSE_IO_URING_CMD_COMMIT_AND_FETCH, when
fetching the next request and accessed the req from
the pending list in fuse_uring_ent_assign_req().
That code path was not protected by fiq->lock and so
might race with task-A.

For scaling reasons we better don't use fiq->lock, but
add a handler to remove canceled requests from the queue.

This also removes usage of fiq->lock from
fuse_uring_add_req_to_ring_ent() altogether, as it was
there just to protect against this race and incomplete.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Reported-by: Joanne Koong <joannelkoong@gmail.com>
Closes: https://lore.kernel.org/all/CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com/
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c         | 33 +++++++++++++++++++++++----------
 fs/fuse/dev_uring.c   | 17 +++++++++++++----
 fs/fuse/dev_uring_i.h | 10 ++++++++++
 fs/fuse/fuse_i.h      |  2 ++
 4 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 124a6744e8088474efa014a483dc6d297cf321b7..20c82bb2313b95cdc910808ee4968804077ed05b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -407,6 +407,21 @@ static int queue_interrupt(struct fuse_req *req)
 	return 0;
 }
 
+static bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
+{
+	spin_lock(lock);
+	if (test_bit(FR_PENDING, &req->flags)) {
+		list_del(&req->list);
+		clear_bit(FR_PENDING, &req->flags);
+		spin_unlock(lock);
+		__fuse_put_request(req);
+		req->out.h.error = -EINTR;
+		return true;
+	}
+	spin_unlock(lock);
+	return false;
+}
+
 static void request_wait_answer(struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
@@ -428,23 +443,21 @@ static void request_wait_answer(struct fuse_req *req)
 	}
 
 	if (!test_bit(FR_FORCE, &req->flags)) {
+		bool removed;
+
 		/* Only fatal signals may interrupt this */
 		err = wait_event_killable(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
 		if (!err)
 			return;
 
-		spin_lock(&fiq->lock);
-		/* Request is not yet in userspace, bail out */
-		if (test_bit(FR_PENDING, &req->flags)) {
-			list_del(&req->list);
-			clear_bit(FR_PENDING, &req->flags);
-			spin_unlock(&fiq->lock);
-			__fuse_put_request(req);
-			req->out.h.error = -EINTR;
+		if (test_bit(FR_URING, &req->flags))
+			removed = fuse_uring_remove_pending_req(
+				req, fuse_remove_pending_req);
+		else
+			removed = fuse_remove_pending_req(req, &fiq->lock);
+		if (removed)
 			return;
-		}
-		spin_unlock(&fiq->lock);
 	}
 
 	/*
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ebd2931b4f2acac461091b6b1f1176cde759e2d1..0d7fe8d6d2bf214b38bc90f6a7a9b4840219a81c 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -726,8 +726,6 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 					   struct fuse_req *req)
 {
 	struct fuse_ring_queue *queue = ent->queue;
-	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_iqueue *fiq = &fc->iq;
 
 	lockdep_assert_held(&queue->lock);
 
@@ -737,9 +735,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 			ent->state);
 	}
 
-	spin_lock(&fiq->lock);
 	clear_bit(FR_PENDING, &req->flags);
-	spin_unlock(&fiq->lock);
 	ent->fuse_req = req;
 	ent->state = FRRS_FUSE_REQ;
 	list_move(&ent->list, &queue->ent_w_req_queue);
@@ -1238,6 +1234,8 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (unlikely(queue->stopped))
 		goto err_unlock;
 
+	set_bit(FR_URING, &req->flags);
+	req->ring_queue = queue;
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
 	if (ent)
@@ -1276,6 +1274,8 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 		return false;
 	}
 
+	set_bit(FR_URING, &req->flags);
+	req->ring_queue = queue;
 	list_add_tail(&req->list, &queue->fuse_req_bg_queue);
 
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
@@ -1306,6 +1306,15 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	return true;
 }
 
+bool fuse_uring_remove_pending_req(struct fuse_req *req,
+				   bool (*remove_fn)(struct fuse_req *req,
+						     spinlock_t *lock))
+{
+	struct fuse_ring_queue *queue = req->ring_queue;
+
+	return remove_fn(req, &queue->lock);
+}
+
 static const struct fuse_iqueue_ops fuse_io_uring_ops = {
 	/* should be send over io-uring as enhancement */
 	.send_forget = fuse_dev_queue_forget,
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 2102b3d0c1aed1105e9c1200c91e1cb497b9a597..89a1da485b0e06fc6096f9b343dc0855c5df9c0b 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -142,6 +142,9 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_uring_queue_bq_req(struct fuse_req *req);
+bool fuse_uring_remove_pending_req(struct fuse_req *req,
+				   bool (*remove_fn)(struct fuse_req *req,
+						     spinlock_t *lock));
 
 static inline void fuse_uring_abort(struct fuse_conn *fc)
 {
@@ -200,6 +203,13 @@ static inline bool fuse_uring_ready(struct fuse_conn *fc)
 	return false;
 }
 
+static inline bool fuse_uring_remove_pending_req(
+	struct fuse_req *req,
+	bool (*remove_fn)(struct fuse_req *req, spinlock_t *lock))
+{
+	return false;
+}
+
 #endif /* CONFIG_FUSE_IO_URING */
 
 #endif /* _FS_FUSE_DEV_URING_I_H */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b30cd57b8a6bbda11447a228cf446..5428a5b5e16a880894142f0ec1176a349c9469dc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -392,6 +392,7 @@ enum fuse_req_flag {
 	FR_FINISHED,
 	FR_PRIVATE,
 	FR_ASYNC,
+	FR_URING,
 };
 
 /**
@@ -441,6 +442,7 @@ struct fuse_req {
 
 #ifdef CONFIG_FUSE_IO_URING
 	void *ring_entry;
+	void *ring_queue;
 #endif
 };
 

-- 
2.43.0


