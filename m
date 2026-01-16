Return-Path: <linux-fsdevel+bounces-74075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4FD2EBC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C78A3028456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248B34F47C;
	Fri, 16 Jan 2026 09:28:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B831BC84;
	Fri, 16 Jan 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555720; cv=none; b=Xy/QD9FG1u3Bh3y9+YtsJRSEA5pgkrV/td6ZRMMojIozEb6M8RLvr/tYSLoXwDURoDaiQMTZ9JZ+1m4VwjC54oKh2nrfd6POGPuGzUIPiA4GKj/hI/MtL3gjMCsviqxdYU98nZXynoIL821VkvcZatoyGcillbv+pY+eleTXuwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555720; c=relaxed/simple;
	bh=dBUhJpI6mXYVjQfOJlD05nAGp716WS2uhFaqvl5biCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+IO0CLVHvWEBCOSq0TPApkwbFvb/awPQzCghNnlpogHHlaWPHiCq0jfU/n8ugcUGjGAhpI/aJXjfy0QjQ7GwdX5aKwli4LZ8iV805O6lMdj7B3SeU0Kexy26oJChd/4zUwk/QSkvoswfNEKd3kqCdF0llwvZOfNw/N7rOC+iOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00821227A8E; Fri, 16 Jan 2026 10:28:33 +0100 (CET)
Date: Fri, 16 Jan 2026 10:28:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v5 11/14] ntfs: update misc operations
Message-ID: <20260116092833.GB21396@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-12-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-12-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 11, 2026 at 11:03:41PM +0900, Namjae Jeon wrote:
> +	if ((data1_len != data2_len) || (data1_len <= 0) || (data1_len & 3)) {

Nit: all the inner braces are superfluous.

Also why allow passing negative values at all and not pass unsigned
length values?

> +		ntfs_error(vol->sb, "data1_len or data2_len not valid\n");
> +		return -1;
> +	}
> +
> +	p1 = (const __le32 *)data1;
> +	p2 = (const __le32 *)data2;
> +	len = data1_len;

I don't think any of these casts is needed.  Also the variables could
easily be initialized at declaration time.

> +	do {
> +		d1 = le32_to_cpup(p1);
> +		p1++;
> +		d2 = le32_to_cpup(p2);
> +		p2++;
> +	} while ((d1 == d2) && ((len -= 4) > 0));

More superfluous races.

> +	if (d1 < d2)
> +		rc = -1;
>
> +	else {
> +		if (d1 == d2)
> +			rc = 0;
> +		else
> +			rc = 1;
> +	}
> +	ntfs_debug("Done, returning %i.", rc);
> +	return rc;

Just return directly using cmp_int() and skip the very verbose debugging?

	return cmp_int(d1, d2);

> +/**
> + * ntfs_collate_file_name - Which of two filenames should be listed first
> + */
> +static int ntfs_collate_file_name(struct ntfs_volume *vol,
> +		const void *data1, const int __always_unused data1_len,
> +		const void *data2, const int __always_unused data2_len)

Do we need these annotations for indirectly called callbacks now?

> +	if (cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG &&
> +	    cr != COLLATION_FILE_NAME && cr != COLLATION_NTOFS_ULONGS)
> +		return -EINVAL;

Turn this into a switch to make it more obvious?

> +
>  	i = le32_to_cpu(cr);
> -	BUG_ON(i < 0);
> +	if (i < 0)
> +		return -1;
>  	if (i <= 0x02)
>  		return ntfs_do_collate0x0[i](vol, data1, data1_len,
>  				data2, data2_len);
> -	BUG_ON(i < 0x10);
> +	if (i < 0x10)
> +		return -1;
>  	i -= 0x10;
>  	if (likely(i <= 3))
>  		return ntfs_do_collate0x1[i](vol, data1, data1_len,
>  				data2, data2_len);
> -	BUG();

.. and then maybe use the switch to untangle this as well, which
smells like just a bit too much deep magic..

> -void __ntfs_error(const char *function, const struct super_block *sb,
> +void __ntfs_error(const char *function, struct super_block *sb,

Why does this drop the const?

> +#ifndef DEBUG
> +	if (sb)
> +		pr_err_ratelimited("(device %s): %s(): %pV\n",
> +		       sb->s_id, flen ? function : "", &vaf);
> +	else
> +		pr_err_ratelimited("%s(): %pV\n", flen ? function : "", &vaf);
> +#else
>  	if (sb)
>  		pr_err("(device %s): %s(): %pV\n",
>  		       sb->s_id, flen ? function : "", &vaf);
>  	else
>  		pr_err("%s(): %pV\n", flen ? function : "", &vaf);
> +#endif

Usually if you have cpp conditions with an else, I'd use ifdef instead
of the negated version.


