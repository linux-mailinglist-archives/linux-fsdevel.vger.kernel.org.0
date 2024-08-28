Return-Path: <linux-fsdevel+bounces-27613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A6962D81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3102D283EFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876F1A3BC2;
	Wed, 28 Aug 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxxgJuIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CA44C68;
	Wed, 28 Aug 2024 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861827; cv=none; b=LjXSNVgj/SMNoGaPidfWydAMiWvaEhi3ZW7ny1fl4QmEWCOPM6eDeh1PtVtyOLAt42bY5xAY8fAfBWY8zKllLY4xu1dPXwG4CHba6d3pwJLQdKBqHxeBBsqU1avW6DF8l+2NZiQKkEyRhZwvp8e5aUWG2R5fo+ChSw8Ve16Zk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861827; c=relaxed/simple;
	bh=zzEz6a+a7catR9lF918EwtrhUutTlF4Pbk+J6wAcCw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXUvnWEo7bCy5cAQlZ3cRKQNGF04MCUouspoX1zLQone3vRPnBJboDDbOlqq4R+fM+zWbbwl33+UYaRnX4tvYcIJRU5fTQWQPnQm+rmh5Y/sC9/0XZwwf0dgutasOvDFu/wZ6lKbGRu+GibwKDeokDpPhybAwQ9dAAW7FkhHXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxxgJuIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B537EC51EFE;
	Wed, 28 Aug 2024 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724861826;
	bh=zzEz6a+a7catR9lF918EwtrhUutTlF4Pbk+J6wAcCw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxxgJuIJRyZJqzE/0h9xbbxQOOsR3VFLEUM0Fd+duKDEywUX12Fpnn5nzbXzDlvyb
	 zJ9loCnxLbVhr2FRoCsOpiC91g/7ezzgrZHpkuPQ3BjW61sk+XLik6TdFkd0Mj2dKE
	 ySHIgUuXPn6Yx9DDLT3nnMdCsIlN362YraDknMyDUds/Rq/2XOCFITky6zf1STOJf2
	 sW+HjM5qt2SRXbjqQQWZ5r09gFugBOKB6j5lMsmz+nTdLQMS0pcmnYKW8bbJQpk+Oj
	 6ZenheRsMCDHz9rZrL+rb8UaUhIHcnzF8dZ3S2rWvr0tgSDHh5InaROPD1IVq6u1aP
	 FIgYWMrIX4DdA==
Date: Wed, 28 Aug 2024 09:17:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: improve shared block detection in
 iomap_unshare_iter
Message-ID: <20240828161706.GI1977952@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-3-hch@lst.de>
 <20240827054424.GM6043@frogsfrogsfrogs>
 <20240827054757.GA11067@lst.de>
 <20240827162149.GW865349@frogsfrogsfrogs>
 <20240828044929.GB31463@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828044929.GB31463@lst.de>

On Wed, Aug 28, 2024 at 06:49:29AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 27, 2024 at 09:21:49AM -0700, Darrick J. Wong wrote:
> > > For writes it usually means out of place write, but for reporting
> > > it gets translated to the FIEMAP_EXTENT_SHARED flag or is used to
> > > reject swapon.  And the there is black magic in DAX.
> > 
> > Hee hee.  Yeah, let's leave IOMAP_F_SHARED alone; an out of place write
> > can be detected by iter->srcmap.type != HOLE.

out of place write => "OOP"

but that acronym is already taken

static inline bool iomap_write_oops(const struct iomap_iter *i)
{
	/* ... i wrote it again */
	return i->srcmap.type != HOLE;
}

<with apologies to the artist I just insulted>

jk

> I can probably come up with a comment that includes the COWextsize hints
> in the definition of out of place writes and we should be all fine..

Sounds good to me.

--D

