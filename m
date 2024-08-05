Return-Path: <linux-fsdevel+bounces-25042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4767948348
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0148283999
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC414EC44;
	Mon,  5 Aug 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8LO++w9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7714C599;
	Mon,  5 Aug 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889297; cv=none; b=CV5Z0UOZs84hK2+Kl/oQV8deN3iDqw+jJwxWpMZpPDDc9qdYX0hwgwVYPQexOnYZDVOpDGcQlt7LpXnxMK9fN9qzLxzgzxfdI+NO/s5OKyD0HPHQ5GyJCBjfLcMtLEanE6udQ/XtvVpHSz636KjYqV928UCVNNWmEVjEJeHl2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889297; c=relaxed/simple;
	bh=doePkK3W3rLwILpFW/eujrZrIn3uHHpRkC4DiWYh/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnfbBqqMND8QXPjn2UFDq9P0X/3Uh9KJ/qVbX+pbXQ+jGaNYnIFyKuIFa17ojlLldO5hrI/7+Aru19YvjIIYrzAPh3UuM5A61KxK9P6cx2NozlTqXrCIVlANBxmDHgae6qeMuZf0BKoRGHU5sEanM41ULucsPZdLehWBaM+fbyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8LO++w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAFDC32782;
	Mon,  5 Aug 2024 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722889296;
	bh=doePkK3W3rLwILpFW/eujrZrIn3uHHpRkC4DiWYh/mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8LO++w9rRwOTrK4vLzeFY2Fb+lpuYIW/Pmm2iLhyrBEKAWK14PMp9gmu2REMsfHn
	 RPF3R+ZKNCuC7aryhLYSQeEI2e7t+7tyCXWgbRU0QLeT/6U5KEISX6W75KzRUnC7Rs
	 uDKXdH8iw82itjYR8Zq/czLiWHwV8e0hRkdTpAaxEw7EZmvQ+MJfn6aknwjmtdIZeK
	 dqAcECA9OzzaInq7gL7Ooet8RDKmPi6J36kpyBbnbngqfOsjXQa88Zjuaxfdk7AWBu
	 7we6iXQsYtis/9i5jEjNh1tyqE3DuSHaOrxZxRk+2esnfMhFhsuZawqeBFCt5kp7tt
	 CQ1sRC3iF1JtA==
Date: Mon, 5 Aug 2024 13:21:36 -0700
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	wojciech.gladysz@infogain.com, ebiederm@xmission.com,
	linux-mm@kvack.org
Subject: Re: [PATCH] exec: drop a racy path_noexec check
Message-ID: <202408051320.A5A8674C@keescook>
References: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner>
 <20240805131721.765484-1-mjguzik@gmail.com>
 <20240805-denkspiel-unruhen-c0ec00f5d370@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805-denkspiel-unruhen-c0ec00f5d370@brauner>

On Mon, Aug 05, 2024 at 05:35:35PM +0200, Christian Brauner wrote:
> But having it in there isn't wrong. In procfs permission/eligibility
> checks often are checked as close to the open as possible. Worst case
> it's something similar here. But it's certainly wrong to splat about it.

Right, please keep the redundant check, but we can downgrade it from a
WARN. It's caught stuff in the past, so I'd like to retain it until we
really do feel safe enough to let it go.

-- 
Kees Cook

