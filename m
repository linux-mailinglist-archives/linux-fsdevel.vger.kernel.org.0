Return-Path: <linux-fsdevel+bounces-45251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C6A754C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5483B2577
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 07:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DFD183CCA;
	Sat, 29 Mar 2025 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A15Amwb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D0EEAA;
	Sat, 29 Mar 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743233662; cv=none; b=jPVVe65mxHwoeZbA9NWKBj4kFuDpZ3UflBcwsf6fy9O50z95g7wuwCstsG4YMFhHPQr3HPyRo0FG6U47ye79lhegjES9obsSB74+Mr463Z42LnShErKWjskNHJ+t8dm4iq2q9TqB79SiCKAgfvuGBdCz7PkNCiL0de1qUbi2JQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743233662; c=relaxed/simple;
	bh=o4j5LCbRbB89ZuEq7Q9Tyu1R9emivmKXvQi65+lOfgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhSeWm5QlxRvmO+BHWKUu7+DGfqcJNTsYSvdv/tP4UKQHLWhi9ArN5JW/OIY40Ac8TbtOFW2F5xPUFo/bDSdDrsKKmv5sX9pBqYQwqjHh3QQfNbRFJnY6Kfrf/3UoAiUgg4mlUA82/uEdGEjgRU9t5JyvwrDJoAVuUEHa6QnjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A15Amwb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD1CC4CEE2;
	Sat, 29 Mar 2025 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743233661;
	bh=o4j5LCbRbB89ZuEq7Q9Tyu1R9emivmKXvQi65+lOfgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A15Amwb3lWUD0JIL9zKa0zgmQRnim7sGofSTgoK1Mu2oRGFkS3wD71V6sSi8vsJXG
	 tCuCS7L/k70dYlhhAjmi7Cj7ae1NyWuo+chuHsqnxqAPLPlZh9P0HXT4HJtP0HNjn/
	 hr1Oj8H+OlOD9Fa+wA49P8b3jaeWTa5RIxcDR1k7TbrjfduzFvGq5LuCobSkX74ltL
	 bs962ouIluQ4t/A+RAa7xfV0ajn2VMYyQmIzFIcFaoNrCtOVv785tAJlaxpgtKOF2Y
	 OEKQigZ/qKQljmn1BB2rce6a5gG7qH/qMiLwe6a7JYXQAeBbYTA+oZxm9ZfpnhInHJ
	 icKxjZo+YwEXg==
Date: Sat, 29 Mar 2025 08:34:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 5/6] super: use common iterator (Part 2)
Message-ID: <20250329-stumpf-pavian-090ff0c7b74f@brauner>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
 <20250328-work-freeze-v1-5-a2c3a6b0e7a6@kernel.org>
 <db131c4abf29ea8205d6e761ac8227f5837540b5.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db131c4abf29ea8205d6e761ac8227f5837540b5.camel@HansenPartnership.com>

On Fri, Mar 28, 2025 at 02:58:29PM -0400, James Bottomley wrote:
> On Fri, 2025-03-28 at 17:15 +0100, Christian Brauner wrote:
> [...]
> > +static inline void super_cb_grabbed(struct super_block *sb,
> > +				    void (*f)(struct super_block *,
> > void *),
> > +				    void *arg)
> > +{
> > +	if (super_lock_excl(sb)) {
> > +		bool active = atomic_inc_not_zero(&sb->s_active);
> > +		super_unlock_excl(sb);
> > +		if (active)
> > +			f(sb, arg);
> > +		deactivate_super(sb);
> 
> I don't think this can be right: if we fail to increment s_active
> because it's zero, we shouldn't call deactivate_super(), should we?

Fixed in-tree. Thanks.

