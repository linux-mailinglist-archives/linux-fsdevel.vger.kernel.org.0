Return-Path: <linux-fsdevel+bounces-59815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B981B3E217
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA5200FCE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCBD322775;
	Mon,  1 Sep 2025 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZh8e3nC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A577813DBA0;
	Mon,  1 Sep 2025 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727745; cv=none; b=h1IP7yHvGnY0Tln2QffbnRy3FlSJaStu48PnoYH5NtpWgft2HReMawlIEAFvhqzIC/GaHDWfq5ODlDGOMUJJF8mHd1BfsEo3O2EwNUirSwIBp0gXuV3ii2OuWdv35iHrt8k8VCQHn7KS+lBFBxp9i5YAqwLrTHtc1REoL+ejx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727745; c=relaxed/simple;
	bh=LhPPWEaamsmIWnyrbslWBBEtN9yAgzBlsCW5xydLch0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFZMASgMKjlkmQnh05zVaTfkT37PbvPd4cCl7LnhEbfN+MWSLGJaAaIiE7ka3IdQsAlIXqLJpNaUw0h9y/8iH/Ed2+GCF5clcvJKueUnhbWFZ28bXZSO6+fJ94xhkQvzd6POOb6TnYcBD09m4948Sm8XetCvcQxH6YIoQV+/h14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZh8e3nC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A2FC4CEF0;
	Mon,  1 Sep 2025 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756727745;
	bh=LhPPWEaamsmIWnyrbslWBBEtN9yAgzBlsCW5xydLch0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZh8e3nCeH//ensosA3FWAubiNQ8MqGtxFKazz6sZHrOwnxqS62WKyUtGk45dbEz/
	 EJmLjsxh5McImZCuSJhRcWoHQAuE6Bx+tirT9qHIutVzYfBkaMsPRdUTbGsn018oWG
	 w6UyTDB6w8lle+NMV41g9i0YoC2Czn8XTbjOvFJtUbP0tmMg2xaa93ZyLl2VKYwG7D
	 oqNCDzSp1L4zqX8ORvhC7dOxhfjYQfO9Y+tmhlvOFlHNAKL86e43VNAmdALlv5vXuU
	 mfMf7sPnuyZgnwxgz3oykpXKEJnPewip6nbEAzH99DMATHok0RHvYmprO9l6WnrNQw
	 sJJ2PhWQ+qgjg==
Date: Mon, 1 Sep 2025 13:55:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] rust: file: fix build error
Message-ID: <20250901-beackern-begonnen-0d7275fd367a@brauner>
References: <20250830040159.25214-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250830040159.25214-1-work@onurozkan.dev>

On Sat, Aug 30, 2025 at 07:01:59AM +0300, Onur Özkan wrote:
> Fixes an obvious error most likely caused while
> resolving a merge conflict from other patches.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508291740.MyzqNwyg-lkp@intel.com/
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---

Thanks! I folded this!
Christian

