Return-Path: <linux-fsdevel+bounces-27752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846899638E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71211C21B50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EC74C3D0;
	Thu, 29 Aug 2024 03:46:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8372381D5;
	Thu, 29 Aug 2024 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903192; cv=none; b=mF+ImsGwoU2oXPy2NpZ79ff9ZNTGGEnhdIvkuAf/6d//oYtsEHfWi1ZrPKN1gDwoww649BKJiRtAjv3EJrszNA0nQRkM6ICfj/GXDtBj7uRoa4Gfnuuityg2rnbtfVcd9ZyWynwjKoiPI7qM/nrIHYodIB5rVe+M8KD//E4ungk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903192; c=relaxed/simple;
	bh=KEpxA1LZX6bV4rsVpbLSqiKVKTKgKBJqunXBkE8HjKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3pYt2TsfTIA2rJsNo9GIRpi6YiZOSeUDrMZgrtPwtfba3B14OqhpHx/f5eexqDx6X4yQgfIkueXXViMeSZ5PA+luHLnY/p3U2/AOEs43rPcp7fbwcyGLILrm30TK9A+zq7c+B1M0z1MtT+mPKnqIMTTX7m5VmrcqOqf1n9s5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBD6D68AFE; Thu, 29 Aug 2024 05:46:26 +0200 (CEST)
Date: Thu, 29 Aug 2024 05:46:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] iomap: handle a post-direct I/O invalidate race
 in iomap_write_delalloc_release
Message-ID: <20240829034626.GB3854@lst.de>
References: <20240827051028.1751933-1-hch@lst.de> <20240827051028.1751933-2-hch@lst.de> <20240827161416.GV865349@frogsfrogsfrogs> <20240828044848.GA31463@lst.de> <20240828161338.GH1977952@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828161338.GH1977952@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 28, 2024 at 09:13:38AM -0700, Darrick J. Wong wrote:
> Though we might have to revisit this for filesystems that don't take
> i_rwsem exclusively when writing -- is that a problem?  I guess if you
> had two threads both writing and punching the pagecache they could get
> into trouble, but that might be a case of "if it hurts don't do that".

No i_rwsem for buffered writes?  You can't really do that without hell
breaking lose.  At least not without another exclusive lock.


