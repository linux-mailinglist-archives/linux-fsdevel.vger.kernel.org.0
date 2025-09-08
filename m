Return-Path: <linux-fsdevel+bounces-60471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A46B482A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 04:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8353F3A9301
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131D81F4C9F;
	Mon,  8 Sep 2025 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="TuM+c8QN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77760AD51;
	Mon,  8 Sep 2025 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298905; cv=none; b=KQ/gKNYfIzdIjguPxPIJ6+9dlWR4QfFqS3ssIHKK6uPZCW2MhJEqsFjdlIjRSaBNru8HB4G/5iJnb+SHEkv5Bhm/AW8CDweelRSFLp9nq+DbZyAsGU5w9cyAGPrxuAMfgYJg5FQtmWlviAKNV2kNjGthIA8l0BFCs8KPsRNZr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298905; c=relaxed/simple;
	bh=bcK8U7Mx2h8XnpNVxn4vD0wzqCMtNYj5lomMvEgQuEE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=Y/6ZpwU1bAk9M7nxgMoecvHGotiC72OfTdxj2MdvjjBs6+sLZErpXVWhjmkPEwQ/p1V/G0yI2kKSeW1wztg4dLDLl3eSR5/RmAX0PO834hUJP2m3UUh1Su3aPtR5YINnAtuurrpdZUH9jhrYf/sCxB/pAXQF9jIQy7hBO7iRj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=TuM+c8QN; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mQrKvmLDsFkxDPkRt0hUS8uNPuWkuhQY/mUi/U6X8tU=; b=TuM+c8QNf6kfGkCBPtyqbSxPPs
	Q3e9cg//9CSUGyYOYofrtitjhajJQxhq9pkSHR3oAdwxDrAV2nFh5Fw1t4vIysuCP7eEHZDENfYyc
	H/m2KKseGqnWtsJrXE5ZT7JK5JRVsDsMfQ6nucxd/aSg8PmwdcBwrtvmyM2JT5WhtYwuj7UOQIEtc
	3+Hd7vD6HzKNx/+hLxslpp5PKW9sgnTwfSPaEdFtyXpeOaIsZOS1EwDUmsLHSjPd4jWbkske4KXzy
	JyxzJEdk0CBrvrBqcoYstX0XyV7Rz/wUuDralT+fYEK6645eo/dvSd+bT7KmJjnoHChcubp2IVrp9
	En+6D8WA==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1uvRiT-00000000zn5-2v9G;
	Sun, 07 Sep 2025 23:34:49 -0300
Message-ID: <032c8e1184693ecc448d104bae5ea458@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] netfs: Prevent duplicate unlocking
In-Reply-To: <20250905015925.2269482-1-lizhi.xu@windriver.com>
References: <68b9d0eb.050a0220.192772.000c.GAE@google.com>
 <20250905015925.2269482-1-lizhi.xu@windriver.com>
Date: Sun, 07 Sep 2025 23:34:49 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lizhi Xu <lizhi.xu@windriver.com> writes:

> The filio lock has been released here, so there is no need to jump to
      ^ s/filio/folio/

> error_folio_unlock to release it again.
>
> Reported-by: syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b73c7d94a151e2ee1e9b
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/netfs/buffered_write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

