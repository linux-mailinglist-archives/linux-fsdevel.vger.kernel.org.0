Return-Path: <linux-fsdevel+bounces-42863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB02DA49F4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 17:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D46A3B382D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20074274248;
	Fri, 28 Feb 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VJa9A5Ye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4137189B84;
	Fri, 28 Feb 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761391; cv=none; b=pj5F/nKGZzgmcYycac66aonslQOxrvZROqLM70KAbe4ppU2dv5WIcaB2kld/xAZ3fjYMWKUkx/7w8IrFy3uyD5bl8x2ATHzqE4zJF6JknojlsuHngVS3JFE1zQjfm9B5YewqXlHHKoLGR3N6vJ0FPO7KNs5l6AAiFBzdh7r6m/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761391; c=relaxed/simple;
	bh=Wf4Spbjcc1F3e1BGo74fk+hf2L2xd9vSSjE+PFgFlBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZOu6LREoWPI5XkMSPS5WROs+b4aXpgkPEQX316cfpfMM7L2Uj5b1ya5g4PAoWmmg07/MCxnl916N9NIVVdNFQZrDL7BDN53GjKRNplLihaYeza2Ppfj8i8fF/LGUPusuJRNWrIF7qbM2541m6sjOsdiDTtbXhOQE+hZd8C1WNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VJa9A5Ye; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740761386;
	bh=Wf4Spbjcc1F3e1BGo74fk+hf2L2xd9vSSjE+PFgFlBw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VJa9A5YeCGy/7cBIRp6/E+rg3V0rr/MV1RvqNudBYlp695mb+R3ovdhyWYx0I6pCQ
	 eVYNhDmQwcco3iHQll2WThlFWbBTwphiyagI0M7Xc6zlFGpMChhnQQ0bGnCC349AP2
	 Sy0yzjwT8F6mpWLrP81vSWfasYc3Qs3jgZOa/1QE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 4CF771C0887;
	Fri, 28 Feb 2025 11:49:46 -0500 (EST)
Message-ID: <3c371af00ce12575ab11522189cd37d4167cc3aa.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/2] efivarfs: add variable resync after hibernation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jon Hunter <jonathanh@nvidia.com>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Christian
 Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Lennart
 Poettering <mzxreary@0pointer.de>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Date: Fri, 28 Feb 2025 11:49:45 -0500
In-Reply-To: <5205ea6a-92eb-4c3d-a135-f3c3ea3bbf1c@nvidia.com>
References: <20250107213129.28454-1-James.Bottomley@HansenPartnership.com>
	 <20250107213129.28454-3-James.Bottomley@HansenPartnership.com>
	 <5205ea6a-92eb-4c3d-a135-f3c3ea3bbf1c@nvidia.com>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=mQENBE58FlABCADPM714lRLxGmba4JFjkocqpj1/6/Cx+IXezcS22azZetzCXDpm2MfNElecY3qkFjfnoffQiw5rrOO0/oRSATOh8+2fmJ6el7naRbDuh+i8lVESfdlkoqX57H5R8h/UTIp6gn1mpNlxjQv6QSZbl551zQ1nmkSVRbA5TbEp4br5GZeJ58esmYDCBwxuFTsSsdzbOBNthLcudWpJZHURfMc0ew24By1nldL9F37AktNcCipKpC2U0NtGlJjYPNSVXrCd1izxKmO7te7BLP+7B4DNj1VRnaf8X9+VIApCi/l4Kdx+ZR3aLTqSuNsIMmXUJ3T8JRl+ag7kby/KBp+0OpotABEBAAG0N0phbWVzIEJvdHRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT6JAVgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmBLmY0FCRs1hL0ACgkQgUrkfCFIVNaEiQgAg18F4G7PGWQ68xqnIrccke7Reh5thjUz6kQIii6Dh64BDW6/UvXn20UxK2uSs/0TBLO81k1mV4c6rNE+H8b7IEjieGR9frBsp/+Q01JpToJfzzMUY7ZTDV1IXQZ+AY9L7vRzyimnJHx0Ba4JTlAyHB+Ly5i4Ab2+uZcnNfBXquWrG3oPWz+qPK88LJLya5Jxse1m1QT6R/isDuPivBzntLOooxPk+Cwf5sFAAJND+idTAzWzslexr9j7rtQ1UW6FjO4CvK9yVNz7dgG6FvEZl6J/HOr1rivtGgpCZTBzKNF8jg034n49zGfKkkzWLuXbPUOp3/oGfsKv8pnEu1c2GbQpSmFtZXMgQm90dG9tbGV5IDxqZWpiQGxpbnV4LnZuZXQuaWJtLmNvbT6JAVYEEwEIAEACGwMHCwkIBwMCAQYVC
	AIJCgsEFgIDAQIeAQIXgBYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJgS5mXBQkbNYS9AAoJEIFK5HwhSFTWEYEH/1YZpV+1uCI2MVz0wTRlnO/3OW/xnyigrw+K4cuO7MToo0tHJb/qL9CBJ2ddG6q+GTnF5kqUe87t7M7rSrIcAkIZMbJmtIbKk0j5EstyYqlE1HzvpmssGpg/8uJBBuWbU35af1ubKCjUs1+974mYXkfLmS0a6h+cG7atVLmyClIc2frd3o0zHF9+E7BaB+HQzT4lheQAXv9KI+63ksnbBpcZnS44t6mi1lzUE65+Am1z+1KJurF2Qbj4AkICzJjJa0bXa9DmFunjPhLbCU160LppaG3OksxuNOTkGCo/tEotDOotZNBYejWaXN2nr9WrH5hDfQ5zLayfKMtLSd33T9u0IUphbWVzIEJvdHRvbWxleSA8amVqYkBrZXJuZWwub3JnPokBVQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQTVYG5zyLRicb6tmt+BSuR8IUhU1gUCYEuZmAUJGzWEvQAKCRCBSuR8IUhU1gacCAC+QZN+RQd+FOoh5g884HQm8S07ON0/2EMiaXBiL6KQb5yP3w2PKEhug3+uPzugftUfgPEw6emRucrFFpwguhriGhB3pgWJIrTD4JUevrBgjEGOztJpbD73bLLyitSiPQZ6OFVOqIGhdqlc3n0qoNQ45n/w3LMVj6yP43SfBQeQGEdq4yHQxXPs0XQCbmr6Nf2p8mNsIKRYf90fCDmABH1lfZxoGJH/frQOBCJ9bMRNCNy+aFtjd5m8ka5M7gcDvM7TAsKhD5O5qFs4aJHGajF4gCGoWmXZGrISQvrNl9kWUhgsvoPqb2OTTeAQVRuV8C4FQamxzE3MRNH25j6s/qujtCRKYW1lcyBCb3R0b21sZXkgPGplamJAbGludXguaWJtLmNvbT6JAVQEEwEIAD
	4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTVYG5zyLRicb6tmt+BSuR8IUhU1gUCYEuZmQUJGzWEvQAKCRCBSuR8IUhU1kyHB/9VIOkf8RapONUdZ+7FgEpDgESE/y3coDeeb8jrtJyeefWCA0sWU8GSc9KMcMoSUetUreB+fukeVTe/f2NcJ87Bkq5jUEWff4qsbqf5PPM+wlD873StFc6mP8koy8bb7QcH3asH9fDFXUz7Oz5ubI0sE8+qD+Pdlk5qmLY5IiZ4D98V239nrKIhDymcuL7VztyWfdFSnbVXmumIpi79Ox536P2aMe3/v+1jAsFQOIjThMo/2xmLkQiyacB2veMcBzBkcair5WC7SBgrz2YsMCbC37X7crDWmCI3xEuwRAeDNpmxhVCb7jEvigNfRWQ4TYQADdC4KsilPfuW8Edk/8tPtCVKYW1lcyBCb3R0b21sZXkgPEpCb3R0b21sZXlAT2Rpbi5jb20+iQEfBDABAgAJBQJXI+B0Ah0gAAoJEIFK5HwhSFTWzkwH+gOg1UG/oB2lc0DF3lAJPloSIDBW38D3rezXTUiJtAhenWrH2Cl/ejznjdTukxOcuR1bV8zxR9Zs9jhUin2tgCCxIbrdvFIoYilMMRKcue1q0IYQHaqjd7ko8BHn9UysuX8qltJFar0BOClIlH95gdKWJbK46mw7bsXeD66N9IhAsOMJt6mSJmUdIOMuKy4dD4X3adegKMmoTRvHOndZQClTZHiYt5ECRPO534Lb/gyKAKQkFiwirsgx11ZSx3zGlw28brco6ohSLMBylna/Pbbn5hII86cjrCXWtQ4mE0Y6ofeFjpmMdfSRUxy6LHYd3fxVq9PoAJTv7vQ6bLTDFNa0KkphbWVzIEJvdHRvbWxleSA8SkJvdHRvbWxleUBQYXJhbGxlbHMuY29tPokBHwQwAQIACQUCVyPgjAIdIAAKCRCBSuR8IUhU1tXiB/9D9OOU8qB
	CZPxkxB6ofp0j0pbZppRe6iCJ+btWBhSURz25DQzQNu5GVBRQt1Us6v3PPGU1cEWi5WL935nw+1hXPIVB3x8hElvdCO2aU61bMcpFd138AFHMHJ+emboKHblnhuY5+L1OlA1QmPw6wQooCor1h113lZiBZGrPFxjRYbWYVQmVaM6zhkiGgIkzQw/g9v57nAzYuBhFjnVHgmmu6/B0N8z6xD5sSPCZSjYSS38UG9w189S8HVr4eg54jReIEvLPRaxqVEnsoKmLisryyaw3EpqZcYAWoX0Am+58CXq3j5OvrCvbyqQIWFElba3Ka/oT7CnTdo/SUL/jPNobtCxKYW1lcyBCb3R0b21sZXkgPGplamJAaGFuc2VucGFydG5lcnNoaXAuY29tPokBVwQTAQgAQRYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJjg2eQAhsDBQkbNYS9BQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEIFK5HwhSFTWbtAH/087y9vzXYAHMPbjd8etB/I3OEFKteFacXBRBRDKXI9ZqK5F/xvd1fuehwQWl2Y/sivD4cSAP0iM/rFOwv9GLyrr82pD/GV/+1iXt9kjlLY36/1U2qoyAczY+jsS72aZjWwcO7Og8IYTaRzlqif9Zpfj7Q0Q1e9SAefMlakI6dcZTSlZWaaXCefdPBCc7BZ0SFY4kIg0iqKaagdgQomwW61nJZ+woljMjgv3HKOkiJ+rcB/n+/moryd8RnDhNmvYASheazYvUwaF/aMj5rIb/0w5p6IbFax+wGF5RmH2U5NeUlhIkTodUF/P7g/cJf4HCL+RA1KU/xS9o8zrAOeut2+4UgRaZ7bmEwgqhkjOPQMBBwIDBH4GsIgL0yQij5S5ISDZmlR7qDQPcWUxMVx6zVPsAoITdjKFjaDmUATkS+l5zmiCrUBcJ6MBavPiYQ4kqn4/xwaJAbMEGAEIACYCGwIWIQTVYG5zyLRi
	cb6tmt+BSuR8IUhU1gUCZag0LwUJDwLkSQCBdiAEGRMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCWme25gAKCRDnQslM7pishdi9AQDyOvLYOBkylBqiTlJrMnGCCsWgGZwPpKq3e3s7JQ/xBAEAlx29pPY5z0RLyIDUsjf9mtkSNTaeaQ6TIjDrFa+8XH8JEIFK5HwhSFTWkasH/j7LL9WH9dRfwfTwuMMj1/KGzjU/4KFIu4uKxDaevKpGS7sDx4F56mafCdGD8u4+ri6bJr/3mmuzIdyger0vJdRlTrnpX3ONXvR57p1JHgCljehE1ZB0RCzIk0vKhdt8+CDBQWfKbbKBTmzA7wR68raMQb2D7nQ9d0KXXbtr7Hag29yj92aUAZ/sFoe9RhDOcRUptdYyPKU1JHgJyc0Z7HwNjRSJ4lKJSKP+Px0/XxT3gV3LaDLtHuHa2IujLEAKcPzTr5DOV+xsgA3iSwTYI6H5aEe+ZRv/rA4sdjqRiVpo2d044aCUFUNQ3PiIHPAZR3KK5O64m6+BJMDXBvgSsMy4VgRaZ7clEggqhkjOPQMBBwIDBMfuMuE+PECbOoYjkD0Teno7TDbcgxJNgPV7Y2lQbNBnexMLOEY6/xJzRi1Xm/o9mOyZ+VIj8h4G5V/eWSntNkwDAQgHiQE8BBgBCAAmAhsMFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmWoNBwFCQ8C4/cACgkQgUrkfCFIVNZs4AgAnIjU1QEPLdpotiy3X01sKUO+hvcT3/Cd6g55sJyKJ5/U0o3f8fdSn6MWPhi1m62zbAxcLJFiTZ3OWNCZAMEvwHrXFb684Ey6yImQ9gm2dG2nVuCzr1+9gIaMSBeZ+4kUJqhdWSJjrNLQG38GbnBuYOJUD+x6oJ2AT10/mQfBVZ3qWDQXr/je2TSf0OIXaWyG6meG5yTqOEv0eaTH22yBb1nbodoZkmlMMb56jzRGZuorhFE06
	N0Eb0kiGz5cCIrHZoH10dHWoa7/Z+AzfL0caOKjcmsnUPcmcrqmWzJTEibLA81z15GBCrldfQVt+dF7Us2kc0hKUgaWeI8Gv4CzwLkCDQRUdhaZARAApeF9gbNSBBudW8xeMQIiB/CZwK4VOEP7nGHZn3UsWemsvE9lvjbFzbqcIkbUp2V6ExM5tyEgzio2BavLe1ZJGHVaKkL3cKLABoYi/yBLEnogPFzzYfK2fdipm2G+GhLaqfDxtAQ7cqXeo1TCsZLSvjD+kLVV1TvKlaHS8tUCh2oUyR7fTbv6WHi5H8DLyR0Pnbt9E9/Gcs1j11JX+MWJ7jset2FVDsB5U1LM70AjhXiDiQCtNJzKaqKdMei8zazWS50iMKKeo4m/adWBjG/8ld3fQ7/Hcj6Opkh8xPaCnmgDZovYGavw4Am2tjRqE6G6rPQpS0we5I6lSsKNBP/2FhLmI9fnsBnZC1l1NrASRSX1BK0xf4LYB2Ww3fYQmbbApAUBbWZ/1aQoc2ECKbSK9iW0gfZ8rDggfMw8nzpmEEExl0hU6wtJLymyDV+QGoPx5KwYK/6qAUNJQInUYz8z2ERM/HOI09Zu3jiauFBDtouSIraX/2DDvTf7Lfe1+ihARFSlp64kEMAsjKutNBK2u5oj4H7hQ7zD+BvWLHxMgysOtYYtwggweOrM/k3RndsZ/z3nsGqF0ggct1VLuH2eznDksI+KkZ3Bg0WihQyJ7Z9omgaQAyRDFct+jnJsv2Iza+xIvPei+fpbGNAyFvj0e+TsZoQGcC34/ipGwze651UAEQEAAYkBHwQoAQIACQUCVT6BaAIdAwAKCRCBSuR8IUhU1p5QCAC7pgjOM17Hxwqz9mlGELilYqjzNPUoZt5xslcTFGxj/QWNzu0K8gEQPePnc5dTfumzWL077nxhdKYtoqwm2C6fOmXiJBZx6khBfRqctUvN2DlOB6dFf5I+1QT9TRBvceGzw01E4Gi0xjWKAB6OII
	MAdnPcDVFzaXJdlAAJdjfg/lyJtAyxifflG8NnXJ3elwGqoBso84XBNWWzbc5VKmatzhYLOvXtfzDhu4mNPv/z7S1HTtRguI0NlH5RVBzSvfzybin9hysE3/+r3C0HJ2xiOHzucNAmG03aztzZYDMTbKQW4bQqeD5MJxT68vBYu8MtzfIe41lSLpb/qlwq1qg0iQElBBgBAgAPBQJUdhaZAhsMBQkA7U4AAAoJEIFK5HwhSFTW3YgH/AyJL2rlCvGrkLcas94ND9Pmn0cUlVrPl7wVGcIV+6I4nrw6u49TyqNMmsYam2YpjervJGgbvIbMzoHFCREi6R9XyUsw5w7GCRoWegw2blZYi5A52xe500+/RruG//MKfOtVUotu3N+u7FcXaYAg9gbYeGNZCV70vI+cnFgq0AEJRdjidzfCWVKPjafTo7jHeFxX7Q22kUfWOkMzzhoDbFg0jPhVYNiEXpNyXCwirzvKA7bvFwZPlRkbfihaiXDE7QKIUtQ10i5kw4C9rqDKwx8F0PaWDRF9gGaKd7/IJGHJaac/OcSJ36zxgkNgLsVX5GUroJ2GaZcR7W9Vppj5H+C4UgRkuRyTEwgqhkjOPQMBBwIDBOySomnsW2SkApXv1zUBaD38dFEj0LQeDEMdSE7bm1fnrdjAYt0f/CtbUUiDaPodQk2qeHzOP6wA/2K6rrjwNIWJAT0EGAEIACcDGyAEFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmWoM/gFCQSxfmUACgkQgUrkfCFIVNZhTgf/VQxtQ5rgu2aoXh2KOH6naGzPKDkYDJ/K7XCJAq3nJYEpYN8G+F8mL/ql0hrihAsHfjmoDOlt+INa3AcG3v0jDZIMEzmcjAlu7g5NcXS3kntcMHgw3dCgE9eYDaKGipUCubdXvBaZWU6AUlTldaB8FE6u7It7+UO+IW4/L+KpLYKs8V5POInu2rqahlm7vgxY5iv4Txz4EvCW2e4dAlG
	8mT2Eh9SkH+YVOmaKsajgZgrBxA7fWmGoxXswEVxJIFj3vW7yNc0C5HaUdYa5iGOMs4kg2ht4s7yy7NRQuh7BifWjo6BQ6k4S1H+6axZucxhSV1L6zN9d+lr3Xo/vy1unzA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 16:44 +0000, Jon Hunter wrote:
> Hi James,
>=20
> On 07/01/2025 21:31, James Bottomley wrote:
> > Hibernation allows other OSs to boot and thus the variable state
> > might
> > be altered by the time the hibernation image is resumed.=C2=A0 Resync
> > the
> > variable state by looping over all the dentries and update the size
> > (in case of alteration) delete any which no-longer exist.=C2=A0 Finally=
,
> > loop over all efi variables creating any which don't have
> > corresponding dentries.
> >=20
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > ---
> > =C2=A0 fs/efivarfs/internal.h |=C2=A0=C2=A0 3 +-
> > =C2=A0 fs/efivarfs/super.c=C2=A0=C2=A0=C2=A0 | 151
> > ++++++++++++++++++++++++++++++++++++++++-
> > =C2=A0 fs/efivarfs/vars.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> > =C2=A0 3 files changed, 155 insertions(+), 4 deletions(-)
>=20
> ...
> =C2=A0=20
> > +static int efivarfs_pm_notify(struct notifier_block *nb, unsigned
> > long action,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *ptr)
> > +{
> > +	struct efivarfs_fs_info *sfi =3D container_of(nb, struct
> > efivarfs_fs_info,
> > +						=C2=A0=C2=A0=C2=A0 pm_nb);
> > +	struct path path =3D { .mnt =3D NULL, .dentry =3D sfi->sb-
> > >s_root, };
> > +	struct efivarfs_ctx ectx =3D {
> > +		.ctx =3D {
> > +			.actor	=3D efivarfs_actor,
> > +		},
> > +		.sb =3D sfi->sb,
> > +	};
> > +	struct file *file;
> > +	static bool rescan_done =3D true;
> > +
> > +	if (action =3D=3D PM_HIBERNATION_PREPARE) {
> > +		rescan_done =3D false;
> > +		return NOTIFY_OK;
> > +	} else if (action !=3D PM_POST_HIBERNATION) {
> > +		return NOTIFY_DONE;
> > +	}
> > +
> > +	if (rescan_done)
> > +		return NOTIFY_DONE;
> > +
> > +	pr_info("efivarfs: resyncing variable state\n");
> > +
> > +	/* O_NOATIME is required to prevent oops on NULL mnt */
> > +	file =3D kernel_file_open(&path, O_RDONLY | O_DIRECTORY |
> > O_NOATIME,
> > +				current_cred());
> > +	if (!file)
> > +		return NOTIFY_DONE;
> > +
> > +	rescan_done =3D true;
> > +
> > +	/*
> > +	 * First loop over the directory and verify each entry
> > exists,
> > +	 * removing it if it doesn't
> > +	 */
> > +	file->f_pos =3D 2;	/* skip . and .. */
> > +	do {
> > +		ectx.dentry =3D NULL;
> > +		iterate_dir(file, &ectx.ctx);
> > +		if (ectx.dentry) {
> > +			pr_info("efivarfs: removing variable
> > %pd\n",
> > +				ectx.dentry);
> > +			simple_recursive_removal(ectx.dentry,
> > NULL);
> > +			dput(ectx.dentry);
> > +		}
> > +	} while (ectx.dentry);
> > +	fput(file);
> > +
> > +	/*
> > +	 * then loop over variables, creating them if there's no
> > matching
> > +	 * dentry
> > +	 */
> > +	efivar_init(efivarfs_check_missing, sfi->sb, false);
> > +
> > +	return NOTIFY_OK;
> > +}
>=20
>=20
> With the current mainline I have observed the following crash when
> testing suspend on one of our Tegra devices ...
>=20
> rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Feb 28 16:25:55
> 2025
> [=C2=A0 246.593485] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000068
> [=C2=A0 246.602601] Mem abort info:
> [=C2=A0 246.602603]=C2=A0=C2=A0 ESR =3D 0x0000000096000004
> [=C2=A0 246.602605]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32=
 bits
> [=C2=A0 246.602608]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
> [=C2=A0 246.602610]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
> [=C2=A0 246.602612]=C2=A0=C2=A0 FSC =3D 0x04: level 0 translation fault
> [=C2=A0 246.602615] Data abort info:
> [=C2=A0 246.602617]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0=
x00000000
> [=C2=A0 246.634959]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess=
 =3D 0
> [=C2=A0 246.634961]=C2=A0=C2=A0 GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0,=
 Xs =3D 0
> [=C2=A0 246.634964] user pgtable: 4k pages, 48-bit VAs,
> pgdp=3D0000000105205000
> [=C2=A0 246.634967] [0000000000000068] pgd=3D0000000000000000,
> p4d=3D0000000000000000
> [=C2=A0 246.634974] Internal error: Oops: 0000000096000004 [#1] PREEMPT
> SMP
> [=C2=A0 246.665796] Modules linked in: qrtr bridge stp llc usb_f_ncm
> usb_f_mass_storage usb_f_acm u_serial usb_f_rndis u_ether
> libcomposite tegra_drm btusb btrtl drm_dp_aux_bus btintel cec nvme
> btmtk nvme_core btbcm drm_display_helper bluetoot
> h snd_soc_tegra210_admaif drm_client_lib snd_soc_tegra210_dmic
> snd_soc_tegra186_asrc snd_soc_tegra210_mixer snd_soc_tegra_pcm
> snd_soc_tegra210_mvc snd_soc_tegra210_ope snd_soc_tegra210_adx
> snd_soc_tegra210_amx snd_soc_tegra210_sfc snd_soc
> _tegra210_i2s drm_kms_helper ecdh_generic tegra_se ucsi_ccg ecc
> snd_hda_codec_hdmi typec_ucsi snd_soc_tegra_audio_graph_card
> snd_soc_tegra210_ahub rfkill tegra210_adma snd_hda_tegra
> crypto_engine snd_soc_audio_graph_card typec snd_hda_cod
> ec snd_soc_simple_card_utils tegra_aconnect arm_dsu_pmu
> snd_soc_rt5640 snd_hda_core tegra_xudc ramoops phy_tegra194_p2u
> snd_soc_rl6231 at24 pcie_tegra194 tegra_bpmp_thermal host1x
> reed_solomon lm90 pwm_tegra ina3221 pwm_fan fuse drm backl
> ight dm_mod ip_tables x_tables ipv6
> [=C2=A0 246.756182] CPU: 9 UID: 0 PID: 1255 Comm: rtcwake Not tainted
> 6.14.0-rc4-g8d538b296d56 #61
> [=C2=A0 246.764677] Hardware name: NVIDIA NVIDIA Jetson AGX Orin Develope=
r
> Kit/Jetson, BIOS 00.0.0-dev-main_88214_5a0f5_a213e 02/26/2025
> [=C2=A0 246.776569] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [=C2=A0 246.783718] pc : efivarfs_pm_notify+0x48/0x180
> [=C2=A0 246.788285] lr : blocking_notifier_call_chain_robust+0x78/0xe4
> [=C2=A0 246.794286] sp : ffff800085cebb60
> [=C2=A0 246.797684] x29: ffff800085cebb60 x28: ffff000093f1b480 x27:
> 0000000000000000
> [=C2=A0 246.805021] x26: 0000000000000004 x25: ffff8000828d3638 x24:
> 0000000000000003
> [=C2=A0 246.812355] x23: 0000000000000000 x22: 0000000000000005 x21:
> 0000000000000006
> [=C2=A0 246.819694] x20: ffff000087f698c0 x19: 0000000000000003 x18:
> 000000007f19bcda
> [=C2=A0 246.827029] x17: 00000000c42545a5 x16: 000000000000001c x15:
> 000000001709e0a9
> [=C2=A0 246.834372] x14: 00000000ac6b3a37 x13: 18286bf36c021b08 x12:
> 00000039694cf81c
> [=C2=A0 246.841713] x11: 00000000f1e0faad x10: 0000000000000001 x9 :
> 000000004ff99d57
> [=C2=A0 246.849046] x8 : 00000000bb51f9d6 x7 : 00000001f4d4185c x6 :
> 00000001f4d4185c
> [=C2=A0 246.856382] x5 : ffff800085cebb58 x4 : ffff800080952930 x3 :
> ffff8000804cba44
> [=C2=A0 246.863713] x2 : 0000000000000000 x1 : 0000000000000003 x0 :
> ffff8000804cbf84
> [=C2=A0 246.871045] Call trace:
> [=C2=A0 246.873550]=C2=A0 efivarfs_pm_notify+0x48/0x180 (P)
> [=C2=A0 246.878119]=C2=A0 blocking_notifier_call_chain_robust+0x78/0xe4
> [=C2=A0 246.883753]=C2=A0 pm_notifier_call_chain_robust+0x28/0x48
> [=C2=A0 246.888852]=C2=A0 pm_suspend+0x138/0x1c8
> [=C2=A0 246.892438]=C2=A0 state_store+0x8c/0xfc
> [=C2=A0 246.895931]=C2=A0 kobj_attr_store+0x18/0x2c
> [=C2=A0 246.899791]=C2=A0 sysfs_kf_write+0x44/0x54
> [=C2=A0 246.903553]=C2=A0 kernfs_fop_write_iter+0x118/0x1a8
> [=C2=A0 246.908113]=C2=A0 vfs_write+0x2b0/0x35c
> [=C2=A0 246.911608]=C2=A0 ksys_write+0x68/0xfc
> [=C2=A0 246.915013]=C2=A0 __arm64_sys_write+0x1c/0x28
> [=C2=A0 246.919038]=C2=A0 invoke_syscall+0x48/0x110
> [=C2=A0 246.922897]=C2=A0 el0_svc_common.constprop.0+0x40/0xe8
> [=C2=A0 246.927731]=C2=A0 do_el0_svc+0x20/0x2c
> [=C2=A0 246.931127]=C2=A0 el0_svc+0x30/0xd0
> [=C2=A0 246.934265]=C2=A0 el0t_64_sync_handler+0x144/0x168
> [=C2=A0 246.938737]=C2=A0 el0t_64_sync+0x198/0x19c
> [=C2=A0 246.942505] Code: f9400682 f90027ff a906ffe2 f100043f (f9403440)
> [=C2=A0 246.948767] ---[ end trace 0000000000000000 ]---
>=20
>=20
> Bisect is pointing to this commit. I had a quick look at this and the
> following fixes it for me ...

Yes, this occurs because the notifier can be triggered before the
superblock information is filled.  Ard fixed this:

https://web.git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=
=3Durgent&id=3Dcb6ae457bc6af58c84a7854df5e7e32ba1c6a715

Regards,

James


