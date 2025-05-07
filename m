Return-Path: <linux-fsdevel+bounces-48395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE73AAE5F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A5D50003E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2428B7FA;
	Wed,  7 May 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="aADmR4cE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBF28B7DC;
	Wed,  7 May 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633959; cv=none; b=gibI/RiQdCr2ND5FU4g+0KjUXLwEUyWE3gbBF+XjhWHLmIhdASEGTMvtxqbwylZVP6ousdmgDsNTXJazIhl7NWR3Z3vJXT8dztqg1oWwVuM+y2IKGCy/PQ3KllJwjbigwwtCnS1yV2ohAf0sjRMMMjL99eBnhn+AHioBKpAdB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633959; c=relaxed/simple;
	bh=x0GhAdTrsUjoll9UJ2scIqlF4JD4LTwaMQXDabkmEbY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PNduHskfypZeaPn/V1oMrmOfEN1MEAn1xhMUhTxwFqjCs+8j5vZNyrqC3ktqxg1ePYTsUWLJOE73zuzV9QDC/BfzykSZ5e4Ko53RC3sFzufsgbeV65f6zLlB3MqxrvqF5bPRaDqPos2WE4IE4zDCBBb4WMxFV6YyTB/5ZqCLHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=aADmR4cE; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 97959CB;
	Wed,  7 May 2025 17:59:01 +0200 (CEST)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id s-y2X6RhqgSo; Wed,  7 May 2025 17:58:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr 0A4A08D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1746633539; bh=z9CikFXAeKFWOimfQF9yvtUss98FljLb1RvOvIhBgOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aADmR4cEDRykDletGNFs1jjnJfrJw+6GnyYprK83CZrRd3tyEy6ub0QVpmzlbeazj
	 psoK4uZwGo8lE4eCpyFy/sZzTGN+nqdCvbzMi75ZUqlOvTf4pBaSMDrWN4NHYbjKm7
	 bDptnwVG7o9vy6zED37DnAlYY6ZHaF/WnwuvHkNIY2K3D/YXWknc0fgwlHDZkyBevA
	 YIiT1HMgOfDgIBn+r6hwNmQKcENMYMqfLC0KaK/eeMUW4APFAGaH0E+WiMg5BaW5GF
	 O4GOukJMPKZQVl0NsKxysVgRQGaoanjfVpx8FBoaw1l9RLMUk+rB9RDnMoKxykF+PW
	 Usb6564G5QQWw==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id 0A4A08D;
	Wed,  7 May 2025 17:58:59 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 May 2025 17:58:58 +0200
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when files
 are on CIFS share
In-Reply-To: <df978e3da9bec1a5e040448f6341b646@manguebit.com>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
 <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
 <5087f9cb3dc1487423de34725352f57c@3xo.fr>
 <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com>
 <e63e7c7ec32e3014eb758fd6f8679f93@3xo.fr>
 <53697288e2891aea51061c54a2e42595@manguebit.com>
 <bb5f1ed84df1686aebdba5d60ab0e162@3xo.fr>
 <af401afc7e32d9c0eeb6b36da70d2488@3xo.fr>
 <a25811b8d4f245173f672bdfa8f81506@3xo.fr>
 <e0b7f4902af6c758b5cdb7c2b7892b43@manguebit.com>
 <df978e3da9bec1a5e040448f6341b646@manguebit.com>
Message-ID: <4367e54becaf348ac6c18e0b298dcd7e@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Paulo

I'm testing this branch and going back with results

Thanks again !
Nicolas

Le 2025-05-07 00:53, Paulo Alcantara a écrit :

> Hi Nicolas,
> 
> Could you try my cifs.dio branch [1] which contains the following fixes
> 
> afea8b581c75 ("netfs: Fix wait/wake to be consistent about the 
> waitqueue used")
> ae9f3deaa17a ("netfs: Fix the request's work item to not require a 
> ref")
> b2a47dc3ead6 ("netfs: Fix setting of transferred bytes with short DIO 
> reads")
> c59f7c9661b9 ("smb: client: ensure aligned IO sizes")
> 
> Let me know if you find any issues with it.  Thanks.
> 
> [1] https://git.manguebit.com/linux.git

