Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C1185366
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 01:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCNAmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 20:42:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46791 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCNAmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:42:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id r9so3832521lff.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RwsAxU8WnehWNYnYawqMDWrndD0IlWbUqTUz3Fam9I=;
        b=Iujf8nmDlOEl8DuY+scdOEaoXNtqE3/87ZkLYwqmOxxEburi8x/PvzjADUkVWiuy6t
         yu0Mw4qmnFFYOzNVqGfC3HzJwT5Xf66YvEA3e9tIjJ37wHKrLORYFkjcemchA+IRQRdz
         Nl+7RN1k830zJspW3aLfmSCT4Jr3sv7xVzmX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RwsAxU8WnehWNYnYawqMDWrndD0IlWbUqTUz3Fam9I=;
        b=HG06gvG7X1I1IO/babdh4jWGd396QUqlXC6HqR0fZ+s4wKoz7zeJV1cS4AenSFnH98
         bRgQpk1FI8D+/aFiPz5TIpaaP+Q5EMKSacStBayDvL+byWaOfhGiyehdc1Uu4wbqPpsQ
         fHAA+aqSXNqoAlajEh06jI6vhf5dtPVLO9IVIhbYcnLK/GnFZKb0avzE+/36fgczVQnh
         8YPAwdjvbI+xovWU5I7/W0U7tTdFeA7Wd6bs1lh1eLOFehS0CRiV4WwLsl60usR+msy8
         xn4cUlNSNvu7iV3RJqkk4/Uc2QH9gtAV/rHUuBLXYl2ytbDDHhA8FYbD7zEKOKyGfV/S
         YGsQ==
X-Gm-Message-State: ANhLgQ0uhOflWrA2QKgdQ5SroPaNNY6Cu61nr2156uWnXgcrs3rY2oWH
        MCOGzyuncKCr3U2oe6lu1Kp11ttO9S8=
X-Google-Smtp-Source: ADFU+vsPQZ1AF8Gou3Yd2+KvqqjPyB07qqbuUeexyMODwCbVMD12NrFhTkuZkMjCNZraisjNAEpBNA==
X-Received: by 2002:ac2:5e7b:: with SMTP id a27mr1574913lfr.61.1584146555252;
        Fri, 13 Mar 2020 17:42:35 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a8sm12026592lfi.83.2020.03.13.17.42.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:42:34 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 5so2228826lfr.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:42:34 -0700 (PDT)
X-Received: by 2002:ac2:5986:: with SMTP id w6mr9930880lfn.30.1584146554075;
 Fri, 13 Mar 2020 17:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-27-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-27-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwDZc4gh8R8gszZq+2mue-686aXTgELMZq=jqmj9z+FA@mail.gmail.com>
Message-ID: <CAHk-=wjwDZc4gh8R8gszZq+2mue-686aXTgELMZq=jqmj9z+FA@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 27/69] namei: invert the meaning of WALK_FOLLOW
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
> -          flags & WALK_NOFOLLOW) {
> +          ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
> +          (flags & WALK_NOFOLLOW)) {

Oh, and here you fix the implicit precedence thing I was complaining
about earlier.

Maybe my original complaint had happened at this point, and I'd missed
the original place.

Likely.

            Linus
