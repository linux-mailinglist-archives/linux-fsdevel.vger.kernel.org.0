Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496FA739E81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFVKXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjFVKXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:23:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F781BD4;
        Thu, 22 Jun 2023 03:23:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31636204AC;
        Thu, 22 Jun 2023 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687429391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jLJdaHtd9jQpxlVJ+So1VAsRM34wp0PKNV9CKuEjkU=;
        b=nYKhg1lJ+TbMdOr2p36eTnByOlrrH2WGuBNJj9EYWC5qEqInfucOEK2J+SanKC6PLShLDV
        h707x5qPwdMm9pkW3DebvRap6/QBdoWp/C+pjWE5R1HNLgfM/7O2V2NyuvbbT3LorbQr4r
        jkh55vkftnHvz3A9B49Fv7FsTj1U31Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687429391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jLJdaHtd9jQpxlVJ+So1VAsRM34wp0PKNV9CKuEjkU=;
        b=ZhKqdfH6zWk1ZdpmbHGvKXEdemrl07Q6nTyoPGkusSPHDFM8/cmZhkIpW6ClZ+6W06tByf
        ORIVq65iETPUNpAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B92813905;
        Thu, 22 Jun 2023 10:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z8BPBg8hlGS9OwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 22 Jun 2023 10:23:11 +0000
Message-ID: <a42b97a9-88d5-b8cd-e36e-81a168dff7cd@suse.de>
Date:   Thu, 22 Jun 2023 12:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 0/4] minimum folio order support in filemap
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a@eucas1p1.samsung.com>
 <20230621083823.1724337-1-p.raghav@samsung.com>
 <b311ae01-cec9-8e06-02a6-f139e37d5863@suse.de>
 <ZJN0pvgA2TqOQ9BC@dread.disaster.area>
 <4270b5c7-04b4-28e0-6181-ef98d1f5130c@suse.de>
 <94d9e935-c8a4-896a-13ac-263831a78dd5@suse.de>
 <ZJQggr3ymd7eXgA4@dread.disaster.area>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZJQggr3ymd7eXgA4@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/23 12:20, Dave Chinner wrote:
> On Thu, Jun 22, 2023 at 08:50:06AM +0200, Hannes Reinecke wrote:
>> On 6/22/23 07:51, Hannes Reinecke wrote:
>>> On 6/22/23 00:07, Dave Chinner wrote:
>>>> On Wed, Jun 21, 2023 at 11:00:24AM +0200, Hannes Reinecke wrote:
>>>>> On 6/21/23 10:38, Pankaj Raghav wrote:
>>>>> Hmm. Most unfortunate; I've just finished my own patchset
>>>>> (duplicating much
>>>>> of this work) to get 'brd' running with large folios.
>>>>> And it even works this time, 'fsx' from the xfstest suite runs
>>>>> happily on
>>>>> that.
>>>>
>>>> So you've converted a filesystem to use bs > ps, too? Or is the
>>>> filesystem that fsx is running on just using normal 4kB block size?
>>>> If the latter, then fsx is not actually testing the large folio page
>>>> cache support, it's mostly just doing 4kB aligned IO to brd....
>>>>
>>> I have been running fsx on an xfs with bs=16k, and it worked like a charm.
>>> I'll try to run the xfstest suite once I'm finished with merging
>>> Pankajs patches into my patchset.
>>> Well, would've been too easy.
>> 'fsx' bails out at test 27 (collapse), with:
>>
>> XFS (ram0): Corruption detected. Unmount and run xfs_repair
>> XFS (ram0): Internal error isnullstartblock(got.br_startblock) at line 5787
>> of file fs/xfs/libxfs/xfs_bmap.c.  Caller
>> xfs_bmap_collapse_extents+0x2d9/0x320 [xfs]
>>
>> Guess some more work needs to be done here.
> 
> Yup, start by trying to get the fstests that run fsx through cleanly
> first. That'll get you through the first 100,000 or so test ops
> in a few different run configs. Those canned tests are:
> 
> tests/generic/075
> tests/generic/112
> tests/generic/127
> tests/generic/231
> tests/generic/455
> tests/generic/457
> 
THX.

Any preferences for the filesystem size?
I'm currently running off two ramdisks with 512M each; if that's too 
small I need to increase the memory of the VM ...

Cheers,

Hannes

