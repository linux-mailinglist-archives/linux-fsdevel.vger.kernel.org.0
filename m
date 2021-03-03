Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C768C32C56E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355152AbhCDAUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:42 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:51515 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350317AbhCCTFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614798257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irYpeoFd1vn4PPKGQI2P/VimUYWFx4DtL0ROKNEWfDs=;
        b=CZTX03D6dKnMeM2nHtrPcUJkdBNfoBIhDvnLr28KmHonGfKAxRKiC2HHwCY7WOCrLLTjAt
        RkaNivDPsuo0eNkfuevrmwFwHi03Fdgt8PKdJ33aRVG1HfURgPcul+FnBloCISsq6LieWa
        PT5HSu+ddqbDHTKhu3cQT0wbDco9KeA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-8Z0l7xMiNRiP1ZWJpyRZ_w-1; Wed, 03 Mar 2021 20:04:16 +0100
X-MC-Unique: 8Z0l7xMiNRiP1ZWJpyRZ_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuKAtIW/VR+byioOUTIASjM0hRAJ5egOWY32Lj//hAphsEoVE5Ye48JEUN0DRBgxnOlvE0P6zk+x0phRO7Dr+CYujzUclQGVH9uuaAozz+Gj48LfalcxlCz9c/otZSrs8yxfhqUL3G1d0zvpdN96he5IJWdIUJIru1n7n0nk1gL9zE2NiaNLYVhuOA3cQXNipSISQFcURHAVU2pNELISEDbdmWTCZv687qie5mXU2bWaIoZujkKW7HPKh/WZFIrlK80LjlFvV34v4v3MQ54In03rggOtLaruYw7wjeHYw2aYRO9jiCex/cUBBJCntARex5al8RGWfqSSbZ4ZuS+qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjU9KsJuRDpPxHRZ7/NaaELVluzegeeTIs8S0XxTIGY=;
 b=bhqnT/6Cq/4RaVkrF47nXzO9dpvC2CqV6+b++zPY79A2AySiuR7StpCrX5debOrCrtkEerxZksHIMB9RqJySmYsubX/Y0IAP1YHr5Z1A2lhmQ2A3j742wt0/u+mC3MpZWz4yjLDIWTF+ZF91dttxI3QIlIg1OqojNuBQ1bkju9mXi2L6263xXCLIZkgk/DGMgtvFCBO9c2+r32fcxd128imZ50heN+AURfoYl+nq8x0h1LxJdSQlMKZBmxDrLk2XSMfSBqVYeth2+Dn+1vjyDOPMKRwYxMScLKKXKJ3I8Rr58oE6072YZriWsuL57hcYVB2SEfhfME3H/3tTm9ueIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VE1PR04MB7280.eurprd04.prod.outlook.com (2603:10a6:800:1af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 19:04:14 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 19:04:13 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     Tom Talpey <tom@talpey.com>,
        =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com
CC:     smfrench@gmail.com
Subject: [PATCH v3] flock.2: add CIFS details
Date:   Wed,  3 Mar 2021 20:03:53 +0100
Message-ID: <20210303190353.31605-1-aaptel@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <17fc432c-f485-0945-6d12-fa338ea0025f@talpey.com>
References: <17fc432c-f485-0945-6d12-fa338ea0025f@talpey.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:70b:4a22:792c:d376:dd41:4ec2]
X-ClientProxiedBy: ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::15) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a22:792c:d376:dd41:4ec2) by ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 19:04:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2b843c-346d-47b7-e157-08d8de77226b
X-MS-TrafficTypeDiagnostic: VE1PR04MB7280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB728026BACB9F395945E63534A8989@VE1PR04MB7280.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwSqwHZKr7Vzwh3PhedkYtwCvhi14Qa1zjW5B+VFG0ioCh/yDykhklOk+c4tHZ4p4JtPla6fJ2U0avOCFWMEeXcrBjDFiZc5aaOSZgzJR7AUax2sgUIDrCKWE/djTsL4pO7gPz0USQenJRw8Su9piElYo+uOCwoc0IjP9KkfHAEk1+Dy9rZDR4kb+vJKE/DzVn3wfOYaHl9vC69xS6yaV1svC+IY0l+BHsXjfu+fTrkhj2KwSIAB7a/flUxM/k+gu9XUX7FMhK9dCcJblSM9Iqk/GXizTeoWhLnST0TZjKL81bQl8LqwxRo/hNv/3c9aKiMiWXH3U/QcYZwtnnyxrrfMg7OHcULA4Laurbr+yZOpE0wy23bQJo0Rcko5PArl3+3exNCS2ZSJJwNXjm5cf34Ym0gIjAf/x8j6JVHQTbAFIw5HrtHVb4yY3B2FDKPEgc4QA3fVt7xzpuX9PlIy0lLhwkl7v8Sl8CqVKNnfFi92rBc7U/Th3V1OU+mDh75NG1z8EqWMbvr0b89T2pLOZRPY1a05N2pypzx+a4jELKrp2qel5y01kgu7i1bMW+0J0RT76amydhoIzEL5vtg4/5UZVJeknr9QujDEr44gj5IrjUXY5GFryTR7EUHxzK8ir9ZG10nWP+4rkyWu3+Z/5pilV7l9aIozqxCxPXheASw1mmsIzmpmcy6NZH4KSk+azB6soZYNjrfoWexKBcjKqK+9eohhCbcES01kOilNkxph++dJhcskIH4lfZTaElhRxxXMFx64wxABUnKeBFuHELKBB1g5+R+3pcpTv1w80kAgpOOh7daxxaoX1bVd+CbrrQF/KqiIiym/PnDL7QOq8gYSH94kn+HYKorde8OExRXWnk6VSzDcFC02sQA5EwrZTW7+6Dxu6ufGPR+pT6W/oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(8676002)(83380400001)(316002)(66946007)(110136005)(8936002)(1076003)(186003)(4326008)(36756003)(6666004)(478600001)(6496006)(16526019)(52116002)(2906002)(6486002)(86362001)(5660300002)(2616005)(66476007)(66556008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+Q2w5st7eFT1kcxw7wRwC/GnbqiIdLjnph4PUtOkGDxAtDhQH+DAnkx3N5q9?=
 =?us-ascii?Q?ApT9y8QKugucUyC5UPJyWPk0NloMl+z8EmdP5cJUtFpjcrYqxLONh2IftA9a?=
 =?us-ascii?Q?DEsU2y5a8XZSavPNuTwBnlI2Q53SJj6r8uAPPWEtMXeVRhzZXE9yNFw7+7KY?=
 =?us-ascii?Q?c0cEd2iNBTpALkBWCsfRxD5BefehcQiOlftYZp9/rczjSOWSQcblzsIwT/10?=
 =?us-ascii?Q?K5LeAzSQY+bypv+Qz3eV2xv4O80lcL68I+IRwhZB2a0c2CrqkiiD8Ug7u7Ff?=
 =?us-ascii?Q?/297o+tB4jV1VlfNC9SDLweeh0FkODVPjMr8CLbn826Xg884bDt3IM2j1fAr?=
 =?us-ascii?Q?Owzz5+0xSSTads61cR0kpTy/BuZMAYlrzsF2UDyaX0gaX0WIcNb2r8bKxbT+?=
 =?us-ascii?Q?sy2xg3fjRPBQ5gsa3XeU98LMxfc8z9D+WxZTIq67wqz3Pja6N7nFAD4OK2we?=
 =?us-ascii?Q?M/DjGm68X7Qzp0gfFrO9z1pnDDoR3HTXV2QD5UevKgjquQvOKBIgK7VGQHbr?=
 =?us-ascii?Q?ac1V+fzm28YBGEUr9zisGSqsA0v2SbNEd+JE4KqW9oaTD7r04HUChLVQ6oZ0?=
 =?us-ascii?Q?rL5hnu9BY126W10H0h4DbHns28WPeHlTiJ9Sh2zuYWMResbNosHrugKCrhH5?=
 =?us-ascii?Q?Zsz/X1zFtvyQCYnz978Ccyk8Cs6rkPp8ycZS8uLAtRcSz7QaApImSgeVAYdj?=
 =?us-ascii?Q?2kG98P9u0FbaFSDiOgGhslIaENNtKu63pNorkKyNVpyMNJI96l8Vtj+ERaj9?=
 =?us-ascii?Q?9XqLW6wf5Vu4FecIMiiH6PNUqM3rNS5ahInILaDk0Fue1iw7VR2EMeIEWaRq?=
 =?us-ascii?Q?HACYbqq8ovMK4Rnkjtn9ZqJlaJv0eUsM6SUJKhvEH7hKZ4DQto2ypA0JSTsI?=
 =?us-ascii?Q?AFL91YWgmUr3skNWMSYT4KQyv1vxXvNuDoOvIQyFhYRYdaNXG2I6oV5p048+?=
 =?us-ascii?Q?VssMeFevQjzE327FejbvMRXvaYGUFyfgLTJPcqdmiu02i8aSyIvmbfNb0Vyg?=
 =?us-ascii?Q?YReoRFF6EWnWmx9dE29mLWoHmqKHDIxpLQmHUvdzJ78uLrGCgdoWmM5w1Cm9?=
 =?us-ascii?Q?rvuzl/KuTGNqvemYBTMAykgAx2E85jxEuiTJ50SRvIDRRBUI7cyAGF6Rdzfk?=
 =?us-ascii?Q?u/7Bi3vJ/vQ7xq73+c0BkFX3WEJti/WmrnAmBxLoGvzjr2xXs+VJkvDbJCY6?=
 =?us-ascii?Q?fIFutvrZ3gilXuEqYcnnWK7BW8PsBu1NU+hWi0ylB7/Aqs92iYtheVwb3/1p?=
 =?us-ascii?Q?wSR21qADKQ1GW/4FRNWSNfJ13TEGYsy/MslD7yoPEww1qDZdVFLcRaYE5Tum?=
 =?us-ascii?Q?pf80pd4a8X+uQZsxdd9s7YBqsnDunHowH/EpF/VevXB/0FbOWyKXlaQKsg0G?=
 =?us-ascii?Q?shUB1nccA3gCqMOSsODQFuy345vZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2b843c-346d-47b7-e157-08d8de77226b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 19:04:13.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4apX6t1xYIi1rHpHjdQxJZZqyLjD8LHS+LD/cnacMqGWzk6HRfpXs5NA7AYi4ck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7280
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

Similarly to NFS, CIFS flock() locks behave differently than the
standard. Document those differences.

Here is the rendered text:

CIFS details
  In  Linux kernels up to 5.4, flock() is not propagated over SMB. A file
  with such locks will not appear locked for remote clients.

  Since Linux 5.5, flock() locks are emulated with SMB  byte-range  locks
  on  the  entire  file.  Similarly  to NFS, this means that fcntl(2) and
  flock() locks interact with one another. Another important  side-effect
  is  that  the  locks are not advisory anymore: a write on a locked file
  will always fail with EACCESS.  This difference originates from the de-
  sign of locks in the SMB protocol, which provides mandatory locking se-
  mantics. The nobrl mount option (see mount.cifs(8)) turns off  fnctl(2)
  and  flock() lock propagation to remote clients and makes flock() locks
  advisory again.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 man2/flock.2 | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/man2/flock.2 b/man2/flock.2
index 61d4b5396..4b6e5cc24 100644
--- a/man2/flock.2
+++ b/man2/flock.2
@@ -239,6 +239,35 @@ see the discussion of the
 .I "local_lock"
 option in
 .BR nfs (5).
+.SS CIFS details
+In Linux kernels up to 5.4,
+.BR flock ()
+is not propagated over SMB. A file with such locks will not appear
+locked for remote clients.
+.PP
+Since Linux 5.5,
+.BR flock ()
+locks are emulated with SMB byte-range locks on the entire
+file. Similarly to NFS, this means that
+.BR fcntl (2)
+and
+.BR flock ()
+locks interact with one another. Another important side-effect is that
+the locks are not advisory anymore: a write on a locked file will
+always fail with
+.BR EACCESS .
+This difference originates from the design of locks in the SMB
+protocol, which provides mandatory locking semantics. The
+.I nobrl
+mount option (see
+.BR mount.cifs (8))
+turns off
+.BR fnctl (2)
+and
+.BR flock ()
+lock propagation to remote clients and makes
+.BR flock ()
+locks advisory again.
 .SH SEE ALSO
 .BR flock (1),
 .BR close (2),
--=20
2.30.0

