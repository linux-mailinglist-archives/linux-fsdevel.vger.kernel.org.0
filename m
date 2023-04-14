Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3586E23A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 14:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDNMvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 08:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDNMvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:51:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F54C22;
        Fri, 14 Apr 2023 05:51:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12A6921961;
        Fri, 14 Apr 2023 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681476709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iWBlwHvWOD4JRJQREhWhtFsot85ORsl/tkKnRk+m6bM=;
        b=BHziAQw+YXHl6adelbQWUX1U8WKCC5KnpNdZOnmPJBwxzXb6lyhLbC6n31Ywyh6hI/0wn+
        Dd6nMb67APAKYo/Km+049SZ/xhDqFnvWnJLLK00M405pHiln8NlqpHtMvbh/yuZF+YhP5/
        mgPtHBCO87e2jvY5LIRKB8z48B/ozaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681476709;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iWBlwHvWOD4JRJQREhWhtFsot85ORsl/tkKnRk+m6bM=;
        b=R6e8so7n8jrNI3PtwtasNoioQpQSSaT4qKqOkoNLqDwJY5t2IiVT2nVF2fr3Y80C+Yk4H6
        eU0Zv/WklidAQmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03658139FC;
        Fri, 14 Apr 2023 12:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CtrRAGVMOWTHdAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 14 Apr 2023 12:51:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 84E78A0732; Fri, 14 Apr 2023 14:51:48 +0200 (CEST)
Date:   Fri, 14 Apr 2023 14:51:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 02/10] libfs: Add __generic_file_fsync_nolock
 implementation
Message-ID: <20230414125148.du7r6ljdyzckoysh@quack3>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <e65768eb0fe145c803ba4afdc869a1757d51d758.1681365596.git.ritesh.list@gmail.com>
 <ZDjrvCbCwxN+mRUS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDjrvCbCwxN+mRUS@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-04-23 22:59:24, Christoph Hellwig wrote:
> Still no fan of the naming and placement here.  This is specific
> to the fs/buffer.c infrastructure.

I'm fine with moving generic_file_fsync() & friends to fs/buffer.c and
creating the new function there if it makes you happier. But I think
function names should be consistent (hence the new function would be named
__generic_file_fsync_nolock()). I agree the name is not ideal and would use
cleanup (along with transitioning everybody to not take i_rwsem) but I
don't want to complicate this series by touching 13+ callsites of
generic_file_fsync() and __generic_file_fsync(). That's for a separate
series.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
