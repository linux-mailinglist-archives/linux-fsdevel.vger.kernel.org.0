Return-Path: <linux-fsdevel+bounces-25308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E046F94AA12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B61C20FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63657407A;
	Wed,  7 Aug 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPhoAXQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2B50271;
	Wed,  7 Aug 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040812; cv=none; b=M/RiWBjMAosAKy1jjVFsSVpYFkmosYvY5ULA1EMxZDfvRg/Sch+XOK9+8iFItafrlk25sxKE5FwYGKhj7OzCUv1Ld3f5CUICMKpPygak4wfVltkIQpfTfSNH40DSndq4/rsJKmGx82IntaJOhs6CpxcRQU47/jr26GupkIxG6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040812; c=relaxed/simple;
	bh=ZRZuNRg5Y5wO3tVO/sFSpZoOyFYN4iuPKnrf4slOW5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiObQGD5Qz7+8+RG9G4Lk7sGvPnxBmiV6v0wxDdPof9aKAVLNCulJrFhFysA/MsO1GkbVil4GOwT57Qmcu8N+7GV6T5tjIjQs2QBsmfSEz01oBUuDj6if2srfcORoa33wBdBU7uW5rCAsVau5eNNLlpMK+dWByYIpf5xnelhp7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPhoAXQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A40C4AF0B;
	Wed,  7 Aug 2024 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040811;
	bh=ZRZuNRg5Y5wO3tVO/sFSpZoOyFYN4iuPKnrf4slOW5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPhoAXQFPT5nmzqDa7/81u3XKeTtzU3RwRCy6buuR2yKyYPZkUtFw1K5UvKvo1KO9
	 vq/16gXrjyYfff5dAYQoFPwk3iV6jM7wfpHqUDshKpwIiD/BsW0pjeS8NJkeRSPtAA
	 fC/P9wI8UD+JlhC/S8hmuT1WDdTQOmiL8NDS66tHp2B4kjtS/BNPMqCtTIkbcDK3L+
	 AXKGGR6SuWUdVjaSMcw6AtAqV4qIjYUwiDY1YKDZQIsdsKxohsQzLAy5vlYAV1jq1g
	 8VBJcVvteXRCzYvaF886I4PVJsSSRu1FQeBhR/rE0MzN2rR0Ormj3kyEZ+RFTl0ZVT
	 znv9jdrQouUIw==
Date: Wed, 7 Aug 2024 16:26:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240807-erledigen-antworten-6219caebedc0@brauner>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806-openfast-v2-1-42da45981811@kernel.org>

> +static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
> +{
> +	struct dentry *dentry;
> +
> +	if (open_flag & O_CREAT) {
> +		/* Don't bother on an O_EXCL create */
> +		if (open_flag & O_EXCL)
> +			return NULL;
> +
> +		/*
> +		 * FIXME: If auditing is enabled, then we'll have to unlazy to
> +		 * use the dentry. For now, don't do this, since it shifts
> +		 * contention from parent's i_rwsem to its d_lockref spinlock.
> +		 * Reconsider this once dentry refcounting handles heavy
> +		 * contention better.
> +		 */
> +		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
> +			return NULL;

Hm, the audit_inode() on the parent is done independent of whether the
file was actually created or not. But the audit_inode() on the file
itself is only done when it was actually created. Imho, there's no need
to do audit_inode() on the parent when we immediately find that file
already existed. If we accept that then this makes the change a lot
simpler.

The inconsistency would partially remain though. When the file doesn't
exist audit_inode() on the parent is called but by the time we've
grabbed the inode lock someone else might already have created the file
and then again we wouldn't audit_inode() on the file but we would have
on the parent.

I think that's fine. But if that's bothersome the more aggressive thing
to do would be to pull that audit_inode() on the parent further down
after we created the file. Imho, that should be fine?...

See https://gitlab.com/brauner/linux/-/commits/vfs.misc.jeff/?ref_type=heads
for a completely untested draft of what I mean.

