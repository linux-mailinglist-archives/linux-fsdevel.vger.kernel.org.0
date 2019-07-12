Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E364067630
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfGLVZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 17:25:59 -0400
Received: from kich.slackware.pl ([193.218.152.244]:45170 "EHLO
        kich.slackware.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGLVZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:25:59 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 17:25:58 EDT
Received: from kich.toxcorp.com (kich.toxcorp.com [193.218.152.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shasta@toxcorp.com)
        by kich.slackware.pl (Postfix) with ESMTPSA id A8A09C1;
        Fri, 12 Jul 2019 23:17:03 +0200 (CEST)
Date:   Fri, 12 Jul 2019 23:17:03 +0200 (CEST)
From:   Jakub Jankowski <shasta@toxcorp.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
In-Reply-To: <3de2d71b-37be-6238-7fd8-0a40c9b94a98@ispras.ru>
Message-ID: <alpine.LNX.2.21.1907122312190.8869@kich.toxcorp.com>
References: <20190712160913.17727-1-izbyshev@ispras.ru> <20190712163625.GF21989@redhat.com> <20190712174632.GA3175@avx2> <3de2d71b-37be-6238-7fd8-0a40c9b94a98@ispras.ru>
User-Agent: Alpine 2.21 (LNX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-07-12, Alexey Izbyshev wrote:

> On 7/12/19 8:46 PM, Alexey Dobriyan wrote:
>> The proper fix to all /proc/*/cmdline problems is to revert
>>
>> 	f5b65348fd77839b50e79bc0a5e536832ea52d8d
>> 	proc: fix missing final NUL in get_mm_cmdline() rewrite
>>
>> 	5ab8271899658042fabc5ae7e6a99066a210bc0e
>> 	fs/proc: simplify and clarify get_mm_cmdline() function
>>
> Should this be interpreted as an actual suggestion to revert the patches,
> fix the conflicts, test and submit them, or is this more like thinking out
> loud? In the former case, will it be OK for long term branches?
>
> get_mm_cmdline() does seem easier to read for me before 5ab8271899658042.
> But it also has different semantics in corner cases, for example:
>
> - If there is no NUL at arg_end-1, it reads only the first string in
> the combined arg/env block, and doesn't terminate it with NUL.
>
> - If there is any problem with access_remote_vm() or copy_to_user(),
> it returns -EFAULT even if some data were copied to userspace.
>
> On the other hand, 5ab8271899658042 was merged not too long ago (about a year),
> so it's possible that the current semantics isn't heavily relied upon.

I posted this (corner?) case ~3 months ago, unfortunately it wasn't picked 
up by anyone: https://lkml.org/lkml/2019/4/5/825
You can treat it as another datapoint in this discussion.


Regards,
  Jakub

-- 
Jakub Jankowski|shasta@toxcorp.com|https://toxcorp.com/
