Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF554A2AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiFMXXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiFMXXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:23:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2031DFC;
        Mon, 13 Jun 2022 16:23:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 63E322D6;
        Mon, 13 Jun 2022 23:23:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 63E322D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1655162595; bh=DaRek4VCbbCEWDVHGSepYt+fEnKtHG9ut+awCzRUXRQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FvS3IOr2TAOGBY3ITgsqcvlVGpzQmoKdunLDI+3/shEpR/t7oSEVVeHoGDDdKX6dK
         Cd2H+2nc/WjM5b4sVQ8yNi7nlUuPXXG+a4sIK+UrOD6YPML0Y/EpPTvLykfUtrihqp
         1XS8NPeT74mLMvk6FtO/Ac9KHGggTSOoAru8AlmMmkiVFfNrdkZ8ngujBF+HYdqN34
         3UJ5krv9fnSnhbPSzoTQy5sHuxOwVSwaZWMBP/YU3q+oSaktASpzcEQaAUL/OUsBas
         i3jQ8659pZFpkCyCBVVeNy4nrowO+LjnbeEtjztKMVkqznwuc4JCXqMY6ZifUbJ8c6
         OCm5Hpe4Z58GQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine
 grained access control
In-Reply-To: <CAJHvVchdmV42qCgO6j=zGBi0DeVcvW1OC88rHUP6V66Fg3CSww@mail.gmail.com>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com>
 <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
 <Yqe6R+XSH+nFc8se@xz-m1.local>
 <CAJHvVchdmV42qCgO6j=zGBi0DeVcvW1OC88rHUP6V66Fg3CSww@mail.gmail.com>
Date:   Mon, 13 Jun 2022 17:23:14 -0600
Message-ID: <87k09kxi59.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Axel Rasmussen <axelrasmussen@google.com> writes:

> I think for any approach involving syscalls, we need to be able to
> control access to who can call a syscall. Maybe there's another way
> I'm not aware of, but I think today the only mechanism to do this is
> capabilities. I proposed adding a CAP_USERFAULTFD for this purpose,
> but that approach was rejected [1]. So, I'm not sure of another way
> besides using a device node.

I take it there's a reason why this can't be done with a security module
- either a custom module or a policy in one of the existing modules?
That sort of access control is just what security modules are supposed
to be for, after all.

Thanks,

jon
