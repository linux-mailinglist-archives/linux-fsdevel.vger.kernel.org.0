Return-Path: <linux-fsdevel+bounces-32151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19869A1580
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 00:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762C62823B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7BE1D358B;
	Wed, 16 Oct 2024 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S1ID1XUI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF714EC47;
	Wed, 16 Oct 2024 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116049; cv=none; b=agPyRkpQbnh0f1hAxfIHtf9H78j8Z9WRb1o/bwssx6FF+3J8kskBToJSQVC9fY45CrklGUK0eUf7LBk3QnJXHLu9n1RoWZB/uXIC17sevlsR93V3fdMvPU50T3qo6LqK04ESu6YrArLFSl2CjvC3JLqAi6dUr/wnBiEP7T8OZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116049; c=relaxed/simple;
	bh=xwyCusH+SopIhC3oIPu4xYN2h6QDfJpgc3rvG/upU7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5FkFkMjGspcrQxn7LOSkfy33yJK1y9rUMPp51X88NmY5Y+uFkNU4PrBmTdBftWcunZqfeo/SdteqNQ2uNn31pk+zKr4UgGAphlQDgwe9j4h9n90oP5bIAtGyUOT9+MB5ec8lo//eTBlhp8rD0JGnyOyz8wUyvQwHj/x5cgl7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S1ID1XUI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x/5rC1xxa1L+8foNZ96vhDMYxXts5+xHlK0v36f7pTo=; b=S1ID1XUIpYRZxd95Lq9A6uoH8N
	8IDRXXr9OBR+TBeJNazOHCmmP5yAu522EddTdoOekBTXwTX2aevD5aLUmdKdWVJoMkKh+2DTIoKpf
	LysiBhB2jRJ9QwoPxRLuzpLqzgtWVCc2Y8RbvQG6xyoqxop0a1bVBNsxJcbnBX+SXcVxsxCfWqXrO
	EOYKiVsqLkjIjklOuESs1Z9eiT3EXkWPuV8ElRSgBnkHybZgeJfzynqdaR1HcAM4AhQOCHD3iHZev
	2f2L/IeQaBmoRao4h1dyPp4+y1OmWMAkajPsx/R+Anp4vFiLV3FzJhd+wL/cinLl3DwsT2vskX+vu
	4XLAwGVg==;
Received: from [179.118.186.49] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t1C3r-00BMoD-HR; Thu, 17 Oct 2024 00:00:07 +0200
Message-ID: <a26db27a-85ca-46e4-9669-d885db2dd4ae@igalia.com>
Date: Wed, 16 Oct 2024 18:59:58 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/10] libfs: Create the helper function
 generic_ci_validate_strict_name()
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com, kernel-dev@igalia.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
 <20241010-tonyk-tmpfs-v6-1-79f0ae02e4c8@igalia.com>
 <87bjzls6ff.fsf@mailhost.krisman.be>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87bjzls6ff.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 15/10/2024 12:59, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@igalia.com> writes:
> 
>> +static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
>> +{
>> +	if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb))
>> +		return true;
>> +
>> +	/*
>> +	 * A casefold dir must have a encoding set, unless the filesystem
>> +	 * is corrupted
>> +	 */
>> +	if (WARN_ON_ONCE(!dir->i_sb->s_encoding))
>> +		return true;
>> +
>> +	return utf8_validate(dir->i_sb->s_encoding, name);
> 
> There is something fishy here.  Concerningly, the fstests test doesn't
> catch it.
> 
> utf8_validate is defined as:
> 
>    int utf8_validate(const struct unicode_map *um, const struct qstr *str)
> 
> Which returns 0 on success and !0 on error. Thus, when casting to bool,
> the return code should be negated.
> 
> But generic/556 doesn't fail. That's because we are over cautious, and
> also check the string at the end of generic_ci_d_hash.  So we never
> really reach utf8_validate in the tested case.
> 
> But if you comment the final if in generic_ci_d_hash, you'll see this
> patchset regresses the fstests case generic/556 over ext4.
> 
> We really need the check in both places, though.  We don't want to rely
> on the behavior of generic_ci_d_hash to block invalid filenames, as that
> might change.
> 

Thanks Krisman! Nice catch. I fixed this for the next version. Testing 
with the modified generic_ci_d_hash(), I also realized that the 
validation was in the wrong place and leaving an inode behind, this fixed:

diff --git a/mm/shmem.c b/mm/shmem.c
index eb1ea1f3b37c..7bd7ca5777af 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3624,13 +3624,13 @@ shmem_mknod(struct mnt_idmap *idmap, struct 
inode *dir,
         struct inode *inode;
         int error;

+       if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
+               return -EINVAL;
+
         inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, 
VM_NORESERVE);
         if (IS_ERR(inode))
                 return PTR_ERR(inode);

-       if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
-               return -EINVAL;
-


