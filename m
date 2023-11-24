Return-Path: <linux-fsdevel+bounces-3678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F847F7796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DDB282130
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE332E85A;
	Fri, 24 Nov 2023 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="h0ksV85m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874CC1;
	Fri, 24 Nov 2023 07:22:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE7E01BF20A;
	Fri, 24 Nov 2023 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1700839372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFFFOKyC6p1FOoorSMK24kJ5FMkPhQFR5RZw96Asog4=;
	b=h0ksV85mHyER9weo51zXH0+I93eoVv8zic3Pep0xMnyIbVAGPMf8AlKmlRLpNMJzFlrcrF
	RK0X2S9Oz2IAHSAQCVXQ9hdbbZCYgc9SYGyi7hLfEI8vXnWzjKzIfH1TjNvxCLuXogY37N
	KwsOh/9JwZqXgCZyxj1OMJMvZKF26j9D/Hj0noHzPFe1ytsYN9uLegU6C5eyEQIgjoMwEq
	tPBGRtY3VNzX2iz2xKh9bN26J8RiSsv491w/JQGDrqq21jf/9t1eRNOnN/wZAWT2odpy33
	6DvZwXZehQsTnLH6w8fWvtm0VMdJQtwecNRgazkr0EH2pZMYGADavZ1C6sBIZA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>,
  tytso@mit.edu,  linux-f2fs-devel@lists.sourceforge.net,
  ebiggers@kernel.org,  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
In-Reply-To: <20231123215234.GQ38156@ZenIV> (Al Viro's message of "Thu, 23 Nov
	2023 21:52:34 +0000")
References: <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
	<655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
	<20231120-nihilismus-verehren-f2b932b799e0@brauner>
	<CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
	<20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
	<CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
	<20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
	<20231123215234.GQ38156@ZenIV>
Date: Fri, 24 Nov 2023 10:22:49 -0500
Message-ID: <87leangoqe.fsf@>
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
>> >
>> > 4. d_move() and d_exchange() would ignore the value returned by __d_move();
>> > __d_unalias() turn
>> >         __d_move(alias, dentry, false);
>> > 	ret = 0;
>> > into
>> > 	ret = __d_move(alias, dentry, Splice);
>> > d_splice_alias() turn
>> > 				__d_move(new, dentry, false);
>> > 				write_sequnlock(&rename_lock);
>> > into
>> > 				err = __d_move(new, dentry, Splice);
>> > 				write_sequnlock(&rename_lock);
>> > 				if (unlikely(err)) {
>> > 					dput(new);
>> > 					new = ERR_PTR(err);
>> > 				}
>> > (actually, dput()-on-error part would be common to all 3 branches
>> > in there, so it would probably get pulled out of that if-else if-else).
>> >
>> > I can cook a patch doing that (and convert the obvious beneficiaries already
>> > in the tree to it) and throw it into dcache branch - just need to massage
>> > the series in there for repost...
>> 
>> if you can write that, I'll definitely appreciate it. It will surely
>> take me much longer to figure it out myself.
>
> Speaking of other stuff in the series - passing the expected name to
> ->d_revalidate() is definitely the right thing to do, for a lot of
> other reasons.  We do have ->d_name UAF issues in ->d_revalidate()
> instances, and that allows to solve them nicely.
>
> It's self-contained (your 2/9 and 3/9), so I'm going to grab that
> into a never-rebased branch, just to be able to base the followups
> propagating the use of stable name into instances.

ack. I'll base the other changes we discussed on top of your branch.

thanks,

-- 
Gabriel Krisman Bertazi

