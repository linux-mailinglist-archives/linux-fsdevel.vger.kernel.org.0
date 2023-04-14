Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2986E2030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDNKC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDNKC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:02:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C872F8A53;
        Fri, 14 Apr 2023 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO5DDZCuPL5WQhgwtEwx+LQGxLynHuSZjHIJuDDhYak=;
 b=XAFDX6aboc6bl+MA1/ExnAcY2ooaYex1jfxAvgHt1IemmQ5jav/ipGn8vFSAudti5BI2aAupiUBXUYsrX7DqnTbTGTW8y2Wg1Q0v0rT1d8lrzo7ykoUqO/desyiZe7KyQsAWpywI4F8FbqPUJgZjXuLE03C/Fjzqq8wI6vSt7I0=
Received: from DU2PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:10:232::35)
 by DB9PR08MB9636.eurprd08.prod.outlook.com (2603:10a6:10:45c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 10:02:49 +0000
Received: from DBAEUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::af) by DU2PR04CA0090.outlook.office365.com
 (2603:10a6:10:232::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.33 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT038.mail.protection.outlook.com (100.127.143.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 10:02:49 +0000
Received: ("Tessian outbound 3a01b65b5aad:v136"); Fri, 14 Apr 2023 10:02:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 35b5056c35104267
X-CR-MTA-TID: 64aa7808
Received: from 2b773196d45a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BB736C91-2C76-40DC-B794-E7E984CBF406.1;
        Fri, 14 Apr 2023 10:02:42 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2b773196d45a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 14 Apr 2023 10:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHg7/VyDNXIbh33XjyU6VQzq+CtodkuoKAm2PZ5uqoxijmlltDhlefZYDrqNT+eZb3lKaEk1p9qEAqymyVmhxdzPFZrV+RApAADOvZ35v776a/lAh7Qa38tSqG6ofcoQOK6AZEXNFsU0CfGTBxEel5WgcVGwshuwLMsQoW0tjJpaJ+jiLUB8m3tSdDjkoSbr/R4jpj0X3+uS3uj+Sw2yPHPmJM1y502mLj6LG5XezrPcuCDohpmYa3OE1XDv3AIJuGdBPJRBNqeB1lV60QouZhWQwl6Bkavd6PpsUGYEtdVRnIUSaMbR9FmWvOWSsxwrYNbaCteZ5fpfqRxLSjHKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO5DDZCuPL5WQhgwtEwx+LQGxLynHuSZjHIJuDDhYak=;
 b=GWUVTe9aC6FwHDsk0CHvxg6mLzboaTw3vFT2uZMgyVgPBY2g5sgL+/bshijw+uSCmrsvb56fy2/piSkIWgE+t3OuR0zSgiw+RUSO0qvx30FKuyoBQ2KlkJqQSatjbB6e4DQAToxXEXqa8UxNHlsFOXSx/BYutXB172MMFPxtxo2dAuwXeXAcPkv/cLp6Z+ou9PONcmh3VQFL/nZhP8WY1WS0+9cCCv1nONV4+kdxhiepSaG0nTw5FKcXlIZfBLRlth/yK/wSvIPG6xSELLKmBJZDVlrxk6e+ExJEZ5tisMKLHXTEd8dNx8ceB4xi+1uVAowrH6eYWXPzCeS3CeoO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO5DDZCuPL5WQhgwtEwx+LQGxLynHuSZjHIJuDDhYak=;
 b=XAFDX6aboc6bl+MA1/ExnAcY2ooaYex1jfxAvgHt1IemmQ5jav/ipGn8vFSAudti5BI2aAupiUBXUYsrX7DqnTbTGTW8y2Wg1Q0v0rT1d8lrzo7ykoUqO/desyiZe7KyQsAWpywI4F8FbqPUJgZjXuLE03C/Fjzqq8wI6vSt7I0=
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by AM0PR08MB5490.eurprd08.prod.outlook.com
 (2603:10a6:208:184::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 10:02:32 +0000
Received: from DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:46b:cafe::ff) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.31 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT037.mail.protection.outlook.com (100.127.142.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 10:02:32 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 14 Apr
 2023 10:02:30 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 14 Apr
 2023 10:02:29 +0000
Received: from localhost.localdomain (10.57.20.128) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:29 +0000
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
        <linux-fsdevel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, <linux-cifs@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/5] fs: Pass argument to fcntl_setlease as int
Date:   Fri, 14 Apr 2023 11:02:09 +0100
Message-ID: <20230414100212.766118-3-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT037:EE_|AM0PR08MB5490:EE_|DBAEUR03FT038:EE_|DB9PR08MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c483a51-fa88-445c-a63b-08db3ccf6788
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xxSgjTArNLv33vnPZj18K62vC8Ft/UjGLeR2roN6/+8rNWqyQAt97pPz1vBKAPTi/McZir3IVfHzeAH06cEMcVxf/wzJDGlwa6vpmIE4AJZyNbGLFoGO1Ab1g15T9o3yfiXEqaIe+p/dao2q4ITGh0Dh3OJP0TxIr+1jaPJdVxvViWCxvcDjQSTMVqr4Dra1uyZV5TCf+GeWKq4CPPVrMflbzzefOg5BjS4iCIGaspaJky5KelM6NbnxQdmK0H/DmUlraDlsf6UdyNTCwXX6csQ8wIfN45NbEoBPYbBv3UIJ/FFhr51aUSzO/mwGtiDqAe6dh+LxpInYPESrv/nwgiwWhyj7fW802PGyrtU9w9r+3aFBY6GGNlnIZMjUKU8ffBP5/c6pMyIphWpmgtYLrVhJW9xTthgyHRmCdiVMb5zF6frjV6o0zf14szh4Ke3m2fRUytDgB1BECI9vSyRuzXPZ7RH81ZJLFapsDd8JxD+Jk1Tdshyb/7ZQANIZQXm5xaMBPTNcyQgde7hsSMn97cJ8Ms0P8B2zUfQEjOebWgWgmfsogAYDlgvfzGtfuKmamulohMgpa6SpJN/Op0YdyLxIkuMWQIfaROaAW1Y8zr1koxScDhApSkeJOOG+hAqSThg/pNJbfOaOo+1+xOmaNOD52V4uTsY/zo4br9QmeEY5dTa6QL8asDyqfG0xkKCN4d21vM0m0+1wAv2bObGeLQ==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(336012)(2616005)(426003)(47076005)(82310400005)(86362001)(2906002)(30864003)(83380400001)(356005)(81166007)(40480700001)(36860700001)(82740400003)(36756003)(6666004)(41300700001)(4326008)(70206006)(70586007)(8936002)(8676002)(6916009)(5660300002)(316002)(7416002)(478600001)(54906003)(26005)(1076003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5490
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bb364269-c422-42bb-ba9d-08db3ccf5d38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHlzO5cdJsAuLi2XGoZpUgNdvamfg6GhHqCXMxO/Y8NaFIjFS/t8aq1dyjkznoiqSmIUxhECFzEmqLHJ2xUZ2GTvl7+T50v1ThSgISlzL70DNS2J31xqB3HcIulffPzBuvE3v+fYyPPsC881pvohRRqcAgQ97nkByC8HINQskN72lG+rS99acsHf1yOXi2/kuLQx1DRdzR9gtuepggEknD+I11zjOdQQKoLqtbYp8kFSXK35vxlq2X+PuJc5yvKYZ0LasSbh5Pd1MgKYBxFmzQGqQkIVmKOFfdK3yzDvwF73g+cy03veKaN/Ni1/fN15Pc+3zVjOsxOpN1tjoQLbzgvin3haNqJqRGO1ggEaTxTZoXg6eAggKjakxhH4iheemBj+Z5e9M4njUg3w4g7DoHsmHw9WM3lEGvjzhhgu2UMTBo7LZgaOCK7obU3wPU1EcC++LVWrQaBa7XnQ+ES3tL6w0XTPGk99SXsYHgUdqCLnrbRolI/+R3UkHYDdSButfaeCZbg05nwohxDl9gz5sMhKaBLbTnPvPBl2s5fs+aDAwcijJEyKtqZZb22QEl5FFFhmpqehaBSZuMTmtkNo7yw0znt71tHipUA8PuNahjDNmhTLBgwQrbyYMD0OYQIRGnKOLlOgP54SA5EnnntnagVwfhrznUJnWl+NpTQbL4QzDRHHXRxU4ll1+Y/+DBowDY1h5HVOYi3pfF0fwytjCw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(478600001)(83380400001)(36756003)(47076005)(81166007)(40480700001)(336012)(426003)(2616005)(36860700001)(86362001)(82740400003)(2906002)(30864003)(316002)(5660300002)(26005)(186003)(54906003)(1076003)(6916009)(450100002)(6666004)(4326008)(40460700003)(8936002)(41300700001)(8676002)(82310400005)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 10:02:49.5650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c483a51-fa88-445c-a63b-08db3ccf6788
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9636
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
F_SETLEASE to be of type int. The current code wrongly treats it as
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
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 fs/cifs/cifsfs.c         |  2 +-
 fs/libfs.c               |  2 +-
 fs/locks.c               | 20 ++++++++++----------
 fs/nfs/nfs4_fs.h         |  2 +-
 fs/nfs/nfs4file.c        |  2 +-
 fs/nfs/nfs4proc.c        |  4 ++--
 include/linux/filelock.h | 12 ++++++------
 include/linux/fs.h       |  4 ++--
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index ac9034fce409..ad5b2cfe8320 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1069,7 +1069,7 @@ static loff_t cifs_llseek(struct file *file, loff_t o=
ffset, int whence)
 }

 static int
-cifs_setlease(struct file *file, long arg, struct file_lock **lease, void =
**priv)
+cifs_setlease(struct file *file, int arg, struct file_lock **lease, void *=
*priv)
 {
        /*
         * Note that this is called by vfs setlease with i_lock held to
diff --git a/fs/libfs.c b/fs/libfs.c
index 4eda519c3002..1c451e76560c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1274,7 +1274,7 @@ EXPORT_SYMBOL(alloc_anon_inode);
  * All arguments are ignored and it just returns -EINVAL.
  */
 int
-simple_nosetlease(struct file *filp, long arg, struct file_lock **flp,
+simple_nosetlease(struct file *filp, int arg, struct file_lock **flp,
                  void **priv)
 {
        return -EINVAL;
diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..265b5190db3e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -438,7 +438,7 @@ static void flock_make_lock(struct file *filp, struct f=
ile_lock *fl, int type)
        fl->fl_end =3D OFFSET_MAX;
 }

-static int assign_type(struct file_lock *fl, long type)
+static int assign_type(struct file_lock *fl, int type)
 {
        switch (type) {
        case F_RDLCK:
@@ -549,7 +549,7 @@ static const struct lock_manager_operations lease_manag=
er_ops =3D {
 /*
  * Initialize a lease, use the default lock manager operations
  */
-static int lease_init(struct file *filp, long type, struct file_lock *fl)
+static int lease_init(struct file *filp, int type, struct file_lock *fl)
 {
        if (assign_type(fl, type) !=3D 0)
                return -EINVAL;
@@ -567,7 +567,7 @@ static int lease_init(struct file *filp, long type, str=
uct file_lock *fl)
 }

 /* Allocate a file_lock initialised to this type of lease */
-static struct file_lock *lease_alloc(struct file *filp, long type)
+static struct file_lock *lease_alloc(struct file *filp, int type)
 {
        struct file_lock *fl =3D locks_alloc_lock();
        int error =3D -ENOMEM;
@@ -1666,7 +1666,7 @@ int fcntl_getlease(struct file *filp)
  * conflict with the lease we're trying to set.
  */
 static int
-check_conflicting_open(struct file *filp, const long arg, int flags)
+check_conflicting_open(struct file *filp, const int arg, int flags)
 {
        struct inode *inode =3D file_inode(filp);
        int self_wcount =3D 0, self_rcount =3D 0;
@@ -1701,7 +1701,7 @@ check_conflicting_open(struct file *filp, const long =
arg, int flags)
 }

 static int
-generic_add_lease(struct file *filp, long arg, struct file_lock **flp, voi=
d **priv)
+generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void=
 **priv)
 {
        struct file_lock *fl, *my_fl =3D NULL, *lease;
        struct inode *inode =3D file_inode(filp);
@@ -1859,7 +1859,7 @@ static int generic_delete_lease(struct file *filp, vo=
id *owner)
  *     The (input) flp->fl_lmops->lm_break function is required
  *     by break_lease().
  */
-int generic_setlease(struct file *filp, long arg, struct file_lock **flp,
+int generic_setlease(struct file *filp, int arg, struct file_lock **flp,
                        void **priv)
 {
        struct inode *inode =3D file_inode(filp);
@@ -1906,7 +1906,7 @@ lease_notifier_chain_init(void)
 }

 static inline void
-setlease_notifier(long arg, struct file_lock *lease)
+setlease_notifier(int arg, struct file_lock *lease)
 {
        if (arg !=3D F_UNLCK)
                srcu_notifier_call_chain(&lease_notifier_chain, arg, lease)=
;
@@ -1942,7 +1942,7 @@ EXPORT_SYMBOL_GPL(lease_unregister_notifier);
  * may be NULL if the lm_setup operation doesn't require it.
  */
 int
-vfs_setlease(struct file *filp, long arg, struct file_lock **lease, void *=
*priv)
+vfs_setlease(struct file *filp, int arg, struct file_lock **lease, void **=
priv)
 {
        if (lease)
                setlease_notifier(arg, *lease);
@@ -1953,7 +1953,7 @@ vfs_setlease(struct file *filp, long arg, struct file=
_lock **lease, void **priv)
 }
 EXPORT_SYMBOL_GPL(vfs_setlease);

-static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg=
)
+static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
 {
        struct file_lock *fl;
        struct fasync_struct *new;
@@ -1988,7 +1988,7 @@ static int do_fcntl_add_lease(unsigned int fd, struct=
 file *filp, long arg)
  *     Note that you also need to call %F_SETSIG to
  *     receive a signal when the lease is broken.
  */
-int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
+int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 {
        if (arg =3D=3D F_UNLCK)
                return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 4c9f8bd866ab..47c5c1f86d66 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -328,7 +328,7 @@ extern int update_open_stateid(struct nfs4_state *state=
,
                                const nfs4_stateid *open_stateid,
                                const nfs4_stateid *deleg_stateid,
                                fmode_t fmode);
-extern int nfs4_proc_setlease(struct file *file, long arg,
+extern int nfs4_proc_setlease(struct file *file, int arg,
                              struct file_lock **lease, void **priv);
 extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
                struct nfs_fsinfo *fsinfo);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 2563ed8580f3..26c2d3539d75 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -438,7 +438,7 @@ void nfs42_ssc_unregister_ops(void)
 }
 #endif /* CONFIG_NFS_V4_2 */

-static int nfs4_setlease(struct file *file, long arg, struct file_lock **l=
ease,
+static int nfs4_setlease(struct file *file, int arg, struct file_lock **le=
ase,
                         void **priv)
 {
        return nfs4_proc_setlease(file, arg, lease, priv);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5607b1e2b821..ba59ad558209 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7559,7 +7559,7 @@ static int nfs4_delete_lease(struct file *file, void =
**priv)
        return generic_setlease(file, F_UNLCK, NULL, priv);
 }

-static int nfs4_add_lease(struct file *file, long arg, struct file_lock **=
lease,
+static int nfs4_add_lease(struct file *file, int arg, struct file_lock **l=
ease,
                          void **priv)
 {
        struct inode *inode =3D file_inode(file);
@@ -7577,7 +7577,7 @@ static int nfs4_add_lease(struct file *file, long arg=
, struct file_lock **lease,
        return -EAGAIN;
 }

-int nfs4_proc_setlease(struct file *file, long arg, struct file_lock **lea=
se,
+int nfs4_proc_setlease(struct file *file, int arg, struct file_lock **leas=
e,
                       void **priv)
 {
        switch (arg) {
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index efcdd1631d9b..95e868e09e29 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -144,7 +144,7 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned=
 int,
                        struct flock64 *);
 #endif

-int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
+int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
 int fcntl_getlease(struct file *filp);

 /* fs/locks.c */
@@ -167,8 +167,8 @@ bool vfs_inode_has_locks(struct inode *inode);
 int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
 int __break_lease(struct inode *inode, unsigned int flags, unsigned int ty=
pe);
 void lease_get_mtime(struct inode *, struct timespec64 *time);
-int generic_setlease(struct file *, long, struct file_lock **, void **priv=
);
-int vfs_setlease(struct file *, long, struct file_lock **, void **);
+int generic_setlease(struct file *, int, struct file_lock **, void **priv)=
;
+int vfs_setlease(struct file *, int, struct file_lock **, void **);
 int lease_modify(struct file_lock *, int, struct list_head *);

 struct notifier_block;
@@ -213,7 +213,7 @@ static inline int fcntl_setlk64(unsigned int fd, struct=
 file *file,
        return -EACCES;
 }
 #endif
-static inline int fcntl_setlease(unsigned int fd, struct file *filp, long =
arg)
+static inline int fcntl_setlease(unsigned int fd, struct file *filp, int a=
rg)
 {
        return -EINVAL;
 }
@@ -306,13 +306,13 @@ static inline void lease_get_mtime(struct inode *inod=
e,
        return;
 }

-static inline int generic_setlease(struct file *filp, long arg,
+static inline int generic_setlease(struct file *filp, int arg,
                                    struct file_lock **flp, void **priv)
 {
        return -EINVAL;
 }

-static inline int vfs_setlease(struct file *filp, long arg,
+static inline int vfs_setlease(struct file *filp, int arg,
                               struct file_lock **lease, void **priv)
 {
        return -EINVAL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8da79822dbba..0c9367980636 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1779,7 +1779,7 @@ struct file_operations {
        int (*flock) (struct file *, int, struct file_lock *);
        ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, lo=
ff_t *, size_t, unsigned int);
        ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_i=
nfo *, size_t, unsigned int);
-       int (*setlease)(struct file *, long, struct file_lock **, void **);
+       int (*setlease)(struct file *, int, struct file_lock **, void **);
        long (*fallocate)(struct file *file, int mode, loff_t offset,
                          loff_t len);
        void (*show_fdinfo)(struct seq_file *m, struct file *f);
@@ -2914,7 +2914,7 @@ extern int simple_write_begin(struct file *file, stru=
ct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
-extern int simple_nosetlease(struct file *, long, struct file_lock **, voi=
d **);
+extern int simple_nosetlease(struct file *, int, struct file_lock **, void=
 **);
 extern const struct dentry_operations simple_dentry_operations;

 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsig=
ned int flags);
--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
