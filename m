Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DFB75AD5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGTLsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGTLsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:48:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68DE2D59;
        Thu, 20 Jul 2023 04:47:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3EEF2253C;
        Thu, 20 Jul 2023 11:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689853671;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXvh2FiCEsqqGt4Xpv8kQ/WlSD4wtLnzE1if43wT4GY=;
        b=RMQ5BM+sbdXabQ4s8pGQb+tTBO64o2CN/taLOopGLcZEPshYPKZe+mPiZvzicglUp9n1Zq
        9t/fCbHIXin7Xo3vLRhMRQbye1cWd1KC2gdgAPbUkTRMYTbV7q2Xf2BCOKbCtoq08EtIiy
        9AxLhDlQsQ7yHz5HvqxN5SW1YA7QR4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689853671;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXvh2FiCEsqqGt4Xpv8kQ/WlSD4wtLnzE1if43wT4GY=;
        b=zHwfTyxZkffcpL4UUbh7kWdKt5vuqvcnxMrrR9+SdsV06Qn/xAZY/+LmylJYrxSeMwGNU6
        RjaIKCS0dSlT03BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DA2E138EC;
        Thu, 20 Jul 2023 11:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NU/THeceuWRhFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Jul 2023 11:47:51 +0000
Date:   Thu, 20 Jul 2023 13:41:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/23] btrfs: don't redirty pages in compress_file_range
Message-ID: <20230720114111.GX20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153144.22834-20-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:31:40PM +0200, Christoph Hellwig wrote:
> compress_file_range needs to clear the dirty bit before handing off work
> to the compression worker threads to prevent processes coming in through
> mmap and changing the file contents while the compression is accessing
> the data (See commit 4adaa611020f ("Btrfs: fix race between mmap writes
> and compression").
> 
> But when compress_file_range decides to not compress the data, it falls
> back to submit_uncompressed_range which uses extent_write_locked_range
> to write the uncompressed data.  extent_write_locked_range currently
> expects all pages to be marked dirty so that it can clear the dirty
> bit itself, and thus compress_file_range has to redirty the page range.
> 
> Redirtying the page range is rather inefficient and also pointless,
> so instead pass a pages_dirty parameter to extent_write_locked_range
> and skip the redirty game entirely.
> 
> Note that compress_file_range was even redirtying the locked_page twice
> given that extent_range_clear_dirty_for_io already redirties all pages
> in the range, which must include locked_page if there is one.

This is probably the only scary patch in the series. I don't see
anything obviously wrong, the reditrying logic added due to the mmap
case is preserved.
