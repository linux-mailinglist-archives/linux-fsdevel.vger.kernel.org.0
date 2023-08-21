Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E22782FA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjHURsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjHURsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:48:46 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010010F
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 10:48:44 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103]) by mx-outbound41-68.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 21 Aug 2023 17:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6S7EjrP2Ol3y3uubdn5n1MJ/4L4hJ3NSx6v1/Q6UUfHScc75WnHYsQQdOBMZOL2RMrc8v+N8R1y/aFFTasteDaZwJQ6W6804Z/GAxFaQBEG7TWMq3eiL/K58ojITxsYkXYg26Tq0jCfwQG7GVRWSE5OO7Sc/nh4Ycc6vmsoRc521NwrHVOGFCzCoCtCnseAfCjyzG98uPJGwOlwdB/KWlDDO/1Rezj/1ocDnGQk3q1FjsiISCwSQlXBukrBGQVXy057QkT81GLff3UCPsXjW9NmFHBR7jOmt7VbPRUPS1x+IKsByVPRQUxNHwt0gcWLLOdbPt6CLO5d8Ig+4zEJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lftzyG3qlEfkN1FGeQs9Yk+Rt+U3QbATcLWSKeR8Uc4=;
 b=gYgCN0+iVEZko99V8F+OYKNGjk+JMbiVfdplfiREXbUs8FkGtuiiCZ2nDVUt61ir+m3cjF7e5sf9Gkcz7TKCGzRMthQ0FTNzZx3OsXuDy2/V7c2YrqcXQ1GG9PHd8eaFypaLpm8PR0S/u945gllZhiG4adHfS3okiVGB/tVbMmdefxBubdg7GLpelDz5jFSZBqE930Ile8xjzTtEUqFzE7cOfSwRZfmsPr83KXWvdD/38//6zT2IEQ6YfUOj1ewZzE3ord9NJALyKf+mxPv8EgA9IgqQ89wL3ShjGD+zrLodq+elYo6Pfp0WRnr31eJFqDsOWHqnKq1mZH7Ej7PF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lftzyG3qlEfkN1FGeQs9Yk+Rt+U3QbATcLWSKeR8Uc4=;
 b=v+SCnXeGwZrdfYW9O7PVyLBEVagp4ZpsRn4OhuQ1Yiditv6m9HVkFHDsEh/ZWtY0IxZqZQQ8quj8XJ5mP/p2Tya632clHThfWWM1sjfSrgNOBagAjiuwQqjoI6L5WdXWtskIOEXFTwO4vUwwGWj/TDzXbwgg5EO6UJ86xiG/Kc4=
Received: from DS7PR03CA0129.namprd03.prod.outlook.com (2603:10b6:5:3b4::14)
 by DS7PR19MB4424.namprd19.prod.outlook.com (2603:10b6:5:2c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 17:48:00 +0000
Received: from DM6NAM04FT055.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::19) by DS7PR03CA0129.outlook.office365.com
 (2603:10b6:5:3b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 17:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT055.mail.protection.outlook.com (10.13.158.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.11 via Frontend Transport; Mon, 21 Aug 2023 17:48:00 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 1B41320C684C;
        Mon, 21 Aug 2023 11:49:05 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH 2/2] libfs: Remove export of direct_write_fallback
Date:   Mon, 21 Aug 2023 19:47:53 +0200
Message-Id: <20230821174753.2736850-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821174753.2736850-1-bschubert@ddn.com>
References: <20230821174753.2736850-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT055:EE_|DS7PR19MB4424:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2e84bc4-8e09-4a62-fc2d-08dba26ec2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APM5A22u/BU3l4IAMrMzGVb/VppIxV8IGBkkY7d88DUPMhCoj9bPBddfC+adS+jtHRiHDfTQ5b7fpFHYXxjRX3pm3mPoyQFFL7Ndqn/oHQxikHf5pr52SrGZcaC5mtmCiZUYDSJoMrwPUqJ7idvASt8Zc4B/nKBO2TfVObu0wRvyJ7wSGkRXr+vWpKO271OLOkjpCDX0VyE7A2BiRip6wWdaaJiT6gd4pp8yG50iF6HOVJcoXVhrz9yH9nqdGC6Q08BcNL05v5GfdB5nwRpZzMttjr9UTtjjCSz6jO8wbnFtndPs3nP01Y1dz+3RXDWfHKx/XK/XViiZnedDSdX/GA6cb7noVrEw86mr7KPtG4O9JYBHogWIFTuglz7o79HSbTABqwBzwCKM5Rt2NRJVrjYo2P7cLiUU/0AvJL+5c2Ov6nmiVpMyFjXLcqV60OWsziplE6bnMYllVpxXTomVo71L9PtkOFccqXBFDfWj1cNvSmReXyeM5B6MYdM+x+kGdrVhSkw4a1GWPMSbAuvZ5YF1c8Oecf66DXUmV3UB+HfAGH6s6PQvRjEfSnnRHm5nfsJVbB+qKJh/ldx4qxqWNToYcJuDRNvgqeEdJ99WRu4amjecR1dt5eNW4ZNIrTh6CucPa9xKiHJKgPuwFYEE3jpMecFsizkx9GZ7Ym+zFt/mOTdocqdrHl1EftmmDLLki1Dg6p+8HlsOl8FZdLpA26FGlOfzD/kY56PtBA5qbqSjW3pSQKUzemxf+UOQwgil
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39850400004)(346002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(54906003)(6916009)(70586007)(70206006)(316002)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(4744005)(2906002)(86362001)(47076005)(36860700001)(336012)(5660300002)(6266002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?b8a9A6RnukiSS54i2hs+Z6EYBN+iRVz8MCvE1ovIPH0YujJP6VxVe7axe3Tu?=
 =?us-ascii?Q?DqTIU4j6/Sca0vjkolE5G7tiEoFtAsWKJaIaVG4DPyTLjWeYl+u7Wzapvans?=
 =?us-ascii?Q?TopVIlK0G/hQr0Dom0IXSfqBtSlUmM5pqmLABNfHBdreFguqYAQZm/Ee2+XS?=
 =?us-ascii?Q?V0MWSffJGa+ygFSgSfISf9Wbrb6Z8OAXk9erMQGQF7ep/iDq6vzf0vxD54su?=
 =?us-ascii?Q?AxYS6XHBQvJ2uLOG3qPQ17iMgeEDspEHbSezWXnS0GFBU7Aze07fIMgfWJ2M?=
 =?us-ascii?Q?yVdYBS5H3LljZTdz1z+DmUcGX+Yct1/O/2/xB1mhK8xsIFkOGWxCVYiN5jCB?=
 =?us-ascii?Q?tz6OljWp6WiRfM78y0uBrNM4RCp+NYsqXNCdCkbiC9YPlMs51lujlloWWViR?=
 =?us-ascii?Q?51E+Z9lmthhd9R3vfxP+V2c78poCEB6bbMw9M9sK1bHCHmNN/r3NCkn0Fp0H?=
 =?us-ascii?Q?aWw3Xj/kB3efW5XW7kU8SCbXpH84ticAWmt3BJQKatuFisrMQ8lsTkL6eDXN?=
 =?us-ascii?Q?wpAA5umCMQ1AptzqEGFtCHH7bB3dqmAHo5KNWnw/wAiRlPuU2i+GTzNysK3V?=
 =?us-ascii?Q?xcXlS6tgYpgePe6vzFG7d6UaQ/0xS2qHeRGvuL5EkNubLN+NzY7Hq1mEllLQ?=
 =?us-ascii?Q?JeSbW+HW2nR+5uKxzuG6E/sy3MdJop5aRrcCI2X4KSxqx7ybcH7eXoecNMx8?=
 =?us-ascii?Q?gOPciXrxySF1oji9Ut14UDyKhOc8pL2OhbHA/bix7B4uSYJahnue0hsJcWvR?=
 =?us-ascii?Q?4Sjq4umnhBQdOcs7NRLgnyqFZC2IlXJFbeLeaHuBp5GQDKV/vL1cdGxV+rMd?=
 =?us-ascii?Q?hZTHP1lHsKu6CUhkMK23tkppmGuzk6wWnNvGZeIq4Lwy+S7PORRfOc1xgAvz?=
 =?us-ascii?Q?Z807ljAOXOwApaLGt9xu784wBCK/VR7E3vTATdft19xLB95mzmuOWOxFvN2+?=
 =?us-ascii?Q?QqcmVLZJ1aiNaq3BCky9DFZnUJhAuelXHwUiAYfPjT4=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:48:00.1771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e84bc4-8e09-4a62-fc2d-08dba26ec2de
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT055.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4424
X-BESS-ID: 1692640083-110564-12426-5649-1
X-BESS-VER: 2019.1_20230821.1520
X-BESS-Apparent-Source-IP: 104.47.70.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuamxkBGBlDMyCjZxDTJzCAlxS
        LV1CIlLTXNxNA8ySDF3NDMPNXSxEipNhYA/dsEVEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250295 [from 
        cloudscan15-134.us-east-2a.ess.aws.cudaops.com]
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

The last external user of direct_write_fallback (fuse)
is not using this function anymore - exporting the symbol can
be removed.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/libfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..db106065c187 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1653,4 +1653,3 @@ ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
 	invalidate_mapping_pages(mapping, pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
 	return direct_written + buffered_written;
 }
-EXPORT_SYMBOL_GPL(direct_write_fallback);
-- 
2.39.2

