Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57C2EC8D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 04:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbhAGDGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 22:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbhAGDG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:06:29 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF4CC0612F0
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 19:05:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id q22so7884413eja.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 19:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSUsWf76Ym0VoANrRHrfG8/N3sNNdbLhBCzibzDQLgQ=;
        b=jzcK6Cm4FLAHY6hu7Ywcx91MTihZUhUT4alDFfGGpy2OI2jruYUMwtMsV2Wc1QvBVj
         +VdUrk1WN+XglSmpIKB92NTYYak68JExk3D9+huWoZ/eBfo0xv3wRVyOwuJzzCXE4r9f
         eJ8IZCIwG+aTnvZ5+cwzVFMxJ/HDFPDnJhx7Q9qc/+HZY+3VsGbXWM0SvVaYUrWY1Mjy
         l3AyzVVBTEwKS78Oiebo2664+u+voD6vBdkl18mgx9ZfdDseA9Sbqs+ix8ZAMrtWkrub
         Ws8bQQ9E3w37PTz+GDe01/zjrtwfGQTvYyyCeVloOJl/678G9+5Orx6vwAvamNRpBAMP
         Ho8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSUsWf76Ym0VoANrRHrfG8/N3sNNdbLhBCzibzDQLgQ=;
        b=Q9eX2e76b+HojXYuQWDyiGdufJ9+gVzDM/wVToJKC7caoE/HdFVgXjplvOYTs6Q2dC
         0XRDxtTQntortI4eFaxHDig4YKS1RugZM5S3oIpVyla+0uHJ+vLrl2jylxGqBS7Jgwa2
         +QN8Vtq2THk2ANk18b1znGj0QFFVkmzU7JGeR5qeoZCCbisqaFIK96G+L304F22AYYGj
         zvxttNauzlrVprZixXeYM4fuTOwJivaPDB2Dzb4H3aArPausekWRf8YQ82T6uoBy70Ab
         07uDqUGFnpm8m8mXU7YJBfaVjlc2tyD3uU6GgaMNC8I21wm7Z/fS99BERfHdVGncHn0p
         pKLg==
X-Gm-Message-State: AOAM532FYKxFwL1ErQf5SoCkJC1yFqIvqAzD8pDR3e/r72JsbwOqMXJX
        ckh+SjsfpmdWNKwP3XwI2aaxzpzHbdAR+hQf/Dkh
X-Google-Smtp-Source: ABdhPJzgjmqgSpNil4HfGt5R7VIJWNzi+EIBFt1ZTPt5Iiqemj9MXy/gnGidF9P6nTkpbXAI3b6IhBo/OGNCSFMHEGY=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr5049512ejc.178.1609988747833;
 Wed, 06 Jan 2021 19:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-3-lokeshgidra@google.com> <CAHC9VhScpFVtxzU_nUDUc4zGT7+EZKFRpYAm+Ps5vd2AjKkaMQ@mail.gmail.com>
 <f7dfe33a4d0f9c27f3e25f72a988201a@dancol.org>
In-Reply-To: <f7dfe33a4d0f9c27f3e25f72a988201a@dancol.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Jan 2021 22:05:36 -0500
Message-ID: <CAHC9VhQhvqtfF0m3BgObjQaT7WSLfqT8v0SJsKiTxfF0GxQU7g@mail.gmail.com>
Subject: Re: [PATCH v13 2/4] fs: add LSM-supporting anon-inode interface
To:     dancol <dancol@dancol.org>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 6, 2021 at 9:42 PM dancol <dancol@dancol.org> wrote:
>
> On 2021-01-06 21:09, Paul Moore wrote:
> > Is it necessary to pass both the context_inode pointer and the secure
> > boolean?  It seems like if context_inode is non-NULL then one could
> > assume that a secure anonymous inode was requested; is there ever
> > going to be a case where this is not true?
>
> The converse isn't true though: it makes sense to ask for a secure inode
> with a NULL context inode.

Having looked at patch 3/4 and 4/4 I just realized that and was coming
back to update my comments :)

-- 
paul moore
www.paul-moore.com
