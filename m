Return-Path: <linux-fsdevel+bounces-57335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD3B20883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615D21771C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D25B2D3A98;
	Mon, 11 Aug 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOIGRIIX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95C2D375E;
	Mon, 11 Aug 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914403; cv=none; b=RQB0XbE4wP6R1vDN3R2lkzPhUVcBXkMvrNVW6petlG5lIGa9ob1js4WmgPnn+mMwN/jm4OldE9TYgzz4pYH4n9QsE6GTmD4pgx0fxfOVRgR2A8bNqSczWJOZPLyTaGNBkpSiF+XIhwvUT9xIhruSHoSXdPxixQ96p43ZinAvDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914403; c=relaxed/simple;
	bh=U4/byd7EwnoOC0l4EYzXmiuZ4GMgOMyb4BL8igF7Osk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6ceJ09wrCtMu1bwvlSpnrgsIX2BR+Pr91IeDCY1LpRkNnpWTyHfc1hSVfQ7NImQCWnTCpPHHuehXsMhQFH8qCt5nU8HGX5JPsJPlwzf6QgsWn9W0drl46TPTtZ8Gy4nFWu1TbtH7RobZGETI6LWlSuDNVhWRw6POecsL1W+apA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOIGRIIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E075AC4CEED;
	Mon, 11 Aug 2025 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754914402;
	bh=U4/byd7EwnoOC0l4EYzXmiuZ4GMgOMyb4BL8igF7Osk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOIGRIIXm8NMIZbqzPjQq8N+VKJST/aadbm4wFpY2fP1KFR19MFP0/6FIPEkIZ6TM
	 QbvFMZdXn9R39/bbo/ETbgkrqzYu3zbSHiPAcgYSyD1iWPQ0pPLYTUUbyAICdpwt4d
	 hBSS3tuEqXLmJb/5EPUqNYgM6OtJsVfDxKlndLlmgIGQH90PFpfo6c9RZAoztQGvTK
	 aSRMG6FAsf1mbhL/fK+B/iBJB6O6kJMfhqjnUnw5QoCcHgeH0SZhVD0DGTM4BjpRBy
	 4Dj/o5ZeOA38mPsUS/SFXXnD0kZDobIUyyQeVx4MiszpShuWYB7kD+lZEtKlC1EG7a
	 UFpQJHA5XVTyw==
Date: Mon, 11 Aug 2025 14:13:17 +0200
From: Carlos Maiolino <cem@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, dan.j.williams@intel.com, 
	willy@infradead.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] xfs and DAX atomic writes changes
Message-ID: <o3oukzgqkmduvfsmwwy6hgxz63c37dojuexz6a6h3pdgr5tdue@5zifgr6axpdt>
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
 <IjNvoQKwdHYKQEFJpk3MZtLta5TfTNXqa5VwODhIR7CCUFwuBNcKIXLDbHTYUlXgFiBE24MFzi8WAeK6AletEA==@protonmail.internalid>
 <32397cf6-6c6a-4091-9100-d7395450ae02@oracle.com>
 <rnils56yqukku5j5t22ac5zru7esi35beo25nhz2ybhxqks5nf@u2xt7j4biinr>
 <gKy1Y0TmFIveaTbYHqrtPIDx8-dC7nvIlhVlUw3BOwHrSS_uOaBgSSs-xURb8QsPi1BWGMGvtp6fuvoXWW4Ymw==@protonmail.internalid>
 <a1b9477e-0783-478d-9c64-8522f8554a35@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1b9477e-0783-478d-9c64-8522f8554a35@oracle.com>

On Mon, Aug 11, 2025 at 01:08:59PM +0100, John Garry wrote:
> On 11/08/2025 13:06, Carlos Maiolino wrote:
> >> I was expecting you to pick these up.
> > I did, for -rc1.
> >
> >> Shall I resend next week after v6.17-rc1 is released?
> > No, I already have them queued up for -rc1, no need to send them again
> 
> Great, thanks. I was just prepping to send again :)

Sorry, I meant I have them queued up for -rc2 :-) i.e. this week I'm
sending them to Linus

