Return-Path: <linux-fsdevel+bounces-15842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E9894509
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 20:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568C21C21258
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965094EB24;
	Mon,  1 Apr 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="H0AnMKKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6BF9DF
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997717; cv=none; b=taURWHC4vSStxmHp3+SDTr3qhuAOW+5bT7tXlahFFjtzSAPwgabQlqzFZvdnJbUdjDqVvSXwicR6EZHfCFNG3+/pgkrQS4iHc57uZ7o6bxteBp2LymGTiLTBtrMJmA7hkFCVuW5+7EvhkVLB3zfnElVOjysBnE7N7b6O+rcS+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997717; c=relaxed/simple;
	bh=r6IdAjbsnMRjT7xXt8kc/YieChud6GyMWyS26TCVkEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV4vbZyySntKJ55S2IimeJ/RJ1KfsVJpwhvETzA+5mbf7YyBOq0XwfyMaacWhQlUmqxirYVfFHjYEyF0/c4NHVg8LdUNQcrCBif9FWzgoAuus2vQkqPzKUTvvk8TjYDDvMMFZ1TXQiwmHB25b6gJvcsp5pO/s7Frx3oQO7Cj2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=H0AnMKKc reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3chAKLGYI7vRCGbZjOzOcMgWscRaMcKNC/Epd9mN3Io=; b=H0AnMKKcTJsF6Nyr3gupfTmIpO
	vkRX/Jc/8+XMdrQz/V+LJgra19P/pw/5hDzu6SQdUS6BQpejxNUyyRMj2V4E/KWdPljIJ+jS5YLlF
	UpOa6FtoicTBeMtjpUGSoeD6hCiZMoFysxrT5LTcb4vW6u7krkPuupTkW/kGdF4+a9JjICYCMxhne
	iq6ISvWuTmpMKOMGaySGtV4VDlR16sKecdJ0Q1ICEputvFX7ygy9/95E0g6EVFqdRofTPk3ZejToU
	G71aLJY8y8oPyJEmpKWOYiHV0zxNq8kREXqXra/WJlazoJ4WVIVaMoDbvmCody3BK0jDOBEVsw3Tf
	UchuUUtQ==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrMoF-003gQh-21;
	Mon, 01 Apr 2024 18:55:07 +0000
Date: Mon, 1 Apr 2024 11:55:04 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux@yadro.com
Subject: Re: [PATCH 2/2] configfs: make a minimal path of symlink
Message-ID: <ZgsDCGqQQCDxLx0g@google.com>
Mail-Followup-To: Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux@yadro.com
References: <20240401082655.31613-1-d.bogdanov@yadro.com>
 <20240401082655.31613-3-d.bogdanov@yadro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401082655.31613-3-d.bogdanov@yadro.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Mon, Apr 01, 2024 at 11:26:55AM +0300, Dmitry Bogdanov wrote:
> Symlinks in configfs are used to be created from near places. Currently the

Perhaps "... are usually created from nearby places. ..."

> path is artificially inflated by multiple ../ to the configfs root an then
> a full path of the target.
> 
> For scsi target subsystem the difference between such a path and a minimal
> possible path is ~100 characters.
> 
> This patch makes a minimal relative path of symlink - from the closest
> common parent.
> 
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> ---
>  fs/configfs/symlink.c | 59 ++++++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index 224c9e4899d4..a61f5a4763e1 100644

<snip>

>  static int configfs_get_target_path(struct config_item *item,
>  		struct config_item *target, char **path)
>  {
> -	int depth, size;
> +	struct config_item *pdest, *ptarget;
> +	int target_depth = 0, item_depth = 0;
> +	int size;
>  	char *s;
>  
> -	depth = item_depth(item);
> -	size = item_path_length(target) + depth * 3 - 1;
> +	/* find closest common parent to make a minimal path */
> +	for (ptarget = target;
> +	     ptarget && !configfs_is_root(ptarget);
> +	     ptarget = ptarget->ci_parent) {
> +		item_depth = 0;
> +		for (pdest = item;
> +		     pdest && !configfs_is_root(pdest);
> +		     pdest = pdest->ci_parent) {
> +			if (pdest == ptarget)
> +				goto out;
> +
> +			item_depth++;
> +		}
> +
> +		target_depth++;
> +	}

This O(n^2) loop tickles my spidey senses.  Reading it over, I think it
is correct, though I'm wary of how it might handle certain inputs.  I
also tried to think of ways it could short circuit the inner loop based
on the max target depth, but it can't know that without precomputing
the max target depth.

There are enough corner cases that I would think the depth computation
is a good candidate for KUnit tests.

Thanks,
Joel

-- 

"Hell is oneself, hell is alone, the other figures in it, merely projections."
        - T. S. Eliot

			http://www.jlbec.org/
			jlbec@evilplan.org

