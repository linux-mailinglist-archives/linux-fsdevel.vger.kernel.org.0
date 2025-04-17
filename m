Return-Path: <linux-fsdevel+bounces-46620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D918A91876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E11461146
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840D22A7EF;
	Thu, 17 Apr 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nARtGiPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625761C84AD;
	Thu, 17 Apr 2025 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883862; cv=none; b=uicFJk90GcEiXpx6Bsf431YNrcE5UzGeI1AeodlQY+8JLUW8i6cYHqYs5zRCsTJJhb11c4DexdYP+jw34JDajcGVTFUR2n1JP1NPbnNBukgqgAzWaN/FT6MlPsDcNckQl7a3m5MQJitur9Rz2UkYE+HY79PJa1HBH/+7johlGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883862; c=relaxed/simple;
	bh=74Syrnslrm4pPY3lc+PPK93eU6Bz87BAgFvR+bR2NiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjDoqE+p3QSRx45kG5QcrP2Qugc67AabP7M35u3QFHX3bHK4wg79Tzna0vZCOoZ20Y96qTY9BbTfXtCzEjs7rQlC2lcqHkwLjoYrMehLvZ9IYE2Ot9VRh4tstVw+7LUAMYd39uVFrzmGdSStfBnCr0h/JxzJ7tZ/KeVfdwauZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nARtGiPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F389BC4CEE7;
	Thu, 17 Apr 2025 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744883861;
	bh=74Syrnslrm4pPY3lc+PPK93eU6Bz87BAgFvR+bR2NiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nARtGiPz0ghKcu32cNEflVOXhx2Hju91/QffUQjwWmvvob7CZ4uNdGNeEyU9LTfbH
	 5QNHmjBu2wQH/QHynp7bZyuQxhNcBu27IOMbjWyqB3coeHh/j3CErHUqHne3Ozgxg9
	 EVnL7vMMdijjp+Cs3yKQ3h9hQ34qvh4CbzpUAWGRV5GnNXuWWPQJbp/+1435t/ZIb2
	 FTYfDu/kGpdNH2NGdxScJd3/3vVpF0ThiPvfENXapwvdJuB0BFz4+6xFqo5A/4nvMs
	 d5ElTJzF2JDuGtb+rC2aOVgIZs00gCOSpp9lm64HKAYtBbhizx+TO1yqfN9chLqDfu
	 E2KU/j9eWTTzQ==
Date: Thu, 17 Apr 2025 11:57:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	willy@infradead.org, hare@suse.de, djwong@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next 0/7] fs/buffer: split pagecache lookups into atomic
 or blocking
Message-ID: <20250417-annahme-geprobt-bc84bbd12af3@brauner>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <aAAEvcrmREWa1SKF@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAAEvcrmREWa1SKF@bombadil.infradead.org>

On Wed, Apr 16, 2025 at 12:27:57PM -0700, Luis Chamberlain wrote:
> On Tue, Apr 15, 2025 at 04:16:28PM -0700, Davidlohr Bueso wrote:
> > Hello,
> > 
> > This is a respin of the series[0] to address the sleep in atomic scenarios for
> > noref migration with large folios, introduced in:
> > 
> >       3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
> > 
> > The main difference is that it removes the first patch and moves the fix (reducing
> > the i_private_lock critical region in the migration path) to the final patch, which
> > also introduces the new BH_Migrate flag. It also simplifies the locking scheme in
> > patch 1 to avoid folio trylocking in the atomic lookup cases. So essentially blocking
> > users will take the folio lock and hence wait for migration, and otherwise nonblocking
> > callers will bail the lookup if a noref migration is on-going. Blocking callers
> > will also benefit from potential performance gains by reducing contention on the
> > spinlock for bdev mappings.
> > 
> > It is noteworthy that this series is probably too big for Linus' tree, so there are
> > two options:
> > 
> >  1. Revert 3c20917120ce61, add this series + 3c20917120ce61 for next. Or,
> 
> Reverting due to a fix series is odd, I'd advocate this series as a set
> of fixes to Linus' tree because clearly folio migration was not complete

I agree.

