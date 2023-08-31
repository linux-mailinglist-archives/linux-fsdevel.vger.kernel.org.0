Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8578E749
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjHaHku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 03:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjHaHku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:40:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCED1A3;
        Thu, 31 Aug 2023 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ccB2LVS/tUuk3eRzpdd7XrE+xJv3Lnyhqf1GwTcQim4=; b=jR3MbC+/65/URnB/bkJ1K/qbdS
        FHWnPkcvI8M4NbUoIEzjY6WKflMQKm05oQ1ylQ8VeKE8ftOzi74+Bbz85vbPirY1O9VK3Ob1YJuxb
        yChN3vf/qipA683IvOfGA45djmrelDJiiVWtdj29q4J+J3TBfihlHkGE3L8BqySU1SvrQcXSn335N
        6vSxmSDeSxNOeSnRBpTApxN2v0g7RE9Ul1DWHobgJnCBMIhfC2HEEbw1MeUUKm+Q9yJJLObVQa2V3
        HS06nRF7mJNgj60Y62zkjhJzXkebK2YxWnwcf/5lM5QEMcGNjXN0QdS7v62moRD9TRj838cKfWVng
        HGk2+pzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbcIH-00EpUK-1a;
        Thu, 31 Aug 2023 07:40:45 +0000
Date:   Thu, 31 Aug 2023 00:40:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/2] Use exclusive lock for file_remove_privs
Message-ID: <ZPBD/X9IUrz46Sia@infradead.org>
References: <20230830181519.2964941-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830181519.2964941-1-bschubert@ddn.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:15:17PM +0200, Bernd Schubert wrote:
> While adding shared direct IO write locks to fuse Miklos noticed
> that file_remove_privs() needs an exclusive lock. I then
> noticed that btrfs actually has the same issue as I had in my patch,
> it was calling into that function with a shared lock.
> This series adds a new exported function file_needs_remove_privs(),
> which used by the follow up btrfs patch and will be used by the
> DIO code path in fuse as well. If that function returns any mask
> the shared lock needs to be dropped and replaced by the exclusive
> variant.

FYI, xfs and ext4 use a simple IS_NOSEC check for this.  That has
a lot more false positives, but also is a much faster check in the
fast path.   It might be worth benchmarking which way to go, but
we should be consistent across file systems for the behavior.

