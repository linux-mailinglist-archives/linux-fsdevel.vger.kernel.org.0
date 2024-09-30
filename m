Return-Path: <linux-fsdevel+bounces-30394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D068E98AA79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6981F21641
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66218E354;
	Mon, 30 Sep 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GJ6XjISy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0F196455;
	Mon, 30 Sep 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715755; cv=none; b=fi7ts+QTxrE/gM/fzBzAw0QSI6H1emF+wXp0S8tvBRoj15CkjTodMsNcsP70qAJunAdTTTyHz5usHmenn6tXYsPHOcpYcRU1wiE7KhesVvdqapH1tOYWITRdQOWr9ygZOwwwtEI6qmqhdx1Z/2R/GXABAWRI3cNe0Gt+OXV9uLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715755; c=relaxed/simple;
	bh=JfHd3X4HlZBDMgDERyAbbeCgTP8rWRA21aXzyD+GkP0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fDUnc9b/iPpmBV3jbI9x+NzznqugY7AzFCuAR6ZBPyzNKbQBwlqvsBrROgQlqzoKvaFXcfDOvM2wgD+mn/yOAb2HvaAp2MBPel91WuuGoUGs4keex0nRGtFpNe+NQKgMXrdPRl9I54AqhK15H5CkC+soAEjxajwBovEV6kc6UVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GJ6XjISy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54ADC4CECF;
	Mon, 30 Sep 2024 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727715755;
	bh=JfHd3X4HlZBDMgDERyAbbeCgTP8rWRA21aXzyD+GkP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GJ6XjISyC67KIwsL0CH4wM7oesvXpWGYyDcdcBTTfT6Grigd2vSGp4YveebenE5Qa
	 Z337DNbYuBSU7LPhsBdWNWpdV0Pvu4NUvgpNeerBTRu0ZWygao6rhyCbid2INK7awl
	 +8S8/ASh3NQaMBJWlZXSlmBlFKeyhAe9usVAdmSc=
Date: Mon, 30 Sep 2024 10:02:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, skhan@linuxfoundation.org,
 syzbot+4089e577072948ac5531@syzkaller.appspotmail.com, willy@infradead.org
Subject: Re: [PATCH v2] Fix NULL pointer dereference in read_cache_folio
Message-Id: <20240930100234.f7e91af05adeea036e0be8cc@linux-foundation.org>
In-Reply-To: <20240930090225.28517-2-gianf.trad@gmail.com>
References: <20240929230548.370027-3-gianf.trad@gmail.com>
	<20240930090225.28517-2-gianf.trad@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 11:02:26 +0200 Gianfranco Trad <gianf.trad@gmail.com> wrote:

> Add check on filler to prevent NULL pointer dereference condition in
> read_cache_folio[1].
> 
> [1] https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531

Test case https://syzkaller.appspot.com/x/repro.c?x=10a0d880580000

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4f3753f0a158..88de8029133c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2360,6 +2360,8 @@ static int filemap_read_folio(struct file *file, filler_t filler,
>  	/* Start the actual read. The read will unlock the page. */
>  	if (unlikely(workingset))
>  		psi_memstall_enter(&pflags);
> +	if (!filler)
> +		return -EIO;
>  	error = filler(file, folio);
>  	if (unlikely(workingset))
>  		psi_memstall_leave(&pflags);

do_read_cache_folio() already handles a NULL filler (from
freader_get_folio()'s read_cache_folio() call).

	if (!filler)
		filler = mapping->a_ops->read_folio;

so I'm suspecting that an appropriate fix is to teach the underlying
address_space_operations (appears to be from /proc/pid/maps) to
implement ->read_folio().

