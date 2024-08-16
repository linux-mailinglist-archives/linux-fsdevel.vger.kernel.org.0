Return-Path: <linux-fsdevel+bounces-26146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120995509F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 20:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CDE1C21791
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB3A1BDABA;
	Fri, 16 Aug 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Yi38N/C3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078516EC0E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832149; cv=none; b=bjMRPzXjyiBfrD5U8INxwKq2R4xrTGBYrMB1QH/XWBAhdZdLA7qimRXtYzuqS6kfVinnoZinwGuKmuPlfw3EDyJAicGuTYuNzieC+Yay35bnExk9p+oQJseYxsNiwZWgYlZqFd87WSIhIbDsqX1i5BjCVvKjCDis0sa7uIeTWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832149; c=relaxed/simple;
	bh=qg3L2xQLZGPbv6ovw7NcX9WlRCUSYQeR/MfvwvTk1LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZdvVxYPAL/kDcraaV5EjH3foYAHOodboB38XaHpYGRxA/ZBj89UNJFr0zFbapTk7ju2GTCuU4Hly85FMA0OJLo/moAZfRcd487rLQ/MOlbHXumGu/nXs9onC5PiDAkACfObtUo7TOL35Ji+AQjXYjlfzofqkzcbx3JFj78fgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Yi38N/C3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FdmsthDnPp0vITnObatTkJj9O2dYOhdAw/MTFNBLHSk=; b=Yi38N/C3oJJnZe80PDcDTi2bPe
	SFq/E+Q6yfw8zzwmaWmzm6E4mh08pD+c86M1zaxYzQuqtzQJvQu123sS7OBOLiVRIOkbewClvi5JU
	k2LLGB/jM/O+0U4pe2eSLb4WPPyG/kqx7UnqLh7aaKUUjMh+fhg2gXgGzPTi3XeAQcb5qSX4HG0Eo
	djosNWCLUibUBIFZ3RjMdeugWmINyt5vPWx0aKqwfqNGivmfLGBhegHWD+TccijcAHmuofMtv/QGO
	DF62NG5P2p/6Y0r7EsyQY56wVXqTJiyTvWtQBekgCvu+ok65X01GvNDytLzuJdcrKIPuRuCliRFRu
	m/468UDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sf1UH-00000002NR7-0KzP;
	Fri, 16 Aug 2024 18:15:45 +0000
Date: Fri, 16 Aug 2024 19:15:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20240816181545.GD504335@ZenIV>
References: <20240816030341.GW13701@ZenIV>
 <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
 <20240816171925.GB504335@ZenIV>
 <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 16, 2024 at 10:55:30AM -0700, Linus Torvalds wrote:
> On Fri, 16 Aug 2024 at 10:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > All it takes, and IMO it's simpler that way.
> 
> Hey, if it' simpler and gives more natural semantics, I obviously
> won't argue against it.
> 
> That said, I do hate your "punch_hole" argument. At least make it a
> 'struct' with start/end, not a random int pointer, ok?
> 
> Oh, and can we please make 'dup_fd()' return an error pointer instead
> of having that other int pointer argument for the error code?

As in https://lore.kernel.org/all/20240812064427.240190-11-viro@zeniv.linux.org.uk/?

Sure, I can separate it from dependency on alloc_fd() calling conventions
(previous patch in that series) and fold it into this one...

