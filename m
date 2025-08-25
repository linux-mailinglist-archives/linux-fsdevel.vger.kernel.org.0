Return-Path: <linux-fsdevel+bounces-59067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C28DB340C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377FF17B395
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059A277C90;
	Mon, 25 Aug 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RjQZU9H2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C027510B;
	Mon, 25 Aug 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128702; cv=none; b=rAjg29egX9Hjne9diDyNaCc3R7h0Kv0MnJUsWuqUGIpRBWaDdEBFtdohJWYLtViDDm6hGnM+QqmiLzFJmBJJR2jOrc3csa3tpPqlSTCyowX6QFmvsPYqyhxvLWltonT1lhSe5XngZUz4NJGeGV92yCdpxopE1iYemu2ZJ1cajHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128702; c=relaxed/simple;
	bh=6O5W/y80iaKkDYIuTZU5ULjARvkCS0FnEOvGtJR9bwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyQ2vbuhx6RFR9/XfFfhXXGZzHGJhM3dLkq/5UWLaEsC+U5HtbrqcPtoqTh6RpBPl1Hf25bTp/Bah+ty1YwuFFvldrv4hf1MYqLSVQA3QI4+ErcVr+u2MrTRQWDPRpCY/0qNB0AZuuNfd1Exp4d5n8fRaKSkSY0NH6KU1Craics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RjQZU9H2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vXizZ6L0n8V782CYb3FHXRs1CctnBrwFXRGLWjyJOok=; b=RjQZU9H2eLaeNbY+/Xvon5f24G
	H2wYLPrTIIfQck+LUpB1PV9QSoUakr7mivtpkJTyg7SICW6BSGSRX5B6tBKcF4sUktzAEMz9DaYEf
	gYKPcwAi+Lwj8PQQnofEe5iyiK2io0K1SjSEJsMiHfecJlnfvqCEGHd9soWeWz0IwG/n8HFJ6Lg7w
	ui2AvLdB5SY1wLOMPCGysM2ORPZYgQ7j5kjfJNeuMWANksMgBbevtqwWwYKCVrfk5aBYDjFL1QwSF
	5aEmWRlkm8ZP3TnOoapdSVBZW3DRZYA4Md9IPAldpqH2Q5QvjBQG+0t81zNoJjGoKih1uMlnndsvS
	ayEauFcw==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uqXI9-001Pu6-Ip; Mon, 25 Aug 2025 15:31:21 +0200
Message-ID: <6235a4c0-2b28-4dd6-8f18-4c1f98015de6@igalia.com>
Date: Mon, 25 Aug 2025 10:31:16 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled
 layers
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com>
 <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
 <62e60933-1c43-40c2-a166-91dd27b0e581@igalia.com>
 <CAOQ4uxjgp20vQuMO4GoMxva_8yR+kcW3EJxDuB=T-8KtvDr4kg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxjgp20vQuMO4GoMxva_8yR+kcW3EJxDuB=T-8KtvDr4kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Amir,

Em 22/08/2025 16:17, Amir Goldstein escreveu:

[...]

   /*
>>>> -        * Allow filesystems that are case-folding capable but deny composing
>>>> -        * ovl stack from case-folded directories.
>>>> +        * Exceptionally for layers with casefold, we accept that they have
>>>> +        * their own hash and compare operations
>>>>            */
>>>> -       if (sb_has_encoding(dentry->d_sb))
>>>> -               return IS_CASEFOLDED(d_inode(dentry));
>>>> +       if (ofs->casefold)
>>>> +               return false;
>>>
>>> I think this is better as:
>>>           if (sb_has_encoding(dentry->d_sb))
>>>                   return false;
>>>
> 
> And this still fails the test "Casefold enabled" for me.
> 
> Maybe you are confused because this does not look like
> a test failure. It looks like this:
> 
> generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed lookup
> in lower (ovl-lower/casefold, name='subdir', err=-116): parent wrong
> casefold
> [  150.669741] overlayfs: failed lookup in lower (ovl-lower/casefold,
> name='subdir', err=-116): parent wrong casefold
> [  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
> name='casefold', err=-66): child wrong casefold
>   [19:10:24] [not run]
> generic/999 -- overlayfs does not support casefold enabled layers
> Ran: generic/999
> Not run: generic/999
> Passed all 1 tests
> 

This is how the test output looks before my changes[1] to the test:

$ ./run.sh
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP 
PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
MKFS_OPTIONS  -- -F /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2

generic/999 1s ... [not run] overlayfs does not support casefold enabled 
layers
Ran: generic/999
Not run: generic/999
Passed all 1 tests


And this is how it looks after my changes[1] to the test:

$ ./run.sh
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP 
PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
MKFS_OPTIONS  -- -F /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2

generic/999        1s
Ran: generic/999
Passed all 1 tests

So, as far as I can tell, the casefold enabled is not being skipped 
after the fix to the test.

[1] 
https://lore.kernel.org/lkml/5da6b0f4-2730-4783-9c57-c46c2d13e848@igalia.com/


> I'm not sure I will keep the test this way. This is not very standard nor
> good practice, to run half of the test and then skip it.
> I would probably split it into two tests.
> The first one as it is now will run to completion on kenrels >= v6.17
> and the Casefold enable test will run on kernels >= v6.18.
> 
> In any case, please make sure that the test is not skipped when testing
> Casefold enabled layers
> 
> And then continue with the missing test cases.
> 
> When you have a test that passes please send the test itself or
> a fstest branch for me to test.

Ok!

> 
> Thanks,
> Amir.


