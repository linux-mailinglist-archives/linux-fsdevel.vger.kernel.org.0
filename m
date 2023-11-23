Return-Path: <linux-fsdevel+bounces-3554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D549C7F6596
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 18:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133851C21020
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7E405F8;
	Thu, 23 Nov 2023 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="TR6RKpJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55014189;
	Thu, 23 Nov 2023 09:37:47 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D88FDFF809;
	Thu, 23 Nov 2023 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1700761066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aE8aUEa9aAZvs4jBkIx+0j52NfPIGVPGiVlPWv3lCf4=;
	b=TR6RKpJtGtwhTO/9QTjmH69srCGp1iqc+0yDO4y3r5dOxuneAh0a64obgAT3tKkJii1V2o
	u18GtIPMuhkXOfnrnZAEDioqxM4aCdy6SQyNRebdb4qeHVoWor1NEr6F4a6KEmXGuNOYuh
	deAnY5WhiI1kOeQNvOXOgghf9uzP0jKheNnfN0AdF2UhfFonstsYq1wkWiIl9tpyIL6rRc
	/wMCdUJehUSjH+ojEHcOtmDnkLkphUcJwxs+e9YAtaEz7/FKyHPPCC6qP/DPPf8TCiBZI2
	3XZ1rh085NeBrVCikkNnXV3jXGxGI6JJikPo/4NaPc70hhLkmJpV/NdJAVHrkw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>,
  tytso@mit.edu,  linux-f2fs-devel@lists.sourceforge.net,
  ebiggers@kernel.org,  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
In-Reply-To: <20231123171255.GN38156@ZenIV> (Al Viro's message of "Thu, 23 Nov
	2023 17:12:55 +0000")
References: <20230816050803.15660-1-krisman@suse.de>
	<20231025-selektiert-leibarzt-5d0070d85d93@brauner>
	<655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
	<20231120-nihilismus-verehren-f2b932b799e0@brauner>
	<CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
	<20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
	<CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
	<20231123171255.GN38156@ZenIV>
Date: Thu, 23 Nov 2023 12:37:43 -0500
Message-ID: <87h6lcid5k.fsf@>
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

> On Thu, Nov 23, 2023 at 10:57:22AM -0500, Gabriel Krisman Bertazi wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > Side note: Gabriel, as things are now, instead of that
>> >
>> >         if (!d_is_casefolded_name(dentry))
>> >                 return 0;
>> >
>> > in generic_ci_d_revalidate(), I would suggest that any time a
>> > directory is turned into a case-folded one, you'd just walk all the
>> > dentries for that directory and invalidate negative ones at that
>> > point. Or was there some reason I missed that made it a good idea to
>> > do it at run-time after-the-fact?
>> >
>> 
>> The problem I found with that approach, which I originally tried, was
>> preventing concurrent lookups from racing with the invalidation and
>> creating more 'case-sensitive' negative dentries.  Did I miss a way to
>> synchronize with concurrent lookups of the children of the dentry?  We
>> can trivially ensure the dentry doesn't have positive children by
>> holding the parent lock, but that doesn't protect from concurrent
>> lookups creating negative dentries, as far as I understand.
>
> AFAICS, there is a problem with dentries that never came through
> ->lookup().  Unless I'm completely misreading your code, your
> generic_ci_d_revalidate() is not called for them.  Ever.
>
> Hash lookups are controlled by ->d_op of parent; that's where ->d_hash()
> and ->d_compare() come from.  Revalidate comes from *child*.  You need
> ->d_op->d_revalidate of child dentry to be set to your generic_ci_d_revalidate().
>
> The place where it gets set is generic_set_encrypted_ci_d_ops().  Look
> at its callchain; in case of ext4 it gets called from ext4_lookup_dentry(),
> which is called from ext4_lookup().  And dentry passed to it is the
> argument of ->lookup().
>
> Now take a look at open-by-fhandle stuff; all methods in there
> (->fh_to_dentry(), ->fh_to_parent(), ->get_parent()) end up
> returning d_obtain_alias(some inode).
>
> We *do* call ->lookup(), all right - in reconnect_one(), while
> trying to connect those suckers with the main tree.  But the way
> it works is that d_splice_alias() in ext4_lookup() moves the
> existing alias for subdirectory, connecting it to the parent.
> That's not the dentry ext4_lookup() had set ->d_op on - that's
> the dentry that came from d_obtain_alias().  And those do not
> have ->d_op set by anything in your tree.
>
> That's the problem I'd been talking about - there is a class of situations
> where the work done by ext4_lookup() to set the state of dentry gets
> completely lost.  After lookup you do have a dentry in the right place,
> with the right name and inode, etc., but with NULL
> ->d_op->d_revalidate.

I get the problem now. I admit to not understanding all the details yet,
which is why I haven't answered directly, but I understand already how
it can get borked.  I'm studying your explanation.

Originally, ->d_op could be propagated trivially since we had sb->s_d_op
set, which would be set by __d_alloc, but that is no longer the case
since we combined fscrypt and CI support.

What I still don't understand is why we shouldn't fixup ->d_op when
calling d_obtain_alias (before __d_instantiate_anon) and you say we
better do it in d_splice_alias.  The ->d_op is going to be the same
across the filesystem when the casefold feature is enabled, regardless
if the directory is casefolded.  If we set it there, the alias already
has the right d_op from the start.

-- 
Gabriel Krisman Bertazi

