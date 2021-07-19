Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2E3CEF42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389745AbhGSVga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385192AbhGSSuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:50:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A158DC0613DF
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:21:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h9so27913111ljm.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvseTVwISQQYVhM74Otk0kHaj1gV421l1SCA3Nj6+8A=;
        b=bG065vqODgODNuvvz8mm0qHyJG6bF2CQmrIx298YPsPIfm1XQziVg1hw4cyEeNraRs
         As5mkoiZv9EFfjI3rygNALG/BoZwX1W+bpEUGC32eW7jeK+OzXHmykLB8a8dTBNQlzHs
         hWbkQvF2brbeFqyBxVGR9lMGFE15eZqGdyFsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvseTVwISQQYVhM74Otk0kHaj1gV421l1SCA3Nj6+8A=;
        b=VhB3e2iICaelCjBZ5dlcKXhOs37lwagB9CUscInsg51DSNHUEWkJTfGd8DN75e6d49
         N9yHWlQc6ysM0wmbMR3/gj8RvvLTMwXM0AD86F3+j0J7/9azyDfCM3JfjZOAYdS80TfQ
         wDlatEESOWfqsFe5GuCgbGOsysyt+qx8NshlrXkeJHTEHDo9mT/D/KApuPWwVJtnJd+w
         g/Xu6IEF+cBrDCIsWMp1jrQHHmpiRqL5freeBhLDqpfZc3AUlJFlS/5zUx7Li342cPbE
         rR2qAdOxIWwvzM8haS43UT9IF+o8lCfjL/RWZCXJC2LpntguSGrJSPYD+w3Y5g8D83TF
         xSQw==
X-Gm-Message-State: AOAM532D2+S0FnnCLfGcWgpweSXkQMLIr2GQbQonfL3I+kMAJP6dSAXM
        RlUmSYBKm92ZaJt1yxIkr6m1HtZELkhWzlan
X-Google-Smtp-Source: ABdhPJzeton9mR7S5GNFekHdT8sD7GvdOu+b/sQ8EpZu2WZSkIn6zfu+vQIKRZBMhQJAfHbn96X0WQ==
X-Received: by 2002:a2e:7e09:: with SMTP id z9mr23353605ljc.340.1626722991854;
        Mon, 19 Jul 2021 12:29:51 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id i27sm1466349lfl.50.2021.07.19.12.29.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:29:51 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id b26so32112369lfo.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:29:51 -0700 (PDT)
X-Received: by 2002:a05:6512:404:: with SMTP id u4mr18798424lfk.40.1626722990987;
 Mon, 19 Jul 2021 12:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210718223932.2703330-1-agruenba@redhat.com> <20210718223932.2703330-6-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-6-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Jul 2021 12:29:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3p41a-=7FFf36sYBQP750ys6CKi0S7JNiCSatY5-7og@mail.gmail.com>
Message-ID: <CAHk-=wh3p41a-=7FFf36sYBQP750ys6CKi0S7JNiCSatY5-7og@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] iov_iter: Introduce ITER_FLAG_FAST_ONLY flag
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 18, 2021 at 3:40 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Introduce a new ITER_FLAG_FAST_ONLY flag

I think the code is fine, but I think it might be best to call this
"ITER_FLAG_NOIO" or something like that.

The "FAST_ONLY" name makes sense in the context of
"get_user_pages_fast()" where we have that "fast" naming (and the long
history too). But I don't think it makes much sense as a name in the
context of iov_iter.

                   Linus
