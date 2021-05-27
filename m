Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FEA3928E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhE0HtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 03:49:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54058 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbhE0Hs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 03:48:56 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 03:48:55 EDT
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B39AF218DD;
        Thu, 27 May 2021 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622101311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ttE23UWAFNVZ79voJwxcR9BZTIr+cGS5rkk0rMZAv4=;
        b=G37Rd2Tl9nmQmo/aSnHsfaxoVuJG1gpZDW/+7zIsNaJD73F6mKMwY8BAWS3atZSFjRq9U1
        q0cqkNLwbfrheSF3otx/7lWDVPtkHs+puLD3YmTciEnKDhgay24iVTl7wdjjIec7JAS0dt
        ThHonE2EnIdnEWo5Qpy4Va4BiYj4uyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622101311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ttE23UWAFNVZ79voJwxcR9BZTIr+cGS5rkk0rMZAv4=;
        b=0aHPCyCS6WhEkAtclxXHAn4zgLcfsCll1qrl0BdnA057x2WxMF3dvQY6Nfq4MbQnpuLevZ
        L/2M2m9lLskm1GCQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 965C711A98;
        Thu, 27 May 2021 07:41:51 +0000 (UTC)
To:     Keith Busch <kbusch@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <YJlzwcADaxO/JHRE@casper.infradead.org>
 <YJ636tQhuc9X7ZzR@casper.infradead.org>
 <20210526210742.GA3706388@dhcp-10-100-145-180.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [LSF/MM/BPF TOPIC] Memory folios
Message-ID: <97698689-0a18-81e0-a0ff-b4f92e56be5b@suse.de>
Date:   Thu, 27 May 2021 09:41:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210526210742.GA3706388@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/21 11:07 PM, Keith Busch wrote:
> On Fri, May 14, 2021 at 06:48:26PM +0100, Matthew Wilcox wrote:
>> On Mon, May 10, 2021 at 06:56:17PM +0100, Matthew Wilcox wrote:
>>> I don't know exactly how much will be left to discuss about supporting
>>> larger memory allocation units in the page cache by December.  In my
>>> ideal world, all the patches I've submitted so far are accepted, I
>>> persuade every filesystem maintainer to convert their own filesystem
>>> and struct page is nothing but a bad memory by December.  In reality,
>>> I'm just not that persuasive.
>>>
>>> So, probably some kind of discussion will be worthwhile about
>>> converting the remaining filesystems to use folios, when it's worth
>>> having filesystems opt-in to multi-page folios, what we can do about
>>> buffer-head based filesystems, and so on.
>>>
>>> Hopefully we aren't still discussing whether folios are a good idea
>>> or not by then.
>>
>> I got an email from Hannes today asking about memory folios as they
>> pertain to the block layer, and I thought this would be a good chance
>> to talk about them.  If you're not familiar with the term "folio",
>> https://lore.kernel.org/lkml/20210505150628.111735-10-willy@infradead.org/
>> is not a bad introduction.
>>
>> Thanks to the work done by Ming Lei in 2017, the block layer already
>> supports multipage bvecs, so to a first order of approximation, I don't
>> need anything from the block layer on down through the various storage
>> layers.  Which is why I haven't been talking to anyone in storage!
>>
>> It might change (slightly) the contents of bios.  For example,
>> bvec[n]->bv_offset might now be larger than PAGE_SIZE.  Drivers should
>> handle this OK, but probably haven't been audited to make sure they do.
>> Mostly, it's simply that drivers will now see fewer, larger, segments
>> in their bios.  Once a filesystem supports multipage folios, we will
>> allocate order-N pages as part of readahead (and sufficiently large
>> writes).  Dirtiness is tracked on a per-folio basis (not per page),
>> so folios take trips around the LRU as a single unit and finally make
>> it to being written back as a single unit.
>>
>> Drivers still need to cope with sub-folio-sized reads and writes.
>> O_DIRECT still exists and (eg) doing a sub-page, block-aligned write
>> will not necessarily cause readaround to happen.  Filesystems may read
>> and write their own metadata at whatever granularity and alignment they
>> see fit.  But the vast majority of pagecache I/O will be folio-sized
>> and folio-aligned.
>>
>> I do have two small patches which make it easier for the one
>> filesystem that I've converted so far (iomap/xfs) to add folios to bios
>> and get folios back out of bios:
>>
>> https://lore.kernel.org/lkml/20210505150628.111735-72-willy@infradead.org/
>> https://lore.kernel.org/lkml/20210505150628.111735-73-willy@infradead.org/
>>
>> as well as a third patch that estimates how large a bio to allocate,
>> given the current folio that it's working on:
>> https://git.infradead.org/users/willy/pagecache.git/commitdiff/89541b126a59dc7319ad618767e2d880fcadd6c2
>>
>> It would be possible to make other changes in future.  For example, if
>> we decide it'd be better, we could change bvecs from being (page, offset,
>> length) to (folio, offset, length).  I don't know that it's worth doing;
>> it would need to be evaluated on its merits.  Personally, I'd rather
>> see us move to a (phys_addr, length) pair, but I'm a little busy at the
>> moment.
>>
>> Hannes has some fun ideas about using the folio work to support larger
>> sector sizes, and I think they're doable.
> 
> I'm also interested in this, and was looking into the exact same thing
> recently. Some of the very high capacity SSDs that can really benefit
> from better large sector support. If this is a topic for the conference,
> I would like to attend this session.
> 
And, of course, so would I :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
