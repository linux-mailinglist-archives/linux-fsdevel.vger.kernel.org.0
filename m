Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47436E2027
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDNKCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDNKCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:02:47 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7A7D91;
        Fri, 14 Apr 2023 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1CjXb9KzVRUCMvJ/++SI3aV4TTk9Q8RSGMhb0oiuik=;
 b=dxx6QvovAvlKDwJTy6zKVoOKWkteMhKC78UHMJS8TKTL0C0J+LukdhmdyQzYK34XhrauQNUDLcILlE8SOgX0xdPnw0imfTNLC8IKaqWs9zJEH8B2Scrt1KSmDKlmqwtAVuOYPY0Chks+wN0hjSoO/Eme8QMapTW70M6iqMM5tEI=
Received: from DUZPR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::25) by AS8PR08MB5909.eurprd08.prod.outlook.com
 (2603:10a6:20b:297::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 14 Apr
 2023 10:02:42 +0000
Received: from DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4bd:cafe::60) by DUZPR01CA0149.outlook.office365.com
 (2603:10a6:10:4bd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT011.mail.protection.outlook.com (100.127.142.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.29 via Frontend Transport; Fri, 14 Apr 2023 10:02:42 +0000
Received: ("Tessian outbound 3a01b65b5aad:v136"); Fri, 14 Apr 2023 10:02:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bb7821e7f456537f
X-CR-MTA-TID: 64aa7808
Received: from 5e167ff54ce4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7CA5BD1E-5DA4-47D0-810D-D742C7819C17.1;
        Fri, 14 Apr 2023 10:02:35 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5e167ff54ce4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 14 Apr 2023 10:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS6waTpHDFbs+G3xws8v72TmZI8rNnR6dBXTlHlNSJx2rjGT1Nn6CTnhZytZBOjhFbjDB2NT0gZRsX1oDtbkThFFQvbXOUf0EEkqyG2F4u3EeHBBUL/fN45WMUeCBUEWNbOg9T0lM6FUZQ/I1tbge9OHMmw/BGPLWLW4zSRzcm5H7nsy1yDuJV5jMljTJ3VUyi86U6/5bb8YVrlLCUXxDTfwItv4UMBudw3rqP/QIpbnHFsGTas0uuK4ZvghNjDhdiAXWUnGrvseCCvad3ldMM08PKLayJYFrrcM7Ufsq6AgGQsP0WLKd9Pnm/oN+swmyCvknIWS5SiPbFNxJaNR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1CjXb9KzVRUCMvJ/++SI3aV4TTk9Q8RSGMhb0oiuik=;
 b=Tb0BFgRYJRxmh7cZ4zG48JcJF285PexFp/1eVsam2mOy+DDXJPfDL0E4b8UIhtK8ZYhMl42byh+On5MpG1sjV1uZdugWOk/4oaGrrf3wImEE/mCeCOsHAR7X+nu/0rzwMfK30ca4T6V37NYY82x4wqjCa/Z/IS0q3gSNgZlKAXfq5X7f3r1ZQv+tElD6GpNPeRofegBv8P7OQTSai+8GIx6tnCPlBdNOAzzesH+0rLndZPnB/o4C/wH8XrQjdDhiZe2e+GadseEiOH0s5olzFMe578+XJEAZzYECrboGyvQEDSGAviVQtl69xwB3e8QoPfARmRM4KUXZDuTiV3V2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1CjXb9KzVRUCMvJ/++SI3aV4TTk9Q8RSGMhb0oiuik=;
 b=dxx6QvovAvlKDwJTy6zKVoOKWkteMhKC78UHMJS8TKTL0C0J+LukdhmdyQzYK34XhrauQNUDLcILlE8SOgX0xdPnw0imfTNLC8IKaqWs9zJEH8B2Scrt1KSmDKlmqwtAVuOYPY0Chks+wN0hjSoO/Eme8QMapTW70M6iqMM5tEI=
Received: from DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) by GV1PR08MB7852.eurprd08.prod.outlook.com
 (2603:10a6:150:5f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 10:02:30 +0000
Received: from DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:46b:cafe::da) by DUZPR01CA0025.outlook.office365.com
 (2603:10a6:10:46b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT037.mail.protection.outlook.com (100.127.142.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 10:02:30 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 14 Apr
 2023 10:02:29 +0000
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
Subject: [PATCH 1/5] fcntl: Cast commands with int args explicitly
Date:   Fri, 14 Apr 2023 11:02:08 +0100
Message-ID: <20230414100212.766118-2-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT037:EE_|GV1PR08MB7852:EE_|DBAEUR03FT011:EE_|AS8PR08MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: e12c5ceb-ae88-4900-0724-08db3ccf6319
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Yd8xvFgJbpffiqrw86lv8QOeO3TPMTMcm6oBHz/eBIk6uFGQy/nGZCkVhkBL6BwnH2SC7GfAT7Pvk/lUew7PxZd1H/3tFmA5cINT0Fi2VMFIBpjX+dPXWnQEnRUwBXC470Pc7cVQ2TaUpn1lwDa0W3RATv8oHGkfj4aumxS9314McRNIBDuuntXXSECjL7+z3VmgdRNoa4gB2V7D1dxAIFlpwfzHEUgK0WMs6Jiqurx8FXEGeMhbywgLZQ2jDDxx0SrqR4fHOoTq11XY9NoYH57mY9mBx1PCZ8jRakCUXVa5EaGpwmCI6J1ZVHtPabuf61I2fwTgD0OyqionCOS3WDx1GM/2rFexxh9Ay0aS084W50CVU9xNI6X2Eo6Jws8H0ZXd8Ub5S8THD4kEx7hnD3jCbHLSkJ+V8S7K/grf6YLuwuf78V46ctFkRooTwHr5zleKGqtFjMMjp4w83vnkx3+uor2b8yTCOeL17WKozjVppgDEdqya6VrzD00bQmBWiiO87KvXYSE2M1EQbD7DB86fpXUML8QCId/FU6HPY0jwSJ6uMH3XZbDu424NfNY6q70CRcPped7xk5AKdSSGv4888PQyZWwBjeXyPpsyULj8f9NV72dwCz2m8SDu1dWPJ8d2kwYEWHIR0bxkmL9RTuAB5kM5nv6dZFifMCojTWPuVBm7flOu4Ff6fWouctOZX/VJsYUBI1p308hWP2h1lA==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(70586007)(81166007)(1076003)(36860700001)(26005)(82740400003)(186003)(47076005)(426003)(336012)(6666004)(2616005)(356005)(36756003)(8676002)(5660300002)(82310400005)(2906002)(478600001)(86362001)(41300700001)(8936002)(54906003)(316002)(40480700001)(70206006)(4326008)(6916009)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7852
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 917572e1-040d-42c8-0a2d-08db3ccf5bfe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyGkbjyBNJYLUUwntADJx1HdQdyGPr9mq6IuboStAxXtiE0z4OvZ8ycGNV9r9Z2XIZUz5DdBfe8ukOuoBZBhF6ZpJclLmRqHUq2/nXIDvHp0vHQl8hJDAxECV/Tcyn6FnDo8J34el07D9FK8n3/fs133aih5m/eT8h7bW6CQrQUhV0Xv3bM4OK9jvqTfjMJyhO+UuNi3nhsdhbdsSVGw/XZn6xSpazD4WhHKCWluSV0OxdAAKGegp/t3AB+7gkiPf022UZCNQI12JknbAZFvnxvdnC3AnM6jNsa8tGynT78w+Fu7HCgMjTwfU2uf6tsXWwvKqdmM/l0az633/89KVA3a782Zc7hWvBkKIKx2MHkAIf8d+dMUIRrRwm9Fel+NRm1xVVrtulxCMBBvKNQNlK8GnP7gUHlvU6vym9EOidsoANV/Yv0lTRBospIwnPk81yHJwwIMKPWHf3yWWChOJHfDf9YPXwburZLDlARtx3O7jutJd4KT6tkenHxSpIJ2FVPWKf+SKUHVVyVeiDom0bSNwgVvvHNgGBeC2Gm3fHAQXeocH4bJPKbiwY7JVLc4rgHWKd2cFyMNzJrk+kZ/iOCMwnpsd2+uYh55ncI4bys5M8DEgN//J2h3A2CAa7goG5d9jBfaROJIBub63zb9zRbWfsR0qr01hb3Sps4GEQYkdnCHnn0fmJnRDTIwCGpNqEu9MuGP/zwD1BQSAp6Qaw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(82310400005)(40460700003)(2906002)(5660300002)(8676002)(8936002)(86362001)(40480700001)(1076003)(6666004)(26005)(54906003)(36860700001)(478600001)(2616005)(47076005)(186003)(336012)(426003)(83380400001)(450100002)(70586007)(82740400003)(70206006)(81166007)(41300700001)(6916009)(4326008)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 10:02:42.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12c5ceb-ae88-4900-0724-08db3ccf6319
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5909
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to the fcntl API specification commands that expect an
integer, hence not a pointer, always take an int and not long. In
order to avoid access to undefined bits, we should explicitly cast
the argument to int.

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
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 fs/fcntl.c         | 29 +++++++++++++++--------------
 include/linux/fs.h |  2 +-
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index b622be119706..e871009f6c88 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -34,7 +34,7 @@

 #define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIM=
E)

-static int setfl(int fd, struct file * filp, unsigned long arg)
+static int setfl(int fd, struct file * filp, unsigned int arg)
 {
        struct inode * inode =3D file_inode(filp);
        int error =3D 0;
@@ -112,11 +112,11 @@ void __f_setown(struct file *filp, struct pid *pid, e=
num pid_type type,
 }
 EXPORT_SYMBOL(__f_setown);

-int f_setown(struct file *filp, unsigned long arg, int force)
+int f_setown(struct file *filp, int who, int force)
 {
        enum pid_type type;
        struct pid *pid =3D NULL;
-       int who =3D arg, ret =3D 0;
+       int ret =3D 0;

        type =3D PIDTYPE_TGID;
        if (who < 0) {
@@ -317,28 +317,29 @@ static long do_fcntl(int fd, unsigned int cmd, unsign=
ed long arg,
                struct file *filp)
 {
        void __user *argp =3D (void __user *)arg;
+       int argi =3D (int)arg;
        struct flock flock;
        long err =3D -EINVAL;

        switch (cmd) {
        case F_DUPFD:
-               err =3D f_dupfd(arg, filp, 0);
+               err =3D f_dupfd(argi, filp, 0);
                break;
        case F_DUPFD_CLOEXEC:
-               err =3D f_dupfd(arg, filp, O_CLOEXEC);
+               err =3D f_dupfd(argi, filp, O_CLOEXEC);
                break;
        case F_GETFD:
                err =3D get_close_on_exec(fd) ? FD_CLOEXEC : 0;
                break;
        case F_SETFD:
                err =3D 0;
-               set_close_on_exec(fd, arg & FD_CLOEXEC);
+               set_close_on_exec(fd, argi & FD_CLOEXEC);
                break;
        case F_GETFL:
                err =3D filp->f_flags;
                break;
        case F_SETFL:
-               err =3D setfl(fd, filp, arg);
+               err =3D setfl(fd, filp, argi);
                break;
 #if BITS_PER_LONG !=3D 32
        /* 32-bit arches must use fcntl64() */
@@ -375,7 +376,7 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned=
 long arg,
                force_successful_syscall_return();
                break;
        case F_SETOWN:
-               err =3D f_setown(filp, arg, 1);
+               err =3D f_setown(filp, argi, 1);
                break;
        case F_GETOWN_EX:
                err =3D f_getown_ex(filp, arg);
@@ -391,28 +392,28 @@ static long do_fcntl(int fd, unsigned int cmd, unsign=
ed long arg,
                break;
        case F_SETSIG:
                /* arg =3D=3D 0 restores default behaviour. */
-               if (!valid_signal(arg)) {
+               if (!valid_signal(argi)) {
                        break;
                }
                err =3D 0;
-               filp->f_owner.signum =3D arg;
+               filp->f_owner.signum =3D argi;
                break;
        case F_GETLEASE:
                err =3D fcntl_getlease(filp);
                break;
        case F_SETLEASE:
-               err =3D fcntl_setlease(fd, filp, arg);
+               err =3D fcntl_setlease(fd, filp, argi);
                break;
        case F_NOTIFY:
-               err =3D fcntl_dirnotify(fd, filp, arg);
+               err =3D fcntl_dirnotify(fd, filp, argi);
                break;
        case F_SETPIPE_SZ:
        case F_GETPIPE_SZ:
-               err =3D pipe_fcntl(filp, cmd, arg);
+               err =3D pipe_fcntl(filp, cmd, argi);
                break;
        case F_ADD_SEALS:
        case F_GET_SEALS:
-               err =3D memfd_fcntl(filp, cmd, arg);
+               err =3D memfd_fcntl(filp, cmd, argi);
                break;
        case F_GET_RW_HINT:
        case F_SET_RW_HINT:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..8da79822dbba 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1050,7 +1050,7 @@ extern void fasync_free(struct fasync_struct *);
 extern void kill_fasync(struct fasync_struct **, int, int);

 extern void __f_setown(struct file *filp, struct pid *, enum pid_type, int=
 force);
-extern int f_setown(struct file *filp, unsigned long arg, int force);
+extern int f_setown(struct file *filp, int who, int force);
 extern void f_delown(struct file *filp);
 extern pid_t f_getown(struct file *filp);
 extern int send_sigurg(struct fown_struct *fown);
--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
