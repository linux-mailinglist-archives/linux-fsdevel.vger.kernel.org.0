Return-Path: <linux-fsdevel+bounces-66338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780DFC1C265
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E309188678E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64E33B6C1;
	Wed, 29 Oct 2025 16:33:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D752BE7CD;
	Wed, 29 Oct 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755626; cv=none; b=IMvDktxNxZSlBYrwNayndn5X37FnFcMVmBYHMwzZdK2YUty3G8oaZu07VfBC47y5NElVFd6pnpsoBApEv7wmnSTYJAOOC09aJZo11Zdno9YHvJD7TWfUZi0Zr+T7RNYlhcueJpkFALWsCJ9L+RJ+E4pkRnD4PX8abz7UZfIizLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755626; c=relaxed/simple;
	bh=QagiAdPJNd6tmdwGW6NXKOXyfexgcYV3dAqjz49bUqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5auHy2zkHpAR1uZKRyXoymkzl10xx+KvUqXWB66/H+p7kBzlNNqI3iEGSc/S/SXGw7dW3x00l6Y5KFQ/Cq3WRXKr4nY3gFJ4yWRXuE+66wojWf/2r2Bdw9+tbAmaQxE7iTqi6DCATDm/AXeGbQlnz+FRGKDJR7rMr8+t28RyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6338B227A8E; Wed, 29 Oct 2025 17:33:38 +0100 (CET)
Date: Wed, 29 Oct 2025 17:33:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251029163338.GA26985@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <ea07dede-5baa-41e5-ad5d-a9f6a90ac6e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea07dede-5baa-41e5-ad5d-a9f6a90ac6e8@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 08:58:52AM -0700, Bart Van Assche wrote:
> Has the opposite been considered: only fall back to buffered I/O for buggy 
> software that modifies direct I/O buffers before I/O has
> completed?

Given that we never claimed that you can't modify the buffer I would
not call it buggy, even if the behavior is unfortunate.  Also with
file systems and block drivers driving work off I/O errors or checksum
failures (RAID rebuild, or Darrick's xfs healthmon / healer work recently
reposted) applications could also be malicious and cause action not
intended.  Note that this is an issue with all non-privileged ways to
signals this.

> Regarding selecting the direct I/O behavior for a process, how about
> introducing a new prctl() flag and introducing a new command-line
> utility that follows the style of ionice and sets the new flag before
> any code runs in the started process?

I suspect most of this code isn't run from the command line, but modulo
all the other concerns about unprivileged ways to opt out of the bounce
buffering this does sound like a reasonable idea.


