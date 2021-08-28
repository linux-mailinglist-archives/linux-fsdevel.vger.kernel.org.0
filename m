Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02D33FA7B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 23:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhH1Vsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1Vst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:48:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6FC061756
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 14:47:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id k78so16613587ybf.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpFNOvvpFZbbZ8OM3mIkAwJTup8tfISROOVfntRP9pg=;
        b=MzSuWBFZvekJz7MBaisKxWQ6esuYjymMLZ3IrbKj/oha3c6TmcvZtOeOIvOrR0wk2r
         MI9IE8qYkuhDL3mVBGpQokgXbf1Sv32wrg2D7tpw1KBPbBl3CB8uFDsLUOjqrUV/iwMY
         nqabwDzlrPvZEeWxcCs7/3Ir1zqLdAbIh9MRwdZPG8JpUj8Hgp78xJfy875BU05RAcIj
         nK52sQVxzEGZiKl8GtQxwYiDr9brpS4Dzsrj5U+TxePlIxTM2Hr4e/T7peehxfrkda/c
         0J+Z1AYZjUNYWGlJ90k16GfxTYfDUZ2hpZCjn43GkToyMAk89/Ye7WqaU1WQLL5TKU9d
         3Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpFNOvvpFZbbZ8OM3mIkAwJTup8tfISROOVfntRP9pg=;
        b=tljI7w751TY7CbqK1doOFJvXq+yclPCRskKEAb3rtFgX9Z1wfLcmliufalP9YUBXCJ
         cWpKw/oK9BpSZiCVsPIsQPYQ7KIv8dp3EnaJ9FizC1B5zcDKmg0g74KDAeuOCex1iR2V
         rNic7meTLY15ffLdzXxFzquXZ0HekRZHSOCzPovpJ6w8QBGyCQLHGj4Gb/1So8g8fh+F
         LmvQuACxszKf0CP0x+GgqeHpltItDUXGdzOrSGMkhZdOv+QSWaY+MT5oKsXm4yG1aQjF
         uQ6I44wdu3D3z2+Ryj6n4hxiqTXbVNVsTwqlqV/icEUuRU9EvGJGSQGZIiIn4s+WEAmU
         br8w==
X-Gm-Message-State: AOAM531awW8SOZq8AksRatOshzxk/Hv0ynIRqC4xVL1ueNExOvMRlc7h
        XY4zXzhpNEscE1BR1TeSHEY8cA6QcHtCM2Oog6X02g==
X-Google-Smtp-Source: ABdhPJxLFe0ifBzSQIBXioyPixIsF51tIx7RKGeEqpYwiC2QLvRLZlCjMTzoqzh4c2B6Q8LmDm2C5NX/wjFcIV7kVNY=
X-Received: by 2002:a25:810c:: with SMTP id o12mr14569991ybk.250.1630187277699;
 Sat, 28 Aug 2021 14:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-3-surenb@google.com>
 <YSmVl+DEPrU6oUR4@casper.infradead.org> <202108272228.7D36F0373@keescook>
In-Reply-To: <202108272228.7D36F0373@keescook>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 28 Aug 2021 14:47:46 -0700
Message-ID: <CAJuCfpEWc+eTLYp_Xf9exMJCO_cFtvBUzi39+WbcSKZBXHe3SQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org, eb@emlix.com,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Aug 28, 2021 at 02:47:03AM +0100, Matthew Wilcox wrote:
> > On Fri, Aug 27, 2021 at 12:18:57PM -0700, Suren Baghdasaryan wrote:
> > > +           anon_name = vma_anon_name(vma);
> > > +           if (anon_name) {
> > > +                   seq_pad(m, ' ');
> > > +                   seq_puts(m, "[anon:");
> > > +                   seq_write(m, anon_name, strlen(anon_name));
> > > +                   seq_putc(m, ']');
> > > +           }
>
> Maybe after seq_pad, use: seq_printf(m, "[anon:%s]", anon_name);

Good idea. Will change.

>
> >
> > ...
> >
> > > +   case PR_SET_VMA_ANON_NAME:
> > > +           name = strndup_user((const char __user *)arg,
> > > +                               ANON_VMA_NAME_MAX_LEN);
> > > +
> > > +           if (IS_ERR(name))
> > > +                   return PTR_ERR(name);
> > > +
> > > +           for (pch = name; *pch != '\0'; pch++) {
> > > +                   if (!isprint(*pch)) {
> > > +                           kfree(name);
> > > +                           return -EINVAL;
> >
> > I think isprint() is too weak a check.  For example, I would suggest
> > forbidding the following characters: ':', ']', '[', ' '.  Perhaps
> > isalnum() would be better?  (permit a-zA-Z0-9)  I wouldn't necessarily
> > be opposed to some punctuation characters, but let's avoid creating
> > confusion.  Do you happen to know which characters are actually in use
> > today?
>
> There's some sense in refusing [, ], and :, but removing " " seems
> unhelpful for reasonable descriptors. As long as weird stuff is escaped,
> I think it's fine. Any parser can just extract with m|\[anon:(.*)\]$|

I see no issue in forbidding '[' and ']' but whitespace and ':' are
currently used by Android. Would forbidding or escaping '[' and ']' be
enough?

>
> For example, just escape it here instead of refusing to take it. Something
> like:
>
>         name = strndup_user((const char __user *)arg,
>                             ANON_VMA_NAME_MAX_LEN);
>         escaped = kasprintf(GFP_KERNEL, "%pE", name);

Did you mean "%*pE" as in
https://www.kernel.org/doc/html/latest/core-api/printk-formats.html#raw-buffer-as-an-escaped-string
?

>         if (escaped) {
>                 kfree(name);
>                 return -ENOMEM;
>         }
>         kfree(name);
>         name = escaped;
>
> --
> Kees Cook
