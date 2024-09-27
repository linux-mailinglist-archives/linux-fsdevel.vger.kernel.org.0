Return-Path: <linux-fsdevel+bounces-30309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F698932D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 08:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED8E1F22AFF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 06:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856913A41F;
	Sun, 29 Sep 2024 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="F9lb2t0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35FF37171
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727589791; cv=none; b=Qf3uduX0o55iUBUvs7eFtdm3j9sS6hPP9O0rZkCCzcDNj6PWX6kOyiiSUxemN1T5BRTSHrspf4aEaWKJKko6cjWntazmbkKAY7KSCm0eHNltGnqmPvtqWq8BBr36/+e8mcXKjpLxSn4Q037dWjqRdNrsKAVCppVMgQua/j3GjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727589791; c=relaxed/simple;
	bh=+akFPa+8alj51MCfrHOvoYE8LLNbQjwGyJuPEMHWLnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlFIsKtrqCQ90YD8y0IAev1lsaHTzwdv9QxkixSdtJluxasusMz8WqfjzGS9bs9PmLTAZzMzuWHdjeiY6RFIoaGjBNBCR7+QEFsIH3G18SOyOrv5gxKoI+XUNLmPrsmdwD7TsHvsemvn+c+/++6cH4wB98DLzLCbi5zgNIziQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=F9lb2t0f; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([191.96.150.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 48T5xa0F003145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 01:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1727589579; bh=irslh8MsFcziIi7ImkqjnJQeDeABJM+Q2j1bZu9qw5Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=F9lb2t0f9NjX3BPjn6sGHLs9VIHknZUoi1KhvEaJOtho67SUD8rFrxfiHFKznp9+S
	 eCajM9Fo0SdJuLBsT3cDKG/qWuY9FH/YuRXkTW0Q+McT37KKIyIM3y99vlgbpUc9AR
	 pUZczo55ghh124GGJyyNY5jpzHkCn2kvNJeSVfQjicQCCmOqajnqaDnegEknvxd+1+
	 tx7YlAyzawhZv4mHHPV1nM23Sp3OljZk1syml6ecHvIgWGJ3X95gcpC7H/43iBZ7Hx
	 7fJtFtY/lj8JtED6GlIEuqqdDVhFgaugNG+qvp7s1U1bPLVXm4iMxaLWp0cZmgsuhb
	 tNfxAH8ChHfgA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 9B17A3402F3; Fri, 27 Sep 2024 08:50:19 -0700 (PDT)
Date: Fri, 27 Sep 2024 08:50:19 -0700
From: "Theodore Ts'o" <tytso@mit.edu>
To: Max Brener <linmaxi@gmail.com>
Cc: adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] vfs/ext4: Fixed a potential problem related to
 an infinite loop
Message-ID: <20240927155019.GA365622@mit.edu>
References: <20240926221103.24423-1-linmaxi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926221103.24423-1-linmaxi@gmail.com>

On Fri, Sep 27, 2024 at 01:11:03AM +0300, Max Brener wrote:
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219306
> 
> This patch fixes a potential infinite journal-truncate-print
> problem.  When systemd's journald is called, ftruncate syscall is
> called. If anywhere down the call stack of ftruncate a printk of
> some sort happens, it triggers journald again therefore an infinite
> loop is established.

This isn't a good justification for this change; in general, whenever
you have code paths which get triggered when a logging daemon is
triggered, whether it's systemd-journald, or syslog, and this can
cause this kind of infinite loop.  For example, suppose you are using
remote logging (where a log message gets sent over the network via the
remote syslog facility), and anything in the networking stack triggers
a printk, that will also trigger an "infinite loop".  This falls in
the "Doctor, doctor, it hurts when I do that --- so don't do that!"

In this particular situation, journald is doing something silly/stupid
which is whenver a message is logged, it is issuing a no-op ftruncate
to the journald log file.  It's also worth noting that ext4's truncate
path does *not* trigger a printk unless something really haw gone
wrong (e.g., a WARN_ON when a kernel bug has happened and flags in the
in-memory get erronously set, or the file system gets corrupted and
this gets reported via ext4_error()).  The reporter discovered this by
explicitly adding a printk in their privatea kernel sources, and in
general, when you add random changes to the kernel, any unfortunate
consequences are not something that upstream code can be expected to
defend against.

For context, see: https://bugzilla.kernel.org/show_bug.cgi?id=219306

We can justify an optimization here so that in the case of
silly/stupid userspace programs which are constnatly calling
truncate(2) which are no-ops, we can optimize ext4's handling of these
silly/stupid programs.  The ext4_truncate() code path causes starting
a journal handle, adding the inode to the orphan list, and then
removing it at the end of the truncate.  In the case where sopme
program calls truncate() in a tight loop, we can optimize the
behaviour.  It's not a high priority optimization, but if given that
we can't necessarily change silly/stupid userspace programmers, it can
be something that we can do if the patch is too invasive.

HOWEVER....


> To fix this issue:
> Add  a new inode flag S_TRUNCATED which helps in stopping such an infinite loop by marking an in-memory inode as already truncated.

Adding a generic VFS-level flag is not something that we can justify
here.  The VFS maintainers would NACK such a change, and deservedly
so.

What I had in mind was to define a new EXT4 state flag, say,
EXT4_STATE_TRUNCATED, and then test, set, and clear it using
ext4_{test,set,clear}_inode_state().

Cheers,

					- Ted

