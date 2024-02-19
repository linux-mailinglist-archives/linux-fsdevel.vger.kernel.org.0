Return-Path: <linux-fsdevel+bounces-11987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED651859E8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 09:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86F9282350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC722314;
	Mon, 19 Feb 2024 08:38:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05E208B9;
	Mon, 19 Feb 2024 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331921; cv=none; b=Af50z4cL+RdoRQr4a5t79aWrgVjRKWLdqXu8Yd4z2+Mhh4AaxCLs2tJgX0ifYkXhWV7/+NWsxccVoOLMR4nXmSuDrWl1bQHbhCpad6WSpT/Xo/bEfETMAitYMHTIP0OboSglxgFpc+TGpK0E4lvi5gvTCblSD+K9GDJJ3AUIQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331921; c=relaxed/simple;
	bh=dAs2OALmkNudBmi4/5a+XrcRC0uaaEkJeqpRp/lL8ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZT1BpEGH/bKGTW51pnWYOkYoNYE7zS0VJ/RVRtiD4h/RboYyv76O0uxOMpHZQpMGfwbifulXMPDKfbcn7rOySnBTqZea+LsKc3/M/VDsQPfE3nWkpFJntknPNUFPsuDxFg/OteZOodVvk2zpkwFZsAn6b6XcKaPhIFWKmBvF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rbzAY-0007jO-Uv; Mon, 19 Feb 2024 09:38:35 +0100
Message-ID: <960e015a-ec2e-42c2-bd9e-4aa47ab4ef2a@leemhuis.info>
Date: Mon, 19 Feb 2024 09:38:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] netfs: Fix missing zero-length check in unbuffered
 write
Content-Language: en-US, de-DE
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton
 <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240129094924.1221977-1-dhowells@redhat.com>
 <20240129094924.1221977-3-dhowells@redhat.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20240129094924.1221977-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708331919;be4d50cb;
X-HE-SMSGID: 1rbzAY-0007jO-Uv

On 29.01.24 10:49, David Howells wrote:
> Fix netfs_unbuffered_write_iter() to return immediately if
> generic_write_checks() returns 0, indicating there's nothing to write.
> Note that netfs_file_write_iter() already does this.
> 
> Also, whilst we're at it, put in checks for the size being zero before we
> even take the locks.  Note that generic_write_checks() can still reduce the
> size to zero, so we still need that check.
> 
> Without this, a warning similar to the following is logged to dmesg:
> 
> 	netfs: Zero-sized write [R=1b6da]
> 
> and the syscall fails with EIO, e.g.:
> 
> 	/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> 
> This can be reproduced on 9p by:
> 
> 	xfs_io -f -c 'pwrite 0 0' /xfstest.test/foo
> 
> Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> Reported-by: Eric Van Hensbergen <ericvh@kernel.org>
> Link: https://lore.kernel.org/r/ZbQUU6QKmIftKsmo@FV7GG9FTHL/

David, thx for fixing Eric's regression, which I'm tracking.

Christian, just wondering: that patch afaics is sitting in vfs.netfs for
about three weeks now -- is that intentional or did it maybe fell
through the cracks somehow?

> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

