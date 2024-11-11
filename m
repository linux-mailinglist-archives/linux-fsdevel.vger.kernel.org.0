Return-Path: <linux-fsdevel+bounces-34221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E08B9C3E6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC23B20BA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A548189BBB;
	Mon, 11 Nov 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTzWEyIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF955C29;
	Mon, 11 Nov 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328256; cv=none; b=HZJJZEQ8jqV133FwBKuvDRowUV3LhBxZKWGgrCe/l4U2zKtLICbg0gKtYXCLTR/uBO7PXVcJQEChfBPLvppDum7PUy8TPo9qh5MI/NfBKRozyxN5YbZ7dZMEiKG2bovQcU7xDrfrA+oT5hq1e56CDySW88LrvRWfsTAbvG+E+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328256; c=relaxed/simple;
	bh=ihQcDuzRhqrkWuxg9HooJoiJ3EJAF6SrEZPYiQkmmGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVjtPlgXE069tcYc/gfdMOnPQN3HY0x8pZ000DZVdS4xX9vrl310Mtsk51m5tydFP323W4PJBxVQBXS81NgQzuDTaUfM3/vx9w8sinrthykkfRIk6Ti4nQjsbB8qOtZ7t3ok1ysjlvmPwjPRpV6ZwPzLILYhv9iPWdOOauyUfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTzWEyIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE78AC4CECF;
	Mon, 11 Nov 2024 12:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731328255;
	bh=ihQcDuzRhqrkWuxg9HooJoiJ3EJAF6SrEZPYiQkmmGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTzWEyIUD21jD6UTLoEvBNCsEh1YOMEfo2ya346GcvkSQygAFdaLMdxoK8lSm1qcL
	 9BWatNEetQhXwRBkuZQgWtuoLC0/e5oSb2j/ArIMdfe4gX/v07Qhj9HaSFqj7fm7P3
	 cfpEADdnZ59KV347aP5XX+AVLmkgEkUyAzKlV2SszJwpWYt9F8byXpH63gV7JVIDkS
	 6tafS2xdK1xVQqCGPXMylLxFuRKNL5S0LC09WsvHkE1DMQ2euywv02GSS3VSWf73DO
	 kxa4o7RQJewH2pKjc3ikkaXoNz+GehOG7kjNEDAorAncK/FeW+ZCYN6owU4yG9Bucn
	 hJwhHXiv+KtSw==
Date: Mon, 11 Nov 2024 13:30:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Eric Sandeen <sandeen@sandeen.net>, Zorro Lang <zlang@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Ian Kent <raven@themaw.net>
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2
 (new mount APIs)
Message-ID: <20241111-erbschaft-unruhen-d42cefd92f46@brauner>
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
 <9f489a85-a2b5-4bd0-98ea-38e1f35fed47@sandeen.net>
 <20241031-ausdehnen-zensur-c7978b7da9a6@brauner>
 <CAJfpegtyMVX0Rzgd6Mqg=9OxqJzrGufqOK4iBU2TSSDrt36-PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtyMVX0Rzgd6Mqg=9OxqJzrGufqOK4iBU2TSSDrt36-PQ@mail.gmail.com>

On Mon, Nov 04, 2024 at 05:41:18PM +0100, Miklos Szeredi wrote:
> On Thu, 31 Oct 2024 at 11:30, Christian Brauner <brauner@kernel.org> wrote:
> 
> > One option would be to add a fsconfig() flag that enforces strict
> > remount behavior if the filesystem supports it. So it's would become an
> > opt-in thing.
> 
> From what mount(8) does it seems the expected behavior of filesystems
> is to reset the configuration state before parsing options in
> reconfigure.   But it's not what mount(8) expects on the command line.

I'm not sure that's the case but I might misremember what mount(8) does.

As best as I remember it the mount(2) system call has different behavior
for VFS generic options, and filesystem specific mount options.

The difficulty is once again that both are mixed together in the
mount(2) system call which hides the behavioral differences. I'll try to
summarize what I remember below. 

> I.e. "mount -oremount,ro" will result in all previous options being
> added to the list of options (except rw).  There's a big disconnect
> between the two interfaces.

So for VFS generic mount options the behavior of mount(2) is that if one
has a filesystem mounted with nodev,nosuid,ro such as:

	mount(NULL, "/mnt", "tmpfs", 0, "nodev,nosuid");

and one now remounts (proper remount, not MS_BIND | MS_REMOUNT) as "ro":

	mount(NULL, "/mnt", "", MS_REMOUNT, "ro");

then mount(2) will not display additive behavior for the generic VFS
mount options. Instead, it will treat it as a "reset". So "ro" gets
added and "nosuid" and "nodev" get stripped.

That non-additive behavior has actually caused quite some security
issues. So mount(8) works around this, by translating a:

	mount -o remount,ro /mnt

internally into:

	mount(NULL, "/mnt", "", MS_REMOUNT, "ro,nodev,nosuid");

But afair, this reset behavior only applies to generic VFS options (ro,
nosuid, nodev, noexec) but not filesystem specific options during
remount.

In contrast, the problem with filesystem specific mount options during
remount, is that quite a few filesystems ignore unknown mount options or
mount options that cannot be changed on remount.

This is effecitvely what overlayfs does when the remount request comes
from the old mount(2) api. It will just consume anything and ignore even
nonsensical/nonexistent mount options.

This causes other problems where users that want to really ensure that a
mount property gets changed during remount cannot be sure because
anything will succeed.

So initially I had thought we could change that behavior by
differentiating between a request coming from the old or new mount api.
If the request comes from the new mount api we would return errors for
unknown- or mount options that cannot be changed on remount.

However, this seems to break some tools such as mount(8) because it
reassembles all mount options during remount to emulate additive
behavior but then fails because a remount request from the new mount api
rejects mount options that can't be changed during a remount.

But there's definitely use-cases where userspace wants to know whether a
mount option was actually change{d,able} during a remount.

To accomodate the old and new behavior my idea had been to let the
filesystem choose whether to ignore unknown mount options or whether it
will error out if unknown mount options are specified or when mount
options are specified that cannot be changed on remount.

A filesystem that allows for strict mount option parsing could raise a
flag in fs_flags and then a new uapi extension for fsopen() gets added,
e.g., Something like:

        fsopen("overlayfs", FSOPEN_REMOUNT_STRICT);

(Fwiw, mount_setattr() is additive/subtractive, i.e., it does the
right thing and only clears or sets the options that are explicitly
specified, leaving other options alone.)

> 
> I guess your suggestion is to allow filesystem to process only the
> options that are changed, right?
> 
> I think that makes perfect sense and would allow to slowly get rid of
> the above disconnect.

