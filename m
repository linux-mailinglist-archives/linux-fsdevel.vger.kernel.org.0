Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4350F677233
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jan 2023 21:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjAVUGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 15:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjAVUGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:06:13 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B203E3B5
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jan 2023 12:06:12 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id s4so8266232qtx.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jan 2023 12:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M3P+Sxuip0JpXG7+ldpgmEp2EenukjcoZIDETYOhkzk=;
        b=AxA6vhZvWvf4Ly02xlfimgdl7Mc4SsAq21xlSc5ob2ZJN/c+Ewq6nEdGEnHBezxMEQ
         q89Z0xlyCdda5W59uRY2wm/deBWEk/+CusXOSvkD38qN/864plKvpxf1eXijXmHmSedv
         Z8QjFmJ5xByp+RvZZBjOGhgKugQgMTz3pBtwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3P+Sxuip0JpXG7+ldpgmEp2EenukjcoZIDETYOhkzk=;
        b=QhD6YnQe/f6mLPNDGX44x5HE0KbSYyzX8RfolBAA8gJFQ8Wsmj/3Slbp+tpzgDChoD
         MLw37puNQWACWdkbbUStsWDthffuyAmdQjQDdVn3K/bD2Lp1P5n14q8Kzw/aKdTTJ/6j
         VCWLVCe3RlSvwCO46Wy9o465xybj8mJO0PnaZMSJzQIlzj2Hhk8pu/e9R+K+pTL5rQg2
         C4bB/KIB2l1vpeQk7urxL5vTNViC/WZPuHZf/lCH6IeoI2AZtk695O8a/VkhbKR1Uym7
         01nEx5RqVxaRo5w1ZzgRvaZzpCDbOdO8n0pPtHh4+lgqHae9SGKy07xJu3BaUJ1LthEU
         0Qgw==
X-Gm-Message-State: AFqh2kqu7Axo7H95jPkMG4mLrjpp5i2uNM2RjJhtV0geoiYwppgaQVGt
        J5L9dMgqtgN0UT842T3t81/NReZpFCYvalNn
X-Google-Smtp-Source: AMrXdXtB5u0PqcABzT9wWgy84iXlcA9bFfEf1zkEoUaIr7qdGgYNu/q5eqts1ugpszAOCltJXJXSKw==
X-Received: by 2002:ac8:6b81:0:b0:3a8:1677:bc39 with SMTP id z1-20020ac86b81000000b003a81677bc39mr30489124qts.52.1674417970837;
        Sun, 22 Jan 2023 12:06:10 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b007055dce4cecsm6655123qkn.97.2023.01.22.12.06.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 12:06:10 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id f23so3035326qkg.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jan 2023 12:06:10 -0800 (PST)
X-Received: by 2002:a05:620a:99d:b0:705:efa8:524c with SMTP id
 x29-20020a05620a099d00b00705efa8524cmr1089614qkx.594.1674417969782; Sun, 22
 Jan 2023 12:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20230122090115.1563753-1-agruenba@redhat.com>
In-Reply-To: <20230122090115.1563753-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Jan 2023 12:05:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgjMNbNG0FMatHtmzEZPj0ZmQpNRsnRvH47igJoC9TBww@mail.gmail.com>
Message-ID: <CAHk-=wgjMNbNG0FMatHtmzEZPj0ZmQpNRsnRvH47igJoC9TBww@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 writepage fix
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 22, 2023 at 1:01 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> gfs2 writepage fix
>
> - Fix a regression introduced by commit "gfs2: stop using
>   generic_writepages in gfs2_ail1_start_one".

Hmm. I'm adding a few more people and linux-fsdevel to the reply,
because we had a number of filesystems remove writepages use lately,
including some that did it as a fix after the merge window.

Everybody involved seemed to claim it was just a no-brainer
switch-over, and I just took that on faith. Now it looks like that
wasn't true at least for gfs2 due to different semantics.

Maybe the gfs2 issue is purely because of how gfs2 did the conversion
(generic_writepages -> filemap_fdatawrite_wbc), but let's make people
look at their own cases.

                 Linus
