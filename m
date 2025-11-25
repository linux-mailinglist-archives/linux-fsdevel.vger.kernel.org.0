Return-Path: <linux-fsdevel+bounces-69747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0839C843F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C01334CF14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB82E265A;
	Tue, 25 Nov 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psP4wvU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1D2741AC;
	Tue, 25 Nov 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063324; cv=none; b=R7Xr4Wn3PXMoSBqbDHKRQvxRXHogxeZPrnoHUxTbhwDJ6KelRab9b0bxDYJ1ch8l3Tl/a4GbMvkXFCOdIhWibSmlLULMsMZ1vSiRSDmQvpzF1TPaECIo7rzIQyhAO06Vs+XKlAYqR76xFvenfSJxDjp185TSWXmOGRWTsTNuNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063324; c=relaxed/simple;
	bh=1Wb/VpaTSKEGMRrsEIbAvD4pOzSKaJus6F2VO710JTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeeTFHA4nSn88jTzQhCdaNQCS/Vucjc2kWcVpvqxynuX8kQVuAI8ojM/l2P0VWS4TCGkSrmQXhVrIY7J6j1DHIOzXJm9zE1icdQbKUu09GJ+kOm0z3muJnFJ2xCDCgmATb3HiznxKD9E8e6XtofzVAKquCVortHS+ftbjbN404E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psP4wvU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46C1C4CEF1;
	Tue, 25 Nov 2025 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764063324;
	bh=1Wb/VpaTSKEGMRrsEIbAvD4pOzSKaJus6F2VO710JTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psP4wvU0GiNkwuAQkqC4kr+5V42n0JGqL6hgUHlsZ3Y6/eDSc/p8evVZQRniYXlwp
	 6+H/d1gccZZqxF0fxSW2iZWMMYA0FlcY1vv51O4IN5uScYlGygREQ9CGXV1H1hoUaE
	 FxjSnovw8WaLr52UHgw4WS1qlg6C7W1s0SuLOJFMDbuB09GpsH45bzZGTohjCYY/eu
	 AF2V7ar7xgNzhPG/tK+JaTwVXnQeT+jBGcqACfs1l+21weCOKU231C2tS9MZBP2wr0
	 GuvuROVrXGt6qR7BTDw0yDuA9r2GzL4fVhrXc9/JQUYb69rqHqtjcrlVV3zjYsMtMb
	 ssf9gePFyjEbw==
Date: Tue, 25 Nov 2025 10:35:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: neil@brown.name, agruenba@redhat.com, 
	almaz.alexandrovich@paragon-software.com, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <20251125-hausdach-antrag-f3e4bcd35365@brauner>
References: <gyt53gbtarw75afmeswazv4dmmj6mc2lzlm2bycunphazisbyq@qrjumrerwox5>
 <6924057f.a70a0220.d98e3.007b.GAE@google.com>
 <wtgy54dfpiapekffjjkonkkhpnxiktfp24wdmwdzf4gslrtact@pongm7vm3l2y>
 <CAGudoHHfGndcMwXMupOs82HM6c_ajMw8GETxPdkqzORrEq0btA@mail.gmail.com>
 <c2kpawomkbvtahjm7y5mposbhckb7wxthi3iqy5yr22ggpucrm@ufvxwy233qxo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2kpawomkbvtahjm7y5mposbhckb7wxthi3iqy5yr22ggpucrm@ufvxwy233qxo>

On Mon, Nov 24, 2025 at 10:21:07AM +0100, Mateusz Guzik wrote:
> On Mon, Nov 24, 2025 at 10:01:53AM +0100, Mateusz Guzik wrote:
> > sigh, so it *is* my patch, based on syzbot testing specifically on
> > directory locking vs inode branches, but I don't see why.
> > 
> > I take it the open() codepath took the rwsem, hence the rename is
> > sleeping. Given that all reproducers find it *on* cpu, it may be this
> > is busy looping for some reason.
> > 
> > I don't have time to dig more into it right now, so I think it would
> > be best to *drop* my patch for the time being. Once I figure it out
> > I'll send a v2.
> > 
> 
> good news, now that I gave up I found it.
> 
> insert_inode_locked() is looping indefinitely an inode which is no
> longer I_NEW or I_CREATING.
> 
> In stock kernel:
>                 if (unlikely(!inode_unhashed(old))) {
>                         iput(old);
>                         return -EBUSY;
>                 }
>                 iput(old);
> 
> it returns an error
> 
> with my patch:
>                if (isnew) {
>                         wait_on_new_inode(old);
>                         if (unlikely(!inode_unhashed(old))) {
>                                 iput(old);
>                                 return -EBUSY;
>                         }
>                 }
>                 iput(old);
> 
> unhashed status is only ever check if I_NEW was spotted,
> 
> which can be false. Afterwards the routine is stuck in endless cycle of
> finding the inode and iputting it.
> 
> Christian, I think the easiest way out is to add the fix I initially
> posted, inlined below. It *was* successfuly tested by syzbot. It retains
> inode_unhashed checks even when they are not necessary to avoid any more
> surprises.

Thanks for tracking this down. Now folded.

