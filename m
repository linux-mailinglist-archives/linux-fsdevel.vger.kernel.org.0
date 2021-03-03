Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206B432C538
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447271AbhCDATs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:48 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:29622 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234161AbhCCMjK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:39:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614775122; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PtMq7GNMoeu6+0qiGV3pBsJu4dFPWHqMkKNpr2j9aPE=;
 b=TVsgglTCOfyOCSQr39qnOLAdZwq7WIznyNgh/iX2cbWoyLtVzWajExUeHO6TCvtW6lLL0YCt
 MTjYmnP3XL5+SdCEIbCZUT7O56SAGgoEN6yl8kyRkbiTeUlzheLIL9Xq9WDnndY12ZKLycTU
 96HEZAssnEzPSPAnTCygLk9ZOwE=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 603f804439ef372114108b55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 12:25:40
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74DDEC43465; Wed,  3 Mar 2021 12:25:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7AA2FC433CA;
        Wed,  3 Mar 2021 12:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Mar 2021 17:55:38 +0530
From:   pintu@codeaurora.org
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, jaewon31.kim@samsung.com,
        yuzhao@google.com, shakeelb@google.com, guro@fb.com,
        mchehab+huawei@kernel.org, xi.fengfei@h3c.com,
        lokeshgidra@google.com, nigupta@nvidia.com, famzheng@amazon.com,
        andrew.a.klychkov@gmail.com, bigeasy@linutronix.de,
        ping.ping@gmail.com, vbabka@suse.cz, yzaikin@google.com,
        keescook@chromium.org, mcgrof@kernel.org, corbet@lwn.net,
        pintu.ping@gmail.com
Subject: Re: [PATCH] mm: introduce clear all vm events counters
In-Reply-To: <YD5gFYalXJh0dMLn@cmpxchg.org>
References: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
 <YD0EOyW3pZXDnuuJ@cmpxchg.org>
 <419bb403c33b7e48291972df938d0cae@codeaurora.org>
 <YD5gFYalXJh0dMLn@cmpxchg.org>
Message-ID: <2f816fe9682d9b066ba630951db75eac@codeaurora.org>
X-Sender: pintu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-03-02 21:26, Johannes Weiner wrote:
> On Tue, Mar 02, 2021 at 04:00:34PM +0530, pintu@codeaurora.org wrote:
>> On 2021-03-01 20:41, Johannes Weiner wrote:
>> > On Mon, Mar 01, 2021 at 04:19:26PM +0530, Pintu Kumar wrote:
>> > > At times there is a need to regularly monitor vm counters while we
>> > > reproduce some issue, or it could be as simple as gathering some
>> > > system
>> > > statistics when we run some scenario and every time we like to start
>> > > from
>> > > beginning.
>> > > The current steps are:
>> > > Dump /proc/vmstat
>> > > Run some scenario
>> > > Dump /proc/vmstat again
>> > > Generate some data or graph
>> > > reboot and repeat again
>> >
>> > You can subtract the first vmstat dump from the second to get the
>> > event delta for the scenario run. That's what I do, and I'd assume
>> > most people are doing. Am I missing something?
>> 
>> Thanks so much for your comments.
>> Yes in most cases it works.
>> 
>> But I guess there are sometimes where we need to compare with fresh 
>> data
>> (just like reboot) at least for some of the counters.
>> Suppose we wanted to monitor pgalloc_normal and pgfree.
> 
> Hopefully these would already be balanced out pretty well before you
> run a test, or there is a risk that whatever outstanding allocations
> there are can cause a large number of frees during your test that
> don't match up to your recorded allocation events. Resetting to zero
> doesn't eliminate the risk of such background noise.
> 
>> Or, suppose we want to monitor until the field becomes non-zero..
>> Or, how certain values are changing compared to fresh reboot.
>> Or, suppose we want to reset all counters after boot and start 
>> capturing
>> fresh stats.
> 
> Again, there simply is no mathematical difference between
> 
> 	reset events to 0
> 	run test
> 	look at events - 0
> 
> and
> 
> 	read events baseline
> 	run test
> 	look at events - baseline
> 
>> Some of the counters could be growing too large and too fast. Will 
>> there be
>> chances of overflow ?
>> Then resetting using this could help without rebooting.
> 
> Overflows are just a fact of life on 32 bit systems. However, they can
> also be trivially handled - you can always subtract a ulong start
> state from a ulong end state and get a reliable delta of up to 2^32
> events, whether the end state has overflowed or not.
> 
> The bottom line is that the benefit of this patch adds a minor
> convenience for something that can already be done in userspace. But
> the downside is that there would be one more possible source of noise
> for kernel developers to consider when looking at a bug report. Plus
> the extra code and user interface that need to be maintained.
> 
> I don't think we should merge this patch.

Okay no problem.Thank you so much for your review and feedback.
Yes I agree the benefits are minor but I thought might be useful for 
someone somewhere.
I worked on it and found it easy and convinient and thus proposed it.
If others feel not important I am okay to drop it.

Thanks once again to all who helped to review it.

