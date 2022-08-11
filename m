Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80AB58F7BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiHKGiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 02:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiHKGhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:37:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C887B792;
        Wed, 10 Aug 2022 23:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FA186147D;
        Thu, 11 Aug 2022 06:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879F9C433D6;
        Thu, 11 Aug 2022 06:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660199864;
        bh=x207FYSJa7cUI/hPBLKm3lge12rqi5SLownAS+tQ2PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+gz12zRt5PPNOeWI+8t9bPR8S3Wg0llsJEQL75p3c3ObZtjpVcEja24kRPpKHaSH
         A7u36ZwEgsKuqUTM+QsKNT9DbzKD+AtLtfNrlmrROJtaOabDHtqkeeS9q/jCu9EHaO
         wu/zfMTKnLPxH5oeH+sYqXsGllBvIWZWFSSxR9lg7JfGw/B6ArK/gLFIqyGIXRGJTi
         OKMla3FHwxm+r94GKQReLlM2nKQys9csaUkAr1r4GkqQXw0A/GTCzeRPuAXavfQypG
         Oh7Am6CJIyakRhP9DRWOGTnQ29hQQaLDShSgU14EFHxlTF6y34SB8R7fe7ppvpYn7T
         DIT5KA1GEeiFg==
Date:   Thu, 11 Aug 2022 09:37:25 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <YvSjpYOM4m5JG0xQ@kernel.org>
References: <20220808175614.3885028-1-axelrasmussen@google.com>
 <20220808175614.3885028-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808175614.3885028-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:56:11AM -0700, Axel Rasmussen wrote:
> Historically, it has been shown that intercepting kernel faults with
> userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
> of time) can be exploited, or at least can make some kinds of exploits
> easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
> changed things so, in order for kernel faults to be handled by
> userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
> must be configured so that any unprivileged user can do it.
> 
> In a typical implementation of a hypervisor with live migration (take
> QEMU/KVM as one such example), we do indeed need to be able to handle
> kernel faults. But, both options above are less than ideal:
> 
> - Toggling the sysctl increases attack surface by allowing any
>   unprivileged user to do it.
> 
> - Granting the live migration process CAP_SYS_PTRACE gives it this
>   ability, but *also* the ability to "observe and control the
>   execution of another process [...], and examine and change [its]
>   memory and registers" (from ptrace(2)). This isn't something we need
>   or want to be able to do, so granting this permission violates the
>   "principle of least privilege".
> 
> This is all a long winded way to say: we want a more fine-grained way to
> grant access to userfaultfd, without granting other additional
> permissions at the same time.
> 
> To achieve this, add a /dev/userfaultfd misc device. This device
> provides an alternative to the userfaultfd(2) syscall for the creation
> of new userfaultfds. The idea is, any userfaultfds created this way will
> be able to handle kernel faults, without the caller having any special
> capabilities. Access to this mechanism is instead restricted using e.g.
> standard filesystem permissions.
> 
> Acked-by: Nadav Amit <namit@vmware.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/userfaultfd.c                 | 73 +++++++++++++++++++++++++-------
>  include/uapi/linux/userfaultfd.h |  4 ++
>  2 files changed, 61 insertions(+), 16 deletions(-)

-- 
Sincerely yours,
Mike.
