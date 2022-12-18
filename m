Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6C64FD56
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 02:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLRBFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 20:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLRBFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 20:05:53 -0500
Received: from ms11p00im-qufo17291401.me.com (ms11p00im-qufo17291401.me.com [17.58.38.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF12625
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Dec 2022 17:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671325551;
        bh=CU/eyyyK8TwQFiwwwOIA2tQ1Rpw9x9qntSrQp9qm0zw=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=vyW+mMByV2K4utfBidJJ/C1eVF7GzBMiDuRsZlGolhKrlKloqwKaECoHwLZp9IwG7
         hXHJdbgWDh6An2PRbYYiuBkjxgVn0XEx7qy6dgIq8ylT6ChJSviYgqsZUS/u0l/0hE
         iOuBh4B0nnVIndP5gNeSey5ATRMFtWsAZH/fNKOJQv0ZKNCS8kvyTVYFh/QjmmAa9h
         lOK/Q3m0sYsNzYd3c1rOh0HQkUAsKLOT5fZBDR2NKLlfR61Ikj+PY5MtVx2E3mlTxr
         3LYQ5eFYCpcjo5LV+81LPXwN5lAIjOCJIGOKSn+P4YC0O9vU9zxs3LbJIgAMVOaTjT
         ddu3Vs/guNyjQ==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291401.me.com (Postfix) with ESMTPSA id 2E9498E053F;
        Sun, 18 Dec 2022 01:05:50 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH 2/6] Don't assume UID 0 attach
From:   evanhensbergen@icloud.com
In-Reply-To: <Y55Z2DwZgRG+9zW3@codewreck.org>
Date:   Sat, 17 Dec 2022 19:05:38 -0600
Cc:     v9fs-developer@lists.sourceforge.net,
        Ron Minnich <rminnich@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3343B7A9-2D1D-4A41-859E-B04AF90152FA@icloud.com>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
 <20221217185210.1431478-3-evanhensbergen@icloud.com>
 <Y55Z2DwZgRG+9zW3@codewreck.org>
To:     asmadeus@codewreck.org
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Proofpoint-GUID: OA9RlOlds9TOEa1ab8ML_c9csJM0hqAT
X-Proofpoint-ORIG-GUID: OA9RlOlds9TOEa1ab8ML_c9csJM0hqAT
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxlogscore=615 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180009
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 17, 2022, at 6:07 PM, asmadeus@codewreck.org wrote:
>=20
> Eric Van Hensbergen wrote on Sat, Dec 17, 2022 at 06:52:06PM +0000:
>> The writeback_fid fallback code assumes a root uid fallback which
>> breaks many server configurations (which don't run as root).  This
>> patch switches to generic lookup which will follow argument
>> guidence on access modes and default ids to use on failure.
>=20
> Unfortunately this one will break writes to a file created as 400 I
> think
> That's the main reason we have this writeback fid afaik -- there are
> cases where the user should be able to write to the file, but a plain
> open/write won't work... I can't think of anything else than open 400
> right now though
>=20

I=E2=80=99ll try and craft a test case for this, but I think it works?
That being said, I haven=E2=80=99t been trying the xfstests, just fsx =
and bench.

> I'm sure there's an xfs_io command and xfstest for that, but for now:
> python3 -c 'import os; f =3D os.open("testfile", os.O_CREAT + =
os.O_RDWR, 0o400); os.write(f, b"ok\n")'
>=20
> iirc ganesha running as non-root just ignores root requests and opens =
as
> current user-- this won't work for this particular case, but might be
> good enough for you... With that said:

Yeah, the real problem I ran into this was if the server is running as =
non-root this causes issues and I was testing against cpu (which =
doesn=E2=80=99t run as root).  I need to go back and check, but if you =
are running as root and dftuid=3D0 then the behavior should be the same =
as before?
In any case, I=E2=80=99ll try to go back and make this work =E2=80=94 my =
big issue was always using uid 0 regardless of what mount options said =
is Wong.

>=20
>> There is a deeper underlying problem with writeback_fids in that
>> this fallback is too standard and not an exception due to the way
>> writeback mode works in the current implementation.  Subsequent
>> patches will try to associate writeback fids from the original user
>> either by flushing on close or by holding onto fid until writeback
>> completes.
>=20
> If we can address this problem though I agree we should stop using
> wrieback fids as much as we do.
> Now fids are refcounted, I think we could just use the normal fid as
> writeback fid (getting a ref), and the regular close will not clunk it
> so delayed IOs will pass.
>=20
> Worth a try?

Yeah, that (using regular fids) is exactly what I am doing in my write =
back-fix patch which isn=E2=80=99t part of this series.  I was still =
hunting a few bugs, but I think I nailed them today.  I have to do a =
more extensive test sweep of the different configs, but unit tests seem =
good to go now so if I end up reworking the patch set to address your =
comment above, I may just go ahead and add it to the resubmit set.  =
However, I also go ahead and flush on close/clunk =E2=80=94 and that =
gets rid of the delayed write back which I think is actually preferable =
anyways.  I may re-introduce it with temporal caching, but its just so =
problematic=E2=80=A6..

         -Eric


