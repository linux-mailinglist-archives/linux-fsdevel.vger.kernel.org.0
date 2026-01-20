Return-Path: <linux-fsdevel+bounces-74568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72334D3BE5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 05:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B47B8355A4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 04:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8D347FFA;
	Tue, 20 Jan 2026 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQPAMc66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3545345753
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883244; cv=none; b=e0l6B4sT61lAt7WBfKipWaMRQA4DIclryYfZ7RGu7XDQIB2mTtCSsAjCruOuDfAA5ot6h7pBtUkC5CWk0Ej215IRoVXZBFpdcaiwcN6KbAsj4j5emypy/BbptZF1B0UbvgV9oZ0zhvs08R0G0MOaVkYvpSR4N2RdVn1rWxefydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883244; c=relaxed/simple;
	bh=xs/PHx070j//uMlDdcx5aTr3e2to9BJLJE8Lurv3BO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNuVahJN1QGzl14pjJgrAd98mFGoUB0UGQZlmPb++K/M2ainEAVhdMGY4FZB1MMXU9xu8+aEj32pUhCpym5UWy4Tormnh0j6u1w2jhsSFuga7nhpqBJ4+29TIouIPJz0qvIa1t6/0gDHCHRRs/WHIZayWywi/O9o+4m6nOBr1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQPAMc66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67ABC2BCAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768883242;
	bh=xs/PHx070j//uMlDdcx5aTr3e2to9BJLJE8Lurv3BO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uQPAMc66NeGWtI+DKobi5AdF+AFnHR2mIl4R137TLuAiv29N+E5+wyFIXkf6Vq+Ea
	 YSWUBdt8gi08SsXylAkCvd+SD6is/VdG7Jh+8cVW67PcLLZW2mJHfYHuiJyeGEkSjm
	 9SgonUh4RiSiBZA8x5w/wBkHwX4OoqI0jkLYQ6d8EyeDTw79rm3SlkqJoZw5SleD9v
	 K72q4aOHPX/EGzQh4DXUHlzFBJkDyqbBosIq0wS/MdP6Ewsr9GrW36hXBZEG11MANp
	 kjMnqVnR708ZWAzAevR1ZcsLFWm/zZRPI6EQvyaBkNvdD+xdSMQbVIJRonRaac1k4N
	 pl2pXnmfPxwMg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b87003e998bso1014136266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 20:27:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKAIMFJ/GfAHhvtJO9EGn0TIo6r0k099O+KeyhsKFtvnFZs55C+3dPqui6PRdsYVGglzVyeHdCUqN8mtDE@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtvG4UmiHHZz4Cv5iHLQTp7FnzXEpTdEFsi/N/6YSADOe5MFw
	M8LgKQgL9L/Y4MFIeKPX3+2rGDeBxulTpqFixCFfwBx9VTZTRtQaeWjQQMMYjlLLRTrWfoWL0rz
	FJlV69EhWFrFrw7qEklN4S9JwDoSJ4TI=
X-Received: by 2002:a17:906:6a1e:b0:b71:60a3:a8b9 with SMTP id
 a640c23a62f3a-b8793a5bf69mr1351344866b.29.1768883241261; Mon, 19 Jan 2026
 20:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-14-linkinjeon@kernel.org>
 <20260116093025.GD21396@lst.de> <CAKYAXd9dz_OBkMWcS5OtfU0BhEA1r4hMqtWJ_u+qWYK4Nwk+7Q@mail.gmail.com>
 <20260119071923.GE1480@lst.de>
In-Reply-To: <20260119071923.GE1480@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Jan 2026 13:27:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_07=0fPd4As1HajY-Q_Uvkqm6LLvri6=wzTV833=RB-g@mail.gmail.com>
X-Gm-Features: AZwV_QhqMkfRprqk26v3KgTJBYY6Tnh210JA5ANvPguia0mkyBaPwjo5GIPQ4ZE
Message-ID: <CAKYAXd_07=0fPd4As1HajY-Q_Uvkqm6LLvri6=wzTV833=RB-g@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] ntfs: add Kconfig and Makefile
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:19=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 18, 2026 at 02:08:01PM +0900, Namjae Jeon wrote:
> > > > +
> > > > +       If you don't know what Access Control Lists are, say N.
> > >
> > > This looks like a new feature over the old driver.  What is the
> > > use case for it?
> > The POSIX ACLs support is intended to ensure functional parity and ABI
> > compatibility with the existing ntfs3 driver, which already supports
> > this feature. Since this ntfs aims to be a replacement for ntfs3,
> > providing the same mount options and permission model is essential for
> > a seamless user transition.
>
> Can you make this more clear in the help text?
Sure, I'll update it.
>
>
> > Furthermore, By enabling this feature, we can pass more xfstests test
> > cases.
>
> Passing more tests only really matters when they were failing before,
> and lack of Posix ACL code should not lead to failures - if it does
> we need to improve feature detection in xfstests.
I agreed. and xfstests already handles acl detection correctly..

Thanks!
>

