Return-Path: <linux-fsdevel+bounces-59995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A84B40786
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601A81885D41
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB531158C;
	Tue,  2 Sep 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ahFuXh6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4D2E0407;
	Tue,  2 Sep 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824428; cv=pass; b=COyVBZo2qLgXnoNhzVAoX1rYRMhjqBtfAQ6eXRYrze68Ip1MC8Eul5zR8HZO6xuLzBg7mo1oBOncttgUEQDPnGDxLm5yfBkEFufLQBj8NIYnEhdQuNW9MRvNcBgiBSxk6uDl2gS/se0TjG1orEmwDWC9YgRWVghuzndEQv8uWIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824428; c=relaxed/simple;
	bh=QRs8WG6/3owti9znRWrf2vUZdyG+kmIZ/4sPivrKG/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9FWMJjCPGi8/ugJiQyL4Kmt1OasUxOhotJ1eh5IdNgW0ULYYK2kcn/PebY3gxwYh1rc3xrU1bkHpTxs9opw5XcbLrcbugknlmz0CILzkH4Bx1JgDGhhn9ysaG0lMvRMr4L7IHltFmddOGeHGlqypTyBvDMmYBO2bVxb++T24hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ahFuXh6T; arc=pass smtp.client-ip=23.83.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CB6D48533F;
	Tue,  2 Sep 2025 14:46:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (100-102-100-57.trex-nlb.outbound.svc.cluster.local [100.102.100.57])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 26FB484F45;
	Tue,  2 Sep 2025 14:46:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756824419; a=rsa-sha256;
	cv=none;
	b=d4SI0fkmOUSX2SGsH3tGmzA5T7O38Rb2zp3OVz0EZyQd+gAfR0U6gz/TCQIvNw0eilrIYR
	j7fSHsvtLaaG7qTJOzWy+AN7n0Jw6VTr+vT7pwwhmdV5nN3Yi1fNgUHDkw8+MnyqYROENf
	TJwiaFLP5hqiwdMDUubbK4NelDCbWRQTkabhZH4zgcPiz3s4cNx8LP2O+DOQTNF3ozgfqf
	vCh6LTaH3zgwqM+rj6h5YOGNEXHMDn2Y+kE77q1f7Mfu3GQUQnPlmnGN+PN+KyACX8z38m
	K6bT1bLpB7G1Sjc80nSsLE6hc41Fo6hAbnkakKgGmyZOVc17FTaQme+NZM+a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756824419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DRZMJhVX4LzPqmwkjT3d+FOTiKORmaj3h8jd47mnvis=;
	b=blLyN6tNLXUZo4Qn8DwbQL+wqTwSMr2D8fftXutauH3fR0J9UeDxnlzJ9Gozn2t8Yh+MnI
	WoYkDYLHDyeY5oH4D8Uo2yPE6/S8H9n5wyW7Ran/gboLRHdAkTFeId3jJ/8z7CQuB101r1
	c5sngHBottpeXNUq7RlAhTf38guMBoIQ6A5g8OFpkGDi+5HSVvYBBK1AU/TpkykGLcd7HM
	Ht5JM1EWmp1GW+kj7NQ2UkNyVEJ4uutBY5gBcRsuyYE6DXNuNUcdzk+PWLlPoHAdjyU5NM
	On7H2AYc0rLCFzXBgAtyoRfKNylmEAoh3Oi00Vg3D9Ck5lM47CRn5ftS8qhWAA==
ARC-Authentication-Results: i=1;
	rspamd-7b4c58cfff-wm9q6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Thoughtful: 6dfc35c35855886b_1756824419657_1353450583
X-MC-Loop-Signature: 1756824419657:4042092830
X-MC-Ingress-Time: 1756824419657
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.100.57 (trex/7.1.3);
	Tue, 02 Sep 2025 14:46:59 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4cGT8y0brxz5x;
	Tue,  2 Sep 2025 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1756824419;
	bh=DRZMJhVX4LzPqmwkjT3d+FOTiKORmaj3h8jd47mnvis=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ahFuXh6TLfV1SNfdspKZSAUyRRCEMTayPVRx7ctfIpGBahfb0Dp/YnYNoWAl/2nci
	 ED7kWBbA884J1CmHlDqoolEsxeLcGz1xNnbHoDXyjfMEOOjAQ5fWQbK0eiRExb1jwZ
	 r3njvCgIJuU/KHBqHKbD26Ra3FupmSiZ2oBtXnvd+PbF50gWUH4xvCOfiWkgO20Xv0
	 Pn7cu4FaKJUDP53K20BbVlOyA8K9AKlEuadnFFmy4/I/dbtzrYCrbH0Mc3IQRITR8I
	 oJvxhxZV2ueEMqbkRYKQR5Kyuo0N1S5o9VIF0erx5qJi+L7aDHi6pehxfM3fZ94MAz
	 nLjRGrHw1V41Q==
Date: Tue, 2 Sep 2025 07:46:55 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: syzbot <syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org,
	shaggy@kernel.org, slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [syzbot] [hfs?] INFO: task hung in deactivate_super (3)
Message-ID: <20250902144655.5em4trxkeks7nwgx@offworld>
Mail-Followup-To: syzbot <syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, brauner@kernel.org, frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org,
	shaggy@kernel.org, slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	willy@infradead.org
References: <00000000000091e466061cee5be7@google.com>
 <68b55245.050a0220.3db4df.01bc.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <68b55245.050a0220.3db4df.01bc.GAE@google.com>
User-Agent: NeoMutt/20220429

On Mon, 01 Sep 2025, syzbot wrote:

>syzbot has bisected this issue to:
>
>commit 5b67d43976828dea2394eae2556b369bb7a61f64
>Author: Davidlohr Bueso <dave@stgolabs.net>
>Date:   Fri Apr 18 01:59:17 2025 +0000
>
>    fs/buffer: use sleeping version of __find_get_block()

I don't think this bisection is right, considering this issue was first
triggered last year (per the dashboard).

Thanks,
Davidlohr

>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101ba1f0580000
>start commit:   c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
>git tree:       upstream
>final oops:     https://syzkaller.appspot.com/x/report.txt?x=121ba1f0580000
>console output: https://syzkaller.appspot.com/x/log.txt?x=141ba1f0580000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
>dashboard link: https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10857a62580000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f5ce34580000
>
>Reported-by: syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com
>Fixes: 5b67d4397682 ("fs/buffer: use sleeping version of __find_get_block()")
>
>For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>

