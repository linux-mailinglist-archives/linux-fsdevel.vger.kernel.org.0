Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0661A73DF23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjFZM2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjFZM15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:27:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACED26A8;
        Mon, 26 Jun 2023 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Fnlcm06KG3ZhOYahi/chwTRVVkhSDvG0K9SeqiS5DE=; b=Kbk3zz0BfOzOZJUrGovlBDWliQ
        DVc4oS4e8s4KFQMM3PWa1fNnBIg/2eIYh3q936RZcyrYe2kuW1PAeKdeixEad6/EGoF4ZpjXq3Xe/
        vGPuiBF0Z/OIm5a1SMcqWIH0CMThpXe7QNYPkVknc+cx9l/s+70tRVs9ocToTahg2S6CdEuWpEH92
        8e4s7psYmG39wYTJhkdnjQrFvribhVHhJwoCYbjuzo43AFftERadw3hMP8Lqk0K7nNkWXxYu70MDc
        D1o2OIB8XBlCWRy+S3Ufq9QgbHxawyR9LnN///ppSLe1tXGrxF+JfMypyKbloYl8x0twn/gOwVrZh
        HPUMQT0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDlJ1-001hwh-NT; Mon, 26 Jun 2023 12:26:55 +0000
Date:   Mon, 26 Jun 2023 13:26:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [RESEND PATCH v3 0/2] clean up block_commit_write
Message-ID: <ZJmED0CpVewunniH@casper.infradead.org>
References: <20230626055518.842392-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626055518.842392-1-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:55:16AM +0200, Bean Huo wrote:
> change log:
>     v1--v2:
>         1. reordered patches
> 
>     v2--v3:
>         1. rebased patches to git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next

It's be nice to have a bit of an explanation for the whole series here,
but I think the two patches work standalone.

If you'd like to extend this work, you could convert the callers of
block_commit_write() to use a folio instead of a page and then unify
block_commit_write() and __block_commit_write() as you did in the earlier
version of your patchset.  It shouldn't be too hard, both callers in
ext4 and the caller in iomap are already done.  That just leaves the
three callers in ocfs2 and the one caller in udf.
