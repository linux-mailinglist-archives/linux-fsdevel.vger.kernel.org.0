Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306BA32D012
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 10:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbhCDJv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 04:51:59 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:22575 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237841AbhCDJvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614851432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9azcL2imnnY89Z/GDCp94UJJcpbvBzaJ5eOGLbN4NMs=;
        b=PRVqvwYKRYilX/ICsreXPWmScB+rC3Z57l67pI6v3dVtmuXHxWEF8OxgISFSP4CIJ+edIn
        f577DnnJsSQB23Zsq3DltXUt3WjIQWhu8lPBr1uZ/T75mHU0qn5/LWJG7pHKAfnHoFExXs
        655FYfgn6JukCnyi1CEFXrpLkrCJ/tQ=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-7zAgtrHNMOy9McYTN3zhfg-1; Thu, 04 Mar 2021 10:50:31 +0100
X-MC-Unique: 7zAgtrHNMOy9McYTN3zhfg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTeo7iY1B6fBPVcL1Mm5PRyKGqvH5cecn18S8OwIpUkl7bV+dt3Omg6+wb3F3+d20BCF8Ko+42C10PKGG0wWtqR0uIhT/BlQPUrVrZFRwd1NMrQdY7O86V0rdAgiFrmemkOzhjjr91PBYnMh0dJ+2361d9t7sTUUi6Sf9PtsRn9EH/S5tQ8DW0yqpLPvOceX9CJPlrSUPbxky8/z9IbCVa0kWIiWHEp6s0bU3n4jyYrRd9H1CxxmGaad/PW8v71A9Im5BLD2ylnnfo423+jPFjNJs2ywMR4SSLPDMeKlYzhyryI+Oew9t0kEz6td0BZ5CENFbrd8sUNe67tkW1WweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/FW9BkiPYujmFbz/Bfnzax0omN1q6gB5uYFT9WZEJk=;
 b=cS8Z4KUaNvSY1aAsSx/NR/oUCNUt3asC6PDdkk0/xF8Vz2EB9Yr9Nv+avhixxwejWZuZNq7UapgeMatTkheFDmRAvWAZI8/YZP5UldQDAxnmrrWMFPcXOPyGMp+ciSxDQO4WlSJsOf6zrEviTVcMPFcpU3yac2/9Iuqty7bHMRJ9RfpFKFpN4so7PKGTOHHtB5v2/fLN43YHXknvaZ1NVcM/w3wGE1VFGw4CEViPDc/cheu/wco+OZjsF3M2OrAYgJlqLsmVXPfiAv3VXwI6SysOLlErY7dX7DInhmXs9+6M4qKgoj6OQAkY9eUWvkNLTtcV3++rd+LCqkAmAUZ9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR0402MB3759.eurprd04.prod.outlook.com (2603:10a6:803:1f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 09:50:29 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 09:50:29 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com
CC:     smfrench@gmail.com
Subject: [PATCH v4] flock.2: add CIFS details
Date:   Thu,  4 Mar 2021 10:50:26 +0100
Message-ID: <20210304095026.782-1-aaptel@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <87v9a7w8q7.fsf@suse.com>
References: <87v9a7w8q7.fsf@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:70b:4a22:792c:d376:dd41:4ec2]
X-ClientProxiedBy: ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::23) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a22:792c:d376:dd41:4ec2) by ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 09:50:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c26c0dc-bc63-42e7-62bd-08d8def2f1d9
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3759D20FE69DFD185F341350A8979@VI1PR0402MB3759.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JeScGbhYywHRBVdCpz7Kbp388g84+WmKG4QtpfuPtUDmTxtFZd7bHPgWetObl4evHygU95t+nxcEeWGa2hoF+iAWlaVPn/WfW3u98idrTf4Ib8Nd+e1eN8m9hfE1gXYwvkGUuahxNlHm4yP1Kf4Ie0Xxjv4zlc8cPiz+8SYZFodM1/vngYSj4OmeF7KRFtTDfhWOOtuaUjfd3ITr4nB7+WzYlFsGC+5Lx7Xlmnf0lUFGMY/C2H3tJYM01Fcx9ugU0BsMxmtJY6HMtSr0AEo5Z+CCGk4LwZNc+6HC5+SoY5io6C/+uEI+HWGYPNfdEFRELpEAH7eELp+RRjPhtVRxuCcMhps7cafmzrDPgZ4dVfGwcu4KUtUjEIWezcyjyh/VecPlpXXIkjgimV9c3kDPneuV9yfYgxNByZo0BbFX7lsj6gfYa5xidSUtcmUsPfZ1nihVP0Yuq2MincEMjM9hM92VpC71KHRCtOskhFPiKfvuPsZS4/Zmh4expsMG64Ip4AhMs+zWytihHJladMvuXudWn3Tktem+8EBuTgSEWLzfF1oQs93uVCci+VRGaw8k7KAyIlP6XFf+2z5KQxQoOv+82G4Qj+w4zsiVH+v3fqa7w63IOfO8MwXwoMIn/BbAHlDlYSZO6xv1zmtpFm4TAh0PFDkBTfWZz0+/OHwha0U+w+JR1sFcQTygnX0kivQbQoqpQzl2yR8VzW1fx+T/nMsohsLuqKkjl67xk62dQ9tMoxnaJFF93cu0EyXefmOX9zhtMhk8tqPK3UUWlAiOhlhjrBpWZembu6xURgy004IyxYYxxRL8W8SQ7osyTfm/y4q9klYnbpGKfz2rUFc5z3PG5Yl3KwXyeKsRbNrgtYfS1Wcma2wv7flMP7AbJDWOVGNA4HmMCwLfb4dwXvpYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(376002)(396003)(346002)(366004)(39860400002)(136003)(5660300002)(110136005)(478600001)(66476007)(66556008)(8676002)(8936002)(66946007)(36756003)(4326008)(316002)(6666004)(83380400001)(86362001)(1076003)(16526019)(2616005)(52116002)(186003)(6496006)(2906002)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fvd+pe2t46drF6a+OGh0ZpLPcSh655gI+OFEeLk0yl3tp3xpClnsLnCAMdCM?=
 =?us-ascii?Q?TcJSQYHFVrwFPAoavAi7RqpRRq+xZjUEA2/z1Rb4H8T8sKLVKRDmFkxY4xOu?=
 =?us-ascii?Q?hUiyV1v7BZB96rGskXuIDY9u9Btb0AprVxKQAXrDItGDmNusmaHqvTUE1q8N?=
 =?us-ascii?Q?bHFEM74EMFanud8+VPCCQ/CwYT+cOL08MIupjVAuPu1d5Q5Qe+/yV16a+njq?=
 =?us-ascii?Q?VKdtIIHymIqj0twmAS7q5eqQ/9iRGwG7CQe/XowzmDEyza0S5gGoBpDT3MY8?=
 =?us-ascii?Q?1HEOyb4ak5cVec2RCDCDzvLgYNpgp4Opi3qN7P9Fd7CwJdeZ/LOxvLx6uxaJ?=
 =?us-ascii?Q?kyW4BTnNBKuoCo5YzjOyBASfqfPofLxGYOY/F5l5gXwxRBc3Bzitmp+Kovtb?=
 =?us-ascii?Q?qFv7i74n/3gGw26Dy+/r3kgxdtWxAzBQAVdArFqxznIDBAtXSYmibpgNT+JG?=
 =?us-ascii?Q?wN++8SML7IAqYZqa0uCK+NILyRFWJ1ZOxK/bT7HEXUFJYZPNiPkZDsaRD2K0?=
 =?us-ascii?Q?5dvMbd0cdxgEMCUfPIRxeBcx2oZnJNAUBAcmLKghSb9p51pS0BGAss5X9/5N?=
 =?us-ascii?Q?iuioHPhOL94Ix9SLsJGXYPS/OHixmBPMg2qPsbA2suoNfoGgicL+b6da9cLK?=
 =?us-ascii?Q?q84nHagOry30bcYWyOFPl35LBo8763t0lED09VeI7pd+KxmgtZPBWYy25+sm?=
 =?us-ascii?Q?WQMBe/N7kVXX8fckDNraACbDwoi/JPXzucyXsInVz30guAung3MTKUYoCKYW?=
 =?us-ascii?Q?FANuPQd1757JSyFYhGkOVJW5Vuxf94VXg8PK5eK+NRH0u2uYh61GQsfn7ZHo?=
 =?us-ascii?Q?kxfMVsooWwKaUPOMcR0B7t6ujtRmkJ7BTck3caglWYXbzvB763rZjkRxYxaC?=
 =?us-ascii?Q?jDryrC4/BV4tmgxs9Z2Wf41aygINANJgE4mDn2vdo31SMqa8EsiywYjkTouo?=
 =?us-ascii?Q?YNbmc015uZwmx6jWrFQBraX+mdTwWXHBPofpb0JdrJVzZpVGEvTPH/+swGdi?=
 =?us-ascii?Q?waj2zujtCschJo10hnMbJuc4jjA/7KUyb4dNee98FI5+PoExHg+jRtwM6D2k?=
 =?us-ascii?Q?qGjgu4VMLzLkbJWOv9vdFzZTKDcQ68rEjVX8lf/Ghmc0BeOeT8ctukSm1/QI?=
 =?us-ascii?Q?CnAueDieyCc7Of7+II/X0gSlrq/5hBC+XRs0yif3TWP1PRB6zNVKLTFzq4cn?=
 =?us-ascii?Q?A5s+p89MCTrQwm4cEyi4q2pWH5wMCPT57zPbctgc+KiRDP8/wUhB/1mibqR9?=
 =?us-ascii?Q?eXPxFjtjBQjnOLcBJe0YsNq265QKlScY9s2R+KdIAKten000AEcpXoJWGD0r?=
 =?us-ascii?Q?OAzwEoLgyAUEU17jeT0S90hGHFydOZpUCnJrBH3W4WMQCEpr7rmJTLlZWfwt?=
 =?us-ascii?Q?dy+ZSkrHfCcyljKlGGg/y40nfESm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c26c0dc-bc63-42e7-62bd-08d8def2f1d9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 09:50:29.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eg22IlJY4j4lyoylrkiFrNRk3EmjzGPPRAXUteEH1cTWHNMIoPAqeC89Zw5Sp3Xa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3759
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
  will always fail with EACCES.   This difference originates from the de-
  sign of locks in the SMB protocol, which provides mandatory locking se-
  mantics. The nobrl mount option (see mount.cifs(8)) turns off  fnctl(2)
  and  flock() lock propagation to remote clients and makes flock() locks
  advisory again.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Reviewed-By: Tom Talpey <tom@talpey.com>
---
 man2/flock.2 | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/man2/flock.2 b/man2/flock.2
index 61d4b5396..d447eac9c 100644
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
+.BR EACCES .
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

