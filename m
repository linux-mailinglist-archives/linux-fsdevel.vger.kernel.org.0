Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1A72522E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 04:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjFGCrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 22:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbjFGCrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:47:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74333173B;
        Tue,  6 Jun 2023 19:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlhNwVvIxaAdVFMpnvPqSzXOpB38u5rB0aaXWw5n8JH7w6zfaMoOvhWw/DbUWGuPs4pq9N22mbZPJZNaT1912qqnfN8W8oLXYerDkvREydm9V6FIRKOBynd1Eb+KexR7PySJZvr/jqRD0+wtXavWeaVfMeAUQEWlfeWIPV2CT6B6L9loV+ClOwbu52F8gCrjKikxmpyNAJ+R/qCEBjTsXKSPZ+xDkASMiJxNGaKtFvVO0wOyoyiVvU7WOEq2lAY9zSRO8ysQ6F3AhmWghdNFbgn0Gh4gQBJoraKLNzm2yMz8hX+j6WOpS5PK29M7zFEmYjOdHSN96YhWjnVGpZlVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZNu1Y+8IRBnVLy/bXkS5dt7zifSuhXOuDieknQbEug=;
 b=mCTcvFDnJOeMCyIhsmt1TT+DeA0EUE3hQRO6fLMkY6+DEBSWhVjuRafDxeDY8La6FzAdKnf2BncBDBVhCp9IwEaWr70O49enCjQ7sPMZONoLRm6ZRU/zf7lJNSPzdMBFFba1P2HRu7lJU6gBc+Tc7ckXc2UxHvWHTHQjb27KNezaJjncY+F06/YA4ROpIjjV33XrhQfVdT9qY9liZtFx0QdNiLXuCO2EjjMMF4Dki7h6XP7esesbGPIE77+fASiI08JjLXShG7UGwXPrmZ8I6oTQo8WVMzZAe1lt3vK3sBqiql4u766P5XCZfW43Qd75mWXL7Kd38dO/cvfYZRTXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZNu1Y+8IRBnVLy/bXkS5dt7zifSuhXOuDieknQbEug=;
 b=Ne698keZAfKN1XYjANhXU5WtNfj6ICCOYWqkbE3ilzCyFvZVKTSMm/Nmiegd8ool4wKbOC3TiH5WpSSLTH+SNgVf0AKGyNKLrfACDgjOik3MiQi8ITzSbxq7QzHRnfDNqczephknB/C6fYyZjfvXkEMKrhLxoc5sIjFqmw820/eJndo5o9AWqsJFjaPlmQCaMO82mTxx9AsdkfgjFDAAS6B75ZAEwUidLe1LVuK1iyrORjkjcS1NGg2PC0A/TDg4yI250jHS3eksV9xNNyvT7/16fLnSkMmJFAEQRF5pDmAgFq+Xs/o2P8HRfi9+VPQ1tBca0AcgUkp+mxT8x5PH4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by TYZPR06MB6239.apcprd06.prod.outlook.com (2603:1096:400:33d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 02:47:13 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::6d0f:eb63:3c0f:e78a]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::6d0f:eb63:3c0f:e78a%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 02:47:13 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wubo.oduw@gmail.com, Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 1/1] fsnotify: export 'fsnotify_recalc_mask' symbol
Date:   Wed,  7 Jun 2023 10:47:00 +0800
Message-Id: <20230607024700.11060-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To SL2PR06MB3017.apcprd06.prod.outlook.com
 (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3017:EE_|TYZPR06MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf0368f-2500-4fed-4f23-08db67017ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gmq1nKH/XrdiJy4JdPw7Pxh6Q74Xo5cmQFvVNeaSfw/LZ8fjmtn2x0TVaJ7CYW/7xUfCRBBrjPiH2hbIY03WzhDi0BhOUe0xQ/xmSGY8/pitpcogez9JRhMX1g1vVA9RbNa3XZ11gE85q2dZavT7GIaWm6mC26zW6FH1ZtD/FZ9R7M4+oF/Tvk9zpyqKgphlBQq8//iytnzbl9YxfDwMUYMCHZQRNgj9pmalLpU3dIKaUi3idmLu440CMSqjD13GWGvGdh7Nohix7TCkjSJvdDPGN8rsfJNh2Bgog8VU3aaUdGoT29N3FMdqnV7lFfW8VhnTPA1p5hIg+dNDQ/tHzviQYea8mo2vSIpkYATwCKfdwQ5WhBA6O8IaF3G7VaMCxMcxQVqyb4wSqZtHjXnjVmxkZIfDtofq68T817XB1n4SrG6CD/URpd2DJKrW6p7UrbW5hzR529XaKaowu2dL+LD90RTeQkUxdZtweQr0sazDKsNFsEoOt0sLt60QZ68/2eoZf/ZL3WLqIzqwhLO5a+ZDx1xrDeXc3VWaTwtEzyHrTdyjudbXZoq6zolB2YYHZFdrrMNOFQtQ5K73R7geP+DudmIcZ0roa1XKrPvuPdOQbHjHo7XnSa44g0dkl+2f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(451199021)(110136005)(478600001)(66556008)(8936002)(8676002)(5660300002)(36756003)(86362001)(4744005)(2906002)(66946007)(66476007)(316002)(4326008)(38100700002)(1076003)(38350700002)(41300700001)(2616005)(107886003)(6512007)(6506007)(26005)(83380400001)(52116002)(6486002)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gFNiAsbABvlzVjBC057ctR/a7s5YOM5Fl9fcOg4cIo1ejTAshpJW2t8z9T36?=
 =?us-ascii?Q?KNDPpo22t9IELf74hLq9gxa/u8KP9elZNfXAqreZ83ouLiRbukiuVe9VTF9Z?=
 =?us-ascii?Q?wC9cFhjsCEof9xCJvaW/7YX7Sovl6ClzAetUUb7uFJLG43hYN1xzhXYEgUus?=
 =?us-ascii?Q?GPUxblG2Dt+3FlM5f22qn8EEZpZiK8wm6xu8EdvYiCBH9hclw5WxKv81mFWx?=
 =?us-ascii?Q?a5/oR7j831IvPvHp7TEJcBfTK9Spv5zfQ7Ue86ZV/x7bpZ+XHyY1NIdkf4Me?=
 =?us-ascii?Q?fGoYQ8b5NQ8Odesf2dyUrt0gPo1T0w+BxrfwNeXyG0hgoz4Z3tWdSn0PSbw7?=
 =?us-ascii?Q?FUtdw1ILmDcjqcBq7rIDVeLYvwJTQv0OGWxJyXJn6AXpqFlEPJpMo86XBXHV?=
 =?us-ascii?Q?YJviEeYAX4Dh7qg7I20wbAkhYNuR9p9NAuTnQc0xTcG16suuwQ71NG9c7dlo?=
 =?us-ascii?Q?QGUZGYvqpRnZ/0VcLOEQGUaA6hSTqpn3yjln99f+m8OyEtM+8AYzzbENnbIG?=
 =?us-ascii?Q?1yUWHW3u7Iob0t3tv2VKWz7GAje1nXn/kkOofTYv4OX0soqkNgM8OlKF9kST?=
 =?us-ascii?Q?SadP+Ui/jNfxxCKJNkPmlVEieWbXEqbPkZlWvw0xT7XD7826uxxihOLWDyr0?=
 =?us-ascii?Q?aAByWDJIGnDHTWgpD3qNS/hsfj+r1BBINh3481l3t9WwlPe3b8cZNBsOx7an?=
 =?us-ascii?Q?DvuyRi6zLN3JJZqmwoGovBYjNabIAkki58myS/yK2pUwIhE5eZKqygWMb9kO?=
 =?us-ascii?Q?IerBD7jtjm6LOrPi3NCBRWWqYPcZVmt7s0rzOlRmSJcXQ1ZCz3ccF9y1lGFQ?=
 =?us-ascii?Q?mSQH8CQULFuefgqkP0h7QkOPQ5RIz8PRQLJcLqx2A/aWJiiHeFC0AFo2V78E?=
 =?us-ascii?Q?9SQCUWPPEgf8FjEizVDlVQ3jtMe2zmX/8Z2pXwTh0Hoz7WVhZW4F8y85lqAm?=
 =?us-ascii?Q?PhzJEK3VdGp4NN854TDQq2QUGe8iEteIEUljUxvQdXeu56Rl+bdOrUjDV0R1?=
 =?us-ascii?Q?126yqSo0KspDS+SYrtX3FdmB2T0ZpJmzFMZPs/XVcB2KpZEY9Od4Cw6rK2AO?=
 =?us-ascii?Q?iSCKtecV8m/h23i4zwJ5LRD14q6E223vDze8aEPV8os5H35bKM8npX18lSxg?=
 =?us-ascii?Q?JyLkunW2tnk/BU1kasQkTip1ACUjNT44zelszk5ZJCviMTZxBpYEcFBT750y?=
 =?us-ascii?Q?JJqhZBp3wfRUHuWl+D8OZABUK+UXIVs8V1OOHxQBuXmppMrHCHNy8SeXDcPx?=
 =?us-ascii?Q?+UBNusjUNKHDwgZvH2erXknILZeovTvPeOmHp14hCPROpQ59nlVmxnP9gbxG?=
 =?us-ascii?Q?GTintxKQEDhdR6Mu4QzzTsVIlCfTjUIc2/6idRHNyDdbeyS5eGV71+RtTDv/?=
 =?us-ascii?Q?P3e9xWHqFL7ISvveRop0V5e0fDRn87da1cG921JvKrphzxXIFss698pQVruA?=
 =?us-ascii?Q?6iKVIE8/SOxIEcLSuZoZe8gj52SK2xeUZ3eFFV7QpSX9RBnKH/1zz613aPT4?=
 =?us-ascii?Q?7Zc46rrwKhxZBNM3OZSn9Dy+I0Wt8wXDeILAJSZvp77/V4bj8sezk3wN8v8J?=
 =?us-ascii?Q?Qo944WEYD5zckBesE814+8QJrYprDdZ26tDOBAzk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf0368f-2500-4fed-4f23-08db67017ee8
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 02:47:12.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AiP7Mf38RNy8gVSjAujkIg23Yr9GqcO7sBuEQhvZAOEGAeqJaNNFC5nPOdYjETv4/TC/Nwimh1apysa66+0dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To enable modules to update existing mark, export 'fsnotify_recalc_mask'
symbol.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/notify/mark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c74ef947447d..bc8f38c98bfa 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -194,6 +194,7 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 		__fsnotify_update_child_dentry_flags(
 					fsnotify_conn_inode(conn));
 }
+EXPORT_SYMBOL_GPL(fsnotify_recalc_mask);
 
 /* Free all connectors queued for freeing once SRCU period ends */
 static void fsnotify_connector_destroy_workfn(struct work_struct *work)
-- 
2.35.3

