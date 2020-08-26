Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A80253955
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 22:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHZUs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZUsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:48:25 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F559C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 13:48:25 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i10so3607760iow.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GYZ/IYnL+Ejk8On59DCFq1qjJvZujhshbpaYtFkE1R8=;
        b=fgr2FDPuuOFPfNtfWqDsufpkMYmHHkvJqPJqR9DYQu2fBa6a8i94cTveYLvPe8rwPB
         cBJKNqx5qPeAgOo5uNPQaI1rQeHzy4HiIdcioANP2/qrPeBMye11kYFHf8lkqhxYfS93
         rlzwWk51dEw7macHuYgBf8aYM0cyMW00LF6iPKzr0pgqf331i1XC/qAm8sF6FH5STsik
         jqo4ibr1DA6OjUZHdisZKVD9djHc7K2gYcCX8SExQXoWdmcMlVMDKV3/sZ0uGECvjFT0
         VBvno0Qd9SEtJP1haonwQTmPrbsnw0ZMFeXFC1miWd1ZCtach4LnN24ujGEzXa1nuMet
         eUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GYZ/IYnL+Ejk8On59DCFq1qjJvZujhshbpaYtFkE1R8=;
        b=ff/bLaGtf0YXa6CmYxobery0DvWsqZrf6Mk5HLN/4FK2sSfTI/33W5IXqRgRXgQoEj
         hkKGK/O53pCubGKx3HpXpA6uoXq6YYGEdhsUoPcrMvVGXfDLbL+biKmd3VWPywrgCnkx
         ixfmG6xLGdw4EnlMYPKH1xZJ52i283wYnTBkTVq9EBI/2j3M1t9/6dIUCd7xTpDE/KPh
         +m53hjPdQFNkH9jGIbAayZ8aTrFdDd+pYB+JnbFrMpdf95ETy/lOIzSc7Fr/GjuO6VxJ
         v1ef0kfcE5I+ggMXcrFnDgmsJdQeUwkgqkY0++lzTbjftafGC9yOV4G7RiZ+h9pVLjMg
         wHAQ==
X-Gm-Message-State: AOAM532Ir+tT4+WXeEcV1+VjBzu3uF0bjvHnr/cSOY0GF0hcwVYzA1bs
        pxA5kfJfYa12eameHMVObD/ARQ==
X-Google-Smtp-Source: ABdhPJyjH+VPjhzGpxN1j0RJJ5T32c17PK5Hy829DQuYywUr8Sqy6bzaiccBnyyeSJ1SgTbObhl/sw==
X-Received: by 2002:a05:6638:2a3:: with SMTP id d3mr3127575jaq.0.1598474903204;
        Wed, 26 Aug 2020 13:48:23 -0700 (PDT)
Received: from google.com ([2601:285:8380:9270::f2a2])
        by smtp.gmail.com with ESMTPSA id i144sm75064ioa.55.2020.08.26.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 13:48:22 -0700 (PDT)
Date:   Wed, 26 Aug 2020 14:48:19 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v8 1/2] Add a "nosymfollow" mount option.
Message-ID: <20200826204819.GA4414@google.com>
References: <20200819164317.637421-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819164317.637421-1-zwisler@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

O Wed, Aug 19, 2020 at 10:43:16AM -0600, Ross Zwisler wrote:
> From: Mattias Nissler <mnissler@chromium.org>
> 
> For mounts that have the new "nosymfollow" option, don't follow symlinks
> when resolving paths. The new option is similar in spirit to the
> existing "nodev", "noexec", and "nosuid" options, as well as to the
> LOOKUP_NO_SYMLINKS resolve flag in the openat2(2) syscall. Various BSD
> variants have been supporting the "nosymfollow" mount option for a long
> time with equivalent implementations.
> 
> Note that symlinks may still be created on file systems mounted with
> the "nosymfollow" option present. readlink() remains functional, so
> user space code that is aware of symlinks can still choose to follow
> them explicitly.
> 
> Setting the "nosymfollow" mount option helps prevent privileged
> writers from modifying files unintentionally in case there is an
> unexpected link along the accessed path. The "nosymfollow" option is
> thus useful as a defensive measure for systems that need to deal with
> untrusted file systems in privileged contexts.
> 
> More information on the history and motivation for this patch can be
> found here:
> 
> https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-traversal
> 
> Signed-off-by: Mattias Nissler <mnissler@chromium.org>
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> Changes since v7 [1]:
>  * Rebased onto v5.9-rc1.
>  * Added selftest in second patch.
>  * Added Aleska's Reviewed-By tag.  Thank you for the review!
> 
> After this lands I will upstream changes to util-linux[2] and man-pages
> [3].
> 
> [1]: https://lkml.org/lkml/2020/8/11/896
> [2]: https://github.com/rzwisler/util-linux/commit/7f8771acd85edb70d97921c026c55e1e724d4e15
> [3]: https://github.com/rzwisler/man-pages/commit/b8fe8079f64b5068940c0144586e580399a71668
> ---

Friendly ping on this.

Al, now that the changes to fs/namei.c have landed and we're past the merge
window for v5.9, what are your thoughts on this patch and the associated test?
