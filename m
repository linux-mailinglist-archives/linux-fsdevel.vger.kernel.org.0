Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C56E2026
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDNKCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDNKCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:02:48 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C77DB6;
        Fri, 14 Apr 2023 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXThXgzbpE2PttY3ewrOzQKxE1UlmTlLnI5hp/7CtmM=;
 b=IARNfGAuYAWUVvJ3ZiVh3mZcMRPHs+yzw+D5Hqaf9THoMKbTbWQOiH+WK/8m3JZ8sE+XExIaA4NXj94cwF2MPYJDlFWvVbygYw95q+uygFk3rc81Bb5eZ1OyQxFaN8GcsyNwBDwfAhRVURKMei/hP60pODCnWvI8SemsuqkXmI4=
Received: from DU2PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:10:2b0::23)
 by AS8PR08MB9979.eurprd08.prod.outlook.com (2603:10a6:20b:633::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 10:02:43 +0000
Received: from DBAEUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::c6) by DU2PR04CA0168.outlook.office365.com
 (2603:10a6:10:2b0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT064.mail.protection.outlook.com (100.127.143.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.10 via Frontend Transport; Fri, 14 Apr 2023 10:02:43 +0000
Received: ("Tessian outbound 8b05220b4215:v136"); Fri, 14 Apr 2023 10:02:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 39e72d5079958af0
X-CR-MTA-TID: 64aa7808
Received: from ba243dce12c3.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 49866A54-A50C-4952-97A7-F18F90F8217E.1;
        Fri, 14 Apr 2023 10:02:36 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ba243dce12c3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 14 Apr 2023 10:02:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnR98YkOWYhPXZzTsj7jjPFapiXqqcwub3xqqL7AAs2t2VxYMVT2bHQZiXJkHJYlUzzrqbV6Ym2ifTJEo2FaN/Hu33NoYfpnlOMQlFFb63X5Z54Uay/lleJMdQwY60KSf2MRNr8PZpY3Oi8CXqCC4kbMloNQX0KNillRPX4uvFyf3L4hn68QLHUN8srrfXIYT4MeX4ez9CqCgNoiheBB5INvseVW/M4V0f4MX0jGmOPsLTeAVCYeFTxnVXRKhUT/ph7Msq59VOyRS0MllJQoEh/jStiWJ0qugs27k8gWV40YN9rvvrCT4meucbrCdKo6URmPyQoPV0RiA1MVXPFr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXThXgzbpE2PttY3ewrOzQKxE1UlmTlLnI5hp/7CtmM=;
 b=DbNjEzBE515VnUbUdr4xiJVBK00ccnZzbM3IQhhA9bueKkt//zuc3ZIZGP9dSXuMWZSbzD0Gwb9TUfnsRtS5gB5oodx/lGRYUPWlXmexGYZNJpelQVmKHM4QHtTRBeD0tZe6Q0DFxZsTjVZS4YPg7IAFPQbib/IF3kp1RfX7z/d1S8SgkoiRGgX2Kk+w63hc8OYohiAt+zOtTFF29MIwbKb2sM0ogQjyMLGhMUDXsVAvgek29Z1oESGcQgJgPe877k71zlXBUg//uhHLUhxpboVAZUVNs7+AKMF221yMeP3Uj6rquDsctOOD6H0ZQwVJtghlh+7XQPkPpvzyTIZ4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXThXgzbpE2PttY3ewrOzQKxE1UlmTlLnI5hp/7CtmM=;
 b=IARNfGAuYAWUVvJ3ZiVh3mZcMRPHs+yzw+D5Hqaf9THoMKbTbWQOiH+WK/8m3JZ8sE+XExIaA4NXj94cwF2MPYJDlFWvVbygYw95q+uygFk3rc81Bb5eZ1OyQxFaN8GcsyNwBDwfAhRVURKMei/hP60pODCnWvI8SemsuqkXmI4=
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by GV1PR08MB8353.eurprd08.prod.outlook.com
 (2603:10a6:150:a3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 10:02:34 +0000
Received: from DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:46b:cafe::8e) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.31 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT037.mail.protection.outlook.com (100.127.142.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 10:02:33 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 14 Apr
 2023 10:02:31 +0000
Received: from localhost.localdomain (10.57.20.128) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:30 +0000
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
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 5/5] dnotify: Pass argument of fcntl_dirnotify as int
Date:   Fri, 14 Apr 2023 11:02:12 +0100
Message-ID: <20230414100212.766118-6-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT037:EE_|GV1PR08MB8353:EE_|DBAEUR03FT064:EE_|AS8PR08MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbc9dfe-47e2-4dfd-4401-08db3ccf63d5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: M9WQw0GoJIf/7je9lWbREJsGpT3zbjbrlAdBuHJfEEFk0K97OnXwmiQi3Lbb2jBi9qGXRKglhqNg1uSwSBgUjiGwzYm1a7yl1wM3oCagNg49Yb40X4upSHUJ3HZHxvJcln0lrPhq9EuVBBzdOhqv8nVBNGa3qFGSGKudAoMdqjWKCtP0oIejNACN7B9LDvUsEGFMr7BWfa3fN5b1S3pcyTb5SajmosepdYnuqWqj4q2WNDP6uybkicRZyfm8oqAHxRnYvXB9+qOTgZStvLn+BE9DBfjnsH14LXwCOrNvxmPe/bYRbWomtc6/99WYGso+beGMmpWLKL+PD8BzxlSiDqhp0meKzVQ13sApW5AgZ1O6Gin+x4q9UEan0Ik7WDWBEIu+C6SkFslw15X+z76QJI/kvuU1rLQXeKo+DTU9UMKhq3CKj8okxjeBDhIoMbOv8jyfaxhQMAAYU3BEMh95+1Snf9wn9AFZPP+E4obXIypXudzUj7imrYfy+FTFT3eguqhKDrLI6xues6XEHq4S4p7X9yV9XMgbVrCSVP3gtqXazmE8qR9eyKxNzgj6pFXFHpVuzGU07n8z8q7W8kA3gRvlK3t0IlPxqozjWG43syQxqnNK2ECLOQcNvT8TDnd40LC0TsBgC2bTvN4q1iODwQBX5RlPdtT/nyiKeailT+3XsexfzvBfbS9ejO1d25C0bMwxMLehA6oSpHOdcITQ/Q==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(478600001)(86362001)(54906003)(36860700001)(36756003)(47076005)(2616005)(336012)(83380400001)(26005)(40480700001)(1076003)(82740400003)(6666004)(186003)(82310400005)(81166007)(316002)(6916009)(356005)(4326008)(2906002)(70206006)(70586007)(426003)(8936002)(8676002)(7416002)(5660300002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8353
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 41483d6d-1376-48ad-4826-08db3ccf5e2e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIpaDfYjtD51eEk8FYXjZ9m9cT4NmczaCZ5TNos/WdCWROrptKin0souGJs9dckIJSvCeqWjTRXjQbY7qvx3kct1Be15AYVI9wBmpHJcQjLKiX5Lahv5nB1I3LN2mr6lPvRaZWczzxYoYu4Sk5snO3APrqvnPREN59HSsB1SgnAwhl4HInqDVecDQ/StIhJDL6vC5k66XTOhjBlvLaaZ3Suuy796QVhgLFntJ3y8TOQVjznI43GC2enMMomdWDyysJsYQMyaoJPpclBY5fj3zatkEsW5JyudMTByEYJfnpmj1dLg440QocqA3mZhm6eJ0rq78PUa3yfB4cDgrYi8JAMh2SldYjhJOjPGyaeFNDAExgOv7WJYWok0Ll11KJOOcsxsoovXwOvdwaH2GBKiLowMIo39EoFyyHFFPUDy1ckz2+mlHQ60FTcM52mUlHuwcItsiWz5eMUlpHe4aF7aV7k091jRd8wrYMYk/1iEFXzwrdRGhi1CWe36wdQLOcucXoshGLLCRHvQmYU+D/Kyt5XCOPlTwtaOHhTUvOUen2jQbYPYTGDj0FZVHxlNMKGLWLClBqT72Avt9+Dc57lHXwrDaw+ZZstBHS9MYNFWmA3KSwbRhkaIJZSrxezbVRVNctKyt7MWrEHMcd/TLGoiixihQTzdNwQ3AVfAjv+U42E42rJwACap1P67lPbhVugcmObLnSKcB/72zpAqfid/dQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(336012)(426003)(5660300002)(86362001)(8936002)(2616005)(70586007)(6916009)(83380400001)(450100002)(8676002)(40480700001)(2906002)(4326008)(70206006)(47076005)(107886003)(81166007)(82740400003)(36756003)(36860700001)(26005)(186003)(82310400005)(1076003)(40460700003)(54906003)(316002)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 10:02:43.3718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbc9dfe-47e2-4dfd-4401-08db3ccf63d5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9979
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The interface for fcntl expects the argument passed for the command
F_DIRNOTIFY to be of type int. The current code wrongly treats it as
a long. In order to avoid access to undefined bits, we should explicitly
cast the argument to int.

Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: David Laight <David.Laight@ACULAB.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 fs/notify/dnotify/dnotify.c | 4 ++--
 include/linux/dnotify.h     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 190aa717fa32..ebdcc25df0f7 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -199,7 +199,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 }

 /* this conversion is done only at watch creation */
-static __u32 convert_arg(unsigned long arg)
+static __u32 convert_arg(unsigned int arg)
 {
        __u32 new_mask =3D FS_EVENT_ON_CHILD;

@@ -258,7 +258,7 @@ static int attach_dn(struct dnotify_struct *dn, struct =
dnotify_mark *dn_mark,
  * up here.  Allocate both a mark for fsnotify to add and a dnotify_struct=
 to be
  * attached to the fsnotify_mark.
  */
-int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
+int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 {
        struct dnotify_mark *new_dn_mark, *dn_mark;
        struct fsnotify_mark *new_fsn_mark, *fsn_mark;
diff --git a/include/linux/dnotify.h b/include/linux/dnotify.h
index b1d26f9f1c9f..9f183a679277 100644
--- a/include/linux/dnotify.h
+++ b/include/linux/dnotify.h
@@ -30,7 +30,7 @@ struct dnotify_struct {
                            FS_MOVED_FROM | FS_MOVED_TO)

 extern void dnotify_flush(struct file *, fl_owner_t);
-extern int fcntl_dirnotify(int, struct file *, unsigned long);
+extern int fcntl_dirnotify(int, struct file *, unsigned int);

 #else

@@ -38,7 +38,7 @@ static inline void dnotify_flush(struct file *filp, fl_ow=
ner_t id)
 {
 }

-static inline int fcntl_dirnotify(int fd, struct file *filp, unsigned long=
 arg)
+static inline int fcntl_dirnotify(int fd, struct file *filp, unsigned int =
arg)
 {
        return -EINVAL;
 }
--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
