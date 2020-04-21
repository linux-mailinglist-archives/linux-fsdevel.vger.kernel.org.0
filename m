Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D675A1B1E42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 07:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDUFmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 01:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgDUFmM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:42:12 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7544A2084D;
        Tue, 21 Apr 2020 05:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587447732;
        bh=2gulgVkFfAjn3Pl1PNqXRXmkM/QzduOVT11dMu8o86o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ApJOmYR1uYAyNlSBQToll/A86aHlF3kQ/tdWHawXyGpKjOxTqiRWCqHSR3WazJzIA
         4L+nLEixqzeyYNqXfuV8TjK7idDUh5mHndFGgD9WMc/H8gSw+Vy/J9jJ49qwecfb3F
         M7IdSAdFh4D9we0/ZFSI3sw35uAquW5tJmZTokec=
Date:   Mon, 20 Apr 2020 22:42:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v11 19/25] erofs: Convert compressed files from
 readpages to readahead
Message-Id: <20200420224210.dff005bc62957a4d81d58226@linux-foundation.org>
In-Reply-To: <20200414150233.24495-20-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
        <20200414150233.24495-20-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Apr 2020 08:02:27 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> 
> Use the new readahead operation in erofs.
> 

Well this is exciting.

fs/erofs/data.c: In function erofs_raw_access_readahead:
fs/erofs/data.c:149:18: warning: last_block may be used uninitialized in this function [-Wmaybe-uninitialized]
	*last_block + 1 != current_block) {

It seems to be a preexisting bug, which your patch prompted gcc-7.2.0
to notice.

erofs_read_raw_page() goes in and uses *last_block, but neither of its
callers has initialized it.  Could the erofs maintainers please take a
look?
