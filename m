Return-Path: <linux-fsdevel+bounces-64070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1850BD7457
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911673B2E1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B891D30B51F;
	Tue, 14 Oct 2025 04:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yn1+yXRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70F21E0AD;
	Tue, 14 Oct 2025 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416612; cv=none; b=kQiw+Fir+pmWdCne/OGe9lWKt+cGchsIkx41lh3BUjn2buP1cRX4TaesvlPQbsvUjfI8LWvKNF+poUt+FwQKoT0iYoEyLxts+v26qcO4JJb94YpWbMOaNKELGG5q4b5aioYJenm016WQXpCBEuypSD/DBPHkqZDld+6J9lqPPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416612; c=relaxed/simple;
	bh=TlaRcGin2t5gVIo1Gwv/FGKJek987QTyU89u6pQlTzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf73vEg+SfRyUST7BzlQUu0S3gzkpP//8EAg8mP7uwyK2Q9rXde8WWoPGt/3jyr+x/a7xOo6X3l1E2ED2JU6NvCSK33v17bbiE9xCOPmAd2FWXoTCOvgTp/k9mAfubRlTlqjzdydLa7aSEPtk3Kvx8CLSXanByIXsGuQGc/ES9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yn1+yXRn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IMu0EiBQKuo88PicOuBaR9azVBnbX4FkUeISqr0YQqc=; b=yn1+yXRnkl5SR1liGQd492ggu0
	eKIuIjLRS3FAihC9qF01Ss3qXC/hcZAReCEjH7BFzEehHKeTcYyoiD9n5QLKTAxn3dwThaauNcF7f
	rMfoxA56J268eqqnUmqAXim8KXy3yVCKoupzcHp6EfWf5eNzqc7lYYMocPaDpNrZ5/YhHb8XzH3zj
	STjNoHKx27DCTtzmSXs7FRAF1k9JuFjK7BSvyqMW9jiAaOPOfEQZqTaGq/+2ULxq8Tlj3RUubqkke
	W8hFSoAnG51FNluHfbq9/qHc/SJNYDKxlxmSUQgXnQr/fk/QeQQCKM/ZrqR91Nl86SZUd3Dj9KPh0
	joezxn0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8WmI-0000000F7VU-1jvA;
	Tue, 14 Oct 2025 04:36:50 +0000
Date: Mon, 13 Oct 2025 21:36:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <aO3TYhXo1LDxsd5_@infradead.org>
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 13, 2025 at 07:35:16PM +1030, Qu Wenruo wrote:
> - Remove the btrfs part that utilize the new flag
>   Now it's in the enablement patch of btrfs' bs > ps direct IO support.

I didn't really suggest removing it, but splitting it into a separate
patch in a two-patch series.  We could probably even move everything
through the btrfs tree for 6.18 to get the fix in.  It's just important
to keep infrastructure and user separate if you have to e.g. revert the
btrfs part for some reason, but we have another user in the meantime.
And I plan to use this for zoned XFS soon.

> +	/*
> +	 * Align to the larger one of bdev and fs block size, to meet the
> +	 * alignment requirement of both layers.
> +	 */
> +	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> +		alignment = max(alignment, fs_block_size);
> +

This looks much nicer, and thanks for the explanation!

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

