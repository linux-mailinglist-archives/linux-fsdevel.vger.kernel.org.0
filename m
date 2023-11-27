Return-Path: <linux-fsdevel+bounces-3971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEACE7FA8F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71828B21284
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC83DB97;
	Mon, 27 Nov 2023 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DjqTlj+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD3A198;
	Mon, 27 Nov 2023 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CqEzkt+oM2IBi7Kij86HZ2Ewj2l3h5pTUsWNsGVn/48=; b=DjqTlj+sgml0PJUhtui5FC3/wG
	wto1Q+ju6Bcqb5B+RH+X1NFFOpS8PWOJBjt9VUrwIIIKPkoHheM1jehn05BfUoGX8pAW5vM5KAV95
	xWvKYhbdYx/B6LU/XhYT+1VHWuxzb+kQLowLtwtNrnOeZmqB1Kbk0ClkWwea1WRzPNQt9pxwv4ztl
	6JYn4ZwxRZNuj6Ju2JFwkpaiRLsNaAXpvE2BhvLEGcbnU6uLAafpKDXmMsuGDKmu7jboPysvlUJTM
	KXgAzeRV+EX9JFvhCHR+GupMNOhECBakw2NKaZUIEHFGXW38cVx8DNMsOKuq0PUmVzrp9YlJOW3o4
	T1sjZwLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7gJ9-0045ma-2o;
	Mon, 27 Nov 2023 18:26:11 +0000
Date: Mon, 27 Nov 2023 18:26:11 +0000
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
Message-ID: <20231127182611.GA973514@ZenIV>
References: <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV>
 <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
 <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
 <878r6jnq1t.fsf@email.froward.int.ebiederm.org>
 <20231127172544.GJ38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127172544.GJ38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 27, 2023 at 05:25:44PM +0000, Al Viro wrote:
> On Mon, Nov 27, 2023 at 10:01:34AM -0600, Eric W. Biederman wrote:
> > "Eric W. Biederman" <ebiederm@xmission.com> writes:
> > 
> > > I am confused what is going on with ext4 and f2fs.  I think they
> > > are calling d_invalidate when all they need to call is d_drop.
> > 
> > ext4 and f2f2 are buggy in how they call d_invalidate, if I am reading
> > the code correctly.
> > 
> > d_invalidate calls detach_mounts.
> > 
> > detach_mounts relies on setting D_CANT_MOUNT on the top level dentry to
> > prevent races with new mounts.
> >
> > ext4 and f2fs (in their case insensitive code) are calling d_invalidate
> > before dont_mount has been called to set D_CANT_MOUNT.
> 
> Not really - note that the place where we check cant_mount() is under
> the lock on the mountpoint's inode, so anything inside ->unlink() or
> ->rmdir() is indistinguishable from the places where we do dont_mount()
> in vfs_{unlink,rmdir}.

Said that, we could simply use d_drop() in those, since the caller will
take care of mount eviction - we have ->unlink() or ->rmdir() returning
success, after all.

The same goes for xfs caller and for cifs_prime_dcache() (in the latter
case we have just checked that they sucker is negative, so d_invalidate()
and d_drop() are doing the same thing).

