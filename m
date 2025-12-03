Return-Path: <linux-fsdevel+bounces-70581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08645CA0BB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 19:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19A7030014D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057B34104C;
	Wed,  3 Dec 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="3AHelxj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9533D6D6;
	Wed,  3 Dec 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784896; cv=none; b=aULGpu0nMSeVnmty6KlxAITnVZ8BCgQh3arHcCjjYSG7rVROzwgEUfmkoTsgVxYHdGQWyd6aQBs8iuzBsw+zj5ldzDcWWaqtJuCWV7nzndkNKBpijhGb0lEYpVZ0P94a8+FcbxRsOmaZo6FmlMr2LZV9TfdCPmTAfrW24LP5zoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784896; c=relaxed/simple;
	bh=5CZz+n0aCk1jZ0uAfCJdvWrN/YpI/Q+QwQ0ju9Y11DA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=eeufvXzPavRNWsPowq5KOuZ4ywfLJQTXxAbOb13pnQGbyK+kOseow0cWqb3Caf7pxhkM8oMB2zWKLZ7jqXf0IDif5RIAQi1VVDHkKkmXEs8fkAVg/Y92I/0sfh2NGsToz4iN/vWDdXdzjS1YpmwdGsGUX3sFltzE0uxxfFHCHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=3AHelxj8; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RNfC7607WF0KF17s16Qmh7V79C7DQ4hFq4c7IgzWdMI=; b=3AHelxj8i0TKVsm+sK3MoVmGBB
	ZsoguvJ1rtqnWEY01Vk/fgTZ8TVNi5nCb70oNIicrbMw1Znrw1Z2NIQXKbIsnhb/aS7LN+z++IXWC
	xlCC+C2UIKFCa2wX+UCRliIoy1hFhNlSmKrjIW/IKkgzVE5nlSZBmcBkcCRNg4FQKWhskLVIXwgpK
	VERTTHTgEeJ+BjNocUreRfKX9umKASlU4Gjy/xTo2auiu7cK39JM/T0MXR8SeZoVegNJG7o+4+ObM
	JoRN0ohFw3KbVjA9Whd32tnElwR0R6EcDNRwLKFLIBtuGdJsBZNNsRcmUcSPYuowwrvz95JIDqaTD
	wHRG2mdw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99)
	id 1vQrAJ-00000000AHO-0sbi;
	Wed, 03 Dec 2025 15:01:23 -0300
Message-ID: <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: dhowells@redhat.com, Shyam Prasad N <sprasad@microsoft.com>,
 linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read
 over SMB1
In-Reply-To: <1597479.1764697506@warthog.procyon.org.uk>
References: <1597479.1764697506@warthog.procyon.org.uk>
Date: Wed, 03 Dec 2025 15:01:22 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

>     
> If a DIO read or an unbuffered read request extends beyond the EOF, the
> server will return a short read and a status code indicating that EOF was
> hit, which gets translated to -ENODATA.  Note that the client does not cap
> the request at i_size, but asks for the amount requested in case there's a
> race on the server with a third party.
>
> Now, on the client side, the request will get split into multiple
> subrequests if rsize is smaller than the full request size.  A subrequest
> that starts before or at the EOF and returns short data up to the EOF will
> be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
> indicating to netfslib that we can't read more.
>
> If a subrequest, however, starts after the EOF and not at it, HIT_EOF will
> not be flagged, its error will be set to -ENODATA and it will be abandoned.
> This will cause the request as a whole to fail with -ENODATA.
>
> Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyond
> the EOF marker.
>
> This can be reproduced by mounting with "cache=none,sign,vers=1.0" and
> doing a read of a file that's significantly bigger than the size of the
> file (e.g. attempting to read 64KiB from a 16KiB file).
>
> Fixes: a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

Dave, looks like we're missing a similar fix for smb2_readv_callback()
as well.

Can you handle it?

Thanks.

