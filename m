Return-Path: <linux-fsdevel+bounces-56433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC57B1749F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 18:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9187AC648
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FFC211A35;
	Thu, 31 Jul 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF2HBVP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD02BD58E;
	Thu, 31 Jul 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977836; cv=none; b=Uxu9W5HD08YxK4KGNyUDlSh2OOTvtBS+njs5gAVKYTyRWkdt4W3aQgRuKS/IbXRBMj8zDdgUryjLw6Jr44AuY/MTrPxiAnS/Tlt8sEcRyrEdLg/szFd1iR8Ly5wvLp1wX03cXLSxdgVy8k5XrXNonma6VdyQi4JDCiWwn9jtXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977836; c=relaxed/simple;
	bh=FoJVd4ZwsAg3dczFHPLLdiXTUwMJYOTGXZXwEPJ6CjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar+lIaTnKKEDpO1MpnRPmAfAiAusBFmNXRPVt6bLY6NGH5SF1QiaMNbaPFgQGtoVX+TVHzOvoVpKOx1KGzgVj0xhHG7ZAyMCyjPNN5epSaI+5bZeze6hI7qYxqbB1MV47+nszXjXxCHj9DLJ8GGkbuAMfmxKqNsYtlmjlGiMfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF2HBVP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA428C4CEEF;
	Thu, 31 Jul 2025 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753977836;
	bh=FoJVd4ZwsAg3dczFHPLLdiXTUwMJYOTGXZXwEPJ6CjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YF2HBVP6qdt+eLmPppziskZVKA16Vqah3Gk74VfImqvm4mvfbFN4gYVlrIAe2QDRL
	 /sispgCBlarwEWH886YFqB3eCOsxNio+skexa5tHkWPQnO5mAZcRf0DWspXIfYaxqp
	 jFuSA8SP2rlljjoWKLXdmMWH0jZ36BqIYK4U1eczSevuo+qVfyo9IPeDoPJngDznzg
	 kyFWOzUe1K3oZICNCRjIl+q/k5X5Htvew8wEDnCblLYsa/Z0UyDFvEavZQtB6t7B2V
	 JI7yZOmic2gFWpYuLmjK23QtaEvWtPjBOHi+VjBZN72spItqFbhyPo9ZAQ20EEnNgK
	 k58YexbATehLA==
Date: Thu, 31 Jul 2025 18:03:50 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, david@fromorbit.com, 
	ebiggers@kernel.org, hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 26/29] xfs: fix scrub trace with null pointer in
 quotacheck
Message-ID: <qo6znctky4vztjqewafqjc4gz3urbej6ux7zikp6fm5mpccnhl@qbycsfaikqgb>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-26-9e5443af0e34@kernel.org>
 <20250729152839.GC2672049@frogsfrogsfrogs>
 <-DbaWXaCN_e5KnqMY2BMk4CzJU6iCFfXox_PClVrR77u4tP-i9XjOWbWAyxAQnVXT4ompbgItUSIBbvJ5iiUWw==@protonmail.internalid>
 <s36etkudrevqb35gfscyfeibrwetxyrepuc2z2xg2bcgp7dzpb@hhaaawzg7vjq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s36etkudrevqb35gfscyfeibrwetxyrepuc2z2xg2bcgp7dzpb@hhaaawzg7vjq>

On Thu, Jul 31, 2025 at 04:54:46PM +0200, Andrey Albershteyn wrote:
> On 2025-07-29 08:28:39, Darrick J. Wong wrote:
> > On Mon, Jul 28, 2025 at 10:30:30PM +0200, Andrey Albershteyn wrote:
> > > The quotacheck doesn't initialize sc->ip.
> > >
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> >
> > Looks good,
> > Cc: <stable@vger.kernel.org> # v6.8
> > Fixes: 21d7500929c8a0 ("xfs: improve dquot iteration for scrub")
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> @cem, could pick this one? Or if you want I can resend it separately
> with tags

Yes, please, send it again, without the RFC tag, with the rest of
shenanigans :)

> 
> --
> - Andrey
> 
> 

