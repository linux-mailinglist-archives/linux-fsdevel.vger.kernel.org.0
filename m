Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710666B2822
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjCIPD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjCIPDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:03:07 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7EFF0C56
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 06:59:40 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u9so8192942edd.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1678373979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+VSDa7dBH/bVf4+A7dL/Xx6tG+g312K6/L+r45ZA+CU=;
        b=De0gNLn6ZBXhJR3GiPLzdHVtUHk9b0I+eQyNxZGTw8O0e8giDVjxj1uqT0EfDgqJIG
         48/LmTbYk1rbeobIw+Bkvgp1z5/QMmUcoa55yGfMpZAdIJ9ECQDcNjRJHy0Etaz9qTbV
         n4nWOz+0tWPMXB5F7AdPyXHI2n/71TPUZnQN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VSDa7dBH/bVf4+A7dL/Xx6tG+g312K6/L+r45ZA+CU=;
        b=t8eKPJ/9aROTe59EMLR56/VmrOpMPXhK0tSabnmGdVz+LI50/EqIbnJ/l3Mom2az/l
         Q1rPLcP/vpJ8zLUREWf+ZNf1WaXzsnYTang1Y+lrtErPQ8dn29UBDwxHQzMp7HlKY1Nk
         +ni3SzOEJ2MtMw727L5dTFSbzFVFRYTcxvU+zW+i4xqzgzbhU2CmVbvtbh+1bETgYSGg
         zQNiuaw+23RHA9VRWhAe83IJ91ts87VWQi7BSp88XBATBPW4/Cp9Cszf8T1D4Z1oqA77
         gRFVfosPd6W3yL6f2VFYzdey0hn2b+APu+fmCsUPYlA+xVc7tikZ0pqtg0Pml8ABF1wA
         ZUzw==
X-Gm-Message-State: AO0yUKXy1cFS2H6IoymePPhaGNtlPMlrw11iK6q3TyO6JiRPMsC2Eg1B
        1GWugje5tlDMlPLeN1DD3bOKpqigxihuAaDqLzI23xKP4FO00Xws
X-Google-Smtp-Source: AK7set+19crCv3xn8eV6LTvRSmhextzlOUuWjoia6pFldjZHmUNJ1nqnArcoZB1onZ3MrlNAowxHKoc6ietIxmjkjrU=
X-Received: by 2002:a50:8e5d:0:b0:4c8:1fda:52fd with SMTP id
 29-20020a508e5d000000b004c81fda52fdmr12485472edx.8.1678373979006; Thu, 09 Mar
 2023 06:59:39 -0800 (PST)
MIME-Version: 1.0
References: <CAL7ro1GQcs28kT+_2M5JQZoUN6KHYmA85ouiwjj6JU+1=C-q4g@mail.gmail.com>
In-Reply-To: <CAL7ro1GQcs28kT+_2M5JQZoUN6KHYmA85ouiwjj6JU+1=C-q4g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 9 Mar 2023 15:59:28 +0100
Message-ID: <CAJfpeguTqXKuBcR3ZBbpWTPTbhnLja0QkBz3ASa4mgaw+A4-rQ@mail.gmail.com>
Subject: Re: WIP: verity support for overlayfs
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Mar 2023 at 16:29, Alexander Larsson <alexl@redhat.com> wrote:
>
> As was recently discussed in the various threads about composefs we
> want the ability to specify a fs-verity digest for metacopy files,
> such that the lower file used for the data is guaranteed to have the
> specified digest.
>
> I wrote an initial version of this here:
>
>   https://github.com/alexlarsson/linux/tree/overlay-verity
>
> I would like some feedback on this approach. Does it make sense?
>
> For context, here is the main commit text:
>
> This adds support for a new overlay xattr "overlay.verity", which
> contains a fs-verity digest. This is used for metacopy files, and
> whenever the lowerdata file is accessed overlayfs can verify that
> the data file fs-verity digest matches the expected one.
>
> By default this is ignored, but if the mount option "verity_policy" is
> set to "validate" or "require", then all accesses validate any
> specified digest. If you use "require" it additionally fails to access
> metacopy file if the verity xattr is missing.
>
> The digest is validated during ovl_open() as well as when the lower file
> is copied up. Additionally the overlay.verity xattr is copied to the
> upper file during a metacopy operation, in order to later do the validation
> of the digest when the copy-up happens.

Hmm, so what exactly happens if the file is copied up and then
modified?  The verification will fail, no?

Thanks,
Miklos
