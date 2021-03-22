Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3634472D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCVOag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:30:36 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:58668 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230353AbhCVOaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1616423434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPz3aHV8Cee91K/15ZTExGdgTdvPWeF2XQ+Mky+0YlM=;
        b=URGsQuMDNNQBetzwaNrbL+WgaFu4YE4hv0JRHp1xVH6oDkg4L5wd4fRyw8jViMTMvwD5WQ
        zjVYV3Bgosgl6+e7FGMsJlQcj7fdocFZvDbe/L9X1eF3tO9ao+9OOThdO88hNnUloKyT9U
        VpbN9tvsqjW90NLDS2eR9F70EGadtJQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-7-VLvb6E5HOzqiWHsi9_pjag-1; Mon, 22 Mar 2021 15:30:33 +0100
X-MC-Unique: VLvb6E5HOzqiWHsi9_pjag-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxT52BHdG36LzgzVCmOPAT3cs70ZPGGU6MpwcFqn/gpmIRVU8R/rNYkZC3pmvQ+S9xIaO5xShRSPnAzyJTOGvf1sR4RB0VHAS2rZRA0UMHn0SZnnNDo+7ldfD+WupVRocpEDqfc/fpQ5SgBPOGjf7zQE9n7iuzADqSxDg43uU5w48YUPxosx+eZ0DB5VXnduOvHHTMJCmx6OGleJiXANqFjKgG+aorVDWnF6m9oMbd2l28pJZoHynyaFrhm08q64M/Eg/H0eTpW/+zZSizG+rIVPy8POjVMVK8UE5L976ldqfB5tCs7UCB8W16WiZ8OOmqJkA3ifqreJD+PE5qHu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVFacGV4SniNSnyeySgeeFeg6E4lzyN6UFK+BMYvr+Y=;
 b=fqK+s2vJvny28KT8sjN8nH7b7EPOZud71Zrsj9fGAnpk5KqRh1PUiSszinQqbQfJnMTx1T2bI/ShS9YeTEF39rF3O8CIDqCqyjIySgamYmLNz23ZCB1hYB5volCewWE46jFbj2PxEfjj3Wku/SLsIBbKjLWkUuSgUgj7lIgbhx5HiqtdqpmG3spavivE95oYnllAJK8L0kUUjerL1z2qj0jliO8wqXB7yd5tOXauoStWSvvFobPHCbwWQVspiuqMdCeqUfUQ7FLjokzTFQ4EXvXh/CwvlbsMwbGIR+08uM/PLJw9Q4S2AZbQWB8f/zkb88F0SeAItNCKWbOfrX8uSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB4319.eurprd04.prod.outlook.com (2603:10a6:803:43::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 14:30:30 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.3933.032; Mon, 22 Mar 2021
 14:30:30 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     Pavel Shilovsky <piastryyy@gmail.com>, Tom Talpey <tom@talpey.com>
CC:     =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Steve French <smfrench@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Subject: [PATCH v5] flock.2: add CIFS details
Date:   Mon, 22 Mar 2021 15:30:24 +0100
Message-ID: <20210322143024.13930-1-aaptel@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <CAKywueQkELXyRjihtD2G=vswVuaeoeyMjrDfqTQeVF_NoRVm6A@mail.gmail.com>
References: <CAKywueQkELXyRjihtD2G=vswVuaeoeyMjrDfqTQeVF_NoRVm6A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:700:2815:b96b:85ea:1f90:5f2c]
X-ClientProxiedBy: ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::9) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:700:2815:b96b:85ea:1f90:5f2c) by ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 14:30:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d1bb7a-feca-4a1c-074c-08d8ed3f0b90
X-MS-TrafficTypeDiagnostic: VI1PR04MB4319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4319665AFE2B5B7BD48A4766A8659@VI1PR04MB4319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kf8KDqzX5C2p3C2aBdLmdkWbVoC9Cnw4omofpaWCrAd7mNj3c7d32xg6StHm?=
 =?us-ascii?Q?Dqsif5MRaorKQsd9u32oH0se3p/8lqRnBu9y9tezg529YYq2L4ndDPVgohJN?=
 =?us-ascii?Q?fT1CTuO8S6eh/Rn6mDU+ZCIEIIgxuodoJs3pO7K3K4I1MGu5tQFKc4kxCX9D?=
 =?us-ascii?Q?xlsARydTn3H4yN9gHj3KGMwuAOXa1z9t8Ja9QtUH/EDXkbNetYyqm5DMY7Qs?=
 =?us-ascii?Q?wsLUS5A2BBgCMhUCvfVtKB9lZTRpJqgMhmGvkbXOtnc0y8KDa1qUeO9SZ1d4?=
 =?us-ascii?Q?Kz8eNiBFYYdxNTfPDcKzW9ORvNS2XjvQi28uYk4AFOvc/fo65CHgXOYrbTKZ?=
 =?us-ascii?Q?DW+guU4iBpP5upu+mdwx5U+N2sAuv6TbdRz0Kw1ZHeWmGc0nJzDrCQ2cy4vw?=
 =?us-ascii?Q?0+EJtAVGvUigJD3/BuXtvBgaEdClZATSvuYSjZLmI6nPEXRHgofaUfekGKzX?=
 =?us-ascii?Q?f3J0qruZMUWajmoOMjjCr+laS2O6GVe3veJ6RR9roFm7GxDs50bCH1hofrOf?=
 =?us-ascii?Q?xYQJCMtRgT+hgOQpJgIGAw0qxNrLuGyoqkNf5rDYHed4ohPCm8/PVwnABfL/?=
 =?us-ascii?Q?b+D7pJznnADwwCSk6RZ6yUxC+vKDn9Lfanf53IRxx4PbMydXLc2+npB0cpf2?=
 =?us-ascii?Q?YQfc9VO+m1r4hvUJm8zod64lrbwv8NTcoEBJepu4sOzqxjjstM/hsfJ9F8UM?=
 =?us-ascii?Q?HDOhGw9Z4U2h9XtZr1Fa/ZXY0gNpmWc+C7zu3/jnp7XFPke6JMWRQe2x9ePs?=
 =?us-ascii?Q?oCyOMEsnBbcoyIfcihXe/YJ9kKb5PM8pFSFRFAqK8kgR9yRIwymStTUhbtEb?=
 =?us-ascii?Q?DjOT9dplmCS1BvkFfoK105YA6HczXiqCkzhD03lEreVnJbQ6e3bV5DnL6YCs?=
 =?us-ascii?Q?uzOZJiQaKgAp+Lxz52+owskC0kELzvUkGXnbpRop0fyzC3yk0uksNA+/K+XY?=
 =?us-ascii?Q?wR0epkyBHf0ViO8ksGziEMEFql1zqecXxltpoG2dm5s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(39840400004)(136003)(346002)(376002)(396003)(366004)(5660300002)(52116002)(6666004)(54906003)(4326008)(66946007)(110136005)(1076003)(66556008)(478600001)(16526019)(6486002)(86362001)(38100700001)(186003)(316002)(36756003)(8676002)(83380400001)(2906002)(2616005)(66476007)(8936002)(6496006)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?agQc/6tZN+eBGZMcRqQsu0KHHHcQ8ji4CWSWo8wmxjkhe8+TSMxr3diHgCSd?=
 =?us-ascii?Q?TtlDQILkuBgGjq2F/rRjXvGYu8H4sK76OcvLb1cXzLsg+T+EZEKylLDkra4R?=
 =?us-ascii?Q?8fAl+pPXhH2aYuEBhUGC+/Uw/D1j2TpFW7qO1Ny5v+gv7SXn6cR2b7+i8LAM?=
 =?us-ascii?Q?weOYH0sBSd2VNVsXFFA7AfK9Sj0UyjZK5jg5K9S/MofutrxHzpw/923H9dtx?=
 =?us-ascii?Q?AkkYXDX7BG31NRPu+M2+aP5B5z4eR8Mv/4Pid/ebt5fKygD1vhJ14HsSBg91?=
 =?us-ascii?Q?27oxbf3kzKBbSknbkc1sqJz/fsLeOh3bejaHY3TEKRHY4q8o64LZ/iY3le07?=
 =?us-ascii?Q?3/TmT6tQaAk35GpNkxaCz8CybFnEjy7D4230FZdaREUj4zuPkPG57WCjkimG?=
 =?us-ascii?Q?nf/NjEBtRhkwS92VlmoBXHLdARXobnISXdq519DYySHptp1IkObgbGJCLQW3?=
 =?us-ascii?Q?PJwW0mS4pSfHjt5bJLi6UkgprLyyz7Jsc7QUq3Vw8zboYClPalA1XKoJEQDf?=
 =?us-ascii?Q?Qg5x4f7x9D4tQdvZv6yWCEK+JOi1AggJG0n1omBcRh6g3grjSxzxf6SGKreI?=
 =?us-ascii?Q?WEI5Ls+3+OtzLXZ/jY3r5l+ZMxBd/kw0NDB9oCI60oK34bofDALUzZpGjfHr?=
 =?us-ascii?Q?xC6KEhFVxsvkpAaKAPXROppQ4RphVDOBX5ca3acwMlzjSYczNuGWbRnVb1IZ?=
 =?us-ascii?Q?Jn/hJO91LEwQXYHXHl4HKiOjY2Nqnj8sjRC21CvNC5z90umVjIyqazVuLscq?=
 =?us-ascii?Q?UkSL41hROVgrCTKSCGe/B1ziQrVjTk1pX2yj0EQ7mJqZRmyMTVrYFpFnsI46?=
 =?us-ascii?Q?g7aX/pp8buEqwRop2/oZR/H79sp039NYXqKpDqE/A4AIN0WBwlz+2h6M559b?=
 =?us-ascii?Q?7x3ZzVZF8UYgUzUPFZKhKOfwUA1OZnRnnOlO9enI0EX8hRtDRps029drjDZ9?=
 =?us-ascii?Q?1I221Z3zh5LuvnwhnkgtA0C8Qk1Dqff5JLFwS+A0mRkcoQI63T5dgQqkRWAr?=
 =?us-ascii?Q?//+bFDlPhmTqK6lmp6IblGZ3PvWZcrDccMbLVfi9Wb8L7BYUWdApoE5VRwRi?=
 =?us-ascii?Q?Y1B4Xs+mWJSH0yOGkz4FqupY/v7Vb8KR6zLOi3kzSimoY7o1Zi/zVjREMZXl?=
 =?us-ascii?Q?tLoNUTMsG2Nve+MDdzRJMQrhQa4qA/w7Rt9ITsBWQzK1csiZy4PtCjEYAbdZ?=
 =?us-ascii?Q?6iOhknrbJqVlMTBhlqDfX8/stNIgVbqmgAUqbqY+YPlbwUAvmqrcIZ8qDTc8?=
 =?us-ascii?Q?etojYs/lWYAyI93gzEhO06e2wSyMoEq/MkipgH6xHowwaECrfifRbakMPh4a?=
 =?us-ascii?Q?Yw2VeFbouRT7282n7If7JdhNf3m2piutsfJbSIbKoJ38f/DPISiWPFdrMFYH?=
 =?us-ascii?Q?wxBb/ysjEGbNniG7iDMFDYrnB/nw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d1bb7a-feca-4a1c-074c-08d8ed3f0b90
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 14:30:30.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkQXxDH78TMEoVqpM73j8bac4SRP8oMl1wq/Duyn28T/8/inHLJei1ZOYFQrWnNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4319
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

CIFS flock() locks behave differently than the standard. Give overview
of those differences.

Here is the rendered text:

CIFS details
  In Linux kernels up to 5.4, flock() is not propagated over SMB.  A file
  with such locks will not appear locked for remote clients.

  Since Linux 5.5, flock() locks are emulated with SMB  byte-range  locks
  on  the  entire  file.   Similarly to NFS, this means that fcntl(2) and
  flock() locks interact with one another.  Another important side-effect
  is  that  the  locks  are not advisory anymore: any IO on a locked file
  will always fail with EACCES when done from a separate file descriptor.
  This  difference  originates from the design of locks in the SMB proto-
  col, which provides mandatory locking semantics.

  Remote and mandatory locking semantics  may  vary  with  SMB  protocol,
  mount options and server type.  See mount.cifs(8) for additional infor-
  mation.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 man2/flock.2 | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/man2/flock.2 b/man2/flock.2
index 328377365..61822c9bc 100644
--- a/man2/flock.2
+++ b/man2/flock.2
@@ -239,6 +239,31 @@ see the discussion of the
 .I "local_lock"
 option in
 .BR nfs (5).
+.SS CIFS details
+In Linux kernels up to 5.4,
+.BR flock ()
+is not propagated over SMB.
+A file with such locks will not appear locked for remote clients.
+.PP
+Since Linux 5.5,
+.BR flock ()
+locks are emulated with SMB byte-range locks on the entire file.
+Similarly to NFS, this means that
+.BR fcntl (2)
+and
+.BR flock ()
+locks interact with one another.
+Another important side-effect is that the locks are not advisory anymore:
+any IO on a locked file will always fail with
+.BR EACCES
+when done from a separate file descriptor.
+This difference originates from the design of locks in the SMB protocol,
+which provides mandatory locking semantics.
+.PP
+Remote and mandatory locking semantics may vary with SMB protocol, mount o=
ptions and server type.
+See
+.BR mount.cifs (8)
+for additional information.
 .SH SEE ALSO
 .BR flock (1),
 .BR close (2),
--=20
2.30.0

