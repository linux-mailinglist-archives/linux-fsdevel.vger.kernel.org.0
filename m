Return-Path: <linux-fsdevel+bounces-74567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071ED3BE5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 05:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB6B34E9B16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 04:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4FC346760;
	Tue, 20 Jan 2026 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DktcV8dI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8583D346AC9
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883227; cv=none; b=YTGkyO5UU4NGqHrtvWluaWpS5tSuyDVwFLnlZ0+EBN5y/ZbRSCsz8SKIhiOn0S2Mh7pG3PILTSAxfobXGaqgA8AILu9QWc/oC0BHzcBSjeYiPa3L3aHcFvGIa8EOjUFxU2BgyAdO2b62TCjgSCTqHD01VzyleaBMMZ+Lw9FEjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883227; c=relaxed/simple;
	bh=X8FU8ogecwf8kjTfYDVyXu0MV1R3qua7Wh94im77YgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+cF67Px5POzSM+9yN1NXfJpzcS4+Ow5T32MdOTs7M3oA+/f/4o8Mx3CbkfpVhRnFA663zrrW2GayMUh1A/VllndJ0KjegZgIOWXHXop+qkiLhqWpMeILb5fvWg7ASNU7P4IOhhvYaVEmNSNuN8T22dstuLaYMIHSEGYhGyw9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DktcV8dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE48BC2BCB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768883223;
	bh=X8FU8ogecwf8kjTfYDVyXu0MV1R3qua7Wh94im77YgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DktcV8dIC2hUNaAFjcwhetaIgTfxZVEXn0eLg4al26Lc0TMIxCbGX8s6qbVFCHZqD
	 d6UKJydxr9n8ug7I1EspFsS4t7VRYagpz0y8dS0S0nlxYSiwOn4GiNWV9PZWyX+XGr
	 Rl2hzFyDooL/W5ZPj9v5Zk3VTmP8H1D08gJYUgIfUxVHJmnTiB4qBF74BsaInkm5CD
	 vcpHpRr18+tppIX1pEPvwelqiNq+hAWwiL+zJXDnuYHU96pvKEt+Kko82OXfGdFaUC
	 6xPdYdtDElLGZIw4wADIbVSAruXTVaCjq488hLP3DLS/53HO5gfLadznRFPBwzmyIb
	 +ucUWleA3i5tw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so7771069a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 20:27:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPmOMLg+kP34nvNKXup4y9+UL4dh60+xQN6BhS7fHa6QlgWMQP/mrRJl9QCIu01HDATc9lf3kekBSNPNRQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3vFFz6ChpIelk2jBF82q/Io49EIUtFUQnigWyxj+FNdMlJQl
	nUmPAhCxp5ti0R2KLNrXGYh58mOSz2H6RGEd5DQfCM3nh3xXuh6lVGYvsZn28QPYXlOngvuNjuC
	UyRpeVg/GLGXRre8aWfLnlxjzauSKdAY=
X-Received: by 2002:a05:6402:1471:b0:64d:1a1:9dee with SMTP id
 4fb4d7f45d1cf-654bb32c9d0mr11200711a12.16.1768883222139; Mon, 19 Jan 2026
 20:27:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260116093348.GA22781@lst.de>
 <CAKYAXd9CXj5hZ2zoiyEgrBWA6NB1u2VrBEcOGCwCPCSZODzp6w@mail.gmail.com> <20260119070254.GA1480@lst.de>
In-Reply-To: <20260119070254.GA1480@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Jan 2026 13:26:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_NzRz3n3yBo_6OSE4M9mT2M+y9Tspb5t1KJSpjBniJ9Q@mail.gmail.com>
X-Gm-Features: AZwV_QgziZ7A7ONQCvO75eAjUjPtmXOfHDnfHWr5bfzqFEnAjV3S47RUPGTnyRo
Message-ID: <CAKYAXd_NzRz3n3yBo_6OSE4M9mT2M+y9Tspb5t1KJSpjBniJ9Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ntfs filesystem remake
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:03=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 18, 2026 at 02:19:51PM +0900, Namjae Jeon wrote:
> > > I'm not sure how many tests are actually run for the ntfs variants
> > > because they lack features needed for many tests, but how many still
> > > fail with this, because with these numbers I suspect there's quite
> > > a few left. Do you have any good grasp why they are failing, i.e.
> > > assumptions in xfsteasts, or missing feature checks?
> > Regarding the xfstests results, many of the 'Not Run' cases are due to
> > fundamental differences in the NTFS architecture. For instance, NTFS
> > does not support certain advanced features like reflink, which causes
> > many tests to be skipped. Also, ntfs does not yet support journaling,
> > leading to failures in tests that assume journal-based consistency.
> > I am currently categorizing these failures to distinguish between
> > NTFS-inherent limitations and areas for future improvement. I will
> > provide a detailed breakdown and analysis of these test results in the
> > cover letter on next version.
>
> Not run is totally fine.  We have plenty of them even for native
> file systems, and having even more for foreign file system support
> is just fine.  What I meant to say is the number of failing tests
> is the much more interesting metric, so maybe you can share that?
Yes, I will share that.
Thanks!
>

