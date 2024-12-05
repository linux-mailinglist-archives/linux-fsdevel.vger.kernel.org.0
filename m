Return-Path: <linux-fsdevel+bounces-36526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD09E5305
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 11:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1379E1881208
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8D1DB938;
	Thu,  5 Dec 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq/jr4EJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754621DA60C;
	Thu,  5 Dec 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396001; cv=none; b=SkGva4fCRbnK+3sqKcBaofQO3zliqzLS4mUBEAfoe2XX9tAsbN/IyFeMLSZZOFnTWlujCfDBHq1ft22T5jHFMnJMEV9/obiLt+wvFe2lAxCNGWQvXFB9LO4gBs/pxno5gZ2K5hyjeNjIbqmBXYb4a7yfk56C2DAr7ftUk7H7Ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396001; c=relaxed/simple;
	bh=IFQCT/71vDZWwVkDuN7CYbIjKP67ulnwIBjAeTNpINE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjERvhWm6zZb04xhHp6IAABbz0CR4ugi03XGdDB0HA0iR+8Ma7zmLQtEc4bP6oGRoQ2QWwRlC+MbA5V8BBon/L9ZB53ZtfzfTZ2QudS+lBO7Z+x14mXmotKSb2mXxcGzEX6HB9+dKLx1o0TtXIE5KXo4zRBVPUgDehm8eB6eGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq/jr4EJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082BDC4CED1;
	Thu,  5 Dec 2024 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733396001;
	bh=IFQCT/71vDZWwVkDuN7CYbIjKP67ulnwIBjAeTNpINE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yq/jr4EJYZ/lZkHKEKf+QQ0JGXsoGogFusR7s0ZvNrzHI/hPiEic4TrX/7+v3eQHI
	 iXRmL66NA2KKUEDzNY+iKgltF0WEQ8+NhmspqV5mFBXMVS34xoBPHtvO9nnEEOfr6K
	 CmEL33VgQ8Knv9JLNpWZzRFbJRfKcGa3OpT+e8KAGA12TwrPWkTHXNYcZd0hU2dacu
	 UbQ5jZTjcXjybhoHwzKH9zYpX11aMdZyLTL+T113otC7JMN4mRbpw1j+6kFSlyEA+J
	 aveGg3O3j+/v3TeuMr8oKY5HptUMyE8q+y3k+P2kIAgU28eVKzs/GC9W54wVP+9n1K
	 6tnVCqkpPQUhg==
Date: Thu, 5 Dec 2024 11:53:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Erin Shepherd <erin.shepherd@e43.eu>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <20241205-waghalsige-hetzjagd-b271c6c2efea@brauner>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1D2BE2S6FLJ0tTk@infradead.org>

On Wed, Dec 04, 2024 at 04:38:28PM -0800, Christoph Hellwig wrote:
> On Sun, Dec 01, 2024 at 02:12:24PM +0100, Christian Brauner wrote:
> > Hey,
> > 
> > Some filesystems like kernfs and pidfs support file handles as a
> > convenience to enable the use of name_to_handle_at(2) and
> > open_by_handle_at(2) but don't want to and cannot be reliably exported.
> > Add a flag that allows them to mark their export operations accordingly
> > and make NFS check for its presence.
> > 
> > @Amir, I'll reorder the patches such that this series comes prior to the
> > pidfs file handle series. Doing it that way will mean that there's never
> > a state where pidfs supports file handles while also being exportable.
> > It's probably not a big deal but it's definitely cleaner. It also means
> > the last patch in this series to mark pidfs as non-exportable can be
> > dropped. Instead pidfs export operations will be marked as
> > non-exportable in the patch that they are added in.
> 
> Can you please invert the polarity?  Marking something as not supporting
> is always awkward.  Clearly marking it as supporting something (and
> writing down in detail what is required for that) is much better, even
> it might cause a little more churn initially.

Fine by me but let's do that as a cleanup on top, please. Especially
because we need to backport this to stable.

