Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141666781FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjAWQnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjAWQnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:43:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D72BF38;
        Mon, 23 Jan 2023 08:42:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E330F1F45B;
        Mon, 23 Jan 2023 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674492138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1U4rA+VoFO9h3GdxtZVKjzAASXf334IjkmplB6VlGQ=;
        b=xc/cvDDxdcoScBSeKZyWHi9Pmc4XEAffKczz1UJGoADpR5KOlL3ERGopUkTej4M3cVOCxf
        nBrPCP3JSUKYRwOj1XhvgS6Mdr8Tnhi/ba9NtQRWMUD7FyMkZ68F0QFZSVzeVrnJZtTxLe
        9dycIdivY1+DgPQsFpZkEKB8QkiU2bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674492138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1U4rA+VoFO9h3GdxtZVKjzAASXf334IjkmplB6VlGQ=;
        b=wivDXhSuA+RJe2xPtE+LrPo+hQfDN+VNt4pwi9X+3FEFKLq5ap7D5AnLZI//PfxWEtSYIi
        L8qM4Jr4lm6wAzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3E53134F5;
        Mon, 23 Jan 2023 16:42:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZiS7M+q4zmP+fwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Jan 2023 16:42:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 56191A06B5; Mon, 23 Jan 2023 17:42:18 +0100 (CET)
Date:   Mon, 23 Jan 2023 17:42:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Message-ID: <20230123164218.qaqqg3ggbymtlwjx@quack3>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <Y862ZL5umO30Vu/D@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y862ZL5umO30Vu/D@casper.infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-01-23 16:31:32, Matthew Wilcox wrote:
> On Fri, Jan 20, 2023 at 05:55:48PM +0000, David Howells wrote:
> >  (3) Make the bio struct carry a pair of flags to indicate the cleanup
> >      mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (equivalent to
> >      FOLL_GET) and BIO_PAGE_PINNED (equivalent to BIO_PAGE_PINNED) is
> >      added.
> 
> I think there's a simpler solution than all of this.
> 
> As I understand the fundamental problem here, the question is
> when to copy a page on fork.  We have the optimisation of COW, but
> O_DIRECT/RDMA/... breaks it.  So all this page pinning is to indicate
> to the fork code "You can't do COW to this page".
> 
> Why do we want to track that information on a per-page basis?  Wouldn't it
> be easier to have a VM_NOCOW flag in vma->vm_flags?  Set it the first
> time somebody does an O_DIRECT read or RDMA pin.  That's it.  Pages in
> that VMA will now never be COWed, regardless of their refcount/mapcount.
> And the whole "did we pin or get this page" problem goes away.  Along
> with folio->pincount.

Well, but anon COW code is not the only (planned) consumer of the pincount.
Filesystems also need to know whether a (shared pagecache) page is pinned
and can thus be modified behind their backs. And for that VMA tracking
isn't really an option.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
