Return-Path: <linux-fsdevel+bounces-65074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EABFABFAE98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 10:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B00B4E28B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57A30AAB3;
	Wed, 22 Oct 2025 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO5pF0Wm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4F1DDDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122035; cv=none; b=klEOe94bk2QR7rQ0wtdkeXw1uI11Z9bO0SlTaIXHyh7IVOS1eel1WPcCSKlkwXPqd4lAjEiToKoKbq8pFsglWX5ypcvvXb94S7IWI5M6UbaMhbozMPhM3CgtV3mIOdFB3IjglS12yctP6q6sHEHkNhHcnL6xHjo1bcXh1AJceUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122035; c=relaxed/simple;
	bh=N9x84jixJiN0AO+xsJ6pTpBphMTYT0uIpmPJoLhxDSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9LKcPJBQUAsYBiIZIoS6SLIdTbwQNl4bCjGnGXKNswc8dirERwbclTR1FhUOG6XKw7r0/+wx+MKXFzoxmIJUibXOyIopZJKtcWJQumVXV+jwVxeqypDKEWEmu+/IFCzzcZQhh3R/HkTKiukUXc+6rrnrmIrf7U5KK+IVPp+0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO5pF0Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D290BC113D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761122034;
	bh=N9x84jixJiN0AO+xsJ6pTpBphMTYT0uIpmPJoLhxDSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pO5pF0WmtQaCE0WwjUdBLjqLYdh73R8FFasRhk4jR7eZSB6bSwp60/Lyqn9QuiR0r
	 KLVmUdhoqbRp5Yr+0poWdbkyZxqaDGwzRPjLjcLnY75px18fYJm0H9R8MitR0BxQ3/
	 B5vtdbZ83d/zi1Hdzul0ErnWJhtBxRt7j1CrxzNpmz1QQC41b0RQhfj/ub1oh2GeFW
	 t5FrJDp/YGea499OumnIgSPC7Pe9vY/tekg43XWxqHJr6fKoq0i6bAQ2FWQQxa7o+u
	 +0DHhEWj+1ONVxvGjQBGGUZdAj5duMdw8aexcYHrFVuumHUkmiycBaEEeYZKOs1zVJ
	 /VwuWoQL5QeZw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b5a8184144dso1078687266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 01:33:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/8ChYRZFeMD+2uPrw/ZyvZg4McAT8BcZ8E7L+rXCd8g9/SikoIDPNID7BNS8Xs1hpsU72zHcqE2Yqo8uJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwNH93EXuZDeKdlgacCu+Wk7wOLuzL2LRlPK+mmgf9mAtAYLjeJ
	WqW6PwzJm8rmKv9yDleaxw7Ss7x72wm/UlSyYhlx0qsNGoN8UkVFi2pEbDbYTKxNgJSQXdAlx3d
	NXIurngzaIU5g9HOoiqu1JypGQNRdslI=
X-Google-Smtp-Source: AGHT+IFN/73b2Yv3ZelKdkLNRTSTloKVEzyFCT+aqYbmXKMileH6B4CRb3anBM9pR9lKV3i9bZOcQvKU7TV7WXabXXg=
X-Received: by 2002:a17:906:ef04:b0:b40:6e13:1a82 with SMTP id
 a640c23a62f3a-b64747339f8mr2198118566b.26.1761122033403; Wed, 22 Oct 2025
 01:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020020749.5522-1-linkinjeon@kernel.org> <20251022063056.GR13776@twin.jikos.cz>
In-Reply-To: <20251022063056.GR13776@twin.jikos.cz>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 22 Oct 2025 17:33:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_LofQsx7p-k8xH23E1gVd2-BUKS3jwKkAWStE2AHJUWQ@mail.gmail.com>
X-Gm-Features: AS18NWAnD3epknggQb4IvzWVRKTSbBuBDwjrEEd0LIHk_qDoG9OjkFG66JcsW9I
Message-ID: <CAKYAXd_LofQsx7p-k8xH23E1gVd2-BUKS3jwKkAWStE2AHJUWQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
To: dsterba@suse.cz
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:31=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Mon, Oct 20, 2025 at 11:07:38AM +0900, Namjae Jeon wrote:
> > The feature comparison summary
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > Feature                               ntfsplus   ntfs3
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > Write support                         Yes        Yes
> > iomap support                         Yes        No
> > No buffer head                        Yes        No
> > Public utilities(mkfs, fsck, etc.)    Yes        No
> > xfstests passed                       287        218
> > Idmapped mount                        Yes        No
> > Delayed allocation                    Yes        No
> > Bonnie++                              Pass       Fail
> > Journaling                            Planned    Inoperative
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> Having two implementations of the same is problematic but I think what
> votes for ntfs+ is that it's using the current internal interfaces like
> iomap and no buffer heads. I'm not familiar with recent ntfs3
> development but it would be good to know if the API conversions are
> planned at all.
>
> There are many filesystems using the old interfaces and I think most of
> them will stay like that. The config options BUFFER_HEAD and FS_IOMAP
> make the distinction what people care about most. In case of ntfs it's
> clearly for interoperability.
>
> As a user I'd be interested in feature parity with ntfs3, eg. I don't
> see the label ioctls supported but it's a minor thing.
I can confirm that achieving full feature parity with ntfs3, including
the label ioctl support, in the next version.
Thanks for your feedback!


> Ideally there's
> one full featured implementation but I take it that it may not be
> feasible to update ntfs3 so it's equivalent to ntfs+. As this is not a
> native linux filesystem swapping the implementation can be fairly
> transparent, depending only on the config options. The drawback is
> losing the history of fixed bugs that may show up again.
>
> We could do the same as when ntfs3 appeared, but back then it had
> arguably better position as it brought full write support. Right now I
> understand it more of as maintenance problem.

