Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA4617B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2019 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfGGVR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 17:17:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35031 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfGGVR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 17:17:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so7135699ljh.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jul 2019 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khwRExgsrAxesDLfa+MBNv1Kv3bFqCQXDesV7F9LKao=;
        b=Ark+YhDSe2cjbYKXLWFRcC6Zg4N/GRkkzxT43m4iaIAuQN8NmmRJspuz1CcbY7cA3l
         kXIt4/Gaks4V/Ht5T9hR8BRUbU/TxYdtsEocgCSmUawCXES9+asmQ8/q7YB0i/U02/eW
         KOByO/j0JMeifjbX/2rrzc2QtpJKR98kzq/bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khwRExgsrAxesDLfa+MBNv1Kv3bFqCQXDesV7F9LKao=;
        b=FDSwSReJ0j3gnYFIpvwWolFOLXvyTZ9Ck/lsUsPp1dYQsQIj8h1+TyGX294qUBBEVo
         9lQQR0H59IG7GQMIX9JFb6Ti7MVFv/UDcMx8IN/At98LA2oO2uoFtzsDhQboASVb0+0k
         AOd23qa+PYMA9IoV4s1nGWes6yAWaM1SNwkK+D+AbJk6oQuWuRGsv6q2vZFuEjBKrHAQ
         riIQbVP9AuRQWaNFAkrGuiOSPRYq3HYBGNGiQ8YoBTxWAuT7+wNQaZh7qT505NyvoDUt
         Uc+lVNWsa5w33irCx0YWgMbbrzFPvJw50cupBjvssz4sFRkN2+XrlmExkSmZNCmojQlZ
         R7pA==
X-Gm-Message-State: APjAAAUEGNNN7noxc1RDZ+58ABnkFvJ55HTdnfcJi3YhVJEKspO4Xddw
        WuAuSV/H8FbQZCXsSOgJL1OWviYzwfE=
X-Google-Smtp-Source: APXvYqzMPqNC6bbNq1f8JH6Smy0YQiHVjV8kBDaS+STC3v/al6DHzYF9z3BOraBy9ROyrXWO4yVT7A==
X-Received: by 2002:a2e:9a19:: with SMTP id o25mr8305018lji.63.1562534275011;
        Sun, 07 Jul 2019 14:17:55 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b9sm3204289ljj.92.2019.07.07.14.17.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 14:17:54 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c9so7751783lfh.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jul 2019 14:17:54 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr6182613lfb.29.1562534273929;
 Sun, 07 Jul 2019 14:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190706001612.GM17978@ZenIV.linux.org.uk> <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
 <20190706002236.26113-4-viro@ZenIV.linux.org.uk>
In-Reply-To: <20190706002236.26113-4-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jul 2019 14:17:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgB5NN=N9Z4Y26CTSr1EchMfXbuFvVU4rcKaNca9qVkiA@mail.gmail.com>
Message-ID: <CAHk-=wgB5NN=N9Z4Y26CTSr1EchMfXbuFvVU4rcKaNca9qVkiA@mail.gmail.com>
Subject: Re: [PATCH 4/6] make struct mountpoint bear the dentry reference to
 mountpoint, not struct mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 5, 2019 at 5:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
> +static LIST_HEAD(ex_mountpoints);

What protects the ex_mountpoints list?

It looks like it's the mount_lock, but why isn't that documented?

It sure isn't namespace_sem from the comment above.

                  Linus
