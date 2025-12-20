Return-Path: <linux-fsdevel+bounces-71799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15DCD313F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC9F30161BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A72D12E7;
	Sat, 20 Dec 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="vu84rKGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6F28E59E;
	Sat, 20 Dec 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766242543; cv=none; b=RnuluZhvio/pDmRP8dBZmy08RPq8dJ8ZZtm66BR8nCuSQhmDsuIDGM0n8RPnD30tg6Rj3urLiXoL1RCUgy+eKB69PFoun2YShfWJ5TETLB6hEmyhdxQGIFX24HLA33WsxbfNj1p0kuZs+kZiF7ehhYxO9mRnTeclw2DsQlmWqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766242543; c=relaxed/simple;
	bh=KtzVQdZaMr95ioM5Kw3aMHD+e5gqVZPsillYzrYIT2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO4t2CnS2twrHhnTlZ12V7wV3UcS+Uc+5RC9ltqw9PqK4U0Ths4XAEBVrBkewWen79WSpSuKTZDgbZ0Ayq9EsAXHd1WcVOLXRi+A3IdXSc1e46VGFcYooSvBsBbiIwfldWLpN5bDhHJZfHFClQFFm66bbAZF2wryF8dN0Y0lBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=vu84rKGN; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=1oMl2sGh2+KLRcLUi/Ckq52w8adkpPfv++Qj3e/rMCU=; b=vu84rKGNUGSSpfqZqLuwJ5wv79
	6gmOwHsc/E3w9W+1zMye8INJM/crkGlASEOYMMiSJb09wi6yBjHMOY2FGuX5bAjrfZIa1184tyA/K
	U+rHxqoIBI2yJq98oScJ67QxhTUFQk4+/zid+MKBhRHqMoL9UEYxPCdlQ2K8KrQTX0/nm8y5F7fci
	bh3hJqbJi0Fy7qnHdfK5Aj2BENuerxZUOFyk9YW4sPmSYFLhxErDq43ghp4Dh5VgyLmPrKj1lY9jN
	pG9R11L0mXbN6d5s0zRAwwLaRBXTQPZ2HveD+VcF4/YqjIK4/HYQzB5ZIe168baASqm8laiLaqE31
	ekYTxyCpdOsvcsdwOjsg4edKcsEfaKEN3Df9MaDpP+CjhWNShSiAFPKMPxUGbOLorNjikUWVi6mLM
	HIXbQbLtpYkbG5iokJJdz5iC32zhFgN/FzM2t+t0siPGa4ZfExIpnNEC3Aq76AVDHIRdWZtal3U8/
	YlWwhb5XhbaNlK6InneEBaN6ts4QBySVvSbWv79YrbvCNW1GiysgQVZOi9t00ZXHQL6g0QvuQgbWv
	vwq2TcZI0NtyIkGjxDycLvuUefNwkn9ppfnpuqRTzX7TcnhxZ25iKVkW+OD+vpTyUhm/KtMhCEF9w
	KtbBe1c7gdF7XBWZr3CMNA2a2AFoZjXqPiNTFEIbE=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Chris Arges <carges@cloudflare.com>,
 Matthew Wilcox <willy@infradead.org>, Steve French <sfrench@samba.org>,
 v9fs@lists.linux.dev, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix early read unlock of page with EOF in middle
Date: Sat, 20 Dec 2025 15:55:09 +0100
Message-ID: <8618918.T7Z3S40VBb@weasel>
In-Reply-To: <938162.1766233900@warthog.procyon.org.uk>
References: <938162.1766233900@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 20 December 2025 13:31:40 CET David Howells wrote:
> The read result collection for buffered reads seems to run ahead of the
> completion of subrequests under some circumstances, as can be seen in the
> following log snippet:
> 
>     9p_client_res: client 18446612686390831168 response P9_TREAD tag  0 err
> 0 ...
>     netfs_sreq: R=00001b55[1] DOWN TERM  f=192 s=0 5fb2/5fb2 s=5 e=0
>     ...
>     netfs_collect_folio: R=00001b55 ix=00004 r=4000-5000 t=4000/5fb2
>     netfs_folio: i=157f3 ix=00004-00004 read-done
>     netfs_folio: i=157f3 ix=00004-00004 read-unlock
>     netfs_collect_folio: R=00001b55 ix=00005 r=5000-5fb2 t=5000/5fb2
>     netfs_folio: i=157f3 ix=00005-00005 read-done
>     netfs_folio: i=157f3 ix=00005-00005 read-unlock
>     ...
>     netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
>     netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=c
>     netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
>     netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=8
>     ...
>     netfs_sreq: R=00001b55[2] ZERO SUBMT f=000 s=5fb2 0/4e s=0 e=0
>     netfs_sreq: R=00001b55[2] ZERO TERM  f=102 s=5fb2 4e/4e s=5 e=0
> 
> The 'cto=5fb2' indicates the collected file pos we've collected results to
> so far - but we still have 0x4e more bytes to go - so we shouldn't have
> collected folio ix=00005 yet.  The 'ZERO' subreq that clears the tail
> happens after we unlock the folio, allowing the application to see the
> uncleared tail through mmap.
> 
> The problem is that netfs_read_unlock_folios() will unlock a folio in which
> the amount of read results collected hits EOF position - but the ZERO
> subreq lies beyond that and so happens after.
> 
> Fix this by changing the end check to always be the end of the folio and
> never the end of the file.
> 
> In the future, I should look at clearing to the end of the folio here rather
> than adding a ZERO subreq to do this.  On the other hand, the ZERO subreq
> can run in parallel with an async READ subreq.  Further, the ZERO subreq
> may still be necessary to, say, handle extents in a ceph file that don't
> have any backing store and are thus implicitly all zeros.
> 
> This can be reproduced by creating a file, the size of which doesn't align
> to a page boundary, e.g. 24998 (0x5fb2) bytes and then doing something
> like:
> 
>     xfs_io -c "mmap -r 0 0x6000" -c "madvise -d 0 0x6000" \
>            -c "mread -v 0 0x6000" /xfstest.test/x
> 
> The last 0x4e bytes should all be 00, but if the tail hasn't been cleared
> yet, you may see rubbish there.  This can be reproduced with kafs by
> modifying the kernel to disable the call to netfs_read_subreq_progress()
> and to stop afs_issue_read() from doing the async call for NETFS_READAHEAD.
> Reproduction can be made easier by inserting an mdelay(100) in
> netfs_issue_read() for the ZERO-subreq case.
> 
> AFS and CIFS are normally unlikely to show this as they dispatch READ ops
> asynchronously, which allows the ZERO-subreq to finish first.  9P's READ op
> is completely synchronous, so the ZERO-subreq will always happen after.  It
> isn't seen all the time, though, because the collection may be done in a
> worker thread.
> 
> Reported-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Link: https://lore.kernel.org/r/8622834.T7Z3S40VBb@weasel/
> Signed-off-by: David Howells <dhowells@redhat.com>
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: v9fs@lists.linux.dev
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---

I had bisected this mmap() data corruption to e2d46f2ec332 ("netfs: Change the 
read result collector to only use one work item"). So maybe adding a Fixes: 
tag for this as suggested by Dominique?

With the patch applied, this issue disappeared. Give me some hours for more 
thorough tests, due to the random factor involved.

>  fs/netfs/read_collect.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index a95e7aadafd0..7a0ffa675fb1 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -137,7 +137,7 @@ static void netfs_read_unlock_folios(struct
> netfs_io_request *rreq, rreq->front_folio_order = order;
>  		fsize = PAGE_SIZE << order;
>  		fpos = folio_pos(folio);
> -		fend = umin(fpos + fsize, rreq->i_size);
> +		fend = fpos + fsize;
> 
>  		trace_netfs_collect_folio(rreq, folio, fend, 
collected_to);

What about write_collect.c side, is it safe as is?

/Christian



