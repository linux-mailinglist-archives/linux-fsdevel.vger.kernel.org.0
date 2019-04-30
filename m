Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C17FD16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfD3Pm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:42:59 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38089 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3Pm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:42:58 -0400
Received: by mail-ua1-f65.google.com with SMTP id t15so4919505uao.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxw3hN1YSm26ISg+LOrlcUFUk2/ynydw3TOb8ZPeF0s=;
        b=O/YPSKpdJNfI7U6oIOgur+JBh6lLTX26M/YLxxTMTTbCOdPzII6OA9QsPMywPziiVG
         zpbQJz5mB/J7NdHufCTiy3vXfHvVklhiXXTRr5MFYctmmoM/5ysemaK2nE9o2A82LpFE
         EkHyne5+Jcq6bx5DKtAGx12ur+JpsGrBj8JHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxw3hN1YSm26ISg+LOrlcUFUk2/ynydw3TOb8ZPeF0s=;
        b=uWURjRiix8EyUQtEtN4DEtsx3tM0uRZH2bmhcbfarscy4+L+0FGAI8ViVcKGz3GZv3
         pDMxiSQKCzvBeZxY4OZzXhGg7f8nQJ4zufEcOSMuOGEFZbPejbMRs+beZBi99PT0uDwK
         aBYPe66Wz1IWni+2A86VfEAX8W5njW82rUC1e/8hf5/A42Y2+Hqyu0O10D377KJEsi7t
         PdqkFuMwjJALv7WLEF3vb3GTh1BWZqkM/zjsj4zeqYbUJuad9rT7JwNh7biPezMJfNmL
         RXrBwqtLgedj/1Ph7SBX1hR7HtQxPXReGcP7WZJzBUMA/1vdzBv0atIpxXI29PkfH/41
         Calg==
X-Gm-Message-State: APjAAAVvzYuc5iqI77YpYsUinf5FqNqPLVZeHfNhSgvZswag9furFCW3
        yhsRTV6lfE9/mSce+I4HrtnSLJd6DQw=
X-Google-Smtp-Source: APXvYqzHIMJGTz8RPJbRZysq7Jh/vUEp+QXA/sFlhyinRaIP2D6aQNJ9Yd5MvgfyYzp9kythb4XMWg==
X-Received: by 2002:ab0:2a4a:: with SMTP id p10mr9703548uar.90.1556638977244;
        Tue, 30 Apr 2019 08:42:57 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id m23sm52259563vsl.24.2019.04.30.08.42.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:42:55 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id e207so3990536vsd.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 08:42:54 -0700 (PDT)
X-Received: by 2002:a67:eecb:: with SMTP id o11mr36496756vsp.66.1556638973924;
 Tue, 30 Apr 2019 08:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190429222613.13345-1-mcroce@redhat.com> <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
In-Reply-To: <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Apr 2019 08:42:42 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com>
Message-ID: <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 3:47 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > Add a const int array containing the most commonly used values,
> > some macros to refer more easily to the correct array member,
> > and use them instead of creating a local one for every object file.
> >
>
> Ok it seems that this simply can't be done, because there are at least
> two points where extra1,2 are set to a non const struct:
> in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
> while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
> and a struct net.

Why can't these be converted to const also? I don't see the pointer
changing anywhere. They're created in one place and never changed.

If it's only a couple places, it seems like it'd be nice to get these fixed.

-- 
Kees Cook
