Return-Path: <linux-fsdevel+bounces-48566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29755AB10E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DD0521590
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813728ECD1;
	Fri,  9 May 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9voHfwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAFA28E57C;
	Fri,  9 May 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787116; cv=none; b=l/BcmHe65ULQCTz83L8R8n/Mv7eOPZUPF4iG2WIjZNsEf7TvxZOoFnwBCgm2zsc6KTujZizwNn3fjLHytvN7jGLaAK+7PQFCuzOxuD+0rgtlRF8Ie4NlQgN9IbPrPE5F2eB9vrC34jUuiZSQryj+4NqIaPVMw4tPWc3mxUO/Gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787116; c=relaxed/simple;
	bh=sBAbm4SuIn80Cm4grT8hVNMovldKiFgkvskTMNgDNrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXvuF4J/oUU6tGXxF3nmzcW0UNGTqwiwMg+Fo/JNvMBzX432bjYDbGEruB5y4NHX1TqP6sogzK2067cwKsGwNDZfHCkxt1OQjXs+M8fYsMu1V+T7KsRs8XgxjIcoiP6kgFGK19uIqTiRnB8WmJlzIuiZ3CT5qroOoDdP39DKB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9voHfwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAADC4CEE4;
	Fri,  9 May 2025 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746787115;
	bh=sBAbm4SuIn80Cm4grT8hVNMovldKiFgkvskTMNgDNrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9voHfwXIYBm9ZoVTNUKI4aXHk8tHvdyYI7H7DhWWk8DHI46p6dlhgF/RepjGNUcA
	 y9CLB+QL3xJhroEHfmo4PZtgm6v034kFYf6dgGj2iF0iWl+qzXAR/H3PurU+qAf5gJ
	 AbZeX9Ct9RENXJGlEd/Gcq5qcwEiHf5KXBV032PYoFeT0vBTSewXiuTZfnGCSzzCPV
	 v1ZdPBTerq51/w6f+IWETxcXpPDTlkxrdC/cg5DnQiomxEy/s7wwVFkdrrulJgFCpt
	 6m6ATTlsszvFJKfs7qYHoDmhLflphfOwy5et17ZrBYYeFIjF31Qz2q1uWWTY6A07UJ
	 rbb6/we/YLjRA==
Date: Fri, 9 May 2025 12:38:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH] fs: allow nesting with FREEZE_EXCL
Message-ID: <20250509-unzucht-gestundet-8633defb4c9e@brauner>
References: <ilwyxf34ixfkhbylev6d76tz5ufzg2sdxxhy6i3tr4ko5dbefr@57yuviqrftzr>
 <20250404-work-freeze-v1-1-31f9a26f7bc9@kernel.org>
 <m2bvkh2v56akvvomku4w6n4lbw3zkc2awlutijndb7cc3tuirz@o64zcabrekch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m2bvkh2v56akvvomku4w6n4lbw3zkc2awlutijndb7cc3tuirz@o64zcabrekch>

On Wed, May 07, 2025 at 01:18:34PM +0200, Jan Kara wrote:
> On Fri 04-04-25 12:24:09, Christian Brauner wrote:
> > If hibernation races with filesystem freezing (e.g. DM reconfiguration),
> > then hibernation need not freeze a filesystem because it's already
> > frozen but userspace may thaw the filesystem before hibernation actually
> > happens.
> > 
> > If the race happens the other way around, DM reconfiguration may
> > unexpectedly fail with EBUSY.
> > 
> > So allow FREEZE_EXCL to nest with other holders. An exclusive freezer
> > cannot be undone by any of the other concurrent freezers.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> This has fallen through the cracks in my inbox but the patch now looks good
> to me. Maybe we should fold it into "fs: add owner of freeze/thaw" to not
> have strange intermediate state in the series?

Done.

