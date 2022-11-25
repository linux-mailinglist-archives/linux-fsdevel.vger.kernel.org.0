Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1480638F44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKYRoR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 12:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKYRoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:44:16 -0500
X-Greylist: delayed 714 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 09:44:09 PST
Received: from herc.mirbsd.org (herc.mirbsd.org [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AAEF2180B
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 09:44:09 -0800 (PST)
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 2APHO4Tk015230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 25 Nov 2022 17:24:07 GMT
Date:   Fri, 25 Nov 2022 17:24:04 +0000 (UTC)
From:   Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To:     1024811@bugs.debian.org
cc:     adobriyan@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: Bug#1024811: linux: /proc/[pid]/stat unparsable
In-Reply-To: <166939644927.12906.17757536147994071219.reportbug@x61w.mirbsd.org>
Message-ID: <Pine.BSM.4.64L.2211251719211.1674@herc.mirbsd.org>
References: <166939644927.12906.17757536147994071219.reportbug@x61w.mirbsd.org>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dixi quod…

>The effect is that /proc/[pid]/stat cannot be parsed the way it is
>documented, as it does not escape embedded whitespace characters;

… nor parenthesēs:

tglase@x61w:~ $ ./mk\)sh -c 'echo $$; sleep 10' &
[1] 13375
tglase@x61w:~ $ 13375
tglase@x61w:~ $ cat /proc/13375/stat
13375 (mk)sh) S 13330 13375 13330 34837 13377 4194304 124 0 0 0 0 0 0 0 20 0 1 0 59029474 2977792 180 18446744073709551615 94911056490496 94911056739789 140721459110048 0 0 0 0 0 134307847 0 0 0 17 1 0 0 0 0 0 94911056765744 94911056773808 94911059955712 140721459115917 140721459115946 140721459115946 140721459118064 0

This is… sad — extremely so. It does not escape anything.
I found proc_task_name(), which has an escape parameter,
which is set to false here, but it’s only for /status
which must escape newlines.

It’s used with false in /stat and /comm… the latter indeed
needing no escapes.

I’d argue that it needs a tristate argument, 0 for /comm
to not escape anything, 1 for /status to escape newlines,
and 2 for /stat to escape whitespace (and perhaps also a
closing parenthesis, using \x29, so splitting both using
scanf as indicated in the manpage and using parenthesēs
as people seem to do on the ’net is fixed).

bye,
//mirabilos
-- 
22:20⎜<asarch> The crazy that persists in his craziness becomes a master
22:21⎜<asarch> And the distance between the craziness and geniality is
only measured by the success 18:35⎜<asarch> "Psychotics are consistently
inconsistent. The essence of sanity is to be inconsistently inconsistent
