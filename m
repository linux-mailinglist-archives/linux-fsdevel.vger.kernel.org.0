Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E65762796
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 01:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGYX7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 19:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGYX7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:59:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26D170D
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 16:58:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso51614505e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 16:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690329538; x=1690934338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0V/EEMFzUDgOJY1HEZ2mzSgEOY/cF7JWrxdvLNmC4c=;
        b=HQmhRjdDvJ1uYczgxWnKD2vuEgMQ1C34U5qNTVu5bgQnwC4Bo65ZfziU37Xl9ReMuI
         ljgsg+zC1ZyZKpd6J4xCbFL7r/WFBlobzR0fNJHPHHsEVIs1APIzpwzPPIJWZ9biqp/R
         QfbRvQeOQiOMI8y/jOcru47WwYghRDHy+nC0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690329538; x=1690934338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0V/EEMFzUDgOJY1HEZ2mzSgEOY/cF7JWrxdvLNmC4c=;
        b=GBKGJC83u2Ww6KR2I4GElFch+neIuUIOaLAYWZ+1/NivKO9fd/kb0oPP9e75U/BSl1
         ptbUj5uG6KrTtBcYhKODH1pzmkWorl9/0x0vnQPcn5P5XP3SfbaqT0UK5nH7ivGfoZbK
         5TKO5f1uIexTB5xgT8tBbcwwvWMpklsvoLvwsuiiTeP88Q8c4uLQ5leLpNIcGvPBC81O
         kN2VTqTahJ4kgn775X/rSpAM8BVsA5blR5T8nqXsnbZSEXbUubGBXVS5qhSuNUef4suT
         d+Lu2Bk9nK+R1cgihtEUD18inEiS5xvNLPyf73PtupcKfLTyt+a7I5xVJpbqEnH1firZ
         Tnog==
X-Gm-Message-State: ABy/qLYDVC+YpfjCQnkYFcGLlV2DfQrSd1sHjrV9c5upwS7U1t4Mlqku
        REe7ZiCxf7vupxDfOe2bk5x41ZyRHmj2k9CMhwzWHA==
X-Google-Smtp-Source: APBJJlGy2L5/2cNwOkSULYyldMb4TDytCVWiZW6+dAHiJcS7YGt/MlduX4KyitS9hJny3oNNGjQrpGffL7wmLJmUKA8=
X-Received: by 2002:a5d:49c5:0:b0:316:fb39:e045 with SMTP id
 t5-20020a5d49c5000000b00316fb39e045mr180608wrs.48.1690329538460; Tue, 25 Jul
 2023 16:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230710183338.58531-1-ivan@cloudflare.com> <2023071039-negate-stalemate-6987@gregkh>
 <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com> <jy7ktvlb4tkg6pl2vll6u4gozfji7giddyseypj4w2d2ue4gvn@4tw7dmjy4hfv>
In-Reply-To: <jy7ktvlb4tkg6pl2vll6u4gozfji7giddyseypj4w2d2ue4gvn@4tw7dmjy4hfv>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 25 Jul 2023 16:58:47 -0700
Message-ID: <CABWYdi1k1gNwkWT8TH7kPv=tA8qaZbjaaogYoMRnFPtBqvR_Uw@mail.gmail.com>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in fsid
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 7:07=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Mon, Jul 10, 2023 at 02:21:10PM -0700, Ivan Babrou <ivan@cloudflare.co=
m> wrote:
> > I want to monitor cgroup changes, so that I can have an up to date map
> > of inode -> cgroup path, so that I can resolve the value returned from
> > bpf_get_current_cgroup_id() into something that a human can easily
> > grasp (think system.slice/nginx.service).
>
> Have you considered cgroup_path_from_kernfs_id()?

* It's not available from bpf from what I see (should I send a patch?)
* It turns short numeric keys into large string keys (you mention this belo=
w)
* It's a lot more work upfront for every event under a spinlock

> > Currently I do a full sweep to build a map, which doesn't work if a
> > cgroup is short lived, as it just disappears before I can resolve it.
> > Unfortunately, systemd recycles cgroups on restart, changing inode
> > number, so this is a very real issue.
>
> So, a historical map of cgroup id -> path is also useful for you, right?
> (IOW, cgroup_path_from_kernfs_id() is possible but it'd inflate log
> buffer size if full paths were stored instead of ids.)

For the most part the historical map would not be necessary if we had
cgroup paths (except for the points I mentioned above).

> (I think a similar map would be beneficial for SCM_CGROUP [1] idea too.)

Yes, it seems like it.

> > There's also this old wiki page from systemd:
> >
> > * https://freedesktop.org/wiki/Software/systemd/Optimizations
>
> The page also states:
>
> > Last edited Sat 18 May 2013 08:20:38 AM UTC
>
> Emptiness notifications via release_agent are so 2016 :-), unified
> hiearchy has more convenient API [2], this is FTR.

Sure, but these aren't arguments against having fanotify for cgroup filesys=
tem.
