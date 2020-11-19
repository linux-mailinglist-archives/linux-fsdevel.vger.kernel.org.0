Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01A22B9C2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 21:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKSUj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 15:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgKSUj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 15:39:29 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A5C0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 12:39:28 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cf17so3689810edb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 12:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJ4yHj2o6CJPlclc4Dlue1pFs+YW5Xtp3Pnvold2gGU=;
        b=bzt7RHlpMxYBkqf5zz9ANDxyXQc65RQ67tJSR3v1pY5U4BJMAXZn1pI/d1T0zkdiPu
         s8sO9+GMASROgyMF5j9RJhjjd9K7nN9ep+hNiSvgYp9G2Iu/3YQVYvfTon/4+VbuDJcN
         H20qyMlRZ/uSGpibuTSbyFGscPAeMGVt7ZU92CMLshWBBIA6M/DP14AOIjjXNbwJqETL
         w5S6LHYV5Y1FhOYbDtECPwtOIKeswdrBwWZDL3gj7MChde2jCFuhrVkfY9opGmun5+d3
         lckS1vhfPZ4LTLvWbdO4GZOeNH1A48CiFvI4XIpe8Nh6tQw81rR5NSxvSStCtxSJHX/Y
         Sccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJ4yHj2o6CJPlclc4Dlue1pFs+YW5Xtp3Pnvold2gGU=;
        b=SlAfY7rxT0lCf48i5k7sehLC15M8cqsEvU2OM2B67uNvlNGXCLmKUVToQiR3o16ezr
         NXT7Oojk69D6sVfhUdL05fnhNiPcWK1yS/76nEZPrKHQUuFCXfKtLw+6bs+qaeqvBaeh
         rEWp4cWrhAmH3+bqrFeLfwEIIRXLb9RC9EmL8kp91Pi/TVnbnHqVsS+XKdIGmMK0PPI3
         0gBZMsmIoNbe9/GWEwZXKWavlMPumvVVCP4hSAfYLqaGytcru1L/h4/lWXReD6k5mM0U
         /BFcucZXmSeFKFt3YdkzkUiGGm3dm8MgqWFKwAfWKCrOkyPT+NmHCfn8X2rS5aiGwzt9
         wIFg==
X-Gm-Message-State: AOAM533Et53TBLgtrjmwb85raxNMjiXc9ubQHAWmoFZhk2fa9YC8lG2v
        kQM3hK1vXPJX5CA6TTZyfyCUXeAe4McilELUP6S0Kw==
X-Google-Smtp-Source: ABdhPJy8wzlppYBs8HMU5d+8U8upwmmjqwlOvisvT7hKI6zk7qZ47GGZpODqwvrwEGYytZDoFv1EuU3tAGJPtdUe2M4=
X-Received: by 2002:aa7:cc14:: with SMTP id q20mr7978782edt.140.1605818367084;
 Thu, 19 Nov 2020 12:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20201026210052.3775167-1-lokeshgidra@google.com>
In-Reply-To: <20201026210052.3775167-1-lokeshgidra@google.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 19 Nov 2020 12:39:15 -0800
Message-ID: <CA+EESO7N7gFkG_Vqy5j1oCZif8RaiCJ146GrQAKq3P1SCUi+ng@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Control over userfaultfd kernel-fault handling
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 2:00 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> This patch series is split from [1]. The other series enables SELinux
> support for userfaultfd file descriptors so that its creation and
> movement can be controlled.
>
> It has been demonstrated on various occasions that suspending kernel
> code execution for an arbitrary amount of time at any access to
> userspace memory (copy_from_user()/copy_to_user()/...) can be exploited
> to change the intended behavior of the kernel. For instance, handling
> page faults in kernel-mode using userfaultfd has been exploited in [2, 3].
> Likewise, FUSE, which is similar to userfaultfd in this respect, has been
> exploited in [4, 5] for similar outcome.
>
> This small patch series adds a new flag to userfaultfd(2) that allows
> callers to give up the ability to handle kernel-mode faults with the
> resulting UFFD file object. It then adds a 'user-mode only' option to
> the unprivileged_userfaultfd sysctl knob to require unprivileged
> callers to use this new flag.
>
> The purpose of this new interface is to decrease the chance of an
> unprivileged userfaultfd user taking advantage of userfaultfd to
> enhance security vulnerabilities by lengthening the race window in
> kernel code.
>
> [1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
> [2] https://duasynt.com/blog/linux-kernel-heap-spray
> [3] https://duasynt.com/blog/cve-2016-6187-heap-off-by-one-exploit
> [4] https://googleprojectzero.blogspot.com/2016/06/exploiting-recursion-in-linux-kernel_20.html
> [5] https://bugs.chromium.org/p/project-zero/issues/detail?id=808
>
> Changes since v5:
>
>   - Added printk_once when unprivileged_userfaultfd is set to 0 and
>     userfaultfd syscall is called without UFFD_USER_MODE_ONLY in the
>     absence of CAP_SYS_PTRACE capability.
>
> Changes since v4:
>
>   - Added warning when bailing out from handling kernel fault.
>
> Changes since v3:
>
>   - Modified the meaning of value '0' of unprivileged_userfaultfd
>     sysctl knob. Setting this knob to '0' now allows unprivileged users
>     to use userfaultfd, but can handle page faults in user-mode only.
>   - The default value of unprivileged_userfaultfd sysctl knob is changed
>     to '0'.
>
> Changes since v2:
>
>   - Removed 'uffd_flags' and directly used 'UFFD_USER_MODE_ONLY' in
>     userfaultfd().
>
> Changes since v1:
>
>   - Added external references to the threats from allowing unprivileged
>     users to handle page faults from kernel-mode.
>   - Removed the new sysctl knob restricting handling of page
>     faults from kernel-mode, and added an option for the same
>     in the existing 'unprivileged_userfaultfd' knob.
>
> Lokesh Gidra (2):
>   Add UFFD_USER_MODE_ONLY
>   Add user-mode only option to unprivileged_userfaultfd sysctl knob
>
>  Documentation/admin-guide/sysctl/vm.rst | 15 ++++++++++-----
>  fs/userfaultfd.c                        | 20 +++++++++++++++++---
>  include/uapi/linux/userfaultfd.h        |  9 +++++++++
>  3 files changed, 36 insertions(+), 8 deletions(-)
>
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
It's been quite some time since this patch-series has received
'Reviewed-by' by Andrea. Please let me know if anything is blocking it
from taking forward.
