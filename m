Return-Path: <linux-fsdevel+bounces-46176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB73A83D65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D31189BC94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50420C005;
	Thu, 10 Apr 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="Wwv6qlzo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE60202990;
	Thu, 10 Apr 2025 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274643; cv=none; b=CLSMW1bo1TdeBx3lRrCQlRi1ufZerGSK5aJvVrATgQcc3TonUM6Q8YrFp+YEXBzp8+XvcM4Dt6b5n0TsGPGPiHNmQ019bAtjmJRaaWTbE2uxSA0V1s0nWvM1kVOkG7gbe2R9R1weQqGBqX3b8ez+XcsGdp02KyoxHSZtnIxl6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274643; c=relaxed/simple;
	bh=Vpk8nplB1wj9E13TXADDvPqFxzaBerQ86uW89U5RWo8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tcTWBHmEYMHz/ZIjCoXhQxGFCny0bTg7YP4VdQhvD91U9zCnUlH7XQ3GaWXcMSyGX23WQf1Cg9WP6R7vYGZVDp2FG6XZj4rEuwrum5BMpwVrRXU2s+C5CywOkqhHRuK6FuptC7wAtA0RtyMJ5uY/gUAqZHKMaoocFsT3sa75eTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=Wwv6qlzo; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 0B10ECB;
	Thu, 10 Apr 2025 10:43:52 +0200 (CEST)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id ST9nfpKQCXh0; Thu, 10 Apr 2025 10:43:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr ABFAE8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1744274629; bh=gpkc/Zuf1WpbTIAUiJ2w1zOFyK70naPcUp8Y7Qf8Rks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wwv6qlzo797zVLcsFEVhEgyNU5WA0ftIIq7sRw1Vu0WUatXNcyOH308kJ/7gwF1Dv
	 u8L1xk1W7EaC6HEJyLMFGmdAv9NykvD/HnVgCqd5HhQNbYWgfyHFkXvMBS8I0rgnlG
	 8tAqiJuQ/XDrKGrMo+77ReTMe4U3LF/jiPbgLO2xVbwPSC0CRHc27LlPxNCqKkmKmY
	 16QwBhUPQ6S9/Ps1bSKPEnM4+yaFmYTbZRbGIZIkRyARC46eYaLeIwg6K/DsWAAmb7
	 tnfWqMI24Zegf/+W42lHj0YH/tUCbJPI+zqY/ImlCjWauxAfhZhOusDNo7A3XuldlI
	 I2RD4XgqQacsQ==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id ABFAE8D;
	Thu, 10 Apr 2025 10:43:49 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Apr 2025 10:43:49 +0200
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when files
 are on CIFS share
In-Reply-To: <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
 <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
Message-ID: <5087f9cb3dc1487423de34725352f57c@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Paulo

Thanks for answer and help

> I'll look into it as soon as I recover from my illness.
Hope you're doing better

I had to rollback to linux 6.13.8 to be able to use the SMB share and 
here is what I constat
(don't know if it's a normal behavior but if yes, SMB seems to be a very 
very unefficient protocol)

I think the issue can be buffer related:
On Linux 6.13.8 the copy and cat of the 5 bytes 'toto' file containing 
only ascii string 'toto' is working fine but here is what I capture with 
tcpdump during transfert of toto file:
https://xba.soartist.net/t6.pcap
131 tcp packets to transfer a 5 byte file...
Isn't there a problem ?
Openning the pcap file with wireshark show a lot of lines:
25	0.005576	10.0.10.100	10.0.10.25	SMB2	1071	Read Response, Error: 
STATUS_END_OF_FILE
It seems that those lines appears after the 5 bytes 'toto' file had been 
transferred, and it continue until the last ACK recieved

I will try to reboot on Linux 6.14.0 mainline to see if I have the same 
behavior or to see what I get in the packet capture
(system is in production, I cannot reboot on a failing kernel when I 
want, it should be organised... sorry)

Let me know if you reproduced the issue

Kind regards
Nicolas Baranger



Le 2025-04-04 15:54, Paulo Alcantara a écrit :

> Hi Nicolas,
> 
> I'll look into it as soon as I recover from my illness.  Sorry for the 
> delay.
> 
> On 4 April 2025 08:50:27 UTC, Nicolas Baranger 
> <nicolas.baranger@3xo.fr> wrote: Hi Christoph
> 
> Thanks for answer and help
> Did someone reproduced the issue (very easy) ?
> 
> CIFS SHARE is mounted as /mnt/fbx/FBX-24T
> echo toto >/mnt/fbx/FBX-24T/toto
> 
> ls -l /mnt/fbx/FBX-24T/toto
> -rw-rw-rw- 1 root root 5 20 mars  09:20 /mnt/fbx/FBX-24T/toto
> 
> cat /mnt/fbx/FBX-24T/toto
> toto
> toto
> toto
> toto
> toto
> toto
> toto
> ^C
> 
> CIFS mount options:
> grep cifs /proc/mounts
> //10.0.10.100/FBX24T /mnt/fbx/FBX-24T cifs 
> rw,nosuid,nodev,noexec,relatime,vers=3.1.1,cache=none,upcall_target=app,username=fbx,domain=HOMELAN,uid=0,noforceuid,gid=0,noforcegid,addr=10.0.10.100,file_mode=0666,dir_mode=0755,iocharset=utf8,soft,nounix,serverino,mapposix,mfsymlinks,reparse=nfs,nativesocket,symlink=mfsymlinks,rsize=65536,wsize=65536,bsize=16777216,retrans=1,echo_interval=60,actimeo=1,closetimeo=1 
> 0 0
> 
> KERNEL: uname -a
> Linux 14RV-SERVER.14rv.lan 6.14.0-rc2-amd64 #0 SMP PREEMPT_DYNAMIC Wed 
> Feb 12 18:23:00 CET 2025 x86_64 GNU/Linux
> 
> Kind regards
> Nicolas Baranger
> 
> Le 2025-03-28 11:45, Christoph Hellwig a écrit :
> 
> Hi Nicolas,
> 
> please wait a bit, many file system developers where at a conference
> this week.

