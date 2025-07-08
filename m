Return-Path: <linux-fsdevel+bounces-54272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28EEAFCF5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23ECD17DBE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022202E173D;
	Tue,  8 Jul 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1MB8nSP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53985283FCD;
	Tue,  8 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988963; cv=none; b=PjBXd8VEerGU7EpNfBUEwd4dJZH/jbFGNyJx7AK2TUwuce8f6IDHHS1GOp64jAmxQ6LYM6UKdTJhH13QFuPLU9oszliX8XSOZD0vTc3h95xis8q5LJGwDD6FQR4NYOnm/8biMyEZ2Cmey8NzgJi0z5FQf84jHYENsObOBjEe3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988963; c=relaxed/simple;
	bh=I7QL9rgNS99bH4s1/92a15NX0cgi1YBaLnyOoeaECcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY8lUkqaPkS6Fx/2Y6tnd08LoSlrfy0KQX3CNpcNnTffIC7TAlJK0Y/PQUd9EcwDIikb84rKieKFwVv9ZFXyS2BVqowRJ+YWDZ9UVpNgLRkGhM1EXvctVDEfY7HQ1V5ZB1z58eUot/HFlhx1tdz1eUR3U1Z9BK+RyKli9zF+jMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1MB8nSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C0EC4CEED;
	Tue,  8 Jul 2025 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751988962;
	bh=I7QL9rgNS99bH4s1/92a15NX0cgi1YBaLnyOoeaECcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W1MB8nSPYEUZl5bcX47DF6gUX86qgHNuQ+y9I6vRsODULep4AXPYrW0y5fjp7oUdF
	 xxeFXEtCkwX22xdekjuuR+Ut+KUsHTFa3pzOBB+H+wx0nTA/YeiVCN7DMGR0rbG1vg
	 g8qj5HSYBzP/iK5vpLn1eFW7byDP1D9H/hckUMhb9CEYA6XSJSejQ8Gx63L+9Ea+mH
	 HUeBVNRSPOevp4Va8d2THy5fY7BckYZ55BFztXh0765XLOjpD4UWZPtWHco+EKsmKB
	 5+Q2+Ham1Ayu8N/7bOr13l+B1FifyyqRvtHa3ZKT084LyXr4tO6kPh6WfwRG9GmDpZ
	 EGfngc11eBIUw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553d771435fso3755720e87.3;
        Tue, 08 Jul 2025 08:36:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHCTQ6JHU9nxZ7Qku4892NrtZ45P+nQvutuzpqIePGAPJUSeWo6dQlpkh37nsnDubVcWy6E7AXGncE52ty@vger.kernel.org, AJvYcCUS8cWUEQVzSRdu7IsVeUACpobdrETcjPQZJBSzQy6/Vs+uFTJOwdIkbIXITILxhJ30wX9Dat83JMAy3Ffe7w==@vger.kernel.org, AJvYcCX0VBQh7hTnNLTDplcTvF0GLV/Yzvrg/jglHF5PZSC1pP08CCc4d/B6S9m4+vy7ZAjCkmsMd8ic99eSOYKwFg==@vger.kernel.org, AJvYcCXK0wt784YCl8Ij5ayUTcr/+XqHaBQY7SNhYxDruYfxiswx0ec4bErb0fos/A5OUBnDqNgHD4WnvXM=@vger.kernel.org, AJvYcCXfWyV0We4RKRQ47IZ2PU2QAROlmew2yR0hewIten0Zv8hnXJJOv+qL5Nb/v3amoXSOHIIHe+Q9dOO3gTXM@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTUNxcIB3a7FxVcue9n9GVSJrg6XBMhQ6k8CCcwRYflzZ1YJn
	tOci3Vl0LzeELz4YUPFP7ZpTi5d/ybeyt1Hryd3Bpu1ofUXG6faTmKU3lJ/aq91xMdQDa8Rt+gB
	7WDtVZkt4jxrcC3ojz3S+RmWSX0uc+g8=
X-Google-Smtp-Source: AGHT+IFRtLjaJasKpwEwyQ5+WW04Mv6p+1ysxEiZNM3+T5xfDfVpapMUU0ZvsSkmP7MRTMvglMUJAp47OpXNlDRGL1w=
X-Received: by 2002:a05:6512:238e:b0:553:2e4a:bb58 with SMTP id
 2adb3069b0e04-557f82f578amr1243072e87.9.1751988961465; Tue, 08 Jul 2025
 08:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
 <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz> <CAK7LNATpQrHX_8x4WvhDN7cODCCLr8kihydtfM-6wxhY17xtQw@mail.gmail.com>
 <39bed180-e21c-4801-8ac4-ba40b57f6df2@suse.cz>
In-Reply-To: <39bed180-e21c-4801-8ac4-ba40b57f6df2@suse.cz>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 9 Jul 2025 00:35:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATRkZHwJGpojCnvdiaoDnP+aeUXgdey5sb_8muzdWTMkA@mail.gmail.com>
X-Gm-Features: Ac12FXx_7nF2f-9gneX_4uOIrJSstDjyWshpyZ4rVtF2jAmgOIH61VW1BIqcAYY
Message-ID: <CAK7LNATRkZHwJGpojCnvdiaoDnP+aeUXgdey5sb_8muzdWTMkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: Restrict module namespace access to in-tree modules
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 12:08=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/8/25 14:41, Masahiro Yamada wrote:
> > On Tue, Jul 8, 2025 at 4:29=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >>
> >> The module namespace support has been introduced to allow restricting
> >> exports to specific modules only, and intended for in-tree modules suc=
h
> >> as kvm. Make this intention explicit by disallowing out of tree module=
s
> >> both for the module loader and modpost.
> >>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >
> >
> >
> > In my understanding, an external module with the same name
> > can override the internal one.
> >
> > This change disallows such a use-case.
>
> Hmm I'm not familiar with this, but for such cases to be legitimate we ca=
n
> assume the external module has to be derived from the internal one and no=
t
> something completely unrelated impersonating the internal one? So in that
> case just patch 2 alone would be sufficient and not break any legitimate =
use
> cases?
>

IIRC, nvdimm uses this feature for testing.


In-tree drivers:
  drivers/nvdimm/Makefile

Out-of-tree drivers:
  tools/testing/nvdimm/Makefile
  tools/testing/nvdimm/Kbuild




--=20
Best Regards
Masahiro Yamada

