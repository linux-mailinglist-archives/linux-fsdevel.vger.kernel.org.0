Return-Path: <linux-fsdevel+bounces-57486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B01B220BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9940D6E0864
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2D2E1C64;
	Tue, 12 Aug 2025 08:24:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B91B0437;
	Tue, 12 Aug 2025 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987049; cv=none; b=ofCL9VtokV7gyQUEvTbW2STFgYavrx6shi71FjLz+CdeVF2a6MUT3JQNPRAgOphyaVUAn4HfcRpUlJkNi0LMjUj64DCMQVGqb5KwTtw8/EQi9lkaPQ/3aDs/dG0kcZLMy3DM4O/TuOI7dv6E8mIVWJMU4lkELnCx9AES+4ddgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987049; c=relaxed/simple;
	bh=VXTZQBNeZtxlmE48uuJB2Sjio5NEkJ+S1UmMlzPLsUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmYpprNT8PckNqbYMGxPI6yv8JXsB0rfyKGiq257Ohnwoq7Tu9OvK3cNjweNa8zKAf/FmtBUUHT592FLr9gcPSBasw7MtYMPxrnLqSz7jVwQ1RVWHpxybfg9UYwmhCO6oHZtJe97T+P5/qm/EKYoKc8uGPatUz4UZmlaORRv4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61DA668AA6; Tue, 12 Aug 2025 10:24:04 +0200 (CEST)
Date: Tue, 12 Aug 2025 10:24:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC PATCH 4/5] fs: propagate write stream
Message-ID: <20250812082404.GD22212@lst.de>
References: <20250729145135.12463-1-joshi.k@samsung.com> <CGME20250729145338epcas5p4da42906a341577997f39aa8453252ea3@epcas5p4.samsung.com> <20250729145135.12463-5-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729145135.12463-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 29, 2025 at 08:21:34PM +0530, Kanchan Joshi wrote:
> bio->bi_write_stream is not set by the filesystem code.
> Use inode's write stream value to do that.

Just passing it through is going to create problems.  i.e. when
the file system does it's own placement or reserves ids.  We'll need
an explicit intercept point between the user write stream and what
does into the bio.


