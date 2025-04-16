Return-Path: <linux-fsdevel+bounces-46570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF12A90760
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 17:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93633444E22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCFD2036E9;
	Wed, 16 Apr 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="pTX4FCz2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RamRREms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EA7E110;
	Wed, 16 Apr 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816222; cv=none; b=rBJ8RqrjRfAhLoB6chGkLj0B0hAyngBv6hhF/pLrPC4eGvE3mnmXMQ+MUWgPxqvh8Eo616ze5jMj0kIo2LZh4qpZcFH9sHwfVKTjgH3aioU9H4Grqi3jkmsiCsfgwKOvjFDbsmypXp+34sJldZoGjiIj4tOoZt2TAUA9G7g6KdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816222; c=relaxed/simple;
	bh=lUzn/o69mgiG+qvpvuqKYAaOTnPpZ5mLRifqgUMG3+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDFj+Nc6HeLGXmNf3lPNJwgab0WxK9lAGjhHjjwovbnYYElfHcebGPjcoUALVkbp0ANLbMD8egBtCPua5FnULObmxsoBQvgvPlfI8fiVlTKDkSFTUu1AkUId/2hGbJdNNexx8G/cjL6x7NCDagOk7BX06fn2h0NuT1xVADDptPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=pTX4FCz2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RamRREms; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id D91B41D40351;
	Wed, 16 Apr 2025 11:10:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744816218;
	 x=1744823418; bh=cfqCfrQW/RdAiFQP3RdU4AvqzdIAjl8rLEu2tG3LR/w=; b=
	pTX4FCz2CCMQJxwM18KoB/dVTzhWcXROC3TD6bsGm1kWHgXYH4n94AU5qwmuOtEb
	EdgI4LnqpXBE6ZKFyh8/nYIwXeET6PV4VCkZGsKZxBDwVWDAEUIAgyyS9I88kllM
	Gq/1XiuIqkXQ52rMkxwCUxPPRypj0JrZjOVRddUPjIXenBEEDLRzphq3ZVdIJgUb
	NRYcrl3f9NcS2izrHQPvLesosq59dU9Yzfg4rVidQ7Kz1qudrIF5+NIELIFHqRzp
	O8cUda40fynBOwb/R1L69Yvdy+aq50wBpiJl4HCCP/OrjR40hLuAx0ofoCQZNYa8
	jzSXIkjO8nx1Ik4k6cMXZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744816218; x=
	1744823418; bh=cfqCfrQW/RdAiFQP3RdU4AvqzdIAjl8rLEu2tG3LR/w=; b=R
	amRREmsH3cfqxqWWq64veV6LIL35h/9Q6GV0Rg/D6J0bw/XeFqm9h1dCiUUK0asS
	0UJUadF4H9kkb2P6RpatSiJGeRa2u/t6hgbX2cQYQ7Xwq0woppBBgyrbnmDCcbx2
	8zNI+Qm45iShf1Jk61e+uHRGixYhOcqajOebPBtTzyrpgfqkMJU7c9PWpnH+ajSa
	a8oz1O/UFMNHYbXHc8xA8mo4wASJ0VI4H1Z/u0vDTEIVoUUQX/zFMQ0NOcfogoic
	8OhAFx5675QXhgvecyZhUTZOSgS6+tjFOQUFyOR4CFGek9VzAbwWbeBAzlSxISBR
	pNWdlei1D/LYrk1piFe7Q==
X-ME-Sender: <xms:Wcj_Z9sKu7DMBdPoqr6B9LxOzykGhwquC0tH_garRW_3dka8oLFbXg>
    <xme:Wcj_Z2d9Pn-DsmPuP8_riM9twAt5NsFRsnc-oVYpi0GGC_qA7bTzP0t5Sokw7cI71
    tz3n9Q-9NpkPfhs0Fo>
X-ME-Received: <xmr:Wcj_ZwxHmjbkVmDVRocTxtyZhustSXLYQh8C6HJQ4kep36wgOJseVoy4vvhLCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpefgueevteekledtfeegleehudetleet
    tdevheduheeifeeuvdekveduudejudetgfenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhitg
    hhrghrugdrfigvihhnsggvrhhgvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughj
    fihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtvghnghhiiidrtggrnhestggrnhhonhhitggrlhdr
    tghomhdprhgtphhtthhopehsiigrshiirgdrtghonhhtrggtthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdp
    rhgtphhtthhopegtrghrnhhilhesuggvsghirghnrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Wcj_Z0N0eAeFNc_6Jb9l9mt382OtatcoTxSyOxnLrKbsBeIPwbr0Aw>
    <xmx:Wcj_Z992xepHopPYgR3ZypsTzW1YH6ByEt_AW4veaQcmRMr9-Yhgeg>
    <xmx:Wcj_Z0WTWteFE-N5J6IvHcONX2azGMJk5SdyyE5aIurLeB1Wwk5PIQ>
    <xmx:Wcj_Z-dDGh6O1SPf3ZXFB6GxAxdyv9K-pMhSQ-E6yKOa57TKgDbWaQ>
    <xmx:Wsj_ZyuUxcCTEXrOHDLUn0bUqbrdJt8wXxTqkRXyp5DmooHGUF1jNjZT>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 11:10:16 -0400 (EDT)
Message-ID: <9f8f65c1-5644-42c9-b16f-e0eedbb70a66@sandeen.net>
Date: Wed, 16 Apr 2025 10:10:15 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
To: Richard Weinberger <richard.weinberger@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Cengiz Can <cengiz.can@canonical.com>,
 Attila Szasz <szasza.contact@gmail.com>, Greg KH
 <gregkh@linuxfoundation.org>, Salvatore Bonaccorso <carnil@debian.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-patches@linuxtesting.org, dutyrok@altlinux.org,
 syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh>
 <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
 <20250407-biegung-furor-e7313ca9d712@brauner>
 <20250407190814.GB6258@frogsfrogsfrogs>
 <CAFLxGvxH=4rHWu-44LSuWaGA_OB0FU0Eq4fedVTj3tf2D3NgYQ@mail.gmail.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <CAFLxGvxH=4rHWu-44LSuWaGA_OB0FU0Eq4fedVTj3tf2D3NgYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 5:11 AM, Richard Weinberger wrote:
> On Mon, Apr 7, 2025 at 9:08 PM Darrick J. Wong <djwong@kernel.org> wrote:
>> It's also the default policy on Debian 12 and RHEL9 that if you're
>> logged into the GUI, any program can run:
>>
>> $ truncate -s 3g /tmp/a
>> $ mkfs.hfs /tmp/a
>> $ <write evil stuff on /tmp/a>
>> $ udisksctl loop-setup -f /tmp/a
>> $ udisksctl mount -b /dev/loopX
>>
>> and the user never sees a prompt.  GNOME and KDE both display a
>> notification when the mount finishes, but by then it could be too late.
>> Someone should file a CVE against them too.
> 
> At least on SUSE orphaned and other problematic filesystem kernel modules
> are blacklisted. I wonder why other distros didn't follow this approach.

To be clear, RHEL9 ships a very limited set of filesystems, and as a result
does not ship any of these oddball/orphaned filesystems.

While I agree w/ Darrick that the silent automounter is a risk in general,
even for well-maintained filesystems, for distros like RHEL the attack surface
is much more limited because the most problematic filesystems aren't available.

Not saying it solves the problem completely, just saying it's not as egregious
as it might look from the original example.

Thanks,
-Eric


