Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8AB6CAF53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 22:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjC0UCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0UC3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:02:29 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DEDB1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZtvuEjhdfRCCDqDSpjmMNyQPCJaNCyBtxbv/1hCrohU=; b=cYMlWCzRUVuStmaMn+AM2UyxVj
        Z1GMGcbSTScnh+92IFnNCeXEzgY4ft0MTWwinwiqk9Mq/+cVNv3cSXdElizUjuQINnAxUwWYH5iCK
        CYDiqaGhmW/EppxK4WxYIXslx0RaN64awkHfs9F/n2dDh68C7xk2vPmGrXQEzcFnavS/opPbDvy0Q
        M7DRjQnNspC4S2hTUJAArEC4A9zpBI8HmaxS06za4Q5dW0sTLHKvKmIyA+hHzWD8fxqFB5Lrn+OL9
        PtglzD/Q9pqv6VeuYhQg4zg40UAhCxQNXnZXA5Fge/Bb9NSa3yGGK46IJy13ToghBySJGPjMERW35
        pNEuWlIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgt2w-002VkF-17;
        Mon, 27 Mar 2023 20:02:26 +0000
Date:   Mon, 27 Mar 2023 21:02:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Message-ID: <20230327200226.GI3390869@ZenIV>
References: <20230324204443.45950-1-axboe@kernel.dk>
 <20230325044654.GC3390869@ZenIV>
 <1ef65695-4e66-ebb8-3be8-454a1ca8f648@kernel.dk>
 <20230327184254.GH3390869@ZenIV>
 <65c20342-b6ed-59c8-3aef-1d6f6d8bfdf2@kernel.dk>
 <c975dbcf-1332-5bb5-3375-04280407a897@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c975dbcf-1332-5bb5-3375-04280407a897@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:59:09PM -0600, Jens Axboe wrote:

> > That's a great idea. Two questions - do we want to make that
> > WARN_ON_ONCE()? And then do we want to include a WARN_ON_ONCE for a
> > non-supported type? Doesn't seem like high risk as they've all been used
> > with ITER_IOVEC until now, though.
> 
> Scratch that last one, user_backed should double as that as well. At
> least currently, where ITER_UBUF and ITER_IOVEC are the only two
> iterators that hold user backed memory.

Quite.  As for the WARN_ON_ONCE vs. WARN_ON...  No preferences, really.
