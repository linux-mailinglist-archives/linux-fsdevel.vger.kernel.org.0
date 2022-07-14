Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F635757C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 00:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiGNWmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 18:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbiGNWmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:42:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6AE72ED1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 15:42:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r18so4182471edb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5sSb7FMUXCpjX4/hZvMEr2YHWxUXG0ORXDEw5fsmq2g=;
        b=XG1Fnf66BV1lMKXzEvyAAuTzhIDX6Ps36Kj86OdwLgd5MPJ4zV96P++4DcmX2SvAZK
         8hnDN0V8caqO+yR1WpzaGwvpW6HKKw0puhXnO+YDgk2L5MF7HHLgWj9eQhxpvKWlNwMJ
         hVd2vbmGv9YLGtbWrrFzIUwDePCjY1xOhjVxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sSb7FMUXCpjX4/hZvMEr2YHWxUXG0ORXDEw5fsmq2g=;
        b=5NfGzk77FEio28oACE5RlMcGuX7JSMG6xQrH1Etu+TA7FGhX7zMCY2egY1MAxpc3xm
         tm6+knYGI6ZvmnrvnEXOGWWUCDQ6mPlWsOzA0QE7PMPsWgG+PAudJ8dSMyal+58QzFJD
         dCF3/jk3ogdE1p0JoLt97cps6xvmMpDR2kUag+5Q999C+qbqnWygmFDANw2g3G3ga2Jj
         pAA7u1xUy0YE3FXpswfysWLzrNb9zUarivqwKXU575ttSHK8L2ISQixw5oXAUEz7g4Up
         baGfP6tXfa1LU9wf2ZUXiOGXwWuAmbWz0JQHUknzrdkzOoqQHf4c/jbDKTnfe9fS6DNG
         TmVg==
X-Gm-Message-State: AJIora+9djtgdB6zI/a1AjW31Thtqc857ONkywUaBjfBiw1zOgIDqp1s
        O2lLQNV0rtjLkS8aMu79VY9tHMudYf0s0KcbmrE=
X-Google-Smtp-Source: AGRyM1vYF0NoeF/qHUZIk7nSQ2oPL6ZKDMo0ApGYNQmpPGXVaNP3Fk5BLy9GgOBH8/FV2gUwOBF7fA==
X-Received: by 2002:a05:6402:5388:b0:435:71b:5d44 with SMTP id ew8-20020a056402538800b00435071b5d44mr14658741edb.364.1657838552453;
        Thu, 14 Jul 2022 15:42:32 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709066b0800b006fed062c68esm1207463ejr.182.2022.07.14.15.42.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 15:42:30 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id b6so1343805wmq.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 15:42:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:3a2:e9bd:fcd9 with SMTP id
 g9-20020a05600c4ec900b003a2e9bdfcd9mr17799100wmq.154.1657838549348; Thu, 14
 Jul 2022 15:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia> <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area> <20220713074915.GD3600936@dread.disaster.area>
 <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de> <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
 <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de> <20220714223238.GH3600936@dread.disaster.area>
In-Reply-To: <20220714223238.GH3600936@dread.disaster.area>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 14 Jul 2022 15:42:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1TEGEAhj-obgjhMzDNaSxipZsdAUNS6dApt=OxktZAQ@mail.gmail.com>
Message-ID: <CAHk-=wh1TEGEAhj-obgjhMzDNaSxipZsdAUNS6dApt=OxktZAQ@mail.gmail.com>
Subject: Re: [PATCH] vf/remap: return the amount of bytes actually deduplicated
To:     Dave Chinner <david@fromorbit.com>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 14, 2022 at 3:32 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Linus, can you please revert this commit for the 5.19 series (before
> the stable autosel bot sends it back to stable kernels, please!) to
> give us more time to investigate and consider the impact of the the
> API change on userspace applications before we commit to changing
> the API.

Done.

That said, even from the fastest output, I have to say that the new
behavior looks like the right one, and the old one just returned a
fantasy that didn't actually match what the dedupe operation actually
*did*.

But leaving this for later is not a problem.

                   Linus
