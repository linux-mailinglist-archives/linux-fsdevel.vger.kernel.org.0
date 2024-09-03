Return-Path: <linux-fsdevel+bounces-28360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51336969C30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1680B22D47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D21AD259;
	Tue,  3 Sep 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="noyAzaRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8621A42DF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363670; cv=none; b=KsWP4bjvXkV2xZwQ7djtDQTEOi/JqwvY46AfKtaaeYmHfYNzL+njSNGEhsyGbiWmA1iCwaVh5aT+DmxS5Vy8Zi1C58VM5swvifDVXo8dhj6qMnRYkDX5TIyhvwU7lKrnT2wOxWsOmJT25MyKuy+mLNS8iA+zbKjkSdtpaIvjXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363670; c=relaxed/simple;
	bh=ZHWe71gDWxdrYe7NkRPXLT2MzR6OBiqbvi4uRaZipAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK/ARXqXrEjhqncB4ojhJlW9gwwDYo/RgSRDyr9tFMqHnE/GE1O0vbMaQJXRXXomRkzxwJjYxkI26MyxQ3P3BY+jzn2b++Z6BJt937RC2oZ274PX2KKlkOsNEY+o8hA9HaTL98Gs2IZKpVio8LP2YmCsihA583017UIXzUVOc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=noyAzaRN; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 483BeYf6027219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 07:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725363638; bh=9uDcnDmRUAt/LFQyJrObeVyUY2/vhUilyf6vG2h3AhA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=noyAzaRNdP+rfmt/qLz8IZCdb6ZHDvAYbbnbnkyvzgUoLtYVV6jM5aSrsOnDmndVW
	 MwRj8APicIvs1lE+vu8kCOHWXd1ivqm31ojIrgHL3XzmLZvrAK3N8ZNplHERKHcxT/
	 LQlTJ2mgNQVw7LQaajBctkw0v+xjMiL/c7nw1GkQ3gvaI1Vu3F0vx6xz5y8OCI3u4/
	 l1ZeaZ3fVHXmRsBUrOCyaaaNaG2K7UHZr2aZF5+/r4zES3WbbqO8EffwAz6BfG3IAk
	 uN7LCtOVq30LhxkNREorgSJkud+DLeUkDUT79BX0X2ddZwrtLy7Mg/efxsl89WkEUl
	 r0n8NNJgbdH3g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B316C15C02C4; Tue, 03 Sep 2024 07:40:34 -0400 (EDT)
Date: Tue, 3 Sep 2024 07:40:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        krisman@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/8] unicode: Fix utf8_load() error path
Message-ID: <20240903114034.GC1002375@mit.edu>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
 <20240902225511.757831-2-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902225511.757831-2-andrealmeid@igalia.com>

On Mon, Sep 02, 2024 at 07:55:03PM -0300, André Almeida wrote:
> utf8_load() requests the symbol "utf8_data_table" and then checks if the
> requested UTF-8 version is supported. If it's unsupported, it tries to
> put the data table using symbol_put(). If an unsupported version is
> requested, symbol_put() fails like this:
> 
>  kernel BUG at kernel/module/main.c:786!
>  RIP: 0010:__symbol_put+0x93/0xb0
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x19/0x27
>   ? die+0x2e/0x50
>   ? do_trap+0xca/0x110
>   ? do_error_trap+0x65/0x80
>   ? __symbol_put+0x93/0xb0
>   ? exc_invalid_op+0x51/0x70
>   ? __symbol_put+0x93/0xb0
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? __pfx_cmp_name+0x10/0x10
>   ? __symbol_put+0x93/0xb0
>   ? __symbol_put+0x62/0xb0
>   utf8_load+0xf8/0x150
> 
> That happens because symbol_put() expects the unique string that
> identify the symbol, instead of a pointer to the loaded symbol. Fix that
> by using such string.
> 
> Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

Nice catch!

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

