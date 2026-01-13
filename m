Return-Path: <linux-fsdevel+bounces-73405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00458D17E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FA29301BDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6957538A2A7;
	Tue, 13 Jan 2026 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="tJ42esUh";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="THBEkxKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CC389DFA;
	Tue, 13 Jan 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298904; cv=none; b=YlgzC9FraVDt1SHcGSbTKM0BEvWDgy46fxjSwW/2eGpUS+nIcLEVpWLgM8Ougls1VlNBrtwb2ZNX7asDntQN+IjxqkYTRfpwTFlaDLseo1g1M/2vd/nfQXgEDIuYyIttoLh9SB8KL1Q+uWOuRt7FTetN3Pur3Q7yj6bYtwMyOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298904; c=relaxed/simple;
	bh=yhe6VlHRSoAX02Luz8bg9W7kn2bPDMaZHeYU1wdRGKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7JuhpKJYtxot/Rmz5dKb/P6G5q4vUPmJuue1lZtAgGgew72qsVQ3/kTX7dfyUPIozpbZn4QzHKVO+fJ3Xw+duhlLSanPa36sD22B6I4KPmllHn5/MAk/uzpfC1tJ2Hw0PXyoIpLidfFaLgQxxdkkiwVOamG/JTc/8FVnwfU/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=tJ42esUh; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=THBEkxKg; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 948A72051576;
	Tue, 13 Jan 2026 19:08:08 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1768298888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9nrRY9w2Of6JogZrHYKUs4ce65uX9wXn4p6WWpZNSk=;
	b=tJ42esUhqocsf6j7QZHtqmlgK47lR+Qg0rqn3zcqbErPMoedlzAMK3VzyoIWjGsXCUDAtL
	j5YVNbCNJXcYqeIajbkb+g71bE3Q4ptBlt5SKEMnzV7loyYVit7dPjoIkraePqvrTua+LA
	gZz22NP4iR3VP2Nb1BSeWRcWUxzKtXsNMpTd8u4HbfeEPQ71ubl4djoohPD24qEa0uvnlI
	mpo7L2bTwR5OsRdgIqI41K3QdUJw7YaPwu6fP6NL0X4EfTKpxRak9eVTk1gijTl6+sZr4L
	PkGz1h5+ekcBQ2OHUTXx+Mh/IohwVmPOh5QSznqFmAYhWg7IF6buUVi4PwSeyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1768298888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9nrRY9w2Of6JogZrHYKUs4ce65uX9wXn4p6WWpZNSk=;
	b=THBEkxKgBBUagmG3zN3wHxvASd9E9BWKS6IXEnPjoZXqCaAvxCvlV4RCvvJ4MV9KrtoS4g
	KRhFz33u+AFx2hCQ==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60DA87AO044384
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 19:08:08 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60DA87IJ072944
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 19:08:07 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 60DA87GU072943;
	Tue, 13 Jan 2026 19:08:07 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Zhiyu Zhang
 <zhiyuzhang999@gmail.com>, viro@zeniv.linux.org.uk,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
In-Reply-To: <20260113-rammen-unsinn-d9d5929ca2a0@brauner>
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
	<87secph8yi.fsf@mail.parknet.co.jp>
	<87ms2idcph.fsf@mail.parknet.co.jp>
	<CALf2hKu=M8TALyqv=Tv9Vu98UKUcFjWix1n5D9raMKYqqZtY5A@mail.gmail.com>
	<20260112095230.167359094e9c48577b387e18@linux-foundation.org>
	<87cy3ed7c9.fsf@mail.parknet.co.jp>
	<20260112103959.e5e956cd0d8b6f904e21827a@linux-foundation.org>
	<20260113-rammen-unsinn-d9d5929ca2a0@brauner>
Date: Tue, 13 Jan 2026 19:08:06 +0900
Message-ID: <87y0m1bzax.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> On Mon, Jan 12, 2026 at 10:39:59AM -0800, Andrew Morton wrote:
>> On Tue, 13 Jan 2026 03:16:54 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>> 
>> > Andrew Morton <akpm@linux-foundation.org> writes:
>> > 
>> > > On Tue, 13 Jan 2026 01:45:18 +0800 Zhiyu Zhang <zhiyuzhang999@gmail.com> wrote:
>> > >
>> > >> Hi OGAWA,
>> > >> 
>> > >> Sorry, I thought the further merge request would be done by the maintainers.
>> > >> 
>> > >> What should I do then?
>> > >
>> > > That's OK - I have now taken a copy of the patch mainly to keep track
>> > > of it.  It won't get lost.
>> > >
>> > > I thought Christian was handling fat patches now, but perhaps that's a
>> > > miscommunication?
>> > 
>> > Hm, I was thinking Andrew is still handling the fat specific patch, and
>> > Christian is only handling patches when vfs related.
>> > 
>> > Let me know if I need to do something.
>> 
>> OK, thanks, seems I misremembered.
>
> I prefer to take anything that touches fs/ - apart from reasonable
> exceptions - to go through vfs tree. So I would prefer to take this
> patch.

OK. I will add you to To: (with Acked-by) instead of Andrew next time?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

