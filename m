Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F8A736A55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjFTLHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjFTLHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A91991;
        Tue, 20 Jun 2023 04:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F9F2611EF;
        Tue, 20 Jun 2023 11:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17477C433C0;
        Tue, 20 Jun 2023 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687259190;
        bh=hVUuY5x5g9EGPajdBvb661xphx1c0Xsm7QeY6bqtW3M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hjTWHpL23/rXyCUBKVzdoc0hyunbDzZN+1w5gkgtjtENJuoyeKk+cuX4PA2YuNlSM
         pjLaSH9XI1M3bK35JiKUoLlUQFWBPDEMkYyGt5v/OfVM5RE/TFAfYRwDUa1rDG79O5
         qfUSQHcQ6Pzz9BNsYHTxxJoHJH4m50cch9Nrhd46+JoE41H9iRMlrhNrpbWqoOguDV
         yKZVT/Ype8eUSVlQ2SzB6IsZeK/GV5AGaFim/EJ1dG2T6CWUtGRcUs0dVqYQGznEQ3
         gNJk0fmEXggDFxjjfMuTjLGJpnyEIDaUQ4hjx3SJT09/qnL5oNCWW7Pz65EKdhp6va
         N7DRr3V1hLUNg==
Message-ID: <4c110d97043aa70384da5ad2379b03c3d6e737ff.camel@kernel.org>
Subject: Re: [PATCH 3/3] selftests: add OFD lock tests
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 20 Jun 2023 07:06:28 -0400
In-Reply-To: <20230620095507.2677463-4-stsp2@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
         <20230620095507.2677463-4-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-06-20 at 14:55 +0500, Stas Sergeev wrote:
> Test the basic locking stuff on 2 fds: multiple read locks,
> conflicts between read and write locks, use of len=3D=3D0 for queries.
> Also test for pid and F_UNLCK F_OFD_GETLK extensions.
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
>=20
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Christian Brauner <brauner@kernel.org>
> CC: linux-fsdevel@vger.kernel.org
>=20
> ---
>  tools/testing/selftests/locking/Makefile   |   2 +
>  tools/testing/selftests/locking/ofdlocks.c | 138 +++++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 tools/testing/selftests/locking/ofdlocks.c
>=20
> diff --git a/tools/testing/selftests/locking/Makefile b/tools/testing/sel=
ftests/locking/Makefile
> index 6e7761ab3536..a83ced1626de 100644
> --- a/tools/testing/selftests/locking/Makefile
> +++ b/tools/testing/selftests/locking/Makefile
> @@ -7,4 +7,6 @@ all:
> =20
>  TEST_PROGS :=3D ww_mutex.sh
> =20
> +TEST_GEN_PROGS :=3D ofdlocks
> +
>  include ../lib.mk
> diff --git a/tools/testing/selftests/locking/ofdlocks.c b/tools/testing/s=
elftests/locking/ofdlocks.c
> new file mode 100644
> index 000000000000..1cff350e2c81
> --- /dev/null
> +++ b/tools/testing/selftests/locking/ofdlocks.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <assert.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include "../kselftest.h"
> +
> +static int lock_set(int fd, struct flock *fl)
> +{
> +	int ret;
> +
> +	fl->l_pid =3D 0;		// needed for OFD locks
> +	fl->l_whence =3D SEEK_SET;
> +	ret =3D fcntl(fd, F_OFD_SETLK, fl);
> +	if (ret)
> +		perror("fcntl()");
> +	return ret;
> +}
> +
> +static int lock_get(int fd, struct flock *fl)
> +{
> +	int ret;
> +
> +	fl->l_pid =3D 0;		// needed for OFD locks
> +	fl->l_whence =3D SEEK_SET;
> +	ret =3D fcntl(fd, F_OFD_GETLK, fl);
> +	if (ret)
> +		perror("fcntl()");
> +	return ret;
> +}
> +
> +int main(void)
> +{
> +	int rc;
> +	struct flock fl, fl2;
> +	int fd =3D open("/tmp/aa", O_RDWR | O_CREAT | O_EXCL, 0600);
> +	int fd2 =3D open("/tmp/aa", O_RDONLY);
> +
> +	unlink("aa");
> +	assert(fd !=3D -1);
> +	assert(fd2 !=3D -1);
> +	ksft_print_msg("[INFO] opened fds %i %i\n", fd, fd2);
> +
> +	/* Set some read lock */
> +	fl.l_type =3D F_RDLCK;
> +	fl.l_start =3D 5;
> +	fl.l_len =3D 3;
> +	rc =3D lock_set(fd, &fl);
> +	if (rc =3D=3D 0) {
> +		ksft_print_msg
> +		    ("[SUCCESS] set OFD read lock on first fd\n");
> +	} else {
> +		ksft_print_msg("[FAIL] to set OFD read lock on first fd\n");
> +		return -1;
> +	}
> +	/* Make sure read locks do not conflict on different fds. */
> +	fl.l_type =3D F_RDLCK;
> +	fl.l_start =3D 5;
> +	fl.l_len =3D 1;
> +	rc =3D lock_get(fd2, &fl);
> +	if (rc !=3D 0)
> +		return -1;
> +	if (fl.l_type !=3D F_UNLCK) {
> +		ksft_print_msg("[FAIL] read locks conflicted\n");
> +		return -1;
> +	}
> +	/* Make sure read/write locks do conflict on different fds. */
> +	fl.l_type =3D F_WRLCK;
> +	fl.l_start =3D 5;
> +	fl.l_len =3D 1;
> +	rc =3D lock_get(fd2, &fl);
> +	if (rc !=3D 0)
> +		return -1;
> +	if (fl.l_type !=3D F_UNLCK) {
> +		ksft_print_msg
> +		    ("[SUCCESS] read and write locks conflicted\n");
> +	} else {
> +		ksft_print_msg
> +		    ("[SUCCESS] read and write locks not conflicted\n");
> +		return -1;
> +	}
> +	/* Get info about the lock on first fd. */
> +	fl.l_type =3D F_UNLCK;
> +	fl.l_start =3D 5;
> +	fl.l_len =3D 1;
> +	rc =3D lock_get(fd, &fl);
> +	if (rc !=3D 0) {
> +		ksft_print_msg
> +		    ("[FAIL] F_OFD_GETLK with F_UNLCK not supported\n");
> +		return -1;
> +	}
> +	if (fl.l_type !=3D F_UNLCK) {
> +		if (fl.l_pid !=3D getpid()) {
> +			ksft_print_msg
> +			    ("[FAIL] F_OFD_GETLK does not return pid, %i\n",
> +			    fl.l_pid);
> +			return -1;
> +		}

A selftest seems like a reasonable thing to add. The above check will
need to be fixed to not expect a real pid on a OFD lock, of course.

> +		ksft_print_msg
> +		    ("[SUCCESS] F_UNLCK test returns: locked, type %i pid %i len %zi\n=
",
> +		     fl.l_type, fl.l_pid, fl.l_len);
> +	} else {
> +		ksft_print_msg
> +		    ("[FAIL] F_OFD_GETLK with F_UNLCK did not return lock info\n");
> +		return -1;
> +	}
> +	/* Try the same but by locking everything by len=3D=3D0. */
> +	fl2.l_type =3D F_UNLCK;
> +	fl2.l_start =3D 0;
> +	fl2.l_len =3D 0;
> +	rc =3D lock_get(fd, &fl2);
> +	if (rc !=3D 0) {
> +		ksft_print_msg
> +		    ("[FAIL] F_OFD_GETLK with F_UNLCK not supported\n");
> +		return -1;
> +	}
> +	if (memcmp(&fl, &fl2, sizeof(fl))) {
> +		ksft_print_msg
> +		    ("[FAIL] F_UNLCK test returns: locked, type %i pid %i len %zi\n",
> +		     fl.l_type, fl.l_pid, fl.l_len);
> +		return -1;
> +	}
> +	ksft_print_msg("[SUCCESS] F_UNLCK with len=3D=3D0 returned the same\n")=
;
> +	/* Get info about the lock on second fd - no locks on it. */
> +	fl.l_type =3D F_UNLCK;
> +	fl.l_start =3D 0;
> +	fl.l_len =3D 0;
> +	lock_get(fd2, &fl);
> +	if (fl.l_type !=3D F_UNLCK) {
> +		ksft_print_msg
> +		    ("[FAIL] F_OFD_GETLK with F_UNLCK return lock info from another fd=
\n");
> +		return -1;
> +	}
> +	return 0;
> +}

--=20
Jeff Layton <jlayton@kernel.org>
