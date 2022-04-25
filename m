Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AC50DB6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 10:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiDYIoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbiDYIoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:44:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E377CDC2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 01:40:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so28168120ejd.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yo7vm9yRg/QAt1cNLA0IMYEFR0QnFkwTlujuFxJ6tig=;
        b=Yj5v2QNu+40yHuj9V96wK5Lk2PRlgVVxr+SlafzZ7eT6mKUsJEGiQPF9w+B+5CX7oH
         LoXOZtHd1okc62V7YZhvvG0vy6cbqi0Nxx7zPn2IhK4P8HppahbIB3U4Np3NxBkP1N81
         HkdlYhhE9SpupA1RSfERLDb5m+NekQwnEyTKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yo7vm9yRg/QAt1cNLA0IMYEFR0QnFkwTlujuFxJ6tig=;
        b=J816nq8Wc0G+LzUmE2Vo1xIH9aQH6BH7FwtSlOKeLYLFXaj8LHX9P0tccxbgfyW1nJ
         jzc8ODGELleYSK+Q20qDib88hrp0EjG7it8/leSmXiD0xh2dsdcAT1F5Qb5l9zG2MQUC
         R7kXfy4RV/keh8VEBjr9Oe0a+Ue7pFwRDUN6ynsRr3ZYLLvLRQddxXmtduV6hztZt6Ri
         YBkiyW7h8XqTmrfOUqnt7FvK6Zkg94Sh1DyC1MRJpizUGFqr07Uel0OiTxFYGnxrFfaE
         rt+cAXgT0d7HA2SgL9uzyegLn7bFP00t6QOWJFhjTIgMv/muGikyM6lUkHCF9KBIdgfM
         LhEA==
X-Gm-Message-State: AOAM533qMl0jQAKYj/B3oDIc+kNICc5qEFsFleB8JKAgiYioZzVu6CBZ
        Q6/SsWy2GVM6b8uZ3hI0arb2yTt0EiAxHUCgZeZ5RQ==
X-Google-Smtp-Source: ABdhPJzrHXhPirdz/qLVLB8fMpWlNTSB58OH+GuOBLRSDrrxcvhyz9FXzX0JJ7wK3nskKjTkUX8GTQUVo6vroLyDu74=
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id
 gg2-20020a170906898200b006f395f44adfmr3637776ejc.524.1650876057869; Mon, 25
 Apr 2022 01:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220408061809.12324-1-dharamhans87@gmail.com>
 <20220408061809.12324-2-dharamhans87@gmail.com> <CAJfpegvU+y+WRhWrgWfc_7O5BdVi=N+3RUuVdBFFoyYVr9MDeg@mail.gmail.com>
 <CACUYsyGiNgbyoxWWdXm0z73B7QfnPGU2gYanDNSQqmq5_rnrhw@mail.gmail.com>
 <CAJfpegsZF4D-sshMK0C=jSECskyQRAgA_1hKD9ytsHKvmXoBeA@mail.gmail.com> <2c8e61de-54da-44da-3a7b-b95eabfb29f2@ddn.com>
In-Reply-To: <2c8e61de-54da-44da-3a7b-b95eabfb29f2@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 10:40:46 +0200
Message-ID: <CAJfpegtsTiO8tJ5yP0tonh3zu4125JXaJ0cOY-e_B5dDxmfSug@mail.gmail.com>
Subject: Re: [PATCH 1/1] FUSE: Allow parallel direct writes on the same file
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Hans <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Apr 2022 at 17:20, Bernd Schubert <bschubert@ddn.com> wrote:
>
>
>
> On 4/22/22 16:48, Miklos Szeredi wrote:
> > On Fri, 22 Apr 2022 at 16:30, Dharmendra Hans <dharamhans87@gmail.com> wrote:
> >>
> >> On Thu, Apr 21, 2022 at 8:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >>>
> >>> On Fri, 8 Apr 2022 at 08:18, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >>>>
> >
> > That's true, but I still worry...  Does your workload include
> > non-append extending writes?  Seems to me making those run in parallel
> > is asking for trouble.
>
> Our main use case is MPIIO for now and I don't think it first sets the
> file size and would then write to these sparse files. Fixing all the
> different MPI implementations including closed source stacks is probably
> out of question.

Okay.

> Given that MPIIO also supports direct calls into its stack we also do
> support that for some MPIs, but not all stacks. Direct calls bypassing
> the vfs also haas  it's own issues, including security. So it would be
> really great if we could find a way to avoid the inode lock.
>
> Would you mind to share what you worry about in detail?

I worry about breaking the assumption about i_size does not change if
inode lock is held (exclusive of shared).

Maybe that's not an issue, but we'd need to look very carefully.

Thanks,
Miklos
