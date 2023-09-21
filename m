Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DA7A9E21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjIUT4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjIUT4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:56:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94649E0DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 12:46:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so22944421fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695325612; x=1695930412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBK/gazFsyzXOKB+rBrmhryzG1knngQqKvlNh1yC244=;
        b=EsADxX/l8bpSbBR0dOwOGRhFA/s32coC4juMuGu8Ot+SRhWVPckVxv5JqDr9TDrCPd
         nXd+sCZGp9thaoONzvgcToC98HSNv1oBvfAUH+NUpHKDtYu6+TXZWE5aNsqoeWVKI6pB
         POx0yugFS+EPmoHsXcwLnTmNZYGNgY5WU6nzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695325612; x=1695930412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBK/gazFsyzXOKB+rBrmhryzG1knngQqKvlNh1yC244=;
        b=Fov9ucmRCMesdp3mzdRbcbDkYC1czn8aT4pFH9QdqZsK+rU/3ZRB47JnqYt6Nuwm3L
         wgAHKw+VtNKXFIyj0KNYS1bbtRUwSSZ3gFCczV/mpUxMqa8Qs0Awjb9cVyO7/7bvWi29
         SWSdbqVvx4wJVLnDul0tU1J/j9QO5gPFqZot+rPI0lsCo2235nsht+pdHK3E1Qmc8Z69
         H0rP2pNjgG3Tk0RLqwTh7yY7L4NoLJmsKAe2Bewwp3QMp9wzE5aASTtm853l8EnOwq0h
         H/z/tzs3i+Glr/YkJ8o9/mB9sX2A38vUI0cBGt14qT8IBaCbs2CI3qPvEslySwCXJFTR
         MH2Q==
X-Gm-Message-State: AOJu0Yy/US3hmV7/3Chzd1it2DwwrPoCBknoATDHqffF0L5ELJXCwcKE
        alZgVLu609pQSkjLsyPFJm4fC41BBJ84zlouI07dYxob
X-Google-Smtp-Source: AGHT+IEGpHh1NzX991InEpLtF7pOcdwzuSvr1QWRRwXJNIOyat/lq0w7rNP79EYq2WbCK9D/C52vJQ==
X-Received: by 2002:a2e:96c5:0:b0:2bf:df8c:4e56 with SMTP id d5-20020a2e96c5000000b002bfdf8c4e56mr6396882ljj.39.1695325612560;
        Thu, 21 Sep 2023 12:46:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f8-20020a2e6a08000000b002c0055834b3sm505958ljc.4.2023.09.21.12.46.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 12:46:51 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5043120ffbcso1421779e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 12:46:51 -0700 (PDT)
X-Received: by 2002:a05:6512:2013:b0:502:ffdf:b098 with SMTP id
 a19-20020a056512201300b00502ffdfb098mr4997773lfb.6.1695325611372; Thu, 21 Sep
 2023 12:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org> <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
In-Reply-To: <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Sep 2023 12:46:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDAqOs5TFuxxEOSST-5-LJJkAS5cEMrDu-pgiYsrjyNw@mail.gmail.com>
Message-ID: <CAHk-=wjDAqOs5TFuxxEOSST-5-LJJkAS5cEMrDu-pgiYsrjyNw@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Sept 2023 at 12:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And that's ok when we're talking about times that are kernel running
> times and we haev a couple of centuries to say "ok, we'll need to make
> it be a bigger type",

Note that the "couple of centuries" here is mostly the machine uptime,
not necessarily "we'll need to change the time in the year 2292".

Although we do also have "ktime_get_real()" which is encoding the
whole "nanoseconds since 1970". That *will* break in 2292.

Anyway, regardless, I am *not* suggesting that ktime_t would be useful
for filesystems, because of this issue.

I *do* suspect that we might consider a "tenth of a microsecond", though.

Resolution-wise, it's pretty much in the "system call time" order of
magnitude, and if we have Linux filesystems around in the year-31k,
I'll happily consider it to be a SEP thing at that point ("somebody
else's problem").

                  Linus
