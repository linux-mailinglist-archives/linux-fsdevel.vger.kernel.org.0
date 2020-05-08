Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A941C9F86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 02:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHAY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 20:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEHAY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 20:24:28 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D03C05BD43;
        Thu,  7 May 2020 17:24:28 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWqoQ-003KER-Nq; Fri, 08 May 2020 00:24:22 +0000
Date:   Fri, 8 May 2020 01:24:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, mcgrof@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: avoid fdput() after failed fdget() in
 ksys_sync_file_range()
Message-ID: <20200508002422.GL23230@ZenIV.linux.org.uk>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
 <31be6e0896eba59c06eb9d3d137b214f7220cc53.1588894359.git.skhan@linuxfoundation.org>
 <20200508000509.GK23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508000509.GK23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 01:05:09AM +0100, Al Viro wrote:
> On Thu, May 07, 2020 at 05:57:09PM -0600, Shuah Khan wrote:
> > Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
> > fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
> > in fd.flags. Fix it anyway since failed fdget() doesn't require
> > a fdput().
> > 
> > This was introdcued in a commit to add sync_file_range() helper.
> 
> Er...  What's the point microoptimizing the slow path here?

PS: I'm not saying the patch is incorrect, but Fixes: is IMO over the
top.  And looking at that thing,
{
        struct fd f = fdget(fd);
        int ret;

	if (unlikely(!f.file))
		return -EBADF;

	ret = sync_file_range(f.file, offset, nbytes, flags);
        fdput(f);
        return ret;
}

might be cleaner, but that's a matter of taste...
