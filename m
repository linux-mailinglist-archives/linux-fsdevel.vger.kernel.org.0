Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C469286D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 21:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjBJUhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 15:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjBJUhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:37:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009F85A90E
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 12:37:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id sa10so18832884ejc.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 12:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V5hbvtyrVhBU5KLvd4luM4pmIGBHWSgPPjkAzLVdXdc=;
        b=XJVb1xKfBvelCl8Xuh4Bkq319Cx2dxwUHidMnSfKqGDU/b9SmTwk9u5Vp4ORhPDBNt
         uLp+1raScNofpejxVBGtMzdmvBtnEGPM6qvYjZcLw/dIFGbo6cMI3yaedOJppVXrhg5I
         8ihrf6+ZhqT/79pvdvMQsBrrZs8E6lxb26z2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5hbvtyrVhBU5KLvd4luM4pmIGBHWSgPPjkAzLVdXdc=;
        b=3FUac+0TWpXlxHqZLKOxkFOsnbllkKCMw9S0DwIZULAkskKfbJysuO78KPDcqNBGFs
         LzgA7AoyF7QlhCC0ZcAzQeINnDo5FZWS+g+IUjebViVcePRRZAIfheE+eEMOla8uPLW3
         QXUm4b9lbBMgOIee+2BBzdt6eqw/g4Oo2MMiN7VEz87xGLmBTBPqyTkrhfXnBlp/ua8T
         MYDh6f7AkpswjFnripP6E3ii2PBs/4+qzO0dvFrvSfNn0SKCabh/+oxkN+MlH7vnQLqq
         RczvVQFV/k43sqR/8xGH0hS7bpKnQgUrXOw4ygT9MVQmh4PvBTuYmRwmPepv78dnYrZk
         d3WQ==
X-Gm-Message-State: AO0yUKW+InAD1fUx4h7k14HXM+LC7drxVvlE1Ef39pvwfYELsP35d3i5
        LFjYLHI7hE3IslOuw2/7hPdcg8i0+moOXrYQ+XE=
X-Google-Smtp-Source: AK7set9/u8hcI8Za9zkzmU0zyoyASr1nOMm3pk2z8tHGyVG6BfPGDNgT8ktKCI28jRysjRkRIZ/M+A==
X-Received: by 2002:a17:907:6d94:b0:8ae:e724:ea15 with SMTP id sb20-20020a1709076d9400b008aee724ea15mr14086652ejc.76.1676061437103;
        Fri, 10 Feb 2023 12:37:17 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id gq9-20020a170906e24900b008b0261c4af8sm42874ejb.130.2023.02.10.12.37.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:37:16 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id ml19so19040469ejb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 12:37:16 -0800 (PST)
X-Received: by 2002:a17:906:f749:b0:8af:2ad9:9a1d with SMTP id
 jp9-20020a170906f74900b008af2ad99a1dmr1552969ejb.0.1676061435878; Fri, 10 Feb
 2023 12:37:15 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com> <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk>
In-Reply-To: <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 12:36:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
Message-ID: <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:32 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> No, we very much do have that for io_uring zerocopy sends, which was in
> the bit below you snipped from the reply. It'll tell you when data has
> been sent out, and when the data has been acked.

Hmm. splice() itself definitely doesn't have that data - there's no
"io context" for it.

There is only the pipe buffers, and they are released when the data
has been accepted - which is not the same as used (eg the networking
layer just takes another ref to the page and says "I'm done").

Maybe adding some io context to the pipe buffer would be possible, but
it's certainly not obvious how, without changing splice() semantics
completely.

             Linus
