Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0B25473E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiFKKpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFKKpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:45:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A5EA1;
        Sat, 11 Jun 2022 03:45:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i131-20020a1c3b89000000b0039c6fd897b4so1762900wma.4;
        Sat, 11 Jun 2022 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=a9ATP95JSYITDvtcZYgILfU969WEQUwCi9QMxQISlfw=;
        b=bOBnz4yOrLBIRe9lNqLmJJYNnTUBHYxgfPjC/Q+c+by0cC6DrcHXWzzXAAQKsWs5Xy
         7H5yh5q+cSCvj9FDMI2qYQwgyW+KWhJ5k4Zjat9u+hNJxzSFcF9q10k2J5+e+E3DNndL
         lCeqaymyirCu8HVKMhERgx6kH5f/6tDGJgbu3uYRTJve23lgY17J/z/qiWTHFjMWeJuc
         6jWKfE1WBzb6/qjzIx+YjukuvouZ/eHUhHYDqj4SV5vy3IZq76QEZ/fcBwqOS75Fi9ZM
         L8426YwsgzDm0cHOigB5uFuAKuHESYnbHqM+qoIfxha1dqjpYNU0dW0RZF4Cu4SJ8mUb
         LJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=a9ATP95JSYITDvtcZYgILfU969WEQUwCi9QMxQISlfw=;
        b=XidExkdP1ECg1oAUYLt3Vd969OjzBYlCs7UMNyT0CMRwGqIvUPZI7hNdgHyd3QXd4k
         1AzksVtYq1nqJtkcvsyrGpn2N5XUYfxM4oKmFGPjk5rwKRhIxLEQfArlV4tDBBo+iTpV
         AddCFEZw+l7e+f8QJYfAlxgEF48CWMpwA+nnERPRgJSPpSbC4f4IVCktQRRFsly8AUkT
         0aeNXxZTgQ8qSY3OKTc2ovE4lSYLn778GgVPPMgs5w1+1LPbRlabeoldbv+RmX3IKg/R
         FxdsEqY3DTt5yaeGSD+hW3qKlcFBN4eeB3pPiNn0EQP4HClDt3M77qysBMEEUiUCZOGS
         8uaA==
X-Gm-Message-State: AOAM5304Ic2/B4Rz2AEbGTcj5eNlQ6bKqSyvNqm41m9KSZkOy7J+YQUw
        i6fdpYyloKlUFOl6whYtkko=
X-Google-Smtp-Source: ABdhPJxjfvo6XrtQ+Hcu7hnFyGXxQzXmb+60Sxx8moqSaXPRMMOx26YUKe+ROCWhkMhCSBz3y1N/cg==
X-Received: by 2002:a05:600c:4e8e:b0:39c:80ed:68ad with SMTP id f14-20020a05600c4e8e00b0039c80ed68admr4069701wmq.63.1654944305505;
        Sat, 11 Jun 2022 03:45:05 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b00397122e63b6sm2006978wmg.29.2022.06.11.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 03:45:05 -0700 (PDT)
Date:   Sat, 11 Jun 2022 11:45:03 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqRyL2sIqQNDfky2@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for "arm allmodconfig",
"xtensa allmodconfig" and "csky allmodconfig" with the error:

In file included from ./include/linux/kernel.h:26,
                 from ./include/linux/crypto.h:16,
                 from ./include/crypto/hash.h:11,
                 from lib/iov_iter.c:2:
lib/iov_iter.c: In function 'iter_xarray_get_pages':
./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
lib/iov_iter.c:1464:16: note: in expansion of macro 'min'
 1464 |         return min(nr * PAGE_SIZE - offset, maxsize);
      |                ^~~
lib/iov_iter.c: In function 'iter_xarray_get_pages_alloc':
./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
lib/iov_iter.c:1628:16: note: in expansion of macro 'min'
 1628 |         return min(nr * PAGE_SIZE - offset, maxsize);


git bisect pointed to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")

And, reverting it on top of mainline branch has fixed the build failure.

--
Regards
Sudip
