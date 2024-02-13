Return-Path: <linux-fsdevel+bounces-11307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B388528EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4811F250E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE4114F7A;
	Tue, 13 Feb 2024 06:26:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C111723;
	Tue, 13 Feb 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805588; cv=none; b=PsNP3ASpUVUlt0SxmBEy6kwUOz9QXWdxG9Rt076Yt9VXaPxpYfb9hg8B/Gmxg9aCHi9WopFrgx3YtsJV00/1UUfxQzf6qW4ov1UlaqJS3MqIwHI+ZKOikJXJJAQPElS+5GR3KeyCfecOtwMXr2qZgtUhwg2KERiovfzA5y45tuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805588; c=relaxed/simple;
	bh=+O2tyaoVKyeN1/GpDStbVQXHe/V4WUW88OyGlyBcHMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbznzPbMh89GtFvAh08UxlMnnbi4AB5l/BZyIGUS6pI0a3pWY6hwR92lDx2FqFFBobyL4BK9WkPmpWMld5fJ821sE9PbJKFGJ/TnovbpO/j53fXrSFOLeUcawpXhFn/d9eDtG7UXNtjd83mee5rd2/T6ExOyybi7p+CREgVP5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44B4D227A87; Tue, 13 Feb 2024 07:26:21 +0100 (CET)
Date: Tue, 13 Feb 2024 07:26:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 07/15] block: Limit atomic write IO size according
 to atomic_write_max_sectors
Message-ID: <20240213062620.GD23128@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-8-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 11:38:33AM +0000, John Garry wrote:
> Currently an IO size is limited to the request_queue limits max_sectors.
> Limit the size for an atomic write to queue limit atomic_write_max_sectors
> value.

Same here.  Please have one patch that actually adds useful atomic write
support to the block layer.  That doesn't include fs stuff like
IOCB_ATOMIC or the block file operation support, but to have a reviewable
chunk I'd really like to see the full block-layer support for the limits,
enforcing them, the merge prevention in a single commit with an extensive
commit log explaining the semantics.  That allows a useful review without
looking at the full tree, and also will help with people reading history
in the future.

