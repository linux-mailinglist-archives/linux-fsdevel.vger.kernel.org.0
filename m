Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26B97924DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjIEQAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354435AbjIELhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:37:00 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2094.outbound.protection.outlook.com [40.107.113.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338B1AB;
        Tue,  5 Sep 2023 04:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0rRDNYdjZLvbglAVNNB19XNqBMTzpuZdCIdlWu7l7ShblK82NFMNxv1rdY3CUUdVwyi4nwke/g4WzRjIhZkcxfXHPy0n4BQTFqb6/f+KV8IaL4c3fRqM8Iw8Wg1AJ261qlTl+fiI8ONaBjivDsJisRIFmVLBZCoOlizv3NRHuROA7/GOljz6ydNoCudDDr9OIeMZFckEedKG0m3lSMkJ33E5u74H6TFKBRPXvZNOgxJmDNhVSI9h0td/+ZzdJnt8T1IvyOEVt8MFMRS3hl72+HS32MOEIVIulJgZV852Sn+tA/PAq2H5Cepxw090zdhXNINDAYjqpjq45JM2TiklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9oRBKQFwHJCr/fz05pD/xlnHb/J7BOa5VQ9jcMawMw=;
 b=bdk922cWYLbhCQjsyXM2OWt6O/pCz/hO/Pq/MEJwkH71rXtV1I84UvbnPvTsAyEIe1Enw+6eyafxmIKdQ7g6LaxlarpDWm9fxYovoOVp0P4ihfjbkP0847W2EcOAsYhtgfcCk2wck3B4wKrgCRuxImf00+QLTYJQJZi/nfnzxfcmzJ2zMNytTptxyvVlITfqtNh8lWnL6/yaK76Nq4G7jHLUkZEX74aI1TAwyrKqCvVDle95l+NZPpNHLxbu3k3TcYZg5aYNRQU0dp1dGV1oPM+NHyMj+c0PAnBi5ReWlBwny8cBVfsvZlL1QVLFaCPwx2tQbLfSLwklZzFS9kxLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9oRBKQFwHJCr/fz05pD/xlnHb/J7BOa5VQ9jcMawMw=;
 b=O9jwlSQubi7wsXvZQtwQy4jnO/CXHPkqhzxygkJv0BWzPNYgfrZxx7gpZPSjnpKBU1YsTxF2c6SDslxxp+CnQuMDNIE4nfyVJFSbrHmsr9zMmLO1PRRDcuj/Fo48aRhrn9Zylx5y0euJVAsXgut5XSaQNK94mhx3eiEXmXw2EY4=
Received: from TYCPR01MB11847.jpnprd01.prod.outlook.com
 (2603:1096:400:37f::11) by TYCPR01MB10605.jpnprd01.prod.outlook.com
 (2603:1096:400:300::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:36:51 +0000
Received: from TYCPR01MB11847.jpnprd01.prod.outlook.com
 ([fe80::df3b:cb67:4db:9177]) by TYCPR01MB11847.jpnprd01.prod.outlook.com
 ([fe80::df3b:cb67:4db:9177%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 11:36:51 +0000
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
Thread-Index: AQHZh/SCGvwTtqeRBE2fddPxXgQKo7ALzBZAgADxqoCAAAy8IA==
Date:   Tue, 5 Sep 2023 11:36:51 +0000
Message-ID: <TYCPR01MB11847B943B5055CFBD67E5F54D9E8A@TYCPR01MB11847.jpnprd01.prod.outlook.com>
References: <20230516124655.82283-1-jlayton@kernel.org>
         <TYCPR01MB11847DEDE49FD02AD9F771971D9E9A@TYCPR01MB11847.jpnprd01.prod.outlook.com>
 <72b43294c85fb7dee01d976da606c5b792c5b430.camel@kernel.org>
In-Reply-To: <72b43294c85fb7dee01d976da606c5b792c5b430.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11847:EE_|TYCPR01MB10605:EE_
x-ms-office365-filtering-correlation-id: fddc053f-2822-4834-5c92-08dbae0465fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CEzQU4VYFimZ/hPN2PDkOPeoiYxO1d8Z1P+2BAepoJ1V2d10ITuXw4TjYqG4pSIxU4m3/pdVZsdNshZqn8KXmoIus0y1zTILlgJZYoSNOzFGplQQ6dZ9Z1nxp4gaKQpETROfowBrPJlUmScBxerXB8lgrV+sApCADYB42oqCojX3GkN3R32cPZQ/ocPI5/3m8SjuasqcY1nIOszqjdtcpddnXNdcOZzQ1vQYqiNN9qOX77viIY5EnGDPIZ6b4cvIEtUk7cFxSpIXN1yMhBRIGfvzsNNEUHcxinvUi5ZdxpdGSgloZGOoReHRgPvwX6P3T2PFInuuvksfcvUuZ8yEcwoC5gx8Ez1oB4Udn+80Tzo8V18+nlMj4VNABgsyVkwRwXrzmO9grG3mAtoTZ7u95tNdgXkGrsiQXOdQfcQRB3oPDsh5Qh4q1ZKXJT0vb00NhaFEuzIycC395zw47ENLBZy/V12Oq6NbkREqquZcA2zetu7S003+mK9lwuNUsP8EogU8jfsDW6DK35EsDRiyWpX5+zDsgNumq8N6HbLwUpF8rt5ZF0n00jHg52c4XUybHtnVXiIht37IPuFJHLosS9gc//+QhQD0WyF29FPhrTOC0rn72sWMTvMV0Mac9rfJgJSEO21zK3rjiPQqs99ugSqJyxeT6YENGW1RirBGfB0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11847.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(5660300002)(8676002)(110136005)(316002)(54906003)(64756008)(2906002)(66446008)(66476007)(66946007)(76116006)(66556008)(8936002)(52536014)(4326008)(41300700001)(6506007)(7696005)(55016003)(26005)(9686003)(53546011)(38070700005)(45080400002)(122000001)(71200400001)(38100700002)(478600001)(33656002)(966005)(83380400001)(86362001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?brue50CEuEE0Ojre6yIuzEWtAGN3hTm8jD82UcTtTRlt5r/WvKvayEIPHg/s?=
 =?us-ascii?Q?TkPXaeKMSD1eVBjxhXVf+UH3rUl0wJ+yHqtN13KIY2mYgbvp44wHIgKH7/LY?=
 =?us-ascii?Q?k/JthD2RA479AuhyVRA2VCcdduwK8GkASrtaa98te8YASiVwZ7bm8lNL76gi?=
 =?us-ascii?Q?8+7deKsbojoHADgAAQTLVHv7qggPPWXSQNyKwQKvOxTcTp4t6VpQ6XI4a/BG?=
 =?us-ascii?Q?LrLlWvJYiEJZW7Jgp9Ope0HavSbr3wkFaeykP9BG2+7DDDbeSjNniTcN5Y/U?=
 =?us-ascii?Q?uehVKD4dt0UVUfUlBFLr+0luwRoBe5y7Pnf7ccYRYo1G/NscX6kXLszo1TJP?=
 =?us-ascii?Q?K4FnXywGrQTjrCC/Al5VJvGrsG8g+QzIlY5pLYMh9YmS5FD7GnSBqkdXtjVM?=
 =?us-ascii?Q?UZbWmOC1Dw3bYyjNRUJh61uH5nYJq2OslIkJtUwyKEIac+OItHFbT6YC7aQ1?=
 =?us-ascii?Q?sCy9Y0Xp82NcKNjejG+vtrMRUjm1RMlYKCLhgvLU3vafBGPYhmpT6AQZCt48?=
 =?us-ascii?Q?xwDf4STQjh0R8rKk+GEiRqExlJl0FU9oCfvG3GYh+XVk0TpV2NsqPBBZNV+t?=
 =?us-ascii?Q?wgToXn2NCSNlkdRhv6iBgXIipv90f9GX/5+U4UwephfExbDk6HlIk/MT3mHm?=
 =?us-ascii?Q?1v3xSto33MIAgxMWnRT3FMaFqfmE+oqILQ7GnjROOUoenUlI+zjdi4KPNx9S?=
 =?us-ascii?Q?U7h72SHoDOXHNIFonkGX0/cGDZkIAoYAJM3hJ9dZpc/n+DCExhesq+gAzKEH?=
 =?us-ascii?Q?OGMRyw+Fwm7yiETbKNOIoMAsUZu8+3o+/d5y3M6tA9zslomEEfOfcLI/9fDZ?=
 =?us-ascii?Q?zicq1ZNGTl1rbO19kwO0gN1TgMWkpIx5FIniXhLa4v1DPeLC/1TT7VE/czIC?=
 =?us-ascii?Q?b5lM2m4IfLNCTLSnW0BbLE89Gp/gauP3xFTgHHF96ZNXeQW6F3n/lKUYSFO3?=
 =?us-ascii?Q?iZlHtjThMpELGdKEWyJdeOEcoqcFSJP7+VypeZYuHfBzvZ8Svs3KSNtrhvAg?=
 =?us-ascii?Q?Ioqtz42Xjn/Tf4GuhBu40+nsSvNnxINwVEDW/6fyp60i0Lh13mg9znmqB11O?=
 =?us-ascii?Q?PCahmRXcFdwdTe2Gb928E8km3Q8nd9DYtXdRiWycWY0HOr+hjkGxWGA+N2tn?=
 =?us-ascii?Q?SpOzleV1ECKToBjHnDF8ti9eDeiDyf2qWB3YTSACaEFoXXJJ2HRWczcMTO8q?=
 =?us-ascii?Q?4PJ9hfl3wYn1SoZc5HtBrvogG/o9lhEO+b8rHe9xgM/U5WRV8C2LaQOoxldg?=
 =?us-ascii?Q?LG//deAhW7lsy2+2OMn0GVistgRKcwxpkG/1AfqizYOt64ZRmmqncsO49ZOY?=
 =?us-ascii?Q?dfYazFjkPlQPLrA3Ai2J4nV5M2K+6x7n0xqN2d4OOCGLzzYU1paRHCV7jZMH?=
 =?us-ascii?Q?wGHSijj+CMHNB15JzP9l5E1dCDT/06ZFMr09QPtQUJgVySDkhCivYIEqyo4G?=
 =?us-ascii?Q?5HBRsuscgeDh51ZJrH/+NF562JJDxvglu4s5LbBe4/hL0XulirUnNQYWrBAK?=
 =?us-ascii?Q?t11941+aB6vDEcFkqwQ9K6WYBPDY38CnUM/lRZx7XAY+zoqBVzJxktJCcAR/?=
 =?us-ascii?Q?DJ+TzvipwYrNXYR05tj4RKyNn/uDTjIGhEGLS4f3G3n9FBULABmgZLUT2WrJ?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11847.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddc053f-2822-4834-5c92-08dbae0465fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 11:36:51.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQTqyqYGNZKUHGuB3OTUGEgvJN8Iyrra/hCk36+qVDbEB5wkr2hgx79IIjP7mY6SEx9yetXsPdX1KVJUQ6VwE30DsPv3XXLYXGXFgSavUWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ok, filed BZ for it, will see:
https://bugzilla.redhat.com/show_bug.cgi?id=3D2237410

-----Original Message-----
From: Jeff Layton <jlayton@kernel.org>
Sent: Dienstag, 5. September 2023 12:51
To: Ondrej Valousek <ondrej.valousek.xm@renesas.com>; Alexander Viro <viro@=
zeniv.linux.org.uk>; Christian Brauner <brauner@kernel.org>
Cc: trondmy@hammerspace.com; eggert@cs.ucla.edu; bruno@clisp.org; linux-fsd=
evel@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: don't call posix_acl_listxattr in generic_listxatt=
r

On Mon, 2023-09-04 at 20:36 +0000, Ondrej Valousek wrote:
> Hi Jeff,
>
> I can confirm that with rawhide kernel 6.5 the error is gone, i.e.
>
> Listxattr() shows only "system.nfs4_acl" attribute on NFSv4
> filesystem,
>
> Problem is, that (on the same kernel)
> getxattr(name,XATTR_NAME_POSIX_ACL_ACCESS, 0,0) Sets errno to ENODATA whe=
re "name" is file on NFSv4.
>
> This is different behavior to the previous versions, i.e. on RHEL8 getxat=
tr() sets errno to ENOTSUP in the same scenario - which is what I'd expect =
more.
>
> Is the change of the getxattr() behavior expected or not?
>
> Thanks,
> Ondrej
>

I'd say not. I've been working through xfstests failures on NFS and didn't =
realize that this was a regression, and posted this fstests patch
recently:

    https://lore.kernel.org/fstests/20230830-fixes-v4-1-88d7b8572aa3@kernel=
.org/

It would be nice if getxattr were also fixed here.

Cheers,
Jeff

> -----Original Message-----
> From: Jeff Layton <jlayton@kernel.org>
> Sent: Dienstag, 16. Mai 2023 14:47
> To: Alexander Viro <viro@zeniv.linux.org.uk>; Christian Brauner
> <brauner@kernel.org>
> Cc: trondmy@hammerspace.com; eggert@cs.ucla.edu; bruno@clisp.org;
> Ondrej Valousek <ondrej.valousek.xm@renesas.com>;
> linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] fs: don't call posix_acl_listxattr in
> generic_listxattr
>
> Commit f2620f166e2a caused the kernel to start emitting POSIX ACL xattrs =
for NFSv4 inodes, which it doesn't support. The only other user of generic_=
listxattr is HFS (classic) and it doesn't support POSIX ACLs either.
>
> Fixes: f2620f166e2a xattr: simplify listxattr helpers
> Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xattr.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index fcf67d80d7f9..e7bbb7f57557 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -985,9 +985,16 @@ int xattr_list_one(char **buffer, ssize_t *remaining=
_size, const char *name)
>       return 0;
>  }
>
> -/*
> +/**
> + * generic_listxattr - run through a dentry's xattr list() operations
> + * @dentry: dentry to list the xattrs
> + * @buffer: result buffer
> + * @buffer_size: size of @buffer
> + *
>   * Combine the results of the list() operation from every
> xattr_handler in the
> - * list.
> + * xattr_handler stack.
> + *
> + * Note that this will not include the entries for POSIX ACLs.
>   */
>  ssize_t
>  generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_siz=
e) @@ -996,10 +1003,6 @@ generic_listxattr(struct dentry *dentry, char *buf=
fer, size_t buffer_size)
>       ssize_t remaining_size =3D buffer_size;
>       int err =3D 0;
>
> -     err =3D posix_acl_listxattr(d_inode(dentry), &buffer, &remaining_si=
ze);
> -     if (err)
> -             return err;
> -
>       for_each_xattr_handler(handlers, handler) {
>               if (!handler->name || (handler->list && !handler->list(dent=
ry)))
>                       continue;
> --
> 2.40.1
>

--
Jeff Layton <jlayton@kernel.org>
