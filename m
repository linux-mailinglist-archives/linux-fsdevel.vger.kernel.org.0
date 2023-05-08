Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F76FBB87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 01:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjEHXuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEHXuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 19:50:08 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7D72B6;
        Mon,  8 May 2023 16:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7ajBfk8DFFaGhkh+bcOwdi96d3tlJSokgRqCOruMr9k=; b=rLuXoDkHmSTK0uEqL7aeemGFEA
        udb60veXtDoKErUkiswRA/HySauVx9lTto3b7KgGi6ovt50JbQqBkqSTPSRM4ZB5DWbMb7rPuvxMw
        sI4zsEY9YyqWy0ewzfEdhivUbilm3ZezKettmGcahxDKIrkM1/qpT67UqdpQI/i1NtFua1LIPNt+O
        1HPmyJL4PDYwZb2mHRrAnJsuimkomsQchZcsndPB0pPe4iQt/xnikKJ7f89hpkWiCOMr/vWZZ4c2X
        z+hGyZP+G/N7W5sQ05qt5xasJXNYYpzPwDrLrW6OY/OpyLklr2pUNzrChr5yR9H8rX4/bS1E98aEv
        FhAIMQ8w==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pwAc9-004JaB-AK; Tue, 09 May 2023 01:49:57 +0200
Message-ID: <9fb396ab-d76f-bb07-a940-3f6842a3020d@igalia.com>
Date:   Mon, 8 May 2023 20:49:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <20230505131825.GN6373@twin.jikos.cz>
 <a28b9ff4-c16c-b9ba-8b4b-a00252c32857@igalia.com>
 <20230505230003.GU6373@twin.jikos.cz>
 <ed84081e-3b92-1253-2cf5-95f979c6c2f0@igalia.com>
 <f04cfb6d-9b1f-b5bf-0a41-a93efff47c15@gmx.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <f04cfb6d-9b1f-b5bf-0a41-a93efff47c15@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/05/2023 20:18, Qu Wenruo wrote:
> [...]
>> I see that we seem to have 3 proposals here:
>>
>> (a) The compat_ro flag from Qu;
>>
>> (b) Your idea (that requires some clarification for my fully
>> understanding - thanks in advance!);
>>
>> (c) Renaming the mount option "virtual_fsid" to "nouuid" to keep
>> filesystem consistency, like XFS (courtesy of Dave Chinner) - please
>> correct me here if I misunderstood you Dave =)
> 
> To me, (a) and (c) don't conflict at all.
> 
> We can allow "nouuid" only to work with SINGLE_DEV compat_ro.
> 
> That compat_ro flags is more like a better guarantee that the fs will
> never have more disks.
> 
> As even with SINGLE_DEV compat_ro flags, we may still want some checks
> to prevent the same fs being RW mounted at different instances, which
> can cause other problems, thus dedicated "nouuid" may still be needed.
> 
> Thanks,
> Qu

Hey Qu, I confess now I'm a bit confused heh

The whole idea of (a) was to *not* use a mount option, right?! Per my
understanding of your objections in this thread, you're not into a mount
option for this same-fsid feature (based on a bad previous experience,
as you explained).

If we're keeping the "nouuid" mount option, why we'd require the
compat_ro flag? Or vice-versa: having the compat_ro flag, why we'd need
the mount option?

Thanks in advance for clarifications,


Guilherme
