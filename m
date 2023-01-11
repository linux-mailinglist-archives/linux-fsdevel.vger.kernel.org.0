Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAF665875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 11:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbjAKKCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 05:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjAKKBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:01:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD209D10C;
        Wed, 11 Jan 2023 01:58:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E65C017271;
        Wed, 11 Jan 2023 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673431100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=plQgZXfA2scYOrF0GmD97lY2y/irZtbg3caEwwC8YD8=;
        b=N/MbIuZcaZ+hZSM2kQaFm39/+2DAuuJCUpgl+1VT6ux1/mYFLaziEwETXffJuHytjr67Xp
        bj7+N6YWQIXGVMnUUMLKttW010+oClBl408pj+G4x6DTBQI42qxpDxy7iJNkONCAZJrY6M
        4DYW8y5u1doKy5+KMQd+nBXAq4PPsuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673431100;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=plQgZXfA2scYOrF0GmD97lY2y/irZtbg3caEwwC8YD8=;
        b=yhHjZdZ+3Kcmm2Ncm7cBC3sbHowh1ur+Rq/5k6fdH8uleaTa3zjoJ5yFofULHr/eRVfEFb
        O40R10XCjcdIyXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4F9B1358A;
        Wed, 11 Jan 2023 09:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7rPwMzyIvmMBdQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 09:58:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 656BFA0744; Wed, 11 Jan 2023 10:58:20 +0100 (CET)
Date:   Wed, 11 Jan 2023 10:58:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages
 rather than ref'ing if appropriate
Message-ID: <20230111095820.pa6yk6jnmnsxbvz7@quack3>
References: <20230109172500.bd4z2incticapm7x@quack3>
 <d86e6340-534c-c34c-ab1d-6ebacb213bb9@kernel.dk>
 <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
 <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
 <1880793.1673257404@warthog.procyon.org.uk>
 <2155893.1673361724@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2155893.1673361724@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-01-23 14:42:04, David Howells wrote:
> Jan Kara <jack@suse.cz> wrote:
> 
> > ... So filesystems really need DIO reads to use FOLL_PIN instead of FOLL_GET
> > and consequently we need to pass information to bio completion function how
> > page references should be dropped.
> 
> That information would be available in the bio struct with this patch if
> necessary, though transcribed into a combination of BIO_* flags instead off
> FOLL_* flags.
> 
> I wonder if there's the possibility of the filesystem that generated the bio
> nicking the pages out of the bio and putting them itself.

I just meant to say that some addition struct bio is needed because your
bio_release_page() needs to find out how to release page ref. Filesystem
itself does not care about type of page reference in this path so what you
do in the latest version of this patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
