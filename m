Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5801436BF49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 08:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhD0Gah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 02:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0Gah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:30:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E88C061574;
        Mon, 26 Apr 2021 23:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r/PKhDSOpuWVr+iFptHfckso/hHr0MElpssnEZU9ivc=; b=t9mh6FBuC9Q6m6Enq+ly4WxESH
        mT9pTb/kWbZcUPQ/2+eQFn4c3qeB+Uacs9KFcE/oh+/JwyoYXcZvkoaxwwT7pieJlc35Qe1JIbm6r
        ZOGJAr21vCmO7XF/wZXQAEuEpS7JVCSOWlWyK2YKeFvrI65uv0DV7Q7soPVHJ3RS7RSRr4dWwTA60
        pPffe0QyygoYiTTiltxuCTKdm1XUCP8UaZm3fdB0oXG6/32cJMkIT9eYHRIbWYmInYJXXBGDo7OZT
        w4bTgXAYjwnJAVam9HyTeanfOzo4t1YlNvSLe6ACMjwSPdPnHSwL+aY1POS5JqZR2WFT1gZcb2FwG
        I8/7E5ww==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbHDX-006ZEG-GN; Tue, 27 Apr 2021 06:29:12 +0000
Date:   Tue, 27 Apr 2021 07:29:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v8 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <20210427062907.GA1564326@infradead.org>
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
 <20210423205136.1015456-5-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423205136.1015456-5-shreeya.patel@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 24, 2021 at 02:21:36AM +0530, Shreeya Patel wrote:
> utf8data.h_shipped has a large database table which is an auto-generated
> decodification trie for the unicode normalization functions.
> We can avoid carrying this large table in the kernel unless it is required
> by the filesystem during boot process.
> 
> Hence, make UTF-8 encoding loadable by converting it into a module and
> also add built-in UTF-8 support option for compiling it into the
> kernel whenever required by the filesystem.

The way this is implemement looks rather awkward.

Given that the large memory usage is for a data table and not for code,
why not treat is as a firmware blob and load it using request_firmware?
