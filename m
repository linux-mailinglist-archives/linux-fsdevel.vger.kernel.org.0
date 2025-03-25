Return-Path: <linux-fsdevel+bounces-45034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19FA7046D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D19D3AF966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069EC25B67F;
	Tue, 25 Mar 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="W3/5436i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10BA1EDA3E;
	Tue, 25 Mar 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914762; cv=none; b=DnpF4+qCt+jfw2Kw/Lp0vxEvSe4qkw1+3mkaH6P9rhCSCb7z8jqHfquAB0Ecevvowk1kioMmOwE2XuGXRJRY4ax64T3tjCgkPHKDfV8Wt0Q+3XWckSMASLXK1/VRCnvXUPojlTDzXv6i/NqpY1PHbtxljNW+jY+Lf8GcEglSezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914762; c=relaxed/simple;
	bh=jFKEhjNjq9tWLi1tufH12YoYuLncNqbR/nzyYY8yoFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGLFVkiCOiHzA4Bsg/ZvvgR2Euwg2WGw9qdKsoC1JT58k99EEkANMUcw/iX6RYlenJLUqpO/jeK2czJ5Y1uSLaSakP5FDcp7CxyvrfY2v5gozSnUlywpjUNPe85e0OcLCLo1pT0+Yot1GxHyKJQIdPY/xYVnvdMsnWOzakxGvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=W3/5436i; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 494BD14C2D3;
	Tue, 25 Mar 2025 15:59:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742914758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LA2ZWfipp543V5Octm+YivgRf31pm38h6sG4nFoFVL4=;
	b=W3/5436ielp+x8Mg+ylaT1KwQLXmybgWQDRFANia1QIR5etK8+gW7Dk4fWWTQlCrj6Tkad
	vgLy5gZ/5N8CvbH+NS29LwIEi23qDuWlaxtwdi8nV8zNAN8L0Ztf0cUYdpEIPrYOvKrtL0
	nKtHroMZM9HTu/lCxJ7sBGryNeMS1iRjuWs2kl7o1BM6Pg1FkZkhBBAwWCpBVnvNcGzq3s
	rVAXnUzgy8K1U3e/Qn6FeFY4w8hcycOuxZKajjueOVaqnN0z4ieDQOQEqh70519uT/MjvE
	cWZOqiDjql//4x7MeXIQ9UiRxAtbG0VD4DWlRRn0JeRy5uelCkgZgtw/6cgWlg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ad07f38a;
	Tue, 25 Mar 2025 14:59:11 +0000 (UTC)
Date: Tue, 25 Mar 2025 23:58:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <Z-LEsPFE4e7TTMiY@codewreck.org>
References: <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com>
 <20250325130410.GA10828@redhat.com>
 <f855a988-d5e9-4f5a-8b49-891828367ed7@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f855a988-d5e9-4f5a-8b49-891828367ed7@amd.com>

Thanks for the traces.

w/ revert
K Prateek Nayak wrote on Tue, Mar 25, 2025 at 08:19:26PM +0530:
>    kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_poll rd poll
>    kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_request wr poll
>    kworker/100:1-1803    [100] .....   286.618823: p9_read_work: Data read wait 7

new behavior
>            repro-4076    [031] .....    95.011394: p9_fd_poll: p9_fd_poll rd poll
>            repro-4076    [031] .....    95.011394: p9_fd_poll: p9_fd_request wr poll
>            repro-4076    [031] .....    99.731970: p9_client_rpc: Wait event killable (-512)

For me the problem isn't so much that this gets ERESTARTSYS but that it
nevers gets to read the 7 bytes that are available?

If the repro has already written the bytes in both cases then there's no
reason to wait 5 seconds here...

OTOH syzbot 9p code is silly and might have been depending on something
that's not supposed to work e.g. they might be missing a flush or
equivalent for all I know (I still haven't looked at the repro)

-- 
Dominique

