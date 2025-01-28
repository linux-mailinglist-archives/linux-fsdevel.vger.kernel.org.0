Return-Path: <linux-fsdevel+bounces-40246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1A4A21086
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 19:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281EF188341C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6A1DE889;
	Tue, 28 Jan 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JHf1gzxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DDE1C5F1D;
	Tue, 28 Jan 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087875; cv=none; b=Id2eEhbZBCskM81ldcSk95hBGtaPo8LZJBLHS70yIytiubiQfXU7SJvDcY79LiRFdpEyVLdMtvrADn/jdUSOAHzmaawuNzTExM5umG8kp7uCjCvPsDhVKIy/h4PGLXBeRzT0UQZgUNB3qS0VYHGec5ZlWfmQNKTMoKw70ruWV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087875; c=relaxed/simple;
	bh=wkev7egS7kp6JWAonVtAN1YQdZFEhTl6S0waZCYIo/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENsXcl0dFNQQRa1XdcJIGGN0ktOaqden1rxctdGMBzvAUAlyrnF6mSqFkjjjc8j3fZFITY8HG9kXWSysnF0JxamEvhzmZ5aim6aBvBdmjk146cURl1nFyW5r3XU0NV2fxSeOlKXYKIPPB7v0Kd8i9TSjQYKDqL+rt+z0sZrQSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JHf1gzxm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 568862037175;
	Tue, 28 Jan 2025 10:11:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 568862037175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738087873;
	bh=SQG+2pT80CTArfkB8iOnQFuePfZpq5596HdRBdP/6dY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JHf1gzxm4v2Wu5xI4HmnWnBbUiydERz1sakq86P0O03Tz7pl5jvc8gSRZ0yJ60ZxH
	 5abHUpB2LfR3QOjAC2YxTbl4vm0QrCUOG0Ec9PAKnudyMZIVNYuiaSZiY7221xslV/
	 tKZIz+an2PUwKl6GSaW2jFSluch4LM0dYNTexOQY=
Message-ID: <e530f146-6412-4287-85ad-9e459f462797@linux.microsoft.com>
Date: Tue, 28 Jan 2025 13:11:11 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] fanotify: notify on mount attach and detach
To: Paul Moore <paul@paul-moore.com>, Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Karel Zak <kzak@redhat.com>, Lennart Poettering <lennart@poettering.net>,
 Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 selinux-refpolicy@vger.kernel.org
References: <20250123194108.1025273-1-mszeredi@redhat.com>
 <20250123194108.1025273-3-mszeredi@redhat.com>
 <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> If I understand the commit description correctly,
> security_path_notify(path, mask, FSNOTIFY_OBJ_TYPE_MNTNS) indicates a
> change in the mount namespace indicated by the @path parameter, with
> the initial mntns changes being limited to attach/detach and possibly
> some other attributes (see patch 4/4), although the latter looks like
> it will probably happen at a later date.
> 
> My initial thinking is that if we limit ourselves to existing SELinux
> policy permissions, this is much more of FILE__WATCH_MOUNT operation
> rather than a FILE__WATCH operation as while the /proc/PID/ns/mnt file
> specified in @path is simply a file, it represents much more than
> that.  However, it we want to consider adding a new SELinux policy
> permission (which is easy to do), we may want to consider adding a new
> mount namespace specific permission, e.g. FILE__WATCH_MOUNTNS, this
> would make it easier for policy developers to distinguish between
> watching a traditional mount point and a mount namespace (although
> given the common approaches to labeling this may not be very
> significant).  I'd personally like to hear from the SELinux policy
> folks on this (the SELinux reference policy has also been CC'd).
> 
> If we reuse the file/watch_mount permission the policy rule would look
> something like below where <subject> is the SELinux domain of the
> process making the change, and <mntns_label> is the label of the
> /proc/PID/ns/mnt file:
> 
>    allow <subject> <mntns_label>:file { watch_mount };
> 
> If we add a new file/watch_mountns permission the policy rule would
> look like this:
> 
>    allow <subject> <mntns_label>:file { watch_mountns };
> 

I've gone back and forth on this a few times.  If I understand it 
correctly, I think we might really want to have a new permission here, 
which is sad, because in my humble opinion, the watch_* permissions are 
already more complicated than I like.

"watch" does seem to be the wrong thing because this grants more than 
just changes to the specific file.  However, "watch_mount" is a very 
highly privileged operation.  Allowing watch on all reads and writes in 
the whole file hierarchy from a mount point is a substantial amount of 
access, and seems quite a bit more substantial than just watching new 
mounts being attached and detached (and similar) within a given mount 
namespace.

FWIW I do think the assumption that different labeling between /proc/pid 
files and mountpoints generally does make this not a problem in 
practice.  But in my opinion overloading watch_mount for this case seems 
different from the existing watch_mount permission to warrant not doing 
it.  Particularly with watch_mount being such a privileged operation.

-Daniel

