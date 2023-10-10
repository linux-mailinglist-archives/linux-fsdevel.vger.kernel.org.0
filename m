Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3A17BFD41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 15:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjJJNWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjJJNWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:22:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7335FB9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 06:22:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C337210EB;
        Tue, 10 Oct 2023 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696944164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJvBBQT8/uyJPyM3NMBYOFkF4Fk/m7JTLvpOtw7nozo=;
        b=nZsS9dme73Rhs1t3UPs37v9hzkgfbgM3bIPRlbLFxLdWYJytc6FoxrIL/s0ZTevxbDeHut
        ovsBKZGDDcQl/4DVXGcde9irBX5kmyPzvJV4sMpykenHAyk+/opCNYI/V+mvLkIlCf5kkT
        qVJzOFkvZRSrWtVw8EfafiGUsvHz2i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696944164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJvBBQT8/uyJPyM3NMBYOFkF4Fk/m7JTLvpOtw7nozo=;
        b=eGUPxwsBw0sE6+PcMC3HMfsYHOVic1CYRWuqmibosOIqDIsSImWOAzMcp14mCEvHynxyjS
        3wqQ+WNd99hopvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16F4B1358F;
        Tue, 10 Oct 2023 13:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id StCDAyRQJWV2ZgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Tue, 10 Oct 2023 13:22:44 +0000
Date:   Tue, 10 Oct 2023 15:23:26 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 1/3] lib: Add tst_fd_iterate()
Message-ID: <ZSVQTs1WTxz5Bioi@yuki>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-2-chrubis@suse.cz>
 <87jzruzs6p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzruzs6p.fsf@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> I don't wish to over complicate this, but how many potential fd types
> could there be 100, 1000? Some could have complicated init logic.

I'm at 25 at the moment, suprisingly all of them so far are a syscall
with a few parameters, sometimes packed in a struct.

> I'm wondering if at the outset it would be better to define an interface
> struct with name, setup and teardown for each FD type, plus whatever
> other meta-data might be useful for filtering.
> 
> Then instead of a case statement, we put the structs in an array etc.

I guess that we can, but we would have to add some private data area to
the tst_fd, so that we can tear down things cleanly, but we would need
that if we want to convert the tst_iterate_fd() to be iterator-like
anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
