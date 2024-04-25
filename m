Return-Path: <linux-fsdevel+bounces-17837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D631E8B2B3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 23:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147F81C23DB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D1155A53;
	Thu, 25 Apr 2024 21:45:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDD155A47
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081517; cv=none; b=QRPfAkV/ccEiqKQX3nqEWkrdJ5gbAmGRCIoJ2huZezLj5F/oaGOWdBP3WH7qwBdmNv2CyDjcK/AfYqFJ8AiTG9eKUE/e8A7W2iMdE2Ufo8UMLlGp3dDU7Ro4ATmzRKc/eYL6xIymrwU7ojUcG3j3dRSyT6psgFudlGeS93fIR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081517; c=relaxed/simple;
	bh=54TmoJLahOSFohzjFA5WN4CsmAqEDwDW1crUpuVdjYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzxys7srD6J1palww7ntE1h9nCAPYOQkq0gmrOu3DkV4lANk4nYyw/Fege4K3sWE0atFU07ENfk8ruXdrA+pQikBiteqBr8DQGr5gXN3GKJ+dPpH+MpcFkhm/mgBC04PV8/AbLXEK8IJiVVjBknrvTdfoYWWpjSTRePC5G0Qwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski; spf=none smtp.mailfrom=osuchow.ski; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osuchow.ski
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4VQTsz43q0z9scj;
	Thu, 25 Apr 2024 23:45:11 +0200 (CEST)
Message-ID: <f9fb4d8b-1aa6-4223-91c0-eba4b79a8975@osuchow.ski>
Date: Thu, 25 Apr 2024 23:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fs: Create anon_inode_getfile_fmode()
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz
References: <20240424233859.7640-1-linux@osuchow.ski>
 <20240425-wohltat-galant-16b3360118d0@brauner>
 <20240425202550.GL2118490@ZenIV>
Content-Language: en-US
From: Dawid Osuchowski <linux@osuchow.ski>
In-Reply-To: <20240425202550.GL2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4VQTsz43q0z9scj

On 4/25/24 22:25, Al Viro wrote:
> On Thu, Apr 25, 2024 at 11:57:12AM +0200, Christian Brauner wrote:
>> On Thu, Apr 25, 2024 at 01:38:59AM +0200, Dawid Osuchowski wrote:
>>> Creates an anon_inode_getfile_fmode() function that works similarly to
>>> anon_inode_getfile() with the addition of being able to set the fmode
>>> member.
>>
>> And for what use-case exactly?
> 
> There are several places where we might want that -
> arch/powerpc/platforms/pseries/papr-vpd.c:488:  file = anon_inode_getfile("[papr-vpd]", &papr_vpd_handle_ops,
> fs/cachefiles/ondemand.c:233:   file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
> fs/eventfd.c:412:       file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
> in addition to vfio example Dawid mentions, as well as a couple of
> borderline cases in
> virt/kvm/kvm_main.c:4404:       file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
> virt/kvm/kvm_main.c:5092:       file = anon_inode_getfile("kvm-vm-stats",
> 
> So something of that sort is probably a good idea.  Said that,
> what the hell is __anon_inode_getfile_fmode() for?  It's identical
> to exported variant, AFAICS. 

Thank you for the feedback. I tried emulating what I saw in the other 
functions (which was clearly wrong). Will address this is in next revision.

  And then there's this:
> 
> 	if (IS_ERR(file))
> 		goto err;
> 
> 	file->f_mode |= f_mode;
> 
> 	return file;
> 
> err:
> 	return file;
> 
> a really odd way to spell
> 
> 	if (!IS_ERR(file))
> 		file->f_mode |= f_mode;
> 	return file;

Same for this, will rewrite it based on your suggestion.

-- Dawid


