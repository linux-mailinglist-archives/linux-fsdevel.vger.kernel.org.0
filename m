Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422ED54DAA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 08:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359184AbiFPG3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358783AbiFPG3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:29:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC756B19;
        Wed, 15 Jun 2022 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=COuN5Zz+YBR/xeVdeWv1MuY4NtQSVs4UMHwcz0WDnnQ=; b=26COe9EvreWGEeNT1/sD1d3kfz
        6eiHSoJj3HJNczxIgN6ZNyHhGyF8lkqwkIOL2rgXq98uxDdUx8uC3Lu2IAjIfP6R/f0aliM5EVC6O
        1IhASH35qFwNzseZJ4XUFc3+jdZJ4c7Xluvv7sbbyUQTCbN3yrpBR/WmIvNi7io2ncbPNVRlOnIDy
        hqQ2OPazzRsUwaxn27aCXA9ZVEcHgflQQLkk46TasGiAi8tRAQZfnChJgkw8OGb0eXj325Mwkt6LL
        e0wbU4YbmLMbwRPuPBtRocrTHAynRb7PqFxnUF7o6IDlLRxUJhNefflB5q17jn1tsA4Npc8hfXRTy
        ddSAS+0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1j0i-000jIM-EX; Thu, 16 Jun 2022 06:29:44 +0000
Date:   Wed, 15 Jun 2022 23:29:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
Message-ID: <YqrN2J6r4Z+BIN+o@infradead.org>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
 <20220520032739.GB1098723@dread.disaster.area>
 <YqgbuDbdH2OLcbC7@sol.localdomain>
 <YqnapOLvHDmX/3py@infradead.org>
 <YqpzqZQgu0Zz+vW1@sol.localdomain>
 <YqrIlVtI85zF9qyO@infradead.org>
 <YqrLdORPM5qm9PC0@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqrLdORPM5qm9PC0@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:19:32PM -0700, Eric Biggers wrote:
> Yes I know that.  The issue is that the inode that statx() is operating on is
> the device node, so *all* the other statx fields come from that inode.  Size,
> nlink, uid, gid, mode, timestamps (including btime if the filesystem supports
> it), inode number, device number of the containing filesystem, mount ID, etc.
> If we were to randomly grab one field from the underlying block device instead,
> that would be inconsistent with everything else.

At least on XFS we have a magic hardcoded st_blksize for block devices,
but it seems like the generic doesn't do that.

But I'm really much more worried about an inconsistency where we get
usefull information or some special files rather than where we acquire
this information from.  So I think going to the block device inode, and
also going to it for stx_blksize is the right thing as it actually
makes the interface useful.  We just need a good helper that all
getattr implementations can use to be consistent and/or override these
fields after the call to ->getattr.
