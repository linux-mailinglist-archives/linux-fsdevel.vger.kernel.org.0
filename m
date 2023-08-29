Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA9C78C963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjH2QM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbjH2QMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:12:09 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E18CE8
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:12:00 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound14-88.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Aug 2023 16:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWj1W2MajOBUzlkvrKD83VlLEe0NSOT2PhNZ/ziz1siM833IO22hjflW+VCataDfCDSsfqUyJhcwJ2fU6pzDeop5Devm0GwLNdu7OKjg9BifX2PP3WlamvVMQHvDO20LY2gbBg5D4yJ0h4eUZ3RcB3K/1HmguhZx/pqUVcAb2G5FoyqUR/g50TdHlG5+N4n+z3e9bMc4xdQV1D7YAm8H6Z8WYDRstGvt90KrOxl++z9xTmyivdodSi5ptDzAiDhZRhy7dXwfOwtcXzIg0dHo8Ye1BXc+//b/i2WmHYVHaAHTZdLtwNywZ9LfeqskoS1Jnuy5p3f8A6LOkZX/W7X6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg2ljla5orAeTdEHr64acKFkNCGFrfBOpyLOyqLafwQ=;
 b=Y/koRFjM0q3aKnlyOnced7TnF1VnK4OwMLWmnsKY4CCSgyf9T0V0EhQFGKVc4B+9/+o5dpod++luruVUnvjSJ+iAGY+xxPpY7KigjInkaQjNImufFNI0k6sesddDbqUPPERNM2Pm2ckQ8UAkdxlqcKqIcXoFNbENVtWb+7Cs5HsxljuQ8/MnhrL9FPwXnH3BkKEaFio9Bh4qQCHiHxw+Elg8BYrWYUBhGPaTK5XGCkI245IUNdYsTmICtHeIJnOG96Li7gKc4aCgsCrQ5k4Zj5RN1rdSdbDihsuw2MuxHJZRyRgTFnP7zRR52oKFYcuzV5NHsMYUjIgJgUq7v6kriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg2ljla5orAeTdEHr64acKFkNCGFrfBOpyLOyqLafwQ=;
 b=smVP/5L8xVlAfr4H4Oh71fRwYu8UveBNOOHH2ih8YN09FGvcPuJyhBbpJQqVqsZcYn3xz+mcEJF7W3ynYVmIk4U+t9/jCTYydUArnwTUJfHpY58y6IWOEtv8l9BkFsLC0pJDTKODM7wRL1hzehea/H5CtPtP5C35EU7qiaFJRec=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 MN2PR19MB4128.namprd19.prod.outlook.com (2603:10b6:208:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:11:23 +0000
Received: from DM6NAM04FT006.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::1a) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 16:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT006.mail.protection.outlook.com (10.13.158.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18 via Frontend Transport; Tue, 29 Aug 2023 16:11:23 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 0117220C684C;
        Tue, 29 Aug 2023 10:12:27 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 1/6] fuse: direct IO can use the write-through code path
Date:   Tue, 29 Aug 2023 18:11:11 +0200
Message-Id: <20230829161116.2914040-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829161116.2914040-1-bschubert@ddn.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT006:EE_|MN2PR19MB4128:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8ef55158-3bb7-4ed4-1030-08dba8aa96f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVdmN0/ewPr0EFiSBG94WwS2FwZ982Svxk8rPyNGvjjfyN+VC++m4uI+zU9jpIpqXpjCi6CAQJui3IXeOtqbAhPlryn7/wVJeIL8ca/UK92ycByRogrS2A2IajcGYBDfd77CetVHEWHKFrmCePT0BukdpMXPnCEO9fLl3eIukovVsn11Z6Reo/jkOEitMLVV3xPx7FiyVySTr89rRjgv+ikxj/Q0b664GkbgiujPjJGQ/ljl+mhtM6nNnidc/ZkV3+jpzCm+w5mks4aDjiEC76kgY3ov6i02sDHgToc8vfPl0mKe0d6DvFhOU3S9eK0s6bZLYQjc5G25tcnKCiTmCGktGV7e+vSFTMOFZa/DPtKOSoJUtWrP43xTFwnpxXV4m8BBpIGDDdZJPyOQ/PEsAJNJMGy9VWvZ6OgOqRUqScCxaDbvkUR55HREonBlRzZqGXJqp5qvPfRyMvPouhCUy5QEZIcqqlIEbA5VPBTH4geWq8DsF43hT0aIZutsXXFcutqo3DGq2G7pi4hxlmpi5zuvaYqK+jWC8ft/EagIXypxyO071JejmLDbKZwiLPyPxOZ4/f/NQqdEICLya9mTZcR9l3/Lr8ofXHF4PjKVCCRE4gXq2x/U9Qvbaw83ZYOgog8c+jutK8sV+Ba8yhMXOEDBoT5pWUaoHv+jglMtyQgMA/80Rh+fxVSXrBQM+xkR+yYJacZtAvzq6k8IBHFGwH66/4jAsviuakFYB4uoKsMJGCQszG67h03erIni4ZVP
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39850400004)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(81166007)(356005)(82740400003)(8936002)(6666004)(70586007)(70206006)(478600001)(54906003)(6916009)(316002)(41300700001)(36756003)(26005)(8676002)(5660300002)(1076003)(83380400001)(4744005)(2616005)(86362001)(47076005)(2906002)(36860700001)(40480700001)(336012)(6266002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: naHdJT3II/afXTJJxrTBXD91JnRb8vb7T5FAvsSO4fNXPzvdXUyOuOQZcOpxeXTumJm9mHFHQ/zX+MYv5jEN9AF7nbyz+pDlfcpSXtREbLxge2pocZOtNkHggryfAFhodxdS+LYJS+XhAqRZC3bbroWdatRK0ygtVyp6UMzI3G8iZZyVGKddQ6d57w61/KWzFmx6DR12CsDy72gjBcOB3LadRp1SpPVDchsvFZLpLURnYTomtYKQD5rXQax3v6NkWHQ/iRr3svL1mVrQgYzFHUFNWStsWSKjf3jCSzmV+6O1vryHuLhJcbGcQFe9owgM1GNXRpTPlfKSskF2SuIDbjCAt64Sml1e/7JzCEy09H5KKSIVjnALpQSi9o3u7YuCptoWfuCuArLFIWEg1YouOAg6xvMnEeYYA5j+yEj4KIHSYuObOMqhnkXO0NB1R3wiJ7NQjLTjpU07Gec00jh787mXgH4+GBtc3pMtt1kSH28JszIWnWZ4bfnFZSA49dwJAi38SuPBzcZv/02IBo0lV9KI8FHSTj1I0AGFSb3j9j12J489A4uCWiHsBknwHLeM8qnWvAXryN2tCzqMAK3hsZ7wtg/6AU5b7YjEVmC2QvroC2LsPI7kU8du92Dy8rwxDHSw9PnTzmBfkVL5+kPQg7KkuhvNCMuWQ39MmkGdp5H2/dx9VKND1RPMWSBxXf/2dwClqxNBEHvTkMZjnC9NuiJ+KJf+RsuTO1j32gaBVYfQ8lCFVH480HMRIFNvmJ5ljnKxiJbUDyXN/TEE2iIDVKc4w6C/zD+KJL2s9Hwv3G99f+sA2k0szcOlpxCQA2mU/RlcU7Q6qtBBh9kl7asXWTvgQ1H+6FmwOt8GiFUDFUYC3G4E0Pv0EzFKYZb2tKZJX+Iya1JlDvzcGeYj91m536ku5LVy0RA51JhpI77bpqE=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:11:23.2628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef55158-3bb7-4ed4-1030-08dba8aa96f2
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT006.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4128
X-BESS-ID: 1693325486-103672-9596-613-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmBkBGBlAsKc0y1dw4JTnZwN
        TANNkiOdnUKNnIwszI1Dw5zSzR0FCpNhYA6dbNskAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250471 [from 
        cloudscan22-13.us-east-2b.ess.aws.cudaops.com]
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

