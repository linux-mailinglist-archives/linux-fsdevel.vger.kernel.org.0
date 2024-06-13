Return-Path: <linux-fsdevel+bounces-21677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D85907DCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 23:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CBEB2143C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43A813BC18;
	Thu, 13 Jun 2024 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LQIM/zso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E3139CE2;
	Thu, 13 Jun 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312731; cv=none; b=M3c/FfJ2vztNEZcDEJ6P9i13HuqhtPokwJ0vtdJvJAn6RbiszBMLqRHl9+2hI4VzvDQDA8X1SySwKq//caX3dSlEkr8es3rqkumNZ/L1OEfG1LvDBuN5z2kgqfpH3y8Z2Y1waw8j6bSf4zvEaDojepQttx+haKwL3vNNHFRvfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312731; c=relaxed/simple;
	bh=1N57nJKYad5GQlFlVK5vyZg9DVxu29fNs4rxSskaMqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRCWUcnqKP36JEFxYcnVNpV24Dq1QjJEPQMXDa8CpJsIWYopkFNuA/iq17k1eVQ1wQuc2H87UFvvlN1B1j09KGVLK/mFDXMCsKJ14BK7NmsJL1Wy2aAYO8qqQVMQQ7YAG57De1fugCMaKhylzedIqUru0pCFqWVTE30LA3vMFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LQIM/zso; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cCxKgbEydPpXzyxcW3sCZ69Cxc/JRcYSvSPx79sKwvM=; b=LQIM/zsoXYsGe9XG0lG6bmjxwV
	lVa+IKYA5odiuQ/7Uj+g36bmh8qnQ08MfBqUBRzsC4IhdhDKanekA4d1BZ2K2+Mg0mKXxDRbJ+ukF
	Xqh/TWqP1vRyJlN9hPzzKtdmyS0cqSxKApEdbf6QZdJi3/0XABdX9V7Obmjga7Aiks9tApomKVLCj
	5cjBNm7TDh17+HUuo3HODLohiIgSHTtVIZ1aMRTAwjjQFJDdfsQPht0Hr58wxDO0vswGPuHBIgxIQ
	6i2cFpyp0Ou8vixr3thoU60R6L8T0cBMCHi2d75FxMxu4AKbyiE/AsGC3RcXicJiFtbOrrxXjDWao
	KxyKcwdg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHrdP-00000000UOI-0cZb;
	Thu, 13 Jun 2024 21:05:27 +0000
Date: Thu, 13 Jun 2024 14:05:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 2/5] fstests: add mmap page boundary tests
Message-ID: <ZmtfFwSS66PtVLry@bombadil.infradead.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-3-mcgrof@kernel.org>
 <20240612080634.xmh45gdblvx3lgrc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612080634.xmh45gdblvx3lgrc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jun 12, 2024 at 04:06:34PM +0800, Zorro Lang wrote:
> On Mon, Jun 10, 2024 at 08:01:59PM -0700, Luis Chamberlain wrote:
> > +mwrite()
> > +{
> > +       local file=$1
> > +       local offset=$2
> > +       local length=$3
> > +       local map_len=${4:-$(_round_up_to_page_boundary $(_get_filesize $file)) }
> > +
> > +       # Some callers expect xfs_io to crash with SIGBUS due to the mread,
> > +       # causing the shell to print "Bus error" to stderr.  To allow this
> > +       # message to be redirected, execute xfs_io in a new shell instance.
> > +       # However, for this to work reliably, we also need to prevent the new
> > +       # shell instance from optimizing out the fork and directly exec'ing
> > +       # xfs_io.  The easiest way to do that is to append 'true' to the
> > +       # commands, so that xfs_io is no longer the last command the shell sees.
> > +       bash -c "trap '' SIGBUS; ulimit -c 0; \
> > +		$XFS_IO_PROG $file \
> > +               -c 'mmap -w 0 $map_len' \
> > +               -c 'mwrite $offset $length'; \
> > +	       true"
> > +}
> 
> As you've moved the _mread to common/rc, why not do the same for this mwrite?

I didn't move it as this mwrite() is only used by one test. Let me know
if you want me to move it.

  Luis

