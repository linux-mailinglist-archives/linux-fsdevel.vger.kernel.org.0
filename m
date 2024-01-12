Return-Path: <linux-fsdevel+bounces-7861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88D82BC58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 09:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1904B22BCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52495D8EF;
	Fri, 12 Jan 2024 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG7OWKPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391755D753;
	Fri, 12 Jan 2024 08:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3DAC433C7;
	Fri, 12 Jan 2024 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705048050;
	bh=/NdXb/L49bbVn5XF5vVNs/DqjuCei7Q3bgf+e+k7RGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hG7OWKPKJUKRd18+d7vZGF90KYXn73aypHOTjoT5Mpk6KFUDZ1tYxBFAIczGW7EGM
	 mfjrNmT4C4x4d2jPQP5vjR5ymIFR3MH7H2GUZVlvSl6i6Pl7ilUSkKwiXyfDqaOZ5b
	 eRZBOPxvBcIvcdQr5bzKGlf1+eJFlkZQTBGgyZupVuRNHwuOG3/sWWpcI6vyHGWU1P
	 8pHGBo5jMkU+OqwJODXtCGjx7z8ZAC1LU7o9VKRg2IfIt7weYUYPBoVCzR/WEvx2QV
	 GAsnW8FRWQ8EJ7bf9RIsxfqV3ifB0x5f+AjxXbZqcuEAhdoGFsZGjYCgqBSl77p3K/
	 xcNp3Kl42Yh6A==
Date: Fri, 12 Jan 2024 09:27:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240112-normierung-knipsen-dccb7cac7efc@brauner>
References: <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
 <20240105095954.67de63c2@gandalf.local.home>
 <20240107-getrickst-angeeignet-049cea8cad13@brauner>
 <20240107132912.71b109d8@rorschach.local.home>
 <20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
 <20240108102331.7de98cab@gandalf.local.home>
 <20240110-murren-extra-cd1241aae470@brauner>
 <20240110080746.50f7767d@gandalf.local.home>
 <20240111-unzahl-gefegt-433acb8a841d@brauner>
 <20240111165319.4bb2af76@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111165319.4bb2af76@gandalf.local.home>

On Thu, Jan 11, 2024 at 04:53:19PM -0500, Steven Rostedt wrote:
> On Thu, 11 Jan 2024 22:01:32 +0100
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > What I'm pointing out in the current logic is that the caller is
> > taxed twice:
> > 
> > (1) Once when the VFS has done inode_permission(MAY_EXEC, "xfs")
> > (2) And again when you call lookup_one_len() in eventfs_start_creating()
> >     _because_ the permission check in lookup_one_len() is the exact
> >     same permission check again that the vfs has done
> >     inode_permission(MAY_EXEC, "xfs").
> 
> As I described in: https://lore.kernel.org/all/20240110133154.6e18feb9@gandalf.local.home/
> 
> The eventfs files below "events" doesn't need the .permissions callback at
> all. It's only there because the "events" inode uses it.
> 
> The .permissions call for eventfs has:

It doesn't matter whether there's a ->permission handler. If you don't
add one explicitly the VFS will simply call generic_permission():

inode_permission()
-> do_inode_permission()
   {
        if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
                if (likely(inode->i_op->permission))
                        return inode->i_op->permission(idmap, inode, mask);
               
                /* This gets set once for the inode lifetime */
                spin_lock(&inode->i_lock);
                inode->i_opflags |= IOP_FASTPERM;
                spin_unlock(&inode->i_lock);
        }
        return generic_permission(idmap, inode, mask);
   }

> Anyway, the issue is with "events" directory and remounting, because like
> the tracefs system, the inode and dentry for "evnets" is created at boot
> up, before the mount happens. The VFS layer is going to check the
> permissions of its inode and dentry, which will be incorrect if the mount
> was mounted with a "gid" option.

The gid option has nothing to do with this and it is just handled fine
if you remove the second permission checking in (2).

You need to remove the inode_permission() code from
eventfs_start_creating(). It is just an internal lookup and the fact
that you have it in there allows userspace to break readdir on the
eventfs portions of tracefs as I've shown in the parts of the mail that
you cut off.

