Return-Path: <linux-fsdevel+bounces-74073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7DAD2EB32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B3A30E8A65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F434BA24;
	Fri, 16 Jan 2026 09:21:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D549242D62;
	Fri, 16 Jan 2026 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555305; cv=none; b=f3Yl6i7FPYJ7DTtZ2Rj2tfGnjW7OJt+y9M68+5heeTuYbUqvAPJqxWHIfKhMwq+41Zf2A42IDfyL0LM0tE36cRQfDO6yXJjdrPGGTUwMkqSToL+RQnpfR27mzcnVsl1oPmowiwjDS+yamRpp3qqbnREbcEbL0ggjl4cUTJ+4eVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555305; c=relaxed/simple;
	bh=QZ9EahSP6Mao9bL7DJkclB2GqRbhXKtA5LHlukP77uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up1sehIPsilYyyBUPznKzIMtZvzEPee++Ov9Z55Q5AB0HNbRW3M8gSkZceBLGS7qtWCdogGbVOqUAXUdn6QImNG5i0MZXfkfxzQNTMEkeedQ3hzG1+iqNVwzKm82zsE+gEFjYZSG9eGyZR9QE8kMqCQ3Ni5jRs2CJbpYrWdsXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28D46227A8E; Fri, 16 Jan 2026 10:21:39 +0100 (CET)
Date: Fri, 16 Jan 2026 10:21:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v5 09/14] ntfs: update runlist handling and cluster
 allocator
Message-ID: <20260116092138.GA21396@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-10-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-10-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	for (index = start_index; index < end_index; index++) {
> +		folio = filemap_lock_folio(vol->lcnbmp_ino->i_mapping, index);
> +		if (IS_ERR(folio)) {
> +			page_cache_sync_readahead(vol->lcnbmp_ino->i_mapping, ra, NULL,

You probably only want to kick off a read for -ENOENT here, and not
any error?

> +					index, end_index - index);
> +			folio = read_mapping_folio(vol->lcnbmp_ino->i_mapping, index, NULL);
> +			if (!IS_ERR(folio))
> +				folio_lock(folio);
> +		}

either way, this seems like a nice primitive for doing reasonably
efficient reads from the page cache, and I could think of a few
other places to it.  Maybe factor it into helper, even if you keep
it in the ntfs code for now?


