Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8253799BF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjIIWmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjIIWmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 18:42:44 -0400
Received: from out-219.mta0.migadu.com (out-219.mta0.migadu.com [IPv6:2001:41d0:1004:224b::db])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724DE19E
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Sep 2023 15:42:39 -0700 (PDT)
Date:   Sat, 9 Sep 2023 18:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694299357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8VhvXg/SuVpK79L/k0XNUnHSaeyg+0ZPf36boqf4A44=;
        b=a1kYkOzvInHlFdiyr07UF8WyMvPe6Ovku+jR/TY0QMQq4+t2GQ2YPs81sp+OVg1NAu4fe1
        WKu3WoT0qbIRRnvYNu+xr7yzcSPBamHOJ4FhcaEd54MxmtSObyVS156NAv+4qBBUpJ5OdB
        61eFHTd9nkjd8veVlzeVbNsBspsuSkc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230909224230.3hm4rqln33qspmma@moria.home.lan>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> So why can't we figure out that easier way? What's wrong with trying to
> figure out if we can do some sort of helper or library set that assists
> supporting and porting older filesystems. If we can do that it will not
> only make the job of an old fs maintainer a lot easier, but it might
> just provide the stepping stones we need to encourage more people climb
> up into the modern VFS world.

What if we could run our existing filesystem code in userspace?

bcachefs has a shim layer (like xfs, but more extensive) to run nearly
the entire filesystem - about 90% by loc - in userspace.

Right now this is used for e.g. userspace fsck, but one of my goals is
to have the entire filesystem available as a FUSE filesystem. I'd been
planning on doing the fuse port as a straight fuse implementation, but
OTOH if we attempted a sh vfs iops/aops/etc. -> fuse shim, then we would
have pretty much everything we need to run any existing fs (e.g.
reiserfs) as a fuse filesystem.

It'd be a nontrivial project with some open questions (e.g. do we have
to lift all of bufferheads to userspace?) but it seems worth
investigating.
