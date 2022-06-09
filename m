Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25D4544081
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 02:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiFIAWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 20:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiFIAWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:22:13 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E1F1116EA
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 17:22:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31336535373so74953187b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 17:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAASEe2qSVRx5v90LFy0O2abfHE0hmvo9XEQ+358lUE=;
        b=kwE/erjvbftBlQmQ/NLaQvC4qULKGZs0BrQFNg9Sfc+RjEnOOW7vJ5CxpERfsW0PY7
         xB4S40cgclJVrsiGce/PIiddCW5JpeN7ycvsii7sw1il49TOPGxthiRnfrWZqcbA3Fya
         IDu2PoBN2rbucDmMMQAp0Mtb4nlf9pwTBAj64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAASEe2qSVRx5v90LFy0O2abfHE0hmvo9XEQ+358lUE=;
        b=Kx3g5wnss73x8EhDVYUgO9fS1y3WCHzqsS2YzyJ3HNyEVGcI2DPBaRavsv37Gxz93h
         auLY6SDlZCo04OP+puRHH3tTj0Cb2WL5yUeywwIikd1t/+EAEa1ndCbRnATgGaC1qIYR
         CU4UpFOFoV24BXHiDlOgB1kMoF9kMCJmUItggSf6SxeBphjPWqKNAKUfnxcAQOT6ecjT
         OXcmuT6ZCtWcjkFhwR+4jsMOmsRNJyoY/7nvqE/VpYovyDRnvX8VIJ6l0talcEhp8l70
         3wpm0I56FRzgwidLCcYSSdQbBfxiuExoRpsdTBUqhtVNKTxoZgKznDMdwrfEFFrdJimK
         ynWg==
X-Gm-Message-State: AOAM533FuQkqTfjgZCT6iw0lsOKeGWyXHXoUaBQrYrFBkvvtYOqJgHCU
        LBC6BtQIJhMPdE2kTz90uuXyd8ccumx9jpS+73FWXg==
X-Google-Smtp-Source: ABdhPJxSq6eknAUuCjgJOBPmooxCXhCn9/o0F90u2gDHYkcU69KroNgXnGX9PlANl/ZQ6HFzIugNllXb74KORnf5gCc=
X-Received: by 2002:a81:9206:0:b0:30c:2dfc:e9e with SMTP id
 j6-20020a819206000000b0030c2dfc0e9emr38539273ywg.296.1654734132539; Wed, 08
 Jun 2022 17:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220601011103.12681-1-dlunev@google.com>
In-Reply-To: <20220601011103.12681-1-dlunev@google.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Thu, 9 Jun 2022 10:22:01 +1000
Message-ID: <CAONX=-ck0kfSpZhu8vBstmen1U++rzn0_HcntiWAWKE8FP+1UA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Prevent re-use of FUSE superblock after force unmount
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Daniil Lunev <dlunev@google.com>,
        linux-fsdevel@vger.kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos and Alexander,
Do you have any more concerns or comments regarding the patchset or do
you think we can proceed with it?
--Daniil

On Wed, Jun 1, 2022 at 11:11 AM Daniil Lunev <dlunev@chromium.org> wrote:
>
> Force unmount of fuse severes the connection between FUSE driver and its
> userspace counterpart. However, open file handles will prevent the
> superblock from being reclaimed. An attempt to remount the filesystem at
> the same endpoint will try re-using the superblock, if still present.
> Since the superblock re-use path doesn't go through the fs-specific
> superblock setup code, its state in FUSE case is already disfunctional,
> and that will prevent the mount from succeeding.
>
> Changes in v4:
> - Simplify condition according to Christoph Hellwig's comments.
>
> Changes in v3:
> - Back to state tracking from v1
> - Use s_iflag to mark superblocked ignored
> - Only unregister private bdi in retire, without freeing
>
> Changes in v2:
> - Remove super from list of superblocks instead of using a flag
>
> Daniil Lunev (2):
>   fs/super: function to prevent super re-use
>   FUSE: Retire superblock on force unmount
>
>  fs/fuse/inode.c    |  7 +++++--
>  fs/super.c         | 28 ++++++++++++++++++++++++++--
>  include/linux/fs.h |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> --
> 2.31.0
>
