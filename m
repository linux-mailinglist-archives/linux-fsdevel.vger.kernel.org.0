Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3922623B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 05:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiKJEvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 23:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiKJEvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:51:16 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726662AE1D
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 20:51:15 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso548144otb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Nov 2022 20:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XcT5wYQupLzg19Y6E3tP1wvyvte8y3AvHnzNS4m/36k=;
        b=EHBPgvKuqA3VaRdnYpGt106ghiBtTas2lcZUJ/pEPRYh8Sa73Z7c2+aa43sgNJzDdG
         aZ6YStv67RdwKG20JZlWd+bLKdrA9r8aS0xpabt+nwGKWiiEwp8U31O8K5ezuL5u9fyB
         En2WGN0oZxJLiQr10nIFItho5sbPNNjVNhHdFV1HN7BSX6Um+RJLXxRH1QsEeOm51Exn
         8O3B6vr0WvecAvtNj79DhTeoORcyaMnG4QoJwNAfgKAF+PgOBy3ou4PqdhpGeVzIIwb1
         8fy2DtTAdovczvGXrDGoy4krAdGtqkJeQ2AkFsAUpBiV6f5ghendOmfPbUnwyrktUWR3
         dU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcT5wYQupLzg19Y6E3tP1wvyvte8y3AvHnzNS4m/36k=;
        b=axg6BjeyQyCBGP++MZQGfYU9VSFlKqZMhAXBylQCIwnltx5K4QFFVfBsCYvHjjLICc
         UvhQa3euKczVD4oEUpOEbR/1SegQUtCNjcC3L+0YO9l4KnRe/xprSA90yIuDaH+KaCAE
         jpchsaFpLcR3u0LRK7QG9YmfgZ3ndnZogMsMjWnAp9Cx4R8LzLmLvADDwBQCB24KqQM3
         H028TrJTb+zcO1xzBrLgvbY35qrRClZztad5L7Oj45+MM3acpN+dGbxumUeO/e1WNstC
         VqdON3QoxLISQArKgAdswpN4ug71jcvCBc0qEU8q4z8y5lQnVHsEB/yGDvSXyXLkn+HM
         F/Nw==
X-Gm-Message-State: ACrzQf2I1ogAA8/3cnYqeIqKZEcnPJ8h9oSx70mhvwPd6baB+ueI54lu
        K5c0ltJYtj9GThrh2RSK1PHVkNeMi+aakbNcmQBxJXDU9B+6
X-Google-Smtp-Source: AMsMyM7fystvIOT5xQlaYpTx0YsqbQK9PnqebQYjDZNsxZUJmgLu8IislPk174wIXybPlJtY6hf+UPrtvpA2p6LdqYQ=
X-Received: by 2002:a9d:1aa:0:b0:66c:6922:8640 with SMTP id
 e39-20020a9d01aa000000b0066c69228640mr1065616ote.34.1668055874749; Wed, 09
 Nov 2022 20:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20221110043614.802364-1-paul@paul-moore.com>
In-Reply-To: <20221110043614.802364-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 23:51:04 -0500
Message-ID: <CAHC9VhRtCbOO7ppCpOPAa_oZxK5rBG0gXhrcJQdp8VwhCdksEA@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,fs: fix vfs_getxattr_alloc() return type and
 caller error paths
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 9, 2022 at 11:36 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The vfs_getxattr_alloc() function currently returns a ssize_t value
> despite the fact that it only uses int values internally for return
> values.  Fix this by converting vfs_getxattr_alloc() to return an
> int type and adjust the callers as necessary.  As part of these
> caller modifications, some of the callers are fixed to properly free
> the xattr value buffer on both success and failure to ensure that
> memory is not leaked in the failure case.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/xattr.c                                |  5 +++--
>  include/linux/xattr.h                     |  6 +++---
>  security/apparmor/domain.c                |  3 +--
>  security/commoncap.c                      | 22 ++++++++++------------
>  security/integrity/evm/evm_crypto.c       |  5 +++--
>  security/integrity/evm/evm_main.c         |  7 +++++--
>  security/integrity/ima/ima.h              |  5 +++--
>  security/integrity/ima/ima_appraise.c     |  6 +++---
>  security/integrity/ima/ima_main.c         |  6 ++++--
>  security/integrity/ima/ima_template_lib.c | 11 +++++------
>  10 files changed, 40 insertions(+), 36 deletions(-)

Mimi, I'm particularly interested in your thoughts on this patch as
there are a number of places in the IMA/EVM code that needed some
additional tweaks to prevent a memory leak like we fixed in the
capabilities code via 8cf0a1bc1287 ("capabilities: fix potential
memleak on error path from vfs_getxattr_alloc()").

-- 
paul-moore.com
