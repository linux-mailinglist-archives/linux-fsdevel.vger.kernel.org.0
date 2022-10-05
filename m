Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3655F568E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJEOiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 10:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJEOiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:38:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751147CA8E
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 07:38:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m3so23254404eda.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Oct 2022 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=30RZfPuaNin29yiKpLmSu3lAATDfol189HBniwYXiU8=;
        b=pNkv1d03U/77IcW7X3mn7ka+SdIgp+9HRVNSSLr/aqFgd9PvNDXmIqBqi+/nZhOIiS
         aoJNWxRZQsPv9Uh8Zwx11sR2HbK62WmQuBt1KkTSQLE9ujmK31VXjHVZ7Y4EB7i9622b
         /DoZmRgogduDmPIB7+BdTzf9JUxp5CUWs7LfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=30RZfPuaNin29yiKpLmSu3lAATDfol189HBniwYXiU8=;
        b=Wo74lQUpXdrOrJoNEKyBI/jw9V8lVgfnLYaRP/KL6LqCDKM/Z/FtrCji00zhHti6m+
         /FsxHJWDkrSD6MxWug3dbE27V0e9IdnUoYBf28JIjss872P9KYnAxo4TYlG8NZz4IStD
         RPwWLxY03dc/HUkAHrd9U07xFE597J6qPRDz5tyLdicg5SCJ5lURydF/ae9VEXi9bVDG
         M75S3n11Ok17drHASoijmHrCOfV8T90URNwQuF2k2zEdEzTQIU0/7OdS/ejUE23QkKuf
         Olw4vZ3Pm7Ly1LbRDcdkos9JrXkiese14fVSuegqOMn4hz48uMVl9P6f7zB8+mkf6KJZ
         WCuQ==
X-Gm-Message-State: ACrzQf1teAmXlk+aXGz1mkBA6/TXhaBXF9XOErqvFaNPArckzQKdxVmy
        Mtl+yLzwQyDcHf4bW89Cxb+CbEPEFnp8mWzyFD7Gyg==
X-Google-Smtp-Source: AMsMyM7/IqrggiV8FhxgjZRBnx7wpmyG4q5btSJpLQFHxfujUzG9TEU0iIIkxWRCTFogY46FMZ22jYA7DUd7GlubTA4=
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id
 ek12-20020a056402370c00b004539fab1b53mr104487edb.28.1664980689738; Wed, 05
 Oct 2022 07:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221003123040.900827-1-amir73il@gmail.com> <20221003123040.900827-2-amir73il@gmail.com>
In-Reply-To: <20221003123040.900827-2-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Oct 2022 16:37:58 +0200
Message-ID: <CAJfpegtaLQXb-9KoQ5_zA3mEk835UxMq_sN3UyyCdBuRZZG8dA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ovl: remove privs in ovl_copyfile()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 Oct 2022 at 14:30, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Underlying fs doesn't remove privs because copy_range/remap_range are
> called with privileged mounter credentials.
>
> This fixes some failures in fstest generic/673.
>
> Fixes: 8ede205541ff ("ovl: add reflink/copyfile/dedup support")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
