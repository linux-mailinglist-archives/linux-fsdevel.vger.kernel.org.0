Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB0672A5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 22:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjARVX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 16:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjARVXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:23:55 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A75D11C
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 13:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n+mw9lCCjk5X3T9xtDdQJN9vPxX3IIIv9RMOBrZipMA=; b=cAcwD9Cv2X/HLr205M+1qJdJXE
        pnbobwarCEbw82zWge6795tasauPOC6nTrME3SDL8CrYud98PgtHcXfwYjC30jJ1OF/7tkVM58L+o
        PPMTE8G72UtPDBmZOTH2LCB/ibZ9Ls1TDsCdUdFXP3USV2XyZNaW2HrqDU/RVEOC12LmPb7xQFNee
        eY3j+DoyNoeMk85olgLjZcosXq8a29WdbK7adbqgN5s6R3ffw5vwaqnU/CIYV5d9Z6DpgjK/ECkha
        IggWE5LpZD1SCEGA9mKPEXo7qgsyibWXcEE4kFBOUMY+L+b8WKIS8OOlRiH6qiG+Ga1Auxt3cXR5W
        s8CKCskQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIFuD-002cb0-29;
        Wed, 18 Jan 2023 21:23:37 +0000
Date:   Wed, 18 Jan 2023 21:23:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove most callers of write_one_page v3
Message-ID: <Y8hjWSfC8TVCx5Fe@ZenIV>
References: <20230118173027.294869-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118173027.294869-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 06:30:20PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes most users of the write_one_page API.  These helpers
> internally call ->writepage which we are gradually removing from the
> kernel.
> 
> Changes since v2:
>  - more minix error handling fixes
> 
> Changes since v1:
>  - drop the btrfs changes (queue up in the btrfs tree)
>  - drop the finaly move to jfs (can't be done without the btrfs patches)
>  - fix the existing minix code to properly propagate errors

Grabbed.  I'll split that into per-fs branches (and synchronize wrt
fixes), fold the kmap_local stuff into that and push out.
