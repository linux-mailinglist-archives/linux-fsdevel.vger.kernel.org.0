Return-Path: <linux-fsdevel+bounces-15199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0578988A8D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A676BBA26CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63534597A;
	Mon, 25 Mar 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAVyeJkm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948601BC46;
	Mon, 25 Mar 2024 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361362; cv=none; b=PC+9qBh28Vf1UigEdNHsxkaxGO9XoAwG3zWYKfLE3UQWg/yJMDesEMN/CC56J47wyADWzsTrj99UGesEB2bxp3QZdMwbHAALX7pKDOGTzbpf+Vu3pUmXl7qEI5CMpApeF9tMdTtLnqcJ5OQnd+3yawHvEnm1TTEBiNrmAoAc71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361362; c=relaxed/simple;
	bh=+Ni54kzZZJZ8Gpflipk7sMkXhsxVvZJr72+bdfSCAWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1HArhJxtrvV+eddyepKvoGZOqg3xKYzA0Pq7ASD4e7Tj/zhwr6TZhFbGtK/1vv4j+k8j+ftb1ueXI8I+In9AJYBX77wRetlSH5/xiDBav93408rb1/vYs8Yxs8+5JtbAKbXi0fLWDFb8gRmW2OXMgVtVQO4WJfAZpA0Juuo6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAVyeJkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A7AC433C7;
	Mon, 25 Mar 2024 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711361362;
	bh=+Ni54kzZZJZ8Gpflipk7sMkXhsxVvZJr72+bdfSCAWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAVyeJkmpxeTN6Gxe2VGtXmpfHMhTMrpn/UXUh/Wn12y57WkwEnoAekyyvWfMg2qE
	 gzTc1VIB7QQqr4sWYFMAV5OKg1ncgL02/pD/vVxyLZG4KwXFeO1qkRJU2ZaIJrUZAO
	 fQib1lD8r/c7xoSZ0DEFM4PgT4/uJp7k+B4Dc3NS9veJVKXT7pq/GH2anB5Mwg/8h7
	 FO0nVgHeTPbD8/5ZTjwxRpL9jRk96Mle73oV3aAgXbDCJy5BkzDKGGQQT6al5CROnm
	 hJ58nyT9GCFwA+rC3A87WG5riMWck4SiRU92mtZHC7nwRUccM91gzavJqONMy0zDAV
	 ShVDbZD2bJMRA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rohGi-000000000z4-3YKD;
	Mon, 25 Mar 2024 11:09:28 +0100
Date: Mon, 25 Mar 2024 11:09:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
	regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] ntfs3: serve as alias for the legacy ntfs driver
Message-ID: <ZgFNWPCYQC6xYOBX@hovoldconsulting.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-hinkriegen-zuziehen-d7e2c490427a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-hinkriegen-zuziehen-d7e2c490427a@brauner>

On Mon, Mar 25, 2024 at 09:34:36AM +0100, Christian Brauner wrote:
> Johan Hovold reported that removing the legacy ntfs driver broke boot
> for him since his fstab uses the legacy ntfs driver to access firmware
> from the original Windows partition.
> 
> Use ntfs3 as an alias for legacy ntfs if CONFIG_NTFS_FS is selected.
> This is similar to how ext3 is treated.
> 
> Fixes: 7ffa8f3d3023 ("fs: Remove NTFS classic")
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Johan Hovold <johan@kernel.org>
> Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Hey,
> 
> This is so far compile tested. It would be great if someone could test
> this. @Johan?

This seems to do the trick. Thanks for the quick fix.

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Do we want to do something about the fact that ntfs mounts may now
become writable as well?

Johan

