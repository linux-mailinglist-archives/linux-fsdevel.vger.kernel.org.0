Return-Path: <linux-fsdevel+bounces-45738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F5CA7B96A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0697A6F8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546891A2398;
	Fri,  4 Apr 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="lb20VlKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E719D081;
	Fri,  4 Apr 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757071; cv=none; b=jW+yyNWOsMhFFA4VHdgK/Bom4FR0CzXtamNO1p6w3BQxjbvR4uqQ5jVUIRQJJg+JgRX/MX3ZQ1djy1TsD98FPhZSiFqgld4wHdf2w82Gv+FOH3vDvlcu9gNd0z3hp3rJLfyKUZqfYFItptu1zU4awtIvTNhJOIermpYIHm1oHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757071; c=relaxed/simple;
	bh=qGpiBlKk4gUz7SGt4N7XSRFqC2Dp6ovYU5+SiSPQizM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oSRHVbAWEB4F7MrU7nN8kjBM2Z3OAH1vOv/0Q5zy7EjHUbWOt7wT0/gkBnQGjQv6tf0LJHyHyUpbyDzi4DdKMxdPcESE9I+taXUrlVM14RC7YWj9u9FBmXfJ5x5+yRhOtWfqyOR+tr/J18TXcvcRhCBZqsugQHc/+hKSuglo0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=lb20VlKf; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 98EECCD;
	Fri,  4 Apr 2025 10:50:29 +0200 (CEST)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id 8mSLMhAe8CKe; Fri,  4 Apr 2025 10:50:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr 83FED8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1743756627; bh=CRAJN8+XEA5p31GSsFqFuEJaey0yqN9dDs07tGG1jQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lb20VlKfcjY8a7J/mtS3DUFvklSqJjYHbNOpvr5mvDuUiTcUAZTrS4jvwIYi8pDbd
	 jngz7iyj2q4qcYbEo0GDpo08Z9QRGAjpQdVAP4VFFDrkW8nKXq1Eo/bYXKZQyW/m7B
	 XtHudX59MBoF8M+9EXMuM/86MpKMuPEiXhr+YP1CU432PwUleI3pWhJKH/mAgcVGfr
	 mdDYTpedNVvrT51XQzQsffn4Jv0RJ4oEF+cxyX+4fVC8705kTxtdIRIKH8XCDQCNsY
	 a6gvuy2X4ZE69DNF8SCmUBX3heBPxYDV9qklLKzRt+nmF+63iq/i6DC6LOg1J4dW24
	 aayyaaredgRCQ==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id 83FED8D;
	Fri,  4 Apr 2025 10:50:27 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Apr 2025 10:50:27 +0200
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@lst.de, David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steve French <smfrench@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when files
 are on CIFS share
In-Reply-To: <Z-Z95ePf3KQZ2MnB@infradead.org>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
Message-ID: <48685a06c2608b182df3b7a767520c1d@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Christoph

Thanks for answer and help
Did someone reproduced the issue (very easy) ?


CIFS SHARE is mounted as /mnt/fbx/FBX-24T
echo toto >/mnt/fbx/FBX-24T/toto

ls -l /mnt/fbx/FBX-24T/toto
-rw-rw-rw- 1 root root 5 20 mars  09:20 /mnt/fbx/FBX-24T/toto

cat /mnt/fbx/FBX-24T/toto
toto
toto
toto
toto
toto
toto
toto
^C


CIFS mount options:
grep cifs /proc/mounts
//10.0.10.100/FBX24T /mnt/fbx/FBX-24T cifs 
rw,nosuid,nodev,noexec,relatime,vers=3.1.1,cache=none,upcall_target=app,username=fbx,domain=HOMELAN,uid=0,noforceuid,gid=0,noforcegid,addr=10.0.10.100,file_mode=0666,dir_mode=0755,iocharset=utf8,soft,nounix,serverino,mapposix,mfsymlinks,reparse=nfs,nativesocket,symlink=mfsymlinks,rsize=65536,wsize=65536,bsize=16777216,retrans=1,echo_interval=60,actimeo=1,closetimeo=1 
0 0

KERNEL: uname -a
Linux 14RV-SERVER.14rv.lan 6.14.0-rc2-amd64 #0 SMP PREEMPT_DYNAMIC Wed 
Feb 12 18:23:00 CET 2025 x86_64 GNU/Linux


Kind regards
Nicolas Baranger


Le 2025-03-28 11:45, Christoph Hellwig a écrit :

> Hi Nicolas,
> 
> please wait a bit, many file system developers where at a conference
> this week.

