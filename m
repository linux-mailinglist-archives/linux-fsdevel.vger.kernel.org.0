Return-Path: <linux-fsdevel+bounces-31277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A65993EA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 08:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48871C21722
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072A178CEC;
	Tue,  8 Oct 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzGAxsUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22E1779B8;
	Tue,  8 Oct 2024 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368307; cv=none; b=Aj40RzAnbWmOVzdbeGwj9Gj+Toc6re7z7mmQWqfMuvegihYHI9ENvbKo6bVEPhq+tM9Q/MzkLylN5FsFxRZPto9rupgSi6iw0qY/joIsIWz8ZOuhaxo2umSEm4clQTzgkTeWTPX3qlBkx9YiiooRUeUNU2VvL1qOi1sX+0EFV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368307; c=relaxed/simple;
	bh=n10ylxYJNCTo9eFTFVFmOaP6y9TdnURNNxWzpNeUPw4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hGUJCwwb1AnXzDZE5hwmGg88ownQEVGQDfMZsh1r0eWSdbs/Pw1AOmVv8kwPthkQGCXqtbcbdHqY1Yt5/83AoKbc1daQGzOfbFG87L3hIw4YtkWooffSb95WK3PjkDkqnvTzdiihbOSxt0znncGHQo8SzSYBMsoJY0eAi2rJdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzGAxsUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B38C4CEC7;
	Tue,  8 Oct 2024 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728368306;
	bh=n10ylxYJNCTo9eFTFVFmOaP6y9TdnURNNxWzpNeUPw4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JzGAxsUb/XABKxtvpycH88Iibs8xM2fmpQ2VGo7tUgHPaYHNywj6s6RVGXnnYY918
	 P6H3cNk7OSmZYwB2QQa4OAlQOR0F5vyw3+EB6/lsrhlB41Gz7ydEKmGoRS1ycgWEnR
	 5BDODZ6V2/+UwZrsRy2r1iegqj7jp+aUkjpKtduroiJBm1Mw4NvX6Iz73XpcudIA8X
	 oTa5gz8mJzBr6DIBNFbFMdleeVNHQx0QqYK2O4j4K6jNAQQaRNp9Q3E91pZPZJB92G
	 wCAjCzTt8wYgi3Jgai1oGd0aPi7LfBec+PVOdrK3tpzNnvCv7bwzJ5LcMbQhl3LemH
	 N1JYGU6th3Ycw==
Message-ID: <cab577ea-c84b-4450-af6f-62ab99ac937f@kernel.org>
Date: Tue, 8 Oct 2024 14:18:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend
To: syzbot <syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com>,
 aha310510@gmail.com, akpm@linux-foundation.org, brauner@kernel.org,
 jack@suse.cz, jlayton@kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
References: <66f774b7.050a0220.46d20.002d.GAE@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <66f774b7.050a0220.46d20.002d.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz fix: hfsplus: fix to avoid false alarm of circular locking

On 2024/9/28 11:15, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit be4edd1642ee205ed7bbf66edc0453b1be1fb8d7
> Author: Chao Yu <chao@kernel.org>
> Date:   Fri Jun 7 14:23:04 2024 +0000
> 
>      hfsplus: fix to avoid false alarm of circular locking
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c5f59f980000
> start commit:   90d35da658da Linux 6.8-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=70429b75d4a1a401
> dashboard link: https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159253ee180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11afd4fe180000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: hfsplus: fix to avoid false alarm of circular locking
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


