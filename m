Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79ED4FB3CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbiDKGjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 02:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiDKGjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:39:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFAE222B7;
        Sun, 10 Apr 2022 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zuE9Oa+Qeir18sQSYzqnRYIpuPNJeRgzj07o7ivdwmk=; b=jhLaW6gCJNXjHQjbpXI001NoLm
        AdFauJ9hVbDbbdwuShc0kE3TWVJ7U6cHbS1IVv5Dkz7vDn/LxPDJbM1rz1CQYtaBq9enHaO+9NlL/
        jw3q0mng0Gv7hWxJJvqwU/5geav0RGI5PD2R26zZwNTmbVZ0e2qgaOoci6Tk8P03ECRbTlHhAWhWI
        Nu2CciiC2elMY1Hh1rOZEbKyZ+CMYK7ToiTB8yDWTIR+NTU9faXcILk2jK5BIglpKBW1v2DZQYhXT
        c4S6MZxbtPM/AI23zj/vdJiRazAwFyTd0o2QCLP287g1iNfUVd0oCI7ghVyoF7Tju6mc5yarGTDAJ
        +XuGp9AA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndnfr-006wdX-RD; Mon, 11 Apr 2022 06:37:19 +0000
Date:   Sun, 10 Apr 2022 23:37:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 2/7] mm: factor helpers for memory_failure_dev_pagemap
Message-ID: <YlPMn2DjbqzAVhrb@infradead.org>
References: <20220410160904.3758789-1-ruansy.fnst@fujitsu.com>
 <20220410160904.3758789-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410160904.3758789-3-ruansy.fnst@fujitsu.com>
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

> +	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
> +unlock:
> +	dax_unlock_page(page, cookie);
> +	return 0;

As the buildbot points out this should probably be a "return rc".
