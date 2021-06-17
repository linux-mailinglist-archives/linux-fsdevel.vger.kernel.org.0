Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789C43AB963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhFQQUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 12:20:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhFQQTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:19:35 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E78E21B25;
        Thu, 17 Jun 2021 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623946646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAlFQCFoL81L/tLJBlboccsxVoDE0Z8vXNDI4pk2hvc=;
        b=HjXhwtnvK70Ue77X+pkfAYCkSnNc/Ck4f3yjsQ2QCQnCOoERnEZqvlHM0ScIuirw0MbqKf
        y6hGqJP9gMfED9vWn8JNbmnlJbHPOgVYuf/k+3QUO5YH94adMzUP8Y6jVRzUFN+OUVI86R
        8BT/+dXF8ldEYSLPZO3TwEdhw+VjTo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623946646;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAlFQCFoL81L/tLJBlboccsxVoDE0Z8vXNDI4pk2hvc=;
        b=bq/+cNPYZLBWucoLuxSdpD0cHwkHLJNp/eLXulhJxyXFRKjR7BD7WGsiwwNbsE0CJBscro
        +/rhHGsMbhSWD3Dg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id EF286118DD;
        Thu, 17 Jun 2021 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623946646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAlFQCFoL81L/tLJBlboccsxVoDE0Z8vXNDI4pk2hvc=;
        b=HjXhwtnvK70Ue77X+pkfAYCkSnNc/Ck4f3yjsQ2QCQnCOoERnEZqvlHM0ScIuirw0MbqKf
        y6hGqJP9gMfED9vWn8JNbmnlJbHPOgVYuf/k+3QUO5YH94adMzUP8Y6jVRzUFN+OUVI86R
        8BT/+dXF8ldEYSLPZO3TwEdhw+VjTo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623946646;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAlFQCFoL81L/tLJBlboccsxVoDE0Z8vXNDI4pk2hvc=;
        b=bq/+cNPYZLBWucoLuxSdpD0cHwkHLJNp/eLXulhJxyXFRKjR7BD7WGsiwwNbsE0CJBscro
        +/rhHGsMbhSWD3Dg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id BvI9OZV1y2B+IQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Thu, 17 Jun 2021 16:17:25 +0000
Subject: Re: [PATCH v3 1/2] mm: compaction: support triggering of proactive
 compaction by user
To:     Charan Teja Kalla <charante@codeaurora.org>,
        akpm@linux-foundation.org, nigupta@nvidia.com, hannes@cmpxchg.org,
        corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, aarcange@redhat.com, cl@linux.com,
        xi.fengfei@h3c.com, mchehab+huawei@kernel.org,
        andrew.a.klychkov@gmail.com, dave.hansen@linux.intel.com,
        bhe@redhat.com, iamjoonsoo.kim@lge.com, mateusznosek0@gmail.com,
        sh_def@163.com, vinmenon@codeaurora.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <cover.1622454385.git.charante@codeaurora.org>
 <7db6a29a64b29d56cde46c713204428a4b95f0ab.1622454385.git.charante@codeaurora.org>
 <88abfdb6-2c13-b5a6-5b46-742d12d1c910@suse.cz>
 <0ca491e8-6d3a-6537-dfa0-ece5f3bb6a1e@codeaurora.org>
 <0d516cfa-f41c-5ccc-26aa-67871f23dcd3@suse.cz>
 <8d91a81b-09f3-e814-c9ce-16ff246ed359@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <546f7169-5a9e-fe16-bd83-b0f7a338c3cf@suse.cz>
Date:   Thu, 17 Jun 2021 18:17:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8d91a81b-09f3-e814-c9ce-16ff246ed359@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/17/21 6:05 PM, Charan Teja Kalla wrote:
> The wait_event/freezable_timeout() documentation says that:
>  * Returns:
>  * 0 if the @condition evaluated to %false after the @timeout elapsed,
> 			or
>  * 1 if the @condition evaluated to %true after the @timeout elapsed,
>  * or the remaining jiffies (at least 1) if the @condition evaluated
>  * to %true before the @timeout elapsed.
> 
> which means the condition must be evaluated to true or timeout should be
> elapsed for the function wait_event_freezable_timeout() to return.
> 
> Please check the macro implementation of __wait_event, where it will be
> in for(;;) till the condition is evaluated to true or timeout happens.
> #define __wait_event_freezable_timeout(wq_head, condition, timeout)
> 
>         ___wait_event(wq_head, ___wait_cond_timeout(condition),
> 
>                       TASK_INTERRUPTIBLE, 0, timeout,
> 
>                       __ret = freezable_schedule_timeout(__ret))
> 
> Thus the plain wakeup of kcompactd don't do the proactive compact work.
> And so we should identify its wakeup for proactive work with a separate
> flag.

OK, you're right, I forgot that the macro has the for loop to guard against
spurious wakeups.

