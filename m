Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A527873C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjHXPKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242210AbjHXPKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:10:25 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998A71BF1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 08:10:00 -0700 (PDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170]) by mx-outbound16-175.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 24 Aug 2023 15:08:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9K8dWMb6YmirgIl7pWpQTIe4HWqYomGWdCvgk5yV0v38HN2wpt2GeJ3deP1LasdbDrRWZ6KfFEDhjeiD6F51AYhYj5Gj/j8ZO0vgCUYGPiX8EnfJvZydLj1IkbwEMM/9k9fuAufGMXmtKfYVew5ekIE7XdG9UJMNF/nx2GWP/8dlSW/w8gvALTodjMFIZQrJ07jEOH1OQ58J8j4V6a2ag7hGhyZyKTMCjnHDCL4jeuBnqofexgw74zrC3EcMGsgOVm5gsnzDxR2dUlG4et6qZXPDqRrWETv/NiUGmyUaNYKAeyFk2Rf8Zmhe7NUfSj+fFKgR9OPpqhd7VBRQCaJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYTYMGLyPTLPdlHR0LVNKruoB5rBv0wiSK3O1RF+wLM=;
 b=Bn+uSqm75r/vYIjQ73dJkPQ1pavgaJbwPiBd4OL/oWcjWZBN5zZSqIXNO5GbDz5fD7QU+o/jy8OYNGqdkzmHYwsOHiROzfAxyso7sjEDOR09SmBk8PKWcF8B+CO9KWxdwKSgdal1W7DKnhGerRKRD8zC16gxqYDlYph8ZPeL2As1iGb/bJL6n7mFJYF7VoxT/LRVU2qJ7sVioBDAV/APX2Va8Sjrzve3AdJliUEeacFRPNr//5zn1pTMTv4sxWMcdkRgJulpC1srrxl4PxAlrtLmduG2/97rbiQ3oPdvpNx3+tY9CRk43OfyKsNJFg9a2POo020SaxuAvj8K0P9Zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYTYMGLyPTLPdlHR0LVNKruoB5rBv0wiSK3O1RF+wLM=;
 b=QJmqhyR2G3bRK1O5b13VeGDTQmun3GLgbR50WXijmlYpfvpmRfxRG9BW6pZ1DT6fC3zWDpgSYoo2PcQ4UZ62fon/6COMmfzQtMs6ue6HV0MojgRrlA/VZXCL5UYfmjlMEAbH8T0xtDOWuPO6/NxTTrwyiCGpI+mAARdXDP2eqU8=
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by SJ0PR19MB5368.namprd19.prod.outlook.com (2603:10b6:a03:3d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 15:06:04 +0000
Received: from MW2NAM04FT048.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::48) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 15:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT048.mail.protection.outlook.com (10.13.30.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.19 via Frontend Transport; Thu, 24 Aug 2023 15:06:02 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id B8BA320C6852;
        Thu, 24 Aug 2023 09:07:08 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/5 v2] fuse direct write consolidation and parallel IO
Date:   Thu, 24 Aug 2023 17:05:28 +0200
Message-Id: <20230824150533.2788317-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT048:EE_|SJ0PR19MB5368:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e8fa7122-9011-4de6-df9c-08dba4b3a22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqY6E8ClM7RWGByPruPkc9WuWgBpHtvYPBXQBFATziLDMpEh38YjDYKcdMFxoZb3HRLgVg1td2AuygXZt9PWHIE7OC3NuSNJeEKuDua+Rt2In88HG1QcGshyrlqd9cyCei/3dLU8Mekw8h5Bd84VkPXyoh8De5rmyGDM1SKfz3qSMGLzoZzdDhrayWyg3oko03YnnLjhVbWzInbZRZbTW9cwuN65CMhcBvEYhVtJkpWbNbci2xzHOLx8WLkmd4kZakZ/2+3oRS8QPOk+7BvLYUcUQ7r8DMIOz1DbN2bOW/vZmR0NRimxGiS/R0KGH/gmH42PUPfF2Ve7lKUSvxhFtLQXt/gjjlbptfN3hR3/2w9khYJ+pd4Jc1iYVDxrysmNRjg2lAlTnvBaGKUGB27WhscX//Ya+IS8YUnNOVmP7jqVuyyND+ySAUqqqbFR5ECSIdUxRGda07uUKn1czOHUVtdhHAsRr8ckALI5gVX9Oo4q/V5wXkJ7KQxa8bk9jPSr95X0+2lkBU8WGdZWPACDmz3Ictra9vZ35LLzdui+S/pM37ldk76/Ufmwf1zFqOLxg7PC0PO4JPNnnwfQq3JatR6bcsxTlfVSV00NgIzXik1SPYsRrMYlXcka3zsMHum9D+XtkK1b9hcv4wPI9olYvYPizoScelQqmW1taUI4VDJpXG3EkoGrIeuGzAe8Gz5IrrzKR4gyut7Hz7R0rPi6K7hWxACAzP8bnhjq58zoP1W5lObo3pJLrZEkPSLVBp1S
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39850400004)(396003)(136003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(2906002)(40480700001)(83380400001)(5660300002)(336012)(86362001)(36860700001)(47076005)(26005)(6266002)(70586007)(2616005)(4326008)(8936002)(316002)(54906003)(6916009)(70206006)(82740400003)(478600001)(81166007)(356005)(8676002)(36756003)(41300700001)(6666004)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q78P9ciGTLNwfl0lOUJtmV3XeEjCvGQeKNv7Clzr2aYbnYTk9R9nl72Uz8KYM9Xa5UZb+Pr91Py0po/zpwDuNHSx8kV7fsV/eBmsdwzoeCP3z+HqsXAcYz9iwuqPRCkk8y9Pq9dEzkLes2sFc63qlHTvaSDn3I5XMo4oqrfaXo0+mRNKdrt2zRgEy7jTkOWXk4mh/TM0ZbGiOQL40CawMxt4eQjcLCBLfZ17e+J9Q0UCSd56jklulE77aX7riT+IeVEn/c1d22xc0FCCbL6FUvdTvvBo6axGJY+uK/jY19CSyD+YG0iSSY1aGRYsYqtimxzs2P+P9zKsA6HYeMhQ9Lr7VDE1a9G7JH/Egk3io2YFiwZiavRTmuCQBT4eDTtESvvEi2uj74J67hpNdc/N3n+Qvlic8/AmLd4zF3fcJPIbytjFX4b/YsoXN0fAe+Z2enBAroILPt+31bOg5QKZihI1GqZ2mB5D+qErMb44tGWIN2mUTb5yDEqURyfgn6idKVqR/tWpKhmdpxvBQfCTPgR+FEvbbm7Bl3nijUYU2f1Z+IL88OOK1DAPyJ/M3Q4TWDvSpLk1kYrWpRzlP0DrAxC1FbKvvlRCWndcUEmr7MWga+CvjBtZGsyrrBrQeSZoKKoIRNaEen3k0oR/9pi3XxnZd6VDRpVGzU5AD8JBLh5ooeuUH4DNOIkSMAgUYuEkwzRV8cilHuTdn9qVYiG8YvMXg6t/7ITvxbBABNa3wVZy1OgDZILvI/sMtnUzOg6ynyKurpdS4iCanpzsegcHiF8lt8Y6lpaiuAAd3yo5IRTowZklCXGOw6QH08+9i1VGDQTzBc0I/D/0QlOPcSaD+2xBa96YE3cU3tYUDz7dj0o6z1ULPU5M/UX3pDw6av7F5CQW1UwYZtd2hJgD8TJli6Mz9/8HYg+sYYd6EXaA8KU=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:06:02.9201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fa7122-9011-4de6-df9c-08dba4b3a22e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT048.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5368
X-BESS-ID: 1692889677-104271-5353-408-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.57.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamJuZAVgZQMDU5zcDU3MLUzD
        ItxTTZ3DLNxNAwydzE1Mw8OdnAxCJFqTYWANYSsTVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250361 [from 
        cloudscan20-117.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series consolidates DIO writes into a single code path via
fuse_cache_write_iter/generic_file_direct_write. Before
it was only used for O_DIRECT and when writeback cache was not enabled.
For server/daemon dio enforcement (FOPEN_DIRECT_IO) another code
path was used before, but I _think_ that is not needed and
just IOCB_DIRECT needs to be set/enforced.
When writeback-cache was enabled another code path was used, with
a fallback to write-through - for direct IO that should not be
needed either.

So far O_DIRECT through fuse_cache_write_iter also took an exclusive
lock, this should not be needed either, at least when server side
sets FOPEN_PARALLEL_DIRECT_WRITES.

v2: 
The entire v1 approach to route DIO writes through fuse_direct_write_iter
was turned around and fuse_direct_write_iter is removed instead and all
DIO writes are now routed through fuse_cache_write_iter

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

Bernd Schubert (5):
  fuse: direct IO can use the write-through code path
  fuse: Create helper function if DIO write needs exclusive lock
  fuse: Allow parallel direct writes for O_DIRECT
  [RFC] fuse: Set and use IOCB_DIRECT when FOPEN_DIRECT_IO is set
  fuse: Remove page flush/invaliation in fuse_direct_io

 fs/fuse/file.c  | 122 ++++++++++++++++--------------------------------
 fs/fuse/xattr.c |   8 ++--
 2 files changed, 43 insertions(+), 87 deletions(-)

-- 
2.39.2

