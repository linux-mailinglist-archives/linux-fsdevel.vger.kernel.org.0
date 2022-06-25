Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA155A90E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiFYKqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 06:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiFYKqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:46:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B482F64B;
        Sat, 25 Jun 2022 03:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321A1B803F7;
        Sat, 25 Jun 2022 10:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E121C3411C;
        Sat, 25 Jun 2022 10:46:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CLTB44LS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656153969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HO1H81VSmEESU98hDinjtktp6si9fLsaPygctgo2N8=;
        b=CLTB44LSlf7TkS2DI9TugN1jiskEyLCtOyb1VcWAQL35zlnA9vaBpzSWQXEb48eV/oWhlp
        Qo3mgGNWQTrLomAc/bqaxpun5DybSKvACxwj6vKGn/sI2oKCbw9d14xyxTdgrtzvaGWAxU
        fhzue9/gCHwqh9gQ8K9qTJRQzYiyLzA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 401867d6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Jun 2022 10:46:09 +0000 (UTC)
Date:   Sat, 25 Jun 2022 12:46:04 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: do not set no_llseek in fops
Message-ID: <YrbnbMcI+lbBoiHh@zx2c4.com>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
 <20220624165631.2124632-3-Jason@zx2c4.com>
 <YrYxOC5dgCKBHwVE@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrYxOC5dgCKBHwVE@ZenIV>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:48:40PM +0100, Al Viro wrote:
> On Fri, Jun 24, 2022 at 06:56:27PM +0200, Jason A. Donenfeld wrote:
> > vfs_llseek already does something with this, and it makes it difficult
> > to distinguish between llseek being supported and not.
> 
> How about something along the lines of
> 
> ===
> struct file_operations ->llseek() method gets called only in two places:
> vfs_llseek() and dump_skip().  Both treat NULL and no_llseek as
> equivalent.
> 
> The value of ->llseek is also examined in __full_proxy_fops_init() and
> ovl_copy_up_data().  For the former we could as well treat no_llseek
> as NULL; no need to do a proxy wrapper around the function that fails
> with -ESPIPE without so much as looking at its arguments.
> Same for the latter - there no_llseek would end up with skip_hole
> set true until the first time we look at it.  At that point we
> call vfs_llseek(), observe that it has failed (-ESPIPE), shrug and
> set skip_hole false.  Might as well have done that from the very
> beginning.
> 
> 	In other words, any place where .llseek is set to no_llseek
> could just as well set it to NULL.
> ===
> 
> for commit message?
> 
> Next commit would remove the checks for no_llseek and have vfs_llseek()
> just do
>         if (file->f_mode & FMODE_LSEEK) {
> 		if (file->f_op->llseek)
> 			return file->f_op->llseek(file, offset, whence);
> 	}
> 	return -ESPIPE;
> and kill no_llseek() off.  And once you have guaranteed that FMODE_LSEEK
> is never set with NULL ->llseek, vfs_llseek() gets trimmed in obvious
> way and tests in dump_skip() and ovl_copy_up_data() would become simply
> file->f_mode & FMODE_LSEEK - no need to check ->f_op->llseek there
> after that.  At the same time dump_skip() could switch to calling
> vfs_llseek() instead of direct method call...

Thanks. I'll split things into steps more or less like that and borrow
that commit text for v2 (which I'll send out somewhat soon).

Jason
