Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732D91681C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 16:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBUPfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 10:35:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgBUPfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ZsaQJllFuL8jpNObDQrHmpdC/B73n9RqMvE0qPHxaM=; b=e19h/tTJERLUFpOL5Gva3Nh5/X
        wd0VH9aVgKh+1Blgs+9Q15ijaVkaoTLAy7WypYckq6maI2+/Qpa5TYpUzL45zkwW6/rKVd4gOa/Q3
        37XTTlJ3n85F+yMLVB8w0BnbSlS+Y+mVNSOJqRCX3b4kHG/mSGnd+/RHhL7LSbdq0PycpO3gHljyg
        1ePLpWP66QKkQwSW3hqI4AmWyW4KZvprzI+VqeFwh8xfQgZxihaUIj3MuUi6DWndVunwNc8HfQSPa
        cJzgSNpVLmszdlcuXvTGALnsMeU2uXmuwM6kJU9UgfbmbAX46oAsryhNENVSPO0btKS8JfbqGc1YR
        ErE1c+gA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5AL3-00062c-43; Fri, 21 Feb 2020 15:35:37 +0000
Date:   Fri, 21 Feb 2020 07:35:37 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 11/24] mm: Move end_index check out of readahead loop
Message-ID: <20200221153537.GE24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-12-willy@infradead.org>
 <e6ef2075-b849-299e-0f11-c6ee82b0a3c7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ef2075-b849-299e-0f11-c6ee82b0a3c7@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 07:50:39PM -0800, John Hubbard wrote:
> This tiny patch made me pause, because I wasn't sure at first of the exact
> intent of the lines above. Once I worked it out, it seemed like it might
> be helpful (or overkill??) to add a few hints for the reader, especially since
> there are no hints in the function's (minimal) documentation header. What
> do you think of this?
> 
> 	/*
> 	 * If we can't read *any* pages without going past the inodes's isize
> 	 * limit, give up entirely:
> 	 */
> 	if (index > end_index)
> 		return;
> 
> 	/* Cap nr_to_read, in order to avoid overflowing the ULONG type: */
> 	if (index + nr_to_read < index)
> 		nr_to_read = ULONG_MAX - index + 1;
> 
> 	/* Cap nr_to_read, to avoid reading past the inode's isize limit: */
> 	if (index + nr_to_read >= end_index)
> 		nr_to_read = end_index - index + 1;

A little verbose for my taste ... How about this?

        end_index = (isize - 1) >> PAGE_SHIFT;
        if (index > end_index)
                return;
        /* Avoid wrapping to the beginning of the file */
        if (index + nr_to_read < index)
                nr_to_read = ULONG_MAX - index + 1;
        /* Don't read past the page containing the last byte of the file */
        if (index + nr_to_read >= end_index)
                nr_to_read = end_index - index + 1;

