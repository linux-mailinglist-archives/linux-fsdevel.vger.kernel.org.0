Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A45883D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiHBV4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiHBV4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:56:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ACDFD1C;
        Tue,  2 Aug 2022 14:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E198AB8211D;
        Tue,  2 Aug 2022 21:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FC3C433D6;
        Tue,  2 Aug 2022 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659477363;
        bh=AOCIKVdcQ8fk4ScLc1Irh/VcGx8dsoD0TBBR+VQ8RIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wcz3S+UBxYgJ6fB6g2qdTFnmlODI0Dso88nZq/ySmokT92IqSzfwMdSTVaWLZdg14
         cX6d5OMirx3YEIJYmidSkHt7Zvre26R5nltYrXN2YxnFh9bmXcwDUL/uXAtQaby3Yt
         qiEngDlh0ha6qKLbXcJGhz+hVH6lyW30cd99bcE4xFcQGK2eZ1oW3znrxvxMPtPs7G
         UMDabo6eHHtZuO6NtdSqIac2vkVU+LooNoznQGkt32j1Waisg2EaNYV3GZRE6kxz3t
         0rWFyyzEOg540t8K52lnAQQfjCEO+m36vdKg2gQ9HFmODdw83e9QqAJcBB+WlsdGpn
         7mH7mg3iarYCQ==
Date:   Tue, 2 Aug 2022 14:56:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is
 freed
Message-ID: <YumdcdmPxqmx3AQc@sol.localdomain>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
 <Ynl+kUGRYaovLc8q@sol.localdomain>
 <YsVYQAQ8ylvMQtR2@google.com>
 <Yta5+UOcK2rgBT6q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yta5+UOcK2rgBT6q@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:04:41PM +0100, Lee Jones wrote:
> On Wed, 06 Jul 2022, Lee Jones wrote:
> 
> > On Mon, 09 May 2022, Eric Biggers wrote:
> > 
> > > On Mon, May 09, 2022 at 09:17:26PM +0800, Haimin Zhang wrote:
> > > > From: Haimin Zhang <tcs_kernel@tencent.com>
> > > > 
> > > > Add a new function call to deinitialize the watch_queue of a freed pipe.
> > > > When a pipe node is freed, it doesn't make pipe->watch_queue->pipe null.
> > > > Later when function post_one_notification is called, it will use this
> > > > field, but it has been freed and watch_queue->pipe is a dangling pointer.
> > > > It makes a uaf issue.
> > > > Check wqueu->defunct before pipe check since pipe becomes invalid once all
> > > > watch queues were cleared.
> > > > 
> > > > Reported-by: TCS Robot <tcs_robot@tencent.com>
> > > > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> > > 
> > > Is this fixing something?  If so it should have a "Fixes" tag.
> > 
> > It sure is.
> > 
> > Haimin, are you planning a v3?
> 
> This patch is set to fix a pretty public / important bug.
> 
> Has there been any more activity that I may have missed?
> 
> Perhaps it's been superseded?

I think this was already fixed (correctly, unlike the above patch which is very
broken) by the following commit:

	commit 353f7988dd8413c47718f7ca79c030b6fb62cfe5
	Author: Linus Torvalds <torvalds@linux-foundation.org>
	Date:   Tue Jul 19 11:09:01 2022 -0700

	    watchqueue: make sure to serialize 'wqueue->defunct' properly

- Eric
