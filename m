Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8416B6DE9DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 05:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDLDTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 23:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDLDTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:19:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15910F8;
        Tue, 11 Apr 2023 20:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrdgKy6KYJmk5+H8pzbm0lh9bOcf1bruD8Ge+cl/pB/MWSg+BM2r2BjCjKRQOwmh5+hCrOAv8QnZYGgjHielfUM6qnKqcsNHWFAPMEKJVin2GpLVXEwpTh/IX9wmoNjXD+b1YeNngIql4BcSt9O8GBe8Qndt0zlf2IaR2oOCclUmHQWcKMDS5QQhrGtzs/YuTSbJszBqCDZcNLjxnaBcNM+UEtp5QzUILGnDSwv+1mXywtq6JOe8ijgLoVGU8EWHLQGaaTuGlQnkDUhQkgagqf0Mic3Shqp1Fd/qgm1loqEPB+tCxY9WMs+EpsWSKagcUJW/W26kMpmyutWEYQsMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/XAATz7Qf6xVv95kgrKP6iKiYSa4DUzHwDzSuFAPzA=;
 b=ZVt80cHem4jlNgXKnX0Bys9MmMBSQnYUHahVyurLD6LgmXLidEvkUQ7RajuZa9nvR+ShpcgFe+LjKzWZnUQWlvQro9QmOVkD54m2bdkgTjdaeJbE/s5SNsszfhhQqSyVMiht67ZMlOciALN39sRzzf+jdHwwA3m1YKb+fRF2sUoNfAh6Dm1+8MglHvJTrF2FZwKTOTFHLNF5Rc2+NwGxqmlhvCFRMYLvwk6vRZsnH1WSnHe1SUyErh+TkDF+8KncbmMw+Ix92jT0/Y4/NY2YyO3whEl9vVbyrZz2stnZjLtHcf0WazZ/vjpfziKPan0wYEM/cW9kHaFOfqxw1tnvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/XAATz7Qf6xVv95kgrKP6iKiYSa4DUzHwDzSuFAPzA=;
 b=JCyBFSNTg0K1Fv1UcY4uxXQfaVGNw4rf4YItMv+ZyK2hdxdVbAmcO1l/cOrIAlavHwSxR6lxyPSTlBTb1M3afkcu4lG/AXpT+Wm8K7xCIQaKrNbQqhNVFiJ2QBCUVGAIGuxzfatw3MumisgeNfrZs4f1lpTyFU9TJDPylbg1JY0BtvIqqgvSZmqVtvRq9bI4cPvwmttc1xBnhdZF6s/N5yO9DiSfoIHt8HKXel3RCo0KenlLmXfAIUvnQeD8BTUz2IYn6SJ/LCJ5Wp0EIk6+YhLwdA343j0B/D/GILRYFeWab/4808oesHhMsSVvFrLunnSmZssAgXJr1w9eIMbvTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5681.apcprd06.prod.outlook.com (2603:1096:400:275::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 03:19:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 03:19:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] zonefs: remove unnecessary kobject_del()
Date:   Wed, 12 Apr 2023 11:19:04 +0800
Message-Id: <20230412031904.13739-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bb22b2-4324-4349-853f-08db3b04b290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jWBntZ3bvcD8VqpW3lVq8oE6CmDBdlIbAapIwq9HhXVa+ow2krL9imXelbxTcSkHT+6tDhEoS5tTlSvX1F9XxkIZQuE1CBgjAcImi+ZSWwkIFAFI1lH0PA2th6WSt41tLbbeDt/wlN04WyhnP0MF0UQeRqqNhw1beOV10rzkDhGToJL0YMAQnhk/x1I/Kvo8O4Agg5OVNhLigfs5aU+WSMAbIhpPGgtE8UI77jKNQYkPicgB4Wxs7GqmWQLyv+dkRz14mvsFNt+kDTg36bL6QFe6IBwt+E/plj3YQk7yEdpXN9bPGRtWUdAr/g5DR9riSnhbSRfof8VQJc9qhr6rd9JgG9a3HKgZvaajYHS6KCICMIlEZ/nzwFtIPgh2N61T6c7a3ZvKXa9Dbry4yrMevg5aaCRiOGxTLHzomHPa+ARG24ILXatjKXNyt/IpC+K7vU2ASe/hEnEJDS/L0Du+D+5DUY0mKe9pAJw5OQQkmtPd2K3PQtzFh9VBNiDBGzLVKOUU5LMcpDUDVWj3dqwkq/KjzzUH9mB7OuQxc9tN1g0MsKPfZj9XCqbfLFFKvs6hDsdBi/7MOPzh/pReJrMJt+3KEhklvm/zHgaU1wPX8VJ85r19+i3BvE2QIUYmmcg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(8676002)(8936002)(5660300002)(41300700001)(2906002)(4744005)(38350700002)(4326008)(66556008)(66946007)(66476007)(86362001)(38100700002)(110136005)(478600001)(316002)(83380400001)(52116002)(6486002)(6666004)(2616005)(1076003)(36756003)(186003)(6512007)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQB9v0uiPNpKmLel6DigxBRkL+2EBZm4OvLI9N5mppqa2BulE3Wf2Z4ouXM7?=
 =?us-ascii?Q?FREPauLTXU7GyYqXMtidDDfFviiSP1P/p5xflMduRw+tIkrulGl1R6Gx9gWI?=
 =?us-ascii?Q?4WPfI/ghsUIcFnTjxl1vlmlUGvxwoKmC4sG3l2lKbbtnsN73Ci0i3lpMtkL6?=
 =?us-ascii?Q?nQeUF0GNTnMbn8ARyJEnzCtnfKGCjuLXBK+AFHQpQra0CshO8Tl1JbtheQL5?=
 =?us-ascii?Q?OdHU9ISaKYNsIQytiGMei+aRvu0MTEH2Tm7Vip+SSzx1GFSCCJZHYPi8+wnP?=
 =?us-ascii?Q?rPTI/HLSKLyD3Aiq50D7gllkaK8YmDXK/L6qvovy09BmZMBhPi46WrpxQiSD?=
 =?us-ascii?Q?+YcnVntv/NSrrmi+gLazc2AAt+w+xVBIHaLDh8uNPcFj2RLKvD8j27RJtISH?=
 =?us-ascii?Q?4IouhUB6hVZnK93Q5oadVGjsjN9LwQ5/vfEXvoz+9MQFw6EQQRdz9nDmcUVA?=
 =?us-ascii?Q?Sswynv+03SQaa4pf4NBiruc77mpJmcr0T10UJhYR6zpCthEuwZVPFIuIUJiD?=
 =?us-ascii?Q?1sL/YO1i8k5y+WzKXw+JTvlYEVFGW3N5u2IBbnkBjkCMn3gymJgo+Oc4bTdI?=
 =?us-ascii?Q?8KEjlVYLrOEE52uxK8t3G9FdGF7URKyx0PSrjRW6ghHk8mSsC2nmsDJmalv0?=
 =?us-ascii?Q?Upe9wX140tFvLq0Ghrx95PJiyElRNI4e3mDh2kftiAHKe9jXU5wiEFWiQksC?=
 =?us-ascii?Q?azTqCbKGqi9gZAI/aKJDUawl6V2sAABoiFZbDBA630sLJ/0QTqxL1Z7rU+q6?=
 =?us-ascii?Q?moHHhB4aJn0YaYaoArSllUPzdx3lOoSru0Vpi4mrw0PO6r15H7R8c12AIccJ?=
 =?us-ascii?Q?PyUEqxct8atsl43zMNO3Efxs8X3wEqqPiQBjo1SvdFabgynLIxwuQS01cHem?=
 =?us-ascii?Q?2z9F1kEq53GLNkEjWN4ID5mejD+B4fFTu27SZgDyL4JN8JbzqCpHsfqSVydB?=
 =?us-ascii?Q?WjTbAqKjTSleGwPm073h+jQIjCcT0BdcsT73pJa/8RA16vcoR83zr3ViiSO+?=
 =?us-ascii?Q?ZRMtKwiFO4VzuTFZSwoWkpEcISP+ww0hNDGyqpRi5f8CDjts95J0epgvdnMr?=
 =?us-ascii?Q?rv2yaGEYaX41QQ3BIoqi0HYPQTprHlioPOGAeYuUrrf1cWPMpSam028EKfd+?=
 =?us-ascii?Q?qcmUiLMgo8zkuG5usMoovySj6a9xOpr4hLXwYKexD/gQsO3r5MqZmMO1dLLQ?=
 =?us-ascii?Q?6QmxisWCA7hbZjdSos40wvfsc0fNyyereuZYaTMPCYyNKMzatrUgA+7l0VEZ?=
 =?us-ascii?Q?vhy9eM9KvMu1Rw6XrIWsuuqGwP4AjOJntek/9Hc2Yt8rV8f5CkrHJrb6XQOj?=
 =?us-ascii?Q?w51gnnav2B0lbkEtVmOW75MIY+wROitND0F8JJxG4fHHkGOTYuUN4UY8NNBh?=
 =?us-ascii?Q?fHImjFcGm2YRqHDaqosT6aI+Njvm4zRB9D0H2N2IGSmWrFC5T6xYXIdcohnS?=
 =?us-ascii?Q?7fC3b1UJUvuGgaQC7mP0IHHxC0eEFBbeQPXMDX+HpARnBbqOJm2h2SLZ+sbc?=
 =?us-ascii?Q?skQy2MFlxsVZ8kwFIbA4DAYBospl65YkFnMH/CIuZT/nnXvMq3QFE8CCkb1C?=
 =?us-ascii?Q?VS+0i6AfAygYgG163SDQfveSvwLJaKsvkj5msfTc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bb22b2-4324-4349-853f-08db3b04b290
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 03:19:16.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaAkdNzqnatCTluQtjmRc3kzCUDsj/APc3bPCu+yGYfm16Q8evqbESSeZztiCN1NEnOAIFf/zm+QQGJO6KAxog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kobject_put() actually covers kobject removal automatically, which is
single stage removal. So kill kobject_del() directly.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/zonefs/sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index 8ccb65c2b419..a535bdea1097 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -113,7 +113,6 @@ void zonefs_sysfs_unregister(struct super_block *sb)
 	if (!sbi || !sbi->s_sysfs_registered)
 		return;
 
-	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
 }
-- 
2.35.1

