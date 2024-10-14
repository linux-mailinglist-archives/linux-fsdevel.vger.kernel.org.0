Return-Path: <linux-fsdevel+bounces-31887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33399CB62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5947B21558
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200611AAE19;
	Mon, 14 Oct 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="v993vigk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081101AB534
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911634; cv=none; b=msJF0g0dxwwcYgeYJqrWG4RVT/bmP+/LXq9L7UOliApjuOl3LItUU/wWZ1o3lyUSRyMa6RX6nk0fPyJQrkUtNQ3oFMzudR3HhIEUvp6CCC/9lvqrBqLug9pDi/1Bd1MJSGOqTf04JMFIef7IzkuVG4hLd5jfn6180xyW008wrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911634; c=relaxed/simple;
	bh=YZAwdhLxqIVEsN8AzkOH372BYEQdFlQUVF42OlinRyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svd0bqEBWOmc2kzejpBK/Hq1LYbLWQmPiuh+OYU68of36IYqAc0SqdQoGy/Vw0NpPo34lgi6M5AB49yv4OE7FZE+xJ0xXZJ4vvVIvfYLUzmXAkslzI3E/OoSheY5OZKoZfnnS3A0sfBqW91Ha6PRZM1icYx9li7Yuify4qzfITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=v993vigk; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRyNX6m0TzlcM;
	Mon, 14 Oct 2024 15:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728911628;
	bh=Yd8xTfXZsZiPbyGaXM8oxi4qY6znQrMCC6wFQMaJAxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v993vigkwHSQ+l5Pil6ZeqOGzi3Wn6Wx5mLsxeB7hlZzqMM9EaGIziSps/pGeDj1l
	 /VHneQcEcsHKkGRF+Qo2W/liXjdSO/njK8zyIPP9sXRuWkao3/+iBL7tY4zdiduUED
	 jauTWinPO4rysuIze5V6zh4EsvKyDu+ykcY0b658=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRyNX2wWwzFjk;
	Mon, 14 Oct 2024 15:13:45 +0200 (CEST)
Date: Mon, 14 Oct 2024 15:13:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Burn Alting <burn.alting@iinet.net.au>, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241014.seeN6daap2ta@digikod.net>
References: <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
 <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
 <0e4e7a6d-09e0-480d-baa9-a2e7522a088a@iinet.net.au>
 <ZwzeGausiU0IDkFy@infradead.org>
 <e0188174-a8ae-461b-b30a-bc7acd545a18@iinet.net.au>
 <Zw0L8ZrEani3uWa5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw0L8ZrEani3uWa5@infradead.org>
X-Infomaniak-Routing: alpha

On Mon, Oct 14, 2024 at 05:17:53AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 14, 2024 at 11:12:25PM +1100, Burn Alting wrote:
> > > > PATH records is no longer forensically defensible and it's use as a
> > > > correlation item is of questionable value now?
> > > 
> > > What do you mean with forensically defensible?
> > 
> > If the auditd system only maintains a 32 bit variable for an inode value,
> > when it emits an inode number, then how does one categorically state/defend
> > that the inode value in the audit event is the actual one on the file
> > system. The PATH record will offer one value (32 bits) but the returned
> > inode value from a stat will return another (the actual 64 bit value).
> > Basically auditd would not be recording the correct value.
> 
> Does auditd only track 32-bit inodes?  If yes, it is fundamentally
> broken.

auditd logs 32-bit inodes on 32-bit architecture, whereas it should
always log 64-bit inodes.  The goal of this patch series is to fix this
this issue for auditd and other kernel logs (and to backport these
fixes).

