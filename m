Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098145465EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiFJLla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbiFJLlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:41:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC657938A
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 04:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C84CCB8346F
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 11:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35E5C34114;
        Fri, 10 Jun 2022 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654861267;
        bh=fjE1pzZ/X6OSLXx6aGvs3TrgfGZ0BAZAVl5pMq3acB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+/GFrGvXB17wuFtMN0ps9clMX+iEtSH6epxtQ/Y4gcsM6cXlbMy7VCu0EZABqOyp
         iYIQXj9kyVjL2rWIi0EorcWB+e6HbNc+B2IhU5tqNhlTBaFWM/bC+v9rg5NjtnGLVS
         mMrb38urcspE85hp9uGz3zvNX9mVihzhWdaaNy9uFxKXpEaP5OiqIci+RMAmk7JdId
         TGIvw1mHe902uoi4aHDpGeB4GQJSvNVgMQoq6n76ft5kUFh+nnHEz7jx5r1yykiGOX
         cknJJ3jUgDP6g8PwUhbyhN2Z/jz2/a0vbCYfHkygtRm4lR9YC2/+a2ai3L/Pd+wsY6
         mhEqjiYOPwTKg==
Date:   Fri, 10 Jun 2022 13:41:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 05/10] iocb: delay evaluation of IS_SYNC(...) until we
 want to check IOCB_DSYNC
Message-ID: <20220610114102.tg3jldzybad3nsol@wittgenstein>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
 <20220607233143.1168114-5-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607233143.1168114-5-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:31:38PM +0000, Al Viro wrote:
> New helper to be used instead of direct checks for IOCB_DSYNC:
> iocb_is_dsync(iocb).  Checks converted, which allows to avoid
> the IS_SYNC(iocb->ki_filp->f_mapping->host) part (4 cache lines)
> from iocb_flags() - it's checked in iocb_is_dsync() instead
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
