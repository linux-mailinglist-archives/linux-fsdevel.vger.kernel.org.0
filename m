Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10245791E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbjIDUhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 16:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDUhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:37:09 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2124.outbound.protection.outlook.com [40.107.114.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3610DE;
        Mon,  4 Sep 2023 13:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOvSxnY15Cf+YSZxpvfCPYb+rESt6SoUFHtOo5VPlICIe6kyQxIl05vYAzkBTmx9nZmTd5/oAGmt0iTjoiZw6FJOEtVScYZELx9uEwTjfR/x+kOMeeIEamKxzT8rdagtJdX9YAJSHqt/KFBCfkOLN3Stxs0tUOwFV/bmn3BWXdlm2OMlzHQyvJsgPlM0/iqAMlOLnSH7hCx62aJq1TdK8wl3nTBJOjHLIqjFE2ucsez1the4CWzqUbr2odGdb8MYcnZVNfsPpmF/vbo6MYoh8QgattV/dYjO7egR6bvKjWeYS0a9Y6KHxL7G/e3r53vDA2FXitzPed/T5eqXM+GbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNiWWBbSWAqZeFV7l+fAFC1mh7DHPQzF1ZjBdg71NAw=;
 b=nxCCVlxU1+on9N0F/FtUUC7//0PjZa8KaLTxGI+o8IxqugTie0cO+iaGU9NHxqvDQUylnMMdTEJKE+nLt+WF/XB6F2Cu/n2N84dsZU3m57j1xJhw7m+Rnz8I3GaXg9jXj6I5cwvKTvZyz/dtyanigYImKL3XHH003GaNSTxP48qZBCMmPtIpv5js1fU/WIBqSb08KfSA/Psysb3iC6o2EFqI1DOHavJZJmZ0iQ+yw9qONX9oUVW5arOkK9W9xXqvpS5QDJRwvAoIP/RFNs1sRwePtukLiWCmX//iAkaAVRBYVURWBAMxehKiwx8FiQvZjIqpFg6YhzfE7KTq8mhILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNiWWBbSWAqZeFV7l+fAFC1mh7DHPQzF1ZjBdg71NAw=;
 b=l5nhsB7UfNnIUZxvh/ZBGbiaLxrHUfHaOcwLy3tPaRAMIBm4sgdVRzwgs3CZSBVE66WiS/Cp/FdhIEUWYOk3fBz+NK5derOmRQbhwewJ8/huB8DEaTFIoAeXKYyKeC3qkQu8OZL/xjAJ4b4VdzkLhP9l8N5a7anJ9GwRkPeoP9Q=
Received: from TYCPR01MB11847.jpnprd01.prod.outlook.com
 (2603:1096:400:37f::11) by TYCPR01MB11236.jpnprd01.prod.outlook.com
 (2603:1096:400:3be::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Mon, 4 Sep
 2023 20:36:54 +0000
Received: from TYCPR01MB11847.jpnprd01.prod.outlook.com
 ([fe80::df3b:cb67:4db:9177]) by TYCPR01MB11847.jpnprd01.prod.outlook.com
 ([fe80::df3b:cb67:4db:9177%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 20:36:54 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC:     "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "eggert@cs.ucla.edu" <eggert@cs.ucla.edu>,
        "bruno@clisp.org" <bruno@clisp.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs: don't call posix_acl_listxattr in generic_listxattr
Thread-Topic: [PATCH] fs: don't call posix_acl_listxattr in generic_listxattr
Thread-Index: AQHZh/SCGvwTtqeRBE2fddPxXgQKo7ALzBZA
Date:   Mon, 4 Sep 2023 20:36:54 +0000
Message-ID: <TYCPR01MB11847DEDE49FD02AD9F771971D9E9A@TYCPR01MB11847.jpnprd01.prod.outlook.com>
References: <20230516124655.82283-1-jlayton@kernel.org>
In-Reply-To: <20230516124655.82283-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11847:EE_|TYCPR01MB11236:EE_
x-ms-office365-filtering-correlation-id: aa56cfd8-1411-45da-09e5-08dbad86ad52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ubGL4Y6/yxHVoczjjiXgyXvQxhlKWY+waskohk2YlmBpJ3BQYlqG9FHPZJU4Uxwt++wB/50X9/4zl8zqgQbLh7/ran1FFejL20IZtO5EWGnj94BouwUx/NCCYu/jjvM9COXFhoEKS3/zYIqYvmlS3SrwxtO+5uART1N+QirhprQQMW0kyn0fzDXDlszOs8fpKTrNZJR+2AVbcVLL360ANOLQq+sugaVeDYvDHk9/tY9Dgy34L9c8GGvDHiBlsT9ePqLExQSzl/S1DUhJ6CKBDQUfsSveeHOaIoDYvSxAdqfjoFX9DQX7w//MyK2J3dxZ+ifoTQLbaGyo9L1guQu+eWKy+xfxQ3PCuvE7eDtsBIfgD3SXhzGwvwhbjBBamMOAl+uKpmX6Y0l4b0UWuXcJ1e6ztPbmYc+cbZAnZPltm7yd+w+B7Od4JJgMTs4P5W+BsH7jVZlDqWnMCtbkLH/MNkUQL8tzNGtl010PPipDk70BMANJe0XvnJw15fXCRG2+cIGW1Ng9NnY+hj8dvyOs7KhonIuacyyf8cQyW9WMX859MEtx+d5BEG5NE05h+BXQrllEaUwmT7l+niPlCk48rYFOUeMfEMhAazuIT3VD5MftZCsbWW40KAyPFKgWhxmPpIxxhs9NlZjoKwJNnlnIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11847.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(41300700001)(122000001)(38070700005)(38100700002)(71200400001)(86362001)(33656002)(478600001)(83380400001)(26005)(9686003)(53546011)(6506007)(7696005)(55016003)(66556008)(66946007)(76116006)(66446008)(54906003)(64756008)(2906002)(110136005)(316002)(66476007)(8936002)(8676002)(5660300002)(4326008)(52536014)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b4DLq6dd7mxCGb/hAoRNlbR/HmuBCuhGT6zdukpQsNrH2vaWLDxSRla7oXoA?=
 =?us-ascii?Q?6OeCDw48ExrQlsj6BSow/j0mhTU54aCLbwDEATqBsG4A5M9cOtiYYAWuMgbW?=
 =?us-ascii?Q?9vIhpl2LsKYSwd1t1oMiWUyBO6pWAeZanmZl/IiICfpHgCTVjXoFIg2rJxpZ?=
 =?us-ascii?Q?KNI9oI9vyepR23zsAbsoAisWORpbqqHYwoHm1UtNHB1kbYFNvA4TOrDDpsPQ?=
 =?us-ascii?Q?CP6PfwO+A/B+kF18tRcEnLnABSi/y+oyhfL2MCZe8XpbbDB1KPR/kVP5ZwmY?=
 =?us-ascii?Q?ip0D/hNwrPL7Qet0OXEw4/yqkwVstg5SxT4JW4uBfzk5eOh4XK5RpgL70RpU?=
 =?us-ascii?Q?6sLQVH48fD1DH9Zo25bz3AW+N11phIVllXivY8486DyFWia5Q3NPYMBzqkyH?=
 =?us-ascii?Q?JtrUqtct7N9+PbJ/UJnA4LLUBBaHs6a/xbSv56osA9ZN+AbPDctck8yCsYCX?=
 =?us-ascii?Q?+8rl3KlmUPQw9FXnCjpfKVA+88AVmjxdnq6pI/6HEZisy+Tm5uNiR1H8qUmE?=
 =?us-ascii?Q?ShT8vll7q40VBKROnuAJDusMHkxFOhXUxah49s/fCbR/ua+14VUq+spL4lOd?=
 =?us-ascii?Q?DtsNlu5qqFB1P/AkgvRidieCnzt7FYBZ8eLvWVS5EXtzhjsiKmSBTLfeJkxW?=
 =?us-ascii?Q?ETygMfNDhi7yyodtjy9Cyzh4BMiJG+mjX/mVrGCHigCV1Ia9nYDihCnsknJr?=
 =?us-ascii?Q?OPbH8fwLJ/BfLRmECd+l23RrzW+cSls59pSkxMZdbE1L11Ybtj1KtX+ASSZM?=
 =?us-ascii?Q?UAldKd2poHdhWMXu1oMM/NOJHxUhyxBGlP0zwBDPne0w2kfbWeF17/q+Q7y4?=
 =?us-ascii?Q?6+v0Vfaa+osaWurPJlHY3Im4aPPhg/B2dAFrQm9hVsfqJoD2TIDnqDe8ymSN?=
 =?us-ascii?Q?IMdDGVU8/yVTvjEi8bpAJRw/DfMvm72hoRWp5KDxBe5qDuwX2mYy3/ZzNCkM?=
 =?us-ascii?Q?b+5ND0eHHUnU6HFdPkZmvYWmxpy2HZwpQZdtByRT/y0b1mZDiZvcs7qqYxYC?=
 =?us-ascii?Q?nlTq0b6vVsLXzgpHHQz2eqo4QYHHr82S4y0HgmOsOiJF3usXkH+uJcZkGGuW?=
 =?us-ascii?Q?/BMkZ+jgmKYxw/jo0m4wffe1wtRQJydITk8JnfRbY5scjAyXXb3kWrgM3Hu6?=
 =?us-ascii?Q?UHMbs6gffKmpKaM4bhcUQK0Hs6QIDhQcznpDgsCM0D40b63KBTX0K6QleNwU?=
 =?us-ascii?Q?aXx8vv1TPNZ9vBDxvU/vzzd15UukTHOn/PsOR0bkgHdihQuthVc5k+E2iJDI?=
 =?us-ascii?Q?z0EaVJ/rPoIvqKKFpVx9LBZ5Z6FZa1CK8Pah3NpQJAeui3Gk1oLKEODyC95x?=
 =?us-ascii?Q?DJbgUp2uQ+jJ3aWTZ+cwS6mGmxh8P1yodwJMZsIz4hWzMx3DNyUhMRG7Qu2I?=
 =?us-ascii?Q?odTBc/jrBHrlKz1J6MK6QHOd3aS35G3m5dzFYSemQ24al5tUqJWG0F/ovDAT?=
 =?us-ascii?Q?BWgWXOoppLVAUoOdZaX602mF53Wv1/2BQSSzIRccDfFIZgX7+kz4D38N69hV?=
 =?us-ascii?Q?6whQVO5SLDH+qBXHmzLf0zukFmTGKshENuiTjZd2l3a79wLa77wo875DHtO9?=
 =?us-ascii?Q?1NQt0z2tMIr6eTHqkDTWP2GNeg05BxF2FMLcxVVs1A37+hgPrKNcJMMK/zY8?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11847.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa56cfd8-1411-45da-09e5-08dbad86ad52
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 20:36:54.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2Hs6xHyPQ0LkAN39AHGMDuN0wgklMHQsPtlSw80ORuY1XYXQFemazAXOyU8/uc1/qGofLkrfochfN3K4ubxpKfBnh5SA7Xikd1xDbMHryQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

I can confirm that with rawhide kernel 6.5 the error is gone, i.e.

Listxattr() shows only "system.nfs4_acl" attribute on NFSv4 filesystem,

Problem is, that (on the same kernel) getxattr(name,XATTR_NAME_POSIX_ACL_AC=
CESS, 0,0)
Sets errno to ENODATA where "name" is file on NFSv4.

This is different behavior to the previous versions, i.e. on RHEL8 getxattr=
() sets errno to ENOTSUP in the same scenario - which is what I'd expect mo=
re.

Is the change of the getxattr() behavior expected or not?

Thanks,
Ondrej

-----Original Message-----
From: Jeff Layton <jlayton@kernel.org>=20
Sent: Dienstag, 16. Mai 2023 14:47
To: Alexander Viro <viro@zeniv.linux.org.uk>; Christian Brauner <brauner@ke=
rnel.org>
Cc: trondmy@hammerspace.com; eggert@cs.ucla.edu; bruno@clisp.org; Ondrej Va=
lousek <ondrej.valousek.xm@renesas.com>; linux-fsdevel@vger.kernel.org; lin=
ux-kernel@vger.kernel.org
Subject: [PATCH] fs: don't call posix_acl_listxattr in generic_listxattr

Commit f2620f166e2a caused the kernel to start emitting POSIX ACL xattrs fo=
r NFSv4 inodes, which it doesn't support. The only other user of generic_li=
stxattr is HFS (classic) and it doesn't support POSIX ACLs either.

Fixes: f2620f166e2a xattr: simplify listxattr helpers
Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xattr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index fcf67d80d7f9..e7bbb7f57557 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -985,9 +985,16 @@ int xattr_list_one(char **buffer, ssize_t *remaining_s=
ize, const char *name)
 	return 0;
 }
=20
-/*
+/**
+ * generic_listxattr - run through a dentry's xattr list() operations
+ * @dentry: dentry to list the xattrs
+ * @buffer: result buffer
+ * @buffer_size: size of @buffer
+ *
  * Combine the results of the list() operation from every xattr_handler in=
 the
- * list.
+ * xattr_handler stack.
+ *
+ * Note that this will not include the entries for POSIX ACLs.
  */
 ssize_t
 generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)=
 @@ -996,10 +1003,6 @@ generic_listxattr(struct dentry *dentry, char *buffe=
r, size_t buffer_size)
 	ssize_t remaining_size =3D buffer_size;
 	int err =3D 0;
=20
-	err =3D posix_acl_listxattr(d_inode(dentry), &buffer, &remaining_size);
-	if (err)
-		return err;
-
 	for_each_xattr_handler(handlers, handler) {
 		if (!handler->name || (handler->list && !handler->list(dentry)))
 			continue;
--
2.40.1

