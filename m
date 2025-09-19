Return-Path: <linux-fsdevel+bounces-62230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E04B8983C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F4A3B6826
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2335221F39;
	Fri, 19 Sep 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="kkC/5xUZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECF21B9C5
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285877; cv=none; b=M0sR+w9ui0+0hnC9cBYKOaU53Yw1LLvYgoPYu2q4qwyLaW2IdUovl+Ntw3MZMuR2MnDgWwueg5kEJG1+1zmK8Vw6kdmTSZpIyYCbJdCZZ9vCAsdFwrLLvV4+fUfg15kgiId6AF1g4EvNrACMr9EPdDb53FJiiU9/R5JgF+UfbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285877; c=relaxed/simple;
	bh=r9NdBC7S4y0MQGeGmusoFjVRvk5bdEwLh+OJBdq4aT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZJQLJjcjNGpGjLwFAe/qPGeBxGYwHTqwK04TINGVivdgDYunx2KOdMomukuldOuX+BjsWk7u7PyNcDSS7th/2E2DR+uoi/XZYDJPRcq4kQMoojfkMOw1Mz/g/0j3Nn8Ae5atWV4p2q4dgRsFoFP421y6s8SQYLsia1pS3V/Rbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=kkC/5xUZ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cSsdq05Ccz9t4w;
	Fri, 19 Sep 2025 14:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758285871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T6gZQImpoZO7PeK+0O4VfnNlV9ykNSvzjS1vojQaKBY=;
	b=kkC/5xUZYgFDfaMyaK/ydHeVW09dGjeOnvo3QlQHnvSRsTpwjfHCuOLviNYNB1bsr46U30
	Z34XOaHPPdMsinE0XFedxioLbFpvZD4NluBeEA89jLcXqlZ2n0RRzdmEXAUpmcQaOZ/ELQ
	K8cuoMfY2EI7Be8xpjh8z/KRY9tj/AFblPoVVO+lF+DPvJomlW91LbfnzVlC1ukWLBz+lf
	10LjsKtCGPhvP1V01HoRDlDECeLs0I0AziIIzepmA078HBlwJZROc5+66wNJPfGsCXAcB1
	yQsWXUeNGB3PsWTT8vg0lf+dHlzEg7LUHf0P0sOwbqaikDkWjDYzY+0Y8KMSxQ==
Date: Fri, 19 Sep 2025 22:44:19 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] selftests/namespaces: verify initial namespace inode
 numbers
Message-ID: <2025-09-19-askew-endless-sugars-pokers-Xf6Mrf@cyphar.com>
References: <20250919-work-namespace-selftests-v1-1-be04cbf4bc37@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="osaflwzk24ws3fht"
Content-Disposition: inline
In-Reply-To: <20250919-work-namespace-selftests-v1-1-be04cbf4bc37@kernel.org>


--osaflwzk24ws3fht
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] selftests/namespaces: verify initial namespace inode
 numbers
MIME-Version: 1.0

On 2025-09-19, Christian Brauner <brauner@kernel.org> wrote:
> Make sure that all works correctly.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good, feel free to take my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> ---
>  tools/testing/selftests/namespaces/.gitignore      |  1 +
>  tools/testing/selftests/namespaces/Makefile        |  2 +-
>  tools/testing/selftests/namespaces/init_ino_test.c | 60 ++++++++++++++++=
++++++
>  3 files changed, 62 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testin=
g/selftests/namespaces/.gitignore
> index 7639dbf58bbf..ccfb40837a73 100644
> --- a/tools/testing/selftests/namespaces/.gitignore
> +++ b/tools/testing/selftests/namespaces/.gitignore
> @@ -1,2 +1,3 @@
>  nsid_test
>  file_handle_test
> +init_ino_test
> diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/=
selftests/namespaces/Makefile
> index f6c117ce2c2b..5fe4b3dc07d3 100644
> --- a/tools/testing/selftests/namespaces/Makefile
> +++ b/tools/testing/selftests/namespaces/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS +=3D -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> =20
> -TEST_GEN_PROGS :=3D nsid_test file_handle_test
> +TEST_GEN_PROGS :=3D nsid_test file_handle_test init_ino_test
> =20
>  include ../lib.mk
> =20
> diff --git a/tools/testing/selftests/namespaces/init_ino_test.c b/tools/t=
esting/selftests/namespaces/init_ino_test.c
> new file mode 100644
> index 000000000000..ddd5008d46a6
> --- /dev/null
> +++ b/tools/testing/selftests/namespaces/init_ino_test.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2025 Christian Brauner <brauner@kernel.org>
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <linux/nsfs.h>
> +
> +#include "../kselftest_harness.h"
> +
> +struct ns_info {
> +	const char *name;
> +	const char *proc_path;
> +	unsigned int expected_ino;
> +};
> +
> +static struct ns_info namespaces[] =3D {
> +	{ "ipc",    "/proc/1/ns/ipc",    IPC_NS_INIT_INO },
> +	{ "uts",    "/proc/1/ns/uts",    UTS_NS_INIT_INO },
> +	{ "user",   "/proc/1/ns/user",   USER_NS_INIT_INO },
> +	{ "pid",    "/proc/1/ns/pid",    PID_NS_INIT_INO },
> +	{ "cgroup", "/proc/1/ns/cgroup", CGROUP_NS_INIT_INO },
> +	{ "time",   "/proc/1/ns/time",   TIME_NS_INIT_INO },
> +	{ "net",    "/proc/1/ns/net",    NET_NS_INIT_INO },
> +	{ "mnt",    "/proc/1/ns/mnt",    MNT_NS_INIT_INO },
> +};
> +
> +TEST(init_namespace_inodes)
> +{
> +	struct stat st;
> +
> +	for (int i =3D 0; i < sizeof(namespaces) / sizeof(namespaces[0]); i++) {
> +		int ret =3D stat(namespaces[i].proc_path, &st);
> +	=09
> +		/* Some namespaces might not be available (e.g., time namespace on old=
er kernels) */
> +		if (ret < 0) {
> +			if (errno =3D=3D ENOENT) {
> +				ksft_test_result_skip("%s namespace not available\n", namespaces[i].=
name);
> +				continue;
> +			}
> +			ASSERT_GE(ret, 0)
> +				TH_LOG("Failed to stat %s: %s", namespaces[i].proc_path, strerror(er=
rno));
> +		}
> +
> +		ASSERT_EQ(st.st_ino, namespaces[i].expected_ino) {
> +			TH_LOG("Namespace %s has inode 0x%lx, expected 0x%x",
> +			       namespaces[i].name, st.st_ino, namespaces[i].expected_ino);
> +		}
> +
> +		ksft_print_msg("Namespace %s: inode 0x%lx matches expected 0x%x\n",
> +			       namespaces[i].name, st.st_ino, namespaces[i].expected_ino);
> +	}
> +}
> +
> +TEST_HARNESS_MAIN
>=20
> ---
> base-commit: 5a9b4dfe901cecd4e06692bb877b393459e4d50d
> change-id: 20250919-work-namespace-selftests-7b478f415792
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--osaflwzk24ws3fht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaM1QIxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9QUAD/f+39K9blPSgQzBYAyJrW
xQ+z3+/ECpUt6jFlM/nEhYcBALGzINB60LRxypzO4t1CHc/ljoGppgdqy8iQoKtN
DPUD
=2k8W
-----END PGP SIGNATURE-----

--osaflwzk24ws3fht--

