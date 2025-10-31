Return-Path: <linux-fsdevel+bounces-66579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD5C24EFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9C94067E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BE2348453;
	Fri, 31 Oct 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzcQcnSs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281A3469ED;
	Fri, 31 Oct 2025 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912488; cv=none; b=k+LIGzA7DP/ABgff3opyO3PzM1ZHEnpdOjNMEpAUVcATTRU40qy2VYhfQXvoHyQmJilCeoHVnO1x9GCHnHeLn+9O1jv3ccD7fN5TBrQymYLqdSDWGL6UlLzrwQMpRAE24mpIvGjw6qrXpjrq4nHNZkCi3Xa/vfSAkvFOQmZF9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912488; c=relaxed/simple;
	bh=upDbNS2Fw5shVpSa7tWtmSpwKwbvt3duFmThsc1Tilg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATcnSwA1NfafCxK19TkJubh1cMLh4WDag7PNdZJgFMhsNuyjQGgEqDehrCcuekQ1ORTB0s0BxbZkbob+xWCmRWQMtpOwv5hAkLCOZ14D0bQ1WX6Jc/Uzac0qiRqNzcPOZVFzbwWBGnoM97SWoj2s+Vu2U2zFsOGhvagcRhqZemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzcQcnSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A62C4CEE7;
	Fri, 31 Oct 2025 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761912484;
	bh=upDbNS2Fw5shVpSa7tWtmSpwKwbvt3duFmThsc1Tilg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzcQcnSsE4zfavSWDBk/CVvt3X8g5nr4L4uLckrJTajgbIwoLvPqawi2585UroxG4
	 HRaUG56tuqxfv7lATHzXgELbPhvoEFA2CF3sYUgRommAbXL4jgrur7IqVz9PzbOmhC
	 5H7McJsSBeUKCWmEQBf7liXPSaTqbzB/gwh6XWs5e5gvKx+YyiV+THSgMfR8z9+/us
	 oQf4i7POxykLnWwBhG1DPHxuk/iKHq1RGI3H26ufsOMz2shfudJ1t6A5ZT26D0wzf4
	 RqOPyq7+W0NZO7YvQi8liUOl/cQL2qk7JjZGGCzVwBwJIxcIQ+0vWMFzgn3X5PpDDH
	 guf8dZMF4IXSg==
Date: Fri, 31 Oct 2025 13:08:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Message-ID: <20251031-liehen-weltoffen-cddb6394cc14@brauner>
References: <20251030105242.801528-1-mjguzik@gmail.com>
 <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>

> I wonder if it would make sense to bypass the problem by moving the
> pathname handling routines to a different header -- might be useful in
> its own right to slim down the kitchen sink that fs.h turned out to
> be, but that's another bikeshed-y material.

fs.h needs to be split up. It's on my ToDo but let's just say there's a
lot of stuff on it so it's not really high-priority. If you have a good
reason to move something out of there by my guest. It would be
appreciated!

