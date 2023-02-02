Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBDB6877CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBBIrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBBIru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:47:50 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B983966;
        Thu,  2 Feb 2023 00:47:49 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id s76so518659vkb.9;
        Thu, 02 Feb 2023 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8jltGU5PEP/8zuh7YjjieGS71K/Iq1B/4kENnhMp90g=;
        b=AzFT25L7hRsKFB5cbJoScmALOFfvHoplZRE3HEy73xxi5iko5kUBqEcuUiObonr5z0
         Qy+eZN/PHgsOkRgvm2zaixZ/s5ddKQCuIYlUg8wLtpQ71trBoJ/ixO+F+Dj6Rlt12Tru
         MSTpMgFk9Q/0cwCNxG9Ka2TIwDrBDIr1yYtH7ybRvabUJhb+1zbTkDjVMMEr26MTnqG2
         SNJdGB63ZtP2fx0HGOuF9SIDDMnb3gSXZ+eYO7Y/kDPS8Q83IWJ/l9b5p4zugxcefM2u
         oSpobN59XK8TGPON1ewHV56phizkPEKXnPNIpxHYPRZsgh4K/z9SdjseRCryWDm96GLd
         j/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jltGU5PEP/8zuh7YjjieGS71K/Iq1B/4kENnhMp90g=;
        b=rDOSftCFDUdEVbM4eNoWhIK14sfB+5gqwWuFMecE6Yq5lcr1Le20odpV9k2RZKhTLC
         /zCsscVM062SdbG9OO7PjWCx74u4p+XDPE2nMEnXhnSXqnZQXgdnjXdaNsdIwiqxdLAi
         rRUG8utQZONq48JcQqr3HLwNCBTgUBDdP+B0Vrrhyf7EcXnLOllXP6x5yakwXHAHPLih
         hSqz+X7NvOtDhmc321goehIFMvC9jwqyxgF30ycITRVh1odoB1hbZLT0hJdlSCgPdZ56
         UEydWQvRkdjMgFBEmhAfJpVLFULTOfEn2+S0dQP/ZGMkQ+28I8ea73oKEV+yxDOPxatF
         PfzA==
X-Gm-Message-State: AO0yUKWmnhvm5GplI86lfFJawNlrLFanbftTVeUFM3w/OsAqvrteo5Oc
        5lX05nLmXWFiL5zV8c2pcqu9u1xz6kVMTsVouHI=
X-Google-Smtp-Source: AK7set+odum/96BXUSmaDqKIB8b2b6XGZoasbMzjviqoZJUN++OR+LZo1UWWufoG3tjaNTGS/dFVqhsmqzQhvfit9D4=
X-Received: by 2002:a1f:de47:0:b0:3e2:446a:18a6 with SMTP id
 v68-20020a1fde47000000b003e2446a18a6mr893548vkg.36.1675327668396; Thu, 02 Feb
 2023 00:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com> <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm>
In-Reply-To: <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 Feb 2023 10:47:36 +0200
Message-ID: <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:23 PM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 11/22/22 21:56, Daniel Rosenberg wrote:
> > I've been running the generic xfstests against it, with some
> > modifications to do things like mount/unmount the lower and upper fs
> > at once. Most of the failures I see there are related to missing
> > opcodes, like FUSE_SETLK, FUSE_GETLK, and FUSE_IOCTL. The main failure
> > I have been seeing is generic/126, which is happening due to some
> > additional checks we're doing in fuse_open_backing. I figured at some
> > point we'd add some tests into libfuse, and that sounds like a good
> > place to start.
>
>
> Here is a branch of xfstests that should work with fuse and should not
> run "rm -fr /" (we are going to give it more testing this week).
>
> https://github.com/hbirth/xfstests
>
>

Bernd, Daniel, Vivek,

Did you see LSFMMBPF 2023 CFP [1]?

Did you consider requesting an invitation?
I think it could be a good opportunity to sit in a room and discuss the
roadmap of "FUSE2" with all the developers involved.

I am on the program committee for the Filesystem track, and I encourage
you to request an invite if you are interested to attend and/or nominate
other developers that you think will be valuable for this discussion.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/Y9qBs82f94aV4%2F78@localhost.localdomain/
