Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183B032A529
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443455AbhCBLrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbhCBJ4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:56:15 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B399C06178C
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 01:47:23 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id r25so22129629ljk.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 01:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kcgL94+L1tIXT1R8vfU9UzdbVrMKYIDLcHvPGal+1A=;
        b=SurN3sWHWBPKkLlGNZc6rYyjJtp8AA/I2oXOTORAolb7hFvo7bfaUhEMmYnvL9t/eV
         lX70eBcFbTYDzPxYJFrDwpr1iGSt7PkyTCRxzAkSHJR8OMWI5IkYUuKCCG2ZTlt0f2kO
         IRqX8Vh8c1GRXIZ4HZUGAXxuD7wo4pek3aQ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kcgL94+L1tIXT1R8vfU9UzdbVrMKYIDLcHvPGal+1A=;
        b=LGiRVUQ0HHNif43gseEBy1j9wE7StfyWGw8mtiH+FgH/9N0p1MiEX7lIqgrLUGeNqv
         pScPcoWkdT9peNpioJSxF0BLTch7weyWDiHylNCj2ygeOq2qXz9W6pE2PsBjppaZOTjv
         WJJj4ilHfuxyYVRQMrau22Krj8a2sKe1BiYA21f72rEfKa+CwYqXzZ0ggya+aBtewmWf
         JU00YPqYCIA8os+ZySVvAb/CNER/+WkVUTaKHoHaGIc+7p7j/rf7YCFGzrqDsA/6O6lg
         dLjcahsvb2pL2xQ2YBmLP0XV3GBx7efeo49Iat2IRR02wufQjNRpzGJPY3gPV6JbtMlR
         FqCQ==
X-Gm-Message-State: AOAM532fshdNVvw4qmlJAJ+sgxL+XsopYpBHYRnzwK6cxf744uFHrl7n
        aZTymO9r2P0M3yEKZ1xMVqmpjH93hFYH65YvcDSQcg==
X-Google-Smtp-Source: ABdhPJwg1ssQ28iX2I+mijjOyb6szTErEc2v03CrScKzyn9CA47P04+7k072VSz5R/vYT31LV7LexBEMXka7Q6QXIJg=
X-Received: by 2002:a05:651c:1318:: with SMTP id u24mr11838773lja.426.1614678441745;
 Tue, 02 Mar 2021 01:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20210210120425.53438-1-lmb@cloudflare.com> <20210210120425.53438-3-lmb@cloudflare.com>
 <20210301100420.slnjvzql6el4jlfj@wittgenstein>
In-Reply-To: <20210301100420.slnjvzql6el4jlfj@wittgenstein>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Mar 2021 09:47:10 +0000
Message-ID: <CACAyw9_P0o36edN9RiimJBQqBupMWwvq746+Mp1_a=YO3ctfgw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] nsfs: add an ioctl to discover the network
 namespace cookie
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 1 Mar 2021 at 10:04, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Hey Lorenz,
>
> Just to make sure: is it intentional that any user can retrieve the
> cookie associated with any network namespace, i.e. you don't require any
> form of permission checking in the owning user namespace of the network
> namespace?
>
> Christian

Hi Christian,

I've decided to drop the patch set for now, but that was my intention, yes. Is
there a downside I'm not aware of?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
