Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64BC2D46A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 17:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbgLIQVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 11:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731901AbgLIQVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:21:35 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01E0C06179C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 08:20:54 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id h6so1185308vsr.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftrjIMacRnCDUW60B5wDdWIgLtC6j6ITMAxZ0z4dcsk=;
        b=HgrvSW72NUDBACx2rcJOdsk9j2ywqmTiRhxzfml2ObmeS9/p68ApjmmEUiVuFFixel
         U8V/3sWV/jT/RnYtuN76/jqqa0beH35lqx0GkOdrSQB8kmGRwv6xH/mpxgBW9stqYh98
         TB1KeZ8zKUBTeHyC8I0eCxJ7EFkcfOUQYVVWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftrjIMacRnCDUW60B5wDdWIgLtC6j6ITMAxZ0z4dcsk=;
        b=r9mp2hgpR28lsLisayV6GujSGmxccdT1d5MlO8IThWdnFmw9g0exRk6Y0IEnnQQ134
         rtXyODOiajDpl9yOyI4ypNMeHj7ow5miney80Eb+QWEeGctqaGfnXIBil3Vt5BlHnJmY
         s6yDxYP/0NSJTlcO4ev4mOf468F8PybK8Hdz6si/OvHW990byuI7q6JBeq3lQaeswPGk
         OS0s0yIf2r2JI/6+9K6e8rjIOmQOLdIlv3ho9Xw0g4kiFVoLcxz0dmL8jBds1CmHoRVG
         ltKSsRrfXCtp1kDEmrYlTZ1rb1SmCDQO1YhwemhbWHKBPS/8P0Ai9edRMaCz+zdQ27Is
         JlHA==
X-Gm-Message-State: AOAM533V77t+3Wc7hMiDJrvoUb/9wocwIVCcso4geclx+3FmGNVzNPB4
        Q+4JXQb73Zm+ihbPm7xELh04SJ/+6chzIjwDcDdhxQ==
X-Google-Smtp-Source: ABdhPJzZZ3IkQz7rOL8NyykGCELcBs/amTcJ+Xv2OgUQT+RVIeDoKVuHGvs38tWdvxSIhPXmjhSG0BuRFZBayhnap/U=
X-Received: by 2002:a67:ed57:: with SMTP id m23mr2755029vsp.7.1607530854236;
 Wed, 09 Dec 2020 08:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-4-mszeredi@redhat.com>
 <CAOQ4uxhti+COYB3GhfMcPFwpfBRYQvr98oCO9wwS029W5e0A5g@mail.gmail.com> <CAJfpegsGpS=cym2NpnS6H-uMyLMKdbLpE1QxiDz4GQU1s-dYfg@mail.gmail.com>
In-Reply-To: <CAJfpegsGpS=cym2NpnS6H-uMyLMKdbLpE1QxiDz4GQU1s-dYfg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 9 Dec 2020 17:20:43 +0100
Message-ID: <CAJfpeguvt-Mia9YmT55q3R9tSFocpgq7FzjDKJgnaOEQsaBNVA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ovl: check privs before decoding file handle
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 11:13 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> Hard link indexing should work without fh decoding, since it is only
> encoding the file handle to search for the index entry, and encoding
> is not privileged.

Tested this a bit and while hard link indexing does work,  inode
lookup is broken since it uses the origin inode as a key (which is not
available) instead of using the origin value directly.  This is
fixable, but needs a fair amount of restructuring, so let's just
postpone this and disable index for now, as you suggested.

Thanks,
Miklos
