Return-Path: <linux-fsdevel+bounces-13363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253E286F042
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 12:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295A1B228A4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829317558;
	Sat,  2 Mar 2024 11:33:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FD1754E
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709379220; cv=none; b=KhxxmVk+SK0z8T1n67KMfFhaox2DB1Npu4fauslkexw9Zn5u0EBoBxl8b/d16zHXI+C3gVGV7MT5I4YieV3p2FWaNrdsEJNkfwlzoJy3K3XrbcaIvkp9F6d9jsk6HO9khvnAho9z2/ck16LL7NxPmu0DxOZzmcjKS4pQj0PYYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709379220; c=relaxed/simple;
	bh=Bdp9ovagrFjIm7udJbuFU7TPTMxZCtCIewNaj6ep6eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWybpqGqEXVDtIZqKhmeYKuJBHpgJWSJVjAe18oBdgTFOG9uIg2/qZrv7AT0xbudnvPZSeyDQwzPJlupHU3WQ6wGDoIn1yh7c+YcjZXq4ex0RvDxF/luLS8TybePLkbMpsJPGQQSnt40mhukie7qJGMinXSg+zEt+HmXxMyI92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 422BXZCM016007;
	Sat, 2 Mar 2024 20:33:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sat, 02 Mar 2024 20:33:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 422BXZ76015997
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 2 Mar 2024 20:33:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a2ac50aa-0f68-4a01-9c49-adfc19430af5@I-love.SAKURA.ne.jp>
Date: Sat, 2 Mar 2024 20:33:34 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>, NeilBrown <neilb@suse.de>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/02 9:02, Kent Overstreet wrote:
> Getting rid of those would be a really nice cleanup beacuse then gfp
> flags would mostly just be:
>  - the type of memory to allocate (highmem, zeroed, etc.)
>  - how hard to try (don't block at all, block some, block forever)

I really wish that __GFP_KILLABLE is added, so that we can use like
mutex_trylock()/mutex_lock_killable()/mutex_lock().

Memory allocations from LSM modules for access control are willing to
give up when the allocating process is killed, for userspace won't know
about whether the request succeed. But such allocations are hardly
acceptable to give up unless the allocating process is killed or
allocation hit PAGE_ALLOC_COSTLY_ORDER, for ENOMEM failure returned by
e.g. open() can break the purpose of executing userspace processes
(i.e. as bad as being killed by the OOM killer).


