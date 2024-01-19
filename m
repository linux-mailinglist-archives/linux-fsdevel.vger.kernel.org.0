Return-Path: <linux-fsdevel+bounces-8311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7E832C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 16:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651561C22A67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749495479F;
	Fri, 19 Jan 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8WSvx6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20A54760
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676665; cv=none; b=FE6ZK2IlkqqmCD/wfsz+RNYBuOc759ZjlfdaJjdadLpLbXS7JmnRPMGSNY29F6F9SeJLhsX3dEBUyMCa/MkzKIBUfDxnoJl9RoHMvu2+Bk3+GAqta8uRUy1KYMHZmMCImQ0AVuJ45omHDriuLIqiAGXPtH+UYwdEjMVb/DbD3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676665; c=relaxed/simple;
	bh=g0Eqxs7N7kbvMbrPNOYDNX2TXmJVrwersIoRUmE5JQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llFShbdPf5h+ySJ253oMfYwyAssVl596jq+Bs9WXMjVX+ZrA8kygiU5DqtiDpsIQeX7Vw6rK7uSmcs1hPFY8yHZDmF4evd+hzebchVPg3KOkQtlr79T5uln3VI4+oc+SfMPotkecsXNTaZE7gW3O5jsjQUAcgk/cvNgQD6aCl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8WSvx6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5BAC433C7;
	Fri, 19 Jan 2024 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705676665;
	bh=g0Eqxs7N7kbvMbrPNOYDNX2TXmJVrwersIoRUmE5JQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8WSvx6ICzlagqsF6OcB8Ysm/h2i6uJiisi7/5NvMZ+qfsiHgA94eQ6tDNwkHxclE
	 YIRqzQ8cCg8FA38BNwdpOGDdf1SMEd9DynKg3ZFcS1OcXboTfhxHIY42bk+9x6dQQr
	 UIZpSPF2bKCaddm/HB8gmvebG2wLLlZviIL+dhMlXhF2JLXQDM8SV+aIin+ngj0A6n
	 UmAHzGD3FwEdFTk8uJnyYwPEatv6pF+RnpaADqX6pczlXXaTEjQKVxrMcTTIw6thzK
	 +iaOyr2brRZMS7cZN48G1Fnc7JHASyu6dAjDRG1K4mkPm0m1MPCoSZMdjglL842NiU
	 2JK7Kb+yTEJgw==
Date: Fri, 19 Jan 2024 16:04:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Ryan <gabe@cs.columbia.edu>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: Race in fs/posix_acl.c posix_acl_update_mode and related checks
 on inode->i_mode in kernel v6.6
Message-ID: <20240119-rastplatz-sauer-b8a809f0498c@brauner>
References: <CALbthtcSSJig8dzTT0LNkhYOFEZCWZR1fvX8UCN2Z57_78oWnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALbthtcSSJig8dzTT0LNkhYOFEZCWZR1fvX8UCN2Z57_78oWnA@mail.gmail.com>

On Thu, Jan 18, 2024 at 11:30:29AM -0500, Gabriel Ryan wrote:
> We found races in the fs subsystem in kernel v6.6 using a race testing
> tool we are developing based on modified KCSAN. We are reporting the
> races because they appear to be a potential bug. The races occur on
> inode->i_mode, which is updated in
> 
> fs/posix_acl.c:722 posix_acl_update_mode
> 
> and can race with reads in the following locations:
> 
> security/selinux/hooks.c:3087 selinux_inode_permission
> include/linux/fsnotify.h:65 fsnotify_parent
> include/linux/device_cgroup.h:24 devcgroup_inode_permission
> fs/open.c:923,931 do_dentry_open
> fs/namei.c:342 acl_permission_check
> fs/namei.c:3242 may_open
> 
> 
> In cases where multiple threads are updating and accessing a single
> inode simultaneously, it seems like this could potentially lead to
> undefined behavior, if for example an access check is passed based on
> one i_mode setting, and then the inode->imode is modified by another
> thread.

Uhm, you need to provide more details than that. This is too vague to be
meaningful especially without any traces. IIRC, posix_acl_update_mode()
is called:

* when a new inode is created before it has been added to the
  d+i-cache. Unless of course, there is a filesystem that updates the
  mode of the inode _after_ the inode has been added to the d+icache.

* The other codepath would be setting an ACL directly via ->set_acl()
  through one of the setxattr() system calls. But even in that case the
  race would be semantically benign. IOW, if we passed the permission
  check on inode->i_mode and it's changed afterwads we don't care. We
  accept such races.

  So the issue you're referencing is what exactly? That the update to
  inode->i_mode can be done through a pointer when passing
  &inode->i_mode directly to posix_acl_update_mode() in which case you
  worry about torn reads/writes? So that would be fixed with a
  WRITE_ONCE() in posix_acl_update_mode()?

