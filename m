Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954C878C481
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjH2Mve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 08:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjH2MvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:51:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71769D
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 05:51:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4AA1D6732D; Tue, 29 Aug 2023 14:51:19 +0200 (CEST)
Date:   Tue, 29 Aug 2023 14:51:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: mtd
Message-ID: <20230829125118.GA24767@lst.de>
References: <20230829-weitab-lauwarm-49c40fc85863@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829-weitab-lauwarm-49c40fc85863@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 01:46:20PM +0200, Christian Brauner wrote:
> Something like the following might already be enough (IT'S A DRAFT, AND
> UNTESTED, AND PROBABLY BROKEN)?

It's probably the right thing conceptually, but it will also need
the SB_I_RETIRED from test_bdev_super_fc or even just reuse
test_bdev_super_fc after that's been renamed to be more generic.

In fact I've been wondering for a while why we even support the magic
keyed get_super - if it allocates a new super it should also have a
new dev_t.  So IMHO we should stop playing stupid tricks with keys and
just declare the dev_t the key after doing all the required work for it,
that is allocating the per-instance anon dev_t in the caller.
