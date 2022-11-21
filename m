Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDDA631DBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 11:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKUKHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 05:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiKUKHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:07:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9BCA6A0C;
        Mon, 21 Nov 2022 02:07:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC83421E2E;
        Mon, 21 Nov 2022 10:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669025234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q4IViuQpwPEcZzjjxamaWcFWnSXKTM0MbrHGsCmeqkQ=;
        b=jWO57yYjiG6oJ7os9jTrYvpZwMpk7iFCyXSFiozl+kCieh91bLV3UGjW3Bb55k3q0DM0iT
        Pye7XzjLd+H0jQuBklHlAxqt1U3WbzDWXLeMIK5xCM8SWsovnxyhrVye84ieWJeWn5QENP
        cU5eX4gfF1uRGBx6kvzWOREKWBTdjjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669025234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q4IViuQpwPEcZzjjxamaWcFWnSXKTM0MbrHGsCmeqkQ=;
        b=C/PSDzkFpjgWFOKTSy3+AJAFIyRJIUsoxq+JCiCyQBTUxM8KgZql1lzPCYbkjZkbOfVj4b
        L4lcWr/A/flK1BAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A79931377F;
        Mon, 21 Nov 2022 10:07:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4s7iKNJNe2MjAwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 10:07:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DEFDA070A; Mon, 21 Nov 2022 11:07:14 +0100 (CET)
Date:   Mon, 21 Nov 2022 11:07:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] ext2: remove ->writepageo
Message-ID: <20221121100714.73zjzpbgdvt5j7xv@quack3>
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-3-hch@lst.de>
 <20221114104927.k5x4i4uanxskfs6m@quack3>
 <Y3UMV2mB5BkMM5PY@infradead.org>
 <20221116182040.tecis3dqejsdqnum@quack3>
 <Y3XVU/gdoT5EH6xh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3XVU/gdoT5EH6xh@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-11-22 22:31:47, Christoph Hellwig wrote:
> On Wed, Nov 16, 2022 at 07:20:40PM +0100, Jan Kara wrote:
> > Looking at the code, IMO the write_one_page() looks somewhat premature
> > anyway in that place. AFAICS we could handle the writeout using
> > filemap_write_and_wait() if we moved it to somewhat later moment. So
> > something like attached patch (only basic testing only so far)?
> 
> Yes, this looks sensible.  Do you want to queue this one and the
> ext2 and udf patches from this series if the testing works fine?

OK, I'll take udf and ext2 patches through my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
