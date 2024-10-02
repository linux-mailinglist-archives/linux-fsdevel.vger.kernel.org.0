Return-Path: <linux-fsdevel+bounces-30671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5809198D238
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043A11F224B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81A1EBFE5;
	Wed,  2 Oct 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ahvogri+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350522F43;
	Wed,  2 Oct 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868643; cv=none; b=pvh1exInyn4uUdx4fftg76sFlkMYAVAQRB9iSp/2YxZreldrV1XXOw2m6xJOlTtTWuOPbD7n3x5vYkO30U99nCWT1PoI2wBDKO0UgbYkbLZxx0mBSAfEs2ddRKFz2HSQg0nSl1EhPOmcrjIfcTvcEM30eOrhZXgk1sIFpm6kiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868643; c=relaxed/simple;
	bh=oR9lYsRsUhjny1bmq1b+3xZAoJRr4GA7VsyEj/Nw3aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1EcDDa3aP1sBaQuJXEv4fxR3ILdHcFAu0gYdVjSy7Q+50ckLp7em1h0SPBuVzdkTDqThBJorWFZefj0l5i8/zHr9quZNsq8yTcwW1cncK28o6uLApTiXKQcp9Xbp7enLtu7oaHQNJuPMqLFSh7PU8wtqULJtsNa2whCm5KtwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ahvogri+; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727868633; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xEwxijDeSh+VJN3BJ+JAiKDblgWvKqGAbbaQA2kzvZk=;
	b=Ahvogri+wmScbuVPRXbmKj7vXNImKOe2A1yfzt7OW5xTiH+z52nCyXmsnKgZLth0fsAkDpCHhVCYQSgGJ1+H+nUCxK+2dNopk0xz1bCpPHPUa+rRYhH8aYYf/A4IX8tDDNxejMbdcUU9JPJPLIqoKibmdd31G4thaAlVb1T2ETc=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WG9ymnr_1727868312)
          by smtp.aliyun-inc.com;
          Wed, 02 Oct 2024 19:25:13 +0800
Message-ID: <7cde8511-9d56-4366-aac4-29dfbd8c76b1@linux.alibaba.com>
Date: Wed, 2 Oct 2024 19:25:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
 <20240930141819.tabcwa3nk5v2mkwu@quack3>
 <20241002-burgfrieden-nahen-079f64e243ad@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241002-burgfrieden-nahen-079f64e243ad@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/2 14:12, Christian Brauner wrote:
> On Mon, Sep 30, 2024 at 04:18:19PM GMT, Jan Kara wrote:

..

>>>>
>>>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>>>> index 7dcdce660cac..1428d0530e1c 100644
>>>> --- a/fs/erofs/Kconfig
>>>> +++ b/fs/erofs/Kconfig
>>>> @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
>>>>
>>>>            If you are not using a security module, say N.
>>>>
>>>> +config EROFS_FS_BACKED_BY_FILE
>>>> +       bool "File-backed EROFS filesystem support"
>>>> +       depends on EROFS_FS
>>>> +       default y
>>>
>>> I am a bit reluctant to have this default to y, without an ack from
>>> the VFS maintainers.
>>
>> Well, we generally let filesystems do whatever they decide to do unless it
>> is a affecting stability / security / maintainability of the whole system.
>> In this case I don't see anything that would be substantially different
>> than if we go through a loop device. So although the feature looks somewhat
>> unusual I don't see a reason to nack it or otherwise interfere with
>> whatever the fs maintainer wants to do. Are you concerned about a
>> particular problem?
> 
> I see no reason to nak it either.

Thanks all for taking time on writing down these!

Unfortunately, fanotify pre-content hooks was't landed in 6.12 cycle
(which I think will be used in a lot of scenarios)..

I do hope it could be landed in the next cycle so I could clean up
the codebase then.

Thanks,
Gao Xiang

