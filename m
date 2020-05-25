Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73B11E0FA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbgEYNi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 09:38:58 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17120 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388794AbgEYNi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 09:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590413843; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=qDT6LMzGh8lxZZ8pSZOPw1InJ6c2NdHTqD7WX8gAYcv0sivGjGsUQIw6W5CCoOBvCAF747z9u2TqH7AVMxMBB4IcTugDonkfgKPgSSQK0fBqzP7H6PToEtBxB9dwmkOyx3pXZAAlleiCX0lkFK7LEQ9mA0r/bzjP6F0fiWA0bCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1590413843; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=mquSMkM5+AALl36igoWM9/F1M5XrDJ+imBVLNdmmnbw=; 
        b=MJoxeU4X5K2Nq1fM8jjW+J/XTa3Xv47dKzyOgvdv0uqlwPRjFfuKr52NowQ3sQL4XFzQJZjAFSmOaHBAyjQdzHBDn89oyj2wdYIXlxUZc8QcVeumGdKWcz0mI1+d3ifkg1aPkLmAaV3ThAbgQOaAYrfiDhsCVmphFjcnwR0281s=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590413843;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:Subject:To:Cc:Message-ID:References:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=mquSMkM5+AALl36igoWM9/F1M5XrDJ+imBVLNdmmnbw=;
        b=fGQ2tLy5EOaNF4olYAq2VkL2trY+GQ+K4bOAPLGh01ZO0I4xQnSJLtc403cWcA1E
        eRMNgeIfD6krdeme7RE4oHmvraSYkNSAiynYm9GLxsbadYzbo4K7WBl5KJ8zwDaQKWV
        YAsOKyNBHISPCAwEo75DKBmdDfbB+nu2KQ6TTJms=
Received: from [10.0.0.9] (113.87.88.197 [113.87.88.197]) by mx.zoho.com.cn
        with SMTPS id 1590413841507658.3265125907473; Mon, 25 May 2020 21:37:21 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, Ian Kent <raven@themaw.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Message-ID: <778de44a-17d5-a5ba-fc54-6839b67fe7b1@mykernel.net>
References: <20200515072047.31454-1-cgxu519@mykernel.net>
 <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
 <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
 <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com>
 <05e92557-055c-0dea-4fe4-0194606b6c77@mykernel.net>
 <CAJfpegtyZw=6zqWQWm-fN0KpGEp9stcfvnbA7eh6E-7XHxaG=Q@mail.gmail.com>
 <7fcb778f-ba80-8095-4d48-20682f5242a9@mykernel.net>
 <CAJfpegu1XVB5ABGMzNpyomgWqu+gtd2RCoDpuqGcEYJ7tmWdew@mail.gmail.com>
Date:   Mon, 25 May 2020 21:37:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegu1XVB5ABGMzNpyomgWqu+gtd2RCoDpuqGcEYJ7tmWdew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E5=9C=A8 5/20/2020 10:44 PM, Miklos Szeredi =E5=86=99=E9=81=93:
> On Tue, May 19, 2020 at 11:24 AM cgxu <cgxu519@mykernel.net> wrote:
>> On 5/19/20 4:21 PM, Miklos Szeredi wrote:
>>> On Tue, May 19, 2020 at 7:02 AM cgxu <cgxu519@mykernel.net> wrote:
>>>
>>>> If we don't consider that only drop negative dentry of our lookup,
>>>> it is possible to do like below, isn't it?
>>> Yes, the code looks good, though I'd consider using d_lock on dentry
>>> instead if i_lock on parent, something like this:
>>>
>>> if (d_is_negative(dentry) && dentry->d_lockref.count =3D=3D 1) {
>>>       spin_lock(&dentry->d_lock);
>>>       /* Recheck condition under lock */
>>>       if (d_is_negative(dentry) && dentry->d_lockref.count =3D=3D 1)
>>>           __d_drop(dentry)
>>>       spin_unlock(&dentry->d_lock);
>> And after this we will still treat 'dentry' as negative dentry and dput =
it
>> regardless of the second check result of d_is_negative(dentry), right?
> I'd restructure it in the same way as lookup_positive_unlocked()...
>
>>> }
>>>
>>> But as Amir noted, we do need to take into account the case where
>>> lower layers are shared by multiple overlays, in which case dropping
>>> the negative dentries could result in a performance regression.
>>> Have you looked at that case, and the effect of this patch on negative
>>> dentry lookup performance?
>> The container which is affected by this feature is just take advantage
>> of previous another container but we could not guarantee that always
>> happening. I think there no way for best of both worlds, consider that
>> some malicious containers continuously make negative dentries by
>> searching non-exist files, so that page cache of clean data, clean
>> inodes/dentries will be freed by memory reclaim. All of those
>> behaviors will impact the performance of other container instances.
>>
>> On the other hand, if this feature significantly affects particular
>> container,
>> doesn't that mean the container is noisy neighbor and should be restrict=
ed
>> in some way?
> Not necessarily.   Negative dentries can be useful and in case of
> layers shared between two containers having negative dentries cached
> in the lower layer can in theory positively affect performance.   I
> don't have data to back this up, nor the opposite.  You should run
> some numbers for container startup times with and without this patch.

I did some simple tests=C2=A0 for it but the result seems not very steady, =
so=20
I need to take time to do more detail tests later. Is it possible to=20
apply the patch for upper layer first?

Thanks,
cgxu


