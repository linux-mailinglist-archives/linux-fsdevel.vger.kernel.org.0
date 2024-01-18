Return-Path: <linux-fsdevel+bounces-8225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478628311F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 04:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494BF1C21791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA96FD2;
	Thu, 18 Jan 2024 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPV2WCPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9F6104;
	Thu, 18 Jan 2024 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705550324; cv=none; b=qkp/fjYgSRanhrZ042SGwpne0Q4OCw7iTNk2Kf5C5y3VVdmY7vzmN+vsTiynzdYpcGWoRUZgpDnD5tKbxMm9jiTO/+4HvwDBUuvc21GO2iHqxqjXKiJ55Y9BiTjIynAqzP4PQlA7WvfiRp79nFskUMDsyO7ugPjdkbIJWFyUC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705550324; c=relaxed/simple;
	bh=OSo5PfdHNrhDXM3jaf4Kia103Tf7d+2XdB2eMho5tnk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=DF9sYvQbUui2NzUQahbkwm1X9p+koa0Gd2O2KZsPIyMEuqtH1uk09Ze/DfnCZnOQa+OIOb7Dw898+u7Ej1gUIMdOHbw/VIeflXK4LsZXsGZCGBSmjGN3i19h+P0re3LKBnX21/f+7gvtM/e2o0zjEUPvv3lfFkE/KJnkEMNPFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPV2WCPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79D1C433F1;
	Thu, 18 Jan 2024 03:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705550324;
	bh=OSo5PfdHNrhDXM3jaf4Kia103Tf7d+2XdB2eMho5tnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPV2WCPgVhKu1PyVjnU/7GII0F1EJE3futnmXCd213USbwVAinXpyKP0hVEdE8gmE
	 uSTSuikkGIqpZAR6KqEk13ok+ccKTXX+3kt3IQ+l2aabkIdnjSD9k1LXCvjaz1gHG0
	 WsgeRkpLze4GQP2mQPF+UqtioPVFTUjtCPRu3iTocMMuMTs0HpMkFF23bX2SRF8ACd
	 6R/awD2fKU+NknNmcIm+ylLvndXnWvlIgH1FczqrHwNvsWRT6ZjxTKL1pj0jYzT7mQ
	 NOMdApkmLRJDIhwEqMrim7wyx3UiP85E39jbIZLnXX2zqearAEOSOPotoIBCCPHji0
	 jsOy93iXDhxfA==
Date: Wed, 17 Jan 2024 19:58:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: syzbot <syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com>
Cc: chao@kernel.org, eadavis@qq.com, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 destroy_device_list
Message-ID: <20240118035842.GC1103@sol.localdomain>
References: <000000000000aac725060ed0b15c@google.com>
 <0000000000009fff64060ee0c1b7@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009fff64060ee0c1b7@google.com>

On Sat, Jan 13, 2024 at 08:59:04PM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 275dca4630c165edea9abe27113766bc1173f878
> Author: Eric Biggers <ebiggers@google.com>
> Date:   Wed Dec 27 17:14:28 2023 +0000
> 
>     f2fs: move release of block devices to after kill_block_super()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10639913e80000
> start commit:   052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12639913e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14639913e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=878a2a4af11180a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=a5e651ca75fa0260acd5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167b0f47e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11255313e80000
> 
> Reported-by: syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com
> Fixes: 275dca4630c1 ("f2fs: move release of block devices to after kill_block_super()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

#syz fix: f2fs: fix double free of f2fs_sb_info

