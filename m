Return-Path: <linux-fsdevel+bounces-44421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A5A686C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ABA19C3E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB42512EA;
	Wed, 19 Mar 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7dkHlnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6F15A85A;
	Wed, 19 Mar 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372891; cv=none; b=MKAPGFpkM9gSyBoXJNepuCY7aEaUo4+SOlLrnWEy/vDeA+pu22QN0pThP8WTCxg8qFyc+ecSNRw6EUsNBGcZMazICSmHYuPBqy64CfFV6Znktj0IZm0JTc2W+BrQL1ju1N+xaEWE2/uxdZbGoQ7I99W5JVjnVawASvBAPR0uxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372891; c=relaxed/simple;
	bh=us+3NoWasNgbUERluow/uBpdmdWf+3LKdKCWew3Dxes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvvJO0yR8lpgk1bLhgUUVaydprOgSbNSJmnEe2T0jXskZtrUpsyT4sK4xDb+2vqiKGOdM7j8IfIzN9xfYVcfw6y39uHq+N2vGgWKjFqJTRV2eX4F/JfuONVOjmP5TLBoePNBw6oTiuad1o45TZVHKouj14jnvNzhX0yZY0ZL+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7dkHlnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4F8C4CEEA;
	Wed, 19 Mar 2025 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372891;
	bh=us+3NoWasNgbUERluow/uBpdmdWf+3LKdKCWew3Dxes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7dkHlnKclJneVf+jKYgfSS3yoGTkHgv05HVNkjpNiEeyYVoB7jyFeHcBdRKEp0B+
	 0bgrd/LRIhaUB4DFHX0EP6luJLEf5mx0Ybn3GdN6VFSg/Pv1YyJ2lBbJ41iVl7CGYC
	 PDYhWkcOPvuc0RPgVv7N+mMw9q4KAEMKa7kwy3z09scVuIzFVE7rsR3vL4DwS6hHwW
	 YjzWUOP5UJNtr8Qq3EX860XJHImnFkVTRWpWv9QXOZD5YBRHuzRu8DV6Mi9H9UcWLc
	 GumL0+gOlqC879eTUL9ZC5+xoFfPgUqE1bK+1zAQYO4SPEJwMp6K3u0qNZhS62nBsb
	 RW7uhMS9XuMtQ==
Date: Wed, 19 Mar 2025 09:28:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: load the ->i_sb pointer once in
 inode_sb_list_{add,del}
Message-ID: <20250319-peinigen-hering-e2933b004645@brauner>
References: <20250319004635.1820589-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319004635.1820589-1-mjguzik@gmail.com>

On Wed, Mar 19, 2025 at 01:46:35AM +0100, Mateusz Guzik wrote:
> While this may sound like a pedantic clean up, it does in fact impact

It also makes it easier to read. So +1.

