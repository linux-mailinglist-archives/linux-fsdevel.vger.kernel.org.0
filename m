Return-Path: <linux-fsdevel+bounces-3965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED57FA7E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 18:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9585281843
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C1381B3;
	Mon, 27 Nov 2023 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gw1zVvuh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97939E1;
	Mon, 27 Nov 2023 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2Z43JYeJALNXrDXAND8tVgEUdl1r9pBa63R4laSFKqM=; b=gw1zVvuh8EL0p0oUze6hyvfNHv
	Q1k2kELI/tfU7FJvRftUSSYminTgjCUIyV8flY8/cy8AzeaDI/GwgLF8WBRC1sZ9Y9b2XP7Vj1Wz6
	5BEsDmiJxnj47A0QtB4nkww+jX4+7m1XfXiOD09D6LKlUsSVnEmB5quKvuFxWw6CQM2HKNsRXlJxh
	B1A8qX/Sd2t2K8HFLjkg1Vf22wP4cqc8vcVsK6y4yjiXrZxR8ouzDufbLmcs/7Zs8BqKvAoRLxukV
	7eXR8oTigPqum+b1duZbOcxp7xbIMEhx3+SNnHil8qVpPk4mqdnWFUcIZWwSRK8orVQl4ijuSQ7AD
	zTIiRkHg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7fMe-0044ay-0E;
	Mon, 27 Nov 2023 17:25:44 +0000
Date: Mon, 27 Nov 2023 17:25:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
Message-ID: <20231127172544.GJ38156@ZenIV>
References: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV>
 <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
 <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
 <878r6jnq1t.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r6jnq1t.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 27, 2023 at 10:01:34AM -0600, Eric W. Biederman wrote:
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> 
> > I am confused what is going on with ext4 and f2fs.  I think they
> > are calling d_invalidate when all they need to call is d_drop.
> 
> ext4 and f2f2 are buggy in how they call d_invalidate, if I am reading
> the code correctly.
> 
> d_invalidate calls detach_mounts.
> 
> detach_mounts relies on setting D_CANT_MOUNT on the top level dentry to
> prevent races with new mounts.
>
> ext4 and f2fs (in their case insensitive code) are calling d_invalidate
> before dont_mount has been called to set D_CANT_MOUNT.

Not really - note that the place where we check cant_mount() is under
the lock on the mountpoint's inode, so anything inside ->unlink() or
->rmdir() is indistinguishable from the places where we do dont_mount()
in vfs_{unlink,rmdir}.

