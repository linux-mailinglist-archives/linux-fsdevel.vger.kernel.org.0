Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42DF5C010F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIUPYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiIUPYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:24:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C08E477
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:24:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a41so9258633edf.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=h2EdQ2QiZlRgBNy/h6xiX4E2ojT2ii0L3KbmpDweFGA=;
        b=So/DMfdd49G+5zpIJmraiOXjAQKEHxeMQ3UnlBI422xpLfQJjBE14/fCFMkpAItvJ7
         5ImYMIXOAVrvls71HwZmYWuhhAafkdwyez3AA5EYnR+z708HO6pF/K5wafyaLXKYYqPn
         7YnizfTMjguY+p5OKXIL+3q8PgqFaloWLEZfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=h2EdQ2QiZlRgBNy/h6xiX4E2ojT2ii0L3KbmpDweFGA=;
        b=JQLwWtyq7xfYlkx+Vv5lHdg59DutlLSUexrrhm5NPLbmgMICMsYjuARor9in/DwNQH
         8lVDPfXp0+0IA0dZL0nmkaYBH6glhJDP9vj+6LBXL+Xx5Wtznt+EmaQmhaocLtl6L6fw
         G9FeLPlfSnyiQqfh/tkR3sNCT/FZ+XsUY2IMjRW9DaxPirsVC2YxZhe8gYR9at+m2uaG
         Q6c1Zt4yeD4onQzuzDAdJGF7QV6zUhevyHBVKseJmb4yXJyfcYeYKqQCOAcYeUNm0Bxe
         LobsK/BhsqPi0zSOxaRNllgMUhbbaruVSIBnC50mvNTIGeoaAfCZMgVAvglvVKDw6Y49
         WRcg==
X-Gm-Message-State: ACrzQf0aoSkEN0T9lMrVcp8au+HaogISpcmOoUHyEgh5XChmvdcgFgXA
        k6k+OyeHSkk6jhblJ3OhlMnOgtN198NTzjK2UNReUQ==
X-Google-Smtp-Source: AMsMyM7hucoBHXmG5iAj93qeoK8blS48+jcCRSmT3WNJT/vKBcBl4SvNyUAc7nXiEYVda3EUz/a0/akHinss6ABoLOg=
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id
 ek12-20020a056402370c00b004539fab1b53mr20508721edb.28.1663773855956; Wed, 21
 Sep 2022 08:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-8-mszeredi@redhat.com>
 <20220921090306.ryhcrowcuzehv7uw@wittgenstein> <CAJfpegsEbwQhgZbXTsAzcMTcwVvA_U4r+JEDLcYSAezC6hYq5g@mail.gmail.com>
 <20220921150942.l3g5k55l6j5k7yn2@wittgenstein>
In-Reply-To: <20220921150942.l3g5k55l6j5k7yn2@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 17:24:04 +0200
Message-ID: <CAJfpegvXQYucWaz5ON_zvrbooEGJdDyNyEUgBb+Q+mjhyzZKpQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Sept 2022 at 17:09, Christian Brauner <brauner@kernel.org> wrote:

> Ok, the finish_open* thing can be left for later. But vfs_tmpfile_open()
> should be doable for this patchset already.

Fixed.

Thanks,
Miklos
