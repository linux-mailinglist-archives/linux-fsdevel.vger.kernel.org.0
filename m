Return-Path: <linux-fsdevel+bounces-6893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE781DD87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 03:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A5281BF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 02:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79165A4C;
	Mon, 25 Dec 2023 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KL3gS0Gf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A67F3
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Dec 2023 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-111.bstnma.fios.verizon.net [173.48.113.111])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BP2Bavu001458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Dec 2023 21:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1703470298; bh=ZoLDlB95OTNVdOMk8s/9rf+Dyz28gb7U+ktJAR/PQkM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KL3gS0Gfd5cPnv3M7SPu/qs8MESQxpbPTU1FcQa6cTiUCmVQLYJBO+7Bmy2lil+Gb
	 PJQ3ozuaKsNC3Cy3EiZ3V/YgASZMF4hTdKOJwTxE+ONO3zVaA441/PGt7DUa8IyU/1
	 EX6IJH11cFDaQPiPRS+6yxVw/fFEGErL229tv2AXrNPhb6i+e7vKB9cJSnhKfH9Ks8
	 eyd0di60Uvi57B3dtThrW6aJCbFKngTGlvPm0otWC9Nemyr/vfnelAdGqEWb2NSEfd
	 2016N0ogmJ9Rv2VP+5sUPK32Lg9sdSfpVPEkZNu6qXkPZyAeAbOETcWgAVIQvFhDwC
	 ZYPcJ/mBi+D2A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 205D515C18E6; Sun, 24 Dec 2023 21:11:36 -0500 (EST)
Date: Sun, 24 Dec 2023 21:11:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
        syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yangerkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: fix WARNING in lock_two_nondirectories
Message-ID: <20231225021136.GC491196@mit.edu>
References: <000000000000e17185060c8caaad@google.com>
 <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
 <fb653ebf-0225-00b3-df05-6b685a727b41@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb653ebf-0225-00b3-df05-6b685a727b41@huawei.com>

On Mon, Dec 25, 2023 at 09:38:51AM +0800, Baokun Li wrote:
> Marking the boot loader inode as a bad inode here is useless,
> EXT4_IGET_BAD allows us to get a bad boot loader inode.
> In my opinion, it doesn't make sense to call lock_two_nondirectories()
> here to determine if the inode is a regular file or not, since the logic
> for dealing with non-regular files comes after the locking, so calling
> lock_two_inodes() directly here will suffice.

This is all very silly, and why I consider this sort of thing pure
syzkaller noise.  It really doesn't protect against any real threat,
and it encourages people to put all sorts of random crud in kernel
code, all in the name of trying to shut up syzbot.

If we *are* going to care about shutting up syzkaller, the right
approach is to simply add a check in swap_inode_boot_loader() which
causes it to call ext4_error() and declare the file system corrupted
if the bootloader inode is not a regular file, and then return
-EFSCORRUPTED.

We don't need to add random hacks to ext4_iget(), or in other places...

   	      	     	    	     - Ted

