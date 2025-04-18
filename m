Return-Path: <linux-fsdevel+bounces-46656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4A3A92FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 04:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF70B463552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E0267AF6;
	Fri, 18 Apr 2025 02:16:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098317C219;
	Fri, 18 Apr 2025 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942614; cv=none; b=iJH8Lbn3aaGwQfKTXldF/tY6a35PH5oHcmi1LAdhAH5NOlp/D1qirSFyQgDdyrOX0k9BualJYQ3I/2FNuw36JQYL1w/oT2szX6+LRPrFL8u8IjpSPp+9m15ByV/K+otiv/zoWeJIhowgihT7NHRf50KGF0nJQhkzd4VhNTkX45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942614; c=relaxed/simple;
	bh=mpFODXewOSDNToCIx+5qjNqFN/3KbaoAHaGvqH2r9N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn96h1Jqf/dGjQu3APM8a2VmC5WB1UZNcRo52VCAJz9iYsZyBv1cZuVMs3llcbN+8iHKTgyBHrXdZaLzsQSpnzXB2BceyL3Qk9BevCP5vDmEuPrbXbJuproruwdwVnSB1E51Zd4i12ilhWZf6IPzqFFlxWdrbWgWqJua4UfVWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: izesmtp89t1744942503tc4337595
X-QQ-Originating-IP: s099qD1/wQF3alPzthzju4wTZCLn/eMwQtkZ1Q6DDxw=
Received: from [127.0.0.1] ( [116.234.96.50])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Apr 2025 10:15:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8631517172657761697
Message-ID: <3A9139D5CD543962+89831381-31b9-4392-87ec-a84a5b3507d8@radxa.com>
Date: Fri, 18 Apr 2025 10:15:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] anon_inode: use a proper mode internally
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Mateusz Guzik <mjguzik@gmail.com>,
 Penglei Jiang <superman.xpt@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>,
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
From: Xilin Wu <sophon@radxa.com>
Content-Language: en-US
In-Reply-To: <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4pRUvj8JJ3mGvWUbcly9G9yuqRiCK1NsyRTWGFSgLYGH3WHhGOgvfuW
	8cg6areGxuBvILhdLfetWcjenNXSJk6Wca6YbY2o24aTtm67HeQQlU/c4rn+ivCcaccMrL3
	5dn2bDDEZ5NmqQFJK2xnoyjsysCczj6JS+9dwWnFkw678Xo9dNZ8NO5T5cWytTzJrwvRQzW
	q3FkdY8LL6bHQDw+0jcVQxfCJqf/sapzu8YtfEb3AYDkFBE2E8/4fW+SDP5kaeqNnuJVE49
	p91QUeahSa0UkCrJ3C2nXSXQzwD8UHsOZjuFjdVsKq/rCZGRvut/8WepLlUKqM9/1xArFq/
	4HnZaimXD5sVfa0HadNaAahpcEZZPkV1WY1VqEJ9vrS207kYaA1lDdODKs7cHj/f7XfU9Fw
	6WrwLLH9V4YHwongFEIuo/Cm9StjazsBFDLfPRblb7QbcPRC2cB/4smCdHsgYRbGmMAcZDQ
	W6ajj4JOyS8nIRswvbLSXIHUbvXkVa6wltxRN/NZxisAEHD4I5FiDO6WDYU9ndmDSd93DUr
	bAlEB5eInVJkFUx2cOgZ32HniXyuo+eXo3E4iVweyIZ9oyfFe+llS9/qXX/cOLn4XGVzsTw
	WLBHja1SxnhRS6Ek+QhbNa27oQQ7PA5DJ+vD6zwHHkf1tX+9EM7DGTbCmvo/o81TcRqRoYB
	sl8qg1yPkO92Mj0uGOT8k/81hONRURrglPWcO5WEr8fOf17OBnCW18e+m9BQNqPVg/3sXFx
	eZb4b44O3x6G0shh/an9xBrc1MTnKfpD7i7Yh6r4Fo++i2wAIgQxGfrGKvf3LdG/pwPDp7n
	HGRJUrTePQV6vckAV/MW+ptJ7dfh81att7juZV62MJXHxsWkWu2toSCLrQQcmJfwaVHjB7d
	t1gOk1msHS+GKuQWabJWxY7GGqRbf9T0MAfjKq7R72P24mGAu2r8vaBfAEtV611eR3/SaHH
	l2pdRHHlnQm/6S7YAmmq9QvfL
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On 2025/4/7 17:54:15, Christian Brauner wrote:
> This allows the VFS to not trip over anonymous inodes and we can add
> asserts based on the mode into the vfs. When we report it to userspace
> we can simply hide the mode to avoid regressions. I've audited all
> direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> and i_op inode operations but it already uses a regular file.
> 
> Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
> Cc: <stable@vger.kernel.org> # all LTS kernels
> Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Hi Christian and FSdevel list,

I'm reporting a regression introduced in the linux-next tree, which I've 
tracked down using `git bisect` to this commit.

Starting with `linux-next` tag `next-20250408` (up to the latest 
`next-20250417` I tested), attempting to start an SDDM Wayland session 
(using KDE Plasma's KWin) results in a black screen. The `kwin_wayland` 
and `sddm-helper-start-wayland` processes both enter a state consuming 
100% CPU on a single core indefinitely, preventing the login screen from 
appearing. The last known good kernel is `next-20250407`.

Using `strace` on the `kwin_wayland` process revealed it's stuck in a 
tight loop involving `ppoll` and `ioctl`:

```
ioctl(29, FIONREAD, [0])                = 0
ppoll([{fd=10, events=POLLIN}, {fd=37, events=POLLIN}, {fd=9, 
events=POLLIN}, {fd=5, events=POLLIN}, {fd=29, events=POLLIN}, {fd=17, 
events=POLLIN}, {fd=3, events=POLLIN}], 7, NULL, NULL, 8) = 1 ([{fd=29, 
revents=POLLIN}])
ioctl(29, FIONREAD, [0])                = 0
ppoll([{fd=10, events=POLLIN}, {fd=37, events=POLLIN}, {fd=9, 
events=POLLIN}, {fd=5, events=POLLIN}, {fd=29, events=POLLIN}, {fd=17, 
events=POLLIN}, {fd=3, events=POLLIN}], 7, NULL, NULL, 8) = 1 ([{fd=29, 
revents=POLLIN}])
# ... this repeats indefinitely at high frequency
```

Initially, I suspected a DRM issue, but checking the file descriptor 
confirmed it's an `inotify` instance:

```
$ sudo ls -l /proc/<kwin_pid>/fd/29
lr-x------ 1 sddm sddm 64 Apr 17 14:03 /proc/<kwin_pid>/fd/29 -> 
anon_inode:inotify
```

Reverting this commit resolves the issue, allowing SDDM and KWin Wayland 
to start normally.

Could you please take a look at this? Let me know if you need any 
further information or testing from my side.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>

