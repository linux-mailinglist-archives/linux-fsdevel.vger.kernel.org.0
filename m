Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A932C565
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbhCDAU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:26 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:30706 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379031AbhCCQji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614789509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJPYkd8F+Be/m3NPg6kdtoq4qchR9h6SA40Kvry6mOg=;
        b=eyqTQ3ckx9NM9Sae0Y4X+kDM+ztetPWMWSYQwszp8SHUnq9zcPKcxB+B5s5Ntl8x0/7e6X
        mcoEcWchcKsmuNVHNblEYdPFi8kV1F1jzNOA5KJrzfMlB379f5x5IRhJ3mYz5UQmadd7ui
        36S+29bXHyyUyC3Co8dDNNnKCHYx6PU=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-LdD5LbyuMzOaNBEkpLOViA-1; Wed, 03 Mar 2021 17:38:28 +0100
X-MC-Unique: LdD5LbyuMzOaNBEkpLOViA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J06xrprMFpfjcxvRRk7mNV7Ry89Op3Q4iMhIevydABKt94/Ba6VLxQlLYqFYp/cF2U6BS5lnmgr5dZtyMhwck3lf4sKu/WyTgrn7eUQ9g9ny3+lk9nmEpSyfjUQbY7FccwjKBp3mHq7oB9p5CJ+OciYrw+SGGutUAK9gLdI3b/vV+IIVSiML4FNwV9Sl/TlbppLJXV/Q5x01gAGqOwkUNlysdyw7s48ukRya5/NENagXG+4QHjY+CpwtErizphLJbHCUMCSKUQ5OiEnW1iseVt55LB/jPVFkq7bVszIGN3FWhZegO51oYkQXAsIccE1qZ03r5ofeJ2xhZ3cjWiPDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqX0PVizHFfcCq9SXiKnpontT/1mriLg94Paeum+ucg=;
 b=BDYkOyQes7vVnqE62pplwFyD7BFwQdhGAMyFrNqp9WPTII6LWMN8I44O8WLiHUPBvdQPPpC2VNZBrgb+iWJSLRh1JAUnAA4IdQqbf0Li8TR4hxNdm5oHowi6yFDbRnj285iEm12zGVjYPyQ2A0Qg9EbgVSuszJqUSQD2fcXSpA0DAT2T5fg8g7eGnEP4VDdDHWKoIGU1obnNNzfYkT0HtQvVkWayJXmcOMMnYAtRXW6TBj0T2h2c/VpmxZGMlO7xTV4bDPdoC/fTIKDYpX9S1sJYXBjwpridPfCJSKkXH7CcJ3gaqmxi9icITLbS2ZYFivzMlOnPpLaxQ/0O1QxF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB6221.eurprd04.prod.outlook.com (2603:10a6:803:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 3 Mar
 2021 16:38:27 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 16:38:27 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com
CC:     smfrench@gmail.com
Subject: [PATCH v2] flock.2: add CIFS details
Date:   Wed,  3 Mar 2021 17:37:55 +0100
Message-ID: <20210303163755.31127-1-aaptel@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <8735xcxkv5.fsf@suse.com>
References: <8735xcxkv5.fsf@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:70b:4a22:792c:d376:dd41:4ec2]
X-ClientProxiedBy: ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::10) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a22:792c:d376:dd41:4ec2) by ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 16:38:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 533106f5-1c99-419e-4ee6-08d8de62c591
X-MS-TrafficTypeDiagnostic: VI1PR04MB6221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6221C36EC72AA6A639E02F1EA8989@VI1PR04MB6221.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUPxwh/tm+MOXF7crpAjZV4KjO14/Xkysx0CFKZe+eOrOfSnKortmKkOzfh2DDJdmupwH82LymI8NP9SqKG7DpjqVH1+0ZJ0COgu3d3bB4Ex5WTWOlJhVcsgwX62774EyEiLKvqQXfl6kmYxB2NaIsiK747I16wwFE01cIDrDdSeFpEmWjqSa/vVdzwSnaCXp4gQQIQwE4R+HMimKxz97Q7HCwU8J8WbsioBlHc76HTCnl0eUJQAGXSmcrBLaznbuPlW1S3eMjFp99otVkOdiAnFCJ7adRuH4519FVXHF0fpiinCag94Dc4Wz/feD1jpl5BdB2TSk7g+odxK4GxMcptu5mKzPfwahg5nZalL0RutnWpsLzQYY/9NiCA5MxmkjaS3pWmJLgNsR9GyJ5HOVpjntFBOm/znSmvnlYip7ywu+daUm83KzmVZCqi+9sfx6SvRC/KNdnKdgi3L/w8jENAUzNTLCVqGp3k+48VtHKgVclatbSobxVJnFunDj0Wfl1QO2JV1N1iSdXhSAqkzOM+e48YS/HN8ig2oHke3gOwP1y0QTY+YZ5KgpL9LHs5vcTBg77cfsVRcyDQFY8YmvZZvFYWi2ewi3h0+Y26AAE4ao2CrBnKwWfxN4cKmJIaDxOeL/J51ViqmYzx1c+qUHKw74XY4QTVFiW/d11mRQRXX8kwdWwu6nT5EMhT6y7tBOxftK2KE21C3AJhGcLESM2SbZS4hipC8qqnWx+3IOT4ZVBCVp4Xp2nahAfBt7cvDbHFmhNVV3wAHH719R6w7vo11yQyTwrZ4lWJI3TrVODCCiQOLzf2ekgku2Tp/tEmAjjYCMZMADJJnc6fP7pk5gmoLrYSJFVP0zBsYRimitlS3qB3CYvnGyvPLdzypVlhxFt8ghwZP+dtkczIpoUMrCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(396003)(346002)(136003)(376002)(39850400004)(366004)(6666004)(6486002)(4326008)(52116002)(36756003)(83380400001)(1076003)(110136005)(186003)(478600001)(316002)(16526019)(66476007)(66556008)(2616005)(66946007)(2906002)(5660300002)(86362001)(8676002)(8936002)(6496006)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dndsKZ5CiwG8JpRdAeA5AIC4N8LJYjj5fekycurZ1ztaiaGi0XfZmdjt/LBr?=
 =?us-ascii?Q?bu88hn9jsNNKu7ap+Wrrrv78OTBEbGagZCGf9wxPg83rcUyfBcyef+U+1lYr?=
 =?us-ascii?Q?p2OabNudWxRZh1oSJnMSGVIcdJm9teN+8Z7HYEPA+tHCyONao4ZggiaqaK3Z?=
 =?us-ascii?Q?eljSDy7LZt4It/Wioa74biEbysYgvyb2CmWLf0upq42wvFzdZoY21qzjcFe7?=
 =?us-ascii?Q?dtQQYg5wqfi2p5J8BgRygdb163QwadhJ/4K/dUGaVAHXAWQKAnJ7jlATytzP?=
 =?us-ascii?Q?dfOLIcLWF+C4dEUhquChCTpdDEx8t/99ek58cV4aUTYDgKkEIGLWECyWs3JL?=
 =?us-ascii?Q?gtU3Sl/qw2hQwQIO9fRxVMQFA3CpMu49gsjCA3xWnyKZv7Ct3c463XDUdp5n?=
 =?us-ascii?Q?6+KJ1QGzKDnVfjbeCUAF+cPRnZVP71BDac9ytLkoRFuJOkKkjhKCnIGiWLgs?=
 =?us-ascii?Q?g5xO7PA19oB/3vetCsHm+cj7mw18kyxHWSW3WfrPhZ2LplncFAYdhiDB+Pt4?=
 =?us-ascii?Q?FwwjqHBXQalMxHafJu34tGCJtBPHYg5/+TgKujO8wpiodzwFowXD+lxCXvEq?=
 =?us-ascii?Q?3pGYXj3KU6qceWK+DRaDLuEWJUQ307vx/N6wSx2zm3qBOtKrFt284zoARgFq?=
 =?us-ascii?Q?sIzb1sMvYRoNCNLUJiIbBlXdDlwSmnq6UCfLbI/XH7BSkj/uCV3mvfleL4xt?=
 =?us-ascii?Q?nWhzN+m3UWI0NnEnc6NOBfC4TXftu/BDi8VOFqTGjab2157FHjJKL25Fa9mR?=
 =?us-ascii?Q?CaY+e8FD/+j0nvXsaC7Af0+Rf0JBvISFtgIM5b4U95yieJjRmk8dQS6BDixQ?=
 =?us-ascii?Q?EFJdWQVKxig9VUqqPsTnG1nqVnRcgts7RK9gtZzYbeZem6cSlh0JOmrb8Wc/?=
 =?us-ascii?Q?oB1x6yrw6yYtkWfZIKt19eFL2lu+lp0S2UG7avYa+FereIB555OHEdcMOc+0?=
 =?us-ascii?Q?98QSYUShW/HCBCj/W5dtsI/Bk1b2ZoQi9+BF8VtACjD0oEqS88Se60sAUTUA?=
 =?us-ascii?Q?3kxcdCu2269HZRC09LgoqDbQIx7UzrGpd25LRxhXA/3kGsYi50mvti98zN4W?=
 =?us-ascii?Q?bUqPa/hMUubmhW8HEBm5qH6Lyn0SLa0jJtEWu5+ok09SPmqz51Zbmq6GTG48?=
 =?us-ascii?Q?7CmoTB+c/Iz112+voODRKaW+vzUi/D2YbNINmahK75+XqqghV46zXq26sezX?=
 =?us-ascii?Q?e9NBSwDvZYXjmADCP3hWy1ptiwA+dSxOJcNoHnWRT2uqE/zU3EcTr/gVEU6r?=
 =?us-ascii?Q?Qn0T1QRWEt+c4nHs7XfLRBBFTQimVZ+FmDiRpx38hdZscO8YBbzgiRwsnE8o?=
 =?us-ascii?Q?L/qw1rXFWxq0F3GU4aUxEaRa33dpGne2dkdMlQC5RUHb5E6D2UC2MbC3Cm09?=
 =?us-ascii?Q?TQDxvk2eDV4VdpV90JYrPaSlLL7L?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533106f5-1c99-419e-4ee6-08d8de62c591
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 16:38:27.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMiAjcfUgKX/W4X0h3aPRFDcoedbvNPZ1V9rZXaJvtvpzu3SvDRYtM5VbK0yM9hw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6221
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

Similarly to NFS, CIFS flock() locks behave differently than the
standard. Document those differences.

Here is the rendered text:

CIFS details
  In  Linux kernels up to 5.4, flock() is not propagated over SMB. A file
  with such locks will not appear locked for other SMB clients.

  Since Linux 5.5, flock() are emulated with SMB byte-range locks on  the
  entire  file.  Similarly  to  NFS, this means that fcntl(2) and flock()
  locks interact with one another over SMB. Another important side-effect
  is  that  the  locks are not advisory anymore: a write on a locked file
  will always fail with EACCESS.  This difference originates from the de-
  sign of locks in the SMB protocol, which provides mandatory locking se-
  mantics. The nobrl mount option can be used switch back to pre-5.5 ker-
  nel behavior.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 man2/flock.2 | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/man2/flock.2 b/man2/flock.2
index 61d4b5396..7c4e7e8c9 100644
--- a/man2/flock.2
+++ b/man2/flock.2
@@ -239,6 +239,27 @@ see the discussion of the
 .I "local_lock"
 option in
 .BR nfs (5).
+.SS CIFS details
+In Linux kernels up to 5.4,
+.BR flock ()
+is not propagated over SMB. A file with such locks will not appear
+locked for other SMB clients.
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
+protocol, which provides mandatory locking semantics. The
+.BR nobrl
+mount option can be used switch back to pre-5.5 kernel behavior.
 .SH SEE ALSO
 .BR flock (1),
 .BR close (2),
--=20
2.30.0

