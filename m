Return-Path: <linux-fsdevel+bounces-6892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6594981DD81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 03:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BD4281B3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 02:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3510F1;
	Mon, 25 Dec 2023 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cpHNnWYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1877A3F;
	Mon, 25 Dec 2023 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qLSfK8xGb+CwMrv5+cInd/MERfnvryzHJSdWTD4BQdw=; b=cpHNnWYdyrhnmrYwlZaFDVgCQc
	SFWVWQPdScdhxcnwx/TZc0H45T4vULzyH0YAdAlhQtUIygJAX6F3mHOJJnA/GZMSMrKfK96CH4ieC
	nrjlY4fPjIOtOd8G+mkfIxQ7Bk5WVFDY4csqEIC3EgUBO9vr/tEKX7ubk3FcNj9xa4aNYicXENZq/
	Uiu9oVRTTKiwop2PaesMPSJ+QgS8B7HY5NgTdMfQY4881yhPoDBO/Kx42z9kcNIJ/3iNoTmid9x8j
	bO3Zo1LHcObEfaWerqMRxLdmFkfGhALv4UhRpBn5dlz9c+Jzgis+MXrVcShfJoP+uIIFa88gEGvQj
	+oSu5ndQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rHaNm-006WCg-0G;
	Mon, 25 Dec 2023 02:07:54 +0000
Date: Mon, 25 Dec 2023 02:07:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baokun Li <libaokun1@huawei.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu,
	yangerkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: fix WARNING in lock_two_nondirectories
Message-ID: <20231225020754.GE1674809@ZenIV>
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
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 25, 2023 at 09:38:51AM +0800, Baokun Li wrote:

> In my opinion, it doesn't make sense to call lock_two_nondirectories()
> here to determine if the inode is a regular file or not, since the logic
> for dealing with non-regular files comes after the locking, so calling
> lock_two_inodes() directly here will suffice.

No.  First of all, lock_two_inodes() is a mistake that is going to be
removed in the coming cycle.

What's more, why the hell do you need to lock *anything* to check the
inode type?  Inode type never changes, period.

Just take that check prior to lock_two_nondirectories() and be done with
that.

