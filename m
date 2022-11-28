Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8948B63A63F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 11:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiK1KiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 05:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiK1KiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:38:03 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017313FA8;
        Mon, 28 Nov 2022 02:37:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669631807; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=f7Vkrq9jkn0HdgdrF+Wh4ncq+GGSsebcyRYBNsqcYTHRclUJfK6GZePbRmQDC0pmLvF4cIbYkjB0tjmOqAjT9DuNtyXkv/v0BL2whbqlr60zcCG6YUti8RD9JBSyPwKA7OrvVudPVnUUzC1+RRdVg3I7NG9b2jZll5jPewQ9nn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1669631807; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tnLz2qpKPI3vYwMGy9lOfRIw4je11ytpVT+lhHW/+Qg=; 
        b=MVkIZcWesgBR1eRTLS74wg54CR+GOa4tXB5fkrfalio75ubmQPbOPgSq0R7/dtlLXFGMmkSamKwP/onRlzpthjsZsufD7VSDUI7lqlM70QQjLmw7DWXAHrQUJrF+QtKnyB0IHAKnVn3OS7RwWXRZ3VJb9dmEkVWyTb/SqdRdS+k=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669631807;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=tnLz2qpKPI3vYwMGy9lOfRIw4je11ytpVT+lhHW/+Qg=;
        b=tfokIDKX5BgrbyGBN6WgA9XNMY5994pwLNdGxOGtdG6KNNb8kRC1PN5mtsFbg+ep
        nybrNGyYVe+LUU3ElQbK8TKlTx6LgXYMgz2E0ljqcqyTt/RPpizIfmXlWhJUseqV8Ng
        eXUHnFJeGQ+6Jgmmla5h2oyEhsqCgTWrfczIBaTw=
Received: from [192.168.1.9] (106.201.114.188 [106.201.114.188]) by mx.zoho.in
        with SMTPS id 1669631805587181.18913226273196; Mon, 28 Nov 2022 16:06:45 +0530 (IST)
Message-ID: <6a22e287-9d90-85a9-f5e6-49e600bf0d80@siddh.me>
Date:   Mon, 28 Nov 2022 16:06:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RESEND PATCH v2 0/2] watch_queue: Clean up some code
From:   Siddh Raman Pant <code@siddh.me>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        keyrings <keyrings@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <cover.1668248462.git.code@siddh.me>
Content-Language: en-US, en-GB, hi-IN
In-Reply-To: <cover.1668248462.git.code@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 12 Nov 2022 16:00:39 +0530, Siddh Raman Pant wrote:
> There is a dangling reference to pipe in a watch_queue after clearing it.
> Thus, NULL that pointer while clearing.
> 
> This change renders wqueue->defunct superfluous, as the latter is only used
> to check if watch_queue is cleared. With this change, the pipe is NULLed
> while clearing, so we can just check if the pipe is NULL.
> 
> Extending comment for watch_queue->pipe in the definition of watch_queue
> made the comment conventionally too long (it was already past 80 chars),
> so I have changed the struct annotations to be kerneldoc-styled, so that
> I can extend the comment mentioning that the pipe is NULL when watch_queue
> is cleared. In the process, I have also hopefully improved documentation
> by documenting things which weren't documented before.
> 
> Changes in v2:
> - Merged the NULLing and removing defunct patches.
> - Removed READ_ONCE barrier in lock_wqueue().
> - Improved and fixed errors in struct docs.
> - Better commit messages.
> 
> Original date of posting patch: 6 Aug 2022
> 
> Siddh Raman Pant (2):
>   include/linux/watch_queue: Improve documentation
>   kernel/watch_queue: NULL the dangling *pipe, and use it for clear
>     check
> 
>  include/linux/watch_queue.h | 100 ++++++++++++++++++++++++++----------
>  kernel/watch_queue.c        |  12 ++---
>  2 files changed, 79 insertions(+), 33 deletions(-)
> 

Hi,

Please review the quoted patches, which can be found on:
https://lore.kernel.org/all/cover.1668248462.git.code@siddh.me/

Please let me know if any changes are required.

Thanks,
Siddh
