Return-Path: <linux-fsdevel+bounces-26681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD395AFA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C94D1C21463
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64882165F11;
	Thu, 22 Aug 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx2eGivl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA97139D1A;
	Thu, 22 Aug 2024 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313220; cv=none; b=u57kVGvlJgXG4jOkvqGLXjSGRxp51Nt/1wIA7xkr0PlzYY0TPMy04U+MWOwCq+z02YGBrgNCm33p+Lu8sAzxw9SkUtjCLwpWe4/kotSpAtisX4PE9S0LDR8m4MOA7FhHtX2tQUwZC8078HqonmbG830MON73c9MrcRxCr4DKaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313220; c=relaxed/simple;
	bh=5MWwjL1lHDk+PmepTUEP3i5nx/DKsYhVLEfFbpsYdKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfn8cnenzB1N4rYUrTLDTlWxPZVVTZ53RoLwyxWZJFikWrZJQoBmUZ3aVPlIpoHn7Kiz2rAQDcCNvLaKVi+UCgXDxc56if6pdPeYw8ChYKzvV72KTErtgHkaRSVSV69m3JAxsWv5a2qPbQhyAVEM2ibHRGAC6sgI334hZGz90XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx2eGivl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15D7C4AF09;
	Thu, 22 Aug 2024 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724313220;
	bh=5MWwjL1lHDk+PmepTUEP3i5nx/DKsYhVLEfFbpsYdKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jx2eGivlXHwSOqVHG3mKsy/U3qJ00pGtXRoHYTlm+Q3DcevxqzgmrxDq2ZNl7OB1j
	 vN47rcm4SrkzPFifG9xZGJzCTL5zhZc932vFLlel+Kd2RsCeOeCOmq4Mc3sua3w3fK
	 UX3oD50MuJompOk+RLEDY3gD98Orps7RTliCHarl2vwRJcHtk/dRGJBuYjM9EUqs1W
	 Nu29yjRBARyD0qtUyxB5nDribWHql4i0+LPJee7xGYkAtcLO0ZdeGLf3NDzRVBIuFU
	 BDKMsY7WAOEQHpOuWKCzfc/4aRb05ObpkXCiTZJEBP5pGJvPdekIFMucU+hyTK3zlR
	 e04z9u6ZyjSgg==
Date: Thu, 22 Aug 2024 09:53:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] don't duplicate vfs_open() in kernel_file_open()
Message-ID: <20240822-reaktion-reifung-d7eb09ca6c54@brauner>
References: <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
 <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
 <20240822003359.GO504335@ZenIV>
 <20240822003444.GP504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822003444.GP504335@ZenIV>

On Thu, Aug 22, 2024 at 01:34:44AM GMT, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

