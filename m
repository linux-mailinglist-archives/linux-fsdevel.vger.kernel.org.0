Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490FE1F4B07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 03:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgFJBqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 21:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFJBqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:46:33 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E4C05BD1E;
        Tue,  9 Jun 2020 18:46:32 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dp10so330367qvb.10;
        Tue, 09 Jun 2020 18:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjEvUKOGeP0/F79VG1tPkbwEfkdJVyvg8ywjx9GcPQU=;
        b=oWrZ6e9TU/rbxhNWPbfMhXLTZg4xruWGGcVXQ9mktslLgYxx48qz2u8cxBC7tYpZEI
         LjwR5+JS+p7Ozd4E7Z8TmuyFDeUKg8BmeYxwQ5Xujc3rQdN/bVAoOQMS8yneUlItWdbq
         RTOmEb+XnvIzVsivjlo9ToRTaJXrUR1s0C70dq0ZD/PxyJR60nsZERnoH5fAsiFRdY/J
         tDPAvye0ZiFEvAUtVPWey5Uxadlp6FE2/Gahxn7PVIeHFPMzL2SwgEPf+D6LvrhVget/
         QrcVlKQ948U1HHCDQrCBksA5G6F1NMZ+jghXW4+52PCudnWeiEizDuM+7HAsi+IICcil
         blTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjEvUKOGeP0/F79VG1tPkbwEfkdJVyvg8ywjx9GcPQU=;
        b=AO+saLyPHjyWWHnWyx1lIgNxX8YTwBDX7K8WgXqecH2Vdfpnvy/FVsPf/dKjRiwRFk
         uHXA8iXwwhFKmX1xjTlBFo7XP1jRpI1uTUXRyQT/7zKYAFeK1dBxBP6W4CdjGFC7jQnJ
         hhnuNTFmhWppzB+VQKeYoFVmWIvh8L9JQyUIOk9LiicOvqF7+dD9RzD91iILPIL9ZYnX
         6sj9ndXTeVrGkFEspLygBbM5AtvNvEsXT0gnKVw1/N+L3+SBja+EA2J2lHn4c6UxeeNh
         5cbUoZk2Mpm/skkzi+04mia6PgNiESCfH8sQ0DdrMmkugFVM8fWQhnmS2lA8aaQHWVIP
         e5uA==
X-Gm-Message-State: AOAM531VkEB5xvntNIb0ljlLfETgSUioiEX9ZE93GbQ4k7n1/AW/trYF
        hy1gt9kzVtiDyln4MaOF2dKdARA=
X-Google-Smtp-Source: ABdhPJxQK5SqvejKrGmt9+oKevPj0d2I8q7utJ10aM3gzSAilCgpJsFS1MwbI2P61HEUKMFoX6J21g==
X-Received: by 2002:ad4:42a6:: with SMTP id e6mr1002783qvr.170.1591753591894;
        Tue, 09 Jun 2020 18:46:31 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id g28sm11233434qts.88.2020.06.09.18.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 18:46:31 -0700 (PDT)
Date:   Tue, 9 Jun 2020 21:46:29 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: generic_file_buffered_read() now uses
 find_get_pages_contig
Message-ID: <20200610014629.GB4070152@moria.home.lan>
References: <20200610001036.3904844-1-kent.overstreet@gmail.com>
 <20200610001036.3904844-3-kent.overstreet@gmail.com>
 <20200610013808.GF19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610013808.GF19604@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 06:38:08PM -0700, Matthew Wilcox wrote:
> On Tue, Jun 09, 2020 at 08:10:36PM -0400, Kent Overstreet wrote:
> > Convert generic_file_buffered_read() to get pages to read from in
> > batches, and then copy data to userspace from many pages at once - in
> > particular, we now don't touch any cachelines that might be contended
> > while we're in the loop to copy data to userspace.
> > 
> > This is is a performance improvement on workloads that do buffered reads
> > with large blocksizes, and a very large performance improvement if that
> > file is also being accessed concurrently by different threads.
> 
> Hey, you're stealing my performance improvements!

:)

> Granted, I haven't got to doing performance optimisations (certainly
> not in this function), but this is one of the places where THP in the
> page cache will have a useful performance improvement.
> 
> I'm not opposed to putting this in, but I may back it out as part of
> the THP work because the THPs will get the same performance improvements
> that you're seeing here with less code.

I'm an _enthusiastic_ supporter of the THP stuff (as you know), but my feeling
is that it's going to be a long time before hugepages are everywhere - and I
think even with the pagevec stuff generic_file_buffered_read() is somewhat
easier to read and deal with after this series than before it.

Though I could see the pagevec stuff making hugepage support a pain, so there is
that. Eh.
