Return-Path: <linux-fsdevel+bounces-59028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60685B33F8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0962D7B293C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C55196C7C;
	Mon, 25 Aug 2025 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc3gs6ue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40154BA45
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125185; cv=none; b=Gn1Lkjd2PD2uCEWZcAcdvcIhB9xYRbZWHBZ/ys5vZJmwde2MEQ85Z2GqqMyg17AZVFAAU7LikRixXdt/F5YXgY59hv4hu9Ozx79nWMvfhOrIwEUJDYRijCN0Jrk6EKbuv+GeauDmwd8UaKGvvi/YLDErSY0YjIIGeHHgh4Rsn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125185; c=relaxed/simple;
	bh=pGyogf8PTH5fxOC8bjZqY92avA+xOlk1BIpeZaAbj7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnlZEWFaMSNQe74OJ0ve7N+Xuf4jfdJx0x7KPR6qen5zj+NCGME1ChDJ23KSNEOfFgyIXpumiZPux5oNQohqq1ntqgNVHI0Xl3I4gfpfHEDR2G2OWFSiyjN1o8WdOCr15xyXw/hJr5cKEN5Z05MVFoisvnkOniksv+IHG4xX3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc3gs6ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C968AC113D0;
	Mon, 25 Aug 2025 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125185;
	bh=pGyogf8PTH5fxOC8bjZqY92avA+xOlk1BIpeZaAbj7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kc3gs6uekEAFaP9W7NCczKoXjuRSnb/bUR7a3RgdDlK4uk0VgoHJsJlQIwEp4xDNj
	 zBWdBs6lnr14lRetC2wD2/hEzzPtUq24i7xbleNwGHNfJzPokKLShyWdUiIpf6vbEZ
	 cEIcCCifmEsWOABgKtumLOK4T2486Pt/FA3sQY3JWCDyq0JqSTFygHVf77afbWdodE
	 M/4SPGeh617+1oP3CliN1Mp0mQU1QZn5ayP7Yvl7hnIHTVdpK+7lTUN3PYraY1xgdU
	 iFeS1JTbd9h1KZF0ygBMRwVXz+Ti2pz1WtOUgX+fW5hiq3wCtv9ld/9ueoDsun5pwS
	 IDo7IXd+Sr1Mw==
Date: Mon, 25 Aug 2025 14:33:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 03/52] fs/namespace.c: allow to drop vfsmount references
 via __free(mntput)
Message-ID: <20250825-teilung-skeptiker-bdadb76aeeb3@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-3-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:06AM +0100, Al Viro wrote:
> Note that just as path_put, it should never be done in scope of
> namespace_sem, be it shared or exclusive.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

