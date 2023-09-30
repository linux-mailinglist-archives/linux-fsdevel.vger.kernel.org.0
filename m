Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72A57B42DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjI3SEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjI3SEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 14:04:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D962E5
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 11:04:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb673so123954415e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696097046; x=1696701846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GUrGw+oIpm434a0jwZAXwfA3uceDoUYkG3/g20/aCBk=;
        b=X/272eClGGTRzQnvxueso+cc9Qghp5geSpz4eV6flvNDaSYHZN+LNutPISU5QQMDia
         Dirgvr2nNGOmLhjlgS1MGOvF1ZlZsBMqWR/g5JldFQf6ELbvtXSYwHn2sv+ySK6KaDcm
         oXeBI+IQhVqIEwKMyxqtZgfAsb8SnNdUyLzFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696097046; x=1696701846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUrGw+oIpm434a0jwZAXwfA3uceDoUYkG3/g20/aCBk=;
        b=KGjqDhwNSjND5I+E+w8YCIN0nVq/MahWkRbumIER73M5qero8oFN74I28JENf3jx+p
         NCFd5nRBrd4C+BnTr7LoAELDFpmpXVG5BsXWz1LokyR8DUWUVkz5lMnKH/RBwDeVHO6D
         wvdLzecIV7d9jXU3EVAbS4FBz67PDUqw61z2IJu4YaXm8DyNEm58HTijJMXKmTSWbJzz
         S1YTF1V04d7BMnNo5lDkRga/E840fEPf9IleHXl7cMRWgp6Pmw9PpnmnWXvgpM0MOS+J
         +tsjt3MKC6wQCeaKOb5XdwpDRUlPIAOFwk85lDGS8DSR+rL8QmdEW0P8QKHOEhp7pXAj
         tGpw==
X-Gm-Message-State: AOJu0YwES6H2sQvLNGpI8s1Pn1Luc6zbL/AtNuRpP/EMtCYk0mgew1VV
        7lvozcA6ShG7HCkG/3v0aABm11WpT8pdMg2jns2K7Q==
X-Google-Smtp-Source: AGHT+IEaEcVAVKesjHIdr9ANF3CrDNnDLaBiJyEK/5V4NzqD2eXOyEO1kWAI9OJDXo0mFal2pQWAyQ==
X-Received: by 2002:a5d:4210:0:b0:323:3ab5:9910 with SMTP id n16-20020a5d4210000000b003233ab59910mr6498861wrq.42.1696097046452;
        Sat, 30 Sep 2023 11:04:06 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id q13-20020a056402518d00b005346925a474sm6841534edd.43.2023.09.30.11.04.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 11:04:05 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-32615eaa312so1382107f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 11:04:05 -0700 (PDT)
X-Received: by 2002:adf:f507:0:b0:323:2d06:9dbb with SMTP id
 q7-20020adff507000000b003232d069dbbmr6329330wro.12.1696097045037; Sat, 30 Sep
 2023 11:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <169608776189.1016505.15445601632237284088.stg-ugh@frogsfrogsfrogs>
 <CAHk-=wjHA1d1kGhnzfXw7BsLuR93CPizeFzN0sNJruWsqvqzTQ@mail.gmail.com> <20230930172129.GA21298@frogsfrogsfrogs>
In-Reply-To: <20230930172129.GA21298@frogsfrogsfrogs>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Sep 2023 11:03:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whu=nfBvBn3JG9pBVdgV=tTpCLh=iDdBfsgNsEY6w4KwQ@mail.gmail.com>
Message-ID: <CAHk-=whu=nfBvBn3JG9pBVdgV=tTpCLh=iDdBfsgNsEY6w4KwQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc4
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     bodonnel@redhat.com, geert+renesas@glider.be, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 30 Sept 2023 at 10:21, Darrick J. Wong <djwong@kernel.org> wrote:
>
> Doh, wrong repo.  I'm kinda surprised that git request-pull didn't
> complain about that.

I suspect it did complain, but that one-liner is admittedly much too
easy to overlook when everything else looks sane.

> Will send a new one.

Thanks, pulled.

             Linus
