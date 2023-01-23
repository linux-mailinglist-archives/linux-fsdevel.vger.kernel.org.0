Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550C5678304
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjAWRZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjAWRZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:25:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306965B8A;
        Mon, 23 Jan 2023 09:25:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D87AE210E3;
        Mon, 23 Jan 2023 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674494730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfvxDigIITkJACUHGuzGgE4qv7g7hs/d2VE0Lh/2w6I=;
        b=kxJMEwGO69gWloDzi7wuNJjnSdnxqD0JfvRQRZr2eouyqs4aORRtYAEDFgkSJHLltK95t7
        W8zu1Z7djUdcbJN8uouOopz+EA8q7zlzgVEob2KkngNPLU5XCDUTUp0YPxoPhFDpM34Ghs
        s49QCL8s0GiFr4QsvbKKCmdYItbp7Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674494730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfvxDigIITkJACUHGuzGgE4qv7g7hs/d2VE0Lh/2w6I=;
        b=uGfe0PHh5vU7BXJkGwl/G2KT+2RHVQtuMPgIxgLbx+5Nh/vvMS4nYUTDwatFzHa6PBGBA5
        SB1VKNKnu29txJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2AD81357F;
        Mon, 23 Jan 2023 17:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rRp5LwrDzmMRGgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Jan 2023 17:25:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F3DC4A06B5; Mon, 23 Jan 2023 18:25:29 +0100 (CET)
Date:   Mon, 23 Jan 2023 18:25:29 +0100
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
Message-ID: <20230123172529.woo34hnycrn7xhwk@quack3>
References: <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <318138.1674491927@warthog.procyon.org.uk>
 <Y865EIsHv3oyz+8U@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y865EIsHv3oyz+8U@casper.infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-01-23 16:42:56, Matthew Wilcox wrote:
> On Mon, Jan 23, 2023 at 04:38:47PM +0000, David Howells wrote:
> > Matthew Wilcox <willy@infradead.org> wrote:
> > Also you only mention DIO read - but what about "start DIO write; fork(); touch
> > buffer" in the parent - now the write buffer belongs to the child and they can
> > affect the parent's write.
> 
> I'm struggling to see the problem here.  If the child hasn't exec'd, the
> parent and child are still in the same security domain.  The parent
> could have modified the buffer before calling fork().

Sadly they are not. Android in particular starts applications by forking
one big binary (zygote) that has multiple apps linked together and relies
on the fact the child cannot influence the parent after the fork. We've
already had CVEs with GUP & COW & fork due to this. David Hildebrand has a
lot of memories regarding this I believe ;)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
