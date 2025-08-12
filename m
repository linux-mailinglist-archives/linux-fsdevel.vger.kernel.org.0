Return-Path: <linux-fsdevel+bounces-57513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44016B22B95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34DBD4E1DEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622C2F546B;
	Tue, 12 Aug 2025 15:23:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686032C85;
	Tue, 12 Aug 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012193; cv=none; b=uXNIjY+ZWXXzkpp6e+998FJVlzcFuaCHR7WvnyKH4/Ri957h5swyUT9UZLV5venkGJ3efoFeHQz844JjiSiC2uQ+q9DMwLvk6qfu+b2DojW24uTtxur/LXFYhVykLf6wwbZSmMbL35lzaXqr9RK+jBZxWI8TjP29T45Hbu1ialM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012193; c=relaxed/simple;
	bh=DaD/bMbY4cIGKaK6YNIyTRnx6li4wlPKjN/F+3bF/bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOplg0MJduENyYiGhVAJKTUFjXwbjlISPyhCEIBd9/I9EChzQ5bUZSfUuCCez0c+v4oUFr3ofUSvWlGsIOz+qfwAk5iE/yClHNumZM9FCC0LwI20qEtHuacecVCSKYs5i2mNEVqKzpmXbB8+fKjKyJjREqQ2lbedvUYwcC8Cc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57CFMt6r003862;
	Wed, 13 Aug 2025 00:22:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57CFMtEe003859
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Aug 2025 00:22:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <370cbc89-721c-46aa-9f6e-1681f5d04e99@I-love.SAKURA.ne.jp>
Date: Wed, 13 Aug 2025 00:22:55 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfs: show filesystem name at dump_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Mateusz Guzik <mjguzik@gmail.com>
References: <ceaf4021-65cc-422e-9d0e-6afa18dd8276@I-love.SAKURA.ne.jp>
 <20250811-bahnhof-paare-593afaae19b5@brauner>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250811-bahnhof-paare-593afaae19b5@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp

On 2025/08/11 22:51, Christian Brauner wrote:
> On Mon, 11 Aug 2025 15:50:28 +0900, Tetsuo Handa wrote:
>> Commit 8b17e540969a ("vfs: add initial support for CONFIG_DEBUG_VFS") added
>> dump_inode(), but dump_inode() currently reports only raw pointer address.
>> Comment says that adding a proper inode dumping routine is a TODO.
>>
>> However, syzkaller concurrently tests multiple filesystems, and several
>> filesystems started calling dump_inode() due to hitting VFS_BUG_ON_INODE()
>> added by commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
>> before a proper inode dumping routine is implemented.
>>
>> [...]
> 
> Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.18.misc branch should appear in linux-next soon.

It would be nice if we can get this patch merged into linux.git in 2 weeks, for
https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d is hitting on more
filesystems where a reproducer is not yet available.

> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.18.misc
> 
> [1/1] vfs: show filesystem name at dump_inode()
>       https://git.kernel.org/vfs/vfs/c/ecb060536446


