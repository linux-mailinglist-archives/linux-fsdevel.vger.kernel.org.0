Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311017B6AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbjJCNz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbjJCNz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:55:58 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBFEBF;
        Tue,  3 Oct 2023 06:55:55 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59f57ad6126so10990247b3.3;
        Tue, 03 Oct 2023 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696341355; x=1696946155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e47KQqmvrattxja1YQ2aTfwqutE4ILLnK+WXsK/hoxs=;
        b=dj2EDQ6lBgKZUqkhyw8RvJUlPERvwjhwUsd+mBK7+TXr7LAJM78vJjvIXqd3RfvE9v
         8qajCn4rOQzoyKzn66jEMpeUAeo22pHEkxu3y2FSl2if8KioDPbD3W7yeqkgUW3Y1OTI
         Kt3hf85RkV2qzPXyaifh7hNmlzSU+6g3VaKa6/tHmOKsdo+u7lqMmsR4wLA4QWNgv1Ci
         apNh8+0e5zf3qO4TNj0L1lZybDDhD6Dq54d+WratDZmTgqCGTaDN4ynmpCtxDnmuPVMO
         R52BP56gXQYyS8b/77mKRoofsK2trNc7hEpzvjWQIirQHgOb0+f5N6c9i2AwIIiO0eeO
         AYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696341355; x=1696946155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e47KQqmvrattxja1YQ2aTfwqutE4ILLnK+WXsK/hoxs=;
        b=jcP1/brTG+H177UKNTvome+cVFUVsEonMl20zEHofW9SmxFs2lZKJjfhW0HLnsSDy2
         NOkxx6phAnR7g1ByjH8haSn6j2MI+HGeP/gH5gaSKA+z5qBHAsl0mxpjAzES99GH4NJG
         79PiymnF6BeSPrKAEe5koQBSCGWKxw1jFdN1fM0yaINcdDgEadoCbTsEuTBP91ouxF/p
         kahbbPjpRWV4o2ldPQCYd8GqzOVK418Z09uMTb6u35iBxYdBc9btD+XkHxn01Mz0+CyP
         iIQ1ljyMrS9xDc8RNUUyCkanVP9Fg0X+whj0WGra92MWrdcKivg6uudaOfkWVde/Tp6S
         9d0A==
X-Gm-Message-State: AOJu0YxHGfS1bPTCY6R+wNKDbqL3AFWnGUfmpwWZh0ZCr7sY0jBuLzCY
        gXvaS/nT7QofnTuij8zFrfNLXwIRVGe4KxoZEjI=
X-Google-Smtp-Source: AGHT+IEhXzR//Jjev9ftMKRZBGzNI4vilpgfXx5YzJgF49LCZZ9ICYZFaD6VDvwLkYWpxBxMCcyEznVjJ7bMzxesXQQ=
X-Received: by 2002:a25:1f56:0:b0:d78:f32:5849 with SMTP id
 f83-20020a251f56000000b00d780f325849mr13126245ybf.24.1696341354734; Tue, 03
 Oct 2023 06:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230930050033.41174-1-wedsonaf@gmail.com> <20230930050033.41174-4-wedsonaf@gmail.com>
 <41368837.HejemxxR3G@silver> <ZRfkVWyuNaapaOOO@codewreck.org>
In-Reply-To: <ZRfkVWyuNaapaOOO@codewreck.org>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Tue, 3 Oct 2023 10:55:44 -0300
Message-ID: <CANeycqptxu1qWAHLc76krDmfgesANPX+FLEV51qhtXam6Ky9nQ@mail.gmail.com>
Subject: Re: [PATCH 03/29] 9p: move xattr-related structs to .rodata
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 30 Sept 2023 at 06:03, Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Christian Schoenebeck wrote on Sat, Sep 30, 2023 at 10:12:25AM +0200:
> > On Saturday, September 30, 2023 7:00:07 AM CEST Wedson Almeida Filho wrote:
> > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > >
> > > This makes it harder for accidental or malicious changes to
> > > v9fs_xattr_user_handler, v9fs_xattr_trusted_handler,
> > > v9fs_xattr_security_handler, or v9fs_xattr_handlers at runtime.
> > >
> > > Cc: Eric Van Hensbergen <ericvh@kernel.org>
> > > Cc: Latchesar Ionkov <lucho@ionkov.net>
> > > Cc: Dominique Martinet <asmadeus@codewreck.org>
> > > Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> > > Cc: v9fs@lists.linux.dev
> > > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Thanks for the review, Christian!

> Looks good to me on principle as well (and it should blow up immediately
> on testing in the unlikely case there's a problem...)
>
> Eric, I don't think you have anything planned for this round?
> There's another data race patch laying around that we didn't submit for
> 6.6, shall I take these two for now?
>
> (Assuming this patch series is meant to be taken up by individual fs
> maintainers independantly, it's never really clear with such large
> swatches of patchs and we weren't in Cc of a cover letter if there was
> any... In the future it'd help if either there's a clear cover letter
> everyone is in Cc at (some would say keep everyone in cc of all
> patches!), or just send these in a loop so they don't appear to be part
> of a series and each maintainer deals with it as they see fit)

There is a cover letter
(https://lore.kernel.org/all/20230930050033.41174-1-wedsonaf@gmail.com/),
apologies for not CCing you there. I was trying to avoid spamming
maintainers with unrelated changes.

We need changes in fs/xattr.c (which are in the first patch of the
series) to avoid warnings, so unfortunately this can't be taken
individually. My thought was that individual fs maintainers would
review/ack the patches and this would be taken through the fs tree.

>
> --
> Dominique
