Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2249136CC13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhD0UGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbhD0UGQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:06:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA675C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 13:05:32 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z13so14554231lft.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRcc/vr5Chj3M+4Hm2av7mbAqZ86imiIi9qoDwUZ/zU=;
        b=IRkv5P+hJ3HAvAVcYxfphR2IIalOpLukHJvNdIbyeYiLqB0zwJ4BoazBrHvbL7KeWQ
         YYkLIthfmcyOy+zftHPGy4a5Mdp6pRhBcLvLYvLaScIsMmWwXp0b3UxnZghldjA3FlIY
         iKXh7PqxoIO1WXdxmpi9PD3H48mfugN8DTiMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRcc/vr5Chj3M+4Hm2av7mbAqZ86imiIi9qoDwUZ/zU=;
        b=qbLTh5I5waAwE8JQQTKZrbYnwpRIubdvb0oBCcj5DHrdjdLJniKYWcmv5+YjPOtS8P
         GFOzUuIviE8FPlWve6CUeVsNwXVnWaq8eu0LZr1PzV3n9XGYuYFgCmxGFjARSLSb2Esk
         G2yr/G7boKf0B6Z5bNFSiHnKxpKwWXLWbK5evR9t4RtIZRL6248BN7NlzSpSZ9VZ2U8E
         eo1fD0SVI+yqzIf6w0IjQnq8VnKVM/LCNbMlm5K/bsIBUcXlXf8zUtas6vJWDuX6ye4d
         bZUahQ/5caEtmmvosX7PGFY4aEGoHp4thoyIWdhHdw8lh9mBANk+eanyeyGCTkg8e19p
         POUA==
X-Gm-Message-State: AOAM532PbtHHKneAUsQm+unPSbJV/3k2thWNvO8vArubs6mgmjPp/F7n
        EdYr5cFA5v/Bo6NXrWpMWd/kYi9KRV4EDQ01
X-Google-Smtp-Source: ABdhPJzNH0LkfAMqBaFHoQtkuNOSmknlRpErU5qVJeVwIPvXhV/H5WtZqF2LJvfjsSrEdEpU2tohug==
X-Received: by 2002:a19:48d7:: with SMTP id v206mr2850378lfa.629.1619553930804;
        Tue, 27 Apr 2021 13:05:30 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id s16sm646287ljd.91.2021.04.27.13.05.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 13:05:30 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 124so14522460lff.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 13:05:30 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr5016247lff.421.1619553929885;
 Tue, 27 Apr 2021 13:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210427025805.GD3122264@magnolia> <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
 <20210427195727.GA9661@lst.de>
In-Reply-To: <20210427195727.GA9661@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 13:05:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
Message-ID: <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I'm aware of %pD, but 4 components here are not enough.  People
> need to distinguish between xfstests runs and something real in
> the system for these somewhat scary sounding messages.

So how many _would_ be enough? IOW, what would make %pD work better
for this case?

Why are the xfstest messages so magically different from real cases
that they'd need to be separately distinguished, and that can't be
done with just the final path component?

If you think the message is somehow unique and the path is something
secure and identifiable, you're very confused. file_path() is in no
way more "secure" than using %pD4 would be, since if there's some
actual bad actor they can put newlines etc in the pathname, they can
do chroot() etc to make the path look anything they like.

So I seriously don't understand the thinking where you claim that "<n>
components are not enough". Please explain why that could ever be a
real issue.

             Linus
