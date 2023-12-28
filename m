Return-Path: <linux-fsdevel+bounces-6997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02A681F70F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849411F2280F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2A96FA2;
	Thu, 28 Dec 2023 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rU23jokB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5A6AA4;
	Thu, 28 Dec 2023 10:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D88C433C7;
	Thu, 28 Dec 2023 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703760639;
	bh=BPxPOKTaZnluFeSzgfExNeB7kZWJYat+UJLHwDn2Rig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rU23jokBsrTIsxPfYmNIo9Xnj10xyocVaTrcpX7nEltRKTr9sMmIM31539OQOErIB
	 wO+EI/Dce0SrS+TxgxagIadHeq/btyUM2L+r8H6fEZ/QXeBYe3GjB+ddI7ky/zdFpu
	 Jbww5cKdCaPPzkFsrvcoteN2n2cntNKgN+lFQv8GHWelw6dM65ZJJAg9Y5AydqbxG6
	 AuiZhSW1ZKkZa5dc6cjkyyzWDqSPHv2/W4TMSgg73kHZ4YUkw/nG5BrvE22SX05hbz
	 kEUVX9gV0khXZsUJ+czZTzndgCJ6ysMkFwXN6KOspnN8ujArhc6D4iLx2p+u3PT/zu
	 Pi9T8etG2rnDA==
Date: Thu, 28 Dec 2023 11:50:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, chao@kernel.org, christian@brauner.io,
	daniel.vetter@ffwll.ch, hch@lst.de, hdanton@sina.com, jack@suse.cz,
	jaegeuk@kernel.org, jinpu.wang@ionos.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, mcanal@igalia.com,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	terrelln@fb.com, willy@infradead.org, yukuai3@huawei.com
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
Message-ID: <20231228-arterien-nachmachen-d74aec52820e@brauner>
References: <0000000000001825ce06047bf2a6@google.com>
 <00000000000007d6a9060d441adc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000007d6a9060d441adc@google.com>

On Sun, Dec 24, 2023 at 08:40:05AM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit fd1464105cb37a3b50a72c1d2902e97a71950af8
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Oct 18 15:29:24 2023 +0000
> 
>     fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14639595e80000
> start commit:   2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
> dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107e9518680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Fwiw, this was always a false-positive. But we also reworked the locking
that even the false-positive cannot be triggered anymore. So yay!

