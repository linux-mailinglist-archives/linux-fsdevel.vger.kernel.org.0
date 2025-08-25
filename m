Return-Path: <linux-fsdevel+bounces-59079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1FB34100
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401F23B1A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A399275AED;
	Mon, 25 Aug 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh1Y3/WO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630C23D297
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129400; cv=none; b=mXNQnVjynmEncg7f5fwzJt0+lNpuTeOaTzAMZmTOD1gH/LNUlQUd0lB0oId8P0NskJWmCqpYMhWRejfplZPodGck7Y8xWhOF+ivFnN4vG2DwLUGFvRQVodwFpfugr20pN0Mr2wrZpjG4CwAd9045s8cU3eV/sScMsysqcYn7SwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129400; c=relaxed/simple;
	bh=UUanglp40uOulSbXHJAoBrl6ncBn6KBZTc2Fc4NTySk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SegbCoxZ+pSBJ2V+m5kQ6FfMB8eOyBmSZFWM3C2AQJbLZncdlMeli0JvLdafrJY2flJ79IDosCV+COgZZJo2EL8+4N7uekOEf5K6JMKB81iKKdLgo87ogPGcLoa6CyP02B4s9l/GGN4rMF6dUehoQe7KT+mCFYqdR/L8EdyYfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh1Y3/WO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5D4C4CEED;
	Mon, 25 Aug 2025 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129400;
	bh=UUanglp40uOulSbXHJAoBrl6ncBn6KBZTc2Fc4NTySk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oh1Y3/WOTqWlGOdOQ4mRdnXqIygvkRLz7nbulxV5jAc7I8+DHvnZm1/4uksCAsXcd
	 O3qNTeftkP8beNqiRy2jSkZ23cOoVA/RXn0RhatqZKRwTGBb3aHods38wxWR5oIzdc
	 O7uyOVWRrKeudegBmGA/OVCxpiGsmWIw2uvdvca0wmJUcEQjf910Yr/Y8Z3RLvTHMg
	 nXQIV1Sj5UBZHNY4gHE/n+EVaVaA8HmmUcDzU0/4IqAm2CSKxPTAfF0ZffgxjH6DbN
	 UfFMR7XbJK7hEGUQeiSC1rXpWnjItjvY3BDKH7b5jSw6+KxauEqmenzuPwBjvjLHtD
	 VDtnfiTB5Chkg==
Date: Mon, 25 Aug 2025 15:43:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 33/52] new helper: topmost_overmount()
Message-ID: <20250825-herkommen-endverbraucher-1d26f85fef81@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-33-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-33-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:36AM +0100, Al Viro wrote:
> Returns the final (topmost) mount in the chain of overmounts
> starting at given mount.  Same locking rules as for any mount
> tree traversal - either the spinlock side of mount_lock, or
> rcu + sample the seqcount side of mount_lock before the call
> and recheck afterwards.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

