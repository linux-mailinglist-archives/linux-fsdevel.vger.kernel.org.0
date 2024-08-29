Return-Path: <linux-fsdevel+bounces-27740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5DE9637B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6590B21119
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEF01C28E;
	Thu, 29 Aug 2024 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vrgoiexq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA8EAD5;
	Thu, 29 Aug 2024 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894782; cv=none; b=GXMKrI1j322DZ2k6c1BdgIuGMPPd9IVszxuwiegCZySlP7Vi/mZaFARAE+NOFMix/S4ePQCn+CRppyTUxW5tCzMSBmjnr1LD3u/U8g1q+wnzf7A4mKnnIEl5mUi3w/nxeJHqBZ6/O4ZmGGmuy6LW7zmGrj3JHW7X+Bt+cDKE/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894782; c=relaxed/simple;
	bh=4XuFeSXS+A8GpA3S9dympitc6YLMVAqNw387RXuG4ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYhCQiDuzw09zqwE7xqLyCq2VERVRamf1zlJB5TgP3VnlA6mxf3EHuKLppO+tg+UYWm/Gm5ln/4U9fu/Q/ePKqXXcflzEwqcFeq7I+AtEWOyaNpN7nJO4gRncXw5lO18nX+F0MitXlD7ztssQQ3EBQJsvrRTG4saMHnllC2iowg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vrgoiexq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E702C4CEC0;
	Thu, 29 Aug 2024 01:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724894781;
	bh=4XuFeSXS+A8GpA3S9dympitc6YLMVAqNw387RXuG4ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vrgoiexqah4AmgJards0iG+8M6tbSD67ZKnXuSkiIuDvmEy/0vVkjgnNS0ei/z0vL
	 WvIwrdaqu72zb+FzV31m9NXr07ElEMlbB3UafXJBO4mgHddO5TtKTUoMGFCd7UYEX1
	 kJftBCmGyVKDNTgMJRlGah/QjBeddU7B1JIn92J+fNZNVh9vKuz/ZvsDlzRF4Bb7QL
	 LkoVdrSiFgjiMdVuh4+k6Trl6rL6Aa8TeiY12zYLGzztRD2U1D2SOdlZOktK78M+Ri
	 z5PTaWtZHYO0P2XTSzPbsvR+/N5e2DRoincHrnQiTz5dox1IVd4UXFs/xah1Zdx3V2
	 gCIF+/B1Y17lA==
Date: Wed, 28 Aug 2024 18:26:20 -0700
From: Kees Cook <kees@kernel.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: mcgrof@kernel.org, j.granados@samsung.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sven Eckelmann <sven@narfation.org>,
	Thomas Gleixner <tglx@linutronix.de>, anna-maria@linutronix.de,
	frederic@kernel.org, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Tejun Heo <tj@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: BUG: WARNING in retire_sysctl_set
Message-ID: <202408281812.3F765DF@keescook>
References: <CALAgD-4uup-u-7rVLpFqKWqeVVVnf5-88vqHOKD-TnGeYmHbQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-4uup-u-7rVLpFqKWqeVVVnf5-88vqHOKD-TnGeYmHbQw@mail.gmail.com>

Hi,

On Wed, Aug 28, 2024 at 02:16:34PM -0700, Xingyu Li wrote:
> We found a bug in Linux 6.10. It is possibly a logic   bug.
> The bug report is as follows, but unfortunately there is no generated
> syzkaller reproducer.

I see you've sent 44 reports like this recently[1], but only have
reproducers for 4 of them[2].

Without reproducers these reports aren't very helpful. There
are hundreds like them (many with reproducers) already at:
https://syzkaller.appspot.com/upstream

Please only send these kind of reports if you have a fix for them
(preferred) or a reproducer for an actual problem. This has been mentioned
a few times already[3][4]; have you seen these replies?

-Kees

[1] https://lore.kernel.org/all/?q=f%3Axli399%40
[2] https://lore.kernel.org/all/?q=f%3Axli399%40+%22The+reproducer%22
[3] https://lore.kernel.org/netdev/CANn89iK6rq0XWO5-R5CzA5YAv2ygaTA==EVh+O74VHGDBNqUoA@mail.gmail.com/
[4] https://lore.kernel.org/all/20240829011805.92574-1-kuniyu@amazon.com/

-- 
Kees Cook

