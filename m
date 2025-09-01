Return-Path: <linux-fsdevel+bounces-59810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F1B3E1CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD611A81FCE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3031AF3F;
	Mon,  1 Sep 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUczNzTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E0313E04
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726732; cv=none; b=HWkeEH9a0vRyKrrT1hhitPUAbEWVQaG3XPKOybZyy80n6yyrzsErJthMTs2qb2SQQ23PTGBfjcTbY2q+kMFZz7c8K8JyfT3rJWSQDiSVXFOXoUllLSjYOWH9UmJIeYcjNAt9eOSfT2kbNz3A+Z/Ewa92Ev84cR81aCJ+6NJt1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726732; c=relaxed/simple;
	bh=KPiXKlqo+UiEOAWYksaDQ3Y+zMfNvD5yeFToZ0rZKPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOYDNA62M/RnH84C5H2cyHrMYcV2Zul4qnCzffo1wqZZQ5OE25QDhsHQVSZL6MJmd9Wq7A4RRORovmW1/QWFTjrG+hfGlp9wyrgJ5DAA6J2sxxpnprKFnHltDrJIP3oD2DnJabAzXFt0I5Q+AYeLNy1dWLY6LLWOm2zAFQdw1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUczNzTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388B3C4CEF0;
	Mon,  1 Sep 2025 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726732;
	bh=KPiXKlqo+UiEOAWYksaDQ3Y+zMfNvD5yeFToZ0rZKPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUczNzTWDplZKkeA2wL5b7nq+hfNZwak65PxtB4NAVqJPlp8s8PM4esvp575S5D4C
	 X6ntiR1hsrrn/pYNMAz74PgIu6i5Zkd0xXXqMaQN8kAA9n02Ua1+ok4kubiOYv0vCr
	 13oHtqlv/3EsdLkxr8rs9acl036N6luQ82nYtopWfJ6PKUUy8Yp6tkUTqFajGNOWOl
	 MnUlJNE/eMc0+ALKSJ4gbaM/8YWLtY1Da9xKarGYeSClNO1oM1cU+1aVN5FL6FxcYa
	 uVN8lNUkN2BZQpPAGBqQ8Bm+QAxKqEhjfomCJYbffC4Hh8yQ1yPxv5D7t2VIy/3reK
	 sFZeauFh/kwPw==
Date: Mon, 1 Sep 2025 13:38:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 29/63] do_move_mount(): use the parent mount returned
 by do_lock_mount()
Message-ID: <20250901-loslassen-abstufung-d66660db0360@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-29-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-29-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:32AM +0100, Al Viro wrote:
> After successful do_lock_mount() call, mp.parent is set to either
> real_mount(path->mnt) (for !beneath case) or to ->mnt_parent of that
> (for beneath).  p is set to real_mount(path->mnt) and after
> several uses it's made equal to mp.parent.  All uses prior to that
> care only about p->mnt_ns and since p->mnt_ns == parent->mnt_ns,
> we might as well use mp.parent all along.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

