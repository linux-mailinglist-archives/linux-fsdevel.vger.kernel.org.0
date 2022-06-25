Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE63955ACDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 00:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiFYWPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 18:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFYWPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031A12D05;
        Sat, 25 Jun 2022 15:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E83EA60F21;
        Sat, 25 Jun 2022 22:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E76C3411C;
        Sat, 25 Jun 2022 22:15:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QIh8RFGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656195320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H29Ca5HvHKasX7h8uewLZ03V0uGq8al7k3+cuMznERA=;
        b=QIh8RFGw9o2XaCCRhaeLfJiL6lnWV0SUNIEDhho3Lcc8y02qO8MKBMvcpH2Sx4q7hNnyie
        fYPX2dKoiLJS4+9QGihtEOPvQ4eg31AnbMw9KCTfOu6aaBZ+4/0XpeJ/DXJoG1QaqgtLFA
        xnKtZrA2jubO9nuFWvA6LuM6ptS0Gs8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 197cef61 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Jun 2022 22:15:20 +0000 (UTC)
Date:   Sun, 26 Jun 2022 00:15:18 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Steve French <stfrench@microsoft.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] ksmbd: use vfs_llseek instead of dereferencing
 NULL
Message-ID: <YreI9h957ZWv99OR@zx2c4.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220625110115.39956-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

On Sat, Jun 25, 2022 at 01:01:08PM +0200, Jason A. Donenfeld wrote:
> By not checking whether llseek is NULL, this might jump to NULL. Also,
> it doesn't check FMODE_LSEEK. Fix this by using vfs_llseek(), which
> always does the right thing.
> 
> Fixes: f44158485826 ("cifsd: add file operations")
> Cc: stable@vger.kernel.org
> Cc: linux-cifs@vger.kernel.org
> Cc: Steve French <stfrench@microsoft.com>
> Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
> Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

This commit has been reviewed by Namjae and acked by Al. The rest of the
commits in this series are likely -next material for Al to take in his
vfs tree, but this first one here is something you might consider taking
as a somewhat important bug fix for 5.19. I marked it for stable@ and
such as well. Your call -- you can punt it to Al's -next branch with the
rest of the series if you want -- but I think this patch is a bit unlike
the others. This occurred to me when I saw you sent some cifs fixes in
earlier this evening.

Jason
