Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2233B3CEF41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389692AbhGSVgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385104AbhGSSqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:46:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B508FC061768
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:17:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g8so26197699lfh.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1xCs+r00YlYYmkHhfeZ23WXN1acy6oHwi3mHUNeu3k=;
        b=aFdE74ZCG+BN+jiHq4q1lakSvG+rshYWLQZu1zIoypmQmrrNlzKoxh85yXW+3m2PBp
         lDcp1W5D+wukHZK8WVSqNumwcBVKDXX9keNjOt5GV8kossCG36AANwW2SGQ9nLrOLQca
         gBbpXK2AsQp6Mwz9UbDIXY2bN8t0evot7E9EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1xCs+r00YlYYmkHhfeZ23WXN1acy6oHwi3mHUNeu3k=;
        b=INCEZvvT5TVp+HTP7mhalWdoKy9NezK9w4tq8AzjV1Bw7Npf7QVa07XPleNRjP6ryI
         DanVyr8o/XgJV2oPqcMmBNPBXu3HrfYe1HzfOQxMtwjrghgXDMyc9KmvKqd1ZnyN/6TS
         H+0RmTT+COmV6eMHdWQve5gwmoVCBx4hgNe67jPODmO93glPglxHNa8vKnV61H8OPVsR
         dh1PmQpzBRCPzQY1Zpi9L69NvtMYUVkQP19BhmIbH+BSSOu7CpHCElNpJrjWnhgXRDm0
         AmyXg5yja8NKpHEcT8WkSmebSl2ae7TBYvP6NaKCEkI44C9bTSojFta4bHcDzeoAxYMt
         y6Lg==
X-Gm-Message-State: AOAM533QQC6VQZqC/PIac5cKbmXWM8fik9/akuJdsHrXdp8eGvNE0dNd
        eHW5e5oVaaV/JypmLE+T6Vh+IZ0AWA0zJZiE
X-Google-Smtp-Source: ABdhPJxbXkj5rlu3qX84Rv3mJMBXQ2Px4X3/fqwqS3zwx0Jgh2cscSh7ISBAAMlfL7EJ0pdeUc9g1Q==
X-Received: by 2002:ac2:4211:: with SMTP id y17mr18215014lfh.607.1626722805046;
        Mon, 19 Jul 2021 12:26:45 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id j16sm963679lfh.258.2021.07.19.12.26.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:26:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id m16so311086lfg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:26:43 -0700 (PDT)
X-Received: by 2002:ac2:4475:: with SMTP id y21mr18958429lfl.487.1626722803588;
 Mon, 19 Jul 2021 12:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210718223932.2703330-1-agruenba@redhat.com> <20210718223932.2703330-2-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-2-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Jul 2021 12:26:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxmBjwU+NpeVnUrMEgqk7qAF0VRwtXS2YPJo2n3WGyWg@mail.gmail.com>
Message-ID: <CAHk-=whxmBjwU+NpeVnUrMEgqk7qAF0VRwtXS2YPJo2n3WGyWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iov_iter: Introduce fault_in_iov_iter helper
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

On Sun, Jul 18, 2021 at 3:39 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
> Other than fault_in_pages_writeable(), this function is non-destructive.

You mean "Unlike" rather than "Other than" (also in the comment of the patch).

This is fairly inefficient, but as long as it's the exceptional case,
that's fine. It might be worth making that very explicit, so that
people don't try to use it normally.

                Linus
