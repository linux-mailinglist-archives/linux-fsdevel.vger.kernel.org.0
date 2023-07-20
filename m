Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4602575AF9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjGTNZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 09:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGTNZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:25:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E110F5;
        Thu, 20 Jul 2023 06:25:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C61476732D; Thu, 20 Jul 2023 15:25:18 +0200 (CEST)
Date:   Thu, 20 Jul 2023 15:25:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/23] btrfs: pass a flags argument to cow_file_range
Message-ID: <20230720132518.GA14692@lst.de>
References: <20230628153144.22834-1-hch@lst.de> <20230628153144.22834-2-hch@lst.de> <20230720112236.GW20457@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720112236.GW20457@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:22:36PM +0200, David Sterba wrote:
> On Wed, Jun 28, 2023 at 05:31:22PM +0200, Christoph Hellwig wrote:
> > The int used as bool unlock is not a very good way to describe the
> > behavior, and the next patch will have to add another beahvior modifier.
> > Switch to pass a flag instead, with an inital CFR_KEEP_LOCKED flag that
> > specifies the pages should always be kept locked.  This is the inverse
> > of the old unlock argument for the reason that it requires a flag for
> > the exceptional behavior.
> 
> Int is the wrong type but I'm not sure that for two flags we should use
> a bit flags. Two bool parameters are IMHO fine and "CFR" does not mean
> anything, it's really only relevant for the function.

CFR stands for cow_file_range.  The good news is that with my
(huge) stack of pending pages both flags will eventually go away.
The bad news is that for an intermediate change I actually need a third
one.
