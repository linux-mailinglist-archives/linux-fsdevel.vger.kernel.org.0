Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD936FD18A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 23:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjEIViz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 17:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjEIVix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 17:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28A71739
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683668277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AS+fKVGuPLb0PNBw40EVQclmhLUg9m8EqlylUBoJ6/4=;
        b=MeoF/be6HPchD5I3cb9zg/F84DHtvKlQv6FjHC4AJOBfrKTmyG/Cu9aPVd82l+5/6iN7mA
        5CBjt5tf49NtbKkZXnkFxMypdj5SFvbgE60uCx7b7BAETjZc8xFc4fzTkRlpt4VPw3pDp+
        ycQxCXuTiyhu/qNmhMxESKVujOkPUDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-lCcqVZ60OkWva9VAe79vjw-1; Tue, 09 May 2023 17:37:56 -0400
X-MC-Unique: lCcqVZ60OkWva9VAe79vjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8CCF10115E0;
        Tue,  9 May 2023 21:37:55 +0000 (UTC)
Received: from [10.22.16.30] (unknown [10.22.16.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97775C15BA0;
        Tue,  9 May 2023 21:37:55 +0000 (UTC)
Message-ID: <a7fcd53a-7680-49c5-dd93-489d75126c8d@redhat.com>
Date:   Tue, 9 May 2023 17:37:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 03/32] locking/lockdep: lockdep_set_no_check_recursion()
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-4-kent.overstreet@linux.dev>
 <20230509193147.GC2148518@hirez.programming.kicks-ass.net>
 <ZFqqsyDpatgb77Vh@moria.home.lan>
 <d5b65b01-62a9-e483-dea8-5e2bb65be278@redhat.com>
 <ZFquoxJn1RzWhRiI@moria.home.lan>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZFquoxJn1RzWhRiI@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/23 16:35, Kent Overstreet wrote:
> On Tue, May 09, 2023 at 04:27:46PM -0400, Waiman Long wrote:
>> On 5/9/23 16:18, Kent Overstreet wrote:
>>> On Tue, May 09, 2023 at 09:31:47PM +0200, Peter Zijlstra wrote:
>>>> On Tue, May 09, 2023 at 12:56:28PM -0400, Kent Overstreet wrote:
>>>>> This adds a method to tell lockdep not to check lock ordering within a
>>>>> lock class - but to still check lock ordering w.r.t. other lock types.
>>>>>
>>>>> This is for bcachefs, where for btree node locks we have our own
>>>>> deadlock avoidance strategy w.r.t. other btree node locks (cycle
>>>>> detection), but we still want lockdep to check lock ordering w.r.t.
>>>>> other lock types.
>>>>>
>>>> ISTR you had a much nicer version of this where you gave a custom order
>>>> function -- what happend to that?
>>> Actually, I spoke too soon; this patch and the other series with the
>>> comparison function solve different problems.
>>>
>>> For bcachefs btree node locks, we don't have a defined lock ordering at
>>> all - we do full runtime cycle detection, so we don't want lockdep
>>> checking for self deadlock because we're handling that but we _do_ want
>>> lockdep checking lock ordering of btree node locks w.r.t. other locks in
>>> the system.
>> Maybe you can use lock_set_novalidate_class() instead.
> No, we want that to go away, this is the replacement.

OK, you can mention that in the commit log then.

Cheers,
Longman

