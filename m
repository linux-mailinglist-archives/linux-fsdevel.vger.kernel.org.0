Return-Path: <linux-fsdevel+bounces-36697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CCB9E82AF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 00:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3B5165126
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474FB15530C;
	Sat,  7 Dec 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="hc66G4wm";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="W4+PkAK/";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="rDv5NxyH";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="I7IUFhKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928517E0
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Dec 2024 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733612943; cv=none; b=Ur+IFdveyDQahkm44Eum0fSSKJWMmyuXKA2//ScN6GGtx9FU9HW+jSSDkof7M2qStTQSi7FsA6nhPtR+HXfOQu8prBH2qlW0BzI98SOr0G4CM9pq9DJBJA/msP99ohwm66A4myFlJxrSU1WERbqDeupGvq9ZTLNxpY48JXWWZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733612943; c=relaxed/simple;
	bh=vM05v299J0GdZy6SfknXBKtGIY6QsTzDDp+lr125jT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKGfQqtSCRfYKAOdaIFyzEYQ3K56yarSGck8c5wRxOqh1/0k6ToTEbDGPUpUCjaOB+S/jKt9o1gCm2XF0ffGeEXxvEmbsvtl1f0I/oYW6BBOoALx+k2BZe7gOzFybj5srW4CSbbSoYW8TmG+DhnUMjGbtB64jkv5qgUX15V3kmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=hc66G4wm; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=W4+PkAK/; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=rDv5NxyH; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=I7IUFhKL; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:8215:8949:cdce:4764])
	by mail.tnxip.de (Postfix) with ESMTPS id 029B9208CC;
	Sun,  8 Dec 2024 00:01:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733612490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM05v299J0GdZy6SfknXBKtGIY6QsTzDDp+lr125jT0=;
	b=hc66G4wmPmRv/fLXPm9nvvWKAL2aSUcUEtViU2YXNXrVI0oUTch7jtlQJwjblyfZN8PiCk
	ubP9OWIN23RNRJDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733612490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM05v299J0GdZy6SfknXBKtGIY6QsTzDDp+lr125jT0=;
	b=W4+PkAK/YlVcDCua1pM5RTE+KPmbHBB2jGJyzU6RE/g3Q/g0VD/UFbJmWCYV3fTWR3Op86
	O1y84rPAMYhLeJYhqrzXQqXcNw9STb+B+znV27H9wMpupZNlU4KNMRLi6wPoXgXx9iZrEm
	W35tB/wJ+j4htNwybbvs5bzleb92woQ=
Received: from [IPV6:2a04:4540:8c02:dc00:6184:83fd:f934:64f6] (highlander.local [IPv6:2a04:4540:8c02:dc00:6184:83fd:f934:64f6])
	by gw.tnxip.de (Postfix) with ESMTPSA id 9222F58034C9A;
	Sun, 08 Dec 2024 00:01:11 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733612489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM05v299J0GdZy6SfknXBKtGIY6QsTzDDp+lr125jT0=;
	b=rDv5NxyHjAnmqNA0MVZER9nZpc5l/pzCQ0zyYqd6erOp6h41dUFEt/HeUeu/XOXSINqtoR
	2oFGmzFN9/0bZXAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733612489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM05v299J0GdZy6SfknXBKtGIY6QsTzDDp+lr125jT0=;
	b=I7IUFhKLSGU/l0eSKptkhGtloE8G9ArHEoxbKSZemd6e+YrZn3d6AgvLHhpqnVKLIymxwn
	HIQdggm9wchTu/Z72MvUpRHb4ApIyYgwp7GwyOA3R4ePOc9pq4RSY0etqIGEl66TBVtGiF
	6nm/WUXguIuj0vfSaVxegr8TmPYQE7E=
Message-ID: <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
Date: Sun, 8 Dec 2024 00:01:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: silent data corruption in fuse in rc1
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Joanne Koong
 <joannelkoong@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/12/2024 22:58, Kent Overstreet wrote:
> Hey Miklos, I've got a user who noticed silent data corruption when
> building flatpaks on rc1; it appeared when using both bcachefs and btrfs
> as the host filesystem, it's now looking like fuse changes might be the
> culprit - we just got confirmation that reverting
> fb527fc1f36e252cd1f62a26be4906949e7708ff fixes it.
>
> Can you guys take it from here? Also, I think a data corruption in rc1
> merits a post mortem and hopefully some test improvements, this caused a
> bit of a freak out.
Hi
all,                                                                        
                                                                             
 
I did report this. What I encountered is flatpak installs failing on
bcachefs  
because of mismatching hashes. I did not notice any other issues, just
this    
thing with flatpak. Flatpak seems to put downloaded files into
directories     
mounted with "revokefs-fuse" on /var/tmp. So far I could only reproduce
this on
bcachefs, it does not happen when I make /var/tmp a tmpfs or when I
bind-mount
a directory from a btrfs onto
/var/tmp.                                        
                                                                             
 
To me there seems to be some bad interaction between fuse and
bcachefs.        
                                                                             
 
Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
me.     
                                                                             
 
Regards                                                                      
 
                                                                             
 
/Malte                                                                       
 


