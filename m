Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFED1694C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 03:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgBWCcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 21:32:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44884 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgBWCXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id 7so4291673lfz.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRiUMLVal6a47Pn0KiyPnBHZC0rhgcARtYIItZoVMts=;
        b=cONgu9fG5pE/tWCiXtgOF5ceYHdHZxNumSvYoyFsvLp9PS5M3fb0VPF5CuTOccSzER
         r2NpU2iSrvNXG0WR0NFnOm0HM9MXa0tN+yL++q7ziS1cy/uG5oeUPcx10pfWU/Hr0Ynu
         w3/+07uf8cXa3uKMy2VDDKuUVcP4LO3LE57ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRiUMLVal6a47Pn0KiyPnBHZC0rhgcARtYIItZoVMts=;
        b=GvdrbF+S9G1miGKbhyShoY5UITMQe9MNKwPf2sXzKfSPy9BrpbZeZgeCZKZRdajtDk
         yv6ZQQSY+4g+QGViDtMcEu9jyi5FmJ3e1Zk4FzPqf915CygeYGk+ZzlRb7gkvygbRifP
         rAiYXjmZrQfwItTivQGV0mqpaBuiw044AQ0C69FUx9/wlX+cTd46Lnx13l4ko0IRN7uU
         G9mG9MA7NCeu215p9uApUEMHFJRZSLteUXhXL7fMFugOjSRfrXl1yXE8IJS/CMYLVZxO
         1eidofEIzsNN0d2c4r/5lDhbl/t7uLypNanf9KEwTDp8IPh+tro203tbj7czhwPgDR8L
         AG2A==
X-Gm-Message-State: APjAAAX6bdHGlcB50NuX4WhW8QhQv4J9RrzoHIBzmU2HRxf624T/T0Es
        MkLq2ceyoP/JaIHQ+f0KkEctCufFhfI=
X-Google-Smtp-Source: APXvYqzG/xJPlI70GR1xJZTIlLaPmB8CHE/AEJhvmVXbaMFZ5j7Deqqp/f9pggHGziBo9TzyH/BUkQ==
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr4612887lfa.46.1582424580058;
        Sat, 22 Feb 2020 18:23:00 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c19sm3858850lfb.41.2020.02.22.18.22.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:22:59 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id c23so4305388lfi.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:22:59 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr23906945lfb.31.1582424578811;
 Sat, 22 Feb 2020 18:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-22-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-22-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:22:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQaqgkZiNX6+zG5kqOPWSiGKh6iis_n+Z0dfTBJeQLCg@mail.gmail.com>
Message-ID: <CAHk-=wiQaqgkZiNX6+zG5kqOPWSiGKh6iis_n+Z0dfTBJeQLCg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 22/34] merging pick_link() with get_link(), part 5
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ok, one step back:

On Sat, Feb 22, 2020 at 5:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +       if (err > 0)
> +               return get_link(nd);
> +       else
> +               return ERR_PTR(err);
>  }

.. and two steps forward, as you then entirely remove the code I just
complained about.

> -       err = step_into(nd, flags, dentry, inode, seq);
> -       if (!err)
> -               return NULL;
> -       else if (err > 0)
> -               return get_link(nd);
> -       else
> -               return ERR_PTR(err);
> +       return step_into(nd, flags, dentry, inode, seq);

I'm waiting with bated breath if the next patch will then remove the
new odd if-return-else thing. But I'm not going to peek, it's going to
be a surprise.

              Linus
