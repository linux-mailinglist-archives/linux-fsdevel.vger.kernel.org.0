Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B5A6637A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 04:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjAJDFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 22:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAJDFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:05:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0711451;
        Mon,  9 Jan 2023 19:05:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E756B810C3;
        Tue, 10 Jan 2023 03:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0912AC433D2;
        Tue, 10 Jan 2023 03:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673319909;
        bh=kIb/pMavnQ/vJQ+FDHSwaaxR738wNTcTTT1E+SUl1A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNq1t8iRPejlvRTCQMEhKhCDLCOKf5Jp4Ihc4JA9Ww5kWoHmVuz/HaadQrbwCYoXS
         wBHPTrrMnEsVJjQyQBnGSh3I5TkYE5In5LdNUDM2ccl9oLRGf6KDCw8krhrzptwfpZ
         tZjwuO6TIZlm+pn/NVgxbZxxJcLPH16fuDDn3BzyGkSeXZXzgVnfjqxbJSWozmLZWr
         9fSuQemymDUhxgek/Fq/VNuXu7LKEa9tmz8QRmpre+hKxe4qZ9UNmTohQUqy5DtJpo
         6tO1ost8hxl+kAoshWAIoEriwAixYgU82IEs8nAL+67KgsmEey9aqSw+Ajroxaetvt
         lEKEei6L858Kg==
Date:   Mon, 9 Jan 2023 19:05:07 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 10/11] fs/buffer.c: support fsverity in
 block_read_full_folio()
Message-ID: <Y7zV41MQWSUGo4fw@sol.localdomain>
References: <20221223203638.41293-1-ebiggers@kernel.org>
 <20221223203638.41293-11-ebiggers@kernel.org>
 <20230109183759.c1e469f5f2181e9988f10131@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109183759.c1e469f5f2181e9988f10131@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 06:37:59PM -0800, Andrew Morton wrote:
> On Fri, 23 Dec 2022 12:36:37 -0800 Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > After each filesystem block (as represented by a buffer_head) has been
> > read from disk by block_read_full_folio(), verify it if needed.  The
> > verification is done on the fsverity_read_workqueue.  Also allow reads
> > of verity metadata past i_size, as required by ext4.
> 
> Sigh.  Do we reeeeealy need to mess with buffer.c in this fashion?  Did
> any other subsystems feel a need to do this?

ext4 is currently the only filesystem that uses block_read_full_folio() and that
supports fsverity.  However, since fsverity has a common infrastructure across
filesystems, in fs/verity/, it makes sense to support it in the other filesystem
infrastructure so that things aren't mutually exclusive for no reason.

Note that this applies to fscrypt too, which block_read_full_folio() (previously
block_read_full_page()) already supports since v5.5.

If you'd prefer that block_read_full_folio() be copied into ext4, then modified
to support fscrypt and fsverity, and then the fscrypt support removed from the
original copy, we could do that.  That seems more like a workaround to avoid
modifying certain files than an actually better solution, but it could be done.

> 
> > This is needed to support fsverity on ext4 filesystems where the
> > filesystem block size is less than the page size.
> 
> Does any real person actually do this?

Yes, on systems with the page size larger than 4K, the ext4 filesystem block
size is often smaller than the page size.  ext4 encryption (fscrypt) originally
had the same limitation, and Chandan Rajendra from IBM did significant work to
solve it a few years ago, with the changes landing in v5.5.

- Eric
