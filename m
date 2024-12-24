Return-Path: <linux-fsdevel+bounces-38103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED57F9FBFE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 17:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E2007A1E2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228A1D8A0B;
	Tue, 24 Dec 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzw+JBz0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204E1B3926;
	Tue, 24 Dec 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735056346; cv=none; b=BSAUqVf2lDgWgG7gkUMWAaADdYayjQEjlSQQwBsgGk9FTvJ+I3HYKSJ+RdczB0uCm2bEz0YLYNF0I5Po35W45uO5cwtymJ6XgBHcGaDtAymnaHrb8BUDYBGpXKqIH7C67hgomi6HL+i7osVubbmkO/LU1TI14PR3jyXqCL8Nwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735056346; c=relaxed/simple;
	bh=ZpKBVprYkpYtjeHa4udStkTIytH/4XDXfCEGZY/JC3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ae7uLdcxGD5dzihPRy/eMBdz88YamngOF32un7iFLM5NWWG3qdMeps2ay5pIWD0AYwQhlKwspAC0qdv4psjWK5OGHNRSczWbUOWW1TwsyJ5fUe/7lj0CPdWofF+aDUkrrYF6vVIeOITSf0x5G1fMT36jBa7NZFJFrVwEjthyPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzw+JBz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF13C4CED0;
	Tue, 24 Dec 2024 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735056346;
	bh=ZpKBVprYkpYtjeHa4udStkTIytH/4XDXfCEGZY/JC3s=;
	h=Date:From:To:Cc:Subject:From;
	b=Wzw+JBz0bPJmn5MAIY2rpZJBiJoB3vO8JmL+mvdO7rlJ08uZpa9WQpSk0o0vuL3Hy
	 R8Y9QhqO7HCIziB8XMGRQAzuoxgwbD3iFnIkLufsGrVHzCW1aVep+HEGY8BqTC8nma
	 f408MziE079pqIALFjCYGkpzLXnNeGB3YrbgJA3NKFQLlqOEj/Uz6rycGOn4iAjPoq
	 +FNboMNT3wg2UaHqJEuZ2ISUxLU6MkCgoHch4QGkHVjcW1JV6MSDC8J3R1FAi6MESx
	 jQaHn/DKLVfNgNUoE237sPfun03v3kpICE4lRPhd/fgtI026ecFOYieZxu9Voh2ecV
	 sYiXSCk/Iv5tw==
Received: by pali.im (Postfix)
	id 00CCF988; Tue, 24 Dec 2024 17:05:35 +0100 (CET)
Date: Tue, 24 Dec 2024 17:05:35 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Errno codes from symlink() syscall
Message-ID: <20241224160535.pi6nazpugqkhvfns@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716

TL;DR;
Which errno code should network fs driver returns on create symlink
failure to userspace application for these cases?
* creating new symlink is not supported by fs driver mount options
* creating new symlink is not supported by remote server software
* creating new symlink is not supported by remote server storage
* creating new symlink is not permitted for user due to missing
  privilege/capability (indicated by remote server)
* access to the directory was denied due to ACL/mode (on remote)


Hello,

I discussed with Steve that current error codes from symlink() syscall
propagated to userspace on mounted SMB share are in most cases
misleading for end user who is trying to create a new symlink via ln -s
command.

Linux SMB client (cifs.ko) can see different kind of errors when it is
trying to create a symlink on SMB server. I know at least about these
errors which can happen:

1 For the current mount parameters, the Linux SMB client does not
  implement creating a new symlink yet and server supports symlinks.
  This applies for example for SMB1 dialect against Windows server, when
  Linux SMB client is already able to query existing symlinks via
  readlink() syscall (just not able to create new one).

2 For the current mount parameters, the SMB server does not support
  symlink operations at all. But it can support it when using other
  mount parameters. This applies for example for older Samba server with
  SMB2+ dialect (when older version supported symlinks only over SMB1).

3 The SMB server for the mounted share does not support symlink
  operations at all. For example server supports symlinks, but mounted
  share is on FAT32 on which symlinks cannot be stored.

4 The user who is logged to SMB server does not have a privilege to
  create a new symlink at all. But server and also share supports
  symlinks without any problem. Just this user is less privileged,
  and no ACL/mode can help.

5 The user does not have access right to create a new object (file,
  directory, symlink, etc...) in the specified directory. For example
  "chmod -w" can cause this.

Linux SMB client should have all information via different SMB error
codes to distinguish between all these 5 situations.

On Windows servers for creating a new symlink is required that user has
SeCreateSymbolicLinkPrivilege. This privilege is by default enabled only
for Administrators, so by default ordinary users cannot create symlinks
due to security restrictions. On the other hand, querying symlink path
is allowed for any user (who has access to that symlink fs object).

Therefore it is important for user who is calling 'ln -s' command on SMB
share mounted on Linux to distinguish between 4 and 5 on failure. If
user needs to just add "write-directory" permission (chmod +w) or asking
AD admin for adding SeCreateSymbolicLinkPrivilege into Group Policy.


I would like to open a discussion on fsdevel list, what errno codes from
symlink() syscall should be reported to userspace for particular
situations 1 - 5?

Situation 5 should be classic EACCES. I think this should be clear.

Situation 4 start to be complicated. Windows "privilege" is basically
same as Linux "capability", it is bound to the process and in normal
situation it is set by login manager. Just Linux does not have
equivalent capability for allowing creating new symlink. But generally
Linux for missing permission which is granted by capability (e.g. for
ioperm() via CAP_SYS_RAWIO) is in lot of cases returned errno EPERM.

So I thought that EPERM is a good errno candidate for situation 4, until
I figured out that "symlink(2)" manapage has documented that EPERM has
completely different meaning:

  EPERM  The filesystem containing linkpath does not support the
         creation of symbolic links.

And I do not understand why. I have tried to call 'ln -s' on FAT32 and
it really showed me: "Operation not permitted" even under root. For user
this error message sounds like it needs to be admin / root. It is very
misleading.

At least it looks like that EPERM cannot be used for this situation.
And so it is not so easy to figure out what error codes should be
correctly returned to userspace.


Pali

