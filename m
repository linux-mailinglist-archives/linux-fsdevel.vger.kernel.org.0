Return-Path: <linux-fsdevel+bounces-19151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F38C0AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 07:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE701F23AEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 05:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851FB14900E;
	Thu,  9 May 2024 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yHAWmKTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13328373;
	Thu,  9 May 2024 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231047; cv=none; b=a3u8w7/fUs7bggm85jAHIyG9YjBSiREXlvfS/88hRvtRPpUBAAMQxqJf+LF0XsiFENL1kcNCCFIWM728G1R7hIbX7UvUvHjIkwKx9ntqxQcP9Wfg8l9qF8Mu6ok3FgF3lUJkSBlGR0ACd5qA1iFMGppGwwAyx6d/xLG8tvLxYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231047; c=relaxed/simple;
	bh=MwlBIrAV4SFQeMo0rTzliUgHnpevBn7yH4TkS/salAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0DR5uy4qxGJtJZJjE+PmOamas8HIxMh4fHgZY3FuNvO8TUcnXJ/+Fm789pPlkSpY4LfMJu8Z8kVJpk/rAPn4xVrfab4Ht4TRFW6V0ZFj+8Iq/q09pgSWFkGX15BFvJJMn81uG1u4jcPdnj6G0KA4koFOgL5PslRdrzRm5tytrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yHAWmKTp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g2xu+EltcahsAJnJ7diR5dTX2UOGCmI2Fio59PNUUXs=; b=yHAWmKTpXnNdlwSbo1dGtFwaBS
	K0/Bf2eydRxB/U8iA48SLGbNupRAbe1zuePe8DB8gY/OGPwbUj2jOmeSf0bq1EvUSOAg/w5cvq0U0
	kJVPZvutH7XmFqI+s6t06nNkOJmXVyziKDR6drstzYKre8jURftHO7/Q7lrIk6SWHygKWfoRrrO9k
	utThpB5G2F7x28qT34TCf75wT1Q7yPELq084wjWA4UV2yEbnBJqsMiANKk6Sb6QuE8IH/pgPFOz+2
	czpQfCS3hQaokbd0CEtK2ltdVi9MG9Epl19cmkWDaskH+2XbvTKXomHoo2Zqj0439fkBbxn7aKxhX
	HnJqh7Kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4vwr-00000000NFD-1rb6;
	Thu, 09 May 2024 05:04:05 +0000
Date: Wed, 8 May 2024 22:04:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <ZjxZRShZLTb7SS3d@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
 <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
 <20240502001501.GB1853833@google.com>
 <20240508203148.GE360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508203148.GE360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 08, 2024 at 01:31:48PM -0700, Darrick J. Wong wrote:
> Hmm.  What if did something like what fsdax does to update the file
> access methods?  We could clear the ondisk iflag but not the incore one;
> set DONTCACHE on the dentry and the inode so that it will get reclaimed
> ASAP instead of being put on the lru; and then tell userspace they have
> to wait until the inode gets reclaimed and reloaded?

Yikes.  That's a completely mess I'd rather get rid of than add more of
it.

What is the use case of disabling fsverity to start with vs just
removing a fsverity enabled file after copying the content out?


