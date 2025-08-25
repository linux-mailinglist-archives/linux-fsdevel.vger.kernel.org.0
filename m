Return-Path: <linux-fsdevel+bounces-59138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF66B34E16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51DD1A834B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778229ACD7;
	Mon, 25 Aug 2025 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbG8wmlh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D9E571;
	Mon, 25 Aug 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157428; cv=none; b=kAV4TmleXSX1yHXj7uIqgiiX3zYDAmkAEn0p3MRLe9dY6jsytARgkGS5isYNZtFcekA8IAd1ct45hMqiVf/82xJVJ2FOQ5/E3SIEMRkYkn50eR5VxZ5/9BfmJ6xZctFZcbXZyS4aMs3Ttvw0/kqU1r2hu0q063S/Cj69344sBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157428; c=relaxed/simple;
	bh=GpvMZ0qAhXCQKnlOM3cfGnpFhmf7DlrrZY6C6LnJMBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVlbPtzzoZWxoDkOYvv9AozZsl7VCfJEYn3R/AYhyd1565LZrgIwJ1ncCnUpETYdWuPfFzq1xn0mrpMmhrknl+T5iY1tnLBrKfRVW4/tX+sNy9OzFUYrcKsf2nfBMfbFtls83EXpE99VCOBA2Pi7EFIYJNhgC/n/SlaXy541E3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbG8wmlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCB7C4CEED;
	Mon, 25 Aug 2025 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756157427;
	bh=GpvMZ0qAhXCQKnlOM3cfGnpFhmf7DlrrZY6C6LnJMBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbG8wmlhX98AevAL7T100EjjUxx/DkwgY56m/0kpVaEMmboBt5R5f3z4E8ElGgq9L
	 rq9Zbt427TSgUaMiWzv5EFeF2CY2L0XxeqeYTWd+Uxfdbw5ofi49Y2/uSQ6zsqgIyp
	 /hW00aJyacKCH+VKN1IzmaklOwMBC2+NwPfRPjX5GDgnkXKL8LjSbEOLE9weg8bUaZ
	 TqF/nMY6ZSG67XCUqV47xmQaCsaHPiGJc9ZnJTZL8SWmKlM+NkFcNBLVT+A8gdJYZw
	 VFR9rsCRaPFJGQTsKZRZQSZP8GZN5xzZSh4ml+dCwBnAuc6M4AUQTBWOII+rsLS4f5
	 8j7CQJyeVKwTA==
From: Kees Cook <kees@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Cc: Kees Cook <kees@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Replace offsetof() with struct_size() in fill_note_info()
Date: Mon, 25 Aug 2025 14:30:23 -0700
Message-Id: <175615741923.2091902.12040309987283385487.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813115058.635742-1-zhao.xichao@vivo.com>
References: <20250813115058.635742-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 19:50:58 +0800, Xichao Zhao wrote:
> When dealing with structures containing flexible arrays, struct_size()
> provides additional compile-time checks compared to offsetof(). This
> enhances code robustness and reduces the risk of potential errors.
> 
> 

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: Replace offsetof() with struct_size() in fill_note_info()
      https://git.kernel.org/kees/c/a728ce8ffbd2

Take care,

-- 
Kees Cook


