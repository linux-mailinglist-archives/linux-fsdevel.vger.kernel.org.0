Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7D664072
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 13:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjAJM2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 07:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbjAJM1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:27:44 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A322917061
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 04:27:40 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id o75so11629215yba.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 04:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6KndhW8ZthnZXH5GZJH/lEnO//E0T9z85lpDRJv/Coo=;
        b=fLHC6l/L0Ijx5D2CAJDRuaGTh0+lAqH7wRXf4FXEos/1kCMAzIGNE/a19cTVHPstyj
         JwaTeSROjJgdKlGX2jhdbFh9OyFkzqux7VGs0+lrSZRTtt+esc/w3XrW1M+qkRBOzrNd
         2+HGDXTDKGfbMGyWkagwgv+cThJ+qjOtFr9rhUtHn7QO3oehJwbga1TlShhaSinIURvU
         54pzeCiKxGHjU4wHJ1X9db9bwm7ajet6de0BfVL4IT7QfNxXO2bScK09DianQE/OI7tU
         jt+NXznD2zJ0+5lt87pz53ZPLKBDIvsa2HqYHFm4kDDKjA7Qdg+pqmsS6UU0Sqqna8hx
         /OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KndhW8ZthnZXH5GZJH/lEnO//E0T9z85lpDRJv/Coo=;
        b=kr+Vd0JdSu/w7X1UxuBItPqK/6+yLaMSCHduSKYLcWDmVf523jNS8smCVVu+ybMhCY
         hXIMyB1m7EmVghbpdB64ObqkJUb3UxOxvcfiRlI/yHjTIdyHT30t1R3jB+kEKz9WIPVR
         9NsxxPfFA54iBZ0yQBgS2ZpaV6+ozVHBOMmzw+JP4iwI6qPEOHvVtv4Rdmw5RCoX6CqX
         bABf4uc0nd3rJsjauJ0Xde+gn6FvibcAjojY4y+3u7mor7BqQEIC68hiauYKveyp4PNY
         RixUZ2KoHTji4CDCwoqBQulhRHttznEpJZJ4WFVLgrVEHVvaMLZTV+ZkjwRwX4bvy9jc
         +cLw==
X-Gm-Message-State: AFqh2korT94mVx0cZ8i95f6e6NfEtyTooKwCM0UsB+46QbeZOrSuIqEs
        xpIaQXCDWf7IW8TDd9+tjJIzAOOjrTcJ7Vj8KJ5u9Q==
X-Google-Smtp-Source: AMrXdXuKs2wl/bseH+adSS22ymofeLisqiz/F7ZTp9k5notKnLu5IuY4AXMn8tcdHRycayafMh+GPeKHWlUwXyTIcIU=
X-Received: by 2002:a25:bbc1:0:b0:6fd:ef90:2ae5 with SMTP id
 c1-20020a25bbc1000000b006fdef902ae5mr5331591ybk.376.1673353659656; Tue, 10
 Jan 2023 04:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20221121112134.407362-1-glider@google.com> <20221121112134.407362-2-glider@google.com>
 <20221122145615.GE5824@twin.jikos.cz>
In-Reply-To: <20221122145615.GE5824@twin.jikos.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Jan 2023 13:27:03 +0100
Message-ID: <CAG_fn=Waivo=jEEqp7uMjKXdAvqP3XPtnAQeiRfu6ptwPmkyjw@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs: affs: initialize fsdata in affs_truncate()
To:     dsterba@suse.cz
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 3:56 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Nov 21, 2022 at 12:21:31PM +0100, Alexander Potapenko wrote:
> > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > an error passing the latter to aops->write_end().
> >
> > Fix this by unconditionally initializing fsdata.
> >
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> With the fixed Fixes: reference,
>
> Acked-by: David Sterba <dsterba@suse.com>

Hi David,

I've noticed that the ext4 counterpart of this patch is in the
upstream tree already, whereas the affs, f2fs, hfs and hfsplus
versions are not.
Are they picked via a different tree?
