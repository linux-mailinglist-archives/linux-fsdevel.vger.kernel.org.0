Return-Path: <linux-fsdevel+bounces-57813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1DEB257C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 01:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C8F3B1FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 23:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E02FB973;
	Wed, 13 Aug 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="SbagBhM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6712F60A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128998; cv=none; b=k3O9g5CqBzXJa16Fwiq12jQufSdvwOOeLtGXqYz+NVWnBMh1aqNHT6xbMKsUssw5cSCOXZ4j1lF4dytptCAM07YROBnQBggbnreEa0sbSqk46TvAwmrIkai96SCSlg2/n/vz8KqUFJJp9JHJt1jjMapcN5u0m3N/sSgP9UM7fVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128998; c=relaxed/simple;
	bh=u1zVyD7rzcExKdgOxK0dG1FH/LUnC/ES8o4VdVTMDko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Onh8jX2p+OwxHhNlaXXkPNZzdeNGO4f9/nGjJrx+mp4e/e+f4sjJeE5gfcdSdrVuydiwA0M2v14D3nJxEMw8PK8ByNneiurkFa8urjsSi3uzaBBgfaNR1fVfmuuvONNpf9NaDu5pK/rBwADIb5OoG5jO9AmRm/yiEwDsKzZ6geE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=SbagBhM3; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CEA1D240105
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 01:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1755128993;
	bh=1YxUkmq6FN6LQgr3UahX2gKJFk0JaYwHgo29qh2xlSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=SbagBhM3kXvT29iByWoxEuqWFCMAKNBiTzGo4JtaaxPjssKi1zBnEiu/SMlQVlw+q
	 9bd5bu3S6OrehMwtzFOmAQ4vliXqSHdMhm2JcrbuaOKDmJs9SveP+d4AEXAGHsHx0h
	 JmhVb4kwULEODhYaVO1KVMZdxBXpIWsKCE2NXgPZOPGGPvR/wQzaleK0QqhjpH69rl
	 DiWyGTOwaedm6O9SnsbXgEUi6JpFw/uHzo+2vLOBnSgKPmOSju7X+xyq6AlnXxZ06B
	 8oa+Ysgyt2sD7E3zJMR1QIsIf7pGfVZNiwmgrltznzYfmjlLIGnUttDPgu90bX+w0s
	 tZGq/JYm9XoeemZcDc9FRkjhqcLVMY8sUiDpdzefwIC2xAcZ/gUelWNtMHBULTOSr5
	 4yAXYHwM9Prq2jkvLDQ8+TFNsn9/P2bkzlhXxxBiOPgmmfqy4XrR9WlofKY/yIzkbf
	 bzeaCgqR/rBS74iP2NTGQSkju2ngnSGe1XcVnookAqpN6KNxV1R
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4c2Q8c17Wgz6tsf;
	Thu, 14 Aug 2025 01:49:52 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Christian Brauner <brauner@kernel.org>,  Eric Sandeen
 <sandeen@redhat.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  Danilo Krummrich
 <dakr@kernel.org>,  David Howells <dhowells@redhat.com>,
  linux-kernel@vger.kernel.org,  linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: fix mount options not being applied
In-Reply-To: <495848ab-2493-4701-b514-415377fe877b@sandeen.net>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
	<a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
	<d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
	<8734a53cpx.fsf@posteo.net>
	<cf97c467-6391-44df-8ce3-570f533623b8@sandeen.net>
	<20250808-aufrechnung-geizig-a99993c8e8f4@brauner>
	<495848ab-2493-4701-b514-415377fe877b@sandeen.net>
Date: Wed, 13 Aug 2025 23:49:53 +0000
Message-ID: <87plcyixy9.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@sandeen.net> writes:

> On 8/8/25 9:13 AM, Christian Brauner wrote:
>> On Wed, Aug 06, 2025 at 11:33:11AM -0500, Eric Sandeen wrote:
>>> On 8/5/25 12:22 PM, Charalampos Mitrodimas wrote:
>
> ...
>
>>>> Hi, thanks for the review, and yes you're right.
>>>>
>>>> Maybe a potential systemic fix would be to make get_tree_single() always
>>>> call fc->ops->reconfigure() after vfs_get_super() when reusing an
>>>> existing superblock, fixing all affected filesystems at once.
>>>
>>> Yep, I'm looking into that. mount_single used to do this, and IIRC we discussed
>>> it before but for some reason opted not to. It seems a bit trickier than I first
>>> expected, but I might just be dense. ;)
>> 
>> If we can make it work generically, we should. I too don't remember what
>> the reasons were for not doing it that way.
>
> Sorry for the long delay here. Talked to dhowells about this and his
> POV (which is convincing, I think) is that even though mount_single used to
> call do_remount_sb for an extant single sb, this was probably Bad(tm).
> Bad, IIUC, because it's not a given that options are safe to be changed
> in this way, and that policy really should be up to each individual
> filesystem.
>
> So while we still need to audit and fix any get_tree_single()
> filesystems that changed behavior with the new mount api, may as well
> fix up debugfs for now since the bug was reported.

What if we add a new flag (.fs_flags), say FS_SINGLE_RECONF, to
file_system_type that makes get_tree_single() automatically call
reconfigure() when reusing an existing superblock? Filesystems could
then just opt-in by adding it to .fs_flags.

>
> Charalampos - 
>
> Your patch oopses on boot for me - I think that when you added
>
> 	sb->s_fs_info = fc->s_fs_info;

Yes, did take notice of this yesterday when I revisited it.

>
> in debugfs_fill_super, you're actually NULLing out the one in the sb,
> because sget_fc has already transferred fc->s_fs_info to sb->s_fs_info,
> and NULLed fc->s_fs_info prior to this. Then when we get to
> _debugfs_apply_options, *fsi = sb->s_fs_info; is also NULL so using it
> there oopses.
>
> If you want to send a V2 with fixed up stable cc: I'd suggest following the
> pattern of what was done for tracefs in e4d32142d1de, which I think works
> OK and would at least lend some consistency, as the code is similar.
>
> If not, let me know and I'll work on an update.

As a matter of fact, I have a v2 exactly like this ready to sent. Doing
so in a bit.

>
> Thanks,
> -Eric 

Thanks!
C. Mitrodimas

