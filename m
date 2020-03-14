Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07218536E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 01:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgCNAvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 20:51:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44800 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgCNAvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:51:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so12498377ljp.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5w4U+mOCcTiVuYDq+MXzMGJDsYiXTEA/liBKIfgsNo=;
        b=CuZ6m+O8ocHYyKfETYioICJSPSG6jO2l5sVNRexToIRXGGlWfI0a1s0ftc+276o4kL
         +uJLTjdL3K3G1tQ4MaaU3TpK73x5dELWgmEQvjyRbEV+XaVWnseYbRydLcyLf9Ta4Gzj
         hdHX62pz+h52pKbzWGSD8FI7QHQkc8een7N4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5w4U+mOCcTiVuYDq+MXzMGJDsYiXTEA/liBKIfgsNo=;
        b=PLnFKlqz3x6qDjlYpn0w++sPKLrjVxJLPGRayY+ZfCzvbuIx6XLSY+jxlnCJSpFwgt
         nUSjKNfnDhadwPhE0sdAjiA4OFIOKZ5+JThOIGTo5QIoyNw9GXr+La5uI4A7/w/qEhPn
         j8hcslL7oYaBcHQSc3CyofUs4guwCqXm4eGKH1ZOtR2MtgEFlSNUxbLlA257YzVzajg/
         N3ToT5ZY8GAhtluFgYLnVmQd4GoVPD1kljRVbhOYeWy6enVwekrAEdKR1cotVeQWsXIw
         jt+pwAI2CwX/4+K9lIfK0xP1p5rhg7mdzKjPvTvM3RV1TexQju70XdFqCsk1Ks6BwHwr
         Ux+Q==
X-Gm-Message-State: ANhLgQ3vmDW6H8x0QdD5/q8vMRhhH4H0KJQvdmMwibGp8KJ7llMoZOZE
        aBuMfCWjcuYvY5nU7VEkX1GjJR7d2W0=
X-Google-Smtp-Source: ADFU+vsrOnhS6Hmr213vGBFR7TyuA55AxhHHGkgmT7Op7FuZwNgZS4i4ajZB/Emsr5Gp2Fra4jJ0+A==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr9594220lji.273.1584147068308;
        Fri, 13 Mar 2020 17:51:08 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id f9sm10249482ljo.73.2020.03.13.17.51.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:51:07 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id q19so12488818ljp.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:51:07 -0700 (PDT)
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr9713597ljp.241.1584147066920;
 Fri, 13 Mar 2020 17:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200313235303.GP23230@ZenIV.linux.org.uk>
In-Reply-To: <20200313235303.GP23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:50:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whainTcvgF01vsSmN+y7s7U1qMA-QbM5qFQ3s4xQHwaJw@mail.gmail.com>
Message-ID: <CAHk-=whainTcvgF01vsSmN+y7s7U1qMA-QbM5qFQ3s4xQHwaJw@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v4)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Review and testing would be _very_ welcome;

I didn't notice anythign else than the few things I sent out to
individual patches.

But I have to say, 69 patches is too long of a series to review. I
think you could send them out as multiple series (you describe them
that way anyway - parts 1-7) with a day in between.

Because my eyes were starting to glaze over about halfway in the series.

But don't do it for this version. If you do a #5. But it would be good
to be in -next regardless of whether you do a #5 or not.

                 Linus
