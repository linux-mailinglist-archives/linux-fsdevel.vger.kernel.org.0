Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33906562076
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiF3Qjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiF3Qjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:39:52 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B5286C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 09:39:52 -0700 (PDT)
Received: from [10.10.0.40] (unknown [76.130.91.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id 614173E880;
        Thu, 30 Jun 2022 16:39:51 +0000 (UTC)
Message-ID: <a4ea9789-6126-e058-8f55-6dfc8a3f30c3@openvpn.net>
Date:   Thu, 30 Jun 2022 10:39:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20220627221107.176495-1-james@openvpn.net>
 <Yrs7lh6hG44ERoiM@ZenIV>
 <CAOQ4uxgoZe8UUftRKf=b--YmrKJ4wdDX99y7G8U2WTuuVsyvdA@mail.gmail.com>
 <03ee39fa-7cfd-5155-3559-99ec8c8a2d32@openvpn.net>
 <20220629014323.GM1098723@dread.disaster.area>
 <165646842481.15378.14054777682756518611@noble.neil.brown.name>
 <20220629023557.GN1098723@dread.disaster.area>
From:   James Yonan <james@openvpn.net>
In-Reply-To: <20220629023557.GN1098723@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/22 20:35, Dave Chinner wrote:
> How do you explain it the API
> semantics to an app developer that might want to use this
> functionality? RENAME_EXCHANGE_WITH_NEWER would be atomic in the
> sense you either get the old or new file at the destination, but
> it's not atomic in the sense that it is serialised against all other
> potential modification operations against either the source or
> destination. Hence the "if newer" comparison is not part of the
> "atomic rename" operation that is supposedly being performed...

So the current proposal based on feedback is to move the mtime 
comparison to vfs_rename() to take advantage of existing 
{lock,unlock}_two_nondirectories critical section, then nest another 
critical section {deny,allow}_write_access (adapted to inodes) to 
stabilize the mtime.  The proposed use case never needs to compare 
mtimes of files that are open for write, and the plan would be to return 
-ETXTBSY in this case.

> I'm also sceptical of the use of mtime - we can't rely on mtime to
> determine the newer file accurately on all filesystems. e.g. Some
> fileystems only have second granularity in their timestamps, so
> there's a big window where "newer" cannot actually be determined by
> timestamp comparisons.
So in the "use a directory as a key/value store" use case in distributed 
systems, the file mtime is generally determined remotely by the file 
content creator and is set locally via futimens() rather than the local 
system clock.  So this gives you nanosecond scale time resolution if the 
content creator supports it, even if the system clock has less resolution.

James


