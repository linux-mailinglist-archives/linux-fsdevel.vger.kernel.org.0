Return-Path: <linux-fsdevel+bounces-54815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDCB038D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44873B2CD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F72F43;
	Mon, 14 Jul 2025 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+ns9jDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F812376EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480882; cv=none; b=CpX9WqN9x9kLiHBxmeVBGMn1BG7cnXwmbcruwvPzcgqruBQ7TyEe9TtCce/t9jSmCz56ezANlujhjKAyWpeou5/Z6NXD61TQdaEHNUMDR9QD/XGyOpDtEA4bulZDgkJSZR5v54CoRp60N4omNE1JBSpYy3paflCtBVcZPgwOosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480882; c=relaxed/simple;
	bh=5W6hmGBkKom8pd2zOkSnvxklgMeom00PdvyQeGUJJDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVHw+klFwpI+W1ZxPE05eEpvtmsvqO7ZxhwtpvKXEWF1gSlRnZjHtHWxKsUb0qoHyYYFaaPnRZoajaM8k9+tlHCdu4wELwoUZ85yqSwWNFW+qRN/2XmLlb78op2e7bGqvghHhpZKgGYGx7dLIGJw8U8eS6aw3cORJXlI8slQRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+ns9jDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F171FC4CEED;
	Mon, 14 Jul 2025 08:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752480881;
	bh=5W6hmGBkKom8pd2zOkSnvxklgMeom00PdvyQeGUJJDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+ns9jDdZIxTqjocPZYiIk/KOLoNLJa7lqgbd4uuYmbYghlXo4ntndDxrsItvJvOx
	 1uqiN00cHPKcfqxLUcA+9TqrUTnOGO8ojnJoQW4nyKPEul3NgbVD/XbjhO9O6i776b
	 azGVeOdmrUQoPwmKeW7zKOs6wiJowdpvYWsbVWjI6KqCp7Ps3qaT6REjqxUJI0pDEp
	 d49/Idb2G3jU+uKREvDeRZMsTZmn/SYrRkuU0NIpIGeodQ1dXsP1+Tz6Kn137PB6EY
	 1UKBus+QilPRzdaZolh5MKzDoDrV8RMEjVfAdNG7OCFndOu3gp90znGxGwQ4zLjGmH
	 UMgvQvZegFJHQ==
Date: Mon, 14 Jul 2025 10:14:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix a leak in fcntl_dirnotify()
Message-ID: <20250714-kniebeschwerden-wachdienst-66609223c4b5@brauner>
References: <20250712171843.GB1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250712171843.GB1880847@ZenIV>

On Sat, Jul 12, 2025 at 06:18:43PM +0100, Al Viro wrote:
> [into #fixes, unless somebody objects]
> 
> Lifetime of new_dn_mark is controlled by that of its ->fsn_mark,
> pointed to by new_fsn_mark.  Unfortunately, a failure exit had
> been inserted between the allocation of new_dn_mark and the
> call of fsnotify_init_mark(), ending up with a leak.
>     
> Fixes: 1934b212615d "file: reclaim 24 bytes from f_owner"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

I'll grab this into vfs.fixes and send it with the batch I have in
there this week.

