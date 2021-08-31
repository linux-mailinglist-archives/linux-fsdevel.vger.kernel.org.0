Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D280C3FCD36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhHaSwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 14:52:05 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55006 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHaSwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:52:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:48582)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mL8qg-005rv9-7n; Tue, 31 Aug 2021 12:51:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39628 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mL8qd-005khz-UH; Tue, 31 Aug 2021 12:51:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <YSQSkSOWtJCE4g8p@cmpxchg.org>
        <YSQeFPTMn5WpwyAa@casper.infradead.org> <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
        <YSVMAS2pQVq+xma7@casper.infradead.org> <YSZeKfHxOkEAri1q@cmpxchg.org>
        <20210826004555.GF12597@magnolia> <YSjxlNl9jeEX2Yff@cmpxchg.org>
        <YSkyjcX9Ih816mB9@casper.infradead.org> <YS0WR38gCSrd6r41@cmpxchg.org>
        <YS0h4cFhwYoW3MBI@casper.infradead.org> <YS0/GHBG15+2Mglk@cmpxchg.org>
Date:   Tue, 31 Aug 2021 13:50:35 -0500
In-Reply-To: <YS0/GHBG15+2Mglk@cmpxchg.org> (Johannes Weiner's message of
        "Mon, 30 Aug 2021 16:27:04 -0400")
Message-ID: <87r1e95tz8.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mL8qd-005khz-UH;;;mid=<87r1e95tz8.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18eKAe35NzalvMqaiLGi59y7wlKRtQmiJs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Johannes Weiner <hannes@cmpxchg.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1505 ms - load_scoreonly_sql: 0.21 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 10 (0.6%), parse: 0.92
        (0.1%), extract_message_metadata: 13 (0.8%), get_uri_detail_list: 1.52
        (0.1%), tests_pri_-1000: 6 (0.4%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 157 (10.4%), check_bayes:
        153 (10.2%), b_tokenize: 7 (0.5%), b_tok_get_all: 8 (0.5%),
        b_comp_prob: 2.5 (0.2%), b_tok_touch_all: 133 (8.8%), b_finish: 0.89
        (0.1%), tests_pri_0: 1300 (86.4%), check_dkim_signature: 0.52 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 0.50 (0.0%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 9 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Memory folios for v5.15
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Mon, Aug 30, 2021 at 07:22:25PM +0100, Matthew Wilcox wrote:
>> On Mon, Aug 30, 2021 at 01:32:55PM -0400, Johannes Weiner wrote:
>> > > The mistake you're making is coupling "minimum mapping granularity" with
>> > > "minimum allocation granularity".  We can happily build a system which
>> > > only allocates memory on 2MB boundaries and yet lets you map that memory
>> > > to userspace in 4kB granules.
>> > 
>> > Yeah, but I want to do it without allocating 4k granule descriptors
>> > statically at boot time for the entirety of available memory.
>> 
>> Even that is possible when bumping the PAGE_SIZE to 16kB.  It needs a
>> bit of fiddling:
>> 
>> static int insert_page_into_pte_locked(struct mm_struct *mm, pte_t *pte,
>>                         unsigned long addr, struct page *page, pgprot_t prot)
>> {
>>         if (!pte_none(*pte))
>>                 return -EBUSY;
>>         /* Ok, finally just insert the thing.. */
>>         get_page(page);
>>         inc_mm_counter_fast(mm, mm_counter_file(page));
>>         page_add_file_rmap(page, false);
>>         set_pte_at(mm, addr, pte, mk_pte(page, prot));
>>         return 0;
>> }
>> 
>> mk_pte() assumes that a struct page refers to a single pte.  If we
>> revamped it to take (page, offset, prot), it could construct the
>> appropriate pte for the offset within that page.
>
> Right, page tables only need a pfn. The struct page is for us to
> maintain additional state about the object.
>
> For the objects that are subpage sized, we should be able to hold that
> state (shrinker lru linkage, referenced bit, dirtiness, ...) inside
> ad-hoc allocated descriptors.
>
> Descriptors which could well be what struct folio {} is today, IMO. As
> long as it doesn't innately assume, or will assume, in the API the
> 1:1+ mapping to struct page that is inherent to the compound page.

struct buffer_head any one?

I am being silly but when you say you want something that isn't a page
for caching that could be less than a page in size, it really sounds
like you want struct buffer_head.

The only actual problem I am aware of with struct buffer_head is that
it is a block device abstraction and does not map well to other
situations.  Which makes network filesystems unable to use struct
buffer_head.

Eric
