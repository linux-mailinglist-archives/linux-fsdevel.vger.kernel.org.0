Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22E94A6402
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 19:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbiBASfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 13:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbiBASfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:35:40 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82657C06173D
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Feb 2022 10:35:40 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f10so9219795lfu.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Feb 2022 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nr6pfr8A3FnsPiDXPtirr2skdbzbz2tK8kJNlUysBkY=;
        b=QHacZhjK+Fp00RNIE2ceB9nwsvdfkDUuxTL3FTI8anO97N3zlh89jVYTdvBd/txElw
         hRCYJRTZnz0U0B4glYZ3kVNgGmbqJSmcnm9xcRZlPEDoJvVZDFmqKdPjj28QxLFWI7Oc
         EEYpBYtuicJ0kXHuuFvdiNNKd4io9yZ0Q4WgszqsUrG16BPJZdQA/NOss/Ouzf51suIT
         1YeAMIA4BvkaJ3sM7pKDWh609ffgAsE+cXfhlvlLUu0kqJNHkjk/t7GUnh8wT9gZfxKt
         9zqgfEygHf0Q6ZbMylfldD8IMXBHYQe34+j0gugiPQ4QbySHDcpQXZOERKXt8WUZyvNp
         r1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nr6pfr8A3FnsPiDXPtirr2skdbzbz2tK8kJNlUysBkY=;
        b=r0/VarNjq+cREVT2M9JlWbXDodRZMeBsrZ/t/QIli3XteJi5bmrPaMsd1jn+bOuD/e
         T0X13PPLlhiR4/t7c44t0qzQLA2wmUs87Y7LmYm85N5/3RcZ+gDn/mH/yjhyiFclrQOB
         KSjbncYkJspofMyi5GyVeFIuki6NcMli8CA3dqcbY05v5A+8ePUueiNNbXdNwji50Ux1
         iZ5mwE+APfMqKMvVGjteIiBzKjgKgPcyWfJbRSqkglE7V1JsnYFzjPyEPVjQ/QliskfW
         WmwggNQLwpumBd56X7nTXGTAfFRijMPesMTO1oIKBpugKeXWpy+CE/JSMcDgrxizJfFJ
         Et3w==
X-Gm-Message-State: AOAM533RAdltTYpNHNxF2vJ3C6qqx7RBUQoTou/c0mqAhDYypvGEtQln
        iTtYWMSu2kldJl9YnUqQzwKz3aA+2Zi5QcSYzXntJA==
X-Google-Smtp-Source: ABdhPJyAYi19CYUwKC8npzOgD/p6q3a1QworJ5jjPe8fVFfn1ObwC/pYojTe1W5g5w3xGvlv135+L6M+QjyA3pqA2oI=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr20022304lfb.288.1643740538778;
 Tue, 01 Feb 2022 10:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20220131153740.2396974-1-willy@infradead.org> <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org> <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org> <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> <87tudjn3or.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87tudjn3or.fsf_-_@email.froward.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 1 Feb 2022 19:35:12 +0100
Message-ID: <CAG48ez1O2Nt2eiJ6ZbV8q+XSsg+Co4GhdaLxi-aNF4PRm5R+mg@mail.gmail.com>
Subject: Re: [PATCH 3/5] coredump: Remove the WARN_ON in dump_vma_snapshot
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 7:46 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> The condition is impossible and to the best of my knowledge has never
> triggered.
>
> We are in deep trouble if that conditions happens and we walk past
> the end of our allocated array.
>
> So delete the WARN_ON and the code that makes it look like the kernel
> can handle the case of walking past the end of it's vma_meta array.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Jann Horn <jannh@google.com>
