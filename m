Return-Path: <linux-fsdevel+bounces-46623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7AEA918D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968A24481CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1950422ACF7;
	Thu, 17 Apr 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="0fdtNDFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3222A1D5;
	Thu, 17 Apr 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884633; cv=none; b=HFcvwHvyTBK3kLmptryc1mZqzkD7o9PkRW2Fr+bjdDTSSTwi/nx4N72yxTdTTnXruArzcOodT+yW0S2RPdhDi0hghwBvFaH1gVZqSuEzBvjq9lvyefb79tQKxzHqYtaH9ogA9ciwHc2ccE+MBFmtLyTUTcZTQFzPmdBKLVJ7KYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884633; c=relaxed/simple;
	bh=EsRsSj5ZTvOM1KJnm90ywQ0x9hB4YFNumvk55p/KIbc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MHoLcjh/Dt3HgNoboxpTPuAtU5O+B5ogZQDuz3IGZEeThTfMbfYX/XQ5ChJvwl4ad0kmbMQtOX4ad74fbWvYLPmwqW0YnlPUavXSQ8sL+88LKE3c1KemYfbiQIxMTFzRSFzYVcPe4CRBV6l0PSBa9Ywe019ynJTt2VkxcOcEkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=0fdtNDFs; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 55498CB;
	Thu, 17 Apr 2025 12:10:23 +0200 (CEST)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id VFVFhVEXUlTK; Thu, 17 Apr 2025 12:10:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr DF2908D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1744884621; bh=cEovSie5bPZsVx3CnJ0Skbpj6zHabO1hydZaJkwFs24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0fdtNDFsENFoaAUJ1xp+B2t6xldOSGZCp/9jU3VMorwZR/NMZmgoBIRIT8zhqtx8U
	 EBk4DCw5ETeFbBjJdR5w2avtzTOKQe3VoQ/HRpTT7i63LKsWRNykBga6gTBb3nzgAJ
	 QG9k6ELrX9gesnEBfutnItM7aYs1IlM/0Uj/Q+3O1ve0ndMVBXOchwgAK5VSV26xHu
	 wbmp+ib7sPZxAdZK/LkdctofD+y79KN0Kn6Ed37CErv//eqw8b0yT/HlhAGy5c3FgV
	 qPPYF3MqJLQtl9j0AKVWvq4WzYhzyVA/yqNrHy99FEcYDWivXv+xAyN1xVDAYYjbkp
	 tGelecKgztLIQ==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id DF2908D;
	Thu, 17 Apr 2025 12:10:20 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Apr 2025 12:10:20 +0200
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when files
 are on CIFS share
In-Reply-To: <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
 <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
 <5087f9cb3dc1487423de34725352f57c@3xo.fr>
 <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com>
Message-ID: <e63e7c7ec32e3014eb758fd6f8679f93@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Paulo

Resending this mail with content-type: text, sorry !

Thanks again for answer and help, it's good to hear you're back to 
health.

> Thanks for the trace.  I was finally able to reproduce your issue and 
> will provide you with a fix soon.

Perfect... And thanks !

If you need more traces or details on (both?) issues :

- 1) infinite loop issue during 'cat' or 'copy' since Linux 6.14.0

- 2) (don't know if it's related) the very high number of several bytes 
TCP packets transmitted in SMB transaction (more than a hundred) for a 5 
bytes file transfert under Linux 6.13.8

Do not hesitate to ask, I would be happy to help.

Kind regards
Nicolas




Le 2025-04-15 20:28, Paulo Alcantara a écrit :

> Hi Nicolas,
> 
> Sorry for the delay as I've got busy with some downstream work.
> 
> Nicolas Baranger <nicolas.baranger@3xo.fr> writes:
> 
> I'll look into it as soon as I recover from my illness. Hope you're 
> doing better

I'm fully recovered now, thanks :-)

> I had to rollback to linux 6.13.8 to be able to use the SMB share and
> here is what I constat
> (don't know if it's a normal behavior but if yes, SMB seems to be a 
> very
> very unefficient protocol)
> 
> I think the issue can be buffer related:
> On Linux 6.13.8 the copy and cat of the 5 bytes 'toto' file containing
> only ascii string 'toto' is working fine but here is what I capture 
> with
> tcpdump during transfert of toto file:
> https://xba.soartist.net/t6.pcap
> 131 tcp packets to transfer a 5 byte file...
> Isn't there a problem ?
> Openning the pcap file with wireshark show a lot of lines:
> 25    0.005576    10.0.10.100    10.0.10.25    SMB2    1071    Read 
> Response, Error:
> STATUS_END_OF_FILE
> It seems that those lines appears after the 5 bytes 'toto' file had 
> been
> transferred, and it continue until the last ACK recieved

Thanks for the trace.  I was finally able to reproduce your issue and
will provide you with a fix soon.

