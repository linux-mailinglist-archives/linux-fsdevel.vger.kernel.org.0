Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C5A650492
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 20:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiLRT7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 14:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRT7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:59:42 -0500
Received: from ms11p00im-qufo17291301.me.com (ms11p00im-qufo17291301.me.com [17.58.38.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADE6256
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Dec 2022 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671393581;
        bh=0dBBuqoCd8U0+o6FyXAbsKR0f14ajtRcyhXIVK95Pu4=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=QZKLWX0ki2k5IG9FzR7f0csE9iFp2q0JhoxLYCp85k9lsZQ7l2FsXq5G+ZLULDrxP
         zK7AXnwQo8LcOHc36QqWjnw8WxOtQ/WrKBOOFhI1gXXpYl/5ngRUg8mOZ9zMzAfwmE
         4xWj64UGKQ2pY7Ve0Sqzh3zQL2pGna6oHPqUt8xk/ZbYoYLI1tWNop1K4KoCioJRFD
         i4JBDfiEIUBQw+D5VZsYFJn0DfpcxNIYhxgXVgJvihQqIfJN3OTklUNn0G2nqX1Qpa
         0kFB4Zz9IR1qB93eV/YbYWMP/OvyP+1BQ1dIDOAxw9EAlMMUpXvx83xvI57PE04tKo
         U7fTY9MWWFNGg==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291301.me.com (Postfix) with ESMTPSA id 8C3339405EC;
        Sun, 18 Dec 2022 19:59:40 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [V9fs-developer] [PATCH 2/6] Don't assume UID 0 attach
From:   evanhensbergen@icloud.com
In-Reply-To: <Y59uz0aeuoLMU9W8@codewreck.org>
Date:   Sun, 18 Dec 2022 13:59:29 -0600
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@gmail.com>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <B272E6A0-C349-4B23-BE6F-7CBA8D6C4B6B@icloud.com>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
 <20221217185210.1431478-3-evanhensbergen@icloud.com>
 <Y55Z2DwZgRG+9zW3@codewreck.org>
 <3343B7A9-2D1D-4A41-859E-B04AF90152FA@icloud.com>
 <864E1007-CBCF-40C7-B438-A76C3065AFC9@icloud.com>
 <Y59uz0aeuoLMU9W8@codewreck.org>
To:     asmadeus@codewreck.org
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Proofpoint-GUID: PBcmYKpuFmrQfzchqF5JpqRudNZCsgEl
X-Proofpoint-ORIG-GUID: PBcmYKpuFmrQfzchqF5JpqRudNZCsgEl
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180190
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can you send me your xfstest invocation formulas and I=E2=80=99ll add =
them to my regression tests.

Yeah, I was torn on this merge window or next - the more complicated =
patches here are really fixes for things that are kinda broken in the =
code =E2=80=94 so they might even be -rc candidate patches.  Most of =
them only effect cache mode, which isn=E2=80=99t default =E2=80=94 so =
its probably low-risk, but I know the preference is for things to have =
had longer in the review cycle to marinate.

The simple ones probably could go into this merge window, but I leave it =
up to you since you=E2=80=99ve been carrying the maintainer mantle =E2=80=94=
 and my PGP key and kernel.org repos need to be re-established in the =
web of trust, but mainly because you=E2=80=99re active maintainer here.

I=E2=80=99ll keep crunching and send out the new patch set by the end of =
the day regardless.

     -eric



> On Dec 18, 2022, at 1:49 PM, asmadeus@codewreck.org wrote:
>=20
> evanhensbergen@icloud.com wrote on Sun, Dec 18, 2022 at 10:32:57AM =
-0600:
>> Okay, reproduced the error you suspected on the patch.  It=E2=80=99s =
kind of a
>> pain because the code as is won=E2=80=99t work unless I=E2=80=99m =
running the file
>> server as root and changing all the servers to ignore requests seems
>> off.  It also occurred to me that having a root R/W write back could
>> be a security vulnerability.  I tried patching it with
>> dfltuid/dfltgid, but only root can override the modes so that =
doesn=E2=80=99t
>> work.
>>=20
>> Since I have the better write back fix testing okay, we could drop
>> this patch from the series and I could just focus on getting that
>> patch ready (which I should be able to do today).  It does seem to
>> work with the python test case you gave, so it doesn=E2=80=99t have =
the same
>> issues.
>>=20
>> Thoughts?
>=20
> That sounds good to me, thanks!
>=20
> I haven't had time to look at the other patches in detail but they =
look
> good to me in principle.
> I'll try to find time to run some xfstests this week to check for
> regressions with the other patches (I don't have any list, so run some
> before/after with qemu in cache=3Dmmap/loose modes perhaps?) and we =
can
> submit them next merge window unless you're in a hurry.
> Some are obvious fixes (not calling in fscache code in loose mode) and
> could get in faster but I don't think we should rush e.g. option
> parsing... Well that probably won't get much tests in -next, I'll =
leave
> that up to you.
>=20
> Do you (still?) have a branch that gets merged in linux-next, or shall =
I
> take the patches in for that, or do you want to ask Stefen?
> (I should probably just check myself, but it's 5am and I'll be lazy)
>=20
> --=20
> Dominique


