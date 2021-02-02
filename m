Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E775A30BCCA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 12:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBBLRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 06:17:30 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:20016 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231152AbhBBLRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612264576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ls3ZGXpnv8cqEGYtY5SOnetrHNj1cxHCqmSgT5VyFiI=;
        b=mrimM9TxqtKAw+FXRyNKfCmvpMF94+3/Mg6sVjC2KTczyPOryyqYv94ksz4yU9DmnB1vW/
        1cXvwm2Kp60GnCXeOTTMCeZIwwnf12xIbgzut/AK/dT4VkKsUFHE3Hge/bAb73VvtakAjM
        ktDDnUc8+C1Xwf85n5hMM0Oaf3o+auQ=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-CUi8iV6vPpSdeplDmP2_og-1; Tue, 02 Feb 2021 12:16:14 +0100
X-MC-Unique: CUi8iV6vPpSdeplDmP2_og-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT4WTZ9v2k9KOEP5dDX2YVuCVo6RGcU9ujOhtZbkIC+WINa/QiTCWcWCzgYAaARrnCfHBYHd7IqfBOK06E4BGyTCn7kAa0Vrf2yGafD+//3zN57nsKQKYDXuVbvqKw0SEcTuY+cve6w7mH8QRCxhv5Pg9ygGf7p2O1p8lPjw7qGVSzQE31fGpZ9FXm4dB/JiSsd7AXLexqDV3gkZGOzYY0HpU/fOp3spvTNV2gjpvgkFFwJ0vh2pAVpEEw1y8Nv3gyvpyIVcfeUzun79DaAYxZhNoX5AvGPxHO1cg9ec7cQF8KvJxOG0jQm10shJRe+WiOuvaEw6QVSabxuE7JfuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XCwTb/nDUmqpWq2fPaMtnu4HIQsvdIR7pT8gRiYofE=;
 b=YTpGgIN1KI/mf7Da78CwKUpyfcgVzw9abvgz/89Ske9tnAnEeUp8vZAhSkczMnepnWkdxPY9M241f83K5y9T7jk6x94EdQlSTnYBGnncjSQnOWhIiRHf35SP97GBAb3xEUH54q+0TA06D7gRVf9PwpFLH0fQDabnNF+IbNArwS9dKUcPY4Zr1Z4oGnkkxbXiZiAD4BGRFWyIth4m3yHXbILs2UILJZx6vpfNul0x88G+Akp4yDpiW81sP+g9FbygKmB1SrrPGYTK9e1AV4waoOKAKzOjG/zmwV0oO+CIPBkDzjCEIX1/6Z5Q0152UVndA164o93MpXmMr5yvfw8DuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR0401MB2400.eurprd04.prod.outlook.com (2603:10a6:800:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 11:16:13 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3805.022; Tue, 2 Feb 2021
 11:16:13 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
CC:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>,
        Shyam Prasad N <nspmangalore@gmail.com>
Subject: [PATCH v2] cifs: report error instead of invalid when revalidating a dentry fails
Date:   Tue,  2 Feb 2021 12:16:07 +0100
Message-ID: <20210202111607.16372-1-aaptel@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CANT5p=oSrrCbCdXZSbjmPDM4P=z=1c=kj9w1DDTJO5UhtREo8g@mail.gmail.com>
References: <CANT5p=oSrrCbCdXZSbjmPDM4P=z=1c=kj9w1DDTJO5UhtREo8g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:705:9f33:33e3:4e11:8cc3:3b4d]
X-ClientProxiedBy: GVAP278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::13) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9f33:33e3:4e11:8cc3:3b4d) by GVAP278CA0003.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 11:16:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f62be455-7c68-4b49-15a0-08d8c76bf33c
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2400DAEDAD54585300F2018EA8B59@VI1PR0401MB2400.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Z47wsqMC8eqU6K1UhYrJfxA+neb3i8vHjPwTRpLSJ4pkvBrFkLSB03Pdfhj0MmVK6IFPRU9SgXf4hfmVOqi1loL3YFJ2lp5InowFZOFFWSQSnkDjn3ONhAwRym15pgpW3ngpybWUvS54xu1ziIFa6BNW2hdraUV7e4FBleYkguBXDVlyfmRl0NOJGhVMpCHURdumOOaUU9MtsCvrFbVk7PFhXcK3GzQ9WCFQqqwIOV4gclpsS+esWRgxd1vvj9SvqgXDUZtv9Oa7981CFXXsWySue6YCocbHd1YusDKUvKTThLQJ4nRytPRFs2Y0o0Czxs2+giLfI2NzbDgA5HCqmnPtKYCM6Fj2Mi3vXYU+mf4Q5/V5ciWRxCR28c82PmJITugggaIxCFfpw8YPseXJ1xI1W5XA8XyL4BLMpnv96bFN7w/kMDEsZow1FEmIXa4UZw7dItVju7mZSy7QBM+aWrE8zOjZx47ym5Spl8O8HBvMbAqBQuZX9As3qRGpIcolu+KQEobfOM//sKpIR4O6TlV2Hr2MS3hwKcMv/H70fh8OCH7A3XbzJsWADtXtvD2iRlrv6w4SeMty3/UjRlBOkJJL9/RUIDNHcduXDpCDFFB1F50LuLqKADANrbjgue847lZWN7n5V9mClcEgEPzkKyXvaetvryA7jjwpFMe4X/+AyFshTKrqWq8DIFeKh/jcU4stsT91Kryz9KjaxClebeM1+ues2vUszfb8BOApr2S99U5e+aXUCTxtTHh1GUpDs13eNhzTrX8hG0RA+Nx8ckz8kBifBUPKVNcNQoirOoVWXLR1d8/wvqraEKrzGfffeCaUbXGk0DtF4TxDGZydcKeq5JGnGYTlJqjM21Y5nyRyw29IxpT3jTM+61B/HxqxRBL+V29EaqpItuzNkFr3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(376002)(396003)(136003)(346002)(366004)(39860400002)(6496006)(52116002)(2906002)(6486002)(5660300002)(83380400001)(8676002)(186003)(36756003)(66556008)(316002)(4326008)(2616005)(16526019)(6666004)(54906003)(66946007)(86362001)(8936002)(66476007)(478600001)(1076003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RiFAaDWt2fdDQIu35vh95vyrLYdljolwnN6t+Sg+FYWHc4161mv9MiDHtG++?=
 =?us-ascii?Q?73pUmb+uO2cZ7EbMYj7qXo/FwQtVDDDfTlpACPvW+YF8n8QSqxEnYL8CtepQ?=
 =?us-ascii?Q?VKY5qYtBU5dXnF50ziLrGJzdIQHkCqr0R1pAdZTVw5/qiSsS9efClYB2P3gw?=
 =?us-ascii?Q?n9mDGQUrycUemBNxrhJ/eG+AiYDOn4GZ7AEzwLGZl+ebVxwCOH0OVbWdQKQf?=
 =?us-ascii?Q?0SL8w0D1XIPeNdZjrlXrtFU8LPMRlc05I3i2iLyi/99FX8eix3XOsjY1Fmfc?=
 =?us-ascii?Q?8kMxGnpktRaKNw0LkXFMkTcaJJiZ7abqckOsJ+OeLb1zzF4A10QYBeKBBb7v?=
 =?us-ascii?Q?zupdj6B9t7zuSxZISrFRH9XuRasn+nS49m2u85Zmibw/snTP+wu/4Lr1rsHo?=
 =?us-ascii?Q?4CMlHqb0OO7QkUkd/w3pRoadE7M9kKwD70WpQvDlumyWfesceZ5KzJQ37JlM?=
 =?us-ascii?Q?tqkGJSy87QgH0YAF4cYzVtejYBQvAeQ8XXKt9R2GDPZSCBPtB1btUG9SgHF6?=
 =?us-ascii?Q?2CyNmAA+yxbfFlvlFomanI3VrBsQxTCZVNC4qoDJgIh/7tON8Hv35rhRArR2?=
 =?us-ascii?Q?6prjOGnfUNZdZO5UpTdmNOu6rI/gjJ+0V9hc1SZy0XneWy2PEd9EF7PELEl+?=
 =?us-ascii?Q?N8P9ciTIvyNKlO3Ulye7gP0JGZTBFlsTuviHoq41DnoVIZCxpm+8U9jNl3QK?=
 =?us-ascii?Q?Lx5DCvlrWoFxgECitajY7JNozXlvRyBp9aJBvlVQn1SP9sqQ92cyqnVvpEka?=
 =?us-ascii?Q?fYXVfYxiQ0UvC9A5XLew2YuvDKabwBy7cuiLSfxEKEYWeTqeGAtRaLfWkTRZ?=
 =?us-ascii?Q?LYXdpye7Hm1HNQ99nrguJxyG1ttAkYHOtnpIlOpHh4BScgjdqQCHJPLo/IEK?=
 =?us-ascii?Q?xrKhUuaF804ubdKTJ0olhtX8BqPdrOnZwgWQdNlX4pjqQNF3yGYNXHLtypQJ?=
 =?us-ascii?Q?fhTJTE3Kg0GFl9KruTXYR0WD1qbubeHejQneT5YxhevboNxBM9fQgOR36dSt?=
 =?us-ascii?Q?XNutgg6mhUsdCAaoYnsSeHJduw2DtzXls4grjKyycQOJ0SU/Qutun/uUFRo4?=
 =?us-ascii?Q?sde0qsZVauh8b1K+sThKAo4jTPSEQgkAEWyP7zXvW4DeD+5Knkh+YEMUFP5V?=
 =?us-ascii?Q?Iei0tVIcWE4J?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62be455-7c68-4b49-15a0-08d8c76bf33c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 11:16:13.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHciw7QcwpcsxV4cfQ0HwvJP5LxJZYHmPQBB4KI4l81SHwoRRlIYvQXF45/656Db
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2400
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

Assuming
- //HOST/a is mounted on /mnt
- //HOST/b is mounted on /mnt/b

On a slow connection, running 'df' and killing it while it's
processing /mnt/b can make cifs_get_inode_info() returns -ERESTARTSYS.

This triggers the following chain of events:
=3D> the dentry revalidation fail
=3D> dentry is put and released
=3D> superblock associated with the dentry is put
=3D> /mnt/b is unmounted

This patch makes cifs_d_revalidate() return the error instead of
0 (invalid) when cifs_revalidate_dentry() fails.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Suggested-by: Shyam Prasad N <nspmangalore@gmail.com>
---
 fs/cifs/dir.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 68900f1629bff..4174f35590e62 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -737,6 +737,7 @@ static int
 cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
 {
 	struct inode *inode;
+	int rc;
=20
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -746,8 +747,11 @@ cifs_d_revalidate(struct dentry *direntry, unsigned in=
t flags)
 		if ((flags & LOOKUP_REVAL) && !CIFS_CACHE_READ(CIFS_I(inode)))
 			CIFS_I(inode)->time =3D 0; /* force reval */
=20
-		if (cifs_revalidate_dentry(direntry))
-			return 0;
+		rc =3D cifs_revalidate_dentry(direntry);
+		if (rc) {
+			cifs_dbg(FYI, "cifs_revalidate_dentry failed with rc=3D%d", rc);
+			return rc;
+		}
 		else {
 			/*
 			 * If the inode wasn't known to be a dfs entry when
--=20
2.29.2

