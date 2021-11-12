Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B244ECCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 19:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhKLStg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 13:49:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46346 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhKLStg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:49:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B3D71FD5E;
        Fri, 12 Nov 2021 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636742804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtiOUgFml5wXOb4LYQwg084WSwwUrzV4ukXr1FDAp78=;
        b=jbXw5p4NzK9k4IIdE/XU4h+y54Hxk631ClnVJ+v7r5r5KBUcPjWKe/YU8eQZTN6QhNvNcg
        gaGuG5vxbRY7mnGFv+2eRwUQcGx1CBeFyL1QEtbUwZ2tfkkobJEQK366WzRiIB/F4QFalD
        oypvp7TcQLREA9h2943IkboXlK3dWgM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C35CA13C7E;
        Fri, 12 Nov 2021 18:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GA+XLJO2jmH2MwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 12 Nov 2021 18:46:43 +0000
Subject: Re: 5.15+, blocked tasks, folio_wait_bit_common
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
References: <CAJCQCtSh2WT3fijK4sYEdfYpp09ehA+SA75rLyiJ6guUtyWjyw@mail.gmail.com>
 <CAJCQCtQ=JsO6bH=vJE2aZDS_7FDq+y-yHFVm4NTaf7QLArWGAw@mail.gmail.com>
 <9f7d7997-b1a1-9c4f-8e2f-56e28a54c8c6@suse.com>
 <CAJCQCtQ4JwAD8Nw-mHWxoXtJT7m0d-d+gi23_JgU=C8dvTtEOA@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <41cabdcf-894f-353b-0c9d-98635b26fe30@suse.com>
Date:   Fri, 12 Nov 2021 20:46:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQ4JwAD8Nw-mHWxoXtJT7m0d-d+gi23_JgU=C8dvTtEOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC'ing Omar as Kyber is mentioned]

On 12.11.21 г. 20:06, Chris Murphy wrote:
> On Fri, Nov 12, 2021 at 1:55 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>>
>>
>> On 11.11.21 г. 22:57, Chris Murphy wrote:
>>> On Thu, Nov 11, 2021 at 3:24 PM Chris Murphy <lists@colorremedies.com> wrote:
>>>>
>>>> Soon after logging in and launching some apps, I get a hang. Although
>>>> there's lots of btrfs stuff in the call traces, I think we're stuck in
>>>> writeback so everything else just piles up and it all hangs
>>>> indefinitely.
>>>>
>>>> Happening since at least
>>>> 5.16.0-0.rc0.20211109gitd2f38a3c6507.9.fc36.x86_64 and is still happening with
>>>> 5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64
>>>>
>>>> Full dmesg including sysrq+w when the journal becomes unresponsive and
>>>> then a bunch of block tasks  > 120s roll in on their own.
>>>>
>>>> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1841283
>>>
>>
>>
>> The btrfs traces in this one doesn't look interesting, what's
>> interesting is you have a bunch of tasks, including btrfs transaction
>> commit which are stuck waiting to get a tag from the underlying block
>> device - blk_mq_get_tag function. This indicates something's going on
>> with the underlying block device.
> 
> Well the hang doesn't ever happen with 5.14.x or 5.15.x kernels, only
> the misc-next (Fedora rc0) kernels. And also I just discovered that
> it's not happening (or not as quickly) with IO scheduler none. I've
> been using kyber and when I switch back to it, the hang happens almost
> immediately.

Well I see a bunch of WARN_ONs being triggered, so is it possible that
this is some issue which is going to be fixed in some future RC ? Omar
what steps should be taken to try and debug this from the Kyber side of
things?


> 
> 
> 
> 
