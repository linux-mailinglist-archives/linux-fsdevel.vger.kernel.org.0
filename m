Return-Path: <linux-fsdevel+bounces-40908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B3AA289E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB98166827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E222B8CD;
	Wed,  5 Feb 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="mHkbXXkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8162288C3;
	Wed,  5 Feb 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757219; cv=none; b=P6GgjTuatdoMPcxGpwiIzirt4WE8O8OiDxbN2DsqdhbIW3GhdRSrSBkP9in4T9zA8Brmjk1OJezI+FqPEFagZfIIsqSz6hd/S8zXa30PxCmIgtELOTNyg+M5USH69pyYKSVPp4Vox+fYXDHrXG8+oJ9hF5uc2ABXkqtziWw75HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757219; c=relaxed/simple;
	bh=5qBs+P9AcN2m3Xi249ox5NyNN05CkU/eenHuRZqTRX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d15SahHK6dBCeUfkluEgywceWq8r4t8jYElB9hq0Oj3DfE2VyjIRtYwbhtWXGQmKPWjkNUlUKvcn9nBJZjrfxwtHh/QQAAhS80XRBbeQrxXoNt5bupvfUzAv/7zSe9FEIialR0mQgohjYXGd6BMsHqN+4+5Iqt7EHmBAq0af8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=mHkbXXkz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738757193; x=1739361993; i=ps.report@gmx.net;
	bh=dnTeU+z2cXOaBIAYpMXZCpU4QPCN35HyNl14tHHflaY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mHkbXXkzg+e2vfh+vudSJJbn1FW0aFHHIZT45Shmuf8/mKnScem8ptAwNNHFG+8+
	 g2kx6qXWkIDcW+HK+5nPbAYvrZVkZ9P16QklVUCGVt3CxnHunLyl2yoIOwG0FFt5k
	 ibdKM+ZFj570TEUo963BoRNOS2UWv+kBmECmI7hmr8KYkBeUJlaPlA7JzQRjIc91q
	 Fma/hTe9SYv0O0eqzFGcXFSajsgas58spBExqeFuDdM0LTKqZ19wc+GqbDz2VXbWb
	 QEelVwTybcCw+ejyv7uSMUlrEfO8Ba+tLhURzVBcSVZCuQy+4ihXfcvND3W5Lcm9u
	 NI1+PERFzjJ5dPZjeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1twM4x4A0x-00S3Dp; Wed, 05
 Feb 2025 13:06:33 +0100
Date: Wed, 5 Feb 2025 13:06:29 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Sang
 <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt
 <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 2/6] selftests/pidfd: add missing system header
 imcludes to pidfd tests
Message-ID: <20250205130629.27f142ac@gmx.net>
In-Reply-To: <fab8843ea8664b5089f95ccfdcfd5bd7a5a6bb0b.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
	<fab8843ea8664b5089f95ccfdcfd5bd7a5a6bb0b.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sst7RsRHsV3XSXWva+R9sBzRXOf+cKr29GPeVlyWflCIPr1Mv0B
 YJD3+SUEraUULxJTSSxm9qSskCuirm6fhHXIJX01Cm11EhpiiFYwf0BUG5twLqVQwv4SpdY
 8B2JK6CN3Shty4XssSU87yCqYYVg9IcBYU54km+g8wUVNl1Af+PBVzU7FN0H7TuZ6hcCqM4
 d11y3iUu9yP2ZbiM6WOrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OPRrfe9o8rE=;iGeCkuX/XV1RdWC6+VU8bfcYZSG
 iR9SgWnevZlOrD09jXkWNTCNhjNBsngOr6OyQpnXJiuLgGyq6Wh5kHsqg3CtXrCUp/Xhq4Cq1
 RWeJ7wFeuqyaKGdP8lqNuNzGjMjJTQRHBWXKZ3VixpoY7WMw2whKfSVKQkmTknQPVylmvZSqb
 pa7ObWcWa1fZiU/A7O3wxwQrfTF5QpYV+KP6fy8YJkUMj65N/kR9TTvi9o31BUWhoQCCAptlL
 2xS9GCsE+PA8F1+9c3oRpa/Co6fbB3fiI7KjoDtanRJfhjQxpk04drzv1meRyzXjgJUfRKoR6
 rovaE2CBlcvl8kq4dMhLSe2xTzeYx3YcjCQ0zoeNNTehkZY58LFc2iPWlsthz2x4hFoj600yq
 wy0t+JFBfe2la7kj2WolWFL2l00C0S7NU/1fh20F0l40+6irJO1ioCApFJ8ESEGw40RkMqkek
 +KqRO2ALeMT6ij6xO4l5Zk8PA5qc4ljcbe7XpxY8H98QAM4SroN4rn9tqiD4DiBkEOUEo7fDj
 mInOnpov6LgPLX6GcTywc/Xf7A56cu72fgWKNcIT6ABo+Xnwy6prbx5vUHjuSK1PJ+tYNVbDT
 6G2v8EzF1d2d/z76CszvSvo57EdQJ2ifQAluax3dsvJ7PfKrR+kgYFpdI4/2Wk/h4UUemevBm
 WXeeNyAzTNlj/mo+644kcLx+TvoqoqFrgrjK/xD6Swt7hG58ZmpTYy6ZuDTuO40UCtAkO8Un5
 pGzpb1r1dm5Uv2CC+7lf9K9yFUOK2Z4XYDGV9ev7FPKLpqN6CaFdfAMma38cbNutamiYLWnDo
 G146ENfAz9Ji3u/u9De0J4cbWT/PQeu9P72RnfjYekYZ5yZHeYgH4pHgOpRNyjlHxS7TlK9ej
 J72aJRfI/QRXvakm2qqaWqoRFvp15TW85heR2mxD/ROuL0fN8VoC2gVE6rFFcXBJlZ0xNy8u1
 WSAp/I7+URqGIblYZ7B3L+1cYS6JllKVOUBsvNdQMTdWYIDkm5/3D3QV+JTnBJc54cbyb8oxK
 ziGEKJ8mYaKSVqrtlZcQC+ywS/g6ffoM8zZsBb+k/OeEuFe1G0wgHu0tH+pq6tKRXAFsTYCUh
 dq9vuDHyx8uL95Wxes87OMQWtR74TYRY1DO8S7IFwyI6Fv8ihz2b32AHY21ERkOQstKZ8xIQV
 tkl5p1ywtrczf0iKItkkzCru0Toy2+CLBO2nTD3h6H4oEnKCdk7GhVkoc5HI/PRHB60ZSj+qF
 cLyWcuyAigTMOU78ikjgXYxNQL6rFJUVNNADbcdaKTtYh1Z8X3Z4ldyvpX9ShpGiY+tMl+0ep
 XhhLNV1wsz5CAu1pg6Dd8r+MbD2dd+A5q14/jGyBJEfWXvPwe8xQztmP7zdWnF6WYkTNn4SzO
 bxvpdr3suUsPTMuJSjc6QIHTLF+GcggC+vTwBMpgKzav+kHV0K5BA+zOzt

Hello *,

On Thu, 30 Jan 2025 20:40:27 +0000, Lorenzo Stoakes <lorenzo.stoakes@oracl=
e.com> wrote:

> The pidfd_fdinfo_test.c and pidfd_setns_test.c tests appear to be missin=
g
> fundamental system header imports required to execute correctly. Add the=
se.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
>  tools/testing/selftests/pidfd/pidfd_setns_test.c  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/t=
esting/selftests/pidfd/pidfd_fdinfo_test.c
> index f062a986e382..f718aac75068 100644
> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> @@ -13,6 +13,7 @@
>  #include <syscall.h>
>  #include <sys/wait.h>
>  #include <sys/mman.h>
> +#include <sys/mount.h>
>
>  #include "pidfd.h"
>  #include "../kselftest.h"

Predated patch already available, see

	https://lore.kernel.org/linux-kselftest/20250115105211.390370-1-ps.report=
@gmx.net/

> diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/te=
sting/selftests/pidfd/pidfd_setns_test.c
> index 222f8131283b..a55f6641e0b6 100644
> --- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> @@ -14,6 +14,7 @@
>  #include <sys/prctl.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> +#include <sys/ioctl.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
>  #include <linux/ioctl.h>

and predated patch available, see

	https://lore.kernel.org/linux-kselftest/20250115105211.390370-2-ps.report=
@gmx.net/

Regards,
Peter


