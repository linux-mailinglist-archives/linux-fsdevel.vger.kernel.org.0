Return-Path: <linux-fsdevel+bounces-70300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DF4C962E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 09:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 901D434224F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 08:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2692E540D;
	Mon,  1 Dec 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ma4pymHX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256C33985;
	Mon,  1 Dec 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578004; cv=none; b=Vev3W1K4ZmshydQ/6ajhdVr5d2boSR64raLccpZMOaAao6ZY61Eundx15ynQ/wZmSbexiAHOxr8x+pQUkQN42DhNAa7T+YAKpwfRzkP5y7nulboa3SjN5ukpIjOGvaJ1jOw519YEYLmkja3yhCWXgph/gRHij2TM0MPxtuHlN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578004; c=relaxed/simple;
	bh=L5mjce6qPw0PbbEjYdWI1f5wdLvAI8HMV6A3Go2eKUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzmWheBWdDRLozJUd25N3qBZe7acV3lzEJZvowfshOU+evdINS+/bh8qcud4XwZd2+2I3xemIVDTJrl11Bh1BlSCsS9m1FF9uARUJOY0Fwmb06j12yeMHszihLVgTt5DguYhpnxJPi/emda2i/1e9q1kvvsHw7pMoWqrnJpZ3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ma4pymHX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L5mjce6qPw0PbbEjYdWI1f5wdLvAI8HMV6A3Go2eKUs=; b=Ma4pymHXG+uFsikMlgQ41ehlro
	lQwsWBtcJVhzrh3Q+NwxbL0UdaLunk+G29wL4vvICc6NH+If+Xz0k8+eHrCc9AzQoCx8u8GAY8kXa
	FtmzNPEWqIF0YwBtMbaToMS1lnoYK0nL6hs8y52LXzqLpPKvj0AaQHa0KBwqMg5s1BOCI3/J3w0S4
	goyBD3YkiaxvtfB0R+vk1PNIC22ft6ho0hh0Prf8atSODgt5s4UAINcBo/JQxgQUvVpOMWUsiOciq
	gF4mvmIo3UdYlD713kVNqX0q2b4ilQmRerEzHzTVX9NodmY1GjPqfju2LUPy4bV3Y9eU8GVSRi1A4
	q1gaccOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPzLY-0000000BhEv-1l7C;
	Mon, 01 Dec 2025 08:33:24 +0000
Date: Mon, 1 Dec 2025 08:33:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
	Val Packett <val@packett.cool>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to
 start_removing()
Message-ID: <20251201083324.GA3538@ZenIV>
References: <20251113002050.676694-1-neilb@ownmail.net>
 <20251113002050.676694-7-neilb@ownmail.net>
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
 <176454037897.634289.3566631742434963788@noble.neil.brown.name>
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 01, 2025 at 09:22:54AM +0100, Amir Goldstein wrote:

> I don't think there is a point in optimizing parallel dir operations
> with FUSE server cache invalidation, but maybe I am missing
> something.

The interesting part is the expected semantics of operation;
d_invalidate() side definitely doesn't need any of that cruft,
but I would really like to understand what that function
is supposed to do.

Miklos, could you post a brain dump on that?

