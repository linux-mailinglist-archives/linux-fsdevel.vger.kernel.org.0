Return-Path: <linux-fsdevel+bounces-6897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8AE81DDA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 03:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A395281D36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 02:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A387A1848;
	Mon, 25 Dec 2023 02:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ersVXDjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3815B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Dec 2023 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-111.bstnma.fios.verizon.net [173.48.113.111])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BP2n6wB016557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Dec 2023 21:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1703472549; bh=OdpFpqqpJ89dj3MYT6e+L3YmSv6NrIhp5NNwXxiXfpI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ersVXDjSrH6gZn90dOHWFqQOl4XSj93gjAOQ43HaEgbw8F2nMBnX39IR1oj6frqun
	 p61Zmw0KLT7bINJtuKHp1H136TBDdKc7Xe5RGEYxByfzmDNsNv8Vr6zo2RExIQeV0+
	 A2Oq+RfEZ1+L8mINKsYx3XVjP1iZSnWk1NZ0SpOKkXwJetRBXiWDpD7Jmkzv9Q8tgJ
	 jvQVp+h/J8UFe4QdgeypF7Nz8BLP2aeERtGkp7k9MKFnyQdBnOIf5+3FP0j48UhKtE
	 +po+W6Y+9oD8htGFwXCicrv98Y4jnaxFYX8xWH4Y6J40rG78h7QCyrcBnXeUn1INUK
	 4nIUtm8fOpZ8g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C35A115C18E6; Sun, 24 Dec 2023 21:49:06 -0500 (EST)
Date: Sun, 24 Dec 2023 21:49:06 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Edward Adam Davis <eadavis@qq.com>,
        syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yangerkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: fix WARNING in lock_two_nondirectories
Message-ID: <20231225024906.GD491196@mit.edu>
References: <000000000000e17185060c8caaad@google.com>
 <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
 <fb653ebf-0225-00b3-df05-6b685a727b41@huawei.com>
 <20231225020754.GE1674809@ZenIV>
 <a4d6ca25-cb8d-f3f9-ed4e-3a55378fdfde@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d6ca25-cb8d-f3f9-ed4e-3a55378fdfde@huawei.com>

On Mon, Dec 25, 2023 at 10:33:20AM +0800, Baokun Li wrote:
> Since in the current logic we update the boot loader file via
> swap_inode_boot_loader(), however the boot loader inode on disk
> may be uninitialized and may be garbage data, so we allow to get a
> bad boot loader inode and then initialize it and swap it with the boot
> loader file to be set.
> When reinitializing the bad boot loader inode, something like an
> inode type conversion may occur.

Yes, but the boot laoder inode is *either* all zeros, or a regular
file.  If it's a directory, then it's a malicious syzbot trying to
mess with our minds.

Aside from the warning, it's pretty harmless, but it will very likely
result in a corrupted file system --- but the file system was
corrupted in the first place.  So who cares?

Just check to make sure that i_mode is either 0, or regular file, and
return EFSCORRUPTEd, and we're done.

   	     		      	  	 	       - Ted

