Return-Path: <linux-fsdevel+bounces-38162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9729F9FD469
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 14:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8033A18F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF481F37AE;
	Fri, 27 Dec 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O73zKzYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2141F4273;
	Fri, 27 Dec 2024 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735304510; cv=none; b=pznOaH2ywq30gNxDEU5QgBRgfFtI7F/bUO30Nwqi8QdEDaOK1zwwM+/rNvnzIzF88ybsBhGAOFh6zY3SehlS8StNkj/+08UrS3J3KyzEnlJtrw+pI6kcgtXmxa5Yt6de3lClw9Z38kBVQoQ6ez8HwG4KMUAfgpMnl53oyVuxOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735304510; c=relaxed/simple;
	bh=dolR1U+H4lYAhezUG/pHOFnyYj42yMbru3ukd01vFuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g56HyRq9Pd1x75m38CbNr5B9tVOBfF1Il6kBNvABjG5SbRRnsXR8mnojLtVSHPyAvaM18g6j6abIJHfEzsViXa1DY+IZJQNSYLHoUVFtyndh6Lv5WfP2tpww7g/wn+q8EdH1AusN652T2Y7hJrie+mdqzvF9esqJzeS+J2gIPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O73zKzYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFFBC4CED0;
	Fri, 27 Dec 2024 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735304509;
	bh=dolR1U+H4lYAhezUG/pHOFnyYj42yMbru3ukd01vFuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O73zKzYOWIiDzOCHTa3vQkZNamfw5/uwvq1HgENkP5tBIZT+0SnrBl9tv08MU1ghO
	 m9PSX4EwzMfOzZH8wIs9aA6Vy1OB9nYJQI1U9PPY1ATCGc5hJNMSteQpem+X27fBox
	 eqQS1jlU4qDo9hLIMVJPbMXBXvCtoDZSPbYvKltrGegnQn+DIYHz6nULeaE9QZyve6
	 4YQtYtA1ymB7hXsVo+pR0r4o+p1hY7b8hNsbXs9X2Rgn6bh/zn18NddFhoZuxPe6C5
	 TZw/++2A7DVWS9i9ZvlhFKZ+SmP/9mWS+abur4KHZpi8KkM5oFzDb1IBAWaUgyKa3f
	 3pYGSuFg1nOWQ==
Received: by pali.im (Postfix)
	id 6D289787; Fri, 27 Dec 2024 14:01:39 +0100 (CET)
Date: Fri, 27 Dec 2024 14:01:39 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Errno codes from symlink() syscall
Message-ID: <20241227130139.dplqu5jlli57hhhm@pali>
References: <20241224160535.pi6nazpugqkhvfns@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241224160535.pi6nazpugqkhvfns@pali>
User-Agent: NeoMutt/20180716

On Tuesday 24 December 2024 17:05:35 Pali Rohár wrote:
> TL;DR;
> Which errno code should network fs driver returns on create symlink
> failure to userspace application for these cases?
> * creating new symlink is not supported by fs driver mount options
> * creating new symlink is not supported by remote server software
> * creating new symlink is not supported by remote server storage
> * creating new symlink is not permitted for user due to missing
>   privilege/capability (indicated by remote server)
> * access to the directory was denied due to ACL/mode (on remote)
> 
> 
> Hello,
> 
> I discussed with Steve that current error codes from symlink() syscall
> propagated to userspace on mounted SMB share are in most cases
> misleading for end user who is trying to create a new symlink via ln -s
> command.
> 
> Linux SMB client (cifs.ko) can see different kind of errors when it is
> trying to create a symlink on SMB server. I know at least about these
> errors which can happen:
> 
> 1 For the current mount parameters, the Linux SMB client does not
>   implement creating a new symlink yet and server supports symlinks.
>   This applies for example for SMB1 dialect against Windows server, when
>   Linux SMB client is already able to query existing symlinks via
>   readlink() syscall (just not able to create new one).
> 
> 2 For the current mount parameters, the SMB server does not support
>   symlink operations at all. But it can support it when using other
>   mount parameters. This applies for example for older Samba server with
>   SMB2+ dialect (when older version supported symlinks only over SMB1).
> 
> 3 The SMB server for the mounted share does not support symlink
>   operations at all. For example server supports symlinks, but mounted
>   share is on FAT32 on which symlinks cannot be stored.
> 
> 4 The user who is logged to SMB server does not have a privilege to
>   create a new symlink at all. But server and also share supports
>   symlinks without any problem. Just this user is less privileged,
>   and no ACL/mode can help.
> 
> 5 The user does not have access right to create a new object (file,
>   directory, symlink, etc...) in the specified directory. For example
>   "chmod -w" can cause this.
> 
> Linux SMB client should have all information via different SMB error
> codes to distinguish between all these 5 situations.
> 
> On Windows servers for creating a new symlink is required that user has
> SeCreateSymbolicLinkPrivilege. This privilege is by default enabled only
> for Administrators, so by default ordinary users cannot create symlinks
> due to security restrictions. On the other hand, querying symlink path
> is allowed for any user (who has access to that symlink fs object).
> 
> Therefore it is important for user who is calling 'ln -s' command on SMB
> share mounted on Linux to distinguish between 4 and 5 on failure. If
> user needs to just add "write-directory" permission (chmod +w) or asking
> AD admin for adding SeCreateSymbolicLinkPrivilege into Group Policy.
> 
> 
> I would like to open a discussion on fsdevel list, what errno codes from
> symlink() syscall should be reported to userspace for particular
> situations 1 - 5?
> 
> Situation 5 should be classic EACCES. I think this should be clear.
> 
> Situation 4 start to be complicated. Windows "privilege" is basically
> same as Linux "capability", it is bound to the process and in normal
> situation it is set by login manager. Just Linux does not have
> equivalent capability for allowing creating new symlink. But generally
> Linux for missing permission which is granted by capability (e.g. for
> ioperm() via CAP_SYS_RAWIO) is in lot of cases returned errno EPERM.
> 
> So I thought that EPERM is a good errno candidate for situation 4, until
> I figured out that "symlink(2)" manapage has documented that EPERM has
> completely different meaning:
> 
>   EPERM  The filesystem containing linkpath does not support the
>          creation of symbolic links.
> 
> And I do not understand why. I have tried to call 'ln -s' on FAT32 and
> it really showed me: "Operation not permitted" even under root. For user
> this error message sounds like it needs to be admin / root. It is very
> misleading.
> 
> At least it looks like that EPERM cannot be used for this situation.
> And so it is not so easy to figure out what error codes should be
> correctly returned to userspace.
> 
> 
> Pali

I was thinking more about it and the reasonable solution could be to use
following errno codes for these situations:

 EOPNOTSUPP - server or client does not support symlink operation
 EPERM - user does not have privilege / capability to create new symlink
 EACCES - user does not have (ACL) permission to create new symlink

But in this case it would be needed to extend symlink(2) manpage. It is
feasible? Or the meaning of EPERM is written in the stone, it means that
operation is not supported, and it cannot be changed?

For me it sounds a bug if EPERM means "not supported", and also "ln -s"
tool does not understand this EPERM error as it shows human readable
message "Operation not permitted" instead of "Operation not supported"
(which is the correct one in this situation).

