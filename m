Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E94C44E214
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 07:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhKLG6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 01:58:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52168 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhKLG6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:58:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6BFF218B0;
        Fri, 12 Nov 2021 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636700152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wo+fI7wEspLa1LyIo5kPuxhvr+gf8ZdHKt6FyGkdJbY=;
        b=nYppNL3++yQ3Cidsgp7fTd2NDFMPmkS9J1puM9Tx7cuEB1BTEVSmCPAJWAUp/elrkaI/ju
        ZQcsdMdzNIzvsJdskW5suAyVsWNEPIKU5plCV5QXti9/ElIv4FM6Xkgq9+gfutjErt9fDi
        dgzaLXj1D6v+I1dwO1Mz83mEemIVrog=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 916BE13E3D;
        Fri, 12 Nov 2021 06:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PPrsIPgPjmGFYwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 12 Nov 2021 06:55:52 +0000
Subject: Re: 5.15+, blocked tasks, folio_wait_bit_common
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <CAJCQCtSh2WT3fijK4sYEdfYpp09ehA+SA75rLyiJ6guUtyWjyw@mail.gmail.com>
 <CAJCQCtQ=JsO6bH=vJE2aZDS_7FDq+y-yHFVm4NTaf7QLArWGAw@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9f7d7997-b1a1-9c4f-8e2f-56e28a54c8c6@suse.com>
Date:   Fri, 12 Nov 2021 08:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQ=JsO6bH=vJE2aZDS_7FDq+y-yHFVm4NTaf7QLArWGAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11.11.21 г. 22:57, Chris Murphy wrote:
> On Thu, Nov 11, 2021 at 3:24 PM Chris Murphy <lists@colorremedies.com> wrote:
>>
>> Soon after logging in and launching some apps, I get a hang. Although
>> there's lots of btrfs stuff in the call traces, I think we're stuck in
>> writeback so everything else just piles up and it all hangs
>> indefinitely.
>>
>> Happening since at least
>> 5.16.0-0.rc0.20211109gitd2f38a3c6507.9.fc36.x86_64 and is still happening with
>> 5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64
>>
>> Full dmesg including sysrq+w when the journal becomes unresponsive and
>> then a bunch of block tasks  > 120s roll in on their own.
>>
>> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1841283
> 


The btrfs traces in this one doesn't look interesting, what's
interesting is you have a bunch of tasks, including btrfs transaction
commit which are stuck waiting to get a tag from the underlying block
device - blk_mq_get_tag function. This indicates something's going on
with the underlying block device.
