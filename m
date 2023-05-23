Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70770DCB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbjEWMhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjEWMho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:37:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC48DD;
        Tue, 23 May 2023 05:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBF2631E6;
        Tue, 23 May 2023 12:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AFFC433D2;
        Tue, 23 May 2023 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684845462;
        bh=IrFR6hSXFwTPIqL0va6YERj1ltruCOkzI1N56fCgPFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbcPp5Wk39tfRgN0F4hqRWr2z1n0SIKLjtFrqEbV6rdwWzWWBf41JaluXdPwngS7n
         YkP2M+MNrre1IqYdowqD2gvwspBlw+78DyFX72q66G+F/EgL87TSfBL03dsoLrD1qM
         au4VSvKklwQat8ncTYQIWu6YEu3YE2e8269d+DGcLRwFi/TP2lU7v9EbyBbjcrqMjT
         TfL44g4byc+ONKKhrrNPF7Del3TtLGY10AAIErkDGWFzW9t8m2z9qEjENI9kADmq1S
         RJahiUXw1uO7b7wkD3a2j0nrda5NEi0cA233jlDNrLclS7KunYJMBDqfAzEFmnY2a2
         OI0JXdTdk+PsQ==
Date:   Tue, 23 May 2023 14:37:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v21 2/6] block: Fix bio_flagged() so that gcc can better
 optimise it
Message-ID: <20230523-kommst-gewechselt-e7b94e891a12@brauner>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <20230522205744.2825689-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-3-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 09:57:40PM +0100, David Howells wrote:
> Fix bio_flagged() so that multiple instances of it, such as:
> 
> 	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
> 	    bio_flagged(bio, BIO_PAGE_PINNED))
> 
> can be combined by the gcc optimiser into a single test in assembly
> (arguably, this is a compiler optimisation issue[1]).
> 
> The missed optimisation stems from bio_flagged() comparing the result of
> the bitwise-AND to zero.  This results in an out-of-line bio_release_page()
> being compiled to something like:
> 
>    <+0>:     mov    0x14(%rdi),%eax
>    <+3>:     test   $0x1,%al
>    <+5>:     jne    0xffffffff816dac53 <bio_release_pages+11>
>    <+7>:     test   $0x2,%al
>    <+9>:     je     0xffffffff816dac5c <bio_release_pages+20>
>    <+11>:    movzbl %sil,%esi
>    <+15>:    jmp    0xffffffff816daba1 <__bio_release_pages>
>    <+20>:    jmp    0xffffffff81d0b800 <__x86_return_thunk>
> 
> However, the test is superfluous as the return type is bool.  Removing it
> results in:
> 
>    <+0>:     testb  $0x3,0x14(%rdi)
>    <+4>:     je     0xffffffff816e4af4 <bio_release_pages+15>
>    <+6>:     movzbl %sil,%esi
>    <+10>:    jmp    0xffffffff816dab7c <__bio_release_pages>
>    <+15>:    jmp    0xffffffff81d0b7c0 <__x86_return_thunk>
> 
> instead.
> 
> Also, the MOVZBL instruction looks unnecessary[2] - I think it's just
> 're-booling' the mark_dirty parameter.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-block@vger.kernel.org
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108370 [1]
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108371 [2]
> Link: https://lore.kernel.org/r/167391056756.2311931.356007731815807265.stgit@warthog.procyon.org.uk/ # v6
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
