Return-Path: <linux-fsdevel+bounces-52840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0315AE7647
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372D917CC83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 05:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36F1DEFE7;
	Wed, 25 Jun 2025 05:03:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B63074BC;
	Wed, 25 Jun 2025 05:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827819; cv=none; b=I9+gJUCWDHRu1ldbih3nBqs+yDYfvfphk52Eg0YV+lgzSdcVMYvR/QVfir3bFOJwYPrd9ufYtT9JYL3vMFsSrCRw+76gS6P9aBvMp6SSKxuK9UHHkkhSkTRatvGdR6Sg5HzHHHYHYuCbMWYLzG9BKyxP0yUXPp8vUcybLi3ycIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827819; c=relaxed/simple;
	bh=OdWCPJ/dhggTtstpAX0ijju/NPvG2bBXSkGSInyaM34=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UZIA73+B/eEGiDoUMvQ52+zZ2DUmKlPUjRwTg4oiCswGgFbXplF/vH6pojppmjMo2+0ufsi4MK500JBjt7ad0+bimrT+qqk0XmzmpcmcAeu0Frg4ClLafyU9LIYaI5Sm20YOvUaICbHMVSYc0+y95tvHTgUk7bKEP925QukmWDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55P53LrX079544;
	Wed, 25 Jun 2025 14:03:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55P53Kn6079538
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Jun 2025 14:03:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
Date: Wed, 25 Jun 2025 14:03:20 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH (REPOST)] hfs: don't use BUG() when we can continue
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

Matthew, any comments?

On 2024/12/05 23:14, Tetsuo Handa wrote:
> On 2024/12/05 22:59, Matthew Wilcox wrote:
>> On Thu, Dec 05, 2024 at 10:45:11PM +0900, Tetsuo Handa wrote:
>>> syzkaller can mount crafted filesystem images.
>>> Don't crash the kernel when we can continue.
>>
>> The one in hfs_test_inode() makes sense, but we should never get to
>> hfs_release_folio() or hfs_write_inode() with a bad inode, even with a
>> corrupted fs.  Right?
> 
> Unfortunately, https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
> reports that we can reach hfs_write_inode() with a corrupted filesystem.
> If we should never get to hfs_write_inode(), how do we want to handle
> this problem? Is someone familiar with hfs enough to perform an in-kernel
> fsck upon mounting?
> 


