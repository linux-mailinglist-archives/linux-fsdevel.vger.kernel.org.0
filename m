Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317F2675E7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 20:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjATT4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 14:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjATT4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:56:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA74CEF96;
        Fri, 20 Jan 2023 11:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53A8DB82A53;
        Fri, 20 Jan 2023 19:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C168DC433D2;
        Fri, 20 Jan 2023 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674244607;
        bh=WgPwAk68Gp6i/8CNzDeljqUnskSbMUtSRKCUvjWRZ+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyrxu8zgAFjp28BCELZ5qHOWfx7QkHNrkTxMlvnuXWFb2SUtRSP1RKZooDLdabEI2
         TEhfwoHJ5FBUIxZhyqMO4CHfD246TDXm0v+0rP8LutJU+E1iWmJ7DjknJ6MVLzCVCF
         PIGqU8sEBbr+KN8kLiHj9JlZzK+XkNMSUs28Oy+H1ZJGNrSNLSouYzBwJrPXTAFzBG
         AW7WpSDiR4BNsqOtIh0j+gKkYeYw4wmr7jPH5y9v1ax+gga0MWlSnJFDzgo36Vjm7t
         6bMEFwVcgQZx+8qKhmCyCYYarw/7hc9xJSd6eZPBPq5Gj+UGZrXAlE1eEtfUlwRlE2
         BH3xb/nru8sXg==
Date:   Fri, 20 Jan 2023 11:56:45 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fs/buffer.c: support fsverity in
 block_read_full_folio()
Message-ID: <Y8rx/SPfnlYJJ8XD@sol.localdomain>
References: <20221223203638.41293-1-ebiggers@kernel.org>
 <20221223203638.41293-11-ebiggers@kernel.org>
 <20230109183759.c1e469f5f2181e9988f10131@linux-foundation.org>
 <Y7zV41MQWSUGo4fw@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zV41MQWSUGo4fw@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:05:07PM -0800, Eric Biggers wrote:
> On Mon, Jan 09, 2023 at 06:37:59PM -0800, Andrew Morton wrote:
> > On Fri, 23 Dec 2022 12:36:37 -0800 Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > After each filesystem block (as represented by a buffer_head) has been
> > > read from disk by block_read_full_folio(), verify it if needed.  The
> > > verification is done on the fsverity_read_workqueue.  Also allow reads
> > > of verity metadata past i_size, as required by ext4.
> > 
> > Sigh.  Do we reeeeealy need to mess with buffer.c in this fashion?  Did
> > any other subsystems feel a need to do this?
> 
> ext4 is currently the only filesystem that uses block_read_full_folio() and that
> supports fsverity.  However, since fsverity has a common infrastructure across
> filesystems, in fs/verity/, it makes sense to support it in the other filesystem
> infrastructure so that things aren't mutually exclusive for no reason.
> 
> Note that this applies to fscrypt too, which block_read_full_folio() (previously
> block_read_full_page()) already supports since v5.5.
> 
> If you'd prefer that block_read_full_folio() be copied into ext4, then modified
> to support fscrypt and fsverity, and then the fscrypt support removed from the
> original copy, we could do that.  That seems more like a workaround to avoid
> modifying certain files than an actually better solution, but it could be done.
> 
> > 
> > > This is needed to support fsverity on ext4 filesystems where the
> > > filesystem block size is less than the page size.
> > 
> > Does any real person actually do this?
> 
> Yes, on systems with the page size larger than 4K, the ext4 filesystem block
> size is often smaller than the page size.  ext4 encryption (fscrypt) originally
> had the same limitation, and Chandan Rajendra from IBM did significant work to
> solve it a few years ago, with the changes landing in v5.5.
> 
> - Eric

Any more thoughts on this from Andrew, the ext4 maintainers, or anyone else?

- Eric
