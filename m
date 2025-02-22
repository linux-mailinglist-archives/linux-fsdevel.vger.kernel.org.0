Return-Path: <linux-fsdevel+bounces-42339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 480A1A4096C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 16:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EE717AC90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE6C19AD93;
	Sat, 22 Feb 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Age1dKzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C702CCDB;
	Sat, 22 Feb 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237453; cv=none; b=eMefrtAxARVjRgLihZ5Jfiut8OtZxg6/OfiKjlGSoO+A55iFAFFxwd33kXCdfsSVU/HMCGWXJ4MzUJWbw4fHC0pTJKE9xORPt3XcNSRalz25JL7LIjINHp4sfVDQ4502RcWfXkfbEj8Ahv9ZpghXflAsOdImGANhZzFKxowWpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237453; c=relaxed/simple;
	bh=HKTn8zhss2PatWMKSFImcPKrYWeF0uKg3r+G0+HEDYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+3p3UdKDB/AIy9VstfQI78UWXDSJKC5WU+totZ0CDdbZs0X6GN4XXt67Y95dgj+mEEqPIkEuOBlmyyihS8arQ6kStIw3Y9vX923oMFpPOG4RAwYBtmnsYvqfKZlwVfdA4BM0B61nNqa3cm6ZnHjQNJsMhwo8nNyG6POpjdyzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Age1dKzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE73C4CED1;
	Sat, 22 Feb 2025 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740237452;
	bh=HKTn8zhss2PatWMKSFImcPKrYWeF0uKg3r+G0+HEDYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Age1dKzyVm8yeAbkc6Y5/IGunB1/5c12BDPyWSJwFpa4C/EnR31D1cs7Mzu7L/+39
	 UStQGkmOEOsP5CLz8Ran73zC0lkwiJcOz08sChx/AvFmKyr7J6U5oIxIIZLQhsjYow
	 BHuf/ANIMqtdXiMyQodJzU3Qg2q9y+jBYJnXD/98Cy5qB3xLqyKy/Yt4vsgITw33wR
	 AmeYAkiHFhz/O/TnPZAApg0oRJdSqHwXBP0KSmcOdfC2yxATiURdyMcCxLSmff3dcg
	 Eql0g/b4OLxGb38Ye/JtGSbWYdIg13TeOxRX/eKbNVWKrov3Ehe3exJlcFufs+jKBr
	 IWGnUcea9fNhw==
Date: Sat, 22 Feb 2025 07:17:29 -0800
From: Kees Cook <kees@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Ronald Monthero <debug.penguin32@gmail.com>, al@alarsen.net,
	gustavoars@kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <202502220717.3F49F76D3@keescook>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut>
 <202502210936.8A4F1AB@keescook>
 <CAGudoHHB6CsVntmBTgXd_nP727eGg6xr_cPe2=p6FyAN=rTvzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHB6CsVntmBTgXd_nP727eGg6xr_cPe2=p6FyAN=rTvzw@mail.gmail.com>

On Sat, Feb 22, 2025 at 01:12:47PM +0100, Mateusz Guzik wrote:
> If it was not for the aforementioned bugfix, I would be sending a
> removal instead.

Less code is fewer bugs. I'm for it. :)

-- 
Kees Cook

