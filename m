Return-Path: <linux-fsdevel+bounces-29956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D1C98421B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8302E1C235F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8B156C69;
	Tue, 24 Sep 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tg0EgChg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DE15539D;
	Tue, 24 Sep 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170167; cv=none; b=NdQNeIWmBFqgXeegqRsTZc6xCtA3AyfegvIsYrxw8zGzg4XkDqd+FXi6Gzcq5sz70yyWrujClFhqqQz8/KXCniwl29hL0LC3d5kVYath1ATLZjJ/L4pIYpKRyXUxJ/N36S6lmnjwBiyXT0iRXgFBkYXkYizjE69S0rAqmjTA/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170167; c=relaxed/simple;
	bh=soJbgbX3ZDlR5f00um1NIyMWVjQPDYzwquAN4p+TCc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrF/LmGYE0GWxygFJEgo3Dc1BU7edj+ZGHzEJo+2SHrDthTg4S7EAPiSCl2xJAhpjnyUMMqfnRHmiA2zFOP4LxpdIASIBfLg0hvMGha9A8ZyBuWj/mVYM5skWAMjYJdRz61zlOazVm8XHpuGGiL8sZ/6w8evMYUjYyGAXsxwXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tg0EgChg; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727170155; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TYPCTrP9ZTx3OP31Ms8q/MZw7Vr2s+RTwZ353YzEMbk=;
	b=Tg0EgChgG7uxqSnyEDUQwOL0YRIdN5Vtq6ADM0yx3OcJePhn0adnfg1YT/4Omd84oMdTu6NxyjGMaF4kQSyZ/UPJqn4x95wB4QVor0GZHB0eiBNd5gg34JK8erKKpamfRkQ6DWubdN2Km87BbAjRRcAKMvCBIMfhyHQMoV+NgPw=
Received: from 30.221.130.48(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFfii39_1727170154)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 17:29:15 +0800
Message-ID: <34e86448-65fa-447d-b5d9-1897b2a53ff6@linux.alibaba.com>
Date: Tue, 24 Sep 2024 17:29:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Geert,

On 2024/9/24 17:21, Geert Uytterhoeven wrote:
> Hi Gao,
> 
> CC vfs
> 
> On Fri, Aug 30, 2024 at 5:29 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> It actually has been around for years: For containers and other sandbox
>> use cases, there will be thousands (and even more) of authenticated
>> (sub)images running on the same host, unlike OS images.
>>
>> Of course, all scenarios can use the same EROFS on-disk format, but
>> bdev-backed mounts just work well for OS images since golden data is
>> dumped into real block devices.  However, it's somewhat hard for
>> container runtimes to manage and isolate so many unnecessary virtual
>> block devices safely and efficiently [1]: they just look like a burden
>> to orchestrators and file-backed mounts are preferred indeed.  There
>> were already enough attempts such as Incremental FS, the original
>> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
>> for current EROFS users, ComposeFS, containerd and Android APEXs will
>> be directly benefited from it.
>>
>> On the other hand, previous experimental feature "erofs over fscache"
>> was once also intended to provide a similar solution (inspired by
>> Incremental FS discussion [2]), but the following facts show file-backed
>> mounts will be a better approach:
>>   - Fscache infrastructure has recently been moved into new Netfslib
>>     which is an unexpected dependency to EROFS really, although it
>>     originally claims "it could be used for caching other things such as
>>     ISO9660 filesystems too." [3]
>>
>>   - It takes an unexpectedly long time to upstream Fscache/Cachefiles
>>     enhancements.  For example, the failover feature took more than
>>     one year, and the deamonless feature is still far behind now;
>>
>>   - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
>>     perfectly supersede "erofs over fscache" in a simpler way since
>>     developers (mainly containerd folks) could leverage their existing
>>     caching mechanism entirely in userspace instead of strictly following
>>     the predefined in-kernel caching tree hierarchy.
>>
>> After "fanotify pre-content hooks" lands upstream to provide the same
>> functionality, "erofs over fscache" will be removed then (as an EROFS
>> internal improvement and EROFS will not have to bother with on-demand
>> fetching and/or caching improvements anymore.)
>>
>> [1] https://github.com/containers/storage/pull/2039
>> [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
>> [3] https://docs.kernel.org/filesystems/caching/fscache.html
>> [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
>>
>> Closes: https://github.com/containers/composefs/issues/144
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks for your patch, which is now commit fb176750266a3d7f
> ("erofs: add file-backed mount support").
> 
>> ---
>> v2:
>>   - should use kill_anon_super();
>>   - add O_LARGEFILE to support large files.
>>
>>   fs/erofs/Kconfig    | 17 ++++++++++
>>   fs/erofs/data.c     | 35 ++++++++++++---------
>>   fs/erofs/inode.c    |  5 ++-
>>   fs/erofs/internal.h | 11 +++++--
>>   fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
>>   5 files changed, 100 insertions(+), 44 deletions(-)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index 7dcdce660cac..1428d0530e1c 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
>>
>>            If you are not using a security module, say N.
>>
>> +config EROFS_FS_BACKED_BY_FILE
>> +       bool "File-backed EROFS filesystem support"
>> +       depends on EROFS_FS
>> +       default y
> 
> I am a bit reluctant to have this default to y, without an ack from
> the VFS maintainers.

It don't touch any VFS stuffs so I didn't cc -fsdevel.

Okay, if VFS maintainers have any objection of this, I could turn
it into "default n", if not, I tend to leave it as "y" since I
believe it shouldn't be any risk of this feature (since EROFS is
only an immutable filesystem and I don't think out a context which
could be risky) with clear use cases and I've clearly documented
and showed in the commit message and upstream pull request.

Thanks,
Gao Xiang

