Return-Path: <linux-fsdevel+bounces-41421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DAFA2F4DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CEB3A96B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323B24FBFC;
	Mon, 10 Feb 2025 17:12:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F402451C3;
	Mon, 10 Feb 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207565; cv=none; b=XLH+BmBIaK1PH+2QPVeGCYocxunrYuE9pVtvV9b4LmaHJRqVsCwAeAOLqYFGzbrIQEurGVDV89kbU2cQWMvoGijohHK/Ol0DUw9JAx6y2ugZtOs0zOAhdQQPfeeuNOfp7mu1w+jExlALbn9KjPl2KMEh/rcAOm3Xk32QnbExtVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207565; c=relaxed/simple;
	bh=4u4Z8DwdSsBiBIG4c5Z2rgo6CiSyS0oIh0DsYtfR8IM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTGiL82tEVOADsKOoQw10uabJi0r2kr5rQFxVrlvC8YmCo80MfndM6uu4vwLWBTx9S9uQLoHKtZb7J1LgSfkjPhfQn6DfEflCjitbMMdsYS0X0yg1OMS9CDVrnfhuzm5qU6TOSCyk/gccotP4SWvIFER/i+yTknEjycwTtSyS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D2C4CED1;
	Mon, 10 Feb 2025 17:12:43 +0000 (UTC)
Date: Mon, 10 Feb 2025 12:12:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Reaver <me@davidreaver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle
 in debugfs API
Message-ID: <20250210121246.60b2efbf@gandalf.local.home>
In-Reply-To: <20250210170016.GD1977892@ZenIV>
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
	<86ldud3hqe.fsf@davidreaver.com>
	<20250210115313.69299472@gandalf.local.home>
	<20250210170016.GD1977892@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2025 17:00:16 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Mon, Feb 10, 2025 at 11:53:13AM -0500, Steven Rostedt wrote:
>=20
> > No it will not be fine. You should not be using dentry at all. I thought
> > this was going to convert debugfs over to kernfs. The debugfs_node shou=
ld
> > be using kernfs and completely eliminate the use of dentry. =20
>=20
> I disagree, actually - kernfs is an awful model for anything, sysfs inclu=
ded...

Then what would you suggest? It's the only generic system that is
appropriate for control features, where the underlining "files" are
actually functions to modify or query information from the kernel.

The entire VFS layer is designed for efficient management of some kind of
storage device, where the only interaction with the storage device is
through VFS.

For pseudo file systems like debugfs, sysfs and tracefs, the underlining
"storage" is the kernel itself, where we need a way for the "storage" part
to work with the kernel. The VFS layer doesn't give that, which is why
debugfs and tracefs used dentry as that interface, as the dentry does
represent the underlining storage.

=46rom what I understand (and Christian can correct me), is that kernfs was
created to be that interface of the "storage" connecting back to the
kernel. Where the VFS layer deals with the user accessing the file system
(read, write, mkdir, etc) but kernfs is the "data storage" that attaches
those call back to the kernel to retrieve kernel information or even modify
the kernel behavior.

-- Steve

