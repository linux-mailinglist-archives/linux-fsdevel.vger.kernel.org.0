Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4281916930D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 03:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgBWCIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 21:08:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33764 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBWCH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:07:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so4318279lfl.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4EpyKP0B16qUqyv0D0u0i1KANfiNDemnRfXEOMQZ8w=;
        b=D59j+IUyZoIzeC5uolMmJmJpCNfBDS5i850QEQva1gY5p/iyqk4L8l/OnaOXmzo8MV
         drvUkV5r7JXptxn8mU7gALV8/72ndjyNibKEkb702NJ78lZz9nygv9ROLBKItoBoM9+h
         BPt8ag3da2zcoarpcsJrURNdbl7jazzqgrIaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4EpyKP0B16qUqyv0D0u0i1KANfiNDemnRfXEOMQZ8w=;
        b=aV9sgGV27XfoWd9Cf1PZch2I/oB6GaqPBZ3hrH2z6YlbZrNuCbOZCDLernOsL/oi6r
         C7szOEoTfGGRZNz5MMtCW8/a7CiJTARxQGvi1z2F+iKcXDx6elkeTU4NTFaQ1OyxYEce
         L3eXRPLXptxFN6+GdOKqVUdekH9ZZnLRhLgcRh3Bf9cBeP6Pz6RKK0KtVHHy1EvGptri
         8o1EPMMJP0iy4gQ/JLhqNJONlnp4sMB75SnO/FDaqrPQ+Uji+x3hGbUU+yK1e0bx3bgS
         5v5xfImnr+R26cV3/sSkzC0MCH3mD9CYQQ/qN0Ijrt+qazL289L3nAuD60lZKqXGaXyN
         Ozqg==
X-Gm-Message-State: APjAAAWiYyjFX5RU1nSM/AL2Foe5mqc7eWSSMFhC+cAs6i9Rr8NRn3jJ
        Z+Keu4vPriKqVoKIwZ+METZnoqvdbHw=
X-Google-Smtp-Source: APXvYqx9sc5yiwi6aP/LCMlSH4RfiDTLOMAJvmlA1IqzqpFIn3etNfwRLg6xu+qxC0lpaa6BMu9WEQ==
X-Received: by 2002:a19:4013:: with SMTP id n19mr12547044lfa.2.1582423677331;
        Sat, 22 Feb 2020 18:07:57 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v16sm3749141lfp.92.2020.02.22.18.07.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:07:56 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id a13so6189224ljm.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:07:55 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr25338680ljg.209.1582423675207;
 Sat, 22 Feb 2020 18:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-2-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-2-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:07:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjE0ey=qg2-5+OHg4kVub4x3XLnatcZj5KfU03dd8kZ0A@mail.gmail.com>
Message-ID: <CAHk-=wjE0ey=qg2-5+OHg4kVub4x3XLnatcZj5KfU03dd8kZ0A@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 02/34] fix automount/automount race properly
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 5:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +
> +discard2:
> +       namespace_unlock();
> +discard1:
> +       inode_unlock(dentry->d_inode);
> +discard:
>         /* remove m from any expiration list it may be on */

Would you mind re-naming those labels?

I realize that the numbering may help show that the error handling is
done in the reverse order, but I bet that a nice name could so that
too.

              Linus
