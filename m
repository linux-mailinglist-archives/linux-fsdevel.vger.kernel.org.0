Return-Path: <linux-fsdevel+bounces-56786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DD5B1B94E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 19:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09F53BB87B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273D529B228;
	Tue,  5 Aug 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="GnWGsNCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AEE295513
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414570; cv=none; b=Qu4SLvDCSG3XA/h4GHKqeiKzt7HmriokhOVEO5pFjBSLR/IrOpO8PpGAMtN/4yF9FFc4KOnMWxhBS2aYWc15iTSGwIaDbjx6p6V1w+l2VEjV1a7LuE9TaWU5FKg7N8XTn7KTYBtfY+Sa9gvKq6zWzkqDmYKWUGmHiNVSrG2/tMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414570; c=relaxed/simple;
	bh=LmJb19fOz41y2LEg95uPnPie+raZj97H0roGSclEMhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TeJWKGQF3XgOBPK/Y7rPYPPeJT7ITqjUED2z1GQ6QOMIXO7ZCj65waTDP6cq1mjMAMDhc66VnHoOaJ4dFC+LUtUg2UQBWZmE/U3IJ2lAS6CaaQkOD6HJCDKFyFkzMcZu0RONWv4TmNN7UwiX/kV9NYtynF+SemO5xfxyxzDm19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=GnWGsNCz; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C96CE240103
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 19:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1754414560;
	bh=VZGauJZHhdszoNpJSpB1JM3ZkaSjNqOByQ1QzJOLb8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=GnWGsNCz77EiemnVgjeyKKF+WAcoqSURIxD0JXe5i57NwJlCQ1ytMppZ7VTm8chRf
	 0eFeiHsSj/6H9XwIsnx0Af+tsJXb9dqogePRowMZrkybEwF+VaXhAr3nvJKM9QLw2t
	 nR0njpsQeOg556N8FFK0J2n/b9cUwqIGSuPcO5AcFBb3d4hpgQuEOGEV/EwOOCBtAa
	 sZEx0w+eXvB+UJaf1655IoXwBQh+UpDeNdKjkOq8YMY9uXftuSzyHKdo9YCU03wnt9
	 wgDl82HeilfGF6XQM47ybhyTgosAC+RwEz0FUugit6jPlBntGD43xdEJjFif81NTd0
	 Zdmmee+Y0BvzfKIlh+Nqv58gl8s82DsO+j29x0V7PiesvLqu/uwQDM1oDLq8PsuEtC
	 ifBzI0ojomwSoWTh/hm8qKS7ng9rZ6cCpxf3cqxT+fAChKaAf8j6gGVN7DWo5zNb7T
	 F/Ji2ct47Q3waxsnKGPgIzsez+krtcZ3XAu9JfTudEeaUPpT/PH
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bxKxW1fsyz6v0V;
	Tue,  5 Aug 2025 19:22:39 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Christian
 Brauner <brauner@kernel.org>,  David Howells <dhowells@redhat.com>,
  linux-kernel@vger.kernel.org,  linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: fix mount options not being applied
In-Reply-To: <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
	<a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
	<d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
Date: Tue, 05 Aug 2025 17:22:40 +0000
Message-ID: <8734a53cpx.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@redhat.com> writes:

> On 8/4/25 12:22 PM, Eric Sandeen wrote:
>> On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
>>> Mount options (uid, gid, mode) are silently ignored when debugfs is
>>> mounted. This is a regression introduced during the conversion to the
>>> new mount API.
>>>
>>> When the mount API conversion was done, the line that sets
>>> sb->s_fs_info to the parsed options was removed. This causes
>>> debugfs_apply_options() to operate on a NULL pointer.
>>>
>>> As an example, with the bug the "mode" mount option is ignored:
>>>
>>>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>>>   $ mount | grep debugfs_test
>>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>>>   $ ls -ld /tmp/debugfs_test
>>>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
>> 
>> Argh. So, this looks a lot like the issue that got fixed for tracefs in:
>> 
>> e4d32142d1de tracing: Fix tracefs mount options
>> 
>> Let me look at this; tracefs & debugfs are quite similar, so perhaps
>> keeping the fix consistent would make sense as well but I'll dig
>> into it a bit more.
>
> So, yes - a fix following the pattern of e4d32142d1de does seem to resolve
> this issue.
>
> However, I think we might be playing whack-a-mole here (fixing one fs at a time,
> when the problem is systemic) among filesystems that use get_tree_single()
> and have configurable options. For example, pstore:
>
> # umount /sys/fs/pstore 
>
> # mount -t pstore -o kmsg_bytes=65536 none /sys/fs/pstore
> # mount | grep pstore
> none on /sys/fs/pstore type pstore (rw,relatime,seclabel)
>
> # mount -o remount,kmsg_bytes=65536 /sys/fs/pstore
> # mount | grep pstore
> none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=65536)
> #
>
> I think gadgetfs most likely has the same problem but I'm not yet sure
> how to test that.
>
> I have no real objection to merging your patch, though I like the
> consistency of following e4d32142d1de a bit more. But I think we should
> find a graceful solution so that any filesystem using get_tree_single
> can avoid this pitfall, if possible.

Hi, thanks for the review, and yes you're right.

Maybe a potential systemic fix would be to make get_tree_single() always
call fc->ops->reconfigure() after vfs_get_super() when reusing an
existing superblock, fixing all affected filesystems at once.

>
> -Eric

