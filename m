Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF4E65048B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 20:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiLRTxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 14:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiLRTxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:53:16 -0500
Received: from ms11p00im-qufo17291401.me.com (ms11p00im-qufo17291401.me.com [17.58.38.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D41FDE8
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Dec 2022 11:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671393193;
        bh=WBYzTifmHshHLbzV2OaE8+BkNgSKGYp9RT7BG1PKOmE=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=wPyWipnumGLH0TdfZyv2p+GlV/DMHWIbnPcYEusmayf/RcwciuK1qjzO9NCTFMzIt
         k5Hy/vDDOdNH0/P/ffYQ0M4l7M7SWcDt4Z50bjts4IlITijKmwePhkuhB/Un9DqNJi
         6cbRGAT+9CiHwbjEkH+Fl0L1nVWXDpJsWRPPC8yAiiOhus558rL2HuW3+5b+gWurXO
         gjQLd5boX+H4vgVesRve2CeF/F4a9Qv5LMLQfrP/uK2S0hWZdy14SlCyDlFwwF1n5X
         NfGkHBFuwvXZ5EhuvUDPiaVL+IYnVq5iwWsXn29E7/aIeFh//eD7kGfNIONLPWOhLw
         5QCBDWtk+TsTg==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291401.me.com (Postfix) with ESMTPSA id D5C998E041F;
        Sun, 18 Dec 2022 19:53:12 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH 1/6] Adjust maximum MSIZE to account for p9 header
From:   evanhensbergen@icloud.com
In-Reply-To: <Y59uIwoECw0yHhf1@codewreck.org>
Date:   Sun, 18 Dec 2022 13:52:55 -0600
Cc:     Ron Minnich <rminnich@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D65A826-F163-4200-8997-5DE6E79223B5@icloud.com>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
 <20221217185210.1431478-2-evanhensbergen@icloud.com>
 <4530979.Ltmge6kleC@silver>
 <CAFkjPTmoQvzaSsSOAgM9_0+knudWsdi8=TnMOTXZj05hT6tneQ@mail.gmail.com>
 <51FD8D16-4070-4DCF-AEB5-11640A82762E@icloud.com>
 <CAP6exY+BF+1fjjUKX20vvbTZXiZ2gxUN3zc8+ZaHTY-aX6fRFQ@mail.gmail.com>
 <Y59uIwoECw0yHhf1@codewreck.org>
To:     asmadeus@codewreck.org
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Proofpoint-GUID: nZflBMZZIeodgn3tfr4Yyy-5igF09afa
X-Proofpoint-ORIG-GUID: nZflBMZZIeodgn3tfr4Yyy-5igF09afa
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oh crap - I=E2=80=99m such an idiot - yeah IOHDRSZ was what I meant to =
use in the first place.  Although I am left wondering why IOHDRSZ is 24 =
- It does seem to be one extra byte, but I won=E2=80=99t begrudge lucho =
for going for an even number.

I=E2=80=99ll fix this up before re-releasing the patchset.  I=E2=80=99m =
just finishing breaking up my write back fixes to make them a bit more =
consumable as a patch.

          -eric



> On Dec 18, 2022, at 1:46 PM, asmadeus@codewreck.org wrote:
>=20
> ron minnich wrote on Sun, Dec 18, 2022 at 08:50:18AM -0800:
>> it's fine. tbh, I doubt the fact that you were fetching 31 vs 32 =
pages
>> mattered as much as the fact that you weren't fetching *4k at a time* =
:-)
>=20
> Yes, I think we can just blanket this as +4k and it wouldn't change
> much; I've been using 1MB+4k for rdma in previous tests...
>=20
> We still aren't doing things 4k at a time with this though, I'd =
suggest
> rounding down the rsize > msize check in p9_client_read_once():
>=20
>        if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
>                rsize =3D clnt->msize - P9_IOHDRSZ;
>=20
> to something that's better aligned; for some reason I thought we had
> that already.  . . but thinking again the sizes are probably driven by
> the cache and will be 4k multiples already?
>=20
>>> -#define DEFAULT_MSIZE (128 * 1024)
>>> +/* DEFAULT MSIZE =3D 32 pages worth of payload + P9_HDRSZ +
>>> + * room for write (16 extra) or read (11 extra) operands.
>>> + */
>>> +
>>> +#define DEFAULT_MSIZE ((128 * 1024) + P9_HDRSZ + 16)
>=20
> There's P9_IOHDRSZ for that ;)
>=20
> But I guess with the comment it doesn't matter much either way.
>=20
> --=20
> Dominique

