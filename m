Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39C6654216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiLVNpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 08:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVNpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:45:20 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A31902B
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 05:45:18 -0800 (PST)
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3262260027FCB;
        Thu, 22 Dec 2022 14:45:15 +0100 (CET)
Subject: Re: Re: Bug#1024811: linux: /proc/[pid]/stat unparsable
To:     Thorsten Glaser <tg@mirbsd.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     1024811@bugs.debian.org
References: <166939644927.12906.17757536147994071219.reportbug@x61w.mirbsd.org>
 <Y4Hshbyk9TEsSQsm@p183> <d1f6877d-a084-2099-5764-979ee163eace@evolvis.org>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <a721c273-9724-a652-1888-9c5d5ece7661@molgen.mpg.de>
Date:   Thu, 22 Dec 2022 14:45:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <d1f6877d-a084-2099-5764-979ee163eace@evolvis.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/22/22 1:53 AM, Thorsten Glaser wrote:
> On Sat, 26 Nov 2022, Alexey Dobriyan wrote:
> 
>> /proc never escaped "comm" field of /proc/*/stat.
> 
> Yes, that’s precisely the bug.
> 
>> To parse /proc/*/stat reliably, search for '(' from the beginning, then
>> for ')' backwards. Everything in between parenthesis is "comm".
> 
> That’s not guaranteed to stay reliable: fields can be, and have
> been in the past, added, and new %s fields will break this. Do
> not rely on it either.
> 
>> Everything else are numbers separated by spaces.
> 
> Currently, yes.
> 
> But the field is *clearly* documented as intended to be
> parsable by scanf(3), which splits on white space. So the
> Linux kernel MUST encode embedded whitespace so the
> documented(!) access method works.

No, Escaping would break existing programs which parse the line by searching for the ')' from the right. The format, surly, is ugly, but that is how it is.

If some documentation suggests, that you can just parse it with scanf, the documentation should be corrected/improved instead.

Are you referring to proc(5) "The fields, in order, with their proper scanf(3) format specifiers, are listed below" [1] or something else?

The referenced manual page is wrong in regard to the length, too. There is no 16 character limit to the field, because it can contain a workqueue task name, too:

    buczek@theinternet:/tmp$ cat /proc/27190/stat
    27190 (kworker/11:2-mm_percpu_wq) I 2 0 0 0 -1 69238880 0 0 0 0 0 170 0 0 20 0 1 0 109348986 0 0 18446744073709551615 0 0 0 0 0 0 0 2147483647 0 0 0 0 17 11 0 0 0 0 0 0 0 0 0 0 0 0 0

The current limit seems to be 64 characters [2] when escaping is off, as it is the case with /proc/pid/stat. But generally the length of the field and thereby of the whole line seems to be rather undefined. So to parse that, you either either need to do some try-and-restart-with-a-bigger-buffer dance or use a buffer size of which you just hope that it will be big enough for the forseable time. 

In fact, if you start escaping now you might also break programs which rely on the current 64 character limit.

Best

  Donald

[1]: https://man7.org/linux/man-pages/man5/proc.5.html
[2]: https://elixir.bootlin.com/linux/latest/source/fs/proc/array.c#L99

> 
> bye,
> //mirabilos
> 


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
