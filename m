Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065476F1098
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 04:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbjD1C4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 22:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjD1C4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:56:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8C273B;
        Thu, 27 Apr 2023 19:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mEdI3Z6CTreItykU8veCrx/99eYfpK8Gh6SV7amEBi0=; b=seHWlYgdjaUbCRl6TG4VMh99ch
        ec4Fp45TlwMoxnqctUCZKm7uqeycSIrPUi5fz5wUZ31MHTYGMGR7f2xsaEknDSsz9hyTFOl0WfLog
        B3VCyrkETgv3yDQtGBTBMKEJi5JdJhiGx7qrFRvTyI713pGaXWUGi/v4tBBuJdTMaJr4uL75bRDsE
        MRC0tgp0I8cwg5AQrfy0yDVG6E1oJcOJJjDJ1PT8TF6+CTvCgxqv/8OXhgifrnP2jHbqnAmQvQUjy
        zpmbKaSPq6pDZtbMCwmeGBgJLvnEpCRab+pCkONDrx7ORrNZgJ1WCdZfCRBt8ieIRhfWSqwFaoGpk
        wV4sSxqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psEHN-004Br5-Mi; Fri, 28 Apr 2023 02:56:13 +0000
Date:   Fri, 28 Apr 2023 03:56:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEs1za7Q0U4bY08w@casper.infradead.org>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZEsGQFN4Pd12r+Nt@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEsGQFN4Pd12r+Nt@rh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 09:33:20AM +1000, Dave Chinner wrote:
> The block device needs to be shutting down the filesystem when it
> has some sort of fatal, unrecoverable error like this (e.g. hot
> unplug). We have the XFS_IOC_GOINGDOWN ioctl for telling the
> filesystem it can't function anymore. This ioctl
> (_IOR('X',125,__u32)) has also been replicated into ext4, f2fs and
> CIFS and it gets exercised heavily by fstests. Hence this isn't XFS
> specific functionality, nor is it untested functionality.
> 
> The ioctl should be lifted to the VFS as FS_IOC_SHUTDOWN and a
> super_operations method added to trigger a filesystem shutdown.
> That way the block device removal code could simply call
> sb->s_ops->shutdown(sb, REASON) if it exists rather than
> sync_filesystem(sb) if there's a superblock associated with the
> block device. Then all these 

I think this is the wrong approach.  Not that I've had any time to
work on my alternative approach:

https://www.infradead.org/~willy/banbury.html
