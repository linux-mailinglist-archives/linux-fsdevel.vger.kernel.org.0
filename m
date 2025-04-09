Return-Path: <linux-fsdevel+bounces-46120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6920FA82D26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031C51B80003
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FD270ECC;
	Wed,  9 Apr 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cNFZcIXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC926FDA4;
	Wed,  9 Apr 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218168; cv=none; b=r3ZaDZrXnDR9C7ZvXdMNr88u96fJXNjavwvqGBeZtblnx+/pbLITn2jKYt1yq80nMJdFOlqc+d9MMMLaSztzEtH+1uZ2y/GFDbOxOJuo+oGE4bhBkPpLe6rwlwMnXZtutqjBN7fitvWh52J+/jMcbWZSnIGSHIYkyntyT4QyCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218168; c=relaxed/simple;
	bh=OHvUhXtTCCbp0EONF6S3id69DHrK++gymSSJsARfsUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGXPB1dYHIrgvbB+/ejp6CWbPegr0V92kqA/g+zF2c2oWKTvobzsVEL7zdplX9a/0n0fRvGP17qVp/5DBpJYwWD8h/IBVIBmPPC6sZ6a7c5zBYTuD7iak6uLrpMipZGe0dXpok8algLWzEMvkvGNsPymb5Kn8cx+gX2MlvnrAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cNFZcIXV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jYHYsmST/s6mhdaoenm3YeJwWoT2gBbnRyd04iTSby8=; b=cNFZcIXVMBwNJbxH/8a8WS8IM4
	I6EyD+R8/PTWcrW0rGnoZAZKMA/JvLP5ShDx/SbHTlFMdr+gu9jziy3P4vzfR93SNhl4CnBFMYUJI
	9m+sxWzqzAXNQR9JIUdYOIOr2U4qPFd9wNsXeV/lmS9+CE7VxzV3Ig15ThN/9ZslWfGoQ4eSWtQXr
	gpuY3O1ZKhh5XQQzESpw5hlhhK+A1+t8Wg+FAcJm9eP3jHfENQFsyrEjWaXlYeF7u9UoBHFLiz2ob
	rp5s8gnHCPZtXAG91gcRIZQjCQNryXoE9GAlNuphCx1w7E8CaDjLRmt9ivc8YlM/FzL/4BxmLqK6u
	56AY5hQw==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u2Yov-00EEWh-I0; Wed, 09 Apr 2025 19:02:37 +0200
Message-ID: <dddab8dd-6d36-4899-ae8c-d284c4c0306c@igalia.com>
Date: Wed, 9 Apr 2025 14:02:32 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ovl: Enable support for casefold filesystems
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
 <871pu1b7l5.fsf@mailhost.krisman.be>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <871pu1b7l5.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gabriel!

Em 09/04/2025 13:52, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@igalia.com> writes:
> 
>> Hi all,
>>
>> We would like to support the usage of casefold filesystems with
>> overlayfs. This patchset do some of the work needed for that, but I'm
>> sure there are more places that need to be tweaked so please share your
>> feedback for this work.
> 
> I didn't look the patches yet, but this is going to be quite tricky.
> For a start, consider the semantics when mixing volumes with different
> case settings for lower/upper/work directories.  And that could be any
> setting, such as whether the directory has +F, the encoding version and
> the encoding flags (strict mode).  Any mismatch will look bonkers and
> you want to forbid the mount.
> 
> Consider upperdir is case-sensitive but lowerdir is not.  In this case,
> I suspect the case-exact name would be hidden by the upper, but the
> inexact-case would still resolve from the lower when it shouldn't, and
> can't be raised again.  If we have the other way around, the upper
> will hide more than one file from the lower and it is a matter of luck
> which file we are getting.
> 
> In addition, if we have a case-insensitive on top of a case-sensitive,
> there is no way we can do the case-insensitive lookup on the lower
> without doing a sequential search across the entire directory.  Then it
> is again a matter of luck which file we are getting.
> 
> The issue can appear even on the same volume, since case-insensitiveness
> is actually per-directory and can be flipped when a directory is empty.
> If something like the below is possible, we are in the same situation
> again:
> 
> mkdir lower/ci
> chattr +F lower/ci
> touch lower/ci/BLA
> mount -o overlay none upperdir=upper,lowerdir=lower,workdir=work merged
> rm -r merged/ci/BLA    // creates a whiteout in upper
>                         // merged looks empty and should be allowed to drop +F
> chattr -F merged/ci
> 
> So we'd also need to always forbid clearing the +F attribute and perhaps
> forbid it from ever being set on the merged directory.  We also want to
> require the encoding version and flags to match.
> 

Thank you for the prompt response. I agree with you, for the next 
version I will implement such restrictions. I think it will be better to 
start with very restrict possibilities and then slowly dropping then, if 
they prove to be not problematic.

>> * Implementation
>>
>> The most obvious place that required change was the strncmp() inside of
>> ovl_cache_entry_find(), that I managed to convert to use d_same_name(),
>> that will then call the generic_ci_d_compare function if it's set for
>> the dentry. There are more strncmp() around ovl, but I would rather hear
>> feedback about this approach first than already implementing this around
>> the code.
> 
> I'd suggest marking it as an RFC since it is not a functional
> implementation yet, IIUC.
> 

Ops, you are right, I forgot to tag it as such.

>>> * Testing
>> sudo mount -t tmpfs -o casefold tmpfs mnt/
>> cd mnt/
>> mkdir dir
>> chattr +F dir
>> cd dir/
>> mkdir upper lower
>> mkdir lower/A lower/b lower/c
>> mkdir upper/a upper/b upper/d
>> mkdir merged work
>> sudo mount -t overlay overlay -olowerdir=lower,upperdir=upper,workdir=work, merged
>> ls /tmp/mnt/dir/merged/
>> a  b  c  d
>>
>> And ovl is respecting the equivalent names. `a` points to a merged dir
>> between `A` and `a`, but giving that upperdir has a lowercase `a`, this
>> is the name displayed here.
> 
> Did you try fstests generic/556?  It might require some work to make it
> run over ovl, but it will exercise several cases that are quite
> hard to spot.
> 
> 

I haven't tried, I'm not sure which directory should I point to fstests 
to use for the test, the merged one?


