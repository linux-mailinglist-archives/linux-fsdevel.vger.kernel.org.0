Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF6664132
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjAJNGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjAJNGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:06:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1116E574E3;
        Tue, 10 Jan 2023 05:06:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C9DD75F89;
        Tue, 10 Jan 2023 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673355976;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oagt+4vJMZBwYo+UNXn/MG8vqxeNFrHBgtCcArXVT6c=;
        b=J9B94SIbxnl0oE/XF1iLiZ/pxfG9UhvmUFS5xpUxqDUMAKJfxpqumk/XZr7MssvYOcSDwa
        xSmOMO1k5wFEThQsRLQPlW5wQj+M1FlrCn0irK/hj1yWrlqya7okuRchYwsOvdaBGNvoDk
        tQcuLbbpyP9cf6J1FdS1G5nshzgF9wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673355976;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oagt+4vJMZBwYo+UNXn/MG8vqxeNFrHBgtCcArXVT6c=;
        b=QJYz3Rx4bQN8uaOfKuCv7ws5nYtLdlYJZpH7vCk2H1VJ5TaHkPwSItV/3ew5XEFL8w24Qx
        N7mZks4HQ0kYT3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 344E613338;
        Tue, 10 Jan 2023 13:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X87RC8hivWOcMAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Jan 2023 13:06:16 +0000
Date:   Tue, 10 Jan 2023 14:00:42 +0100
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
Message-ID: <20230110130042.GA11562@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230108165645.381077-1-hch@lst.de>
 <20230109195309.GU11562@twin.jikos.cz>
 <20230110081653.GA11947@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110081653.GA11947@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 09:16:53AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 09, 2023 at 08:53:09PM +0100, David Sterba wrote:
> > The btrfs patches were sent separately some time ago, now merged to
> > misc-next with updated changelogs and with the suggested switch to folio
> > API in the 2nd patch.
> 
> Yes, 7 weeks ago to be exact.  I wish we could just feed everything
> together now that we've missed the previous merge window, as that
> makes patch juggling for Andrew and Matthew a lot simpler.

The patches are not fixes so they should wait for the next merge window.
