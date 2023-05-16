Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DE70535C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEPQRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEPQRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:17:14 -0400
Received: from out-34.mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77326559E;
        Tue, 16 May 2023 09:17:10 -0700 (PDT)
Date:   Tue, 16 May 2023 12:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684253828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5HxFMYwKVYvGqc9HvmSixbmRT527HdhzsYk1KBgUXM=;
        b=FwqrCdim6lu9NR6/Zyst3qz1J7Yl3fET2pduOmEESKv8UthsWwfqpad4JTqc4EtJYCUR97
        nSZK7oCg035mnk1spGKr+cJVgES/XZjgPxh+XDNp4PV8lKsEhcISrdfLaU2DOtMwzrd5mn
        v/J+Z2LRm724seR6g9xNavMsXa/0snc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <ZGOsgI7a68mWYVQH@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230510044557.GF2651828@dread.disaster.area>
 <20230516-brand-hocken-a7b5b07e406c@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516-brand-hocken-a7b5b07e406c@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 05:45:19PM +0200, Christian Brauner wrote:
> On Wed, May 10, 2023 at 02:45:57PM +1000, Dave Chinner wrote:
> There's a bit of a backlog before I get around to looking at this but
> it'd be great if we'd have a few reviewers for this change.

It is well tested - it's been in the bcachefs tree for ages with zero
issues. I'm pulling it out of the bcachefs-prerequisites series though
since Dave's still got it in his tree, he's got a newer version with
better commit messages.

It's a significant performance boost on metadata heavy workloads for any
non-XFS filesystem, we should definitely get it in.
