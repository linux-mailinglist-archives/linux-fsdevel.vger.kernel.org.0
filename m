Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2202969AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 08:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375305AbgJWGWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 02:22:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S375300AbgJWGWL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:22:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0753CACE6;
        Fri, 23 Oct 2020 06:22:10 +0000 (UTC)
Subject: Re: [RFC] synchronous readpage for buffer_heads
To:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201022152256.GU20115@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <25528b1a-7434-62cb-705a-7269d050bbc1@suse.de>
Date:   Fri, 23 Oct 2020 08:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022152256.GU20115@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/20 5:22 PM, Matthew Wilcox wrote:
> I'm working on making readpage synchronous so that it can actually return
> errors instead of futilely setting PageError.  Something that's common
> between most of the block based filesystems is the need to submit N
> I/Os and wait for them to all complete (some filesystems don't support
> sub-page block size, so they don't have this problem).
> 
> I ended up coming up with a fairly nice data structure which I've called
> the blk_completion.  It waits for 'n' events to happen, then wakes the
> task that cares, unless the task has got bored and wandered off to do
> something else.
> 
> block_read_full_page() then uses this data structure to submit 'n' buffer
> heads and wait for them to all complete.  The fscrypt code doesn't work
> in this scheme, so I bailed on that for now.  I have ideas for fixing it,
> but they can wait.
> 
> Obviously this all needs documentation, but I'd like feedback on the
> idea before I do that.  I have given it some light testing, but there
> aren't too many filesystems left that use block_read_full_page() so I
> haven't done a proper xfstests run.
> 
Hmm. You are aware, of course, that hch et al are working on replacing 
bhs with iomap, right?
So wouldn't it be more useful to concentrate on the iomap code, and 
ensure that _that_ is working correctly?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
