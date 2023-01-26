Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC0967C61E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 09:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjAZImo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 03:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjAZImf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:42:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7013A9B
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 00:42:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FFA61FEC1;
        Thu, 26 Jan 2023 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674722553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0CM5XeS9QS18hCZcjW7fjbY5bEPveUnQYwColEauXQ=;
        b=w+bFjoDInmRzWdvibl+JVZ5qJvIuKpgB3/lnhqi9jS6bwyqABlX0JR1gakZLN4YL+D9+0g
        /qrM8/j2Wg1kyrp32To8lO+3zG3bhsujEtA2Vv7tG57blkVKBS+tGhXG0CpMbmS0I7djzR
        dfcQaBOiDfKHQElTDACgYCF20BA0GOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674722553;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0CM5XeS9QS18hCZcjW7fjbY5bEPveUnQYwColEauXQ=;
        b=hQPfxyPvyH3lw6MOfFTdnTw+PJGANS5Z6D4Rsw1uz79O04nA90v+9CZfZnNebrjnshjpYl
        PZnRfKAQdZOfzxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12F3413A09;
        Thu, 26 Jan 2023 08:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eH6XBPk80mNdPgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 26 Jan 2023 08:42:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7E0E2A06B4; Thu, 26 Jan 2023 09:42:32 +0100 (CET)
Date:   Thu, 26 Jan 2023 09:42:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: don't allocate blocks beyond EOF from
 __mpage_writepage
Message-ID: <20230126084232.2vgh74meyuhjvrfd@quack3>
References: <20230103104430.27749-1-jack@suse.cz>
 <Y7r8dsLV0dcs+jBw@infradead.org>
 <20230125142351.4hfehrbuuacx3thp@quack3>
 <20230125165221.4ac37077497afc84bdf8bf19@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125165221.4ac37077497afc84bdf8bf19@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-01-23 16:52:21, Andrew Morton wrote:
> On Wed, 25 Jan 2023 15:23:51 +0100 Jan Kara <jack@suse.cz> wrote:
> 
> > On Sun 08-01-23 09:25:10, Christoph Hellwig wrote:
> > > On Tue, Jan 03, 2023 at 11:44:30AM +0100, Jan Kara wrote:
> > > > When __mpage_writepage() is called for a page beyond EOF, it will go and
> > > > allocate all blocks underlying the page. This is not only unnecessary
> > > > but this way blocks can get leaked (e.g. if a page beyond EOF is marked
> > > > dirty but in the end write fails and i_size is not extended).
> > > 
> > > Looks good:
> > > 
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Matthew, Andrew, can one of you please pick up this fix? Thanks!
> > 
> 
> This was added to mm-stable (and hence linux-next) on Jan 18, as
> 4b89a37d54a0b.

Bah, thanks for reminder. I didn't see any reply in the thread and somehow
my inbox searching from your commit-bot email failed. Sorry for the noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
