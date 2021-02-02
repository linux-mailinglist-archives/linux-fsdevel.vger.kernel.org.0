Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FDE30C83E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhBBRp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 12:45:57 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:33210 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237823AbhBBRoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612287781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGcnKVUALzGGga4EVprl6Cu07r8GRqHpwFmuqLlvnO4=;
        b=TUn3v9hZvDpGfUPmqDZ7iGI7IkHkpWVDQP8KY4E8XRNFy0YRKnlS7ysfMVxSt1C+9lbBMj
        Bgj2NXgvJuK0XW+GruY70aTSkUgDgbBBNml0GhUDxvtkGZqLuuT7jcwQuHMnT5jDQAoV5M
        q8JBF29all685DySoNWNf6dcAwM7RrM=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2057.outbound.protection.outlook.com [104.47.10.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-qgW0Yw_LMTqSbqH4mzKAhw-1; Tue, 02 Feb 2021 18:43:00 +0100
X-MC-Unique: qgW0Yw_LMTqSbqH4mzKAhw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgKgWn/43czZANi5B39mzKnFyCYwTr60sxrcYKAJdaAxaUKY+H7PZuegEfmoYDAwCD/3psW12gM6t9GDQsErURWcfc7eEU0x1Js4F02FxlLtSNIDXzeOr8ZPqwPjtdh3o1ucZLdjx9oupXV/axrgTmwiV9A8tiu7ZdDTw9tUMOMTqk0enhbwDL15GID2ckTBgume9G5bmyfPyz73TwvBp61wlk6EPHN8ukRIwYWI4UxrlgNIXy8oo5RByYArx3a1tbXccE6ILGj3DCLc/0aMy5VixuAME7eU8BSv7/HQnRmPSXLeMWBEmX0s7P+HT3C5l48cB23dg8rN6zZR2LNF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJsEHSSTZ6DgO8gx+SOhxzgHvw7aWzR1qoEfzaMA2Vk=;
 b=S/r/uGniVmSbOQhlj3ynyPdDeQmuezI9SKLLy0zwUToa5vCwLu6CSvPd52oo3myq/r7DcfRdFISfyoGCbd2OWLarSVc4WzV/rRHLAKMm5tt+RM7o03z71AtRo09TkkAbHVgeiOxBcLSyxUl55nOdy1cULBVWGazCUt2zKUV0NJS/bdK/7jW65b6dOmlk5EglNFiF2FTsHscgbaoD2071l1lTIwH7PUvwICQSJdoxJhe4rzKY37MHVwP4pwE1Gth/4RhsS+ZU3eFh4dDIfc5D8KrHKW23S3Vb4ujDMf0wwdcYOZMLSxgUbuVacj6f5e8+bkrqoeKRe+JQ2t2YiQU5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB5215.eurprd04.prod.outlook.com (2603:10a6:803:59::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 17:42:57 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3805.022; Tue, 2 Feb 2021
 17:42:57 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
CC:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>,
        Shyam Prasad N <nspmangalore@gmail.com>
Subject: [PATCH v3] cifs: report error instead of invalid when revalidating a dentry fails
Date:   Tue,  2 Feb 2021 18:42:55 +0100
Message-ID: <20210202174255.4269-1-aaptel@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
References: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:705:9f33:33e3:4e11:8cc3:3b4d]
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9f33:33e3:4e11:8cc3:3b4d) by ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 17:42:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3f6c55c-df9f-4d8c-b251-08d8c7a1fa33
X-MS-TrafficTypeDiagnostic: VI1PR04MB5215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB52152115A2EDAB82FD41F8A2A8B59@VI1PR04MB5215.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6tCMpCgpm+HFLsmvVgPwGGRY/oZv6xEUwznIzyr4fdTrp/g7/TNaQXB9jVmp3vUpq+D1iA8rGMqBaP7/4KO+9X3vlvQx03ULuEe3xbBQm+USQcdFWhbRWIyMZqTNkYwWhpibW1gRh3qeP3OcsQYgluiR4b0i3zUQ2zslrdwwI5HoQ6+S8KEsF5+xBhBdQ+VferGCTeuWPb2JnUfeyiHQMIzzyLVg6TLI0yd8eeIMbA+5Q7ri/1jsJCn9V7JhX15tZ/Q6nvMojJPtDLWSiwQ8MPInsfWc6ek6YBH5YaaOJRdiqY14gWY3vLScakuxLJoAyuScjk8vtJBgwFGeAG3Or8pcCDOdRvXvcAk76omp+UCN+QvKo1dTv9K+n2eSbLzRQpHRqNiAaoQDmqDAoc/xxF0yPRJoWvq7r65+wIl3XV/jHlcYtJD1Y4i7MYdgh7SIYoLya2Qn8YlF9fheIyQ9MePiz2cRwzz21/qGZ9rMMWwqgs4DZYxMAK+2yCYaslv7bKZ0W2ZUhklstVyUBkupNotdjl0Rdae6kAt8/29a/MjBc1EvXFO4E4sJVsO4IkyaJD12sQFBqqtL21JKe/deo47G2dCL+xVhSmUZqMJFOgulOxS1JAXLTlWFMGE6GML2RFnR9PcV8vDIELuQYhGheg/6ZFqtDH4LwQnXayiAOOZx7nV8mF2tCD0HB+SteDTcEA+7yCAL3Lxz/1UPBahTpS4Y9ZUDk7DFcwjDKhXRK7wEtUYGhDFnCPrD1fzEcJWSnygoEotKu3aZGXJsGuaN6oxUcpoQIyEQbIHfG/I1+39rcg+VOykKP26tbc6Y0i3UThuIMBE4hx+ZRWj8pe2O2z7P4HWJ2W0V8jF01XoBGZ06GVfgZ8mKGW1FeRDBQ2yirwVs3zFn7E7cwlHDD/kZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(316002)(54906003)(83380400001)(478600001)(2616005)(6486002)(36756003)(8936002)(6496006)(52116002)(8676002)(66946007)(86362001)(2906002)(1076003)(186003)(66556008)(66476007)(16526019)(5660300002)(4326008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kx2MnQgyIvDzKKVo182nNTKtJ7ui0pzyNZMaFC9/IlfVx2tFT0aBwE2XOsoT?=
 =?us-ascii?Q?UvBvuJDgQ1yAWgSeQCyinPU9pAJVU5NHi6jecwGyD17hrpZJQfBlW83k0d4X?=
 =?us-ascii?Q?Qi5YWA45U+xjQ5vngfUqlkTFBScJHRBvA7TYkgJeefCE2iJbs/bw/GcvEMF2?=
 =?us-ascii?Q?SQNPIYX6D85cAxwE5vitGGIiP8qcUOtYCbCah7WZRObnGQTpqxFlxONsorqk?=
 =?us-ascii?Q?nyPeyRdDEZlid0xnOqleUKL0Kr7R+EP3PcslHam2ydfdJaZzu0fQ2eRZY6BS?=
 =?us-ascii?Q?uBeezserujpovCuWvPed79HwwlqNJxT+d8MagUyiMsMbSjqTg+S3Qo3pPVSU?=
 =?us-ascii?Q?rcLZFynK8jzB6iI4WSlDeDyEwuKmHtZzDhosS5KGBLUoBpMSzta9Et17m8XI?=
 =?us-ascii?Q?zsIOSTf4UjnCxcorsKobTjPRPBituOuFVPYosh35A7EyTdbPTS+Sn272wGfI?=
 =?us-ascii?Q?dKHjze5OrPFJlcMomNCWwEUsZ/At0oxTv1wqxsrsZcCVQbApl+SOO8U33sqH?=
 =?us-ascii?Q?LS51FrndQqeCmEv83vhd9KEjRUhsiEMWviM/9SaKdlkuUKf0fPUDJcf3PhiW?=
 =?us-ascii?Q?//kHGcoxjiHLJHkQ2XRNpWhx7H2wOcneuCLOqOtIdtHRWjdICw5skkQ/Frez?=
 =?us-ascii?Q?4PWYXje4DqP56xn3wAxxTG7A4mn4CUPs3/yvRAv4SYZLGZkkh235otdTUAW4?=
 =?us-ascii?Q?l55ceAu3OykkydrdLiuSsgGTJDk+CB70O/MFd19eVwDbavhwRvr/RpI6nfN3?=
 =?us-ascii?Q?uYcrvX7pfT3AC9nAwU5RJZF3C/Ehx2JnmdZ1fxb+Q5ES8FGJXpWZkV0DO4r2?=
 =?us-ascii?Q?PL75llUue8q6A3BoxgNXR5hEnEHQFtLy34v0JlNeddtshXuBRn57JWbOmoG0?=
 =?us-ascii?Q?b8BeGCcQJE2M6Yzukrxo/ArBveYMoMfBF1nBjCnM+0CeRoyTx48pnctzffPY?=
 =?us-ascii?Q?dRrQ8TMDHjzEzQARmkgLtTNMBlHj3rpta28BZ4zWez+f1OGLeQUFMtoi7iJt?=
 =?us-ascii?Q?FEYazTtZzmyru7Spsx75PEHqVwz45bVK1Nx5qXq04RAMOLq+ZIJz+NPfmV74?=
 =?us-ascii?Q?W/yLjskGRsixpbk7hbCNt3ySzYzfmfO0iUgUmTapYr9Y2HBlIHPIRw9jAs5j?=
 =?us-ascii?Q?8ngXsjPd9ObG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f6c55c-df9f-4d8c-b251-08d8c7a1fa33
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 17:42:57.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYViI+c6CdK9qrlAFOAhqseN8rR66Cd0ExQlxoFwKB4mQnXAUygPV01XD2NCbQLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5215
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
0 (invalid) when cifs_revalidate_dentry() fails, except for ENOENT
where that error means the dentry is invalid.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Suggested-by: Shyam Prasad N <nspmangalore@gmail.com>
---
 fs/cifs/dir.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 68900f1629bff..868c0b7263ec0 100644
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
+			return rc =3D=3D -ENOENT ? 0 : rc;
+		}
 		else {
 			/*
 			 * If the inode wasn't known to be a dfs entry when
--=20
2.29.2

