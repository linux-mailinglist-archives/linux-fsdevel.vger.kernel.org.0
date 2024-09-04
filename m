Return-Path: <linux-fsdevel+bounces-28660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9692996CA72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 00:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE21F2310B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D6317C9AA;
	Wed,  4 Sep 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jafjgz/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20F17B4E5;
	Wed,  4 Sep 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488925; cv=none; b=IqlW4oXwlkkFyo7seq2PuhehMuY7lCdo8uYrSFYTo5bi7egHKvT3Is6SKXFdbap5+iNVXRVKkOrLcIjIlfv6Di2dMLLNtjAM3051yQW8C+CWlnPWtzcdnNzKY8OBvHdi82V3wji3EUyr+bSJU9IddszezmOCIglsCrKP6pZ5lH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488925; c=relaxed/simple;
	bh=rkuS0CNBwRkRGF+lfyerI7rntJEW3arkWBmA4TUMIcg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cLgPdCooNlP13AJYZ3QwvNo8JSt2ZZKVEL1G97vvoNxUpVbM8R/cigJot2k5K3kzyvlo6x18ypFQhSt82GG3jrxp5iKd4OzqIsjyvDSBme/PIXSFPA6Zd8vjf1pwERfn/n70YS4MGOSMPeY3f4TyDXBD4Eb7WCjkvEtsgP9eDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jafjgz/d; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KSjAivHlg5cFDajG1oCwI0Dhjh9+yTX2k4XmuHn6kME=; b=jafjgz/dLo82epmN2dJPeOiiG2
	S9q6xwR+XDVUJAQoJ87qvKHMUjIEm5BDmnQc/YkzJP9/UK7FEH7EpbsI7i/Og36lPlL8x9VVC5PoZ
	25Jp+BBDYwTkkip9tOAov17p3TmijF66rH0kipfw/1ioGR0MD7xCCSx2kHHXdbtsURt4kv8ZO5q02
	KiyI+RVd0BDewsoyhHsErN99jwRwB1KhLaIb7+M2NEHeHZT5pOWf7dpt5RQMpjS47SFS1QelI0W1V
	dpJy4avtnYK2KJSuWt4oO/5Iyvruh7XOuLbn+F+MabcxJ1wGjjBZ1KdjSUt5zigJaE7FzF+QS6r2r
	EaG/x3WA==;
Received: from [177.172.122.98] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1slyUB-009gve-2F; Thu, 05 Sep 2024 00:28:22 +0200
Message-ID: <500ff1ba-d8db-4f4d-9084-6d59401992da@igalia.com>
Date: Wed, 4 Sep 2024 19:28:16 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: Re: [PATCH v2 6/8] tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs
 dirs
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 krisman@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
 Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
 Christoph Hellwig <hch@lst.de>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
 <20240902225511.757831-7-andrealmeid@igalia.com>
 <87jzfshfwn.fsf@mailhost.krisman.be>
Content-Language: en-US
In-Reply-To: <87jzfshfwn.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krisman,

Thanks for the feedback!

Em 03/09/2024 13:15, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@igalia.com> writes:
> 
>> Enable setting flag FS_CASEFOLD_FL for tmpfs directories, when tmpfs is
>> mounted with casefold support. A special check is need for this flag,
>> since it can't be set for non-empty directories.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>

[...]

>> +
>> +	if (fsflags & FS_CASEFOLD_FL) {
>> +		if (!sb->s_encoding)
>> +			return -EOPNOTSUPP;
>> +
>> +		if (!S_ISDIR(inode->i_mode))
>> +			return -ENOTDIR;
>> +
>> +		if (dentry && !simple_empty(dentry))
>> +			return -ENOTEMPTY;
>> +
>> +		i_flags |= S_CASEFOLD;
>> +	} else if (old & S_CASEFOLD) {
>> +		if (dentry && !simple_empty(dentry))
>> +			return -ENOTEMPTY;
> 
> We don't want to fail if a directory already has the S_CASEFOLD
> flag and we are not flipping it in the current operation.  Something like:
> 
> if ((fsflags ^ old) & S_CASEFOLD) {
> 	if (!sb->s_encoding)
> 		return -EOPNOTSUPP;
> 
> 	if (!S_ISDIR(inode->i_mode))
> 		return -ENOTDIR;
> 
> 	if (dentry && !simple_empty(dentry))
> 		return -ENOTEMPTY;
>          i_flags |= fsflags & S_CASEFOLD;
> }
> 

You are right, it's broken and failing for directories with S_CASEFOLD. 
Here's a small test showing that we can't add the +d attribute to a 
non-empty CI folder (+d doesn't require the directory to be empty):

folder ) mkdir A
folder ) mkdir A/B
folder ) chattr +d A/B
folder ) chattr +d A
chattr: Directory not empty while setting flags on A

However, FS_CASEFOLD_FL != S_CASEFOLD and the set of values for 
inode->i_flags (var old) and fsflags aren't the same, so your proposed 
snippet didn't work. I see that ext4 has a very similar code as your 
proposal, but I think they do something different with the flag values.

I rewrote my code separating the three possible paths and it worked:

/* inheritance from parent dir/keeping the same flags path */
if ((fsflags & FS_CASEFOLD_FL) && (old & S_CASEFOLD))
	i_flags |= S_CASEFOLD;

/* removing flag path */
if (!(fsflags & FS_CASEFOLD_FL) && (old & S_CASEFOLD))
	if (dentry && !simple_empty(dentry))
		return -ENOTEMPTY;

/* adding flag path */
if ((fsflags & FS_CASEFOLD_FL) && !(old & S_CASEFOLD)) {
	if (!sb->s_encoding)
		return -EOPNOTSUPP;

	if (!S_ISDIR(inode->i_mode))
		return -ENOTDIR;

	if (dentry && !simple_empty(dentry))
		return -ENOTEMPTY;

	i_flags |= S_CASEFOLD;
}

In that way, the `chattr +d` call doesn't fall into the simple_empty() 
check. I simplified the code like this for the v3:

if (fsflags & FS_CASEFOLD_FL) {
	if (!(old & S_CASEFOLD)) {
		if (!sb->s_encoding)
			return -EOPNOTSUPP;

		if (!S_ISDIR(inode->i_mode))
			return -ENOTDIR;

		if (dentry && !simple_empty(dentry))
			return -ENOTEMPTY;
	}

	i_flags |= S_CASEFOLD;
} else if (old & S_CASEFOLD) {
	if (dentry && !simple_empty(dentry))
		return -ENOTEMPTY;
}

