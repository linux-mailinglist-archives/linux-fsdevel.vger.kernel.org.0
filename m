Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133DA5E670C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiIVP1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIVP1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F2F1D47
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9621361D05
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7D3C433C1;
        Thu, 22 Sep 2022 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663860452;
        bh=nWGmbB8g+8qk+t1a5h8c9rYD42cS2CTADo2o79qOM+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGqUBKuAqsuui5nXjJHhCssJMq+9H4wzleu+/RsLXibq9LPrdcs52DlNNn9UsRsDG
         wJcVhley5TbZd1cqhpkIAxPprGjQkQlHCushHy/l+H6Hnz5GiU5jXP0Q93eRYo85zi
         Gml6LbLpydbsODrJmTdhWyZVjaTdPwjP8H9AdGbz2wRHXiMRUbXUr4c+yVhEPZqGEi
         T5EP0o3ieM5JbKgPT5ve3qeD58rNbGrPcU/3FVFsgK2FKD5VDbXt+VfOooKFRQdICX
         kcQX/gb5FfpMXUjZEPOn3db6duxgeArD5sCjz0FhO1eRLyNyvwgJiWdxNAl/VA2BpF
         a/2A5yCxDPy4Q==
Date:   Thu, 22 Sep 2022 17:27:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 09/10] vfs: open inside ->tmpfile()
Message-ID: <20220922152727.6yyhnklkoz3lnhvb@wittgenstein>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
 <20220922084442.2401223-10-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922084442.2401223-10-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:44:41AM +0200, Miklos Szeredi wrote:
> This is in preparation for adding tmpfile support to fuse, which requires
> that the tmpfile creation and opening are done as a single operation.
> 
> Replace the 'struct dentry *' argument of i_op->tmpfile with
> 'struct file *'.
> 
> Call finish_open_simple() as the last thing in ->tmpfile() instances (may
> be omitted in the error case).
> 
> Change d_tmpfile() argument to 'struct file *' as well to make callers more
> readable.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Seems good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
