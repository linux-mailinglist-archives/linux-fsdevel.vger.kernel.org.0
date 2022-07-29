Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9F584A10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 05:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiG2DIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 23:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiG2DIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515EF7B78A;
        Thu, 28 Jul 2022 20:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E002F61E05;
        Fri, 29 Jul 2022 03:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4866CC43470;
        Fri, 29 Jul 2022 03:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659064127;
        bh=5OsBdiEjYx6egc32iX+tiEv1xN1iIy+h3EehGYoPG+E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=o90jwd0zX0Zzph/GS+Vkq5WAkYOp8XJ154Fde8nhm6HPrW2N6qpbuQ45941UdDQVI
         j0Pj5+Ua9mH3fJfOHamGHPi83XlEmnoCUU4uq6nKpiR1xZpz9qsXYHkA06G6VNLet8
         AWK8J78gr5I4Js4ytObDDt+UpPN1km8emx2+7kvP0zcLb2RnHs6tBP6eoOL0NBD2r5
         GCfUQJfXMoOM99FdBf6L35Sf3bubeCr0zq/fTUXl/f7uT2wlWUqZpsxT2SmiYbThOI
         WsRWdYbgzHEZuEaK01F5UgNfgYJVsOV+FCdw4ulMRqPUMlbFQvurD0EiKrs2o5+j9R
         dpMgfvH/uNZ1g==
Received: by mail-oi1-f174.google.com with SMTP id c185so4526281oia.7;
        Thu, 28 Jul 2022 20:08:47 -0700 (PDT)
X-Gm-Message-State: AJIora+mTFhkypgwBcPpwleImRn5+CuhFs1jtU55wUxRofFi6XVLWd7m
        426atc93IbrN0qCDAPn8+PwMUtfZr/o9Tk76ths=
X-Google-Smtp-Source: AGRyM1si0r1HZlCPHgEcoqcmDfNjLOpSJLEuoT9j3YrdNg36VqRRnxsa/Ok/akRf0wWxOkN78wRMd69vZV+s+Orn//4=
X-Received: by 2002:a05:6808:1b20:b0:33a:b9ab:30d8 with SMTP id
 bx32-20020a0568081b2000b0033ab9ab30d8mr1096213oib.8.1659064126395; Thu, 28
 Jul 2022 20:08:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6839:41a4:0:0:0:0 with HTTP; Thu, 28 Jul 2022 20:08:45
 -0700 (PDT)
In-Reply-To: <20220726083929.1684-1-tiwai@suse.de>
References: <20220726083929.1684-1-tiwai@suse.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 29 Jul 2022 12:08:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9dtCeFBb_-2g0GGwV6umwK4riWhpctvfXY7gpY1OO5pA@mail.gmail.com>
Message-ID: <CAKYAXd9dtCeFBb_-2g0GGwV6umwK4riWhpctvfXY7gpY1OO5pA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] exfat: Fixes for ENAMETOOLONG error handling
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Petr Vorel <pvorel@suse.cz>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-07-26 17:39 GMT+09:00, Takashi Iwai <tiwai@suse.de>:
> Hi,
>
> this is a revised series for fixing the error code of rename syscall
> as well as cleanup / suppress the superfluous error messages.
>
> As an LTP test case reported, exfat returns the inconsistent error
> code for the case of renaming oversized file names:
>   https://bugzilla.suse.com/show_bug.cgi?id=1201725
> The first patch fixes this inconsistency.
>
> The second patch is just for correcting the definitions as bit flags,
> and the remaining two patches are for suppressing the error message
> that can be triggered too easily to debug messages.
Applied, Thanks for your work!
>
>
> thanks,
>
> Takashi
>
> ===
>
> v1: https://lore.kernel.org/r/20220722142916.29435-1-tiwai@suse.de
>
> v1->v2:
> * Expand to pr_*() directly in exfat_*() macros
> * Add a patch to drop superfluous newlines in error messages
>
> ===
>
> Takashi Iwai (5):
>   exfat: Return ENAMETOOLONG consistently for oversized paths
>   exfat: Define NLS_NAME_* as bit flags explicitly
>   exfat: Expand exfat_err() and co directly to pr_*() macro
>   exfat: Downgrade ENAMETOOLONG error message to debug messages
>   exfat: Drop superfluous new line for error messages
>
>  fs/exfat/exfat_fs.h | 18 ++++++++++--------
>  fs/exfat/fatent.c   |  2 +-
>  fs/exfat/misc.c     | 17 -----------------
>  fs/exfat/namei.c    |  2 +-
>  fs/exfat/nls.c      |  4 ++--
>  fs/exfat/super.c    |  4 ++--
>  6 files changed, 16 insertions(+), 31 deletions(-)
>
> --
> 2.35.3
>
>
