Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CD0522F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiEKJkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiEKJig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 05:38:36 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879D549C91
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 02:37:23 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m190so2896171ybf.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7qdb1hLqH5S/Qijzmj6Il1EkPWwe2L7oUVkXG05Znc=;
        b=dJOWwBZVi7xQ3DLFYimxYV6NWUkjRtnDp21YC96glDvJ7XtbuAr6oQBhLY6kKOcB1o
         93nhch2e5dIYHSHu4m2eXJF5vve5qNg+cEsEvIZnd2DvGRWv3WRpaGNNAqH46jgXjfxr
         3w6cXuxClKtZZDHqrskiHW8HwkPVpJvSgaf/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7qdb1hLqH5S/Qijzmj6Il1EkPWwe2L7oUVkXG05Znc=;
        b=pHZErVsJXec6MHcNoR/1erC87CzcLFU2gMIgbA1jY5fDVId74jCD/fvPnkWzmR5VHN
         6vBa5i1SoK8GuJGGkw5Ubqf4vMcCMPhrtNxvoR83oOBGG3ZGhXZRXjArHgARRlWCc9S2
         xzrBqWEwcBFIFmvrC8bTvpLp3YG2BaEeIFcIGY8ZDbQxl+pEogAYKYPKRkSnZCpjxsIH
         1XB3OzJDrIDwdQNdbB79bPx1ND1adTzsGVagFEtRJjICXVHyOeJIxxuzHndnGXfy8FjF
         p8MPZ4QOCZmpA9uXUofXW1VUCTz++qh5ET0S2dcpEIvFKUxaCk16nNhEa7FfrpT3nGyX
         /8yw==
X-Gm-Message-State: AOAM532WktmDuG8qvvh/VkYNFDQAGTtV7Oyw8vreA39RDlREG8JKH/11
        yIMH1c84nAGzYXjmNPdvE+0dEe2+F/BpJO1jK3dP6CUE5hg=
X-Google-Smtp-Source: ABdhPJx+rswrjLDO8mmFJlrYKb01zVPGHK7SBm118TyWvbFUgfQzKgZC8gEp79UUSYh48Im8RzQ+SCSNDCQpXLSz9rc=
X-Received: by 2002:a5b:44e:0:b0:64a:c0be:c59c with SMTP id
 s14-20020a5b044e000000b0064ac0bec59cmr15610827ybp.573.1652261841760; Wed, 11
 May 2022 02:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com> <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
In-Reply-To: <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 11 May 2022 19:37:11 +1000
Message-ID: <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> No progress has been made in the past decade with regard to suspend.
> I mainly put that down to lack of interest.
>
That is unfortunate.

> It is a legitimate operation, but one that is not guaranteed to leave
> the system in a clean state.
Sure, I don't think I can argue about it. The current behaviour is a problem,
however, since there is no other way to ensure the system can suspend
reliably but force unmount - we try normal unmount first and proceed with
force if that fails. Do you think that the approach proposed in this patchset
is a reasonable path to mitigate the issue?

Thanks,
Daniil
