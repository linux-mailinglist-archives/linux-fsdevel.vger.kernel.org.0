Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC44420FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 20:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhKATlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 15:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhKATla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:41:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D69C061764
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Nov 2021 12:38:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b12so25207261wrh.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PCs1jWJejWVBSaYkuWpG5ZVx/T7dV/wdZJ2SEP85SX4=;
        b=FpgYjHT7o1pNGRzu3Qc0aFwsiElm7Ts1+yAJG2wmmMhbjzLqOV801W6IbTXXTYylAv
         ErEtrvwIEqyHxCHvT73NAzS++m7mw3oPKevaqXJW0IaplujbE0VgWyKGLkwnQuqZ+LtX
         ddBYe4mOy4ubuS4qnyN43AdCOJE8XOSuGTvusHQD/ep7uygEoZ50EiaJraA47iEiM2hn
         fzpuUDMShz6ybNsDlGv8Sa+EktA/59L63iLfDothpTHjd8bhIiU5GHrac5pC2+CoJZbK
         trxHAkCKtQaDxi3uQeaOX295eB/G1vWRba3yriGXiODXXCFOvESI2PFwOC5vKbRm7Ldf
         o8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PCs1jWJejWVBSaYkuWpG5ZVx/T7dV/wdZJ2SEP85SX4=;
        b=HV1b4RvZq8C+GHFfG2g984OidO+rmgbLeiNd8VZiT43kD1Y06cP9+sNq9aFVomoYAk
         kSe+afVnul6padbw6vgiqBUVQo2gkqsLdiG4wGtnPYR7Rl/1zgjfAFbLPC4QgjAvCd//
         co7OGQ9Poz8irC9mGAEKydfUj98v6cmZ2a/Z8d99pYtLqfZcLBedOLpmRaaFPO76eY6e
         klcldkTpoXTqYmIxDiuFM3VWe1DYPiCR7Rkj5+6fO/6sLJ+2aa8q2ykc3D832yp3hZz2
         eyVFzVqI9QAmNSa5FVxvqztkt7ieMT5jy3pZTuu2j/EWwl8qblsBADBVBGcnKGjv49KQ
         87YQ==
X-Gm-Message-State: AOAM530NEYYOzHcbWtoVzz5WsZkH/QDiUYSXUh7JfQVSJY5qriDsPPNB
        flFfY7ZsaVhuTr5aAuPFjigwGm/X+VSNKuADAo1RdEEbk6+K4A==
X-Google-Smtp-Source: ABdhPJzhtfCcvGnSnGKM6geKfETQpI3m8wEuac7/VPjAmNe7rhBAdH+FLl8KDUTdNQWH08pKQHswvtUk8QU7SBmyaKo=
X-Received: by 2002:a5d:65c7:: with SMTP id e7mr21182104wrw.319.1635795535496;
 Mon, 01 Nov 2021 12:38:55 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Mon, 1 Nov 2021 12:38:44 -0700
Message-ID: <CAPcxDJ5rgmyswPN5kL8-Mk2hk7MCjHXVy6pS50i=KQKzUGFHfA@mail.gmail.com>
Subject: Re: [v5 PATCH 6/6] mm: hwpoison: handle non-anonymous THP correctly
To:     Yang Shi <shy828301@gmail.com>, Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A related bug but whose fix may belong to a separate series:

split_huge_page fails when invoked concurrently on the same THP page.

It's possible that multiple memory errors on the same THP get consumed
by multiple threads and come down to split_huge_page path easily.

Thanks,
-Jue
