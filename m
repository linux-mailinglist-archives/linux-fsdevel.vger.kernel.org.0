Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278BE52AE89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 01:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiEQX1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 19:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiEQX1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 19:27:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0162CCAC
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 16:27:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ef5380669cso6760577b3.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3Jcn1iAarxojLmeUPOFMO73FT+c4hfJanwaPilfZzg=;
        b=QqrrLB9fcAAqWfAdPHgvPg1TR8H44QppAqFbge8zxueoMw3Lc78YQjaMIqeRxQYjWy
         yEglKnCqd4+ukyd5esKDU04HjYYF9BJ8LclvkX/9OU/h+JmVwmnTsiyuc4j/BZVo4hVb
         kEuj9+XxADeB2pPPFs88jkAACTQbS6YqGGt8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3Jcn1iAarxojLmeUPOFMO73FT+c4hfJanwaPilfZzg=;
        b=mW+nqek/iQWiC+wYqNuLpTybHRswHIlDkxk7bQZEAuqLvQLGqRhYrze2pms7SQoM8f
         5JZ0GPobGe3YwqHpkOxP514hSWsYhiayg0EAwU58V5BOgLHyvbxWaxXHc7tWvCi+3NgA
         POz+nU3HgIUaTUGJhGAf3LQVJvBBVkpYgV0ceAWq4e00LBgG/CPLHUsKfayhC7JGsSxt
         Bx7Cv7rfVTBDf+0gUHeGuapHpp1KPQDIA2dMnY80MeEn4XEFCJqK2X7Nx+lHjhB1sT4Z
         BJp/nUJ4Qc3ZVVtwJSOyP1GG7cEXktpvSCUxK52S2NW6/KLAExmy3h0HTiTuhGZG9MlM
         rCBQ==
X-Gm-Message-State: AOAM531pJ8xfnjbeeXmSm68AV6CgVVm5KAKgMmcc67ghRlO5ybJLUtF5
        CDj5IeXzufIpOU4f1QP+95kbtoKSEt8Wkah+bVJufQ==
X-Google-Smtp-Source: ABdhPJwrRA7kBmvE15oZulIgerECBDp5F44haVqE1VZK01HEAhB7hYdgStNdM2eQvN61omEB1Q9v0hIVM/WTgwwNGOc=
X-Received: by 2002:a81:604:0:b0:2e6:6b45:4812 with SMTP id
 4-20020a810604000000b002e66b454812mr28130840ywg.266.1652830055463; Tue, 17
 May 2022 16:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220511222910.635307-1-dlunev@chromium.org> <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk> <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
In-Reply-To: <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 18 May 2022 09:27:23 +1000
Message-ID: <CAONX=-fhM-TkOVyS+65WzyRoLwnL8nqd5HDNUv8sUvQyzw0-fw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        fuse-devel@lists.sourceforge.net, tytso@mit.edu, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,
Here is my v1 version of the patch which does skip the node in testing super
https://lore.kernel.org/linux-fsdevel/20220511013057.245827-1-dlunev@chromium.org/T/#u
I am not particular which version is to be used. However note, it still needs
to remove the bdi node since otherwise the new mount will have a conflict.
The bdi put should not kill the bdi if it has more references (and then
conflict would still occur, but chances of bdi being opened for a long time
is low AFAIU), thus this should be safe, but I might be missing something.
Note, that FUSE super block at the time is barely alive, it may have open
filehandles/references, but the connection with user space is already cut
and all of the ops would return transport error.
Let me know what you think and how we can address it better maybe?
Thanks,
Daniil
