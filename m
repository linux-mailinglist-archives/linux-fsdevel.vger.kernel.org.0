Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A2F32C568
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhCDAUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385364AbhCCRKG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:10:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39590AC24;
        Wed,  3 Mar 2021 17:09:22 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
To:     Pintu Kumar <pintu@codeaurora.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, iamjoonsoo.kim@lge.com,
        sh_def@163.com, mateusznosek0@gmail.com, bhe@redhat.com,
        nigupta@nvidia.com, yzaikin@google.com, keescook@chromium.org,
        mcgrof@kernel.org, mgorman@techsingularity.net
Cc:     pintu.ping@gmail.com
References: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <486d7af3-95a3-9701-f0f9-706ff49b99d1@suse.cz>
Date:   Wed, 3 Mar 2021 18:09:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/21 6:56 PM, Pintu Kumar wrote:
> The sysctl_compact_memory is mostly unsed in mm/compaction.c
> It just acts as a place holder for sysctl.
> 
> Thus we can remove it from here and move the declaration directly
> in kernel/sysctl.c itself.
> This will also eliminate the extern declaration from header file.
> No functionality is broken or changed this way.
> 
> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>

You should be able to remove the variable completely and set .data to NULL in
the corresponding entry. The sysctl_compaction_handler doesn't access it at all.

Then you could do the same with drop_caches. Currently
drop_caches_sysctl_handler currently writes to it, but that can be avoided using
a local variable - see how sysrq_sysctl_handler avoids the global variable and
its corresponding .data field is NULL.

Vlastimil


