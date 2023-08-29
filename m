Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161F778C969
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbjH2QNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbjH2QNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:13:11 -0400
Received: from outbound-ip160a.ess.barracuda.com (outbound-ip160a.ess.barracuda.com [209.222.82.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFA91A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:12:46 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by mx-outbound43-64.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Aug 2023 16:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyqIHvX0eHbmfS7EzVIgLEaA/2WaPgzfM9887EN8c6ExvwLwQTJuzOBL6vV8CQO1yoiwEav9Qk/WoKro4ey3lWoIkwNC8zy1kfxLiWn/W4krBa43KVdGhjWxSY0cS6k7tRdBn6dPj3UnDiPLJm7uuctXu6AkpR2xnqy90/Cc4R2vg5zkIiYP8O7u+oQxj2WT0vikwLDPCepRXspEiiu9MoHhaSoF/eCoobRNcQYVrIhXFHF5WNBbf5SoweVmV3gQpT3+PdrLKVezJULzZ/eYfPFsYWlIPXvzjsfMrubQtxosW2pJ4q3KxuH864F7D4WDEUWZFobut2awgjXANQlTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFpLa1q9gL/aDTSirSm9rpK95ZeY//mmAhNVuIOhp2c=;
 b=LOnoEyta3KSUbCFaphEchLgOO+EfklYEAGBRJfTxlzE6IfzUBNHzG8P+pkwwRFcBu53TSxHuqMuA/cPUiEOvjHLm0pH5qDNlmKz60vHLN9sKJRe1+1qshRqP5iJLtfjwyZWC2Gmx609hF+hlq0JhulfOOPHoHn8wElhhwEa5CRYPNPWpKxk3dGsoBRt5MqZzvlkZFGBMesxNwnJ95VfvzuMvvZQn32piXPQt4tfvUrZwDKx7DP0LzP8dOdJaYrPObKnIGpbmLhFhlMqBX/x32hYuYbAWOcmWmX9dNims06L/p0wN7j3iSm7Dj/zaMdxY6dlyEY8PU67z8GFbpd8VCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFpLa1q9gL/aDTSirSm9rpK95ZeY//mmAhNVuIOhp2c=;
 b=Bd8/uTqx/9ZU77nGydJwGh4xmuYGqdDYt3fbqpT6zeJxhdHAQ2unAhj29mpUlEGtJF6bbExobg0d47nYmedJ/fRhNh+waDIwbhsf7waU1V4TzDVP74seSytgsSalwugk6lSVECKLjCMZD2/Dpg85aqFQAVUDTQ+GL1WQcdTmY90=
Received: from BN8PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:94::14)
 by DS0PR19MB8489.namprd19.prod.outlook.com (2603:10b6:8:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 16:11:21 +0000
Received: from BN8NAM04FT005.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::b1) by BN8PR03CA0001.outlook.office365.com
 (2603:10b6:408:94::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 16:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT005.mail.protection.outlook.com (10.13.161.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18 via Frontend Transport; Tue, 29 Aug 2023 16:11:21 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 0509A20C684B;
        Tue, 29 Aug 2023 10:12:26 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/5 v3] fuse direct write consolidation and parallel IO
Date:   Tue, 29 Aug 2023 18:11:10 +0200
Message-Id: <20230829161116.2914040-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT005:EE_|DS0PR19MB8489:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a69cf71-da1d-4fa0-2aac-08dba8aa9601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQjfjT3ec21JBgs9nZ4/UK14nVhOh5iRIVLskFuVSE8K7eDB3KUis/Zdkt9nB0m678C/vuqav9nMObV9B2j61v3auyg1nnn5HpocfDGPFIysVHYu35wGVf/BEpfj6r/dvyHmpZnOzB8g0xppqGI9Bj84HZATPlV+X7aKCZR7DqcxNSyKLXTHJb/U8a/WPvYq7bb+FvsUf8tH/KrM/ugfCqx7uDKrfQyb2p18/pytTN1xfD/+S5h7uYBlyN/1sSm4/4m855ZkhQP5Bp/zv1Vh3kg5mCbhMo+pai08VqjjxNQDxLg6eFFehC6RODzJmArBmCL6j1po17JYc9PQgTIaLpIlX+Qoi39ccsWyVz5USmf0I4714/sjk8+MDeLbe8bTTdDP4EROJoxoSh53CX34r2wjafuOgHKIL6K7phDyX/RpifUwA3H9z0cqh/3wF9avlZ+un7PCSRMxRR7OfO+Tocz3fhUo/9XcFa19iUzM7FiGKbU5oXHVGll7MX8Kp4MlRKq4Erdg/vtQTSpc14JVaQNp+VBJcdqQwmiJso/OkerWb4yQ7LwKnEP8vZufKJxzwBDCbh0ivcz9aYwq8HGxjiFPN8JIgyuGNlUnYkosOLNCZXGRzQqqJwJp40CNiqfSwxD+LDV3+b+MV4OeLljI1UR2U5eRG7zIW5K91g1pBk4iXwTKkhKONnAjtQvxKSYAz+Kih/XaqB3pSpfpuR6Fpe8uk5CjsVWFEKOMffeyoHPtA8+XKEKtSSIWdLhXKki8
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39850400004)(346002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(82740400003)(6666004)(36756003)(86362001)(356005)(81166007)(40480700001)(36860700001)(47076005)(2616005)(1076003)(478600001)(2906002)(6266002)(26005)(336012)(83380400001)(8936002)(70586007)(54906003)(41300700001)(70206006)(8676002)(4326008)(5660300002)(6916009)(316002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R+Jst/L5ow5MkhGwjqydjeHGSdRw2tARjh+xxIL7fnPSkrWwPgsbPiYx35aEbL+Ci9wO6nqNdHsERNxEj6FANkczYcRfe2nkFVg3OXpAJXj34P8hG1qN41qczNaB+4k6rqo4/zNMDl0a7Jnji4tlzTxBVijB1bf46eA9gpDbyXQk6KrW92Xyy+Kyh6bWhkLyRMKCbVPU68V3eAFoRCg3QxIaxb8NnwXfN5LeSbMG4sVt5OJQxN+jukmnyh/HBOOD7Ajg4QHffOOkNiY9P6B5SDBqZ9hy2oEdZ+5+wil1K1OV8Nhj2tDrfvR2XcWGi7i2a/pHi0YgBwC7U7vkMJksaiQS2I/MhdHAEUvV5qLqhXTd0rpGvlHb7DdPLyp+pgigWWuXqQ2gSyWR3aXbHl3k5EKhXcK/RDERzwK/9cX0s1Tqr2cp7ilvEBUIjq0sX1wxzC/kzOz6Tl7TsHle8VdXnMXQmiRCNb9HXVobQFL/G4aeyRufpWDoutJ4S4MmEa2nswZ6tGLY/kAGp1kC87KcEBa0sscl28UhcAjtK/IlYzxhEBJnsDaBy7DaGB3AtodwhS5R8yj3YXSn05NxGhnq2Ehp5IGLSDpGYhaGOPBJkVCfMCgKOf5Qv633j5BwwFwbV90/YukQbf2SRw1erFAibRHuP+Z49kB+BE/fPGdiosIb9ec3MNbYJIRrIxKsgMDAUc3e7ZD4OTkUmFDVZ0F44dZmLcdF3smKha/7guQobuxbzigL2x+vRsrYd1WrU2AeObtUX2KwEwat/eOiWzsBfNlPMLB8ztt6KBxeYGXXgYKAYeEzBiB6/XvVHqnCUp3Bbmu+tgB3lNB2IaBs1Itbb3Nn5HrMtJr2B+h47iss7dTISLCP3mbmLT7KxWUrCRc3HIjr5PWLcj/fVdkP+rSLKUjPfg0hniDKfhJQj1Rsf8E=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:11:21.6060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a69cf71-da1d-4fa0-2aac-08dba8aa9601
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT005.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8489
X-BESS-ID: 1693325533-111072-1433-669-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWZqZAVgZQ0CwpxSjZ3DgpyS
        zVIsXS2MDSwNzcINncyCLFwCzF0iRJqTYWAK7521dBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250471 [from 
        cloudscan9-47.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v3:
Addresses review comments
  - Rename fuse_direct_write_extending_i_size to io_past_eof
  - Change to single line conditions in fuse_dio_wr_exclusive_lock
    (also fixes accidental parenthesis).
  - Add another patch to rename fuse_direct_io to fuse_send_dio
  - Add detailed information into the commit message of the patch 
    that consolidates IO paths (5/6, previously 4/5) and also 
    update the subject.

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

