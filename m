Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF832F88E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 23:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAOWv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 17:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOWvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:51:25 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED57BC061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:50:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u21so12112817lja.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BP8A5Fr5rq60xwzRjLDYqleQmQwgjOuNkcax/uogylI=;
        b=JDgaJ+aZakTkLqDRr/Nxj6NnPtktkwyykElehcXd5k5pvtIMEqDat9KXS9w4vU95Tg
         cPLMFOfNK6lVirAkvw5Y+0SYQdkrHgzJpOd2VZoReMNLGAlPDA/6zkk405lzaLY+hf+S
         PvrIxh/S8EUjw/io+SfZUja2CP/1O23mYY3ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BP8A5Fr5rq60xwzRjLDYqleQmQwgjOuNkcax/uogylI=;
        b=Mdn4KpiPfODWiPbxIXy2eAnVsGPUL7c71KwAu8Iq4qDzfrpUd5RbUsjFMGsfphpXKg
         bL7Bu3fbeqicdsv3ERuAMJEv7Z3N1pgdyTWzePtRvavVY7PG1l+ZpNamang70xs0tAGN
         ATnHTJfLO6mDhokIu+godge7jswpyZs2aiGPNc5xYpSTOwQlWmSdgdqTKIqx4kvo37zw
         iddT8VL84Q5b13MpHekYAJXiXE11W9qM7FmBekp3KGhuiEbtXmTgajlUj3MLEEuKRyGL
         Jia6IuxU/gVfblUge3an1dxYZlD4e70v3ge7oB095FvDyXp1MAeF3ujvnyvkGMUGOxsO
         8gOA==
X-Gm-Message-State: AOAM532cDjWyXsCRorCjkKOxW7Xo+Qp7kY/Lrs+4HivJZz6l73h7BdWQ
        Hy3ca7Om1YiN5ukp3TIjAvSkoLsFV3HOhA==
X-Google-Smtp-Source: ABdhPJx7k6ZS+heXn9QawLNcxj0588UkCa++mmP1jCZlAdOgquNaiRODQDxA66NhLdOEnSh7OPgybA==
X-Received: by 2002:a2e:2417:: with SMTP id k23mr5929249ljk.373.1610751043063;
        Fri, 15 Jan 2021 14:50:43 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o14sm1051300lfi.92.2021.01.15.14.50.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:50:42 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id h205so15503226lfd.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:50:41 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr4766178lfh.377.1610751041631;
 Fri, 15 Jan 2021 14:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20210115163917.GH27380@quack2.suse.cz>
In-Reply-To: <20210115163917.GH27380@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Jan 2021 14:50:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTVhOYX5C4TWFrRdAz=QygD0uPDzhLD6sbv2yZfq8+gw@mail.gmail.com>
Message-ID: <CAHk-=whTVhOYX5C4TWFrRdAz=QygD0uPDzhLD6sbv2yZfq8+gw@mail.gmail.com>
Subject: Re: [GIT PULL] Fs & udf fixes for v5.11-rc4
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 8:39 AM Jan Kara <jack@suse.cz> wrote:
> lianzhi chang (1):
>       udf: fix the problem that the disc content is not displayed

What? Hell no.

This garbage doesn't even build, has never built, and is unbelievable shit.

Clearly entirely untested, there's an extraneous left-over close
parens in there.

              Linus
