Return-Path: <linux-fsdevel+bounces-9123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B237683E547
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687E11F245D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8842E3E4;
	Fri, 26 Jan 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6o8451m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10625636;
	Fri, 26 Jan 2024 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307817; cv=none; b=O0uQ7W0smMiiF3ATjH3TjUh/OFTF0fNn3BPeLmGrZMhPQe69JM0OmTvQqqaS9O1uEi23SWlFoGjJTsqgvE90OLKdTX4d8FR+mhf9zydoKMlXrd9xAvgyDWm/09hdjVhw+4/zyKfF0PwnO8UHLmUfYISEzsa7H0yX00s88SkKCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307817; c=relaxed/simple;
	bh=3a2frhHXQISxXY9oeFM5r0zBXGcl8B7EtAddIILkH4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPDSPOqWQ9WhzpukX8uLzl0iAcEnP2bZ0RVWjhkLPhImlTmSJ7tsua4WgepTK33mARRLcItqS+NKLEgj/jH9JfBRFD2by6LyWH5SwmGl90X2qRuIZ6NIy5Ss+vhAhzvNyFYlXqWjeLWKyrecJRhDieRgQ1dosDcqZCjWr7KsaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6o8451m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B18FC433F1;
	Fri, 26 Jan 2024 22:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706307816;
	bh=3a2frhHXQISxXY9oeFM5r0zBXGcl8B7EtAddIILkH4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q6o8451mPfBNpAwvrn79DeNRGR+zTb2WftPR95DqiosCUYNIl3w5CyDYjVQqde6iV
	 b+K/NwDoxy8vnIwJy+WUArN85m6BXH1RZGNmmmR4hv4OoqG5AETTPbqe8naIBkO5oV
	 iRl5er9RVSTPwXKOTxVn8yGM7yaSyb4NkElZ0cgpawI0osKPsOlf7pDt5M5cMbutyS
	 nNopJCUXxXoSRuhz4+Yb7GQDciAGQ7AR3Vt2gi4azmxWW+u4yBmD/9aMvFPdBGsQAW
	 u5qcIsO3YzLOj5R8y6FUkwWzVSpSFJwolST8eJHhec1/pRN7pzHnL5+PbQu2P7whji
	 KBn4u0kn8BQFA==
Date: Fri, 26 Jan 2024 14:23:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: syzkaller-bugs@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+d99d2414db66171fccbb@syzkaller.appspotmail.com>,
 asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 netdev@vger.kernel.org, v9fs@lists.linux.dev
Subject: Re: [syzbot] [net?] [v9fs?] WARNING: refcount bug in p9_req_put (3)
Message-ID: <20240126142335.6a01b39f@kernel.org>
In-Reply-To: <000000000000ee5c6c060fd59890@google.com>
References: <000000000000ee5c6c060fd59890@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 01:05:28 -0800 syzbot wrote:
> HEAD commit:    4fbbed787267 Merge tag 'timers-core-2024-01-21' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11bfbdc7e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4059ab9bf06b6ceb
> dashboard link: https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386

Hi Aleksandr,

we did add a X:	net/9p entry to MAINTAINERS back in November [1]
but looks like 9p still gets counted as networking. Is it going
to peter out over time or something's not parsing things right?

[1]
https://lore.kernel.org/all/CANp29Y77rtNrUgQA9HKcB3=bt8FrhbqUSnbZJi3_OGmTpSda6A@mail.gmail.com/

