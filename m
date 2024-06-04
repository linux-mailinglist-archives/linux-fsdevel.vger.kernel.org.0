Return-Path: <linux-fsdevel+bounces-20936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1F8FAF20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6281C227E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201156A343;
	Tue,  4 Jun 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="YtAkYBgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20EE1442EF;
	Tue,  4 Jun 2024 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494225; cv=none; b=Y1Ry6+ZGtRPsEfcCjPm4NjW3YoP1mHBznXSCnQlZexZ5mBEWnhZfJRxRHPiMDsyaKOb8TY16apuBnH4brbmk4qV5qdTqF/UuK+UqOoIkw+zGPH53q2wbF45Sl2nlMRwpLyfUw7/xOCFe0JDT5Jz9hk20nv7fxOpQuaOCAbb/XDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494225; c=relaxed/simple;
	bh=5RkdUsK0tny5QZcZrgeZEhT5qBBrTYbEIMgRpQp+U/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JREG71UZ87n/wBjSaCoEm39R50ZPY0/D7uaqAepgR7qFrV6dfIQMEseapI4Z7Gf7x5xcUYUlsnu2uex3U6sL9JHjEx1ID3CNxYdiAjq3oAYwPS6/4Er3OPjuHYVFnLUzaV5WaOQix+6ye60CBgufGn1GUYqpodnru3QKWcoX5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=YtAkYBgi; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Vtlyt3kv8z9sqF;
	Tue,  4 Jun 2024 11:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717494214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/wyixPQKPllzlkQ6nP0MNk7Q+TX9oe0qPOvgtCB3QtA=;
	b=YtAkYBgiDiiLTrSB1xXRBsq9S9oVQd4+fGLl114XZLZfFLqEjmSRSi3OD/ewx2b4xsFrin
	b31N9SmU65EekOzDKNDv/0VOdTQC76P9QfvlKf2AMY5TZpbIK/XI8ojK3aSFwdx+DAE6j5
	TUrzR5fJsAaKzjhai6vLP5SOdNCd31xk0yfdOo3EPOJGxACiklOpHTpNuPSoQSkjXee9V+
	bfUAHw5Bx49k5i6dyWfpCfn8RpXkeCERgAjUoxIKsiaVISFqz3t1aeX8py5FO6HZnWBB+i
	j5epziGzDMKCXz/rHreSnRbSe6R5xg7SFo73vhNBVNNuRmT53/F2MZP0GtcEEA==
Date: Tue, 4 Jun 2024 09:43:31 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: chandan.babu@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
	willy@infradead.org, djwong@kernel.org,
	linux-kernel@vger.kernel.org, hare@suse.de, john.g.garry@oracle.com,
	gost.dev@samsung.com, yang@os.amperecomputing.com,
	p.raghav@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, mcgrof@kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240604094331.gybm6la3xdunpcin@quentin>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-8-kernel@pankajraghav.com>
 <Zlz+upnpESvduk7L@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlz+upnpESvduk7L@dread.disaster.area>
X-Rspamd-Queue-Id: 4Vtlyt3kv8z9sqF

> >  static int __init iomap_init(void)
> >  {
> > +	zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
> > +	if (!zero_fs_block)
> > +		return -ENOMEM;
> > +
> >  	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> >  			   offsetof(struct iomap_ioend, io_bio),
> >  			   BIOSET_NEED_BVECS);
> 
> just create an iomap_dio_init() function in iomap/direct-io.c
> and call that from here. Then everything can be private to
> iomap/direct-io.c...

 Sounds good :)

