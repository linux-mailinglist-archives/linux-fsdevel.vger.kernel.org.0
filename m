Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E590169418
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 03:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgBWCYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 21:24:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38420 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgBWCYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so4306440lfm.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqfK9IxNwj7ckP+MpJmSceONpcVbgVpUow9PPlLP6iA=;
        b=IIfqKj2QdGhRadPaahvLYJUZd7WA2qCg1z6Q8cD1LMlvinW50KHFPhR9fFz/XyCE/k
         aB8JOGB9Flmf8exB5hf8IBB2QSftwDTwA+9g9UU6QgopoPRzetdU1Xp1ZpE+Z3rg3FoT
         y7h9slhbD53JXZysr17OqV0jFNfxzoQdI+4g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqfK9IxNwj7ckP+MpJmSceONpcVbgVpUow9PPlLP6iA=;
        b=VSqHyTAaP5qIGlH/+oVZRrFkDxbEHrdXsgSFbGt5bfySDMM/GLN1yRDOMRYa1XfL86
         13obF8kEhDMURUk/sDzNKk6tHUkCHaoqMLrgzPmXjSKmykb1vq5tc45an4a5/w0seI5X
         3ssIK4/a+e6BMm0XrBUr4ZzaIOeVILQz8YFwkmnpS1jrYbWlpl5l8cML3F5dwx3bYjls
         0YbQrnwxv4v4CadBjqppzYmO8YV/nsWcTheYdKTnSfQbvQUns4BvKgrAV5rv7LOJG7a/
         CmqNRSZBVBhUAR/BH3j63Q7Y5tb5jqtjPIT/L4DvMYm4W7M1AHkPdvprD+XAxY3rneva
         MtLw==
X-Gm-Message-State: APjAAAVs8eUERuG1IIOQXChJF+XfqRAaKJ9ya9vqtT5cxK3ipBjM71nl
        VUrH+MXrk/miQJkqxYAPIktDdMEtlsA=
X-Google-Smtp-Source: APXvYqwBUf9w8nKZoSaEiI1pAxylbYXhGaJV9QPTesE89zQAQpwwhm9Q6mwKCBnvMZ4BY4fIYvbSSg==
X-Received: by 2002:a19:dc14:: with SMTP id t20mr23577013lfg.47.1582424657552;
        Sat, 22 Feb 2020 18:24:17 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id t21sm3957270ljh.14.2020.02.22.18.24.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:24:16 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id q8so6208177ljj.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:24:16 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr26665961ljb.150.1582424656256;
 Sat, 22 Feb 2020 18:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-23-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-23-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:24:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiD_410q9aBfQN44a3pPYrxjqa6OfFf=5ZCr=rCWgTt3A@mail.gmail.com>
Message-ID: <CAHk-=wiD_410q9aBfQN44a3pPYrxjqa6OfFf=5ZCr=rCWgTt3A@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 23/34] merging pick_link() with get_link(), part 6
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 5:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -       err = pick_link(nd, &path, inode, seq);
> -       if (err > 0)
> -               return get_link(nd);
> -       else
> -               return ERR_PTR(err);
> +       return pick_link(nd, &path, inode, seq);

Yay! It's like Christmas.

Except honestly, I think I'd have been happier if the intermediate
points didn't have that odd syntax in them. Even if it then gets
removed in the end.

               Linus
