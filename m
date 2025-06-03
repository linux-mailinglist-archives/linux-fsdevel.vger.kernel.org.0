Return-Path: <linux-fsdevel+bounces-50491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F1ACC8B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B031897588
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C0F238C36;
	Tue,  3 Jun 2025 14:04:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A8238C06;
	Tue,  3 Jun 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959493; cv=none; b=C31iCWBOWGcLpG3iz/lWVXD6qLREFj0AUzGHJOkSVMkUVAXbOFDn9pzy0Qg4Q03OqSMGLFGGhIeF2LtV+St7Hb8PY9maL95xCETUxo7pmQ8zYYqrCi7cW2JX3vTgUajc01ltpC1qBXjFPEMJsYYYS+Q15my2qIzSldkF/dRndTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959493; c=relaxed/simple;
	bh=5QBnuiPhzjYB0sKEZkcAP5Cku3jQz7UexqyVVVNRdKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us01K8LJ93447qs18wyW43Vd7O/1Ygp9Xy9PmH6MBCpEIl8V8X3W1N02r9mRA5FKY4G8v242b6RL4ccgIA0QEYyHv47CJmTBEWb14ZUIor0gN6Iy0spE6zK1LGalOeFA7NpdtGwTQuWDamGPcOZ/iAiiLThOKYZ+HZugSNADoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 727C668D0F; Tue,  3 Jun 2025 16:04:45 +0200 (CEST)
Date: Tue, 3 Jun 2025 16:04:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	p.raghav@samsung.com, da.gomez@samsung.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	kundanthebest@gmail.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250603140445.GA14351@lst.de>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com> <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de> <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de> <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 03, 2025 at 07:22:18PM +0530, Anuj gupta wrote:
> > A mount option is about the worst possible interface for behavior
> > that depends on file system implementation and possibly hardware
> > chacteristics.  This needs to be set by the file systems, possibly
> > using generic helpers using hardware information.
> 
> Right, that makes sense. Instead of using a mount option, we can
> introduce generic helpers to initialize multiple writeback contexts
> based on underlying hardware characteristics — e.g., number of CPUs or
> NUMA topology. Filesystems like XFS and EXT4 can then call these helpers
> during mount to opt into parallel writeback in a controlled way.

Yes.  A mount option might still be useful to override this default,
but it should not be needed for the normal use case.


