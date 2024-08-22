Return-Path: <linux-fsdevel+bounces-26682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C899F95AFAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A3B1C2221E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B115F3F0;
	Thu, 22 Aug 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv8L2qBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E6139D1A;
	Thu, 22 Aug 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313269; cv=none; b=HHabARVKLIbtImA4JU3m8a6A2TU7s/N0f9+RRhE5/fTRTBHkjJ6Tlfyr3Vn0nLYzIWGG12YRy7J2mTC+96VvS0XOO2+BIk5MML5XoJkA6ve9V6SXBLWK8Wfu0x0UoW0homnWBKz/ksCGA6mkuPBP/aAAjSq2NuqGX3Tg7NSmGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313269; c=relaxed/simple;
	bh=uSnDynklvX7IdSjujnB4XlMNdWjBb3XWSwgI4AMLTZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEZAhhcM+bTAOAvCWQ4wd9IOQ7E0/nqZ3k91i78lRK6lseH/giJ/QgLXxyU59SLzLWF39R3CpWx5E1s0Uko1sOJYIa8blubXQbsMM6NQsH8sBDjrp8zSUS3BX5h71TX0E/XgGURlm05/hxslfmWgULrKqohIeuxSBAR9EN6HMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv8L2qBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB48C4AF09;
	Thu, 22 Aug 2024 07:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724313269;
	bh=uSnDynklvX7IdSjujnB4XlMNdWjBb3XWSwgI4AMLTZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jv8L2qBJE0oMQVGA3L+nF7k/3D4zT2gc5SqvaXIwN3D2jGKxPaIvtKwWndHAG918x
	 fnwXDY1DdSfgIPghsydtwzPQkPe4ZWkkm3/j74DBUEd8mZ1HFOq3HkBvSfIqBxmHH8
	 jfo2f/ax4UE8eK6prNMNMT46c8yiyo30cWlEnlwTxJzb5F33HMvfGtNRF+FtWrIJGc
	 uFr/aa5REueuZpX1rQ1hCLu1UGid8GLxFXfiHyLI7Q3fZC6ERV4kWckzzDDesGwUUL
	 v7vcC9ZCEpFeaY6WeeXk970lFMeYuram8pvt8a/RTsa2b9VSDR+i1rxowzyI98sY8K
	 1QhbBtMUGLq6A==
Date: Thu, 22 Aug 2024 09:54:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] lift grabbing path into caller of do_dentry_open()
Message-ID: <20240822-planzahlen-szenarien-ecc66363fbe0@brauner>
References: <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
 <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
 <20240822003359.GO504335@ZenIV>
 <20240822004101.GQ504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822004101.GQ504335@ZenIV>

On Thu, Aug 22, 2024 at 01:41:01AM GMT, Al Viro wrote:
> ... and do that after the call.  Legitimate, since no ->open()
> instance tries to modify ->f_path.  Never had been promised to
> work, never had been done by any such instance, now it's clearly
> forbidden.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Yes, I like it!
Reviewed-by: Christian Brauner <brauner@kernel.org>

