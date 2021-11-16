Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E1453867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhKPRWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 12:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbhKPRWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:22:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506DEC061570;
        Tue, 16 Nov 2021 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TDnzmja9hI9WKSkG4Qxfy2JPZLgVUCwhGDMwKpDMzek=; b=A8YG7C88Ckyx3uSkeRGlWcBj7d
        kwjchQUf7JRLaAxFoUAubkT923ZqKX3raDrlUZw/6z17cEsC5A0BuAv2XfzjcBIgvzMoJ2u/5vQBh
        kWWxG/pXLHNgl2Po5mWM+BP/32n9Sm4MZiecqgL7nmX/6xeW/bGTOsOy/See/+q19WgUV3BfW7jg5
        mYDCuGQYWgbhXfjMcVt26ZqX5Idisxg9M2mESnlpwlhM7JgTL7/OpwBeAR5rVu5tCqBCRST3d/aCq
        NajygZxANl2QnEC+HJ5QiB9MmSLXfpgF8+0dkfUsNK5ir1qbH/wYwaidl8BMT+6xxmHNUOHPDcbjf
        BQiALoIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mn26x-006wWn-SF; Tue, 16 Nov 2021 17:19:11 +0000
Date:   Tue, 16 Nov 2021 17:19:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Eliminate compilation warnings for misc
Message-ID: <YZPoD0SV8F/QfE1c@casper.infradead.org>
References: <20211116080611.31199-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116080611.31199-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 04:06:11PM +0800, Tianjia Zhang wrote:
> Eliminate the following clang compilation warnings by adding or
> fixing function comment:

These warnings have nothing to do with clang.  They're produced by
scripts/kernel-doc:

                if (show_warnings($type, $declaration_name) && $param !~ /\./) {
                        print STDERR
                              "${file}:$.: warning: Function parameter or member '$param' not described in '$declaration_name'\n";
                        ++$warnings;
                }

They show up in any W=1 build (which tells you that people are not
checking their patches with W=1)

> +++ b/fs/file.c
> @@ -645,7 +645,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
>  
>  /**
>   * last_fd - return last valid index into fd table
> - * @cur_fds: files struct
> + * @fdt: fdtable struct

I don't think the word 'struct' there really conveys any meaning.

