Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389D73AB61A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhFQOjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 10:39:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48302 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFQOj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:39:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2072321B0D;
        Thu, 17 Jun 2021 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623940641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+fSxa1wG+88od46CsiBngCtNj3W4t4qd32uH/eMCnU=;
        b=weKQj/4xIvPMP+zMYOKvZZpgRcm9Khkjx3ysroKsxU558oST54zweTWK/lYYRMBzb5cqSW
        xozR+Ws4SfcfpFigwOSq+yOsMQtKftdtp/BdZLovXhH/wnI+vcXzGcEu7H0GR8AJADC7m3
        wRYGlfCRqMl5KCxq/XAjDkUXoESPKzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623940641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+fSxa1wG+88od46CsiBngCtNj3W4t4qd32uH/eMCnU=;
        b=S7Wo9IO+n3KLaMYkganyy+Hr/Yo+cHuQ4O/9DsDuC8ArqZdq452lq+AeSxFJ+JHhAPlgYk
        Og7k7wdHkN2MW7Dw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D488C118DD;
        Thu, 17 Jun 2021 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623940641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+fSxa1wG+88od46CsiBngCtNj3W4t4qd32uH/eMCnU=;
        b=weKQj/4xIvPMP+zMYOKvZZpgRcm9Khkjx3ysroKsxU558oST54zweTWK/lYYRMBzb5cqSW
        xozR+Ws4SfcfpFigwOSq+yOsMQtKftdtp/BdZLovXhH/wnI+vcXzGcEu7H0GR8AJADC7m3
        wRYGlfCRqMl5KCxq/XAjDkUXoESPKzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623940641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+fSxa1wG+88od46CsiBngCtNj3W4t4qd32uH/eMCnU=;
        b=S7Wo9IO+n3KLaMYkganyy+Hr/Yo+cHuQ4O/9DsDuC8ArqZdq452lq+AeSxFJ+JHhAPlgYk
        Og7k7wdHkN2MW7Dw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id zqwmMyBey2AhaQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Thu, 17 Jun 2021 14:37:20 +0000
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0d516cfa-f41c-5ccc-26aa-67871f23dcd3@suse.cz>
Date:   Thu, 17 Jun 2021 16:37:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0ca491e8-6d3a-6537-dfa0-ece5f3bb6a1e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/17/21 9:30 AM, Charan Teja Kalla wrote:
> Thanks Vlastimil for your inputs!!
> 
> On 6/16/2021 5:29 PM, Vlastimil Babka wrote:
>>> This triggering of proactive compaction is done on a write to
>>> sysctl.compaction_proactiveness by user.
>>>
>>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
>>>
>>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>>> ---
>>> changes in V2:
>> You forgot to also summarize the changes. Please do in next version.
> 
> I think we can get rid off 'proactive_defer' thread variable with the
> timeout approach you suggested. But it is still requires to have one
> additional variable 'proactive_compact_trigger', which main purpose is
> to decide if the kcompactd wakeup is for proactive compaction or not.
> Please see below code:
>    if (wait_event_freezable_timeout() && !proactive_compact_trigger) {
> 	// do the non-proactive work
> 	continue
>    }
>    // do the proactive work
>      .................
> 
> Thus I feel that on writing new proactiveness, it is required to do
> wakeup_kcomppactd() + set a flag that this wakeup is for proactive work.
> 
> Am I failed to get your point here?

The check whether to do non-proactive work is already guarded by
kcompactd_work_requested(), which looks at pgdat->kcompactd_max_order and this
is set by wakeup_kcompactd().

So with a plain wakeup where we don't set pgdat->kcompactd_max_order will make
it consider proactive work instead and we don't need another trigger variable
AFAICS.
