Return-Path: <linux-fsdevel+bounces-76089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNdDCcEDgWnZDgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 21:06:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A27D0EC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 21:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6F3D3083962
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 20:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7BF30DD2F;
	Mon,  2 Feb 2026 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfpcaieJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498D3093D2
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062599; cv=none; b=uUzrwz/FoVypuCv2hdTCU215Z8pCS21AF6a38u2csHAJZYAX9dV1OyxU7V4fPfHtSCarujSlxVOxII1/xeNdHGFxHoeHzHGsJ80/Be4nbjhqRrSr/uS5Cb/BCAW82iFnAenypfP6/1AheLLXuQby9ERuiAkeJGZSbDZyaC5I/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062599; c=relaxed/simple;
	bh=bIlM/4QQa7ihj6Fxhl8KrmmDbU4/lwS9+INy3m5qDKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYwZOJiPE+/xJUHc4rM1SWGReb4dSVHxjMogptP+5ljB+JpcheF4YaLCySGmnk3WXCEA4l+iERcqwTUjPzCfJ/N+H9HL4u4lv9WlF61HaqtMmP6Xsw3WU3mhmEBXO9Rn4Jl/SdalXXfNDmrOcqruFCbrhUjZ+QReauWfJ0Lqsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfpcaieJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so35755865e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 12:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770062596; x=1770667396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oeyy3A9F0h68gai95rKC/WKtYz02tqXoxrCeMHYnONw=;
        b=bfpcaieJRa67PWwcQjz5+s1PDDFlX5vaehv2dj5WTGocasY8LgUys6EQEzr3ksjpLj
         +rIfA4QlKwM/qcnYmJPZzmbx9J10YWK4/8wRx6PblTus7sCfdUJxL2IkyES/iji5afZR
         YaSRrvlkEU4st8OpqnzSQHa1ejVoBWqQB5PB0G4utMrJmsc8QtsLDMHoZHE1KSIl5zUf
         L0MpddMgnfOtf/bzFNMqRtwJG5SrbewlXOvRZekoorCfTmYdEkRVnIAuUSJf0VNMQvsV
         86ire3FRP37u3RkwkcXo6gy7tCpBPhBOPyQUtakRJ+Yvb4CyfkMSFRCkHvL5FPS3s2c1
         j2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062596; x=1770667396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oeyy3A9F0h68gai95rKC/WKtYz02tqXoxrCeMHYnONw=;
        b=a6B/FnQst7/yqRa6xR7SIi9IvvrO1fe5vjgu56kWcMCpzqfyeVt3g/1ds/6vQvUlo7
         GWuMPEn/lGxtoJdcCSB9KmB9KcQVOE1D5f2q7R6N8Xul4nSpp+LEWFKTqxbLCjt1tQfB
         wkYHp66sngaj1ChYzvYkoRTiZIgpD7n1PKR6Ykvhqo+KExVVt7oVEEOFQWp2tJo8uTrn
         zfbx1ELNwQ+no4A5+oFiqxdskQmAByzew6IM0l2fKzFpjBLBFy9cmMBz6J6lT/5k6yE9
         i1kO+BzDwhiZ39gny4SZAQ2i8k4NeLpXJpQ/VWBieYZeN2LY9v4UclhifBXDmqAUx+mw
         06Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUDt+nG21ik2K9Va4tLC7qAIhQRzgEbDm5MJcrK67O9BVllr7dXxFjdY3qXx++85pXSe7NAoBy6a2crcar5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnq37fpboiZmUM/VmytSvW/wCKVceGqezVM6IL8jn8lafBcZwE
	iORb/eL3AGsaAIKKOA3QFYEycjCqUBrvYIxwAikFlaIos5ZCqb3YhiuyZIw+CQ==
X-Gm-Gg: AZuq6aLVURfEnOc1aEn/B4dNbnwGY5w1zS4mTYSZe+bOTAWDthHAVMopZbFfxq+/TA2
	eZSnB31Y8Rcl0a665N4euofB7gn6u0hlqBzbb6bA3OSuUDULJI6TO0b8oIpnfVkTAK9Tzq8NUTn
	d8dRBcA1i2H/4gFpbfcd5L3zHQY14KZpyEtz0BV5U4LXcCwsi7C7xUDdg0IHC7jCDa44tMvJ1A3
	OIL9UiyiarXeBzaqgjjg2jE6wz/DwVTanwwLhSHY0513Twme17UsiK7P1LHW80+dfU+6RjKXE6I
	aiWzzeHy9zKNGe1ao7dxhoETdtRGN9yN9ltRNefM9lw8/R+3FZdE1E1XPgxPcJmB/DvWa4gSBwg
	hWfB+dMYP/xqwdXDv5D/VyOYO+qbuy5jtXmDvTfuzZ2URTHnb66zA3EQPJrUzrScg01XMgT5P+l
	zbw60ZIRo=
X-Received: by 2002:a05:600c:4507:b0:480:39ad:3b7c with SMTP id 5b1f17b1804b1-482db45e244mr170114895e9.16.1770062596185;
        Mon, 02 Feb 2026 12:03:16 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483051626c1sm9918025e9.13.2026.02.02.12.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 12:03:15 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: kas@kernel.org
Cc: baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	hughd@google.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk
Subject: Re: Orphan filesystems after mount namespace destruction and tmpfs "leak"
Date: Mon,  2 Feb 2026 23:03:00 +0300
Message-ID: <20260202200300.2719301-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aYDjHJstnz2V-ZZg@thinkstation>
References: <aYDjHJstnz2V-ZZg@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76089-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73A27D0EC5
X-Rspamd-Action: no action

Kiryl Shutsemau <kas@kernel.org>:
> Hi,

I think I know how to fix the problem.

The problem is in your container manager. It seems that the container
manager doesn't unmount filesystems or unmounts them with MNT_DETACH
(i. e. lazy).

What you should do is to make your container manager actually iterate
over all filesystems and unmount them without MNT_DETACH.

Of course, this will not work in your scenario. "umount" call will fail.
But at very least you will actually get failing syscall. I. e. you will
get fail instead of silent leak.

You may go further: if umount on tmpfs fails, then simply go and remove
all files in that tmpfs. And then unmount it using MNT_DETACH.

In fact, this will not remove all files. This process will remove all files
it can remove. I. e. exactly what you need! I. e. it will remove whole
47 GiB of data and just keep 4k, which are actually busy.

Feel free to ask me any questions.


-- 
Askar Safin

