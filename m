Return-Path: <linux-fsdevel+bounces-15256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E788B222
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCFF2E17CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E354F5D724;
	Mon, 25 Mar 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="RgjwET4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550359B70;
	Mon, 25 Mar 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400293; cv=pass; b=oeboe9FxNM+iH4szWegnoHe7W+zE+jywIzQwHRTG+1GldeDEKbjN83Tv5q3Q9zeMVXWXXTuVZXOQv7RZUtGyqOkeJZDhDvNka2TgZg7YW8q4YvVlP+cH+AunVGfGqm8cpj8jwVki+S2m8McTcJmYD3lR5XdLB83HEO+3ErjBgCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400293; c=relaxed/simple;
	bh=76tSERWslhopEOc4u8fRhhRiUnP40jVe+hwo51dCKeo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=q0Xz3o5rUKCGcPyZ1su+qZwz3F0j+FGB52VWhxHr1dRpzno8cMWnXtDL+ZljWgC9CLqut2XzCJE+hSCWFHs4c3XVqBF9CwXTmYxpBYnBIscnBBTKpqrLGhx4Q9Ft/dA/ZQY3/zsoWjO5nKVFh7zDtLn8QJqzDC48sBBusyRMUWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=RgjwET4G; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <a5d0ee8c54ec2f80cb71cd72e3b4aec3@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1711399640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MvYkEvJaEDaTgzwXlfM3JjLexNKp+ZD+YKnxgQvNvo=;
	b=RgjwET4GT2LPkB3kXDJcBckngZwYEgONKnEF6H/uBX2L/FYUh2ER2kLLnvfXCAgcWZWkWP
	QLKd4xRY+JWMn3+u88vfL1PXEyTZMcal9eMFiqDCjo7VOvxo/AXclOOZQwpK+9HlN36QE1
	9eF2q5+5y9v+g2nOuWpfdKo8ndO0+DVtvFVV8P08QS1v0CHvDriLaIVowB1wJSn+tCJZmz
	DF+b/2h+y+9PXA0SaRj3DJpCKPjp3jEHm6QjdaBfBxEnGyVlX5h/S0Mnef8xi09aoheARe
	bAQf9wm14PDUCkUO7OudaG9uQ71lLlRIORyCeMe7RNI+f+jtzRkOYKi2r4DfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1711399640; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MvYkEvJaEDaTgzwXlfM3JjLexNKp+ZD+YKnxgQvNvo=;
	b=WS1iOrWs1eb+MxY1dQd/82e124OrdEijARV75JqHo+hWaA2Ne7Sz9YEm3Knw9ow3zkLbUJ
	+mDGgam3XUX/bJFFhj6yXX02oCoM35iOGavtxAXZbOkCFxvzWZRiQ+h45TqW2qV1IzCGbQ
	WOpMphq+e9AN40niw2tH6hCv43SEgxQT9VwV7u2QGBBhKGpgUxBP6LwqZAmif9u9ZldhmE
	pu4iAR2dwpd2+5ZrLdlbaMFE2dobmkYjNVLx2DGn6liXRkpmADw2RNaOlc9eD2QHP4Dq9H
	a7jHf0WrfeVTJDm2kroWoyTiKtbgUe+89gy5pz7DRG57j2ahl0Exn7ucxpyH8A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1711399640; a=rsa-sha256;
	cv=none;
	b=cpJ7+g7T28hOqVFhxBw2OZo5TAOgf0/kRogSfzCHCssax9p7NKZa4nuHQZhSxRrHxdE3qh
	NYg7lWIz58OMdVyPZVA0SpVC/bmyPyVV5icox1wUgiqz8+8+BZR8tSCE5BZVdQT9qnlp1Q
	6KNy3SbHkElj9HGWipQf67e4qpyLlbmlaWI/7HPrG5fGiVPUmmoxR80sCoZVF8WULK7i7B
	kj+YowgVal9BZvbLR6jqDTDTBymhtK1HV7UivfIPPU1+yblEoV/2UOOjCRkQ9QQr9Jgqc1
	OBxXKOC6B7uKL39obFYICrKij5TvV85ZI67FMv8JUJ+ISxcEthWAdzUQq8IB/g==
From: Paulo Alcantara <pc@manguebit.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Roberto Sassu
 <roberto.sassu@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS
 <linux-cifs@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
 Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
In-Reply-To: <20240325195413.GW538574@ZenIV>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <CAH2r5muL4NEwLxq_qnPOCTHunLB_vmDA-1jJ152POwBv+aTcXg@mail.gmail.com>
 <20240325195413.GW538574@ZenIV>
Date: Mon, 25 Mar 2024 17:47:16 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Mar 25, 2024 at 11:26:59AM -0500, Steve French wrote:
>
>> A loosely related question.  Do I need to change cifs.ko to return the
>> pointer to inode on mknod now?  dentry->inode is NULL in the case of mknod
>> from cifs.ko (and presumably some other fs as Al noted), unlike mkdir and
>> create where it is filled in.   Is there a perf advantage in filling in the
>> dentry->inode in the mknod path in the fs or better to leave it as is?  Is
>> there a good example to borrow from on this?
>
> AFAICS, that case in in CIFS is the only instance of ->mknod() that does this
> "skip lookups, just unhash and return 0" at the moment.
>
> What's more, it really had been broken all along for one important case -
> AF_UNIX bind(2) with address (== socket pathname) being on the filesystem
> in question.

Yes, except that we currently return -EPERM for such cases.  I don't
even know if this SFU thing supports sockets.

> Note that cifs_sfu_make_node() is the only case in CIFS where that happens -
> other codepaths (both in cifs_make_node() and in smb2_make_node()) will
> instantiate.  How painful would it be for cifs_sfu_make_node()?
> AFAICS, you do open/sync_write/close there; would it be hard to do
> an eqiuvalent of fstat and set the inode up?

This should be pretty straightforward as it would only require an extra
query info call and then {smb311_posix,cifs}_get_inode_info() ->
d_instantiate().  We could even make it a single compound request of
open/write/getinfo/close for SMB2+ case.

