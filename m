Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6A7A4F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjIRQnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjIRQn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:43:29 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2666849F3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:41:43 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40]) by mx-outbound12-77.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVjfyTBmtFGfIFqex/9WrqsRUvNa6su+hlabbJbRAZLH/JZLRwdjNiFv7DaS3p/GhTBLBSIAu1syh/IBwwRoE4wevA0SPyz2f0yQf8Hlidfse7ghw8uj7zTvpgpRp7Y0etYzXg3fDz/WyCFuFQO39C2jjzTpCR4un03Z7b+AL0xjaucgZIkfxmnIext8feWoX9Uw6NeimSts4aCcd5UxYlPOfDza4si6XNfIz9ue9zw5mnHFIiNHPvU7IplXD8REAw06OFNAwKPRreFqi4ZriIXN/H25yfTAEfgBtOc0g+4f0DHsxhWDsN6cayJvhg/5GeTYDKeeItgdaB5LISmmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg2ljla5orAeTdEHr64acKFkNCGFrfBOpyLOyqLafwQ=;
 b=cIo0w3HBawqag0K+7APoYD7Ab55/bZ9mdZ8mXYSD4C1iyfeCrmJrswSqSx6lyMwM+mtwzIgEYVd8KhMVnlzLMy1CkcofFGnWC7DdO7cSxDa4Ovdl7njBGcCkCs6ScAGdr7X4dZtivRzvP5BiyeKB1AtWZSlZ3bS+SHUls/R4PRoA+5I73do9YDyzgQ9RPSdCNwd+0qiwl4YDAjKOl3kBjNVGXXWWSGsX5AyL4UYDRqYKF/sVeUwgnOkhzbADKIMkMPtUCwk8JCsi3ph6jUnqkGSIZ+Q5t3I+NRHQL43Opbl40pzAJ//f3AHpebr+8pRocfZED+L9EjMp5RJLnQFEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg2ljla5orAeTdEHr64acKFkNCGFrfBOpyLOyqLafwQ=;
 b=JuRcB/wzLMRNzIA2RCJd9acsd+5wr30DudpkstlBspOHZZ0qbB1xDJU+Mk+lxJvyglJryDaGFOmZhXol5zLBjkpZJbIX5MW+rrEouejoezZFb1zdiftRTayoZs0rfP0zeIDDk08F+EqtplpeWICXZnk1b6O1yo8JKdQrchO1PEQ=
Received: from MW4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:303:b6::18)
 by LV2PR19MB5863.namprd19.prod.outlook.com (2603:10b6:408:173::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 15:03:19 +0000
Received: from MW2NAM04FT067.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f3) by MW4PR03CA0073.outlook.office365.com
 (2603:10b6:303:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT067.mail.protection.outlook.com (10.13.31.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Mon, 18 Sep 2023 15:03:17 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 760FA20C684C;
        Mon, 18 Sep 2023 09:04:22 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v4 01/10] fuse: direct IO can use the write-through code path
Date:   Mon, 18 Sep 2023 17:03:04 +0200
Message-Id: <20230918150313.3845114-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT067:EE_|LV2PR19MB5863:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f79e517c-58b6-442a-9ba9-08dbb85863c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+lGyFx3+AS4gUsdf5RAsEKwkPIl5ZZAcaJEnz61Sy6XI07YF7VeBUGAaP+/j6suVrBsSMyoqwuJf31enWiqEf4dOs16zFOxhYN07wRfZee25bZ3QjuzQtn/rleTJGCcvT0ZaDReiJh3exAeAIapcR2JMWuzC6YB1dn5tPH+aMSFRgP5BE1d8g9eqb7mTc6qTUlIMYC6D7tNf/UVCdU9n5CfPzzkQldG73MrK7OEHy8eqeeDlN2726yvaxsMSrSuZNT7Ttxh/cEhhznyEwjgMsa/0hnKpb0DESgdEiKbN7KG26xyApaOM7oX9PSDe+Mmwk2kfL9PQPi9rjH3R4xPEpttep8znyzgLYYrNJzMuvA6pBs1iBKbCQwSMiWfHG5kbCAHn3oULj4JrAZYqUe6EHyuE3FnUkKf9iCgmxhRhQzRKmEJc0TQBPtOTFUNBSa645EFeN7+sdJPLjH2kk2srR9okgIuz8ksgAGf4PS17v/3/xggBjVehPNWSYjxG2vqzBgrsmK9ueU3Zn5Bn0I3rTwLgTRUenU3HtcAYdOt/yjfjZlwp4Qbn6/GmsFFp+VmgIeAUnMWpdQgWYKBeMxNMv/VPeocdDGXOdoTX7p+3fYVzu4V6hs1Tpi/lYbswK88XGAQ/S9Ud3M/Dlz+h7qy6AWt6+HRPHkzzHjFoJbWITLRBhMGbe2eb02IC/iRNew0fWfv77MKSsmRTE7OEwb+WqvyKwcjWfGZ0PNi2F5XONPFxquGAMZU34zm6/XLrwdN
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39850400004)(136003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40480700001)(5660300002)(86362001)(54906003)(316002)(41300700001)(70206006)(70586007)(6666004)(478600001)(6916009)(8936002)(2616005)(8676002)(356005)(26005)(81166007)(82740400003)(2906002)(36860700001)(6266002)(36756003)(4744005)(336012)(47076005)(1076003)(4326008)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 35eqZrkdh333YA8u+aoub0FhjXCmkqu1sLx9XcjoiHHjf0RpnATut4OqF8vuBWLJZM2fs+8i4faT2KtJ4p98JIO7nQizB9loqXHcuhafvW/qBEF/kFXdYpz6u01LrbRj+TIpJF2+ln2FARS4T5cwBC6/oLXUwpaph6g6++orbXVkrCFS/b9uTkh9q9uBmhmZkrp7ujX35LLpwqTW3WnR47laqsEVgzCCyAt4ZAowwXR5wn3HRLE89kdBxFn2+9SWRiM3JYmfnculokaQ0rM7k+XIPwUEBINAwa2Ras7ZsG8nbOV/T8+ekxywENvV6d57bJE664CkMk00KKj/7cStVPNUOgEcJfU4pSD18IyKUN4hJyzXBV/fUyKn+jF6j3tOU+8OeN2+iDUwJbK+F4JOXMzsoTboFpd7Uvm/WEJGYvdvzxuJdrV/CvFXkgLEzkwZt6R4tsP0w/Cv41ILx9IOMocNh+0jduHwsTtFWtWvnTydSAJ0ekiOo87SURYKrhZCekP5P2XhpCKQYOl2m1Pht9noBZWjDP9DfLABBSJxFMUNSOnRoz2FsyO6ZY72n4xF5pTKGAHhxy/E+ITUwOR8uJelWSe4fnQ5fvcoU0mLEQRQGC9sSQnauqCdYtbKw1ezmT2KnhRbGy9MnjF0R61l04PngO99ujOaUClkY6OkP6w/M983va09BBjPgPNnUint9NpMa187njI417l/73ZR765QzbdDAV7s1loNqjUlaYdUWwpM+xf7s6w+n5Fxhr9uyQkLEoYyVOahWpaUENCzGG1Hq16pRVAI3nIGEcvvszSDAkKu/zdhCGxu3sBeBzmcour65fJyvGkwQ+pNjia53LUWMZvXSAFEMMIdO2l+MVkRgq2Ak7NxmAuETc3lC6txAbgUJEs5RtLq/SMlpLZithWP3CpuZU9ZUYjEbmhpbUo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:17.2843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79e517c-58b6-442a-9ba9-08dbb85863c8
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT067.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5863
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055301-103149-24549-2297-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.66.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmBkBGBlAsKc0y1dw4JTnZwN
        TANNkiOdnUKNnIwszI1Dw5zSzR0FCpNhYA6dbNskAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan15-142.us-east-2a.ess.aws.cudaops.com]
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

Direct IO does not benefit from write back cache and it
also avoides another direct IO write code path.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..b1b9f2b9a37d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1307,7 +1307,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (fc->writeback_cache) {
+	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
 		err = fuse_update_attributes(mapping->host, file,
 					     STATX_SIZE | STATX_MODE);
-- 
2.39.2

