Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E07C6293B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiKOI7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiKOI7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:59:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CB9765E;
        Tue, 15 Nov 2022 00:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zRTnc192G555hOHtI3ujNPRHECrdactujURMebxrasQ=; b=I5xygQ/bmGDcN/Q478BUErg/aK
        mAYLTrD0B9ZyRJjEO4sd5wizRMtfRx8sJBOuZaO8quU7/lIEP+fsni+CzlDUce9U9FHxRnhvevJFV
        4lmPDB0OGWfY7X9NK+oMZ4h3Gj5uDqUduii7yY1jaG8NVqlpgP5yC8KJMIFJtlZlCnKhyL6xX93I5
        WLAi+ieVp5otPHF8b1LDC8ihvKbG1tfkW3aTcSnx+qoqUsh0c9S4Dy433UYcKK5KIld0HHXRBC443
        gULYkMjPAf7dPbuIB0TPcXSDd1v3YsV6ApfjlvRRlOt79h2GR9PUMHElut3Jl/aMtL6VEIQZ2M5B1
        4tugcdCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourme-00968E-Gi; Tue, 15 Nov 2022 08:59:08 +0000
Date:   Tue, 15 Nov 2022 00:59:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] filelock: remove redundant filp argument from
 vfs_lock_file
Message-ID: <Y3NU3AP+SFbSEVeo@infradead.org>
References: <20221114150240.198648-1-jlayton@kernel.org>
 <20221114150240.198648-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114150240.198648-2-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:02:38AM -0500, Jeff Layton wrote:
> -int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock *fl, struct file_lock *conf)
> +int vfs_lock_file(unsigned int cmd, struct file_lock *fl, struct file_lock *conf)

I'd pass fl as the first argument for a saner argument order here.
Also can you please break the line at 80 characters?  The previous
version is insanely unreadable, and the new one just slightly less
so.

> +extern int vfs_lock_file(unsigned int, struct file_lock *, struct file_lock *);

And please drop the pointless extern here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
