Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7394EC8D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348430AbiC3PyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348425AbiC3PyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:54:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3ACF05;
        Wed, 30 Mar 2022 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BW4xB1E0Wz9zQM2RhY0W9y2eD+oHCvNkoCEgXM+QgRg=; b=cKQgGbj3Q5DyGXPpUah3X4jqQ/
        E4zT/CCDEFDmGH6GZFsioH1Rzvzp/Qv7GNxXSV1AzJU/lwoR8DWgL1Py5fzwRRa0OKiqWi544F4iL
        jAsfiaqCuYvKVBk0mJNe1FXjiajtDG+SDTjeeqneFCZ/qD+zgTc9hDT7uL7rDPacPdxpZVbbYTYGu
        AB55ncNM+WLF1lw375xOZvn4r0ONt6GXBt3Bo8QvUPJ8EgW4ZHakxLUCOzDEPHcuuRAq8FPbltqaz
        JlGOY1qTwnKEEFLiRxBWNyDUQ2RV8DIJeYed2YbbLfN1p1MdhrEVlveSg2gloIlAdEQpZoKmoRoIb
        4QbqS9Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZacP-00GfjC-Rv; Wed, 30 Mar 2022 15:52:21 +0000
Date:   Wed, 30 Mar 2022 08:52:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, jane.chu@oracle.com
Subject: Re: [PATCH v11 7/8] xfs: Implement ->notify_failure() for XFS
Message-ID: <YkR8tfSn+M51fbff@infradead.org>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-8-ruansy.fnst@fujitsu.com>
 <YkPyBQer+KRiregd@infradead.org>
 <894ed00b-b174-6a10-ee45-320007957ea4@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894ed00b-b174-6a10-ee45-320007957ea4@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:16:10PM +0800, Shiyang Ruan wrote:
> > > +#if IS_ENABLED(CONFIG_MEMORY_FAILURE) && IS_ENABLED(CONFIG_FS_DAX)
> > 
> > No real need for the IS_ENABLED.  Also any reason to even build this
> > file if the options are not set?  It seems like
> > xfs_dax_holder_operations should just be defined to NULL and the
> > whole file not supported if we can't support the functionality.
> 
> Got it.  These two CONFIG seem not related for now.  So, I think I should
> wrap these code with #ifdef CONFIG_MEMORY_FAILURE here, and add
> `xfs-$(CONFIG_FS_DAX) += xfs_notify_failure.o` in the makefile.

I'd do

ifeq ($(CONFIG_MEMORY_FAILURE),y)
xfs-$(CONFIG_FS_DAX) += xfs_notify_failure.o
endif

in the makefile and keep it out of the actual source file entirely.

> > > +
> > > +	/* Ignore the range out of filesystem area */
> > > +	if ((offset + len) < ddev_start)
> > 
> > No need for the inner braces.
> > 
> > > +	if ((offset + len) > ddev_end)
> > 
> > No need for the braces either.
> 
> Really no need?  It is to make sure the range to be handled won't out of the
> filesystem area.  And make sure the @offset and @len are valid and correct
> after subtract the bbdev_start.

Yes, but there is no need for the braces per the precedence rules in
C.  So these could be:

	if (offset + len < ddev_start)

and

	if (offset + len > ddev_end)
