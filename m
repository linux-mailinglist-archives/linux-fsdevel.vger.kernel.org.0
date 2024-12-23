Return-Path: <linux-fsdevel+bounces-38013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFB89FA9EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 05:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79421654AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 04:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F671487CD;
	Mon, 23 Dec 2024 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fN5t+UxC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F763C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734928655; cv=none; b=ZZuMS9aKJclsd/sGR/XP+q2S2mZov+ulgHaRG9hWg3V92yi9wBY8l+45doAyS6jeGpgCd6MO/W6WehzaA3YRH+q43KfNJmxlh7muhrLQlw8TwQzc/vcmlw22J6JHgzRQ4OysVazwi3TbLO+uxzCfUiT5mXH/U/3HI5oeJa0t/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734928655; c=relaxed/simple;
	bh=lytaECTzHacgXVPPQ6ns0jL64Qyih2yDNwwv544JoIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIbRG06AO6sQ3KmRPiLNub4Db6Qw+swvA2wSMCRJkWRia/ROaBrtVbwkcC6aao+dF4s7IGdelwiVaBL7XY63PhcumTuQ4Qj0ucCGJhudbRuFUHU+cbqvTOJA1EEpmwgeSlh/B1JncorGRAHLEbe3zCC671D0CFYB0K0k6zQkLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fN5t+UxC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=op/01pcC8T2N90YoZf6SEis2Tee6FzG0kpGUUiGysOc=; b=fN5t+UxCJWBR2kepXc5MTkNR9K
	LNTcu/FYhNNrmic1w8PPqVaB3jqQ81Dekq6VS5dHCjKAe0q49Bl/9yXmw/qxBL5gb/xHS22v489BQ
	DLSyy+ShkgDa8E/MX7tQAcXak6U8THPTXxWqig0uBfpuxqCGcY6X9//CqihE2+tn18C0dcvYMF68s
	gLAtqJu9l+YrYswpjCtbPundJJO3c4naa7Rdouq/4jxDMKk/dpPgp+nhbZ1SYKSlij6JvoIM8EFmR
	Egj6FIhv9f8QF9zFsU82Y/cVcuXXgj5zPNXDxWrZasL6k6IaBb9I8v1nIv7riJJwipyHdSt0MihX/
	m47q793g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPaCA-0000000BBlz-1cbh;
	Mon, 23 Dec 2024 04:37:30 +0000
Date: Mon, 23 Dec 2024 04:37:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241223043730.GH1977892@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV>
 <20241209222854.GB3387508@ZenIV>
 <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
 <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
 <20241209231237.GC3387508@ZenIV>
 <20241210024523.GD3387508@ZenIV>
 <20241223042540.GG1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223042540.GG1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 23, 2024 at 04:25:40AM +0000, Al Viro wrote:

> Incidentally, call your file "<none>"; is the current behaviour
> the right thing to do?
> 
> What behaviour _is_ actually wanted?  Jens, Jann?

While we are at it, what do you want to see if your file happens to
be e.g. /home or /boot/efi?

