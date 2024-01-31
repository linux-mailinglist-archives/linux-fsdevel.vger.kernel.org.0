Return-Path: <linux-fsdevel+bounces-9778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1226844D31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC9F284D56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E107A405D4;
	Wed, 31 Jan 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="NwCKFUyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835539AE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744457; cv=fail; b=E2RsZunjszBvl4b4UCr+Ecj7vMhC38sBHbQUTClHTxm0dm9jabCqAaWiabm/ZEMTKLfEcbG3EQnCj2ombYmSKLBPriiHzi23eeAUQF/v42K+6FPnqqJv8Z73cq1xk1QUQkPMi4YbkVZlcfEQZqtL7g5FIQfUjvkn4FgLi1BadMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744457; c=relaxed/simple;
	bh=FTLO4RBu5xY3r3pgFmtARZfKJvzjdWykQLhAa3GN/C8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mgo87ffyVVu4DDchYkPUTobfskdDi86ke/PB1yaSXA3cd14/UeDgJEc5iaeg1pzepj3Az6a1jgRFNhRpgIbZF+MYk1hPHxo60eb2mKzDfI4EjPKZyfoXXvcG8EeaZ6jYrXHRvZyEVJO6RW768+9Vc2XKZfQQ6woZZIgh62lxKf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=NwCKFUyk; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound45-91.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 31 Jan 2024 23:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE7yBvM6BWc7PTwqir2o+JvaFByAHK3EBrBE/dP1MLgkcFDMslCQPY3S5Ci+16NSNwnQ/tyi6XgBBXVGNNkQ/LLcAQvzYIu+Xn/X+kRUw+EeurzWd2BJ8cS9ouo/fcyEynW5d8FJEqlvQ9mcrljB+PQAbOj641i3UZp9acK0Aj3m54OYLAqJFSpWSIUmfGAMNo2FOR94EiTi4bohb9klXwmpN5V1cSkBvxrzMEGDw+KSDcX/p8w6aDBB/8rUVsyyV/f+KufHoUYn4Yssh8dLEJQ2lg/gmdQCSx2Flt5lc8jDD+3tQHKHFDD5mibQ7/rteVZY17lSUYIIc+oxFVNyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixpWq5n7nTtfDmlTOjrO6JmFAmBlkWtcia8jgQZ8Anc=;
 b=gNz0Si5JoE7la0Yd/TtvvKzMjIEFEQYP26oAR9bgdR8u45du0HEeaGxRKOW3LCp9p3zlb64hdO+ON1996NpIh0ROFtt7ljLgMdlFFpA0FFHNq0dU0Nqt0iQF0uGTV5snhGSF7qhf4W7GwUWQnaQ40xPY4Vod0T8jZrQfbPzTuu5JppLJhOE53ieqQjuQlMjmFKPxcNRJwhO8jMsvPzLL3FVahWjOXaNfR9bn3hoqsiFy/AyyI+MW7CqpYCzj7h7VnAa8jvWKtHcFGNdNOmh/zBXCpTThZ8IzodiqpPofTEq6XIMUUlQLS/zIS07FoBvQCPt4SjkRdGQxCh1Kde7n3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixpWq5n7nTtfDmlTOjrO6JmFAmBlkWtcia8jgQZ8Anc=;
 b=NwCKFUykbMlQGMSup54p/6y7/JS71lXXbqcHBO8YLO+PHkjnjkKRCLrQ3oJeNOnQVEKRikqywgmuO99G8J2iaf93nDUI2Sz0v5R4lCjE8wk9LrOV9qo5Ed5FcYRXdvLYmTOx+0eV2Z33JS/wtcWLS9+EN82ba5zh9jv1G5ChWNw=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by BLAPR19MB4609.namprd19.prod.outlook.com (2603:10b6:208:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:08:44 +0000
Received: from MW2NAM04FT052.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::3e) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 23:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT052.mail.protection.outlook.com (10.13.31.175) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.26 via
 Frontend Transport; Wed, 31 Jan 2024 23:08:43 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 8BF8E20C684B;
	Wed, 31 Jan 2024 16:09:44 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [PATCH v2 0/5] fuse: inode IO modes and mmap
Date: Thu,  1 Feb 2024 00:08:22 +0100
Message-Id: <20240131230827.207552-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT052:EE_|BLAPR19MB4609:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d8ef6702-5eb7-45f7-380f-08dc22b19204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qaBjNO89OdFg0B0GLZKIAS/1yUCIpSneLL7Gc5JutfnxecQ7Indzc+oxVQ11E2lyfKyJHnRjNBSSlxO6EeTxS0ciuiWyDPmsvPvCItHQQiKXdx1cCYw5xj4F5+SJARDlq6dwVHFeHmirWZ8K2rHEJulFNxjh9l8GbOHmJNfHXA+UEfnI3FYgcA/jzElFL492sip+ydC5Rp//esiuf0CMP6H/S79ixfoAgMMgLKF/TyT5Kju3AH5YM14EqvYHOuZ1IkhLZYm4cjYjkaSKYL3X0viF6mardSgoM2nC6HbCm/zrXuKLqftPLvLc4vY3lJoYvopBQRoiPh40B0yq46VzZ6qqT7AzQ6szIay1oCg5pyvqyKtMGUoeOB42p5tB42lNIGe5bE/wXtcSz+xod32rEJxiQNYBodgjS1RBipSmTr8mvHGIl7lJPQGzbgI3xDDxuaJeStObNi2II74Yyt7h/WQz+T/WwKRbaOfyVNtoStn3uw8gT1JJZSay2S9BM6CGJpEUyuGmOs1Yy0zWTfGPhVxnn1FLfIAIZAJQ4nncjgS/9ZipYlTdh54lt7ev6KnjJnCr8lcXiNCT0ffciW5paBYlxcXQCE31xQQKl6HGhdu+GCDBpxIFXqgIPd0D4LCpbEmKWx0hPO11QJR4QJm2pVVNtDBg2/uL9BqRdiG/+VL03V13myBbypvStEwp9KhuOSqeWjUirrelEP802ufi7ZKCtPqV7dM5TafGCHS8TvU=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39850400004)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(41300700001)(5660300002)(83380400001)(4326008)(8676002)(2906002)(8936002)(86362001)(70586007)(70206006)(316002)(36756003)(54906003)(6916009)(966005)(36860700001)(356005)(81166007)(82740400003)(478600001)(47076005)(6666004)(2616005)(6266002)(336012)(26005)(40480700001)(1076003)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gtjMOzsTrrldICdIFkmfdSgSlqw/tG+fBFaCdDQLzPdY1frkCFggOvr6Ml3wxXFT06JBnYL/z3r5GIRyHhK8slkuJj1hc9AV8j9HoC2wH9tCk7lRgHZgB/jHpkqpJYMhmdRDlvXRUWX6AeNO8EXmgjD2vpKfRhfBXyWqqvAbh78juN73NE956INhZn6XV3jWFCyE4gTliHCm4FRrbP6R2sPMeGM5en4JnQo0VI5EEXpBZxsmR3rpXFOUbYBFnGg7Gy8BVVJIJwClorbaqbxP9Kwucbe+pgr/g++RUGvWqBYLqPppd6ZBeQ21tKmK09R3HLRpxaKlYvmJXigkxjqNat1zwsQtcLopWLq50K/qS7dZfkokWlq/zGzaTys7/onw7cCbmwwvnqg+vl8th1rqAwu2WIpo+GZVQljRGa8pRFTRUGRYt+RU66X+8BUyLxkX1BtY8uBIja6n7AOYWRQUL3cOC+wMRUqSuhRANx2W0XfENBF/yRqr5NK+ddnJoMQqEc98xrZ/VLrq6mQ89RNU/ZStT59h6CQf2XfflaAXocnc4PrL1Bdgingy2mW7+XPG2rDQROgwOXORsSFD7pL/h/F8K1aShVQ680yLNG8z/JjC10ZoqsFAuFXpx+G85pq04V7EsYEBEPijQxE/3oAeNQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:08:43.3136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ef6702-5eb7-45f7-380f-08dc22b19204
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM04FT052.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4609
X-OriginatorOrg: ddn.com
X-BESS-ID: 1706744450-111611-29371-7747-1
X-BESS-VER: 2019.1_20240130.2130
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWJuZAVgZQ0NAo1dzCLMncyM
	jS3MjA3MTY2CTN0NQsxcwi0cQ02chcqTYWAON8s65BAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253897 [from 
	cloudscan22-130.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status:1

This series is mostly about mmap, direct-IO and inode IO modes.
(new in this series is FOPEN_CACHE_IO).
It brings back the shared lock for FOPEN_DIRECT_IO when
FUSE_DIRECT_IO_ALLOW_MMAP is set and is also preparation
work for Amirs work on fuse-passthrough and also for
shared lock O_DIRECT and direct-IO code consolidation I have
patches for.

Patch 1/5 was already posted before
https://patchwork.kernel.org/project/linux-fsdevel/patch/20231213150703.6262-1-bschubert@ddn.com/
but is included here again, as especially patch 5/5 has a
dependency on it. Amir has also spotted a typo in the commit message
of the initial patch, which is corrected here.

Patches 2/5 and 3/5 add helper functions, which are needed by the
main patch (5/5) in this series and are be also needed by another
fuse direct-IO series. That series needs the helper functions in
fuse_cache_write_iter, thus, these new helpers are above that
function.

Patch 4/5 allows to fail fuse_finish_open and is a preparation
to handle conflicting IO modes from the server side and will also be
needed for fuse passthrough.

Patch 5/5 is the main patch in the series, which adds inode
IO modes, which is needed to re-enable shared DIO writes locks
when FUSE_DIRECT_IO_ALLOW_MMAP is set. Furthermore, these IO modes
are also needed by Amirs WIP fuse passthrough work.

The conflict of FUSE_DIRECT_IO_ALLOW_MMAP and
FOPEN_PARALLEL_DIRECT_WRITES was detected by xfstest generic/095.
This patch series was tested by running a loop of that test
and also by multiple runs of the complete xfstest suite.
For testing with libfuse a version is needed that includes this
pull request
https://github.com/libfuse/libfuse/pull/870

To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>

---
Changes in v2:
Amir:
- Added one more patch (4/5) "fuse: prepare for failing open response"
- Updated the 5/5 (previously 4/4) fuse: introduce inode io modes
    - Fix FOPEN_CACHE_IO release, release could have happened
      without being actually taken (error cases, directory, dax-inode)
    - fuse_file_io_open does not implicitly set FOPEN_DIRECT_IO anymore,
      but waits until concurrent shared-locked direct-io is done or
      switched an exclusive lock).

Amir Goldstein (2):
  fuse: prepare for failing open response
  fuse: introduce inode io modes

Bernd Schubert (3):
  fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
  fuse: Create helper function if DIO write needs exclusive lock
  fuse: Add fuse_dio_lock/unlock helper functions

 fs/fuse/dir.c             |   8 +-
 fs/fuse/file.c            | 339 ++++++++++++++++++++++++++++++++------
 fs/fuse/fuse_i.h          |  81 ++++++++-
 include/uapi/linux/fuse.h |   2 +
 4 files changed, 375 insertions(+), 55 deletions(-)

-- 
2.40.1


