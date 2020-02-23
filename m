Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB03A1694A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 03:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgBWCbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 21:31:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41816 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgBWCbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:31:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so6234352ljc.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lv+/zskqFVdIq9wYZU4Gj6+TZNyU98SMKPYNicpHw4g=;
        b=PdzKp2iGm64BKP+6/6oZhsfTC0LquC9kExy0BphI8KeK0rEElaWmw6ds7noalV8Q5V
         0+UHb2/Y5DN+HwP48Fr362DHpaGN35gYNg1QtVPfHYYSgcKmgPYEJSUsLdwOezgHJwYm
         rbzVeBYbSzQqV+vTo3/JMPpkQRk/AZOMYdEOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lv+/zskqFVdIq9wYZU4Gj6+TZNyU98SMKPYNicpHw4g=;
        b=XGcpnCyJfjclDdHvQ9p8S2SJCxP63KR+sOxhAaTtvEtAb5mWVLpq7OqwiH+wN4JAqM
         7w9hG/VX3IZFX4TYUe+O2Q7Y86ESYK4GWw4Rdr764LNucj3D1SO3C97SitXqrkhgoCy1
         U+60rYXTA+dIJCKGHL91C4U1HtlcDEBaXP/lybBHwdU5xEXfF7csS4U+skUW/TOUJIYU
         nUUU/T2Aj/mXWOAICwrZvlmanVeUEs8VCfatTDJhwNWqNWUHFvEz7kLfqBbaPImfSmfD
         t5C2YMg7/ymcjsoqXg3bkCssVdrJS3Y9vEH+UqYRw4e4rnC1UQy/IvnbAHNm2mVw8WU5
         BMgg==
X-Gm-Message-State: APjAAAWHxWOrXPgfhy/Z7SN+I1qPrvYDm+J9jRzNxAi00TIdz/m7P28H
        Yct9Ar6hNfQwS2C+Ymhk7LzH1P8ejC4=
X-Google-Smtp-Source: APXvYqz3jN/D5UJk6YRaPwt+yRjlHYNuZpwVVNzCerWEdfjrlkKnnXFhRJtpw37P6+ps+ZlGQmjYMQ==
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr24786579ljk.30.1582425107055;
        Sat, 22 Feb 2020 18:31:47 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id e20sm3995144ljl.59.2020.02.22.18.31.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:31:46 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id n25so4336266lfl.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 18:31:45 -0800 (PST)
X-Received: by 2002:ac2:490e:: with SMTP id n14mr9091492lfi.142.1582425105432;
 Sat, 22 Feb 2020 18:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-24-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-24-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:31:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJaHi2wzcJ8KBEtm3r_a2OVXHEvPnXMb_WCqA1cU3eGg@mail.gmail.com>
Message-ID: <CAHk-=wiJaHi2wzcJ8KBEtm3r_a2OVXHEvPnXMb_WCqA1cU3eGg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 24/34] finally fold get_link() into pick_link()
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
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> kill nd->link_inode, while we are at it

I like that part, but that pick_link() function is now the function from hell.

It's now something like a hundred lines of fairly dense code, isn't it?

Oh well. Maybe it's easier to follow since it's straight-line. So this
is more of an observation than a complaint.

             Linus
