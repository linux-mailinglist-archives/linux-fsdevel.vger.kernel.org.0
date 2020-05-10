Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3861CC5C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 02:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEJAfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 20:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728717AbgEJAfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 20:35:19 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80415C05BD09
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2020 17:35:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a4so4431520lfh.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 17:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIj/ulxXwzU/BqtApM64/L2H6IYW1Xqha2rgujJnuic=;
        b=Aez2jDWnaE+fKs120oJmZNtlhpcevhENgd0OPCPE0bHJG0TM/MRk9jV+wNWJnjXJA5
         a09lBbGbqV9CDMms8Dz3aPk7F/35NlYffAlgkn2Lm8eNUR6J4a45CxXKCYWrDB/qoFWi
         X+n0JsxmOsUR3H+tSwTVkoukFukm9n+4MgXNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIj/ulxXwzU/BqtApM64/L2H6IYW1Xqha2rgujJnuic=;
        b=PqEyMCCxPf37S4/sGZoNN5B+lw+NF2tyqdlc2DzvKpk7/L6/v9eQcPGTYhhcCmnlAB
         Od/Ow5TujKi1f+6hxp3+7KjvsOulG8fez7ugEY6UhVSh7nNOHF0jd+gLG/CAorir1lgi
         LI8GHyVJdoh/gLEkd3Q0MjGs3qHaJeG1sLvi9JS1p5DyoMzrDkBSc3ODFPvZ/wg8Yj31
         /CJ2hDiNONNyv0qj/oYPukPeTDSjQr3xjQE9ShVOSS3eSnTr/a1QMSAUnYy1qidzhqQ5
         MFQdMSZ4bsJqGrFDdXyshjrScY3kj0hNm85sxNGwE/EU1KiGynLUIP+YcjX6VFPjzIHf
         miBQ==
X-Gm-Message-State: AOAM532ANYNYl/kg2ayp66xLP89Jtm8ybAMvlLMW3lIdgc/FHcmkOhY0
        oE2c36jTfe50/S31WEiJUN14QpvKg4U=
X-Google-Smtp-Source: ABdhPJzP3EY3q8zzYSmGlVHIG4AasjNWTDUx7hsAOScvtW+vlug3YU8U2BaDJ2iIEGSKNdYye2nuUA==
X-Received: by 2002:a19:5502:: with SMTP id n2mr6237661lfe.168.1589070915367;
        Sat, 09 May 2020 17:35:15 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m15sm5145037lji.21.2020.05.09.17.35.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 17:35:14 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id o14so4552986ljp.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 17:35:14 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr6018733lji.201.1589070913812;
 Sat, 09 May 2020 17:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
In-Reply-To: <20200509234124.GM23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 17:34:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC+LzLX0NGQQdD+J0Q2LUMhMyA4kWPghMVq+AmU--w4Q@mail.gmail.com>
Message-ID: <CAHk-=wiC+LzLX0NGQQdD+J0Q2LUMhMyA4kWPghMVq+AmU--w4Q@mail.gmail.com>
Subject: Re: [PATCHES] uaccess simple access_ok() removals
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 9, 2020 at 4:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Individual patches in followups; if nobody screams - into #for-next
> it goes...

Looks fine to me, although I only read your commit logs, I didn't
verify that what you stated was actually true (ie the whole "only used
for xyz" parts).

But I'll take your word for it. Particularly the double-underscore
versions are getting rare (and presumably some of the other branches
you have make it rarer still).

               Linus
