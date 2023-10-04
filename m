Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B200B7B82BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbjJDOwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbjJDOwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:52:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732FCAB
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 07:52:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A2CC1F45A;
        Wed,  4 Oct 2023 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696431150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3148ZnxxpT4v2dnY42midxl1lwJ1NjKbIFfJVdmTgs=;
        b=lmbFjyLkn5YxNLF//QlTXpvI/KWljGWtVL8FpzK1tcOWQTgxn3OCqpdAuuHH6Gj4uGm9Fd
        UzVSGCrlJVm4dYAq8Qin3M06gPrdDoMHBMovc4GFoDrdqrm5WZO5BErkPDJMskwEvi7rta
        flYj8k2bZEszKzJm6KuMj2lDxn5YdUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696431150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3148ZnxxpT4v2dnY42midxl1lwJ1NjKbIFfJVdmTgs=;
        b=qvjD6jXIvWXFUw4gfN8CxaG5CinWL7zThfXbochIRyXW0sMuxZ/1tBJB5mLMr//rjNZyLb
        60/Z/BMpduVIQLBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1951313A2E;
        Wed,  4 Oct 2023 14:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kQEfBi58HWXwCQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 04 Oct 2023 14:52:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9B2C8A07CC; Wed,  4 Oct 2023 16:52:29 +0200 (CEST)
Date:   Wed, 4 Oct 2023 16:52:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, ltp@lists.linux.it,
        Matthew Wilcox <willy@infradead.org>, mszeredi@redhat.com,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Reuben Hawkins <reubenhwk@gmail.com>
Subject: Re: [PATCH 2/3] syscalls/readahead01: Make use of tst_fd_iterate()
Message-ID: <20231004145229.mulvwfxkfg63u7jx@quack3>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-3-chrubis@suse.cz>
 <CAOQ4uxg8Z1sQJ35fdXnct3BJoCaahHoQ9ek3rmPs3Ly8cVCz=A@mail.gmail.com>
 <ZR11nlq3Le1GAwcd@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR11nlq3Le1GAwcd@yuki>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-10-23 16:24:30, Cyril Hrubis wrote:
> Hi!
> > > TODO: readahead() on /proc/self/maps seems to succeed is that to be
> > >       expected?
> > 
> > Not sure.
> > How does llseek() work on the same fd?
> 
> Looks like we we can seek in that file as well, accordingly to man pages
> we cannot seek in pipe, socket, and fifo, which seems to match the
> reality.  We can apparently seek in O_DIRECTORY fd as well, not sure if
> that is even useful.

Seeking on O_DIRECTORY fd is actually well defined by POSIX. You can store
current file position you've got back from lseek and you are guaranteed to
get back at the same position in the directory if you lseek to it (even if
there was a change to the directory, although effects on changed directory
entries is undefined). This is actually pretty tough to implement in
contemporary filesystems with non-trivial directory structure but that is
how POSIX defined it...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
