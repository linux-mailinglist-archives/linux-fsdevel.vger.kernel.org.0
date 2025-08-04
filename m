Return-Path: <linux-fsdevel+bounces-56702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B429AB1AB8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 01:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBA11675FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 23:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8A28FFD8;
	Mon,  4 Aug 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD2AyEl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28B10E4;
	Mon,  4 Aug 2025 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754351127; cv=none; b=GP30Ybyb9Ai8QdQxRqVurGJsGsv9WvY1k94VgWE1b1ix4fJgUMEgur7FCX+RKQwXZU1QFNnAJJiFhu2CWEi8aOUtxAgfYQyTQ0kdBWcb59Lv7p8SEwJmTn5GviCsM53lFANROblYO2u+n71/AvxI6JPbtqPfhke+ovn3iKul3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754351127; c=relaxed/simple;
	bh=gMXi+2zjy9FFCAVeLuLqqIe2w83kfpuGKlL+Dgz8EHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+n9wD/BZTLLlSlBNlmIGgFYebcirLMxq4Emw/M6hshlARsC6nMXoFeUQleTjCFyqvS4N8CaKeUhG5lx7T2kBiLaOZLeoA2+DYK7WN6b9j8GI1yYZW9lml1IhuuIXXUCkzf2tz82MYlXbZlG3x1Valir2icR7EJE5wtH6ju0qaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD2AyEl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7570EC4CEE7;
	Mon,  4 Aug 2025 23:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754351127;
	bh=gMXi+2zjy9FFCAVeLuLqqIe2w83kfpuGKlL+Dgz8EHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD2AyEl9qnTXBD48CLNh3DDIRje3+Lyvk0Vq2pYI/ZQrHAAAJgGKuCQSfcmGWmY93
	 GYnmZGeD6OjL3bepo+oBD6YLjCCHmhvpUsk6KeWYzPYHv6s1cl5GS9ZVT4xT3mebB5
	 uFdBIvUlyr0dzugbb8bYpNESU0G5dCbkrrdDw1Q/I3C2snZhAE9vE9ubBIN9l9xnHp
	 FE4n6jdcpXQMVrFVxT+v8REDl/DgLdDWh2WSqXXU0MhVxSwjpLSw8u1+H3uIT/3znd
	 HEjndVPnOQFOoVNi5UdoAWGrh9rS6mukVmxFFILvYcWh5cdGek5A6z3uXXlucQ82jM
	 QYM15oPUXq6/Q==
Date: Mon, 4 Aug 2025 17:45:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, dw@davidwei.uk, brauner@kernel.org
Subject: Re: [PATCH 0/7] direct-io: even more flexible io vectors
Message-ID: <aJFGFBCDFksRO916@kbusch-mbp>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <43716438-2fb9-4377-a4a0-6f803d7b8aec@kernel.dk>
 <aJDohO7v7lMWxn7V@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJDohO7v7lMWxn7V@kbusch-mbp>

On Mon, Aug 04, 2025 at 11:06:12AM -0600, Keith Busch wrote:
> On Sat, Aug 02, 2025 at 09:37:32AM -0600, Jens Axboe wrote:
> > Did you write some test cases for this?
> 
> I have some crude unit tests to hit specific conditions that might
> happen with nvme.

I've made imporvements today that make these targeted tests fit into
blktests framework.

Just fyi, I took a look at what 'fio' needs in order to exercise these
new use cases. This patchset requires multiple io-vectors for anything
interesting to happen, which 'fio' currently doesn't do. I'm not even
sure what new command line parameters could best convey how you want to
construct iovecs! Maybe just make it random within some alignment
constraints?

