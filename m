Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2A751F43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 12:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjGMKsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 06:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjGMKsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1E0212B;
        Thu, 13 Jul 2023 03:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65EFE60C48;
        Thu, 13 Jul 2023 10:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FAC433C8;
        Thu, 13 Jul 2023 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689245286;
        bh=QvUa6kP3SwYohOiEpBZrVpgI94o/+CaPmrulrVPHsBM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iP4ERGVQ/0Zh0QREGUodN5yM0U52JQefE0rfnq15VltalV2jIrRJ8dMSO9M6PiEWd
         vWouEEu37ULk0o10UGGLSJchRMn2I+0kru4/DlTsO36SYrjkg69hN1m3+X4XT9SML2
         InKgTfj9+LNdLTpfQvaQw4r6CdA4cmvUeQdBgT81JeXFKEefGO18Ys2rD8iU40+Uaq
         zs5vW5hfxG49fGqusaRrFy3odCSk2pL+ZrxDFmnvBQf/5v6m7uHcsPfnfPcK2oomnw
         i+GYqo3p+qQAqOKW9b5N6/xWucZUTDLzH0a/GiscpRgvhyxI3O2zJw+EahkhOriF7Q
         tiHuKvz1/E0Gg==
Message-ID: <11bef51bf7fed6082f41a9ecde341b46c0c3e0ec.camel@kernel.org>
Subject: Re: [PATCH] ext4: fix decoding of raw_inode timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     brauner@kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Jul 2023 06:48:04 -0400
In-Reply-To: <20230712212557.GE3432379@mit.edu>
References: <20230712150251.163790-1-jlayton@kernel.org>
         <20230712175258.GB3677745@mit.edu>
         <4c29c4e8f88509b2f8e8c08197dba8cfeb07c045.camel@kernel.org>
         <20230712212557.GE3432379@mit.edu>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-07-12 at 17:25 -0400, Theodore Ts'o wrote:
> On Wed, Jul 12, 2023 at 02:09:59PM -0400, Jeff Layton wrote:
> >=20
> > No, I haven't. I'm running fstests on it now. Is there a quickstart for
> > running those tests?
>=20
> At the top level kernel sources:
>=20
> ./tools/testing/kunit/kunit.py  run --kunitconfig ./fs/ext4/.kunitconfig
>=20
> You should get:
>=20
> [17:23:09] Starting KUnit Kernel (1/1)...
> [17:23:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [17:23:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ext4_inode_test =
(1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [17:23:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D inode_test_xtimestamp_=
decoding  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [17:23:09] [PASSED] 1901-12-13 Lower bound of 32bit < 0 timestamp, no ext=
ra bits
> [17:23:09] [PASSED] 1969-12-31 Upper bound of 32bit < 0 timestamp, no ext=
ra bits
> [17:23:09] [PASSED] 1970-01-01 Lower bound of 32bit >=3D0 timestamp, no e=
xtra bits
> [17:23:09] [PASSED] 2038-01-19 Upper bound of 32bit >=3D0 timestamp, no e=
xtra bits
> [17:23:09] [PASSED] 2038-01-19 Lower bound of 32bit <0 timestamp, lo extr=
a sec bit on
> [17:23:09] [PASSED] 2106-02-07 Upper bound of 32bit <0 timestamp, lo extr=
a sec bit on
> [17:23:09] [PASSED] 2106-02-07 Lower bound of 32bit >=3D0 timestamp, lo e=
xtra sec bit on
> [17:23:09] [PASSED] 2174-02-25 Upper bound of 32bit >=3D0 timestamp, lo e=
xtra sec bit on
> [17:23:09] [PASSED] 2174-02-25 Lower bound of 32bit <0 timestamp, hi extr=
a sec bit on
> [17:23:09] [PASSED] 2242-03-16 Upper bound of 32bit <0 timestamp, hi extr=
a sec bit on
> [17:23:09] [PASSED] 2242-03-16 Lower bound of 32bit >=3D0 timestamp, hi e=
xtra sec bit on
> [17:23:09] [PASSED] 2310-04-04 Upper bound of 32bit >=3D0 timestamp, hi e=
xtra sec bit on
> [17:23:09] [PASSED] 2310-04-04 Upper bound of 32bit>=3D0 timestamp, hi ex=
tra sec bit 1. 1 ns
> [17:23:09] [PASSED] 2378-04-22 Lower bound of 32bit>=3D timestamp. Extra =
sec bits 1. Max ns
> [17:23:09] [PASSED] 2378-04-22 Lower bound of 32bit >=3D0 timestamp. All =
extra sec bits on
> [17:23:09] [PASSED] 2446-05-10 Upper bound of 32bit >=3D0 timestamp. All =
extra sec bits on
> [17:23:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] inode_test_xtimestamp_dec=
oding =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [17:23:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] e=
xt4_inode_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [17:23:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [17:23:09] Testing complete. Ran 16 tests: passed: 16
> [17:23:09] Elapsed time: 1.943s total, 0.001s configuring, 1.777s buildin=
g, 0.123s running
>=20
> 	   	   	 	       	      		   - Ted

Thanks Ted,

The above output is what I get with the fix in place. Without this
patch, I get:

$ make ARCH=3Dum O=3D.kunit --jobs=3D16
[06:46:35] Starting KUnit Kernel (1/1)...
[06:46:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[06:46:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ext4_inode_test (1=
 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[06:46:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D inode_test_xtimestamp_de=
coding  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[06:46:35]     # inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/e=
xt4/inode-test.c:252
[06:46:35]     Expected test_param->expected.tv_sec =3D=3D timestamp.tv_sec=
, but
[06:46:35]         test_param->expected.tv_sec =3D=3D -2147483648 (0xffffff=
ff80000000)
[06:46:35]         timestamp.tv_sec =3D=3D 2147483648 (0x80000000)
[06:46:35] 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits: ms=
b:1 lower_bound:1 extra_bits: 0
[06:46:35] [FAILED] 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra=
 bits
[06:46:35]     # inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/e=
xt4/inode-test.c:252
[06:46:35]     Expected test_param->expected.tv_sec =3D=3D timestamp.tv_sec=
, but
[06:46:35]         test_param->expected.tv_sec =3D=3D -1 (0xfffffffffffffff=
f)
[06:46:35]         timestamp.tv_sec =3D=3D 4294967295 (0xffffffff)
[06:46:35] 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits: ms=
b:1 lower_bound:0 extra_bits: 0
[06:46:35] [FAILED] 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra=
 bits
[06:46:35] [FAILED] 1970-01-01 Lower bound of 32bit >=3D0 timestamp, no ext=
ra bits
[06:46:35] [FAILED] 2038-01-19 Upper bound of 32bit >=3D0 timestamp, no ext=
ra bits
[06:46:35]     # inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/e=
xt4/inode-test.c:252
[06:46:35]     Expected test_param->expected.tv_sec =3D=3D timestamp.tv_sec=
, but
[06:46:35]         test_param->expected.tv_sec =3D=3D 2147483648 (0x8000000=
0)
[06:46:35]         timestamp.tv_sec =3D=3D 6442450944 (0x180000000)
[06:46:35] 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit o=
n: msb:1 lower_bound:1 extra_bits: 1
[06:46:35] [FAILED] 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra =
sec bit on
[06:46:35]     # inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/e=
xt4/inode-test.c:252
[06:46:35]     Expected test_param->expected.tv_sec =3D=3D timestamp.tv_sec=
, but
[06:46:35]         test_param->expected.tv_sec =3D=3D 4294967295 (0xfffffff=
f)
[06:46:35]         timestamp.tv_sec =3D=3D 8589934591 (0x1ffffffff)
[06:46:35] 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit o=
n: msb:1 lower_bound:0 extra_bits: 1
[06:46:35] [FAILED] 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra =
sec bit on
[06:46:35] [FAILED] 2106-02-07 Lower bound of 32bit >=3D0 timestamp, lo ext=
ra sec bit on
[06:46:35] [FAILED] 2174-02-25 Upper bound of 32bit >=3D0 timestamp, lo ext=
ra sec bit on
[06:46:35]     # inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/e=
xt4/inode-test.c:252
[06:46:35]     Expected test_param->expected.tv_sec =3D=3D timestamp.tv_sec=
, but
[06:46:35]         test_param->expected.tv_sec =3D=3D 6442450944 (0x1800000=
00)
[06:46:35]         timestamp.tv_sec =3D=3D 10737418240 (0x280000000)
[06:46:35] 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit o=
n: msb:1 lower_bound:1 extra_bits: 2
[06:46:35] [FAILED] 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra =
sec bit on
[06:46:35]     # inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/e=
xt4/inode-test.c:252
[06:46:35]     Expected test_param->expected.tv_sec =3D=3D timestamp.tv_sec=
, but
[06:46:35]         test_param->expected.tv_sec =3D=3D 8589934591 (0x1ffffff=
ff)
[06:46:35]         timestamp.tv_sec =3D=3D 12884901887 (0x2ffffffff)
[06:46:35] 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit o=
n: msb:1 lower_bound:0 extra_bits: 2
[06:46:35] [FAILED] 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra =
sec bit on
[06:46:35] [FAILED] 2242-03-16 Lower bound of 32bit >=3D0 timestamp, hi ext=
ra sec bit on
[06:46:35] [FAILED] 2310-04-04 Upper bound of 32bit >=3D0 timestamp, hi ext=
ra sec bit on
[06:46:35] [FAILED] 2310-04-04 Upper bound of 32bit>=3D0 timestamp, hi extr=
a sec bit 1. 1 ns
[06:46:35] [FAILED] 2378-04-22 Lower bound of 32bit>=3D timestamp. Extra se=
c bits 1. Max ns
[06:46:35] [FAILED] 2378-04-22 Lower bound of 32bit >=3D0 timestamp. All ex=
tra sec bits on
[06:46:35] [FAILED] 2446-05-10 Upper bound of 32bit >=3D0 timestamp. All ex=
tra sec bits on
[06:46:35] # inode_test_xtimestamp_decoding: pass:0 fail:16 skip:0 total:16
[06:46:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] inode_test_xtimestamp_decod=
ing =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[06:46:35] # Totals: pass:0 fail:16 skip:0 total:16
[06:46:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] ext=
4_inode_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[06:46:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[06:46:35] Testing complete. Ran 16 tests: failed: 16
[06:46:35] Elapsed time: 14.549s total, 0.002s configuring, 14.229s buildin=
g, 0.275s running


Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
