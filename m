Return-Path: <linux-fsdevel+bounces-46510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F54A8A6C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 20:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D91900935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA622686F;
	Tue, 15 Apr 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="Vmm8yYma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4F222565;
	Tue, 15 Apr 2025 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741701; cv=none; b=f/e7aaVZe9ekfAQyoLMWiZbZxBE8nZYodMqlPqOUblHERFNz5POyH3RBKmsR9VDGg+8GBrEkP/zVIeSAYXHmQWofpjbY8MosWqANRUTKxlcba994yP9untTpnlW+aHP/fxS6iUKIQ96hoYIs3yQRJcAPB23WP+gp+GxB1Q09CMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741701; c=relaxed/simple;
	bh=KBUcfOPfTWKlv1r0T05CNzWz2hKo8/DBtVqmvyTw5cU=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=tacFThewCqJt+gTBZoiA+7dNy/Ae8RoD2dd2ewL/LERmsY5hnFQ9nYs0Y3BjVK4sNvOVx5aakWUYZkn3miFm1dG4Cj1lBgJK72XnnvgPLvjjqd/d+YBIr03MM1kcTm4jKzeXw4+vtRHrGhcPGeMj3bmES+9bkrWgKUC9vDkRiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=Vmm8yYma; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1744741698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQXRd0G+3P1w/z1AT2Nr8p00ZghYti5DoxzAHJ9JJCI=;
	b=Vmm8yYmaY47rhsPNq32DNzSBuzYfYEzbi8LXZAXCGUdlLurpoOMqKbvxraJCCmWgi2SAYj
	Y1Io5fZv8eoiIBKDIBBSMt3jm+zVVqHMYz+94GwCeffAcvQoks4U6ZCGnf5Isckgs/Goyp
	REO7ni9vd5bdUsVPXMWyCizcSZFVcSulPf7MgaKcfXOzsjIGunKEMKOy+gJwlIyoMVj2io
	9Nc4eAGnijmz6jrp/gXs7SGHWfsuFrE9PM1cNcEMKWLcYS0pfBkvJm514I1gdrwSr8nlih
	LgfjNdJBEf2uzEYpaTtTPb4CqEEiL7gh/dNVmacqqinoLptfteLJQYxDK1B7hQ==
From: Paulo Alcantara <pc@manguebit.com>
To: Nicolas Baranger <nicolas.baranger@3xo.fr>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when
 files are on CIFS share
In-Reply-To: <5087f9cb3dc1487423de34725352f57c@3xo.fr>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
 <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
 <5087f9cb3dc1487423de34725352f57c@3xo.fr>
Date: Tue, 15 Apr 2025 15:28:14 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Nicolas,

Sorry for the delay as I've got busy with some downstream work.

Nicolas Baranger <nicolas.baranger@3xo.fr> writes:

>> I'll look into it as soon as I recover from my illness.
> Hope you're doing better

I'm fully recovered now, thanks :-)

> I had to rollback to linux 6.13.8 to be able to use the SMB share and 
> here is what I constat
> (don't know if it's a normal behavior but if yes, SMB seems to be a very 
> very unefficient protocol)
>
> I think the issue can be buffer related:
> On Linux 6.13.8 the copy and cat of the 5 bytes 'toto' file containing 
> only ascii string 'toto' is working fine but here is what I capture with 
> tcpdump during transfert of toto file:
> https://xba.soartist.net/t6.pcap
> 131 tcp packets to transfer a 5 byte file...
> Isn't there a problem ?
> Openning the pcap file with wireshark show a lot of lines:
> 25	0.005576	10.0.10.100	10.0.10.25	SMB2	1071	Read Response, Error: 
> STATUS_END_OF_FILE
> It seems that those lines appears after the 5 bytes 'toto' file had been 
> transferred, and it continue until the last ACK recieved

Thanks for the trace.  I was finally able to reproduce your issue and
will provide you with a fix soon.

