Return-Path: <linux-fsdevel+bounces-43073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED42DA4DA03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A24F171F71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4221FECAF;
	Tue,  4 Mar 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6fw6vFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE281FECA6
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083578; cv=none; b=rnC/13ayu+B8KRYFlyzHQpQJClvDU9VD41l5b3rfUpOK2laIXEBfH9hikSa45NFuBREdgYnXxTCrYUSeEgmvFmYkEezENo8eAcq/pfubQWw+zZZMlYp5UCG+VhYNDXIZEEyJWrxujJv9isefHF+OaTuBY04MnOuKir+RKDA5epk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083578; c=relaxed/simple;
	bh=gGyWOKdlVR5e/nJgCuYPWytlw/g/TKD0wb/gQM3eErs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt1/mulOiye/Olq5Dz8x2Mo86KeUPSa4FDZ0KyGKxTDgq5cshh/YLd15uiJxZyAf88KYtuEJKdg6dR/tutRVwNLSRguDw3Pbvwy2pKa2Gpc5koZ375t2/0gQHVuzswtx+A0YI75QCbwZ0ETILp5igh3uLM1fDh2KL1kSEDweol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6fw6vFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CDFC4CEE9;
	Tue,  4 Mar 2025 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741083577;
	bh=gGyWOKdlVR5e/nJgCuYPWytlw/g/TKD0wb/gQM3eErs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6fw6vFjmTlmaTGVWQv0TzAS/COHEUTpXRp57oZI7jQu50VDnWjApfB4WRwxZcNmf
	 LF1BuoaKcsPdKkZ8WHC0O1iSfW6v/6YXeT8chs3BOZxvLbpZOMijmJqc/FUDNgkl8i
	 Gcxkb+lWbbr1w90mf0iL0S2R3849AFKdtmywSb6NRQN9rQ3N6FwT4ZnpK0EXFQBMwx
	 6Rrfp5HtLEZhiMU9gzYkO70jfV0kWl8mbKVnku8p3WvukN0yFHYgQym4NpkggQandk
	 xMmR9i1ihld9eiLzeSH+hMm6WBCq1JjcPxrErQ1Yb3z7ZTH8GQejl5aPj0S+iqOzze
	 yLIBy4+iR4f1A==
Date: Tue, 4 Mar 2025 11:19:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Changing reference counting rules for inodes
Message-ID: <20250304-flexibel-glimmen-ccb3a5a71cc6@brauner>
References: <20250303170029.GA3964340@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303170029.GA3964340@perftesting>

On Mon, Mar 03, 2025 at 12:00:29PM -0500, Josef Bacik wrote:
> Hello,
> 
> I've recently gotten annoyed with the current reference counting rules that
> exist in the file system arena, specifically this pattern of having 0 referenced
> objects that indicate that they're ready to be reclaimed.
> 
> This pattern consistently bites us in the ass, is error prone, gives us a lot of
> complicated logic around when an object is actually allowed to be touched versus
> when it is not.
> 
> We do this everywhere, with inodes, dentries, and folios, but I specifically
> went to change inodes recently thinking it would be the easiest, and I've run
> into a few big questions.  Currently I've got about ~30 patches, and that is
> mostly just modifying the existing file systems for a new inode_operation.
> Before I devote more time to this silly path, I figured it'd be good to bring it
> up to the group to get some input on what possible better solutions there would
> be.
> 
> I'll try to make this as easy to follow as possible, but I spent a full day and
> a half writing code and thinking about this and it's kind of complicated.  I'll
> break this up into sections to try and make it easier to digest.
> 
> WHAT DO I WANT
> 
> I want to have refcount 0 == we're freeing the object.  This will give us clear
> "I'm using this object, thus I have a reference count on it" rules, and we can
> (hopefully) eliminate a lot of the complicated freeing logic (I_FREEING |
> I_WILL_FREE).

Yeah, I want to see I_FREEING and I_WILL_FREE stuff to go away. This bit
fiddling and waiting is terribly opaque for anyone who hasn't worked on
this since the dawn of time. So I'm all for it.

> 
> HOW DO I WANT TO DO THIS
> 
> Well obviously we keep a reference count always whenever we are using the inode,
> and we hold a reference when it is on a list.  This means the i_io_list holds a
> reference to the inode, that means the LRU list holds a reference to the inode.
> 
> This makes LRU handling easier, we just walk the objects and drop our reference
> to the object.  If it was truly the last reference then we free it, otherwise it
> will get added back onto the LRU list when the next guy does an iput().
> 
> POTENTIAL PROBLEM #1
> 
> Now we're actively checking to see if this inode is on the LRU list and
> potentially taking the lru list lock more often.  I don't think this will be the
> case, as we would check the inode flags before we take the lock, so we would
> martinally increase the lock contention on the LRU lock.  We could mitigate this
> by doing the LRU list add at lookup time, where we already have to grab some of
> these locks, but I don't want to get into premature optimization territory here.
> I'm just surfacing it as a potential problem.

Yes, ignore it for now.

So I agree that if we can try and remove the inode cache altogether that
would be pretty awesome and we know that we have support for attempting
that from Linus. But I'm not sure what regression potential that has.
There might just be enough implicit behavior that workloads depend on
that will bite us in the ass.

But I don't think you need to address this in this series. Your changes
might end up making it easier to experiemnt with the inode cache removal
though.

> POTENTIAL PROBLEM #2
> 
> We have a fair bit of logic in writeback around when we can just skip writeback,
> which amounts to we're currently doing the final truncate on an inode with
> ->i_nlink set.  This is kind of a big problem actually, as we could no
> potentially end up with a large dirty inode that has an nlink of 0, and no
> current users, but would now be written back because it has a reference on it
> from writeback.  Before we could get into the iput() and clean everything up
> before writeback would occur.  Now writeback would occur, and then we'd clean up
> the inode.

So in the old pattern you'd call iput_final() and then do writeback.
Whereas in the new pattern you'd do writeback before iput_final().
And this is a problem because it potentially delays freeing of the inode
for a long time?

> 
> SOLUTION FOR POTENTIAL PROBLEM #1
> 
> I think we ignore this for now, get the patches written, do some benchmarking
> and see if this actually shows up in benchmarks.  If it does then we come up
> with strategies to resolve this at that point.
> 
> SOLUTION FOR POTENTIAL PROBLEM #2 <--- I would like input here
> 
> My initial thought was to just move the final unlink logic outside of evict, and
> create a new reference count that represents the actual use of the inode.  Then
> when the actual use went to 0 we would do the final unlink, de-coupling the
> cleanup of the on-disk inode (in the case of local file systems) from the
> freeing of the memory.

I really do like active/passive reference counts. I've used that pattern
for mount namespaces, seccomp filters and some other stuff quite
successfully. So I'm somewhat inclined to prefer that solution.

Imho, when active/reference patterns are needed or useful then it's
almost always because the original single reference counting mechanism
was semantically vague because it mixed two different meanings of the
reference count. So switching to an active/passive pattern will end up
clarifying things.

> This is a nice to have because the other thing that bites us occasionally is an
> iput() in a place where we don't necessarily want to be/is safe to do the final
> truncate on the inode.  This would allow us to do the final truncate at a time
> when it is safe to do so.
> 
> However this means adding a different reference count to the inode.  I started
> to do this work, but it runs into some ugliness around ->tmpfile and file
> systems that don't use the normal inode caching things (bcachefs, xfs).  I do
> like this solution, but I'm not sure if it's worth the complexity.
> 
> The other solution here is to just say screw it, we'll just always writeback
> dirty inodes, and if they were unlinked then they get unlinked like always.  I
> think this is also a fine solution, because generally speaking if you've got
> memory pressure on the system and the file is dirty and still open, you'll be
> writing it back normally anyway.  But I don't know how people feel about this.
> 
> CONCLUSION
> 
> I'd love some feedback on my potential problems and solutions, as well as any
> other problems people may see.  If we can get some discussion beforehand I can
> finish up these patches and get some testing in before LSFMMBPF and we can have
> a proper in-person discussion about the realities of the patchset.  Thanks,
> 
> Josef

