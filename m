Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11C8654D9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 09:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiLWIm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 03:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiLWIm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:42:28 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF00357AF
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Dec 2022 00:42:25 -0800 (PST)
Received: from [192.168.0.90] (ip5f5aeb8a.dynamic.kabel-deutschland.de [95.90.235.138])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1859F61CCD7B0;
        Fri, 23 Dec 2022 09:42:24 +0100 (CET)
Message-ID: <b3ed92e0-6135-7f0c-6b6b-1be9dfe7a8a1@molgen.mpg.de>
Date:   Fri, 23 Dec 2022 09:42:23 +0100
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
Content-Language: en-US
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <Pine.BSM.4.64L.2212222023170.29938@herc.mirbsd.org>
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

On 12/22/22 21:28, Thorsten Glaser wrote:
> Donald Buczek dixit:
> 
>> No, Escaping would break existing programs which parse the line by
>> searching for the ')' from the right.
> 
> Huh? No!
> 
> The format is "(" + string + ") " after all, and only the string
> part would get escaped.
> 
> The only visible change would be that programs containing a
> whitespace character (and, ideally, a ‘(’) in their name would

')'

> be escaped, which are these that are currently broken anyway.

You would still break programs which use the string for anything else than displaying it to the user.

We have a job control daemon, which stored PIDs of jobs it has started in a database. The daemon is able to restart. When it comes back up, it needs to find out, whether its jobs are still alive. The problem here is pid wrap: A job might be gone, but a unrelated new process might have gotten the recycled pid. To avoid confusion, the restarting job control daemon looks at the comm value of the process in question, which is known for its own jobs [1].

[1]: https://github.molgen.mpg.de/mariux64/mxq/blob/f3d9fb8c6143c3a884210b212ed4a8514a49a414/mxqd.c#L904

In this case, the fixed process name (set with prctl PR_SET_NAME) even contains a space: "mxqd reaper".

To be fair, this daemon doesn't use /proc/pid/stat for that, but /proc/pid/comm instead. So it wouldn't really be affected by your proposed change. But that is just a random design decision. As /proc/pid/stat is also used in many places, it could as well use that to avoid code duplication or reuse data already read from the other source.

> And perhaps backslashes, if you decide to encode unambiguous,
> but given the field length limit, I don’t think that was ever
> a goal (both because I suspect this file was intended to be
> used to get a quick overview and therefore deliberately shortens
> and because the full info is available elsewhere), so no need to
> encode unambiguously.
> 
>> If some documentation suggests, that you can just parse it with scanf,
>> the documentation should be corrected/improved instead.
> 
> No. Someone recently did a survey, and most code in existence splits
> by whitespace. Fix the kernel bug instead.

Yes, I've seen that on oss-security. No doubt, its easy to parse the file wrongly and no doubt, many programs do that.

I also acknowledge, that the man page and the implementation are in conflict.

However, afaik, 'correctness' in the kernel world is not defined by specifications, less by man pages, but by implementation. So this can't be declared a kernel bug just because it conflicts with a manpage.

Plus the manpage, which you use as a foundation that there is something to fix, doesn't talk about encoding, either. So even when some encoding was applied, the interface would still be in conflict with the manpage.

Generally, changes, which might break userspace, are not very welcome, even if the current implementation is ugly and difficult to work with. I just wanted to point out,  that there exists programs which interpret the comm value they got from procfs. If these programs happen to use /proc/pid/stat for reading it, they might fail, if the format was changed. And experience shows, that any (miss-)feature is used by somebody somewhere, so any "might break" is really a "will break".

I don't object to a change and I think its a valid position to risk a breakage of a very few programs for what you might gain here. But it is not self-evident by the declarative power of the manpage or otherwise. It's a judgement, which has to be taken.

Best
   Donald

>> Are you referring to proc(5) "The fields, in order, with their proper
>> scanf(3) format specifiers, are listed below" [1] or something else?
> 
> Yes.
> 
>> The referenced manual page is wrong in regard to the length, too. There
>> is no 16 character limit to the field, because it can contain a
>> workqueue task name, too:
> 
> Probably used to be cut off after 16. Go fix that in the manpage
> then. But do fix the encoding kernel-side.


>> In fact, if you start escaping now you might also break programs which
>> rely on the current 64 character limit.
> 
> Just cut off at the end then, like I suspect was done at 16 bytes
> initially.
> 
> Or strip whitespace and closing parenthesis if present instead
> of encoding them, or replace them with a question mark.
> 
> bye,
> //mirabilos

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
