Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AA77BAF72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 02:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjJFAE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 20:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJFAEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:04:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0399F;
        Thu,  5 Oct 2023 17:04:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C00C433C7;
        Fri,  6 Oct 2023 00:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696550663;
        bh=jNRpRQ7anZvbWj7vKpq9mEWAlqO+Yk+hyZvPIkYO+ag=;
        h=Date:From:To:Cc:Subject:From;
        b=j5y8PkDvEXUIbnEAbGwNvHAX0jLjFIDRl/jwTRgZ4MU12y6+VK5PJRQF96SVIrHN9
         HncHGIjkkH0+XksCFNusFryrm/gmUtJ6aouvTRR7jKpHVA5vS79N57HmmARXDLnibp
         2DsKuMLeKdHgktl9gLkq3BotMGITcuwoxwA8GMZJ9u6VG14mVrmhiBho/QbUAlGbdu
         O8tZPWALmL2nNTqPUoVkD0v5FhL3NgMJDMRSJynkeAQbOpcaXGtcEw0adyasCiySs6
         zgat0rpuFIsjXlMq4h3ezz7UN8V1FmuietEYek0JOUWyYajHjtXm4fiwmcsSy5WsNS
         e+MYJjRWpSK+w==
Date:   Fri, 6 Oct 2023 01:04:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Test failure from "file: convert to SLAB_TYPESAFE_BY_RCU"
Message-ID: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f4w7RcmGnW7dyD3d"
Content-Disposition: inline
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--f4w7RcmGnW7dyD3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For the past few days (I was away last week...) the fd-003-kthread.c
test from the proc kselftests has been failing on arm64, this is an
nfsroot system if that makes any odds.  The test output itself is:

  # selftests: proc: fd-003-kthread
  # fd-003-kthread: fd-003-kthread.c:113: test_readdir: Assertion `!de' failed.
  # Aborted
  not ok 3 selftests: proc: fd-003-kthread # exit=134

I ran a bisect which pointed at the commit

   d089d9d056c048303aedd40a7f3f26593ebd040c file: convert to SLAB_TYPESAFE_BY_RCU

(I can't seem to find that on lore.) I've not done any further analysis
of what the commit is doing or anything, though it does look like the
bisect ran fairly smoothly and it looks at least plausibly related to
the issue and reverting the commit on top of -next causes the test to
start passing again.

The bisect log is below and a full log from a failing test job can be
seen here:

   https://lava.sirena.org.uk/scheduler/job/154334

Thanks,
Mark

git bisect start
# bad: [7d730f1bf6f39ece2d9f3ae682f12e5b593d534d] Add linux-next specific files for 20231005
git bisect bad 7d730f1bf6f39ece2d9f3ae682f12e5b593d534d
# good: [4d6ee1bd3e3820b523d43349cbcae230fdfcb613] Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
git bisect good 4d6ee1bd3e3820b523d43349cbcae230fdfcb613
# bad: [d6dfa62947bd47317de464c3ca55a6eaafe2e5af] Merge branch 'master' of git://linuxtv.org/media_tree.git
git bisect bad d6dfa62947bd47317de464c3ca55a6eaafe2e5af
# good: [73773d2fdd7172955a4476e8956c34aa49959219] bcachefs: Data update path no longer leaves cached replicas
git bisect good 73773d2fdd7172955a4476e8956c34aa49959219
# good: [87825243dfb1a14a0d8d3ae60754c34dfc084802] Merge branch 'loongarch-next' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
git bisect good 87825243dfb1a14a0d8d3ae60754c34dfc084802
# good: [3855d73729a7ab4c3a6694a6efdf0816c8ad9dd1] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
git bisect good 3855d73729a7ab4c3a6694a6efdf0816c8ad9dd1
# bad: [298370bcbb0e5a2fae6c8efd35e2b7bf4c918f54] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
git bisect bad 298370bcbb0e5a2fae6c8efd35e2b7bf4c918f54
# good: [927cf8c9dd2a58846b541d106149c5e94fd0556f] Merge branch 'nfsd-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good 927cf8c9dd2a58846b541d106149c5e94fd0556f
# bad: [530d23ed060f9c9ddf3b03398367aba9a9577b82] Merge branch 'vfs.super' into vfs.all
git bisect bad 530d23ed060f9c9ddf3b03398367aba9a9577b82
# bad: [7291b00e6f694af2b42d223145acb77b2bf1f62c] Merge branch 'vfs.iov_iter' into vfs.all
git bisect bad 7291b00e6f694af2b42d223145acb77b2bf1f62c
# bad: [459218d4c663f094951d71bbf293fd14dbb688e1] Merge branch 'vfs.mount.write' into vfs.all
git bisect bad 459218d4c663f094951d71bbf293fd14dbb688e1
# good: [cbe52963050bac0f2bfe2c24e09f50ffdc41132b] watch_queue: Annotate struct watch_filter with __counted_by
git bisect good cbe52963050bac0f2bfe2c24e09f50ffdc41132b
# bad: [450f431b47219235870f57a3f72fa8fec0a0ba43] vfs: fix readahead(2) on block devices
git bisect bad 450f431b47219235870f57a3f72fa8fec0a0ba43
# good: [1cf2d167e7f661b687feb0bd15278b859fe1513c] vfs: shave work on failed file open
git bisect good 1cf2d167e7f661b687feb0bd15278b859fe1513c
# bad: [d089d9d056c048303aedd40a7f3f26593ebd040c] file: convert to SLAB_TYPESAFE_BY_RCU
git bisect bad d089d9d056c048303aedd40a7f3f26593ebd040c
# first bad commit: [d089d9d056c048303aedd40a7f3f26593ebd040c] file: convert to SLAB_TYPESAFE_BY_RCU

--f4w7RcmGnW7dyD3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUfTwIACgkQJNaLcl1U
h9Balwf+KctNxpWpdLJd4w+5+82DrGudqyRx/6+Vito3vGyvjsqnLUB5nVxbjql2
EZlLDT2tjS+Ap1B4U9UvxHuUAiNwwhxLu2Sx+vYhHhMZoeOaqmzIr/F20qdRQMs/
VI/Fvc69iS/epSIDda+t5cesEDK0K9frqWNgXb27PXv4uKmSeNdWznyHzS38F0kJ
EElBSjSqIiBHHvT3jdhrlvJG/16JKthi+uSEXCdaUSwebYAT9F1MC80kEzFKb72w
W5/dwIdxE+3jd4AzPObiSdtcfnAKgWXtH3884/B3vQ4YkNpMnhNNrtD22Xahvn6K
wQcZlbQWofFtzB642ExENu7HkVcq7A==
=VOXX
-----END PGP SIGNATURE-----

--f4w7RcmGnW7dyD3d--
