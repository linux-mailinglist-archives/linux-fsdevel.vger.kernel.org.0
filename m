Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A601F72A9CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 09:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjFJHSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 03:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFJHSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A93A9B;
        Sat, 10 Jun 2023 00:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06DDC6113C;
        Sat, 10 Jun 2023 07:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25373C433D2;
        Sat, 10 Jun 2023 07:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686381490;
        bh=cf+Bkk6mucXugv1xsA2ILX2PO2fEzeaOC9b8JKPSR74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPgXFhLTrIUFP5qo6b0/l5GftYFWIej9ZQ382PJmjiAPyGpSy+WTkCXRZ+v0nbP3p
         bkx/N4H9VyDqmYqNXcmYeTJXmr++2h26kzI2KBllgDOyuv1dltrd7hj8Ex0AaXKQZ4
         guuw0FD+rfmQHg26Cii5QwMyyy7LR1mxMGeI6f0WWuuLz8ZITeu3LBk/cbkSgUtoDG
         M4FKnEfXDVrvrav3OvOdaIA6C7bgWmb6iMBfsfVALRQ2nvR/JO84ZV9uLW7TXAuw1p
         7j1PKnBBeuMfzAp31Q2HLBzdEgdAhGN0JlTcmzpeT4geJ2bt1xCfGFIOrTUGeVUGH2
         xXVmk/iX3zynw==
Date:   Sat, 10 Jun 2023 09:18:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Colin Walters <walters@verbum.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ovl: port to new mount api
Message-ID: <20230610-kaktus-leisten-71d4aa7f6640@brauner>
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
 <20230605-fs-overlayfs-mount_api-v2-1-3da91c97e0c0@kernel.org>
 <4229ded1-5c61-42fc-aaf9-50fc9c756885@betaapp.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4229ded1-5c61-42fc-aaf9-50fc9c756885@betaapp.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:09:08PM -0400, Colin Walters wrote:
> Cool work.  It will be interesting to do some performance testing on what does it actually look like to create ~500 or whatever overlayfs layers now that we can.
> 
> On Fri, Jun 9, 2023, at 11:41 AM, Christian Brauner wrote:
> > 
> > +static int ovl_init_fs_context(struct fs_context *fc)
> > +{
> > +	struct ovl_fs_context *ctx = NULL;
> > +	struct ovl_fs *ofs = NULL;
> > +
> > +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> > +	if (!ctx)
> > +		goto out_err;
> 
> It looks to me like in this case, ofs will be NULL, then:
> 
> > +out_err:
> > +	ovl_fs_context_free(ctx);
> > +	ovl_free_fs(ofs);
> 
> And then we'll jump here and `ovl_free_fs` is not NULL safe.
> 
> I think the previous code was correct here as it just jumped directly to "out:".

Good catch, thanks!

> 
> 
> (I've always wondered why there's no usage of __attribute__((cleanup))
> in kernel code and in our userspace code doing that we have the free
> functions be no-ops on NULL which systematically avoids these bugs,
> but then again maybe the real fix is Rust ;) )

I have talked about this before and actually do have a PoC patch in my
tree somewhere I never bothered to send it because it didn't feel like I
had the time for the flamewar+bikeshed that would end up
happening... Maybe I should just try.
