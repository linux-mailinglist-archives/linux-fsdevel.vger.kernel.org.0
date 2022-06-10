Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6785465EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiFJLn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245135AbiFJLnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48CB74DCD
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 04:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A11620FB
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 11:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEE1C34114;
        Fri, 10 Jun 2022 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654861398;
        bh=uAoJOMm/jFrwg7G/KqvhVBfDYvYhv4ZWcIVOglFNyz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0CVZPR+MKqDu6AVOdUFrpc2pswxRnLM6NrmvQbS6K832dYKhOInGizHZ/HQLGcL/
         t6uAmCMIBxpUtx7zwuhDM+PZ9AJfyR2I7pMjOyPXO5+QxGuP+fPZggqipmhoYQVTnV
         EpDn5GP2V9lyIxop7bTqWJf5vO4KfDr0zJXvxaAvh4Y79v6gRGib60RFaienZiEUcP
         Ua8yLH2ew3NrkykKskY2621quaT0B0BqeaIqgExLmXOR7pk09gBltIoRD/sYD4zryR
         37l6zV/ql55cU5Q77mZuViHX6LnEQg0ZMNBU+fmIjYWygnRmtFALzLaeIT3ChkEPWS
         Y0wtEsHInpifA==
Date:   Fri, 10 Jun 2022 13:43:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 06/10] keep iocb_flags() result cached in struct file
Message-ID: <20220610114314.luotgueb2vgknm4k@wittgenstein>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
 <20220607233143.1168114-6-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607233143.1168114-6-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:31:39PM +0000, Al Viro wrote:
> * calculate at the time we set FMODE_OPENED (do_dentry_open() for normal
> opens, alloc_file() for pipe()/socket()/etc.)
> * update when handling F_SETFL
> * keep in a new field - file->f_i_flags; since that thing is needed only
> before the refcount reaches zero, we can put it into the same anon union
> where ->f_rcuhead and ->f_llist live - those are used only after refcount
> reaches zero.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me (independent of whether that'll be called f_i_flag or f_iocb_flags),
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
