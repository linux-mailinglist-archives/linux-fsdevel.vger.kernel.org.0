Return-Path: <linux-fsdevel+bounces-36227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF899DFCF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 10:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3D7B21797
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5D1FA17E;
	Mon,  2 Dec 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzZZ6ghj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9BF1F943E;
	Mon,  2 Dec 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131352; cv=none; b=OrQOEKseoAbcySU2lMztroHH5Z2wDwzXFY+G4PpLxtLlnWA5XieH4Z6PnTL9GBu56r8Wn5t2SArpWdZVXcr0E2m8AFTjvC5hGHG0XGHTsKMnR/UgL1kwcbjccdllKxycSGh91Qh7MWwZgNhq8sMRc3QtBlsUfeHAC6LtXJKHS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131352; c=relaxed/simple;
	bh=pXnYP2WqJw2efuIKrS4+y0ufhlCT/VEXuCTQAD5naC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMN92CjUBFkReFjLXuvWef5Uq1g/bTg2p5anEBSxjz4usWGxWONXkcZD11LkGeKBXnpV9qdQDSyxbOTkBtzp0w0YRH1NbaXH4GHFGulcqLpqTSxGXb/yTA+T2IEZWEBPkuHXmfmQyPuB6FghlIpFj2bB0nSQKTbYa0SVvjPpMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzZZ6ghj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D20C4CED2;
	Mon,  2 Dec 2024 09:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733131351;
	bh=pXnYP2WqJw2efuIKrS4+y0ufhlCT/VEXuCTQAD5naC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzZZ6ghjO8g/Rd8tLoNbO8d1hlGgxOoamr0IEwy+45m7HPZ9RTczRoaEaYRqa1Lqa
	 t8M/rW+AnqNvKubfZH0jnE9WMGRlMj2R25yKuoQFE3d+DUGBIqg3vlIXgj4eb8fn2Y
	 1nmc+6w3wQr+UNkZnFrwcN8gYjcx0OCDKbt2LBPayo0w8/0/Tned+dtzrLk7LHolDn
	 AEX0DgM+XRfYaRSfPDESlw/XCzMHrP9avs255aiCFHtX6+fkugZylNdRazGI5eAsJG
	 k1ZB+zbxOM0z9sDAlxTXwYfv2/EK9YDRXo8OaA4EdNTulKLLtwYKs26tDg1Xxr1ULW
	 nYsxHL4rOjflA==
Date: Mon, 2 Dec 2024 10:22:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "KASAN: slab-out-of-bounds Read in load_misc_binary" in Linux
 Kernel Version 4.9
Message-ID: <20241202-wahlkabine-posten-34e01c2443f9@brauner>
References: <CAKHoSAv+gLUmYioCQjKU46pEba6udNOLgTFxQ0MDVTKy_ehd=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKHoSAv+gLUmYioCQjKU46pEba6udNOLgTFxQ0MDVTKy_ehd=g@mail.gmail.com>

On Mon, Dec 02, 2024 at 12:31:13PM +0800, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 4.9
> This issue was discovered using our custom vulnerability discovery
> tool.

Unless it is reproducible on mainline please stop posting such reports.

