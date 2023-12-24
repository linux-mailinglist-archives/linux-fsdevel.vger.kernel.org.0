Return-Path: <linux-fsdevel+bounces-6870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841E81DAB5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 13:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BED1C21239
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743ED6AA4;
	Sun, 24 Dec 2023 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ldYnWSNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB016AA1
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101]) by mx-outbound22-58.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 24 Dec 2023 12:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3huRupwIQzpgnlZvYrvESHN05HluX4otes76zO2YXzcoJ6eCVhaLVpMfgaQmhfkOHXF7HFv1G/CCIOgxmgeeADpneZ+OxKNaP+83zUsW6JgfzzUEequKjucm8fzY5zZK/sIdD7Jk8w2r6GCocAD22WalvQNUYj6e7xuQRd7mgD2Vm1DxTAyyH+dQgV4IBvS0dud7i3B+aj5yi53OGNdsFMvCPtnjKKGRUgKCoDyBdN0qpoUoUGd9Cl9RApTVnU4Jaj9ByvwiXYH/Fbobzp+ImT3I5XU96eXOwowrc9jsm2CciW+IVkRJzGBfhjyPjqa6AAMt27lEcSlSYat9+OSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Iuw+TDDrslDQ8x6aHH+YIFSKt+5V/wrSvl2a3hsw3U=;
 b=KsfEJMnOfGU1xVQs/K3R9zGn/JRNsmLJrA6oOepPf8yc7DINnbYcIVcSxWfcmY2D8BcrXotJa/EDMMq6S8fKba7pnFal5mPHj/xERsFjOidpcFSRi+WymcwSyh2K+hYPjq0iIkOu95wuSP8rzGx1fSUSjd2MRrzkTUBUGRSxKp9D6rX1L9y9PdNWP/bQMC4Xl9syD9meqMH2nDmwzV5dHGAFys4ZeIqwQgRGp/1FlEPTzsVJU4FOyLytT6hmbg7s6phS9dnS83DYm+1X6EEDLBRWwhGJjCQynAIKZpOmAnF0sAPV8qC5/d5W8Rf8P8hi7z4qFfpU7RR60mWp7EaHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Iuw+TDDrslDQ8x6aHH+YIFSKt+5V/wrSvl2a3hsw3U=;
 b=ldYnWSNNkYxLE9F3/ICJdYZF0O1utREjAVqgtKMnm7W1BBAApnEZKJk9pwU5JiIWSfd3fFs4JohVGVStWrgRr/nd7ynI7Wn9zGsX3B9dyYQ5S9gNXlAjfI7idGCq/q1a48B4QVcv5xQHdFVwUWVQqTr4r11SYQSqAylKFttSKQg=
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by IA1PR19MB6226.namprd19.prod.outlook.com (2603:10b6:208:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 10:49:44 +0000
Received: from DM6NAM04FT059.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:1e0:cafe::10) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24 via Frontend
 Transport; Sun, 24 Dec 2023 10:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT059.mail.protection.outlook.com (10.13.158.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.16 via Frontend Transport; Sun, 24 Dec 2023 10:49:43 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7E38820C684D;
	Sun, 24 Dec 2023 03:50:45 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	amir73il@gmail.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/4] fuse: inode IO modes and mmap
Date: Sun, 24 Dec 2023 11:49:10 +0100
Message-Id: <20231224104914.49316-1-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM04FT059:EE_|IA1PR19MB6226:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6840c077-f648-4964-e313-08dc046e09a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i6ZT8wX24DMv6bEkpndt5MfxA4uy0Up3MBnugNJaSKzOmyzr6DFTaPYbFqNwn60lGiR3MtOMMhhAS4guMH9pez5rSqHv78TFTXEE5ymQYHlWO82a6kAhd/J4aSJ8OjttXqFhGWyGf+iYBwxCNaea4+T2vl8MD98flSrtBRtsYTNKXy6V52iJx3h0OzgR9GjZxW+PXDJhQGSMOkYGquRQBfMc80Dn0iCjIHzRqf1lKs50trc4dJ3XJkFoW7Cgil3g4aEPeqK4ePIVeDmCcURqyu9aQO/qkpM9N0pzElPD/HOdc1Bw54QbR20EqSIRJRx9gbtGNA7Iim9lOn5OOzGbXGFFMEgsU/Q3qnDvaEV+vXp1nb+JJPTvh8tNGrsNoWqlI4ekAIeVDfEkz3VFkm34S/CXiftDVB4UGGC9wfoVQXyOc8MpRiyTZK31vd1MJlzVivb7y9ro08ksFdePCt+sqzbRaThUNx7lvAK0rpBI6XohnH0MaNK/aBjTVHtPJSB8SX31YkfAgU9QigwoOFGOrZ00cGQmv7xAOucvxKzm/ZfCdspmdaNjOY5rC9rJnsvEv74wQ1eZ0je/D1L6A42cpz2dURvNQPG3KCOCOxDoYVcYAgt5V7bvBwQhJAoK7HAoCLs1Lwk7o8kx3cl8opfyTBCKPTOPaqE5pJPwZdYxLdwKlL/eXuLMMcQT40u2xF3CMkXEI6RRVdk7xb+Gl63Za4yp2HU4abhu2G6naWL5Dss=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(478600001)(966005)(81166007)(70586007)(4326008)(6666004)(47076005)(1076003)(2616005)(26005)(86362001)(8936002)(40480700001)(6916009)(316002)(70206006)(8676002)(6266002)(336012)(83380400001)(2906002)(41300700001)(36756003)(5660300002)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iY5iRH2P4vGf6iyC8oXD3/aYyh7fcdZoRm5TRIPvXJfefYF8b3PBPeKgjZb6Y6EqJYtyZDHXsEDO3J0blGsKOEMMBxFUfCocl1dnVBKeqEce2RzE1BhoK1Zk3QdAg2/aKj8SdoAuU2yHUx7tCnZQAefJHL/FZnW+RHOTa3DkT7pZnT0CnoF4TJiYCITY6DGNxiPvio6xRrlqZBoM3OzG1WzzGZ1CY8aF8Vt3GDQYDxfhwWCzituIMdFy3GnGVu99leYXpRW6Qm2Q6jsU4pLkxBxs5a12uZS9MShHBQkNzmrGMPL9NFn/KOG9yHTrBigUoJXM7qXSE1RtIO8g4Q0dfa21tjXWVDxHNfrSTBew1qmemPgRUOvtrIyS5tHhq+2ARrxtcoryBZd3twWMXuapDLtWpKXkPUqRQ453DKNWA9af32jxf/Z3kZrWpIMDn+JErQ75o/lr25xv0+V9JVhLpoDmSZ0EFqlfoW50JTQvhehHoI0pAAh65mTFDWDWzu5S6OmCqQ+mme9tNeB4jF5NtzzZLSGc4bXAZ/XaanahjcFnGox1swLTJdncaBd16ywdKylSXCq1XqOkVWeb50j17Fph1zkF4ceoQmGDpNAP6s4Hbpl5JBU9b0GqP5PuEk11xVh356XsPd0JB8zeq2T9Tw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 10:49:43.3504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6840c077-f648-4964-e313-08dc046e09a1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM04FT059.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6226
X-OriginatorOrg: ddn.com
X-BESS-ID: 1703420623-105690-18954-18438-1
X-BESS-VER: 2019.1_20231221.2126
X-BESS-Apparent-Source-IP: 104.47.55.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZm5kZAVgZQ0MI40SQ1ydjMxM
	zS1CzF0NgozcjEIDXZ2CwpMSk5Jc1QqTYWAMSjBUpBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253035 [from 
	cloudscan12-102.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This series is mostly about mmap and inode IO modes.

Patch 1/4 was already posted before
https://patchwork.kernel.org/project/linux-fsdevel/patch/20231213150703.6262-1-bschubert@ddn.com/
but is included here again, as especially patch 4/4 has a
dependency on it. Amir has also spotted a typo in the commit message
of the initial patch, which is corrected here.

Patch 2/4 and 3/4 add helper functions, which are needed by the main
patch (4/4) in this series and are be also needed by another fuse
direct-IO series. That series needs the helper functions in
fuse_cache_write_iter, thus, these new helpers are above that
function.

Patch 4/4 is the main patch in the series, which adds inode
IO modes, which is needed to re-enable shared DIO writes locks
when FUSE_DIRECT_IO_ALLOW_MMAP is set. Furthermore, these IO modes
are also needed by Amirs WIP fuse passthrough work.

The conflict of FUSE_DIRECT_IO_ALLOW_MMAP and
FOPEN_PARALLEL_DIRECT_WRITES was detected by xfstest generic/095.
This patch series was tested by running a loop of that test
and also by multiple runs of the complete xfstest suite.
For testing with libfuse the branch of this pull request is needed
https://github.com/libfuse/libfuse/pull/870

Amir Goldstein (1):
  fuse: introduce inode io modes

Bernd Schubert (3):
  fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
  fuse: Create helper function if DIO write needs exclusive lock
  fuse: Add fuse_dio_lock/unlock helper functions

 fs/fuse/file.c            | 268 ++++++++++++++++++++++++++++++++------
 fs/fuse/fuse_i.h          |  76 ++++++++++-
 include/uapi/linux/fuse.h |   2 +
 3 files changed, 302 insertions(+), 44 deletions(-)

-- 
2.40.1


