Return-Path: <linux-fsdevel+bounces-57567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C9B2391E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F2616A816
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993F2FFDD8;
	Tue, 12 Aug 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsdm0+fq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14F2D0C9F
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027523; cv=none; b=AezZjaW20/P8MIb4wtSgQz+DKIKtma0d38tyDaaz6uJ7jfOQms+tctDneopn7O94z9R4YbRF1yuk0U6TX6TXryiIzOYC0DogzkRrL8TtgM7KFTVcJee6KudB9bpJMDDVtT8gGCXhZg988Lkk33O5rjryEbB/G/ph0iVYMjadTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027523; c=relaxed/simple;
	bh=At/Xqxetjeqmv0KaWNHvy0vuSm+AyR8O30HHBGcx1Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ourd96D4VybnesXKFgLWTeDZwRL8DhStYu2v51gfj4a0OSYwR1Z52+VwR2NJxR1k8dvYLAITNGwQfz+g9wI4tkyiWzyHKowspp23J03OakA9fkOM10A4ehaJKJt/Y4ZDLtX13hNzuRAW5y351qZZWUDkLAxZsevIE8Fc2CZ2xYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsdm0+fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54749C4CEF0;
	Tue, 12 Aug 2025 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755027523;
	bh=At/Xqxetjeqmv0KaWNHvy0vuSm+AyR8O30HHBGcx1Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zsdm0+fq45atL1k+16ZdLGo3RbxLXFQs4H3lp0kvDbL65sQyReQ0CSQDlgEUhhwOl
	 4dmkadjMos+/xuitmssciKRoz5/ZLnyQ73MJ+3FvZwKIoUeUw+Z5aTRpwNMtoAvWDX
	 S8oSh/kOscdfzFBlrf9Fnatz+kp0ONf9l4b4Nm03img6IYpAUOuRB6ty7wvYYCVrla
	 vulsKquUSZuTeoQ62a5XNvb3vZxm6s7OJmOFlayuwvcZffRBSo+ym34vTc92fOuxPg
	 BsqrquTCi1LdorgTlB22CRyVF2nE0BeVbx40aOUQSvG0iiG40z6JwtSuXdAOrN/Lke
	 JruECxS44kCaA==
Date: Tue, 12 Aug 2025 12:38:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com, bernd.schubert@fastmail.fm,
	willy@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
Message-ID: <20250812193842.GJ7942@frogsfrogsfrogs>
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
 <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
 <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>

On Tue, Aug 12, 2025 at 01:13:57PM +0200, Miklos Szeredi wrote:
> On Mon, 11 Aug 2025 at 23:13, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 1:43 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > Large folios are only enabled if the writeback cache isn't on.
> > > (Strictlimiting needs to be turned off if the writeback cache is used in
> > > conjunction with large folios, else this tanks performance.)
> 
> Is there an explanation somewhere about the writeback cache vs.
> strictlimit issue?

and, for n00bs such as myself: what is "strictlimit"? :)

--D

> Thanks,
> Miklos
> 

