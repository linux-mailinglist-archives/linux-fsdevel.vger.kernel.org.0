Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC75B821F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiINHlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINHlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:41:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB50972B53;
        Wed, 14 Sep 2022 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663141269; x=1694677269;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5rRWCvywlUXdhqWUteBuY+K68wd0DLGVaPN2d1JfXdw=;
  b=I5cEfBhZd/yDrhA5KM3MAkpSq2FJSEBEt3jX64Y4axWju5ApT+r0zkjR
   C3EV9qEYcWAhy3DjufuvX/+pk3Rdajg8yIFCZO6/6DbCJYN7w1nGRxR/B
   5MQs+VBAVrP3I6JUVDfzmRGC8H68hkizF764eyvjsRztDJ4aonD9DRnmV
   THl+jyGYL0dGipKldkJTeGuoQQ36LiU+ur6ZlGDjawXCuSrTevzZh555/
   ZHDtD33XepYlH3NndcAIV03T9MzxJuTIi6q0rMHKLxv6dZAU8DNZ3FpG0
   OLTeLnz10DBhZHEEKIyoHe8DyrhLueS/RoFp5dBsN62KMWJXuMLJaQrTB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278749620"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="278749620"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 00:41:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="647283158"
Received: from debbiedx-mobl.ger.corp.intel.com (HELO [10.213.238.97]) ([10.213.238.97])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 00:40:57 -0700
Message-ID: <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
Date:   Wed, 14 Sep 2022 00:40:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC 1/1] mm: Add per-task struct tlb counters
Content-Language: en-US
To:     Joe Damato <jdamato@fastly.com>, x86@kernel.org,
        linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
 <1663120270-2673-2-git-send-email-jdamato@fastly.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1663120270-2673-2-git-send-email-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/13/22 18:51, Joe Damato wrote:
> TLB shootdowns are tracked globally, but on a busy system it can be
> difficult to disambiguate the source of TLB shootdowns.
> 
> Add two counter fields:
> 	- nrtlbflush: number of tlb flush events received
> 	- ngtlbflush: number of tlb flush events generated
> 
> Expose those fields in /proc/[pid]/stat so that they can be analyzed
> alongside similar metrics (e.g. min_flt and maj_flt).

On x86 at least, we already have two other ways to count flushes.  You
even quoted them with your patch:

>  	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
> +	current->ngtlbflush++;
>  	if (info->end == TLB_FLUSH_ALL)
>  		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);

Granted, the count_vm_tlb...() one is debugging only.  But, did you try
to use those other mechanisms?  For instance, could you patch
count_vm_tlb_event()?  Why didn't the tracepoints work for you?

Can this be done in a more arch-generic way?  It's a shame to
unconditionally add counters to the task struct and only use them on
x86.  If someone wanted to generalize the x86 tracepoints, or make them
available to other architectures, I think that would be fine even if
they have to change a bit (queue the inevitable argument about
tracepoint ABI).

P.S. I'm not a fan of the structure member naming.
