Return-Path: <linux-fsdevel+bounces-9197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049883EC5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 10:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A81283A0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BA1EB20;
	Sat, 27 Jan 2024 09:43:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224313AF8;
	Sat, 27 Jan 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348596; cv=none; b=u16ZQzSaeIKwCBWcqrYv0IXUVadt8+uN+g9Cn0CGlEctmUAJIuNJuahc0PXj8IXaO8fciA4U7MEXL3X18fQC6koqe6WQzntHnekYKd7JGD+Vt9OYasM8wcIvUdXoHBfdf6MiIqd/W3lr7Jb1Ra57NpYmQJMhl+l8xtVPMh3rgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348596; c=relaxed/simple;
	bh=0YlTECjXbMzxOJ9SvYsij9ghpBp0aA2YujbgFnfdvw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtKRSfMXlrvgZvSfo+5ZhOQi1hIU5tZ4/YmOMyVzyDGuXGTkmUqzuPVgA/u8mM1r3NHZm38QMgC5L6YXDiJnzhAYcW5ouw3LDsyFAC5YgtSq9YabLczzRUxgVaizLaqueRa1qrAC7lCRbGrktnx/zAOX8nE2+vrXcUbUOvQaNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4TMTwn1jqyz1syBm;
	Sat, 27 Jan 2024 10:36:57 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4TMTwm61CLz1qqlW;
	Sat, 27 Jan 2024 10:36:56 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id NOGV83LWqDOm; Sat, 27 Jan 2024 10:36:55 +0100 (CET)
X-Auth-Info: LasxOhhX5uau7EcsWEa3k+xXe1y6nnjwUIZEYRn4b8JwSFE2+vRy5vt8DQL1Wdwx
Received: from tiger.home (aftr-62-216-202-105.dynamic.mnet-online.de [62.216.202.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat, 27 Jan 2024 10:36:55 +0100 (CET)
Received: by tiger.home (Postfix, from userid 1000)
	id 31180252088; Sat, 27 Jan 2024 10:36:55 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Steven Rostedt <rostedt@goodmis.org>,
  LKML <linux-kernel@vger.kernel.org>,  Linux Trace Devel
 <linux-trace-devel@vger.kernel.org>,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Christian Brauner <brauner@kernel.org>,  Ajay
 Kaher <ajay.kaher@broadcom.com>,  Geert Uytterhoeven
 <geert@linux-m68k.org>,  linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
In-Reply-To: <CAHk-=whqu_21AnXM9_ohxONvmotGqE=98YS2pLZq+qcY8z85SQ@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 26 Jan 2024 15:17:14 -0800")
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
	<ZbQzXfqA5vK5JXZS@casper.infradead.org>
	<CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>
	<ZbQ6gkZ78kvbcF8A@casper.infradead.org>
	<CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
	<CAHk-=whqu_21AnXM9_ohxONvmotGqE=98YS2pLZq+qcY8z85SQ@mail.gmail.com>
X-Yow: Here I am in the POSTERIOR OLFACTORY LOBULE but I don't see CARL SAGAN
 anywhere!!
Date: Sat, 27 Jan 2024 10:36:55 +0100
Message-ID: <878r4b2k3s.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jan 26 2024, Linus Torvalds wrote:

> Note the "might". I don't know why glibc would have special-cased
> st_ino of 0, but I suspect it's some internal oddity in the readdir()
> implementation.

It was traditionally used for deleted entries in a directory.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

