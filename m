Return-Path: <linux-fsdevel+bounces-14370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718D87B456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DD91F20F59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F9D59B53;
	Wed, 13 Mar 2024 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h1vicywa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27659B4E
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368918; cv=none; b=uoaZiiydEg+KvbDrOLQEBxspOqFuV/5lWJruQCkAp/o7ZlfAzWkW5i5zAiDXz27942H3mvi4SxPOQ9zLalydWI6jcB7v+KjcYVZYorKlL8Y7ODJMEJlTmYpisjuF49ox1qdx3P2T31xWg2rA79nukoMrL4OK1rDMZtymJ6Enn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368918; c=relaxed/simple;
	bh=6go02WlJtTue778mcLSmWnZN+B1PNTU48wUP/tuJq0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY/CgFjIHVOA2mqj0jZ7hp1pqBfjBO00majHO1kiZRjOx78WOW3rVSUx0gFEQxD05VfcmXnFReUMD4hebZfTXxEszdW+6X5iJGbjdrA/0KAQ7i7BoCyh++wiqK5epxBhdJX+BIc/H0YnlRTrNzuThYXaSD7G9s1+jY26sKP7d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h1vicywa; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Mar 2024 18:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710368915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yxehdtefXWXpoBrqnT3MjFzIdHUAXNZvJXs5oHqM2bk=;
	b=h1vicywahpKGXi9bcfgdtjH8MDr4zY9mei3QxjN7YaA6p/oodIYmI1XpZVOSMHVf2fJ1hf
	ct2zEd3nlYcQ5PuUTrQGbZOrBuU68HDWpAumn70TqIhE8S707fJZaY5l332PVmb+Uqebhk
	XfGwT5rWx6ej5GpglYfvcYJKCbAvpKY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.9
Message-ID: <4q5fetc7qwunhhvieuiubk3g3guc4mr4a5wfmn5u4ox6kyo4p7@olyanpabfvav>
References: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
 <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com>
 <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
 <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
 <hbncybkxmlxqukxvfcxcnlc53nrna3hawykbovq3h3u5xpm7iy@6ay4wjnpuqs4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hbncybkxmlxqukxvfcxcnlc53nrna3hawykbovq3h3u5xpm7iy@6ay4wjnpuqs4>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 13, 2024 at 06:22:57PM -0400, Kent Overstreet wrote:
> On Wed, Mar 13, 2024 at 02:51:38PM -0700, Linus Torvalds wrote:
> > On Wed, 13 Mar 2024 at 14:34, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > I liked your MAD suggestion, but the catch was that we need an
> > > exponentially weighted version,
> > 
> > The code for the weighted version literally doesn't change.
> 
> Well, no, and there's another problem I can't believe I missed until
> now. MAD is defined as median of the absolute deviations, not mean, and
> you can't compute a median incrementally.
> 
> So MAD doesn't work here at all.

Sorry, you were talking about mean absolute deviation; that does work
here.

