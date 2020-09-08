Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E05260926
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 06:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgIHD77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 23:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgIHD76 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:59:58 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2312921532;
        Tue,  8 Sep 2020 03:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599537598;
        bh=vutJn3bXaUslL3kDw+93DPKmxLKkVjVONv+fNmUNOgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfPir04GCJBxwFVTIlizrKIE14UBLwFUQvhV8BAIsX9ww146J2Tmbm52GqxiUQANk
         3jV1UdsOzPS5BUSX1sLRCmp0m0y7SxxPbQR2LVCCpSHLe9hScCQz53LrvKxrv6M2Og
         7Qst4SPnQtWYI4R/FydLrp/pAydZ8Pt35E9uhW1s=
Date:   Mon, 7 Sep 2020 20:59:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/18] lib: lift fscrypt base64 conversion into
 lib/
Message-ID: <20200908035956.GH68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-8-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-8-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:26PM -0400, Jeff Layton wrote:
> Once we allow encrypted filenames on ceph we'll end up with names that
> may have illegal characters in them (embedded '\0' or '/'), or
> characters that aren't printable.
> 
> It will be safer to use strings that are printable. It turns out that the
> MDS doesn't really care about the length of filenames, so we can just
> base64 encode and decode filenames before writing and reading them.
> 
> Lift the base64 implementation that's in fscrypt into lib/. Make fscrypt
> select it when it's enabled.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/Kconfig            |  1 +
>  fs/crypto/fname.c            | 64 ++------------------------------
>  include/linux/base64_fname.h | 11 ++++++
>  lib/Kconfig                  |  3 ++
>  lib/Makefile                 |  1 +
>  lib/base64_fname.c           | 71 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 90 insertions(+), 61 deletions(-)
>  create mode 100644 include/linux/base64_fname.h
>  create mode 100644 lib/base64_fname.c
> 

I'm still concerned that this functionality is too specific to belong in lib/ at
the moment, given that it's not the most commonly used variant of base64.  How
about keeping these functions in fs/crypto/ for now?  You can call them
fscrypt_base64_encode() and fscrypt_base64_decode() and export them for ceph to
use.

> diff --git a/lib/base64_fname.c b/lib/base64_fname.c
> new file mode 100644
> index 000000000000..7638c45e4035
> --- /dev/null
> +++ b/lib/base64_fname.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Modified base64 encode/decode functions, suitable for use as filename components.
> + *
> + * Originally lifted from fs/crypto/fname.c
> + *
> + * Copyright (C) 2015, Jaegeuk Kim
> + * Copyright (C) 2015, Eric Biggers
> + */

Please don't change the copyright statements.  The original file had:

 * Copyright (C) 2015, Google, Inc.
 * Copyright (C) 2015, Motorola Mobility

- Eric
