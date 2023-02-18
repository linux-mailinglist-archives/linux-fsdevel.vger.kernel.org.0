Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D2C69BDF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Feb 2023 00:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBRXlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 18:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRXlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:41:17 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44813D66;
        Sat, 18 Feb 2023 15:41:16 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0C39FC01D; Sun, 19 Feb 2023 00:41:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676763698; bh=HAUEnvBlrX3pgMjJsHk6fkvC7qMVL5+b0htLmoE8se0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQDdPq4QR9bi2ivS7nZhHaesdDfafQwgzmQ1aPKsFISaOb7micdmz3nYNzbWzH9Yl
         DbXrEAjefJnA1W2TtpNwlCZ+VYt1Tg8o2VeHXuW9CJVA1I5wObU/ylp3f32CIP87w9
         n/8AyA8zZsuBh+J1ZUCmYwRxKtREvUrpFWEuvNzk/mq7szdw5TrdYd3cN5YofvZTdX
         IFbvycvf1F9hjtoY0zv+6EktInLiffn20Vs6fm1s8FzivZ+gmX0M8kTaeI9VzMvIWC
         FaeQnnOiuME5peJKKhvRUNmi1+dNCV8/ItAQxqDoj891VWV5Mm5+X2w+DwPoem0Qfo
         OrG8DqNvTEVnw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id EAAB3C009;
        Sun, 19 Feb 2023 00:41:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676763697; bh=HAUEnvBlrX3pgMjJsHk6fkvC7qMVL5+b0htLmoE8se0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsyLK2w/1io4fNdrRIb2eNuiOejlLmWvTCUDsmODdYcRObVGmmABkQzDih+L6cwVn
         Kg0bt94PdK+O/a70+ETjouq30gCWEHI36WS5MGLntu0FERiEgo9SXV2SovEka4KArn
         Qv6kavd6IQYp+ph695I8GJUQYMb0GeBN3zwGtLgs4tnNfmv7f1t53r6mgVOlv7+xw+
         Q4hl3UZbQdoDkGF71MBoqlul/4WZIGgOQwCAbzhCpoCZTetkGqqEcryncjZ0lzgMtm
         Ia7rIF3lf0LmPa0qhOynhlAxEf5Cw7s//U3vatrV+MjxkrJtcUpzKhCM2D26OY3zib
         4G6rzn2gWyZLA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 03fa2c52;
        Sat, 18 Feb 2023 23:41:08 +0000 (UTC)
Date:   Sun, 19 Feb 2023 08:40:53 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 10/11] fs/9p: writeback mode fixes
Message-ID: <Y/FiBbMQcEblQ/XR@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-11-ericvh@kernel.org>
 <Y/Ch8o/6HVS8Iyeh@codewreck.org>
 <1983433.kCcYWV5373@silver>
 <CAFkjPT=xhEEedeYcyn1FFcngqOJf_+8ynz4zeLbsXPOGoY6aqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFkjPT=xhEEedeYcyn1FFcngqOJf_+8ynz4zeLbsXPOGoY6aqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 04:24:08PM -0600:
> Yeah, I guess it depends on what options we want to separate,
> writeback == mmap so we can eliminate one option and just use mmap I
> suppose.

For history (since I implemented it for CEA back then), mmap was added
because we had applications relying on mmap (so wanted that to somehow
work) without turning to cache=loose as that doesn't behave well with
nfs-ganesha (in particular, fids not closed until memory pressure comes
reclaiming them, which can be very late or never come, doesn't work well
with ganesha that used to (and probably still does, didn't check) cap
the maximum number of fid active per client.

I think writeback would be acceptable for this usecase, especially since
with your patches we now flush on close.

For clarity though I'd use writeback in the documentation, and keep mmap
as a legacy mapping just for mount opts parsing; the behaviour is
slightly different than it used to be (normal read/writes were sync) so
it's good to be clear about that.

> I feel like readahead has value as it maintains the most
> consistency on the host file system since it shouldn't be doing any
> writeback buffering.  readahead and mmap are different than loose in
> that they don't do any do any dir cache.  To your earlier comments (in
> a different thread) it very well may be that eventually we separate
> these into file_cache=[ readahead | mmap | loose ] and dir_cache = [
> tight | temporal | loose ] and fscache is its own beast.

Separating the two makes sense implementation-wise as well, I like this
idea.
What would the difference be between file_cache=writeback and loose?
Do you plan some form of revalidation with writeback, e.g. using qid
version that loose wouldn't do? (sorry if it's already done, I don't
recall seeing that)

fscache is currently a cache option but it's pretty much unrelated, we
can have it as a separate option and alias cache=fscache to
`file_cache=writeback(loose),dir_cache=loose,fscache=on`
but on its own it ought to work with any level of file_cache and no
dir_cache...
The test matrix will be fun, though :|

> It struck me as well with xattr enabled we may want to have separate
> caches for xattr caching since it generates a load of traffic with
> security on.

xattr caching currently isn't done at all afaik, and it'd definitely
make sense with any kind of dir_cache... That'd likely halve the
requests for some find-like workloads.
Probably another new option as well..

-- 
Dominique
