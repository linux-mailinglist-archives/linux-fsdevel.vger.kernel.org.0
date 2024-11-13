Return-Path: <linux-fsdevel+bounces-34629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC109C6D23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63CE3B22F2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87401FE0E1;
	Wed, 13 Nov 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLGhVafH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B2230984
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494927; cv=none; b=i4YKc74h2gKShXU2GlS5OybSsL0g4qvcGF9y9wJ52JmW4UCJfKf6Mx+3BiRbgC9pLzW62k+mqhf66SLoH63DohZ132fy3fjHqWnMIdca4npzCrO5tVU+t5Apd9Ur/qdR+L1rjU/eWDa1OMmsvSmbsXUwx4HobJOyfI2+OkGGA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494927; c=relaxed/simple;
	bh=JaXHthW69OWq7pu8xfdevV28GEyzUS07vO+cjBXBusk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbCfu4LI4qrdVxIFyVOrDAuCVNhdGR7q5/E9glj2P6RgubLHdtSOJWUUxSXyz0MGOEzjyue+/QZv4opdDYSo39ODnn6HgoE/kF58S0xqrEGVjui5rmu2oTgovH/fl7SKZGXrtSlH6ftasfW5w6XZNe5/Phzw0QPlTlbGKmVpxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLGhVafH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731494922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyiix1MwkCQpAPlotMs0JJeKLRpwAc92205dD5TfNd0=;
	b=RLGhVafHngWRZ3ebuplCtrlsV1H5L7zzSvPQerA2kadfW/QlxkpijEY3q21OxQirNfKSA8
	EsC870/hWXWGQFqCwJIkmkp6YaPJQ7goX+CUj5xU1qGLeXf10AO3Taain+irgE28EZXVEh
	BIXjeFEJlKqiPa3DE580nKTqerogJ5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-yyxlQhQeO5yGg-boZJj-NA-1; Wed,
 13 Nov 2024 05:48:39 -0500
X-MC-Unique: yyxlQhQeO5yGg-boZJj-NA-1
X-Mimecast-MFC-AGG-ID: yyxlQhQeO5yGg-boZJj-NA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AF121954B1E;
	Wed, 13 Nov 2024 10:48:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCE0D19560A3;
	Wed, 13 Nov 2024 10:48:34 +0000 (UTC)
Date: Wed, 13 Nov 2024 11:48:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: port all superblock creation logging to
 fsopen logs
Message-ID: <j7ngxuxqdwrq5o6zi2hmt3zfmh6s5mzrlvwjw6snqbv5oc5ggo@nqpr6wjec7go>
References: <20241106-overlayfs-fsopen-log-v1-1-9d883be7e56e@cyphar.com>
 <20241106-mehrzahl-bezaubern-109237c971e3@brauner>
 <CAOQ4uxirsNEK24=u3K-X5A-EX80ofEx5ycjoqU4gocBoPVxbYw@mail.gmail.com>
 <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
 <20241106.141100-patchy.noises.kissable.cannons-37UAyhH88iH@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106.141100-patchy.noises.kissable.cannons-37UAyhH88iH@cyphar.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Nov 07, 2024 at 02:09:19AM GMT, Aleksa Sarai wrote:
> On 2024-11-06, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Nov 6, 2024 at 12:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Wed, Nov 6, 2024 at 10:59 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Wed, Nov 06, 2024 at 02:09:58PM +1100, Aleksa Sarai wrote:
> > > > > overlayfs helpfully provides a lot of of information when setting up a
> > > > > mount, but unfortunately when using the fsopen(2) API, a lot of this
> > > > > information is mixed in with the general kernel log.
> > > > >
> > > > > In addition, some of the logs can become a source of spam if programs
> > > > > are creating many internal overlayfs mounts (in runc we use an internal
> > > > > overlayfs mount to protect the runc binary against container breakout
> > > > > attacks like CVE-2019-5736, and xino_auto=on caused a lot of spam in
> > > > > dmesg because we didn't explicitly disable xino[1]).
> > > > >
> > > > > By logging to the fs_context, userspace can get more accurate
> > > > > information when using fsopen(2) and there is less dmesg spam for
> > > > > systems where a lot of programs are using fsopen("overlay"). Legacy
> > > > > mount(2) users will still see the same errors in dmesg as they did
> > > > > before (though the prefix of the log messages will now be "overlay"
> > > > > rather than "overlayfs").
> > >
> > > I am not sure about the level of risk in this format change.
> > > Miklos, WDYT?
> > >
> > > > >
> > > > > [1]: https://bbs.archlinux.org/viewtopic.php?pid=2206551
> > > > >
> > > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > > ---
> > > >
> > > > To me this sounds inherently useful! So I'm all for it.
> > > >
> > >
> > > [CC: Karel]
> > >
> > > I am quite concerned about this.
> > > I have a memory that Christian suggested to make this change back in
> > > the original conversion to new mount API, but back then mount tool
> > > did not print out the errors to users properly and even if it does
> > > print out errors, some script could very well be ignoring them.
> 
> I think Christian mentioned this at LSF/MM (or maybe LPC), but it seems
> that util-linux does provide the log information now in the case of
> fsconfig(2) errors:
> 
> 	% strace -e fsopen,fsconfig mount -t overlay -o userxattr=str x /tmp/a
> 	fsopen("overlay", FSOPEN_CLOEXEC)       = 3
> 	fsconfig(3, FSCONFIG_SET_STRING, "source", "foo", 0) = 0
> 	fsconfig(3, FSCONFIG_SET_STRING, "userxattr", "str", 0) = -1 EINVAL (Invalid argument)
> 	mount: /tmp/a: fsconfig system call failed: overlay: Unexpected value for 'userxattr'.
> 		   dmesg(1) may have more information after failed mount system call.
> 
> (Using the current HEAD of util-linux -- openSUSE's util-linux isn't
> compiled with support for fsopen apparently.)

After failed mount-related syscalls, libmount reads messages prefixed
with "e " from the file descriptor created by fdopen(). These messages
are later printed by mount(8).

mount(8) or libmount does not read anything from kmesg.

> However, it doesn't output any of the info-level ancillary
> information if there were no errors.

This is the expected default behavior. mount(8) does not print any
additional information.

We can enhance libmount to read and print other messages on stdout if
requested by the user. For example, the mount(8) command has a
--verbose option that is currently only used by some /sbin/mount.<type>
helpers, but not by mount(8) itself. We can improve this and use it in
libmount to read and print info-level messages.

I can prepare a libmount/mount(8) patch for this.

> So there will definitely be some loss of
> information for pr_* logs that don't cause an actual error (which is a
> little unfortunate, since that is the exact dmesg spam that caused me to
> write this patch).
> 
> I could take a look at sending a patch to get libmount to output that
> information, but that won't help with the immediate issue, and this
> doesn't help with the possible concern with some script that scrapes
> dmesg. (Though I think it goes without saying that such scripts are kind
> of broken by design -- since unprivileged users can create overlayfs
> mounts and thus spam the kernel log with any message, there is no
> practical way for a script to correctly get the right log information
> without using the new mount API's logging facilities.)

> I can adjust this patch to only include the log+return-an-error cases,
> but that doesn't really address your primary concern, I guess.
> 
> > > My strong feeling is that suppressing legacy errors to kmsg should be opt-in
> > > via the new mount API and that it should not be the default for libmount.
> > > IMO, it is certainly NOT enough that new mount API is used by userspace
> > > as an indication for the kernel to suppress errors to kmsg.
 
For me, it seems like we are mixing two things together.

kmesg is a *log*, and tools like systemd read and save it. It is used
for later issue debugging or by log analyzers. This means that all
relevant information should be included.

The stderr/stdout output from tools such as mount(8) is simply
feedback for users or scripts, and informational messages are just
hints. They should not be considered a replacement for system logging
facilities. The same applies to messages read from the new mount API;
they should not be a replacement for system logs.

In my opinion, it is acceptable to suppress optional and unimportant
messages and not save them into kmesg. However, all other relevant
messages should be included regardless of the tool or API being used.

Additionally, it should be noted that mount(8)/libmount is only a
userspace tool and is not necessary for mounting filesystems. The
kernel should not rely on libmount behavior; there are other tools
available such as busybox.

> I can see an argument for some kind of MS_SILENT analogue for
> fsconfig(), though it will make the spam problem worse until programs
> migrate to setting this new flag.
 
Yes, the ideal solution would be to have mount options that can
control this behavior. This would allow users to have control over it
and save their settings to fstab, as well as keep it specific to the
mount node.

> Also, as this is already an issue ever since libmount added support for
> the new API (so since 2.39 I believe?), I think it would make just as
> much sense for this flag to be opt-in -- so libmount could set the
> "verbose" or "kmsglog" flag by default but most normal programs would
> not get the spammy behaviour by default.

I prefer if the default behavior is defined by the kernel, rather than
by userspace tools like libmount. If we were to automatically add any
mount options through libmount, it would make it difficult to coexist
with settings in fstab, etc. It's always better to have transparency
and avoid any hidden factors in the process.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


