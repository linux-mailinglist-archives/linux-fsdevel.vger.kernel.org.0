Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D786630DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 20:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbjAIT67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 14:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbjAIT6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:58:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA911C05;
        Mon,  9 Jan 2023 11:58:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D39605BFED;
        Mon,  9 Jan 2023 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673294323;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqf4EYPtaa7qRzGaumggMD5PgDktxPAtMHctMr6gLGM=;
        b=r7nHWucU7ucFRP3fhs/qdJJmi8IWTyjhS5HquIk9+er3pou1slI3Tziz1P0gwQy7fLoZWn
        pNhRpAn8fAwQwTWe0YhXV5w9A+rV5vlxyfEnw9PEInj1Ui6ywzhAWlFuJMzVZzgC6gUYUR
        59kJnDFifOqb8cczNf6njyjHHZ3gf90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673294323;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqf4EYPtaa7qRzGaumggMD5PgDktxPAtMHctMr6gLGM=;
        b=Qo1EnZ1KxOKENH934JGqVsVzwnwFxxdUsqzwmMD8z8C/qM1N9F6aNZ26bkr587ylrLisjp
        sEHRddTliaeafDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ADCD134AD;
        Mon,  9 Jan 2023 19:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gEfeGPNxvGN0XAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Jan 2023 19:58:43 +0000
Date:   Mon, 9 Jan 2023 20:53:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove write_one_page / folio_write_one
Message-ID: <20230109195309.GU11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230108165645.381077-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108165645.381077-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 05:56:38PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the write_one_page API, and it's folioized
> implementation as folio_write_one.  These helpers internally call
> ->writepage which we are gradually removing from the kernel.
> 
> For most callers there are better APIs to use, and this cleans them up.
> The big questionmark is jfs, where the metapage abstraction uses the
> pagecache in a bit of an odd way, and which would probably benefit from
> not using the page cache at all like the XFS buffer cache, but given
> that jfs has been in minimum maintaince mode for a long time that might
> not be worth it.  So for now it just moves the implementation of
> write_one_page into jfs instead.
> 
> Diffstat:
>  fs/btrfs/volumes.c      |   50 ++++++++++++++++++++++++------------------------

The btrfs patches were sent separately some time ago, now merged to
misc-next with updated changelogs and with the suggested switch to folio
API in the 2nd patch.
