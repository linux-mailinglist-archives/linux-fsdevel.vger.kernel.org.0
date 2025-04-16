Return-Path: <linux-fsdevel+bounces-46578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CDA90980
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B6316C31F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E72153D3;
	Wed, 16 Apr 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws4WbEiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FB2135C5;
	Wed, 16 Apr 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822713; cv=none; b=gJMSosoURm/Aypn4lZ7ZRGIjz4PPoN7aTCHbTzX/wBrGDH0KUIwo//8vAqdP6UqRUhhAUNbV0ylqHodaOLCggBkiqYdCkQMAopjSs5C6dC+lURE6MOnQuH7L8bWsqdTxGnQZSDnbsiO10aPitKJRsclYL8I6EsBGJK4uiuQXokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822713; c=relaxed/simple;
	bh=t29fiwuZzzbt+7E7k2lgexW+wHlU4j24IKia/2TW6/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgBTqEiq2Y80wZPouOOu7KJTtxtD1xENcq11BicfPcD8himo3J0rEjniedHB+54qq6VnhxAiSGAfTs+G/PVBFpSx5aE1xeRo8nVHTJ8JPgCqNnBEUhBj8214Y2QgWySHo8hxUuAvrUqGQrOaPGIOkLm4yIUGR9yKRAcH22a8xSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws4WbEiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57417C4CEE4;
	Wed, 16 Apr 2025 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744822713;
	bh=t29fiwuZzzbt+7E7k2lgexW+wHlU4j24IKia/2TW6/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ws4WbEiDr7BhF0OHP4qxpv2o14+0HotsfuKCMMu5Px769VLD5sAGJXKf3i8JzMHFs
	 JWftel5AhiJvCEqDK7coG9fWVtmywVgHOughUMK8lmjgf6lcOWwBcW/WWpKconJ0dg
	 uSsbAOLwy0bPuKMmzkvdatDwYiFM5fyuFQx91yIC8+ijvbe/stFox8xdr1l1WH/Vpb
	 YR5OhKNzBTFeBuYRugfNEGvN+ZXU2RcwMdoE0ewxFvj3w7n3GFSv/gaOD2anEtlLrb
	 xttH1ofzE72gopjvMGvOdThZsYoiA66EhZ5fYKj+ENSDdTEzLV5tmjDfJJwEdVdDDj
	 TBk7MbwUIAmKA==
Date: Wed, 16 Apr 2025 09:58:30 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>, dave@stgolabs.net
Cc: brauner@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, riel@surriel.com, willy@infradead.org,
	hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com,
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com,
	djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <Z__hthNd2nj9QjrM@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
 <mxmnbr6gni2lupljf7pzkhs6f3hynr2lq2nshbgcmzg77jduwk@wn76alaoxjts>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mxmnbr6gni2lupljf7pzkhs6f3hynr2lq2nshbgcmzg77jduwk@wn76alaoxjts>

On Tue, Apr 15, 2025 at 06:28:55PM +0200, Jan Kara wrote:
> > So I tried:
> > 
> > root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5 -y 2>&1 > log
> > e2fsck 1.47.2 (1-Jan-2025)
> > root@e1-ext4-2k /var/lib/xfstests # wc -l log
> > 16411 log
> 
> Can you share the log please?

Sure, here you go:

https://github.com/linux-kdevops/20250416-ext4-jbd2-bh-migrate-corruption

The last trace-0004.txt is a fresh one with Davidlohr's patches
applied. It has trace-0004-fsck.txt.

  Luis

