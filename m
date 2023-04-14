Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D922D6E202C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDNKCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDNKCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:02:49 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA67D83;
        Fri, 14 Apr 2023 03:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWRAJwDVC0Dm7oaRusXnoOtLZhljqgj8fvowtTrC0EM=;
 b=oezgWYMpfLSnFT84Wc7daZ5CoIJ8QkFTO4WbRRctFTaMQiVyfVba4kyGWA0EH2jAROZM0EIWqGdzRqKo7FTXT4G4XPjKgxgzzFjog2JrGVnP7kbMF6KpsnW3USEgRinMLLMB93Ik+sKZUJe2EBYM7HYJnlwhgBMvFbsXWt7M48o=
Received: from DUZPR01CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::20) by AS4PR08MB7632.eurprd08.prod.outlook.com
 (2603:10a6:20b:4cf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 10:02:38 +0000
Received: from DBAEUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:46a:cafe::b1) by DUZPR01CA0078.outlook.office365.com
 (2603:10a6:10:46a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT006.mail.protection.outlook.com (100.127.142.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.10 via Frontend Transport; Fri, 14 Apr 2023 10:02:38 +0000
Received: ("Tessian outbound 3570909035da:v136"); Fri, 14 Apr 2023 10:02:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 09d0b9a9cb5c7dae
X-CR-MTA-TID: 64aa7808
Received: from 2b12c28e6f6f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 41AFE867-0ECB-46EA-8F0D-BF7138933532.1;
        Fri, 14 Apr 2023 10:02:31 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2b12c28e6f6f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 14 Apr 2023 10:02:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxm4qKsP6+VgT/9aL2fdlmHpi51e+nhh1IMUYNjEzMNs7LldqiTq2H3HBUBWCwBp8TWAb9mQ2nlHnPhoaXvHnwehOJeJhmDea+1yZT2Blizp7m9FwHr/mWI/0tiCTncTLisjwnCtchIbi+nPILgZxg4JonLHZtwQuWFWuhown99h19tYiD4E1MNXI/Pm0B/hWwBs3vhbnuHJgB+x9531HwoR6p57gK/tROVeyDLBDwmDd2IB7UmQFluYC1kPQzbP7XesYGL/n0zgGzXMJZxLWTtYdIdmGOHfjeJ4h/UzzccYmXTdSQA+Ah3zLiYy/ae8NHxU3gAopwLbHSKSMgHCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWRAJwDVC0Dm7oaRusXnoOtLZhljqgj8fvowtTrC0EM=;
 b=EQVpAeMj/KY+FOky2YI5+UGkDpGJTerwwSlpIe82T8TX6QEPh9e+5vP7JE2pGEVoCI5mKQPp2Mhgey+c1GS1hhGAqcqqTS+TbZprf07K+XkThpCOJlQrrtydy0q3OENV15kdmyF2wPGGG6MIE9+o1p3QzQ9dmpqxgKW7yPOVc6Bb3vHMexyfImgAu7RLA528Y0ZBBptK3/XrRUz7UxjRqPrX000iam7ZXD6/C3Wqo9jqiSYvSVz2SXA/p4oyBszqnyoGVupBTGOrqd2w+eYGzAUS1FOO4pttss5SLAPt9/ZtkyXmg+iAkuaLup8sdK5FZjKJP8pVELFBp/nXHagHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWRAJwDVC0Dm7oaRusXnoOtLZhljqgj8fvowtTrC0EM=;
 b=oezgWYMpfLSnFT84Wc7daZ5CoIJ8QkFTO4WbRRctFTaMQiVyfVba4kyGWA0EH2jAROZM0EIWqGdzRqKo7FTXT4G4XPjKgxgzzFjog2JrGVnP7kbMF6KpsnW3USEgRinMLLMB93Ik+sKZUJe2EBYM7HYJnlwhgBMvFbsXWt7M48o=
Received: from DB6PR0202CA0002.eurprd02.prod.outlook.com (2603:10a6:4:29::12)
 by DU2PR08MB10188.eurprd08.prod.outlook.com (2603:10a6:10:46f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 14 Apr
 2023 10:02:29 +0000
Received: from DBAEUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::3) by DB6PR0202CA0002.outlook.office365.com
 (2603:10a6:4:29::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT059.mail.protection.outlook.com (100.127.142.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.11 via Frontend Transport; Fri, 14 Apr 2023 10:02:29 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 14 Apr
 2023 10:02:28 +0000
Received: from localhost.localdomain (10.57.20.128) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:28 +0000
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 0/5] Alter fcntl to handle int arguments correctly
Date:   Fri, 14 Apr 2023 11:02:07 +0100
Message-ID: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT059:EE_|DU2PR08MB10188:EE_|DBAEUR03FT006:EE_|AS4PR08MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed76dda-a1cb-4640-013c-08db3ccf60c4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +ORIshP6jZS17274GEsPuhvnC/oVvzI+2Xk6PW5s7w1aa7Nt2ikkL4j7UTeUmtvXP3fM1oCXWALx1DAbAsaGgi6OaIEMqYl23h5//SRBMayGWsVSUwA+Eb+GmT+YW0k81YT9PTDAoYpozFCY4f6uIbC3zNYWvxo3V88VsTpBZzD1HW690SCe9rYV0WAfPTyGdj6jURJMiEmHs1gAE+0AwFLCv9IVuyl6D0Ua4BE9kn0l6WKLP3Oejmb/01MvV3zsbeGjJo09uXLYKMHNkbYnQlFETE2OINoT5c6X+Dyj6X0wXpI/yF7HdOS37z2iZeB3fpTkZ14TuaRumG9CluHNij6iuQV5br7ATI/QSxdOmJhoiEXd79eqssD7kqYqsmfeNEHlaXiaaI8Z3JfO0aisp+TSCXdGOrcII+31SGeKnh4XGnT2Q1MtcdJafPeGff2N3QpM6hOPYocnr8r3IILOG1e2/ySqjMY+jmUaAqpYZ/6wxW5eE0a80xyUv95smwwhKOrS+4z+8wLi69f4n8Sr1w2pW47x9AMBE4qDUWgthMMVkYmGi0x8TTCrPYbTRZBT7Qpt/PlhC54qNtJuNEhZ/642yfvkV1c0jRFgxF87RP9LETXIdklEswmuyR78RHZ7AGtKh7VkNlCVvCWV5h5R9RLduUE+AjnJQeAYHXzOILxG8xjACc728tt3TagMMI9g1mKogc1jN5putMjNYaTgcvAYTlFtvnU3vJ9vqVMerMo=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(316002)(82310400005)(54906003)(82740400003)(36860700001)(81166007)(356005)(8676002)(70586007)(70206006)(6916009)(4326008)(86362001)(478600001)(426003)(336012)(47076005)(186003)(2616005)(26005)(41300700001)(36756003)(1076003)(2906002)(83380400001)(8936002)(40480700001)(6666004)(5660300002)(966005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10188
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 145afb77-77cb-4c41-24be-08db3ccf5b79
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhzLvUdC6vOFs/7gPxV6qa60vzuUWBCVBYFlYlRHT2vr+GZS0qNRGnjptyTv643NO3OsFcWGX8Njd7+3s0pLIs2P7X5mJTwTXpmJdbuZbeJKeuxQSWB958q1sFcJUzJBe/Pvc3fEz4sU8t1rFP9GAp73ADAhnm6N2P0n4CzutVuStUlzNzpEA1ml5ux85xtagf8ka4+kN4bx0W5/kkcfVWR0OZxyQ3acXD5S72C9wo/h6uTBFMkyoSGKz4OXT15sRFiATj23spjBjqURTjT8f1HisDRVCbqy1AT5ER0gHX39d9G3x4rJB8iY++SVxUwK/cfEKVl3/AneXYOYr7kDIrsyzzwgMmMK6QU4r//nyzna/O62/kbLS69TKgA8uky5tz2nNDdlGt4hSeUhzk5U6LhPUqZIh3xmwZcCyechMDo+20c5/R3M3mWRYS9GVYPpImuvE1QGOF1O2YgqdSwxH2dcsdVPl77MVnsnovVdQ9cfs3UDwG9TPBLL4+7z46B2qkQbV04bUz29Ivf7Y9eouHmXJMgXVtoE8O4GyKDT+OcMnVZJSJG+KuH0okhvDau6KeoYqtg1zpHc2BmbbBTjFJVdWLD/HRacxacerulYg6BNsIJX3BCKBCa3JPk+PJRZjOt7oxqjkKIc+CHHXFzTev2cZlAr5AwKapSJ3lIEk+mUwofmbHpcjbKqjh/13Nq+tjrNOzONgb/9bPb3Xth+iDeURICpAM1jXHmiz4HidXo=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(316002)(4326008)(6916009)(82740400003)(70206006)(70586007)(336012)(426003)(5660300002)(41300700001)(2616005)(47076005)(450100002)(82310400005)(6666004)(36756003)(966005)(86362001)(40460700003)(54906003)(40480700001)(1076003)(26005)(186003)(2906002)(83380400001)(8676002)(8936002)(36860700001)(478600001)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 10:02:38.1630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed76dda-a1cb-4640-013c-08db3ccf60c4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7632
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to the documentation of fcntl, some commands take an int as
argument. In practice not all of them enforce this behaviour, as they
instead accept a more permissive long and in most cases not even a
range check is performed.

An issue could possibly arise from a combination of the handling of the
varargs in user space and the ABI rules of the target, which may result
in the top bits of an int argument being non-zero.

This issue was originally raised and detailed in the following thread:
  https://lore.kernel.org/linux-api/Y1%2FDS6uoWP7OSkmd@arm.com/

This series modifies the interested commands so that they explicitly
take an int argument. It also propagates this change down to helper and
related functions as necessary.

This series is also available on my fork at:
  https://git.morello-project.org/Sevenarth/linux/-/commits/fcntl-int-handl=
ing

Best regards,
Luca Vizzarro

Luca Vizzarro (5):
  fcntl: Cast commands with int args explicitly
  fs: Pass argument to fcntl_setlease as int
  pipe: Pass argument of pipe_fcntl as int
  memfd: Pass argument of memfd_fcntl as int
  dnotify: Pass argument of fcntl_dirnotify as int

 fs/cifs/cifsfs.c            |  2 +-
 fs/fcntl.c                  | 29 +++++++++++++++--------------
 fs/libfs.c                  |  2 +-
 fs/locks.c                  | 20 ++++++++++----------
 fs/nfs/nfs4_fs.h            |  2 +-
 fs/nfs/nfs4file.c           |  2 +-
 fs/nfs/nfs4proc.c           |  4 ++--
 fs/notify/dnotify/dnotify.c |  4 ++--
 fs/pipe.c                   |  6 +++---
 include/linux/dnotify.h     |  4 ++--
 include/linux/filelock.h    | 12 ++++++------
 include/linux/fs.h          |  6 +++---
 include/linux/memfd.h       |  4 ++--
 include/linux/pipe_fs_i.h   |  4 ++--
 mm/memfd.c                  |  6 +-----
 15 files changed, 52 insertions(+), 55 deletions(-)

--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
