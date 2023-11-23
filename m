Return-Path: <linux-fsdevel+bounces-3562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84AD7F6848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 21:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BD9281553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 20:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE04D595;
	Thu, 23 Nov 2023 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KlzKBGwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D9A5;
	Thu, 23 Nov 2023 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D6eauRCleakOAVXg1WO7OewoZlBriSXWxKFLHPSQ66o=; b=KlzKBGwYHxj3Y3yyDacRn2/fO1
	TOvCft6vyHXIu0droOUNqzblCUjjn9o2GTgoOp9ZQzMWXecL6CZVcXI882xS02OWO3hGui0W27vV0
	D3g1HJzDL3O75gbBTgqtURXNPCL3TAuThQmOdEh9pP5IjplRQpCvz7Tur9njCPspxS5kV1JtC6ctk
	E/cbLSwgG5XgceBPvIL3TSeCcbZIe2JpLRliQAcGVV4jWkDu9yB52mr3JV+w+CDsgPlqRg+w7e4oK
	3B2epbPIer5J1mlyxx2JWkXKptokJw20BrHE+iWi7u3KWDpLI0Rj1boTvY2Qr0B5ua1AyCFwRZmeD
	wowHHMiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6G6V-002Eoh-1K;
	Thu, 23 Nov 2023 20:15:15 +0000
Date: Thu, 23 Nov 2023 20:15:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231123201515.GA532258@ZenIV>
References: <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <87bkbki91c.fsf@>
 <20231123195327.GP38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123195327.GP38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 23, 2023 at 07:53:27PM +0000, Al Viro wrote:

> Huh?  If it really depends only upon the superblock, just set it in ->s_d_op
> when you set the superblock up.
> 
> Again, whatever setup you do for dentry in ->lookup(), you either
> 	* have a filesystem that never picks an existing directory alias
> (e.g. doesn't allow open-by-fhandle or has a very unusual implementation
> of related methods, like e.g. shmem), or
> 	* have that setup misplaced, in part that applies to all dentries out
> there (->s_d_op for universal ->d_op value, ->d_init() for uniform allocation
> of objects hanging from ->d_fsdata and other things like that), or
> 	* need to figure out how to transfer the result to alias (manually
> after d_splice_alias(), if races do not matter or using a new method explicitly
> for that), or
> 	* lose that state for aliases.

Note, BTW, that fscrypt tries to be very special in its handling of that
stuff - see fscrypt_handle_d_move() thing and comments in front of its
definition.  Then take a look at the place where it's called.

BTW, it looks like it's broken, since it discounts the possibility of splice
caused by lookup on no-key name.  You get DCACHE_NOKEY_NAME removed unconditionally
there, no-key or not.

It's not impossible that the boilerplate around the fscrypt_has_permitted_context()
calls in fscrypt-enabled ->lookup() instances somehow prevents those, but if so,
it's not obvious from the causual look.

