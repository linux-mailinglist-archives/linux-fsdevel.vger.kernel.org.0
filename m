Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776B828EA52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 03:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbgJOBj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389157AbgJOBji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23DC05113E
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 16:12:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a7so1315760lfk.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAvZc2gfIDjGucI+VwMq6whQr0/X879Oidvupvz4o8Y=;
        b=A8ynlJkvJwu91bo1EWLWkCdSoSsQOYY27iLOzHN9LrJCn/9FttdpwSl7LCaiHFBWPU
         d2qwxL/Z2dBelY1gPIpdNoJbzejfSDUiWJ1po2uf2uumX/elh707ayGNBojGD8rKYC8W
         vfXI/Sd9WF7LGiFge0wniSqlTuIXeGGij18nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAvZc2gfIDjGucI+VwMq6whQr0/X879Oidvupvz4o8Y=;
        b=kJyZQKMmAUV5c0BtYFbGbpyz/4fKI5Tde7coq6k1LZBAtHMc1A0gQ1MBHf29k1ADJ8
         XjEGONjtkEorOw5iYGFGZw+bOxTXJPOfpQOIQ0YLZnNLcraOq7ej0pv5UQ+R33HLy9TV
         fq84zY/0upZLtjhJDQHay+y0GCY4Y8ef5p8tm72NYA0yyglKwoLq3wwWLgXN+wIGqPdu
         jtj3Og6A4QDNwFrXyCkfOZVy9DA2VWWGyjROKGmbgDHcO51l3r9YvOM5pMtfHMkSwh6b
         HPkRzl4ZUIRCi2bBch66j4OyatiZIbzV+Kyw8E+sJaiZAyRx8lp43bGJs4G9HNETdBae
         OFxg==
X-Gm-Message-State: AOAM531txz88Ksxb3P4u2sLXWnWTK6E6qCVK5Oiiswx/xsOKlZrj52zR
        ++wViAsU+S5F99jbxBtdUDU/wZxS93eWSg==
X-Google-Smtp-Source: ABdhPJxa/nK6LtYU+xZx7m9JK4d5K3V0KSWIH5kQEPwG/CG7H78Q+QpEzi9y9DPzPLeeVTaIOnihMg==
X-Received: by 2002:a19:f71a:: with SMTP id z26mr107331lfe.90.1602717145017;
        Wed, 14 Oct 2020 16:12:25 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id i11sm445815ljn.119.2020.10.14.16.12.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 16:12:23 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v6so1286714lfa.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 16:12:23 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr122638lfz.344.1602717143436;
 Wed, 14 Oct 2020 16:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201014204529.934574-1-andrii@kernel.org> <CAHk-=wiE04vsfJmZ-AyWJHfNdGa=WmBYt4bP3aN+sTP05=QXXA@mail.gmail.com>
 <20201014230858.GL3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201014230858.GL3576660@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 16:12:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=winDPLHSayCSPJnFZF9K31krw5TbLdGSxn_x-s++8=meQ@mail.gmail.com>
Message-ID: <CAHk-=winDPLHSayCSPJnFZF9K31krw5TbLdGSxn_x-s++8=meQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fix NULL dereference due to data race in prepend_path()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 4:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  If you've already grabbed it, I'll just push a followup cleanup.

Already grabbed (along with the ppc32 csum fix). Your suggested helper
function cleanup sounds good.

          Linus
