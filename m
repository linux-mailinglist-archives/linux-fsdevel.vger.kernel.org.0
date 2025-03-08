Return-Path: <linux-fsdevel+bounces-43525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB70A57D90
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA4E7A8085
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6D197A76;
	Sat,  8 Mar 2025 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Uo+pXjYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005315E5DC
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741460238; cv=none; b=P77YkXNoCgAWx5DzE/6petNVrNyESeBjqBAjhq5S2kksnIuFCEt/ZdVY5RJ4um6Bckl2KrvbtwdVCNiq5rIMtY92YyDAyWhx9ZXjAMIPCmdR1COdNbyqMRW5V4zdkH+flMcnkcNPXxWgniIunLWF/fOwfBqJt+RdUd50SGIkGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741460238; c=relaxed/simple;
	bh=gukEbJdIrNo8TUJiZWYqSy4aqoaDDcj8Y9luVRYS4Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvxwyMwZ5M3N1+MaV8Al8z272/tw4JpIYGYqcVFl/DJ2QP4tfjR2iyvUXU4IQUdUVyxsxFqYyl9S77Y1Tex/aujgF+fbwXBZurxaQmWczO5nOc2DD3EwA6qTBuCp9VI3Rt7sODAW3eKeOJ6c0g7a7k5ftCWtpVyxWwB5nBeJiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Uo+pXjYW; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9C7t3YB4zV4m;
	Sat,  8 Mar 2025 19:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741460234;
	bh=wN0FXOm2E/56qbhYEzbybQfDtSOz1RXoy+kYKm4jync=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uo+pXjYWr6tOlOaB0PAeSOOHy2v15fZUvnsckilyi0e9fYG4I7LwqN/6QW5Pwc7fZ
	 imkdgwxT3BOTE+pv4h130e+sMI1epOejqwKAEYToW5tIc5Fp0uLhaGK90/LJGyE0Rz
	 VRj1PEwQ704HLsVQqBGZaZ3p0APyObEtBJUaPYrY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9C7s70lLz3Kv;
	Sat,  8 Mar 2025 19:57:13 +0100 (CET)
Date: Sat, 8 Mar 2025 19:57:13 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>, 
	Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 2/9] Refactor per-layer information in rulesets and
 rules
Message-ID: <20250306.aeth4Thaepae@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <6e8887f204c9fbe7470e61876bc597932a8f74d9.1741047969.git.m@maowtm.org>
 <20250304.aiGhah9lohh5@digikod.net>
 <4e0ed692-50e7-4665-962b-3cc1694e441a@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e0ed692-50e7-4665-962b-3cc1694e441a@maowtm.org>
X-Infomaniak-Routing: alpha

On Thu, Mar 06, 2025 at 02:58:01AM +0000, Tingmao Wang wrote:
> On 3/4/25 19:49, Mickaël Salaün wrote:
> 
> > We could indeed have a pointer in the  landlock_hierarchy and have a
> > dedicated bit in each layer's access_masks to indicate that this layer
> > is supervised.  This should simplify the whole patch series.
> 
> That seems sensible.  I did consider using the landlock_hierarchy, but chose
> the current way as it initially seemed more sensible, but on second thought
> this means that we have to carefully increment all the refcounts on domain
> merge etc.  On the other hand storing the supervisor pointer in the
> hierarchy, if we have an extra bit in struct access_masks then we can
> quickly determine if supervisors are involved without effectively walking a
> linked list, which is nice.

Right

> 
> Actually, just to check, is the reason why we have the access_masks FAM in
> the ruleset purely for performance? Initially I wasn't sure if each layer
> correspond 1-to-1 with landlock_hierarchy, since otherwise it seemed to me
> you could just put the access mask in the hierarchy too.

Yes, we could put the access rights in the hierarchy, but that would
involve walking through the hierarchy to know if Landlock should
actually handle (i.e. allow or potentially deny) an access request.
Landlock is designed in a way that makes legitimate/allowed access as
fast as possible (there is still room for improvement though).  In the
case of the supervisor feature, it should mainly be used to dynamically
allow access which are statically denied for one layer.  And because it
will require a round trip to user space anyway, the performance impact
of putting the supervisor pointer in landlock_hierarchy is negligible.

Initially the purpose of landlock_hierarchy was to be able to compare
domains (for ptrace and later scope restrictions), whereas the
landlock_ruleset is to store immutable data (without references) when
used as a domain.  With the audit feature, the landlock_hierarchy will
also contain domain's shared/mutable states and pointers that should
only be rarely accessed (i.e. only for denials).  So, in a nutshell
landlock_ruleset as a domain should stay minimal and improve data
locality to speed up allowed access requests.

We could decorrelate the current content of landlock_hierarchy from the
shared data, but I think it would only be meaningful if this data is
significant (see the landlock_details pointer in the audit patch series).

> In other words, is it right to assume that, if a domain has 3 layers, for
> example, then domain->hierarchy correspond to the third layer,
> domain->hierarchy->parent correspond to the second, and
> d->h->parent->parent would be the first layer's hierarchy?

Yes, that is always the case for a domain.

If we create the supervisor FD with landlock_restrict_self(2), then
we'll not have to add a new pointer to landlock_ruleset, but only
directly to landlock_hierarchy.

