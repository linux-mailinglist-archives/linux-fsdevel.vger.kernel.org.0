Return-Path: <linux-fsdevel+bounces-38750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E41A07C68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 16:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D639188C39F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6621D583;
	Thu,  9 Jan 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Gm/yzwmO";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CiXXoUcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4D21E0A6;
	Thu,  9 Jan 2025 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437839; cv=none; b=ChEZps1rTNj1o7EJGptI7fNEzNfi0HQSYKqQ/xWpvaKWin8qaAqBifkWTHyqVz47h0YBNG/o7sJcHyiiDqQzOjVsbRcC0CUPJQT7JzbdpAW6/YNT1aPiy7fMWeF9COQST5GKxdxOEXGokxGQTsYa7HEKPpXOo9t5EvjZ8Kc0Dxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437839; c=relaxed/simple;
	bh=Y+NALXzWAOb4cRzU3p94qNqwrTFqvz5LULlvKeAgxK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZenGQD5XZo/L7Yr/s3VfF7ZBinGh6FLFBmj3hCVM60vqNzGX9NynPOdyRSJirHmqIKcYIH2YC5AUF34YvxYmPn94WUA8IDGBFrLYFUPgtdk6Jas8OzdN5xbPUvDypqFTXse8F12x1A2MQK94mnJLipO18ZutQJbCWetpCqdJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Gm/yzwmO; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CiXXoUcS; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736437830;
	bh=Y+NALXzWAOb4cRzU3p94qNqwrTFqvz5LULlvKeAgxK8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Gm/yzwmO9nyDmVzD/tj97tUK81hqEb5sN2Bs4iklfTVlvUjq7IX8Al1jaVJ0qD3y6
	 HLKmTWhNntBgucsy6ZNc1HF0PCJxtdF33mC4ysFZ9kz1Ie6A4oyICjhJJq5UrSg56p
	 89GbiAWycqvnmFk0SyVIzf0ryadbnH8Mnaik0sh8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 38AED128165E;
	Thu, 09 Jan 2025 10:50:30 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 3dhUy0ueGQSr; Thu,  9 Jan 2025 10:50:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736437829;
	bh=Y+NALXzWAOb4cRzU3p94qNqwrTFqvz5LULlvKeAgxK8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CiXXoUcSKvS8RYwEooB5HhSi+KvRV700y2rzEZfHoa/naL/e07DsYpeBdaPuWGnxb
	 ++gSba5moVjosLyy/OX79fSgxV/Bjler6LHTKpQeuyapGxmC9/eDi3Q+i2gippdLDo
	 7Qmqzri1CKR6qlKAYkX+x8JeGIyaqGai3BPvMh6o=
Received: from [172.20.4.117] (unknown [74.85.233.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 90418128135E;
	Thu, 09 Jan 2025 10:50:29 -0500 (EST)
Message-ID: <8ec4aa383506dd1c28c650874b3d8e36ded2a2c9.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/6] convert efivarfs to manage object data correctly
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Jeremy Kerr
	 <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro
	 <viro@zeniv.linux.org.uk>
Date: Thu, 09 Jan 2025 07:50:28 -0800
In-Reply-To: <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-01-09 at 10:50 +0100, Ard Biesheuvel wrote:
> On Tue, 7 Jan 2025 at 03:36, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > James Bottomley (6):
> >   efivarfs: remove unused efi_varaible.Attributes and .kobj
> >   efivarfs: add helper to convert from UC16 name and GUID to utf8
> > name
> >   efivarfs: make variable_is_present use dcache lookup
> >   efivarfs: move freeing of variable entry into evict_inode
> >   efivarfs: remove unused efivarfs_list
> >   efivarfs: fix error on write to new variable leaving remnants
> > 
> 
> Thanks James,
> 
> I've tentatively queued up this series, as well as the hibernate one,
> to get some coverage from the robots while I run some tests myself.
> 
> Are there any existing test suites that cover efivarfs that you could
> recommend?

I'm afraid I couldn't find any.  I finally wrote a few shell scripts to
try out multiple threads updating the same variable.  I think I can
probably work out how to add these to the kselftest infrastructure. 
Hibernation was a real pain because it doesn't work with secure boot,
but I finally wrote a UEFI shell script to modify variables and reset.
Unfortunately I don't think we have a testing framework I can add these
to.

Regards,

James


