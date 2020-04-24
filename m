Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09B11B71A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 12:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgDXKLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgDXKLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:11:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37205C09B045;
        Fri, 24 Apr 2020 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=63eqvaxZAp7OS4S7rYpQU2Q5xJodUR5sgvC2fkZKUPw=; b=jVQVA2UyJk8C0S+mxfYgnhUGoI
        l5oJ0Eir3oGqzub+/rqK5r5BmgcZSlZnO3YFL1KAJIqFbBb8eNzU+skwZ1v1aIDwrLCLlAjyc7tgE
        DEepLbdKtdxJVJL1ayv4aJd5Vwfqx9H+ca4DkZUKwQwtD0BuPvMqKtPdDP60GaqRFbSSFktpuqHSu
        kQ4YdC/+6nJU/pzP6GSbWv77l9zcy9JBBYRB6tC5E+YwGAYw/7PIk8zQyJ07dzC2aMQMEQYJfnt9S
        JTktIxKD+Z6LatnwXG7FOCUMWRmGbzm6REB1MHlgew3Woa9m3fKxTiYhMoZEQf+5XmIv+8GlmAtAV
        YIhZwZ8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRvJJ-0004JM-BE; Fri, 24 Apr 2020 10:11:53 +0000
Date:   Fri, 24 Apr 2020 03:11:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Message-ID: <20200424101153.GC456@infradead.org>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587555962.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think the right fix is to move fiemap_check_ranges into all the ->fiemap
instances (we only have a few actual implementation minus the wrappers
around iomap/generic).  Then add a version if iomap_fiemap that can pass
in maxbytes explicitly for ext4, similar to what we've done with various
other generic helpers.

The idea of validating input against file systems specific paramaters
before we call into the fs is just bound to cause problems.
