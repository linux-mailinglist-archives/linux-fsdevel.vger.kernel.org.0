Return-Path: <linux-fsdevel+bounces-23582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1092EC43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B790E1F229BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274316C84D;
	Thu, 11 Jul 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkpS8sXy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EC15B12B;
	Thu, 11 Jul 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713927; cv=none; b=HNHAiV9uqCHxqU+brvAHN+6I5/qtSZsoqoslH3zjiP+Dis0NACkrZmZK+oYiLcS0nO1xar6NRuHxmmhclXEIozODLeLwvbBgrVIvawaSYmIHraxnhXFu/BgrVHAh/P12BACkZA6lXC0GJX1NT5PmQUk18DAPyYSIxfTs7MQjCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713927; c=relaxed/simple;
	bh=nruze7s6VzNIuBhxWiGn100rvALuWu3sTKu1xVD9fWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSxQUBnbQrTahedeq6zzk2PV8V99TvcyKXZTamyTiiYg1BvKXDc11BPAm59uQjcTmbI/s2PB/DQxaD70hOK0LoQSO9cx2pcNGEb/7bER+o4kufOHqT6O6FVOXgtrJDLuSpGB4/3+hLN0CSURDKpPgK9nhQ3zX+1H8D1L9mbdeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkpS8sXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939E1C116B1;
	Thu, 11 Jul 2024 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720713925;
	bh=nruze7s6VzNIuBhxWiGn100rvALuWu3sTKu1xVD9fWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkpS8sXyrSEyTizw1V9j5SqIluRO/Fw9bcWcqaHzlTeZ0sSN/Z5CxBDAKd5UTDkQk
	 iWEU7qamvfSWST8geMeAdAm+DXfCi40ozjgMYS5qU0fQ6F5dwMsLiDk5qVK6lO1A9K
	 a8rBZ+GCV3l3LGHt1pNKRooIcvmMNwKZUGV3j/m1gaXJy/EJHmTUfyRxegC1MW+0e/
	 c8qSNnTp28WxqFG0FwKQdxu1z0MW4OVlOKOIEUGHPxaj9mMUgZyMt0gKO0Lne5m4pH
	 vrexoLBUtXkCkfOPHhOKrnVtFwiNHfhoHCdzdSwAHZzDs0jBDwibqGa+6A5pS8db85
	 vt8fT+p18Ivyw==
Date: Thu, 11 Jul 2024 09:05:25 -0700
From: Kees Cook <kees@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs/affs: struct slink_front: Replace 1-element array
 with flexible array
Message-ID: <202407110901.AB3DEF0A@keescook>
References: <20240710225734.work.823-kees@kernel.org>
 <20240711142928.GB8022@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711142928.GB8022@suse.cz>

On Thu, Jul 11, 2024 at 04:29:28PM +0200, David Sterba wrote:
> On Wed, Jul 10, 2024 at 03:57:34PM -0700, Kees Cook wrote:
> > Replace the deprecated[1] use of a 1-element array in
> > struct slink_front with a modern flexible array.
> > 
> > No binary differences are present after this conversion.
> > 
> > Link: https://github.com/KSPP/linux/issues/79 [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Thanks, I've added the 3 patches to my tree.

Thanks!

> I've noticed there's one
> more 1-element array in struct affs_root_head (hashtable):
> 
> https://elixir.bootlin.com/linux/latest/source/fs/affs/amigaffs.h#L50
> 
> The struct is used only partially by AFFS_ROOT_HEAD from affs_fill_super
> and not accessing the hashtable. This could have been missed by the
> tools you use or was the conversion intentionally skipped?

Yeah -- this was intentional. We wanted to finish conversion of members
that were actually being used by the kernel. There is a lot of UAPI and
"all possible data structures" structs declared in the kernel that we
were wading through only to find they weren't actually being used.

That said, I'm happy to send a patch to convert hashtable -- it's not
used so it can't break anything. ;)

-- 
Kees Cook

