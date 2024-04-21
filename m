Return-Path: <linux-fsdevel+bounces-17362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7348ABDD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Apr 2024 02:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A08281346
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Apr 2024 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06F1C33;
	Sun, 21 Apr 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XoKjUqkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6036C;
	Sun, 21 Apr 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713658898; cv=none; b=T6kGX6u04cHyQvoQIqO6yDBuBj4/oHtFXLFz0DNNr/T8J3p7ukDMTS++w8r/HMVBS5FRzInbPgT0OD80m47nC9YqQNhV++DYRw+DJj+GRrXfAihSrs27398nFv8qnOR2f0F/oj7DfvqUq8WzDP0JgBwr3pnc9A/mErH1/Ea/GRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713658898; c=relaxed/simple;
	bh=bWhEB44EU+xCR31GHSqW8y0nOZf3Pfvhbwo2n9eiZUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aye+fr8LtCWFQ8UqOXc2V/ftREHpFso6lZ95eUzbUczSO7Uw+bhEnNGFSIAn79bhisj0sjM16Z+E8odzrGnNcaqpFVKuluB11iTmiihWIRPKZtAvcAIxzVzhI3aw8i4EbQfuugOLE+VmVKQrmscFdEXL3V7jT/Y2MMXct+OG3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XoKjUqkb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cXdj4Y/fti/COs7xn/VBIILsxCDjiWFHrNpqQP0RP+U=; b=XoKjUqkbexemjpVQe9KdnickZD
	3kN3WplxDHu3+zlEcmP5J5Ono+lrmr6cMnOnkb7ItX5CKD9zcHN/Mxrq2qwEI/Jlm+ihBBqEOTUEI
	8Ru5oY/Lpq2rQKf7X8M7X4i8aAbb2bQFqi3UkXpDIKN8Ry75fssZ2wJKVn60rNq4OTt0rxnxyZarM
	ZOTQluByd+WvAmx2R/B/uiVZmoe8Hw1EHt0zbpCKRwpYy7ZP4sk8VPFDCcYk1+zaWO9hyCxouiSBP
	2REjEBr7WWjqt33Pfmd7wCfrfzUVJtAN9zowvkYiEtH7on3hrBGuNjU/gYmuVXEUEAurpoW0g2XbU
	byHd0ZZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ryKxV-0009aU-0g;
	Sun, 21 Apr 2024 00:21:29 +0000
Date: Sun, 21 Apr 2024 01:21:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+5ad5425056304cbce654@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] possible deadlock in ovl_nlink_start
Message-ID: <20240421002129.GF2118490@ZenIV>
References: <0000000000002615fd06166c7b16@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002615fd06166c7b16@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 18, 2024 at 10:37:18PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=106c9fa3180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
> dashboard link: https://syzkaller.appspot.com/bug?extid=5ad5425056304cbce654
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

Should be fixed in mainline since 72374d71c315

