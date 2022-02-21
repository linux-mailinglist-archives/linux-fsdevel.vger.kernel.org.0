Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98CE4BDC99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 18:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377408AbiBUOPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 09:15:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbiBUOPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:15:21 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEC412754
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 06:14:56 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id j12so8742541vkr.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jukHAxX1a8gs5R7NWrZYvZKQNQvQvJQkqxNSYa7JTb8=;
        b=ZNUhWFbjKY3UwWffoXU16mP6h9wjYYBwYzR549uKv8CNan90Sy6B/G0d/xvHkOJ8D+
         0gDxpUPeqUbTXamz1bzTrd9YkW+b8n3EZ0zqrNl+KCmRzSoPCRJZSNSYLPVWPOAOKOKV
         Oqp4pjfsBKe65koFUeQ3zL8OT7D8RjlwrVBG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jukHAxX1a8gs5R7NWrZYvZKQNQvQvJQkqxNSYa7JTb8=;
        b=cJfS9JkNFtJJIqwK2pKwsdRuvtGyxdRnQTjn6DzXUO13/Er8iN/QJth4OhNLyfMZp0
         /e7S6RF4ZQZcIDyKtGKiFiIX8OXzPnyjyNHbvW3nH7RFEZqEHcNY3i22PU28HfDbgcAB
         D2sYh4bZLl4WLlvXunUX77OBROpKeEclNgB8L/zZqg+X1BWBu2cUQLPnJYmG86vnWWel
         9Z/Eht9vuk95Nl/TwCsZFurQdpKR5Rlg9xG5ma5204vO82sFmyKf6fZvARssATl8OpD8
         fjZwkX0ZKx9oFGgH+RK+wzvqcWUyGfSitXeoatMCKu8pO5AFU5b9cGvv/j6oKRCDxHuN
         QaIA==
X-Gm-Message-State: AOAM5301eQ7QNv5bZGoDnbLu20ZYa0QeNc13HqH8fJ8aLpag1A2TweSp
        gkGPN4ibKkYF99pldQprpSFj8Mto4Sm4LzgOWH5VF60eI6I=
X-Google-Smtp-Source: ABdhPJzgh30SdAuZg65SfZ6LMo/zCX5/82fHSJif+hrIe13qdb5Rx8HQf0bbvBW2vAbkJxbgD/JjN4lMj5OWE/9ekyw=
X-Received: by 2002:a05:6122:134f:b0:330:f4d8:22c5 with SMTP id
 f15-20020a056122134f00b00330f4d822c5mr8279107vkp.1.1645452894298; Mon, 21 Feb
 2022 06:14:54 -0800 (PST)
MIME-Version: 1.0
References: <6da4c709.5385.17ee910a7fd.Coremail.clx428@163.com>
 <CAJfpeguvqro7SUmve_dyMiPHn4_dzQR4MMJRwZyfq61k17N-jg@mail.gmail.com> <4cc380c8.51f5.17f1c9f84fd.Coremail.clx428@163.com>
In-Reply-To: <4cc380c8.51f5.17f1c9f84fd.Coremail.clx428@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Feb 2022 15:14:43 +0100
Message-ID: <CAJfpegtEJCrxuR0jUsCo0zT3j3jS_AdgspGYp65-RK-rhSnRLw@mail.gmail.com>
Subject: Re: Re: Report a fuse deadlock scenario issue
To:     =?UTF-8?B?6ZmI56uL5paw?= <clx428@163.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Feb 2022 at 15:11, =E9=99=88=E7=AB=8B=E6=96=B0 <clx428@163.com> =
wrote:

> >This last is not possible, because write_cache_pages() will always
> >return when it reached the end of the range and only the next
> >invocation will wrap around to the zero index page.  See this at the
> >end of write_cache_pages():
> >
> >    if (wbc->range_cyclic && !done)
> >        done_index =3D 0;
> I use the kernel version is 4.19.36, which it has no 64081362e8ff4587b455=
4087f3cfc73d3e0a4cd7 mm/page-writeback.c: fix range_cyclic writeback vs wri=
tepages deadlock patch.
> I think this patch can fix this deadlock.

Yes, that explains it.  Thanks for investigating.

Miklos
