Return-Path: <linux-fsdevel+bounces-60361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B9EB45A07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 16:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E38B1CC3C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7F35E4DB;
	Fri,  5 Sep 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuGD5/md"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9A1D79BE;
	Fri,  5 Sep 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081036; cv=none; b=TQd8kl83R//fIjDzdHLc9/FjQxWwvbu70wQPEA7BHncXCIXcQTbQDNKQ/jWB65nZUO8oXHyxreTR0RLDJxdr6B7/DWz4kUaBO0wyp5dBEvE5zJGEUN77Y/4+01C8Kdqj6EHdWI13lGXJaHYwpgVN8k72CSN9UyIMmGmqPg0qd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081036; c=relaxed/simple;
	bh=xeb7vbPEHD/KqCw1Cd79remZ0YLf8hLpw04PN3rMOVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3bAdG+gyCxq6bXuyxj5k6UnbvqF+ACflxQhPE4HgigSUTY1pRtnPp7hs8pehGZHF56oYFiHjdIDKuiNHK5Tybfw6n4w6BIjpJ5oZx+REbNSmZS65p8tZKG0ymW+CtCeKTnpYAxdAjR8APzlwDhDEZLkRnGi1HTJ8YyemlCI254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuGD5/md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F0FC4CEF1;
	Fri,  5 Sep 2025 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757081035;
	bh=xeb7vbPEHD/KqCw1Cd79remZ0YLf8hLpw04PN3rMOVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuGD5/mdYyQqT/gUsJySeJt/nHR4lDVAt9EnQ2J96sLRvK2xea3+7HsymdF77PcJ9
	 S+R1NWHu0de2kMWua/5IGb0LuUJJPRL4cMxSrSnh4NGNG6ugLcWmxe4apXcJHtBs27
	 t7CEBqDfUbC7hlaqD4ZI7B7zVTtany8aS5K36jo6MmWfwQcblz8gmjudZK4NJdR6MY
	 psheDX4GuK/I7YMrQlRWr7okTvFBSOvaGRUpvScLpIhFHv3/+7D6HKwV5jnv5r8XgP
	 AS4SetsBInWyQFKLDnzBX6TYLiq2WvBCAPEt3igtuyNUH8YpKfj7RMlsmWd8jIboYn
	 V0NQ7I8PdNwaA==
Date: Fri, 5 Sep 2025 16:03:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Dave Chinner <david@fromorbit.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] fs: add an enum for number of life time hints
Message-ID: <20250905-posaunen-lenken-e81db0559def@brauner>
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
 <kcwEWPeEOk9wQLfYFJ-h2ttYjtf0Wq-SjdLpIAqoJzT3jysu_U4uhYJj1RZys6tWgxVKxq833URcLKj-5faenA==@protonmail.internalid>
 <20250901105128.14987-2-hans.holmberg@wdc.com>
 <gzj54cob33ecyfdabfbvci7nj7gl5sc2cbujpkg6qax7vgoph2@3ubnb4d2dfim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <gzj54cob33ecyfdabfbvci7nj7gl5sc2cbujpkg6qax7vgoph2@3ubnb4d2dfim>

On Fri, Sep 05, 2025 at 10:17:51AM +0200, Carlos Maiolino wrote:
> On Mon, Sep 01, 2025 at 10:52:04AM +0000, Hans Holmberg wrote:
> > Add WRITE_LIFE_HINT_NR into the rw_hint enum to define the number of
> > values write life time hints can be set to. This is useful for e.g.
> > file systems which may want to map these values to allocation groups.
> > 
> > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> 
> Cc'ing Chris Brauner here, as I think he is who will be picking this up.

This is so trivial, just take it through xfs, please.

