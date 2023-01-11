Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E919C6663B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 20:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjAKT0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 14:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjAKT0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:26:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E31D13D;
        Wed, 11 Jan 2023 11:26:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 323CD5148;
        Wed, 11 Jan 2023 19:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673465163;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mH835/H7CJjALAQQPrPqSv0tI1NycZjQjwAi6V6jrQg=;
        b=So/feScP72zUN1fl3YW78TZTSzlscDVER24BUidbmXOEX80wKMypgMljBtOtzwzsxMlto7
        8YGw6FsPjwfy2lWXnjc8J4JhFlUJXYW9JIxWYfLX2uNqFqvMVz+B7ikRliOR8+ri31fmKY
        a3LS2GgNgzC5dCaHlrWC6KwjhuZySXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673465163;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mH835/H7CJjALAQQPrPqSv0tI1NycZjQjwAi6V6jrQg=;
        b=HWvXjIxByWtXQqx8A0QzVBC60YOCI9T/3yVFWUD0X353TG+gV8+WGddh/ubAILvXHIigXN
        WSNivWu4qsF+bkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCCBA13591;
        Wed, 11 Jan 2023 19:26:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vh0eLUoNv2PXLAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 Jan 2023 19:26:02 +0000
Date:   Wed, 11 Jan 2023 20:20:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20230111192027.GJ11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230108165645.381077-1-hch@lst.de>
 <20230109195309.GU11562@twin.jikos.cz>
 <20230110081653.GA11947@lst.de>
 <20230110130042.GA11562@suse.cz>
 <20230110153216.GA10159@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110153216.GA10159@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 04:32:16PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 10, 2023 at 02:00:42PM +0100, David Sterba wrote:
> > On Tue, Jan 10, 2023 at 09:16:53AM +0100, Christoph Hellwig wrote:
> > > On Mon, Jan 09, 2023 at 08:53:09PM +0100, David Sterba wrote:
> > > > The btrfs patches were sent separately some time ago, now merged to
> > > > misc-next with updated changelogs and with the suggested switch to folio
> > > > API in the 2nd patch.
> > > 
> > > Yes, 7 weeks ago to be exact.  I wish we could just feed everything
> > > together now that we've missed the previous merge window, as that
> > > makes patch juggling for Andrew and Matthew a lot simpler.
> > 
> > The patches are not fixes so they should wait for the next merge window.
> 
> Agreed.  But it would be a lot simpler if we could queue them up in
> -mm with the other patches now that we've missed the previous merge
> window.

Ok then, to make it easier for the folio changes I'll send the two btrfs
patches next week. As the rest of the series does not depend on it,
I don't see the need to let them all go via the mm tree.
