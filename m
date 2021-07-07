Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B293C3BF02A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhGGTXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhGGTXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:23:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDFCC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jul 2021 12:20:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f13so6891085lfh.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8sDU1/P1VfuXLXpThIjZK/DKEV3AqnPVmmR6a675sk=;
        b=TL3sOyEcBGu1gEpKYo3+YknZH1bXDiNOt8fLGOSrT7gcTtSYNk2qCAnG4tAmZPO/MZ
         ovzdPXiGVpQUPqvsFEPn66dyk30aOncHb4Jrnhp7MeMmSqHA4sxSIL7b+8LjltgRpdPe
         TdMKVIiIcmlOMLpzKnkw3pfqOHII/epJxAPHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8sDU1/P1VfuXLXpThIjZK/DKEV3AqnPVmmR6a675sk=;
        b=DGq7miLRGalN93uM+YgA3KuaK0Qz3UJrzJ/GINky0efnMlcWsuEBree/4mZLrZM94Q
         7jOCHEoEHvWd7iq5vg2JXEdzu6t3h2P2qoF+m4GHDDPspHj/rCPxBpvoEcUanDpwycVS
         FaNjqMFSjsp6CjEz9tpEUaqQrZEVGPoLbaCfnxcaWyiSnau+SppsYiIcl65dIaSiLFV8
         wu/Y8UTn+FgHDbR6UcVBHkC4veoTAq/8Zmpj1wZqIzEMOAqeuqtc/2LudsKgJ/hiy/NH
         zVfTkKVKSHLKe9vcWYcUZHV1epZuyz8q+zU1gAaWq8n7BIhpBcqnsjBwLV9B5uVjitJ9
         XJ5A==
X-Gm-Message-State: AOAM531KBFUlP7rmGozrD7V9mRPK3P6DAyZ8Cvp7IMMcKf5O3bz/+vT6
        T28piM1SFXQ+ZEDNxSqAJITKLkjmJ4eN9EkEqeI=
X-Google-Smtp-Source: ABdhPJzstCiARtlUQPu9ncfER9Jw5wImo3lR3RGH0KO8Hb5c/u+AOrM9JY37PM+g5Mm3U5ux469xfw==
X-Received: by 2002:a05:6512:3155:: with SMTP id s21mr17438051lfi.650.1625685650978;
        Wed, 07 Jul 2021 12:20:50 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d7sm851501lfg.106.2021.07.07.12.20.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 12:20:50 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id a18so6846794lfs.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 12:20:49 -0700 (PDT)
X-Received: by 2002:a2e:a48c:: with SMTP id h12mr7794800lji.61.1625685649700;
 Wed, 07 Jul 2021 12:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210707122747.3292388-1-dkadashev@gmail.com> <20210707122747.3292388-4-dkadashev@gmail.com>
In-Reply-To: <20210707122747.3292388-4-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 12:20:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijsw1QSsQHFu_6dEoZEr_zvT7++WJWohcuEkLqqXBGrQ@mail.gmail.com>
Message-ID: <CAHk-=wijsw1QSsQHFu_6dEoZEr_zvT7++WJWohcuEkLqqXBGrQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/11] fs: make do_mkdirat() take struct filename
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 7, 2021 at 5:28 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> Pass in the struct filename pointers instead of the user string, and
> update the three callers to do the same. This is heavily based on
> commit dbea8d345177 ("fs: make do_renameat2() take struct filename").
>
> This behaves like do_unlinkat() and do_renameat2().

.. and now I like this version too. And that do_mkdirat() could have
the same pattern with a "mkdirat_helper()" and avoiding the "goto
retry" and "goto out_putname" things, and be more understandable that
way.

Again, that could - and maybe should - be a separate cleanup.

             Linus
