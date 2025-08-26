Return-Path: <linux-fsdevel+bounces-59223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045AB36BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F171C4196A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0A2356915;
	Tue, 26 Aug 2025 14:30:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from winds.org (winds.org [68.75.195.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B40350D46;
	Tue, 26 Aug 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.75.195.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218651; cv=none; b=TYdwQJ4aKoi/egmh4ZDs29y5tgupjNoa0saKvguK9V5sL4Kzb71nSHrlpg5V1dSHdfdutT+cJ6ElyxSGA7ytMQoHM5EmauoJ+MZAKxBYd7UwC9mVviDvRKjcG42oQNhSDXqfdOPepMCmFxHdT4ji84hMLz7jGVk0XFSA/7cqlOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218651; c=relaxed/simple;
	bh=w21r7tJH1xZJf2cEWI9tM5Rt0MJ9+VAhgNXspWSQva8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=anO24iQ99cUL9IbfbOu/mBQTSVU5ph1Vv7oPknGI+Hxr/wL/cQTAgVYKfHoyhYYe4CjFnLbEv4oZg2iOqFsL+J89ynKxPUElpKMNoOLC+ehTC+YnrrTVkHTKIevCBPlsNWRRsPM14YGGWZ1pUVwRdkNhuN3xbJci4v+Nz3/n9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org; spf=pass smtp.mailfrom=winds.org; arc=none smtp.client-ip=68.75.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=winds.org
Received: by winds.org (Postfix, from userid 100)
	id E16958F95FB2; Tue, 26 Aug 2025 10:21:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by winds.org (Postfix) with ESMTP id E07AC1332A400;
	Tue, 26 Aug 2025 10:21:50 -0400 (EDT)
Date: Tue, 26 Aug 2025 10:21:50 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Christoph Hellwig <hch@lst.de>, Askar Safin <safinaskar@zohomail.com>
cc: gregkh@linuxfoundation.org, julian.stecklina@cyberus-technology.de, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    rafael@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
    Gao Xiang <hsiangkao@linux.alibaba.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH] initrd: support erofs as initrd
In-Reply-To: <20250826075910.GA22903@lst.de>
Message-ID: <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
References: <20250321050114.GC1831@lst.de> <20250825182713.2469206-1-safinaskar@zohomail.com> <20250826075910.GA22903@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=us-ascii

On Tue, 26 Aug 2025, Christoph Hellwig wrote:

> On Mon, Aug 25, 2025 at 09:27:13PM +0300, Askar Safin wrote:
>>> We've been trying to kill off initrd in favor of initramfs for about
>>> two decades.  I don't think adding new file system support to it is
>>> helpful.
>>
>> I totally agree.
>>
>> What prevents us from removing initrd right now?
>>
>> The only reason is lack of volunteers?
>>
>> If yes, then may I remove initrd?
>
> Give it a spin and see if anyone shouts.

Well, this makes me a little sad. I run several hundred embedded systems out in
the world, and I use a combination of initrd and initramfs for booting. These
systems operate entirely in ramdisk form.

I concatenate a very large .sqfs file onto the end of "vmlinuz", which gets
loaded into initrd automatically by the bootloader. Then in my initramfs (cpio
archive that's compiled in with the kernel), my /sbin/init executable copies
/initrd.image to /dev/ram0, mounts a tmpfs overlay on top of it, then does a
pivot root to it.

This gives it the appearance of a read-write initramfs filesystem, but the
lower layer data remains compressed in RAM. This saves quite a bit of RAM
during runtime, which is still yet important on older PCs.

If there's a better (more official) way of having a real compressed initramfs
that remains compressed during runtime, I'm all for it. But until then, I would
like to ask you to please not remove the initrd functionality.

(In fact, I was actually thinking about trying this method with erofs as the
lower layer filesystem someday soon instead of squashfs. But I would still be
using an overlay to mount it, instead of the auto-detect method addressed by
this patch.)

Thank you,
  -Byron


