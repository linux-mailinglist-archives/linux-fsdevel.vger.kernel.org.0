Return-Path: <linux-fsdevel+bounces-31951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5B99E276
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F1A1F21C37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F151EABC1;
	Tue, 15 Oct 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rCl6tHSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC551E8833;
	Tue, 15 Oct 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983454; cv=none; b=QnRofdlP5fr4bPX35p/DsJRAa1ABu1LdATfgqiO4fQ4YMcalMmg3GDKVShZHIi+djhxzfhBjiq9SvxP97My9V2SKhAZeH1TX3T3XS/tQ8kQxejmVixRosDP8Tdi8ASH7L5VZMPAbuMdioQ8l0WyD1m8q3nFtXazJ+d9a2zI+xQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983454; c=relaxed/simple;
	bh=8xehucyXkfFfHp6IAPa2xOvlPkm5n/BEyTygnCKw0b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r+OTQCkhSCEeo8lh0jm2SY3BemEkADru8ig4UnDzBgva6Hf6q+KkE5aQqkjdGaoNRZNj/1Oni6vLobM89lgg0w0nXYEMUKEAv/pQw45HlSGixXBvcUJm+p09XNX3W5EsNWFyig1bT4GwNp/O6FVjSUufcHGz984uyj+5CmSn2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rCl6tHSh; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728983448; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h5D/bFMKCf9XcwyqPiJ32DXbOFzCGsMRYuzWv6PI5jA=;
	b=rCl6tHShAPVKzFXuNZ1rJehpV6vGG/CY05/eTDh58fYqriNbPTfEGzQhhpkAjeb34hVY8C1xI8VD4lUCLRWx8RlerXopTX9ohoEnjAsA3GIErw+408Y1sR3C2fWUavJTIPsOWePEwGbTJIonLl85ldRWz976LMj2Fl+8xd3AGlw=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHD3S.B_1728983446 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 17:10:47 +0800
Message-ID: <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
Date: Tue, 15 Oct 2024 17:10:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
To: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>,
 brauner@kernel.org, chao@kernel.org, dhavale@google.com, djwong@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/10/15 17:03, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d61a00525464 Add linux-next specific files for 20241011
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=175a3b27980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8554528c7f4bf3fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1513b840580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1313b840580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f615720e9964/disk-d61a0052.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c4a45c7583c6/vmlinux-d61a0052.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d767ab86d0d0/bzImage-d61a0052.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/fce276498eea/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 56bd565ea59192bbc7d5bbcea155e861a20393f4
> Author: Gao Xiang <hsiangkao@linux.alibaba.com>
> Date:   Thu Oct 10 09:04:20 2024 +0000
> 
>      erofs: get rid of kaddr in `struct z_erofs_maprecorder`

I will look into that, but it seems it's just a trivial cleanup,
not quite sure what happens here...

Thanks,
Gao Xiang


