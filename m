Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64A86C767D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 05:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCXEP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 00:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXEPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:15:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB651EFD7;
        Thu, 23 Mar 2023 21:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eGB7JpsOaBpIpzEUN6AbGsSMNTdxvAc6JD8Om1klY6I=; b=i98wTP/6hqoGRxMbfLPai14/w4
        u7wCgGOSqq6htQrKW2AJiYwoabtccWy4SV5IX6FMfZ+ROUtknX7d45BDay/DpBLYX1hihqMRXwGF/
        0bWj3lT0f0DDZ9hn7nyscQT1bv1gmet1gjwIriTFy7CEJYK7byZbaDF5Rd1eMrcYpppjCm0YrqYzo
        bcgY9gaj+OT6J6hl8kdi0PnnV5cL02BCVM6B1c9Q5lFBwaQ9lfL5Z/Wpl8pqtRJ10GutZ30w+qjGl
        PahB+63ugjWcJc88gCtW7vIP/aiR4PQs2TO8L0yZO4qvxo4uGnYPVroOMvDtsYDus0a0fCmp9EQDc
        6wI19HqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfYph-004Yxn-4R; Fri, 24 Mar 2023 04:15:17 +0000
Date:   Fri, 24 Mar 2023 04:15:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/31] ext4: Convert ext4_journalled_zero_new_buffers()
 to use a folio
Message-ID: <ZB0j1WZOI/ZvdtEo@casper.infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-20-willy@infradead.org>
 <20230314224619.GF860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314224619.GF860405@mit.edu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:46:19PM -0400, Theodore Ts'o wrote:
> On Thu, Jan 26, 2023 at 08:24:03PM +0000, Matthew Wilcox (Oracle) wrote:
> > Remove a call to compound_head().
> 
> Same question as with other commits, plus one more; why is it notable
> that calls to compound_head() are being reduced.  I've looked at the
> implementation, and it doesn't look all _that_ heavyweight....

It gets a lot more heavyweight when you turn on
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP, which more and more distro
kernels are doing, because it's such a win for VM host kernels.
eg SuSE do it here:
https://github.com/SUSE/kernel-source/blob/master/config/x86_64/default
and UEK does it here:
https://github.com/oracle/linux-uek/blob/uek7/ga/uek-rpm/ol9/config-x86_64
Debian also has it enabled.

It didn't use to be so expensive, but now it's something like 50-60
bytes of text per invocation on x86 [1].  And the compiler doesn't get
to remember the result of calling compound_head() because we might have
changed page->compound_head between invocations.  It doesn't even know
that compound_head() is idempotent.

Anyway, each of these patches can be justified as "This patch shrinks
the kernel by 0.0001%".  Of course my real motivation for doing this
is to reduce the number of callers of the page APIs so we can start to
remove them and lessen the cognitive complexity of having both page &
folio APIs that parallel each other.  And I would like ext4 to support
large folios sometime soon, and it's a step towards that goal too.
But that's a lot to write out in each changelog.

[1] For example, the disassembly of unlock_page() with the UEK
config:

  c0:   f3 0f 1e fa             endbr64
  c4:   e8 00 00 00 00          call   c9 <unlock_page+0x9>
                        c5: R_X86_64_PLT32      __fentry__-0x4
  c9:   55                      push   %rbp
  ca:   48 8b 47 08             mov    0x8(%rdi),%rax
  ce:   48 89 e5                mov    %rsp,%rbp
  d1:   a8 01                   test   $0x1,%al
  d3:   75 2f                   jne    104 <unlock_page+0x44>
  d5:   eb 0b                   jmp    e2 <unlock_page+0x22>
  d7:   e8 00 00 00 00          call   dc <unlock_page+0x1c>
                        d8: R_X86_64_PLT32      folio_unlock-0x4
  dc:   5d                      pop    %rbp
  dd:   e9 00 00 00 00          jmp    e2 <unlock_page+0x22>
                        de: R_X86_64_PLT32      __x86_return_thunk-0x4
  e2:   f7 c7 ff 0f 00 00       test   $0xfff,%edi
  e8:   75 ed                   jne    d7 <unlock_page+0x17>
  ea:   48 8b 07                mov    (%rdi),%rax
  ed:   a9 00 00 01 00          test   $0x10000,%eax
  f2:   74 e3                   je     d7 <unlock_page+0x17>
  f4:   48 8b 47 48             mov    0x48(%rdi),%rax
  f8:   48 8d 50 ff             lea    -0x1(%rax),%rdx
  fc:   a8 01                   test   $0x1,%al
  fe:   48 0f 45 fa             cmovne %rdx,%rdi
 102:   eb d3                   jmp    d7 <unlock_page+0x17>
 104:   48 8d 78 ff             lea    -0x1(%rax),%rdi
 108:   e8 00 00 00 00          call   10d <unlock_page+0x4d>
                        109: R_X86_64_PLT32     folio_unlock-0x4
 10d:   5d                      pop    %rbp
 10e:   e9 00 00 00 00          jmp    113 <unlock_page+0x53>
                        10f: R_X86_64_PLT32     __x86_return_thunk-0x4
 113:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
 11a:   00 00 00 00
 11e:   66 90                   xchg   %ax,%ax

Everything between 0xd3 and 0x104 is "maybe it's a fake head".  That's 41
bytes as a minimum per callsite, and typically it's much more becase we
also need the test for PageTail and the lea for the actual compound_head.
