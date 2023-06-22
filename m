Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A09773A7F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 20:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFVSKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 14:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVSKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:10:33 -0400
X-Greylist: delayed 1203 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 11:10:32 PDT
Received: from mta-102a.earthlink-vadesecure.net (mta-102a.earthlink-vadesecure.net [51.81.61.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E831FED;
        Thu, 22 Jun 2023 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; bh=f7xXfWZM+MImUrtRNOoXYVPJtna4w7j0w+27iz
 otiB0=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1687455275;
 x=1688060075; b=UVKoTQ9UlsU2ArvOLqN4BbwzMiANvmZIWLwq7xM9iF/Dk2pvkXQ9Qdu
 DYm4oacA5i1909lqw1FSY7rJPTYIiwwPDjVbGCjhggz3GJPSTOtTtI9qSfd6ux86mem4z9W
 epSwD+Ni4YK7tBRlFWZ8TzP6GoAVrQ1subcJFL0FDL9HS605MgzYUH153QK1KuuTMMRDD5Z
 AsvwdAMRkYSYoUqM39+URIKeHzaPjWe5sfMcRwTHP6vOC0lHW+Sy2GHr3NQR3neKhKMWLEe
 tEX1fTmw6iwGlCuUNKfpMP/IVZsco828De8ilCiczilAklUFL6xYNyhnxTwpY7wwTsfsdSV
 O+A==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id cef2d9db-176b0ba1903c281b; Thu, 22 Jun 2023 17:34:34 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Chuck Lever III'" <chuck.lever@oracle.com>,
        "'stsp'" <stsp2@yandex.ru>
Cc:     "'Jeff Layton'" <jlayton@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Al Viro'" <viro@zeniv.linux.org.uk>,
        "'Christian Brauner'" <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, "'Shuah Khan'" <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-api@vger.kernel.org>
References: <20230621152214.2720319-1-stsp2@yandex.ru> <20230621152214.2720319-3-stsp2@yandex.ru> <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org> <7bbb29d2-4cae-48bd-1b97-9f4dbf6ffb19@yandex.ru> <8F45F47C-86C0-472E-B701-001A4FF90DBC@oracle.com> <26a798ae-b93b-2f68-71ed-35950240927d@yandex.ru> <187C3E49-A977-492E-99CB-97F032B24E5F@oracle.com>
In-Reply-To: <187C3E49-A977-492E-99CB-97F032B24E5F@oracle.com>
Subject: RE: [PATCH 2/2] selftests: add OFD lock tests
Date:   Thu, 22 Jun 2023 10:34:33 -0700
Message-ID: <0a2001d9a52f$cfd24450$6f76ccf0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQFRuQ0uoMlieQo9bLavrmguyfHQFQJxeCDcAuSmYXMCWoer6wFUNlsYArCPQ1cBeWn8P7A9dY2w
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > On Jun 22, 2023, at 1:05 PM, stsp <stsp2@yandex.ru> wrote:
> >
> >
> > 22.06.2023 21:58, Chuck Lever III =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> IMO that's not a reason not to do this properly.
> >>
> >> You should work with Jeff and the maintainer of xfstests to make it
> >> happen.
> > But its not going to be in this patch-set anyway, as its a different
> > source tree...
>=20
> If others agree with me, then please drop the selftests patch from =
this series.
> There is a considerably higher probability that the new test will be =
run frequently
> by CI if it's in xfstests.
>=20
>=20
> > So I should prepare it when this is merged, or?
>=20
> I don't have a strong preference. A good choice is to push the test =
before the
> kernel changes are merged.

As an aside, an additional testing option for OFD locks is the multilock =
test tool that is in the nfs-ganesha project. In preparation to use OFD =
locks in Ganesha, I added them to multilock to check them out, and that =
incidentally also allows testing how the NFS client and server work when =
OFD locks are taken on a file from an NFS mount.

Frank


