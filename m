Return-Path: <linux-fsdevel+bounces-61328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68953B579A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFB83A4291
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63231305062;
	Mon, 15 Sep 2025 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCzCrQk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011030504B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937644; cv=none; b=iolK56x9mzTtkqrOr9Nwt5fdC/AhXGnq0vYXs7VnvhnodHeZkG6A9fhJ3dSmn+BE48fK5pSiG5KetQd0cQBbdrmcJDL2o1mXaTx6MQGNqPD+g+pmLg4lzzI6r28eyWgvG2iuCuYIBV1oguvbQM9e2GO2TOF/jz+BtiZLnAoVMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937644; c=relaxed/simple;
	bh=0W55BINdCqaJ6pXKUjzyntBG8JAu5i79v04RstOG8s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuWxb92297sC75StdLwcSAk1LCNFxr3E/OJcHm63USIpnAuXHMGreOigSwOGYH7OOVXSP51Nq6DGIv1tIRJJW4N/Ac8dPKgxkW+NVKzaHn1y7ytHhTi7L7tjkwagp+yKqSY2eNkDDyMff3OTvsEH24z0vusN/VE1Cu5wExqYQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCzCrQk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FCDC4CEF1;
	Mon, 15 Sep 2025 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937644;
	bh=0W55BINdCqaJ6pXKUjzyntBG8JAu5i79v04RstOG8s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCzCrQk71ttkC94+W/k3zNLMe7jbfTjQsGRcpf2Id1rnU274xfZU0MJWXCscWc7uq
	 2JD3g1FrWlWqFQ15gKkA/EYpqY3PTUtLxredIZR9HOfyVufEE5jeOHZElvQtsPaKTg
	 fIJ9Y7u5WzHK+eKmIx8ozdB1NgUCoiDlHtTniSl2qPcFuLoHg0f4eEV32PO5Pfz3Iv
	 gjU2XJhH+dSKEcddGVir1e3dPGjh6H5xdjJM8eJGSz8QkuvIb501ARpV2YB9I8NXLk
	 N0Gxkah3EkRetxzL2YpYDKN7gHVbJ9Jl/ypQQ9RsapDeDAI48XICSkP5XdYq18oDf0
	 EqK6lJwrLzYXg==
Date: Mon, 15 Sep 2025 14:00:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	John Johansen <john@apparmor.net>
Subject: Re: [PATCH 2/2] Have cc(1) catch attempts to modify ->f_path
Message-ID: <20250915-exkremente-fotos-98f29ad8106a@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091458.GC31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091458.GC31600@ZenIV>

On Sat, Sep 06, 2025 at 10:14:58AM +0100, Al Viro wrote:
> [last one in #work.f_path, following the merge with #work.mount and #work.path]
> 
> There are very few places that have cause to do that - all in core
> VFS now, and all done to files that are not yet opened (or visible
> to anybody else, for that matter).
> 
> Let's turn f_path into a union of struct path __f_path and const
> struct path f_path.  It's C, not C++ - 6.5.2.3[4] in C99 and
> later explicitly allows that kind of type-punning.
> 
> That way any attempts to bypass these checks will be either very
> easy to catch, or (if the bastards get sufficiently creative to
> make it hard to spot with grep alone) very clearly malicious -
> and still catchable with a bit of instrumentation for sparse.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

