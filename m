Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2465C62C2BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiKPPgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiKPPgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:36:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5914D0C;
        Wed, 16 Nov 2022 07:36:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50A47336F9;
        Wed, 16 Nov 2022 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668613006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sLkFAGmODAxxEkX02jVvJl4offD9YV13b3F5VPNgrjo=;
        b=kpjpxKkatXq3EwXIEV+LmXYPlqGug+rL5rx5o/rJsc933/eJpQbsD/p+rNma92cYKNiNi1
        YdbC8GzWo43ZCdPFeaihAJ6HjcQHTDA9QISSKxypcBCuyZTXIUE2VVhStpcpCr29l9V9gK
        NTPHHOb0fLFUwA3NGMDRPUOi0JO3U8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668613006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sLkFAGmODAxxEkX02jVvJl4offD9YV13b3F5VPNgrjo=;
        b=y2zMGOWs/dn5QvLOUYvocvGltUMPBoQY2jZjWa1CBM1nVurW1yi34qHOJja8krFBYkjmXb
        4nRfZRBmBobFkTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E2A513480;
        Wed, 16 Nov 2022 15:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Ro3C44DdWNscgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Nov 2022 15:36:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 46F12A0709; Wed, 16 Nov 2022 16:36:44 +0100 (CET)
Date:   Wed, 16 Nov 2022 16:36:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: Re: generic_writepages & jbd2 and ext4
Message-ID: <20221116153644.7rqgb6a4nyei3ltz@quack3>
References: <20221116135016.GA9713@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135016.GA9713@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-11-22 14:50:16, Christoph Hellwig wrote:
> Hi all,
> 
> I've recently started looking into killing off the ->writepage method,
> and as an initial subproject kill of external uses of generic_writepages.
> One of the two remaining callers s in jbd2 and I'm a bit confused about
> it.
> 
> jbd2_journal_submit_inode_data_buffers has two comments that explicitly
> ask for ->writepages as that doesn't allocate data:
> 
> /*
>  * write the filemap data using writepage() address_space_operations.
>  * We don't do block allocation here even for delalloc. We don't
>  * use writepages() because with delayed allocation we may be doing
>  * block allocation in writepages().
>  */
> 
> 	/*
>          * submit the inode data buffers. We use writepage
> 	 * instead of writepages. Because writepages can do
> 	 * block allocation with delalloc. We need to write
> 	 * only allocated blocks here.
> 	 */
> 
> and these look really stange to me.  ->writepage and ->writepages per
> their document VM/VFS semantics don't different on what they allocate,
> so this seems to reverse engineer ext4 internal behavior in some
> way.  Either way looping over ->writepage just for that is rather
> inefficient.  If jbd2 really wants a way to skip delalloc conversion
> can we come up with a flag in struct writeback_control for that?
> 
> Is there anyone familiar enough with this code who would be willing
> to give it a try?

Yes, I've written that code quite a few years ago :) And I agree JBD2 is
abusing internal knowledge about ext4 here. So yes, writeback_control flag
so that we can propagate the information to ->writepages method should do
the trick. I'll have a look into that.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
