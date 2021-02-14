Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08331B23E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 20:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhBNTgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 14:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhBNTgg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:36:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC39C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 11:35:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u25so7141293lfc.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RbvCfMxOWqMpSP+VwP8T3vlMh+uVuY1n7ujnc/XcM88=;
        b=ccjzpZtHRJY+es2JuDho5q0htQTKjsB1P/wHbFNcnHGiaQCwf/BlM3TdHld1OGor2E
         KacLI5WAD7LkqPBFeOKwHjZtwYGCxiPFhUU/GMbN7N+O7oGc/+syYfbFYh6a4dcqR+Ln
         hX2gIyJ65bNumi31UoWqq8c4UoQzdQtXppA1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbvCfMxOWqMpSP+VwP8T3vlMh+uVuY1n7ujnc/XcM88=;
        b=ZYmmp3LXF5VPX1WhpuszLsn935FnAXlrFf01cMc8Stx2Ng++vSyqJBXyw5giMFm6+J
         HWGLrjOySAI6Wtvu6IIjpfC2F1NPv4FSCvRMq1UqBI+X39Vp2F8XpbjS7ZQKOT07fWV4
         wy9k3ANoPwSFc2VwWTr3cZTLFpn35fNPZ2d1FEJyexOPKukFBhRwqkiU0cscWnkZOVQz
         T3wBsliyMBw9iLqkCOiOyQpvORIAjc5298mRX/ej4/UWqhmtEeXHdzOK+OqD1Vb8KMTC
         rnDWtkNphLU7PI+EBXjqfPSSEDZ+kWHhDKsTKsS+BhT58af7b1iAWR7EyM23UAN1hPKb
         XZfQ==
X-Gm-Message-State: AOAM533SRlHRCzIRzYZ+3XfXQG/82zuSCzqxeHZaQgIIEXH0E0oI3G+Y
        h3OIK+NMPPPtfS8reqnNTLGmqX9+k6qYQw==
X-Google-Smtp-Source: ABdhPJwbC8Cz0cbtzdK0FPiLkM6/0sf0662IPMqYic4MG4hcL2fXQ1IAVo5ru5l/oLYeW4nWDdddWA==
X-Received: by 2002:ac2:4ec9:: with SMTP id p9mr7140242lfr.390.1613331352904;
        Sun, 14 Feb 2021 11:35:52 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id t9sm3366246ljt.80.2021.02.14.11.35.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 11:35:52 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id m22so7116687lfg.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 11:35:52 -0800 (PST)
X-Received: by 2002:ac2:54ac:: with SMTP id w12mr6606496lfk.487.1613331352177;
 Sun, 14 Feb 2021 11:35:52 -0800 (PST)
MIME-Version: 1.0
References: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
In-Reply-To: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 11:35:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyaja6TKL1+HGXMXNE2EkqfjjKV6oQAOKfTTacc=mq5Q@mail.gmail.com>
Message-ID: <CAHk-=wiyaja6TKL1+HGXMXNE2EkqfjjKV6oQAOKfTTacc=mq5Q@mail.gmail.com>
Subject: Re: [git pull] sendfile fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 14, 2021 at 7:19 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Making sendfile() to pipe destination do the right thing, should
> make "fs/pipe: allow sendfile() to pipe again" redundant.  Sat in -next
> for 3 weeks...

Just to clarify: this says "fixes", but I get the feeling that you
meant for me to pull tomorrow in the 5.12 merge window?

I like the patches, but they don't seem to be anything hugely urgent.
They should make "sendfile to pipe" more efficient, but the current
hack is _workable_ (and not any worse than what we historically did)
even if it's not optimal.

Right?

Oh, and it looks like the first line of the commit message of
313d64a35d36 ("do_splice_to(): move the logics for limiting the read
length in") got truncated somehow..

          Linus
