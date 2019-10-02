Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18833C8F21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 18:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfJBQ7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 12:59:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37752 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfJBQ7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:59:51 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so30505093iob.4;
        Wed, 02 Oct 2019 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edH88JJdhvk/m92MPK7nfCg4Dk9GmYl/C4LQHI6oVcg=;
        b=V4N2hGEp0d2Y39s7wVpn/Bk4EUviruUwYOflGFl1F9b8QascqJIKG49jxSvZaziNes
         cTF0rcV/QtekP7KHzbfAqN6glQunPtXZbBrtH6fK7fnxdq++jQk5E+NTlTBO4/LBqUjE
         NnqNcXZISZQPFkfdWGRzY5xOEtlgEtyKAm37qr8Yn0N+WzmwGTpnwORjMFznPZc682hG
         oMan9P6a/rKvuFONLlyBxzKC3qTigKG0YC7Rh0NJnla50L3Uzv+dzHQ7Z9Idr6TbvKd0
         VrVWtske+SzTOIiOtdYUcKFS3aOEZr2yjZ4NPOXlRGSVc5evScbtaEXW8f85mQpAt/TN
         XtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edH88JJdhvk/m92MPK7nfCg4Dk9GmYl/C4LQHI6oVcg=;
        b=Delca1bDpyx8EOeqRvVoVIxJ2Kp+y7d4HRTO7sHbHiJyfI2oQSCdFJxG0CPuh2xoEV
         gBke6+5N7WJUH+epD99PSAxOIaGNND2Q6o2IudUNf7++H17QybqFeh3QRlGLxTrMMDrw
         OmGYtikVkfnfu+hP+f0yizvQHe1TY35g31HsTOtVYfBluCbAwqv8CQsy5jf20yDX/jzZ
         EruxthZ2ThaXuMTH5gDaJcU31zK35uxtVMD0yqhvYgMfDv/OcSSzTCtVeuRN6x46y8bQ
         NYp7rJeoOWuF/rKwxTf/3hJd/bX5ZP8D/k7GX/hTwHPvFadlKrPS220RVr4nfgFRrPAD
         0+nw==
X-Gm-Message-State: APjAAAWuW6fCZnUIHl6EgHgCup+q2Zk9RsolW1MMGKE2Rdh7+/DmVHpq
        meuOtkdknPp9c+r4chjMLcdgCNphuXmZTPndZsE=
X-Google-Smtp-Source: APXvYqyTHRFovhUojBsEb0XHEq2pPC73Ho0l0/Gbp4i+D9nBP1s8h7A2c86r1V5mGH1264/hx7ZE9D4VBS1dqX8IETA=
X-Received: by 2002:a5e:8216:: with SMTP id l22mr1172841iom.252.1570035590957;
 Wed, 02 Oct 2019 09:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de> <20190930210114.6557-1-navid.emamdoost@gmail.com>
 <20191002092221.GJ2751@suse.cz>
In-Reply-To: <20191002092221.GJ2751@suse.cz>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Wed, 2 Oct 2019 11:59:40 -0500
Message-ID: <CAEkB2ERBSfAad=EChgH+X9vrPGjH8_sBvb2W9ur8n1Fnh_NuUg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: affs: fix a memory leak in affs_remount
To:     David Sterba <dsterba@suse.cz>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks David,

On Wed, Oct 2, 2019 at 4:22 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Sep 30, 2019 at 04:01:10PM -0500, Navid Emamdoost wrote:
> > In affs_remount if data is provided it is duplicated into new_opts.
> > The allocated memory for new_opts is only released if pare_options fail.
> > The release for new_opts is added.
>
> A variable that is allocated and freed without use should ring a bell to
> look closer at the code. There's a bit of history behind new_options,
> originally there was save/replace options on the VFS layer so the 'data'
> passed must not change (thus strdup), this got cleaned up in later
> patches. But not completely.
>
> There's no reason to do the strdup in cases where the filesystem does
> not need to reuse the 'data' again, because strsep would modify it
> directly.
>
> So new_opts should be removed.

I will send a new patch with the unused variable removed.


-- 
Navid.
