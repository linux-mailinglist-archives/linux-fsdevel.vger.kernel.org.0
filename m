Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1238D509068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 21:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381786AbiDTT1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381787AbiDTT1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:27:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE31427FE;
        Wed, 20 Apr 2022 12:24:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 015C8612C; Wed, 20 Apr 2022 15:24:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 015C8612C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650482659;
        bh=ziPMTeOUG26tWYhF3IoXdxqxKKwewkeusqsCcAWd1vo=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=QdQbwbi7DRafT804ouNvmbBuD5MwCqumbvlHb5bJa9U1jAstE6Wi3qq4xZUlFsGvY
         qMn/QfhID451WzZ+xrGAtKetjpEYAkfNFYhX+0wmHRX9HQQrNUaqe7dpBUJqcEKV0Q
         sHVLKJrfw3RUlhOB5T3q9f/LO9pKbIs4EnJJ5nTg=
Date:   Wed, 20 Apr 2022 15:24:18 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] Make NFSv4 OPEN(CREATE) less brittle
Message-ID: <20220420192418.GB27805@fieldses.org>
References: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:28:34PM -0400, Chuck Lever wrote:
> Attempt to address occasional reports of test failures caused by
> NFSv4 OPEN(CREATE) having failing internally after the target
> file object has been created.
> 
> The basic approach is to re-organize the NFSv4 OPEN code path so
> that common failure modes occur /before/ the call to vfs_create()
> rather than afterwards. In addition, the file is opened and created
> atomically so that another client can't race and de-permit the
> file just after it was created but before the server has opened it.
> 
> So far I haven't found any regressions. However I have not been
> able to reproduce the original failures.

I'll admit I don't know how big an impact those races have in practice.
But this has bugged me for a long time--thanks for finally tackling it.

I haven't reviewed it in detail but the basic idea looks good.

--b.

> Chuck Lever (8):
>       NFSD: Clean up nfsd3_proc_create()
>       NFSD: Avoid calling fh_drop_write() twice in do_nfsd_create()
>       NFSD: Refactor nfsd_create_setattr()
>       NFSD: Refactor NFSv3 CREATE
>       NFSD: Refactor NFSv4 OPEN(CREATE)
>       NFSD: Remove do_nfsd_create()
>       NFSD: Clean up nfsd_open_verified()
>       NFSD: Instantiate a struct file when creating a regular NFSv4 file
> 
> 
>  fs/nfsd/filecache.c |  51 +++++++--
>  fs/nfsd/filecache.h |   2 +
>  fs/nfsd/nfs3proc.c  | 141 +++++++++++++++++++++----
>  fs/nfsd/nfs4proc.c  | 197 +++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfs4state.c |  16 ++-
>  fs/nfsd/vfs.c       | 245 ++++++++++----------------------------------
>  fs/nfsd/vfs.h       |  14 +--
>  fs/nfsd/xdr4.h      |   1 +
>  fs/open.c           |  44 ++++++++
>  include/linux/fs.h  |   2 +
>  10 files changed, 471 insertions(+), 242 deletions(-)
> 
> --
> Chuck Lever
