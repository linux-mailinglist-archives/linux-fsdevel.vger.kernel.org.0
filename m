Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8686632B4AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353069AbhCCFZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:25:28 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:46312 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1448968AbhCBPxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614700320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kUZjVnsi8Dl5WkKKATrMY3ju10QZjCQvQ2azn7UrYKI=;
        b=Ibw+kCFKla0B8rTBnHu0WGlbUlyflBhF6V0oYGVIyvlROp24QYCGEFDTresm17mLQ+6Gd9
        FJBWVSdW/037nfChd+Q5DJzlc/3Hyzvm9eHpMz0Prt5JJQbVL/3HRZO4fKBNz/5IF6873R
        NR8osEU8W3OarxDwdIrgEzkbLrrDsgU=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-u2cQ5GqlNYSOc0e9C6YSaQ-1; Tue, 02 Mar 2021 16:48:48 +0100
X-MC-Unique: u2cQ5GqlNYSOc0e9C6YSaQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi2P0RhcBw+mjUvi4RHb3Bl7XnkWA3YLSAze59pY/KyJv8ldE9WrfK6oCUmpVz8LP/YkD3Jmz4GwiCWXPy4fFIE7+bSFfkEY96Ibs5PcirMqVSW5xD49cKDeIV/cxudmsUdgpzydxSgtRse/3eZWGBCApR3KRfVZtUPF5jenmnUsV6uk5v5zgKF3b06c2Astm2xmPwwk81Q9nVrI1KjL6kdp2zIs+iNBhUrfJWxDJcOjr+N/jjkQfQMyOw85FLElf0IKmZNtqybNeY9K4WXhVcWOJl2equ3xFIsSE/HRsl6aKmgbN53NNHznzRyXv5cyZz05KMXmQYtk/eEN+HBVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ughVXVVY+M8Uyu/njLCniBzIDoWqbgxHRkRylp9mdZw=;
 b=iN2H2U+NjSF7ycC9ZU/P2dPDaKB0XCfLr1+Yd/QooR5pqnlf3teaGGCGppB5oIpjbNie2sp7q0kDtLT/CEQKJ5XhwpTJCnEG2rzbjrn+cgyqlFS93GBpoornrso5JhRMZsQVJqsol08GEFtcWBiPVfBvrtFMytvG/7ChXq3fXDFeGb1kg8emii7abHcDBiRMFC2HymMH6niO10ZVmxZGKzEJPgb+lIq7EyJ91tdLViG8JGKFvPakclp0QEBiwpL3O7cs34ahwTFkO6CGmdZOoBiUV76Mxt2wifjsF7phNx2s+gAPM0DbP2ARTssGgnF2lhUyUj9O2MQS6CWWL57Cpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB5055.eurprd04.prod.outlook.com (2603:10a6:803:53::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 15:48:47 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 15:48:46 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com
CC:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [man-pages][PATCH v1] flock.2: add CIFS details
Date:   Tue,  2 Mar 2021 16:48:31 +0100
Message-ID: <20210302154831.17000-1-aaptel@suse.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:70b:4a07:1423:4545:e408:5580]
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a07:1423:4545:e408:5580) by ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24 via Frontend Transport; Tue, 2 Mar 2021 15:48:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 500a5b59-b4fc-49a5-92d0-08d8dd92aa68
X-MS-TrafficTypeDiagnostic: VI1PR04MB5055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB505507EFCC96C298F97FE8C8A8999@VI1PR04MB5055.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgncJweN730CubP4O8rMOdYwckmavL4A8hfPQzHnxtqAUIJaeqW+nKBj6F+xVCAzzVtm6n8g7B6zD/PVWxX6g4mwVLZtJv1cCdcfAJFEhepjfHKCVhy+LCnI240p0ETyq7oknx9abTUQVoOb4T38N1ifYoPObJafdO4mXUu0i3ps6XQC6dDkWjGaHsTUyQ/48VLNuQPG2YSgmvFX34lzUIKQsGD6/jQ2k5aHQShsZ/dU6Ee38cFaXXT0DRwnA7iZwkTrb7fRifP8pl7Bel4Lv6EWRoos6l0AoZzhFx9J0daktxc/AUdO/3QUliYGXNkZ9g7KEvzSbBLLYxepymPe4RyCWei+D8yF2H99nNK6nWWGsoUqd2IbALEqIAHq16tuQWI2tDGRht72eujCbg/lXWvsDxSrcF3xRCNPRRjYcM6TEN1JcKzmqsQVUJXo5c9hbGnAVTCfuGl3deW50AQo63q4KbstY71LZU9pLece9+Y1XiLg/gw8K7ylvzb+rfSiLYUmho/ffPHHYoCyp1FAjHDvutMDLQi6ZDvF0k1kJ89CXA14aR75Fw6T9HPVaHRfpRPOgY4lbQh36OXlPdsK8Ld9gePscX4fr2HRF8vR2Um/TZgBN30J4ZhpuyaUS9gpJp1XGioev9QQRr4uNTMcFoTWNwLsM/3xXtLrwThjFMleqK8RDovqQHb1Vyv9hCnIfoMD5neLHijSVFI5AkHeVtEZCQ38vSsR0W/4Qpk/8Q93kEZ8c0u3uxaxNTkQDr64FyBLk7R+rPFFeFMciOL0ZvbV23+uUMZcNy2U8ACJrFCP37d7nLh0R4zrYWVcrANjV2XG7LNIQAFhRGncxRpNIKhSx1hsea42A77oJoUI2kWsoI13OazzRqfjtHtrU2ww/96ReOz54H2C8RRBnvMFrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(376002)(136003)(396003)(39860400002)(366004)(346002)(8936002)(4326008)(107886003)(52116002)(8676002)(186003)(6496006)(16526019)(36756003)(66476007)(5660300002)(2906002)(66556008)(316002)(6666004)(2616005)(83380400001)(1076003)(66946007)(478600001)(86362001)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oSLs+YQJNYu6lZ6Pz1mN9BgmDdEz6jnTERQ6Q1fBngNgD7jGn0lFen9gh2De?=
 =?us-ascii?Q?jwzfNpNPWcg8Se2I9uYG6lh2SFvTfscNDlVZGIBSPfZ14LX8YLNNuCFlT3ke?=
 =?us-ascii?Q?NRyMM+tgo6rVE+PALPYxpu4SSyWjcggwkfl+Nl9haKr/5IccbHY4N8PthxLh?=
 =?us-ascii?Q?jLSss/BOtvnJjjki+Lq3Hbb9XqGgaLQ1x6IsUOa6LmEGjuBb41FvfsCaA7zx?=
 =?us-ascii?Q?qkR59hnMFQkBILknWxOssHLvqeMiS0Rb7aEUyYC5N+R0EXcQMkPj+hLC5hAd?=
 =?us-ascii?Q?VlhGLFKgjvvZqFRvl4/LMsNF4JeBozp7t3rKEmWKLSzn6coi84iNVIBJwOU1?=
 =?us-ascii?Q?eGIfBm7OFCAZC3UNJl4CGy3NKBT6oFtWg/TCkFmUt9Q9fb//KPO2Y1W2NGUd?=
 =?us-ascii?Q?Qg50Si1Zb04lv70/61I5FzkT4Vs3UT7DERuvLJJePWaWM0sFNwwt4bh2UW02?=
 =?us-ascii?Q?qeAl34PiKQCFFiwJBUw5RV7KVHECYyEA+tEqMUIHw8jaUchgXhAdj3ZeZCxB?=
 =?us-ascii?Q?RFC5sv7unAxT8J/RmE+zhx7eHDYIwa9Y/bqKqDLlbY42VIG7oU1n4BXmqv0d?=
 =?us-ascii?Q?DPKujvdfLVqnErHnCqHZ/LtCq01wBEIBkOd6u0E2F1OC4jXtwoZNsCeNIB6s?=
 =?us-ascii?Q?o33S15uhwiam24vKzA2VdwpsEF76HzQuNFJanQHP6YL3LcFpF3WLP0xL7Sgd?=
 =?us-ascii?Q?MjEyXG9a/8B3cLx44KhppUQ5bCFd3p74WvE+I8Z+RM7A7cRGoJKa2VyhY1O9?=
 =?us-ascii?Q?hswraAzKp2uQ46hvENzFiCepnUUyLy4THkhsJePrzT6779vGsXHGoN2PL8/C?=
 =?us-ascii?Q?ofzf5KHCQtkIpTrbfWoE0P/6gncXsbreLCCwRPgSgK/zqVEbAw4TBo1ptIML?=
 =?us-ascii?Q?qU80/wIbRdaL/JQg+TKhlsT4dusXb5vlYPwMmBrOIhkcrlUBELI0+rpjrdbF?=
 =?us-ascii?Q?XVljisJm2BHots8/FRxuO37dtMBHJZi/wW+iwLYNlO6WbPaUwdHFAVosLj6m?=
 =?us-ascii?Q?j2MMMHNGkBchL/9uBWS+q5CnVysMXi6pektQwNvsNFWkyVaq1c7uVMmIQwfC?=
 =?us-ascii?Q?Rv00uRIOYxPUtPEpbwVigIUFt1Ww9yQeF653P4EP+JeKtW+YCARQ5YEIo7gF?=
 =?us-ascii?Q?yKUqGwfd/eBi5eGyIokssVuM/2s7ewj0ypUVlgfWwbGxtH63HnrlIb5j4FPn?=
 =?us-ascii?Q?eood6DDjkblzLtVEoTMwJYK0BK7jBBs9qLQkn4M4kEVza/zx16xZEWUok+IC?=
 =?us-ascii?Q?Rag++dvIxOkEg4I1rSO4oFsJZz97CyMJZRKV744np2GqgU+IQpdp+E5Ws57B?=
 =?us-ascii?Q?ShBHbqJmyqHoTfpHnoVZkKQgwI+V/S/qN6jVXrq6RpyalOghpCLJsjaOGuiQ?=
 =?us-ascii?Q?vDQYTYVOl7qrnJIa6ChEd5yfmiR3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500a5b59-b4fc-49a5-92d0-08d8dd92aa68
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 15:48:46.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHVxrBJargI9TCBJq+YKOSukmNiBv+4rZcpdHKle/Iz9LJk0ECyfuZg1u72WELxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5055
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

Similarly to NFS, CIFS flock() locks behave differently than the
standard. Document those differences.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 man2/flock.2 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/man2/flock.2 b/man2/flock.2
index 61d4b5396..9271b8fef 100644
--- a/man2/flock.2
+++ b/man2/flock.2
@@ -239,6 +239,28 @@ see the discussion of the
 .I "local_lock"
 option in
 .BR nfs (5).
+.SS CIFS details
+CIFS mounts share similar limitations with NFS.
+.PP
+In Linux kernels up to 5.4,
+.BR flock ()
+locks files on the local system,
+not over SMB. A locked file won't appear locked for other SMB clients
+accessing the same share.
+.PP
+Since Linux 5.5,
+.BR flock ()
+are emulated with SMB byte-range locks on the
+entire file. Similarly to NFS, this means that
+.BR fcntl (2)
+and
+.BR flock ()
+locks interact with one another over SMB. Another important
+side-effect is that the locks are not advisory anymore: a write on a
+locked file will always fail with
+.BR EACCESS .
+This difference originates from the design of locks in the SMB
+protocol and cannot be worked around.
 .SH SEE ALSO
 .BR flock (1),
 .BR close (2),
--=20
2.30.0

