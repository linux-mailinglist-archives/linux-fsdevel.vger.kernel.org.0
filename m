Return-Path: <linux-fsdevel+bounces-18450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44508B91AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211601C2148A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 22:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EA612D76F;
	Wed,  1 May 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1IUss+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64E1E481;
	Wed,  1 May 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603076; cv=none; b=fSS/b7zKNSDvNu8QlkV05k+sSqkOmKElnWEImNLPGfU4z9EzzmpvBgvu0EbmQ4aEdGRMBXwJxBciqaKuTaMAnWyVFRN/u/coidEHJNJYQPhASnPdAU3S6ns5ta/fuVNY3sjsjk44A2EW9dH12moAbSausqA0I0UNZYNlMJrUSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603076; c=relaxed/simple;
	bh=z+zmvVARuPhrr08/Yvg9+EebAAa784VOK0GNsyhwW5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJDDl91ktu23kFLXP8diEvUbO6PopoLC0aOlJejbVqOHjhlUQiKTlkaywcXArCp5e5QkAD1cSjbPGQCSEcdKwgONXk6hdzL22HaATmrdKgT/bVkDmF3t3PQRv81YO2BMP2YCwAZ9XzWwIN6JhQ1E8WZ5HiGPEeNT1VLLYeVs3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1IUss+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEA3C072AA;
	Wed,  1 May 2024 22:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714603076;
	bh=z+zmvVARuPhrr08/Yvg9+EebAAa784VOK0GNsyhwW5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1IUss+JjJpvRl0NeSTK3RispOu88/CPlJ3Ao5dlwMb1V/Z8GPCseRuIx2ijp1aDa
	 0YQGLAvqXFnaFRSlmJPSPcwciSa5bzVemBvqFgBwwlFHbzeBQYKwA3QZ24eQt7W9qf
	 A754ve3ZyD1Yh5PO8IO1pYVPsJsWX4oL4l6tLxUHxYpSQlsGYLXVYYU+tRGol3p+Ui
	 WEcIn1QzHXoM7PrKq+/lno8SF9STznvLGkA7JrkMhqP+hXq5XRkHEUsSjoUrUNR7kN
	 oFORxbpor/U7fq6ogShmfjE2Hz1mFWQ2cwSWxstYOe0XzNSKIV+v7u7yPkOmxIOVe5
	 Az6yTui5rVIKw==
Date: Wed, 1 May 2024 15:37:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/18] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240501223755.GH360919@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679890.955480.13343949435701450583.stgit@frogsfrogsfrogs>
 <ZjHq_XiLQnXO_pqo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHq_XiLQnXO_pqo@infradead.org>

On Wed, May 01, 2024 at 12:10:53AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 29, 2024 at 08:24:06PM -0700, Darrick J. Wong wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > This patch adds fs-verity verification into iomap's read path. After
> > BIO's io operation is complete the data are verified against
> > fs-verity's Merkle tree. Verification work is done in a separate
> > workqueue.
> > 
> > The read path ioend iomap_read_ioend are stored side by side with
> > BIOs if FS_VERITY is enabled.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Not sure where my signoff is coming from.  It looks pretty similar to
> a patch I sent a long time ago, but apparently it's been modified enough
> to drop my authorship, in whih case my signoff should be dropped as
> well.

Removed.

---D

