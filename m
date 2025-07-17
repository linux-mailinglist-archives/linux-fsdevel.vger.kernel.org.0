Return-Path: <linux-fsdevel+bounces-55280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F8CB09395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08AF1C476B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12602FD88C;
	Thu, 17 Jul 2025 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JGPomn6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5D28507C
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774593; cv=none; b=MEjgolF5MCec4rPadTjpwCvnsG9Hqq9YqvPK+1pN8bdSZgJ2iaayFvr4Pj3uK3H9ji4x+nm5OiEPJnA5oSbVukIS+RCVqYEuAqBCSXrY5q0pxxyKNZ+Q0OAWacFJFkIl+wYwwO+SRjL+gTiS41pL/a8dTtmWBPg6gvBPXULXuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774593; c=relaxed/simple;
	bh=kHaL02DxlO/amJ1+zcxcVlYqQFj3gNvSuHST674g1bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny3qsUFHaA2uGOrEfoqtzpEYy3mloc7uq48y/s3ApmLd4IbCW9dtfGtGbQGzOXNKqhfCYTt3NT7pGzqnZQDEILwAtVWN31ZRDsEGc4+Xc43vXjhJtZ68g1132Yd6v6krCqW9ukfaNnhgGHP78khKvgfFT6st/T9Jdb6iW0Qe9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JGPomn6k; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bjg3y4pLszxMF;
	Thu, 17 Jul 2025 19:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752773566;
	bh=FhUZljpV3e7kXgQWDft7JJeqq7WQKJ1k9+cgRe3Jnto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGPomn6khu/S+EtuC5HlQ43KacCkMVJV4ES8is4YXgIOR9My9wLU8Cx3CEkr1k8HF
	 HZnIGq5s/vmaCHc07QfC23oSBkMvJyTIAgQm4pIHQ8qGWAUPDAdmSihNxZwBy1Pb8F
	 5kg8fEI+Ux7MtVUvBd4xQAj+mstoB8p0YLb/TyF4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bjg3x5rsfz97W;
	Thu, 17 Jul 2025 19:32:45 +0200 (CEST)
Date: Thu, 17 Jul 2025 19:32:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>, 
	Christian Brauner <brauner@kernel.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, NeilBrown <neil@brown.name>, 
	Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/3] landlock: Fix handling of disconnected directories
Message-ID: <20250717.aeCheichee0i@digikod.net>
References: <20250711191938.2007175-1-mic@digikod.net>
 <20250711191938.2007175-2-mic@digikod.net>
 <4d23784f-03de-4053-a326-96a0fa833456@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d23784f-03de-4053-a326-96a0fa833456@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Jul 14, 2025 at 01:39:12PM +0100, Tingmao Wang wrote:
> On 7/11/25 20:19, Mickaël Salaün wrote:
> > [...]
> > @@ -800,6 +802,8 @@ static bool is_access_to_paths_allowed(
> >  		access_masked_parent1 = access_masked_parent2 =
> >  			landlock_union_access_masks(domain).fs;
> >  		is_dom_check = true;
> > +		memcpy(&_layer_masks_parent2_bkp, layer_masks_parent2,
> > +		       sizeof(_layer_masks_parent2_bkp));
> >  	} else {
> >  		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
> >  			return false;
> > @@ -807,6 +811,8 @@ static bool is_access_to_paths_allowed(
> >  		access_masked_parent1 = access_request_parent1;
> >  		access_masked_parent2 = access_request_parent2;
> >  		is_dom_check = false;
> > +		memcpy(&_layer_masks_parent1_bkp, layer_masks_parent1,
> > +		       sizeof(_layer_masks_parent1_bkp));
> 
> Is this memcpy meant to be in this else branch?  If parent2 is set, we
> will leave _layer_masks_parent1_bkp uninitialized right?

Good catch!  We should always initialize _layer_masks_parent1_bkp.
I'll move both _layer_masks_parent*_bkp initializations just before the
related allowed_parent* initialization.

> 
> >  	}
> >  
> >  	if (unlikely(dentry_child1)) {

