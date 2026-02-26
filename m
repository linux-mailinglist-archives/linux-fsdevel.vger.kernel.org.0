Return-Path: <linux-fsdevel+bounces-78484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOyhGGROoGnvhwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:45:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4291A6DD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F6EB3136C80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6518436A008;
	Thu, 26 Feb 2026 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4GY1B0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812036B06C;
	Thu, 26 Feb 2026 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113113; cv=none; b=SLeQ0apbKvsoQ9+UxOvxyMax1HkyTRvjfWOKWUW1v6i9K8E4a8LOwlSSaMljwwup7P1UbSCLIZxb+3JtFPQVaBNrdFjLH+RDSKFYABqxinDkYPxEyFY2u1kDnb1UGLJFIAaGtYVtdLlf6NxuylFMtvEvTi2iBRPA+li2urrbKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113113; c=relaxed/simple;
	bh=iTpLMqU5w/8tqAe4zu/zNooByLEZgVqkMWGip2X/rq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBv+ztHIt+pO89ZAVrnnXOEW8i7lOBPyIa4Prr4XnsnCh+u2UN3zm3ipTTxpOlEtGADZpr5p3gwL4HefUvXF4E4wNHa2bgFEWV6gOSa6GOazMPGJ5QZ0eN6t6KnSB5OH3s11orEATnF+MmcIugbndcRUb3jisO5yl+ZlgVnuqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4GY1B0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF624C19422;
	Thu, 26 Feb 2026 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113113;
	bh=iTpLMqU5w/8tqAe4zu/zNooByLEZgVqkMWGip2X/rq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4GY1B0KERPulNSyrV+BeHgUd6w4hYjSMoK084zyJrEewnPKisa/GW5HdwuT9XCOZ
	 J5JOfCSQV474Esb+z9EaQpjy6date7QhQ+ZUTNwKJF/H7tCgYOdrr1Y9nurjLq1OfP
	 npJLT+uI66BvKcuMGEVzPReTbPOE3m5Lu8J+YYNW1iV6Ui0IuFDQGMBL+3l1fcHePP
	 y+9StW4+ttTdTB1H9olwd3q8g8CvOpqvXtDQxwfWFqHLpJdE7oq+16SBgQvTkl3Kls
	 lScJN1GfG0wc0nJSR5QgFCdedRIRwzVkI+vKIb1qjT60C3dpV+1mjcb7xdUeJOyNFA
	 eWYqNvgWOmHZA==
Date: Thu, 26 Feb 2026 14:38:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Generic approach to avoid truncation of file on pseudo fs
Message-ID: <20260226-ruhetag-unsauber-7bb117fc6239@brauner>
References: <CAJ2a_Df6GOirF8TnNWTqNMpdWLHgjT9_v7G-PiL4e7LU2nr1PA@mail.gmail.com>
 <nivmqedi2e4wgufmr74fed5jda24dmzj6kroufd5krqrnj4fdm@jnfkf27ncjy3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nivmqedi2e4wgufmr74fed5jda24dmzj6kroufd5krqrnj4fdm@jnfkf27ncjy3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78484-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[googlemail.com,vger.kernel.org,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB4291A6DD6
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:29:33PM +0100, Jan Kara wrote:
> On Thu 19-02-26 14:37:05, Christian Göttsche wrote:
> > Hi all,
> > 
> > SELinux offers a memory mapping for userspace for status changes via
> > the pseudo file /sys/fs/selinux/status.
> > Currently this file can be truncated by a privileged process, leading
> > to other userland processes getting signalled a bus error (SIGBUS).
> > This affects for example systemd [1].
> > I proposed a targeted fix [2], overriding the inode setattr handler
> > and filtering O_TRUNC on open.
> > 
> > Is there there a general solution how to prevent truncation of pseudo
> > files backed up by real memory?
> > Are there more ways a file can be truncated that should be handled?
> > 
> > 
> > If there is no generic way would the following patch be acceptable?
> 
> OK, since my knowledge about this code is limited, I did some research :).
> Firstly, I've checked how other virtual filesystems behave and the answer
> is "it depends". E.g. those that are based on kernfs (e.g. sysfs) have
> their own .setattr handler which just ignores ATTR_SIZE. From those that
> are based on simple_fill_super as is the case for selinux (but also
> debugfs, nfsctl, tracefs, fusectl, binfmt) all of them just allow the file
> size to be changed which likely has some potential for confusing userspace
> for some of them. So I don't see a problem with allowing to pass
> inode_operations to use by simple_fill_super() but I'm a bit undecided
> whether it wouldn't be more sensible for pseudo_fs_fill_super() to just
> set inode->i_op to inode operations that don't allow truncate because for
> none of the filesystems using it, it looks useful to say the least.

It would at least be worth trying. For backwards compat we must probably
ignore it instead of reporting an error though.

