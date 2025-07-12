Return-Path: <linux-fsdevel+bounces-54767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA1AB02D76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 00:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6CA1AA16E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 22:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E922F74E;
	Sat, 12 Jul 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rj8D72HC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E01DE89A;
	Sat, 12 Jul 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752359147; cv=none; b=b82E6NsqLi/3vpyHs8VqVR9nt+729PTPhlNfqVqkxLcyJIOqxotujoEsVrJe/1lZvDhwmuHiMUO5RqJitpGYo9lL/o/hQrIA3Dlh+S+T5wfS9VTE75yQ1uS8owWbJwOmU85rBXdVs3iFmE3lFHX4ObsQr2bKF2+bUKxfeOQUeZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752359147; c=relaxed/simple;
	bh=pSh3mjR//rnmlWfjJ4Z9nm0B9/qkk0CHM9jWwGNd7xM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ITbhNKPBaa1gabQST12FTEVStJ8iNxvjVf9XMKUZ4heJM6TjItyrb5uN3p562VPBd4ScwTUKo9vwDGlmD5MhZi+PdESgzOzrBf8tou6Blg5rUtpzLfLmcXhPYqbNKG9TMJRGZhQjvsM85qH75akZJZu0sMral2BQU45f+/122f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rj8D72HC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E61AC4CEEF;
	Sat, 12 Jul 2025 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752359145;
	bh=pSh3mjR//rnmlWfjJ4Z9nm0B9/qkk0CHM9jWwGNd7xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rj8D72HCwyU0hobnlvR8EllAN81WGIaQzcA/OOUokRki5KcSppE8ZQ4zJZP8sRRCL
	 IZqboHhtLhHRWRGAV0+HN6g2u9MK+MHF0fN9iUk1/kYu8upJ3/IKvrMQF5QJxz5EiX
	 DzV+NN2maEYxcUNc68LkbXq2sravQEDTdudSmmTg=
Date: Sat, 12 Jul 2025 15:25:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: David Hildenbrand <david@redhat.com>, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>, Ryan
 Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] readahead: Use folio_nr_pages() instead of shift
 operation
Message-Id: <20250712152544.07f236ec277290c70a2a862f@linux-foundation.org>
In-Reply-To: <661ccfa4-a5ad-4370-a7f5-e17968d8a46e@163.com>
References: <20250710060451.3535957-1-chizhiling@163.com>
	<479b493c-92c4-424a-a5c0-1c29a4325d15@redhat.com>
	<661ccfa4-a5ad-4370-a7f5-e17968d8a46e@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Jul 2025 10:23:32 +0800 Chi Zhiling <chizhiling@163.com> wrote:

> On 2025/7/12 00:15, David Hildenbrand wrote:
> > On 10.07.25 08:04, Chi Zhiling wrote:
> >> From: Chi Zhiling <chizhiling@kylinos.cn>
> >>
> >> folio_nr_pages() is faster helper function to get the number of pages
> >> when NR_PAGES_IN_LARGE_FOLIO is enabled.
> >>
> >> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> >> ---
> >> =A0 mm/readahead.c | 2 +-
> >> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/readahead.c b/mm/readahead.c
> >> index 95a24f12d1e7..406756d34309 100644
> >> --- a/mm/readahead.c
> >> +++ b/mm/readahead.c
> >> @@ -649,7 +649,7 @@ void page_cache_async_ra(struct readahead_control=
=20
> >> *ractl,
> >> =A0=A0=A0=A0=A0=A0 * Ramp up sizes, and push forward the readahead win=
dow.
> >> =A0=A0=A0=A0=A0=A0 */
> >> =A0=A0=A0=A0=A0 expected =3D round_down(ra->start + ra->size - ra->asy=
nc_size,
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1UL << folio_order(folio));
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 folio_nr_pages(folio));
> >> =A0=A0=A0=A0=A0 if (index =3D=3D expected) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ra->start +=3D ra->size;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> >=20
> > This should probably get squashed in Ryans commit?
>=20
> I have no objection, it's up to Ryan.

"Ryans commit" is now c4602f9fa77f ("mm/readahead: store folio order in
struct file_ra_state") in mm-stable.  I'd prefer not to rebase for this!




