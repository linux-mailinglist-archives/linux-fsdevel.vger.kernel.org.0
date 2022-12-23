Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C91654E26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 10:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiLWJLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 04:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiLWJLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:11:22 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D026636C7A
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Dec 2022 01:11:20 -0800 (PST)
Received: from [192.168.0.90] (ip5f5aeb8a.dynamic.kabel-deutschland.de [95.90.235.138])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D1A2061CCD7B0;
        Fri, 23 Dec 2022 10:11:18 +0100 (CET)
Message-ID: <f83dab3d-0cc1-a655-644c-93f301b31187@molgen.mpg.de>
Date:   Fri, 23 Dec 2022 10:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Bug#1024811: linux: /proc/[pid]/stat unparsable
To:     Thorsten Glaser <tg@mirbsd.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, 1024811@bugs.debian.org
References: <166939644927.12906.17757536147994071219.reportbug@x61w.mirbsd.org>
 <Y4Hshbyk9TEsSQsm@p183> <d1f6877d-a084-2099-5764-979ee163eace@evolvis.org>
 <a721c273-9724-a652-1888-9c5d5ece7661@molgen.mpg.de>
 <Pine.BSM.4.64L.2212222023170.29938@herc.mirbsd.org>
 <b3ed92e0-6135-7f0c-6b6b-1be9dfe7a8a1@molgen.mpg.de>
 <Pine.BSM.4.64L.2212230847310.9463@herc.mirbsd.org>
Content-Language: en-US
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <Pine.BSM.4.64L.2212230847310.9463@herc.mirbsd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/23/22 09:49, Thorsten Glaser wrote:
> Donald Buczek dixit:
> 
>> To be fair, this daemon doesn't use /proc/pid/stat for that, but /proc/pid/comm
> 
> Yes, and that’s proper. The field in /proc/pid/stat is size-limited
> and so not necessarily distinct.

No, it is the process name itself, which is size limited, so in this regard it doesn't make a difference if you read it from /proc/pid/stat or /proc/pid/comm.

>> As /proc/pid/stat is also used in many places, it could as well use
>> that to avoid code duplication or reuse data already read from the
>> other source.
> 
> No, because the data in /stat is incomplete *and* anything using
> it that would be affected by escaping was already broken.

"Incomplete" because if truncation?

The usage in my example is not already broken. Truncation doesn't happen, because the process name used is the fixed string "mxqd reaper".

A process name is limited to 15 characters. The limit is already in force when you use PR_SET_NAME, so there is no truncation when you read it back from procfs.

D.

> 
> bye,
> //mirabilos

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
