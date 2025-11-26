Return-Path: <linux-fsdevel+bounces-69929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D98C8C351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 23:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 156E34E6039
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130C342CA2;
	Wed, 26 Nov 2025 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="xcD55qt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68FD34252E;
	Wed, 26 Nov 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195941; cv=none; b=rpVEGwWaTKKVS5LoEv8uLnDEemx/8p1c8UI7iuPQUUralCP6of09z+oPwPFuZ0TszLtlct+bKGhjFaNRI9y0tqSYeIEEMaa1co8uzBp2V8COrJBFRpeIEqABsNg/VoXE7TBHM57LzVf8+KGDX4bOgz8yDt5L3/AofXc6ZOX68o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195941; c=relaxed/simple;
	bh=CopYVVsoZccsyoMhdHGiZQ1bGe3xNVKgDy+CUG0AGAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDx3K/E7rjEKtO3kSbNjgI+K3wycGl6UU7vwi0RJ1JIxcWCwzOVC100dftEjYu4dIn2RzMoS2DQtKert3wCmWn/fbwyTB4dORM9aqW+ox7x0np0/Y+LxA+J/CzP6d9PasacLHEd2AT+LLH+nrKeZdMsSYwSBhszTyGGmV2Knguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=xcD55qt/; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vONws-00Anzk-V3; Wed, 26 Nov 2025 23:25:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=JdiNBuFehcyPOmOy5sppRLIzajFbdjUkb07I69kLGso=; b=xcD55qt/yTlHbRKdH+dBDSqh0U
	D42VMdh3YZT9pboyItqPjUEFlMjqGvWOkqKAMtxuETcqWYgXpz4rKroO5l/tRmc3L1BOxUfisIxkl
	rB1Iby8Ydzrb+bQCoPA7DatT6VLRSGNsdHwRDRTFQ5z0moPBOyfGsIcUf8++5wUiEyW+pE4J/YgUA
	OPPMAkQtF/m5Q1ardScEOjgI2eA0Y9fd/zb1MeRycorFUZdoNr0n/uOOSlhpqKg4fAk3vPaH5FtCr
	IgHttiJ0P0sh6EEouRQ3I09DwKT03Sa31APrSym62KaZbRen3hdZZ1gjJ53lTWC+Ky3pEFG8BjzHd
	gB2J9ibQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vONwr-0006Pi-3U; Wed, 26 Nov 2025 23:25:17 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vONwi-00EfwT-M2; Wed, 26 Nov 2025 23:25:08 +0100
Date: Wed, 26 Nov 2025 22:25:05 +0000
From: david laight <david.laight@runbox.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Xie Yuanbin
 <xieyuanbin1@huawei.com>, brauner@kernel.org, jack@suse.cz,
 will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org, hch@lst.de,
 jack@suse.com, wozizhi@huaweicloud.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, lilinjie8@huawei.com, liaohua4@huawei.com,
 wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <20251126222505.1638a66d@pumpkin>
In-Reply-To: <20251126200221.GE3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
	<20251126101952.174467-1-xieyuanbin1@huawei.com>
	<20251126181031.GA3538@ZenIV>
	<20251126184820.GB3538@ZenIV>
	<aSdPYYqPD5V7Yeh6@shell.armlinux.org.uk>
	<20251126192640.GD3538@ZenIV>
	<aSdaWjgqP4IVivlN@shell.armlinux.org.uk>
	<20251126200221.GE3538@ZenIV>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 20:02:21 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Nov 26, 2025 at 07:51:54PM +0000, Russell King (Oracle) wrote:
> 
> > I don't understand how that helps. Wasn't the report that the filename
> > crosses a page boundary in userspace, but the following page is
> > inaccessible which causes a fault to be taken (as it always would do).
> > Thus, wouldn't "addr" be a userspace address (that the kernel is
> > accessing) and thus be below TASK_SIZE ?
> > 
> > I'm also confused - if we can't take a fault and handle it while
> > reading the filename from userspace, how are pages that have been
> > swapped out or evicted from the page cache read back in from storage
> > which invariably results in sleeping - which we can't do here because
> > of the RCU context (not that I've ever understood RCU, which is why
> > I've always referred those bugs to Paul.)  
> 
> No, the filename is already copied in kernel space *and* it's long enough
> to end right next to the end of page.  There's NUL before the end of page,
> at that, with '/' a couple of bytes prior.  We attempt to save on memory
> accesses, doing word-by-word fetches, starting from the beginning of
> component.  We *will* detect NUL and ignore all subsequent bytes; the
> problem is that the last 3 bytes of page might be '/', 'x' and '\0'.
> We call load_unaligned_zeropad() on page + PAGE_SIZE - 2.  And get
> a fetch that spans the end of page.
> 
> We don't care what's in the next page, if there is one mapped there
> to start with.  If there's nothing mapped, we want zeroes read from
> it, but all we really care about is having the bytes within *our*
> page read correctly - and no oops happening, obviously.
> 
> That fault is an extremely cold case on a fairly hot path.  We don't
> want to mess with disabling pagefaults, etc. - not for the sake
> of that.
> 

Can you fix it with a flag on the exception table entry that means
'don't try to fault in a page'?

I think the logic would be the same as 'disabling pagefaults', just
checking a different flag.
After all the fault itself happens in both cases.

	David

