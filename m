Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB57495DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 01:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfFQXaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 19:30:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44633 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfFQXaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:30:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so11019671ljc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSlnrikhmcgad5C0n4qp/v4MF0qr179vLd3WTKmDTCM=;
        b=BxpvYJ+agSNLwq4y9NHDYqRZrmep21oIT9drwkiIH2vfs5ZeeuU6IKHLuxX9G306a4
         4mMlrj/9OewJMlCd2mOEFWBGl+lmtDoa19iHj8blbUjKhIUwxNFWEzt6rRvmSEdNkivr
         WGZut+frZ7Ro5jVpYWitT+690GF3d6LM1mkuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSlnrikhmcgad5C0n4qp/v4MF0qr179vLd3WTKmDTCM=;
        b=C60nx2M2T7LTetNJXHj6/F2Ti4lQ8gZzHuXUX7+qfLO1lZdS0iswuogDExd6KhE+Wo
         nl/nWsng9JHuWEGLPZCKUaUC9U6WBWVrGp8z9uHIbaR7as61VkAnIA/mdrAF/aZGsybG
         BNo7ZnDRDJShzlUdcypt69fIYkZbYh45nNsOKuKXNL646LmN78qS4+ZWl9tn6e6qomRS
         xVN9/tKOAbmGXXcIdPGfaqOnCPsnwESu3LA3qBU/LXHCEUrt1DHlinHcU6lCuoIJbsYb
         Dlkd9AHr+nFNKWkFD4Aec6E9/Kctt9+S3TdCRvJAELmwsxeYXPmhbqZgsQtSgQQwmzw8
         /dNA==
X-Gm-Message-State: APjAAAV4UEhYNTPKkvPiENHDAmkb7Aq/LVv76Ha4SYkGZF+KlBAd+OvO
        HFYjpoRwOHJaJV7UT2MZOmF3L6qvh4Y=
X-Google-Smtp-Source: APXvYqxG1YxpwbzRyOuOGmNrd7T/XNCa7QKw3/uP1/ozgNYU7iNYEF269QpBFm4oj7bObBWkEAqKog==
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr18197463ljj.156.1560814211439;
        Mon, 17 Jun 2019 16:30:11 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m24sm1933902lfl.41.2019.06.17.16.30.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 16:30:10 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id p24so7822642lfo.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 16:30:10 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr544968lfm.170.1560814210085;
 Mon, 17 Jun 2019 16:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190617212214.29868-1-christian@brauner.io> <20190617213211.GV17978@ZenIV.linux.org.uk>
In-Reply-To: <20190617213211.GV17978@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 16:29:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvURjNyBUx_V7z3ukSeHN6A5jbQF5c53X40undQy8v9w@mail.gmail.com>
Message-ID: <CAHk-=whvURjNyBUx_V7z3ukSeHN6A5jbQF5c53X40undQy8v9w@mail.gmail.com>
Subject: Re: [PATCH v1] fs/namespace: fix unprivileged mount propagation
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 2:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Applied.  Linus, if you want to apply it directly, feel free to add my
> Acked-by.  Alternatively, wait until tonight and I'll send a pull request
> with that (as well as missing mntget() in fsmount(2) fix, at least).

I've pulled it from you. Thanks,

                   Linus
