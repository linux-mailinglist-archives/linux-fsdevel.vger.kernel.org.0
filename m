Return-Path: <linux-fsdevel+bounces-28184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A41A967BF3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 21:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBA4281CA3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F25B05E;
	Sun,  1 Sep 2024 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Z+aeCJIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613783BB48
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Sep 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725219437; cv=none; b=D/wX9CnXBnvZ12T+Bd1+BM/GEkoFaXc84T8E6BPMafw1mu9TtTvGnGvfB2i/J4hv9gaMpM58ogHDCCQdNFIuPiirK3I8NvzuK29u2YqyDvnAaFcQ0W45JbfK9SOCEA5TvKGcburCX4T7V9uWWlI8wpdqXCbxu8/PPeqnUsn7ynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725219437; c=relaxed/simple;
	bh=BwxkkNeZZumbw1DZeW6BsFY5zqCC0Swu1a2MG21LVlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZswuEO4N2e9KYpHVyA2fzWw4ZWpjPqpSKp/JhGkEG6fWEQMfBQK9nj+Mw5ZYzfUg21g6aRtF1i86ifBl2dujBCE2rNnO6gPFKnT7qY435jED9aOhY+lq73z+ze0Sk6r3sW45cBlST8YshgNnY6InTKZ8Wpcb51aAL2XRCQLsyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Z+aeCJIJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 481JaioL027304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 1 Sep 2024 15:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725219407; bh=7JurVhov2U4ESFGHcMM5LmqLQ3P6SExXTWSzJuUX/rY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Z+aeCJIJk+QF7JdpZCHcYL2zyBd/UdpuFu18Co3SU46OwGNvGNjQMyG3yCUrYdGyt
	 SYOzP7OF2IlI9GKpG2DRhh3lzzuqyIdz7WW2/rFrisp6k0gp39fSyYTEM9YBrN1sC7
	 v2V0kn3f1p7gtnJs5PpGwQ/2dxa3LdZsQVVHy2eBs1V0aq6QXhRGKUkruqfkD5KsQT
	 EaJmFezEYUUbDzNcf5O0+0fSdhPMkTY9iJxcnH8+C1peYFyGmFx2Y7gZU0LOHVWB2v
	 1XEJfnro2YvkuT6WcGumh+KcUWOY8Dc6XVRn1r7/GOMM9MsuiypQHaR6kZZ9NuCTRu
	 h9P+wVLvyHT8A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CE9C815C02C3; Sun, 01 Sep 2024 15:36:43 -0400 (EDT)
Date: Sun, 1 Sep 2024 15:36:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 11/20] ext4: store cookie in private data
Message-ID: <20240901193643.GG9627@mit.edu>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-11-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-11-6d3e4816aa7b@kernel.org>

On Fri, Aug 30, 2024 at 03:04:52PM +0200, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

