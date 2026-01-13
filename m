Return-Path: <linux-fsdevel+bounces-73493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D2D1ADAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53753303B158
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E1334EF10;
	Tue, 13 Jan 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpXDyFTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A4315790
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329238; cv=none; b=EOhqdKZq2gT61yNubIdein4+KH3Mm4iK/lYrFdRbITN9Gr0Mny3c6d4kEFxME0jo4G7RTSoprf5iSUMhcCup9Nd7axDv8yUOR4Ig+EKLgUuwnUSBdCXEZtU7rXxBoJcdiHYKdwMa07Kd3UFyLQQBWdnRqSM7iexa8UiL42L0ZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329238; c=relaxed/simple;
	bh=6wclnzskG/ZNUGRCGnmIpcaafQeAFLYeRrSPFRj2hqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieI7OQrCDPUZq9m3IuhaIcpQxA+OgtfSdKQ0JuHl7eLujqZYN8wBA/DQQjBBjdb38mwhh+VeO/rl5Iy7HxfJApRKA+ypjvIsKv8TXS08Sj4ehOv5U++WQmz24qtezoYVXOT8hn333UZYUFVNSWeyAS2vJ0JjshP4ZQQArQi3jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpXDyFTc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso84993095e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768329235; x=1768934035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD1n4fofwsxFZx8Y9vmmRRviFzIkQGtDaZlhVkXmiq0=;
        b=fpXDyFTc8V6sAVOSDINivucVs1f4NXdjVYCAxga1I5uBIi1ZWxwLWNjyILra1ili7g
         xvlgd2n76SMKRu6tg2+xoWJ4UbTVsY27n1hae/ziMsk5z3zVif2stqQQe2+HTy3sONEt
         AmXX3HGBbrrKwaDrpkFGYrmj1LziZmAXi/HsB5OhBpEPtRDandzpixZ1tG8qr260Tnrq
         bS9H01/oRXM4bN7F3ZxfM6dS6gu4UA5eZsUJXZ4AoxAWf9zqGZ+QkcT6ucC41b4YnDnS
         f228iaceH9Rc3GrlUcIQCKOycY3pSqBijd9+B43GrASJbFhhq3Kck4GS/+o7cM569Xh9
         WvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768329235; x=1768934035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vD1n4fofwsxFZx8Y9vmmRRviFzIkQGtDaZlhVkXmiq0=;
        b=kHgQvXXiE06vRRGUyOfS5JD+rQBHR5myk/smLXkIBlEwHEgePepKAbcOt02HbbB0Xh
         dTjgl3vJN/XWEMD/Ez0bzKbqR4R3Lr4lqVfGOZh/9zqLzaekdoojPSipQZyw4KalvQGf
         Uvqyv8+i4drPPpCUPtdqEF/kfWJq072RX7h2TDQauZCbJbu6t7x3WEgAw3lcVI5AP83U
         Fj83F14uB8F3ms0oj0pHnp453mAg6PY0wBE4rxOuyHLamcFqjWWjhUxnHoRRu3yDnu6J
         wbNi4F6OZWkbZQ8HHwbQgdss54RcePUxo7MODcIp5gSzI9HqbdqycpjIfmvtP1EzfNKu
         HVSg==
X-Forwarded-Encrypted: i=1; AJvYcCWAkxOkfSexgGZtvQXy0Sp5nSmJcAbJzLNCtZDJDddxQmC4xflatng1lTEceyAt//ZTM8FfribN4g35NqGn@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEGSdCacdToKTryfpqZlwb2JV2c5mdrPfqIbO9VgkCHzx3RrN
	UWAT0ggtF/LtLO0TERM7EPGN4jHI3Sck3Dls2MoQY1m4lHZkhBU7SIgc
X-Gm-Gg: AY/fxX7LWO2O/tTnbEm3OAa4fUSF3BgqYKntkyFEN+htiDy/AzoClOZJC8+oSe9nveV
	kpjn4UXLxgxZMlpwb22VSE1gd3HqZbPx7phrD0LlYwzE4LcpMBHmrSDo/6sZ9XWxBa0Bfj/JBva
	AvSpR6DVCaP3cBTfmXbxo1woGuaoyk0iiM+KlvUPBWkjPygQiijNw5A5SqUT4b3EHyOoH22XeaZ
	mRWXBajzOZ/qNUwKfB3jD0lLkK49mOfudJMMcI+6b5p2ch5EJSeBAWLjzfmEWNlz/gfB09WYcF1
	0QWMfhWGr1Wo0h1Kf+Jb33yanyoQ4tj59mJsLFLQg0p3vKA425wff+2C8VT7Ebw1zblz6lllQwG
	iKn+wutt3Af83HKEfHmmtGEJwVoB6gk5YR3jLszQLBiisCPLgGKKnQpFzgsUYkQS9hCndLUGRKN
	6JyDWyz08gwh2mOiIOqHIIBSKZzS29HduzjOyOf1ho75x39XcUtyBOSGdKWa8uDxU=
X-Received: by 2002:a05:600c:6386:b0:47d:403e:90c9 with SMTP id 5b1f17b1804b1-47ee32fc6d8mr1578295e9.11.1768329234806;
        Tue, 13 Jan 2026 10:33:54 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e802sm426004125e9.8.2026.01.13.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 10:33:54 -0800 (PST)
Date: Tue, 13 Jan 2026 18:33:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 30/44] fs: use min() or umin() instead of min_t()
Message-ID: <20260113183346.18ef7c74@pumpkin>
In-Reply-To: <62097ec5-510e-4343-b111-3afee2c7b01e@sirena.org.uk>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-31-david.laight.linux@gmail.com>
	<62097ec5-510e-4343-b111-3afee2c7b01e@sirena.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 16:56:56 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 19, 2025 at 10:41:26PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > and so cannot discard significant bits.  
> 
> This breaks an arm imx_v6_v7_defconfig build:

I hadn't tested 32bit when I sent the patch.
It was noticed ages ago and I thought there was a patch (to fuse/file.c) that
changed the code to avoid the 64bit signed maths on 32bit.

	David

> 
> In file included from <command-line>:
> In function 'fuse_wr_pages',
>     inlined from 'fuse_perform_write' at /home/broonie/git/bisect/fs/fuse/file.c:1347:27:
> /home/broonie/git/bisect/include/linux/compiler_types.h:630:45: error: call to '__compiletime_assert_434' declared with attribute error: min(((pos + len - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error
>   630 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> /home/broonie/git/bisect/include/linux/compiler_types.h:611:25: note: in definition of macro '__compiletime_assert'
>   611 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> /home/broonie/git/bisect/include/linux/compiler_types.h:630:9: note: in expansion of macro '_compiletime_assert'
>   630 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> /home/broonie/git/bisect/include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> /home/broonie/git/bisect/include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
>       |         ^~~~~~~~~~~~~~~~
> /home/broonie/git/bisect/include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
>    98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>       |         ^~~~~~~~~~~~~~~~~~
> /home/broonie/git/bisect/include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
>   105 | #define min(x, y)       __careful_cmp(min, x, y)
>       |                         ^~~~~~~~~~~~~
> /home/broonie/git/bisect/fs/fuse/file.c:1326:16: note: in expansion of macro 'min'
>  1326 |         return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
>       |                ^~~


