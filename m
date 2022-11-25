Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979363841E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 07:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKYGn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 01:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKYGn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:43:57 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888532A73D;
        Thu, 24 Nov 2022 22:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iYW/JhAzy/NAHRzRn6OtcNKWyJmGU2/7NHJP6EadOQU=; b=IcfdP1PWIKeGhwP833cmZzviRW
        qu2ypsdSMoJrBuD6aw+etBv17UIzjGkE99o2W1bap/UOFePESA2JPkQ6HToAfMqus8ZvFhoi71k14
        U9GJ7+Wk72/WgrF1x5RJgAo9YzGJnKoSnNUAu+tk+AqmMafvzrjN8pMBmQj6E3/Q2pNdDu3WLXLac
        6QL4v+2y6v8HkK4Sb3nwFpW+3fdp2lh+dXVW5zPs6WuJQ0HrSixB5J+T8QazZ41YuQ/Y8KJiWWdM1
        9SVoIARbFDi1mhwOuakuTYBlDpZB7QEtsFFhF1KBmCw2E9VAF4ivb7j5j5+NNNl81sKWcsFmzRd5a
        UN0G5KBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oySRB-006btE-0g;
        Fri, 25 Nov 2022 06:43:49 +0000
Date:   Fri, 25 Nov 2022 06:43:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fs: clear a UBSAN shift-out-of-bounds warning
Message-ID: <Y4BkJd3Jy6MY3cdu@ZenIV>
References: <20221121024418.1800-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121024418.1800-1-thunder.leizhen@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:44:16AM +0800, Zhen Lei wrote:
> v1 -- > v2:
> 1. Replace INT_LIMIT(loff_t) with OFFSET_MAX in btrfs.
> 2. Replace INT_LIMIT() with type_max().

Looks fine, except that I'd rather go for commit message
along the lines of "INT_LIMIT tries to do what type_max does,
except that type_max doesn't rely upon undefined behaviour;
might as well use type_max() instead"

If you want to credit UBSAN - sure, no problem, just don't
clutter the commit message with that.  As it is, it reads
as "make $TOOL STFU"...
