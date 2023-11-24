Return-Path: <linux-fsdevel+bounces-3677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF747F778B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED0BFB2139D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423892E82C;
	Fri, 24 Nov 2023 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="lhD5AU7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2425171D;
	Fri, 24 Nov 2023 07:20:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D8504000B;
	Fri, 24 Nov 2023 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1700839247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP9kE/qZ9mZ3UkVY03ruuvTkwENKgMzDkSDUS7WTkLg=;
	b=lhD5AU7Qe1kTAfOW+1UpIAHQWuMOQ6yr2r5z/v2J0mpDrMmvWJtWs0MeE8CJJa1Y0TMoHM
	b5UFHmUnbAzpLpnIAyoa8MAgUqvT1+8Is4wSqyx4tAlWm7KX4uo+UGOG57+QANq1yaXpf0
	hisz9KIiRxt6gPrJBkvO4QrG5mpxAsztruGoKDfiJDknG5+U3HbJmGPjp1y2N14v5j5E5v
	0q69wJjdvmPKRE7O5yrBnIbPsp+YdxElXEyr1g2THU26QnV88esgweZBouIGvQXmPxl+Pc
	OOHxu4SytSoxkXYopPAcXD6Mgvs7G/Q6KBtwqNh/DNvQo0WMM9en4B4dtAT30g==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>,
  tytso@mit.edu,  linux-f2fs-devel@lists.sourceforge.net,
  ebiggers@kernel.org,  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
In-Reply-To: <20231123195327.GP38156@ZenIV> (Al Viro's message of "Thu, 23 Nov
	2023 19:53:27 +0000")
References: <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
	<655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
	<20231120-nihilismus-verehren-f2b932b799e0@brauner>
	<CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
	<20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
	<CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
	<20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
	<20231123195327.GP38156@ZenIV>
Date: Fri, 24 Nov 2023 10:20:39 -0500
Message-ID: <87plzzgou0.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Thu, Nov 23, 2023 at 02:06:39PM -0500, Gabriel Krisman Bertazi wrote:
>
>> > A paragraph above you've said that it's not constant over the entire
>> > filesystem.
>> 
>> The same ->d_op is used by every dentry in the filesystem if the superblock
>> has the casefold bit enabled, regardless of whether a specific inode is
>> casefolded or not. See generic_set_encrypted_ci_d_ops in my tree. It is
>> called unconditionally by ext4_lookup and only checks the superblock:
>> 
>> void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
>> {
>>         if (dentry->d_sb->s_encoding) {
>> 		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
>> 		return;
>> 	}
>>         ...
>> 
>> What I meant was that this used to be set once at sb->s_d_op, and
>> propagated during dentry allocation.  Therefore, the propagation to the
>> alias would happen inside __d_alloc.  Once we enabled fscrypt and
>> casefold to work together, sb->s_d_op is NULL
>
> Why?  That's what I don't understand - if you really want it for
> all dentries on that filesystem, that's what ->s_d_op is for.
> If it is not, you have that problem, no matter which way you flip ->d_op
> value.

I'm not sure why it changed.  I'm guessing that, since it doesn't make
sense to set fscrypt_d_revalidate for every dentry in the
!case-insensitive case, they just kept the same behavior for
case-insensitive+fscrypt.  This is what I get from looking at the git
history.

I will get a new series reverting to use ->s_d_op, folding the
dentry_cmp behavior you mentioned, and based on what you merge in your
branch.

>> and we always set the same
>> handler for every dentry during lookup.
>
> Not every dentry goes through lookup - see upthread for details.

Yes, I got that already.  This should be "we always set the same handler
for every dentry that goes through lookup and bork whatever doesn't come
through lookup."

-- 
Gabriel Krisman Bertazi

