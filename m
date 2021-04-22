Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2443936843D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhDVP4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 11:56:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:43700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVP4I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:56:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8607AB077;
        Thu, 22 Apr 2021 15:55:32 +0000 (UTC)
Subject: Re: (in)consistency of page/folio function naming
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210422032051.GM3596236@casper.infradead.org>
 <ee5148a4-1552-5cf0-5e56-9303311fb2ef@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4fd02ffb-7433-b482-bb1b-81aa3ef1a7e8@suse.cz>
Date:   Thu, 22 Apr 2021 17:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <ee5148a4-1552-5cf0-5e56-9303311fb2ef@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/22/21 11:09 AM, David Hildenbrand wrote:
> On 22.04.21 05:20, Matthew Wilcox wrote:
>>
>> I'm going through my patch queue implementing peterz's request to rename
>> FolioUptodate() as folio_uptodate().  It's going pretty well, but it
>> throws into relief all the places where we're not consistent naming
>> existing functions which operate on pages as page_foo().  The folio
>> conversion is a great opportunity to sort that out.  Mostly so far, I've
>> just done s/page/folio/ on function names, but there's the opportunity to
>> regularise a lot of them, eg:
>>
>>     put_page        folio_put
>>     lock_page        folio_lock
>>     lock_page_or_retry    folio_lock_or_retry
>>     rotate_reclaimable_page    folio_rotate_reclaimable
>>     end_page_writeback    folio_end_writeback
>>     clear_page_dirty_for_io    folio_clear_dirty_for_io
>>
>> Some of these make a lot of sense -- eg when ClearPageDirty has turned
>> into folio_clear_dirty(), having folio_clear_dirty_for_io() looks regular.
>> I'm not entirely convinced about folio_lock(), but folio_lock_or_retry()
>> makes more sense than lock_page_or_retry().  Ditto _killable() or
>> _async().
>>
>> Thoughts?
> 
> I tend to like prefixes: they directly set the topic.

Agreed.

> The only thing I'm concerned is that we end up with
> 
> put_page vs. folio_put
> 
> which is suboptimal.

If we start differing from page's CamelCase, then we can start differing in this
as well. Should be fine if the long-term goal is to convert as much from pages
to folios as possible. Perhaps the remaining page usages could then be converted
too for consistency as there won't be many left?


