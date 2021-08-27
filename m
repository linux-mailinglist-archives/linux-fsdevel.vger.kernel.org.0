Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC713FA007
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhH0TeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhH0TeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:34:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A426C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:33:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so16511473lfg.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noHCPSrtAkyzCrVsyQD6F8PSfdWl+QDD2xq/GV377n4=;
        b=OubElFYVmhZbc+A4cMbmNe0TfihA1IDFIUGNFFLF4+YO14gBPAxD7udrxkX02hDHv8
         AfKEsOmsIOPceXNppuc1+woLySYPcxqVPmdyCnzYp/DWgTgYZru2vKMDv0QdVLj5OUdo
         9eyfmRKJeFyRGIgCMVyovNvNTjyCKilmw7e2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noHCPSrtAkyzCrVsyQD6F8PSfdWl+QDD2xq/GV377n4=;
        b=bd627GZpOXMQHEBrJ9J0BC0Da6Lh0riIuYTondgRLoc+gXGAEV0d4l/Rw5Gmb8Ln55
         D0lGmM2utmmx942rNKX/NVxZW6CFnPHZyIjxBUC7FF8vMmW6g4wfMVwSLXwOfIGBEoQM
         EzFx73rsXSW3YmZze3u+328/XZHhaHFu7qPO4KQRjg2lg7mXNR7Yc7w8CesqTWwQaxp2
         Z++quri2A9tVw2NC+3WvJBLNbZUuiRI8F0FQBzCsrnG9W9lT5tjhSUNuHRBAP5apcOG+
         /rvLnspPqIBWl7CV5e2BAAFRK+Psff9AsVxvDEEIaBZx7jC1pBYXL9uQcYNLOZilirYM
         XpUw==
X-Gm-Message-State: AOAM531ETngG+DvDC0oVrNGrhZ8K+NRMnn+gJzBex0ghcHa1GmNRkvUj
        mb5ZvX3JC7Hc9cOmv6JNOtL8w+mdFub4X66d
X-Google-Smtp-Source: ABdhPJwQZUMoDLuVM8B8DxE5+rMf+iZDd7DogddTZYL/FQk1Un798B1GpNpL4GR0itPiZ2YsEaGrzA==
X-Received: by 2002:a05:6512:b27:: with SMTP id w39mr8012935lfu.129.1630092798913;
        Fri, 27 Aug 2021 12:33:18 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w19sm307393lfl.304.2021.08.27.12.33.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 12:33:17 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f2so13328563ljn.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:33:17 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr8956231ljq.507.1630092796791;
 Fri, 27 Aug 2021 12:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk> <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
In-Reply-To: <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 12:33:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
Message-ID: <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Could you show the cases where "partial copy, so it's OK" behaviour would
> break anything?

Absolutely.

For example, i t would cause an infinite loop in
restore_fpregs_from_user() if the "buf" argument is a situation where
the first page is fine, but the next page is not.

Why? Because __restore_fpregs_from_user() would take a fault, but then
fault_in_pages_readable() (renamed) would succeed, so you'd just do
that "retry" forever and ever.

Probably there are a number of other places too. That was literally
the *first* place I looked at.

Seriously. The current semantics are "check the whole area".

THOSE MUST NOT CHANGE.

              Linus
