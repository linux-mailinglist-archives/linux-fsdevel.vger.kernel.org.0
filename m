Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A065476D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 21:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiLVUnA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 15:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiLVUm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:42:59 -0500
X-Greylist: delayed 671 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 12:42:56 PST
Received: from herc.mirbsd.org (herc.mirbsd.org [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D0A911F
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 12:42:55 -0800 (PST)
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 2BMKS6Ti023117
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 22 Dec 2022 20:28:08 GMT
Date:   Thu, 22 Dec 2022 20:28:05 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     Donald Buczek <buczek@molgen.mpg.de>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, 1024811@bugs.debian.org
Subject: Re: Re: Bug#1024811: linux: /proc/[pid]/stat unparsable
In-Reply-To: <a721c273-9724-a652-1888-9c5d5ece7661@molgen.mpg.de>
Message-ID: <Pine.BSM.4.64L.2212222023170.29938@herc.mirbsd.org>
References: <166939644927.12906.17757536147994071219.reportbug@x61w.mirbsd.org>
 <Y4Hshbyk9TEsSQsm@p183> <d1f6877d-a084-2099-5764-979ee163eace@evolvis.org>
 <a721c273-9724-a652-1888-9c5d5ece7661@molgen.mpg.de>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Donald Buczek dixit:

>No, Escaping would break existing programs which parse the line by
>searching for the ')' from the right.

Huh? No!

The format is "(" + string + ") " after all, and only the string
part would get escaped.

The only visible change would be that programs containing a
whitespace character (and, ideally, a ‘(’) in their name would
be escaped, which are these that are currently broken anyway.
And perhaps backslashes, if you decide to encode unambiguous,
but given the field length limit, I don’t think that was ever
a goal (both because I suspect this file was intended to be
used to get a quick overview and therefore deliberately shortens
and because the full info is available elsewhere), so no need to
encode unambiguously.

>If some documentation suggests, that you can just parse it with scanf,
>the documentation should be corrected/improved instead.

No. Someone recently did a survey, and most code in existence splits
by whitespace. Fix the kernel bug instead.

>Are you referring to proc(5) "The fields, in order, with their proper
>scanf(3) format specifiers, are listed below" [1] or something else?

Yes.

>The referenced manual page is wrong in regard to the length, too. There
>is no 16 character limit to the field, because it can contain a
>workqueue task name, too:

Probably used to be cut off after 16. Go fix that in the manpage
then. But do fix the encoding kernel-side.

>In fact, if you start escaping now you might also break programs which
>rely on the current 64 character limit.

Just cut off at the end then, like I suspect was done at 16 bytes
initially.

Or strip whitespace and closing parenthesis if present instead
of encoding them, or replace them with a question mark.

bye,
//mirabilos
-- 
“It is inappropriate to require that a time represented as
 seconds since the Epoch precisely represent the number of
 seconds between the referenced time and the Epoch.”
	-- IEEE Std 1003.1b-1993 (POSIX) Section B.2.2.2
