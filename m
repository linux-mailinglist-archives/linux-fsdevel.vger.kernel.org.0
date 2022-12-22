Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD9653A32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 01:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLVAy3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 19:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVAy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:54:28 -0500
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Dec 2022 16:54:25 PST
Received: from evolvis.org (evolvis.org [IPv6:2a02:a00:2000:f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC82253A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 16:54:24 -0800 (PST)
Received: from x61w.mirbsd.org (xdsl-78-35-194-223.nc.de [78.35.194.223])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by evolvis.org (Postfix) with ESMTPSA id 91511100381;
        Thu, 22 Dec 2022 00:53:13 +0000 (UTC)
Received: by x61w.mirbsd.org (Postfix, from userid 1000)
        id 218B660A35; Thu, 22 Dec 2022 01:53:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by x61w.mirbsd.org (Postfix) with ESMTP id 1C29960343;
        Thu, 22 Dec 2022 01:53:13 +0100 (CET)
Date:   Thu, 22 Dec 2022 01:53:13 +0100 (CET)
From:   Thorsten Glaser <tg@mirbsd.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
cc:     1024811@bugs.debian.org
Subject: Re: Bug#1024811: linux: /proc/[pid]/stat unparsable
In-Reply-To: <Y4Hshbyk9TEsSQsm@p183>
Message-ID: <d1f6877d-a084-2099-5764-979ee163eace@evolvis.org>
References: <166939644927.12906.17757536147994071219.reportbug@x61w.mirbsd.org> <Y4Hshbyk9TEsSQsm@p183>
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_40,SPF_HELO_PASS,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 26 Nov 2022, Alexey Dobriyan wrote:

>/proc never escaped "comm" field of /proc/*/stat.

Yes, that’s precisely the bug.

>To parse /proc/*/stat reliably, search for '(' from the beginning, then
>for ')' backwards. Everything in between parenthesis is "comm".

That’s not guaranteed to stay reliable: fields can be, and have
been in the past, added, and new %s fields will break this. Do
not rely on it either.

>Everything else are numbers separated by spaces.

Currently, yes.

But the field is *clearly* documented as intended to be
parsable by scanf(3), which splits on white space. So the
Linux kernel MUST encode embedded whitespace so the
documented(!) access method works.

bye,
//mirabilos
-- 
15:41⎜<Lo-lan-do:#fusionforge> Somebody write a testsuite for helloworld :-)
