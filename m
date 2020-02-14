Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1415F8ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgBNVrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 16:47:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36187 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgBNVrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:47:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so12301207ljg.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2020 13:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULvgOcWtqQoiiZTQEcdkHo/hzvR0mDvJVo9JBCmHaro=;
        b=UghfVcGD99QDVJvEji3DwtzpIp/PGb7GJofQVdGg87wpeWgj5k1fmihFbyHJDkzhXm
         S1NEmhmLvIIspUxPsjqWYv+g8q0cgFqkqJsqk6YpKTd6xRAfC/+pRYqVa+LT/zHudhSe
         ezPpARw61nPYCHiuMSRuvAH2pkTlrESq7Y0NpQrB9ACMChfUqXxp93LrOIYT2VYUQCJo
         gmb8qcWUBCD71s/4fRxFDy4T3zhcDp/8yu4ZXGH549/K9U19OlbHknT8fxAAk5duXcIa
         zBQ+s0+fPCvaocHwCtDCGP4wFwcvFTeDl1IPB9yATUIb5hn70+tb0HH0Q6XBRHaUjClO
         2Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULvgOcWtqQoiiZTQEcdkHo/hzvR0mDvJVo9JBCmHaro=;
        b=UlfT4aE4GChtvMKV6kEtLLjGK45U81Ye2ETvqhkbY5x798XEJ9/2j9s1UW0CEVW/ab
         9++s+RxGHSpn7fERiDCHi4cjhGAMA8MoHtUM0fyb+69P5n32h8WgC0TvIl5MOdnCbqLn
         gGXdofzYufl6kQBwJtv8RwY9MyGCTkpVFV1hm2e033y5q3DqrCn5iqj+m1x251eq0MFc
         9AhYQdN3FMq/PgtKruHHCIzOXqXw+6b7eZROiyyYp1feRoBithxbUfQo5S0oVVy+HlH0
         co2THvb2vkcFRahkvwbW+mD4a333J8dkLBBEZeoNlC3o7G8n5+BuIb1QAajrSEB2unXa
         4ZkQ==
X-Gm-Message-State: APjAAAV0IY4E85zV1dpaPPqv5airn4nV0hjH+j/cOY76jTDoBF0U5rSg
        EslyOS3CHlTBt3Y00maGjkc2tNRekdX7lkcErttiUg==
X-Google-Smtp-Source: APXvYqwOnenDJydesgZENHJdVpOerGyyRYO7zjT1GE3p1T0WHWXpqjZg+ov2CAwduAn/RxPssJiAJvJqDMAmNkptrfI=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr3415670ljj.191.1581716868386;
 Fri, 14 Feb 2020 13:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20200208013552.241832-1-drosen@google.com> <20200208013552.241832-2-drosen@google.com>
 <20200212033800.GC870@sol.localdomain>
In-Reply-To: <20200212033800.GC870@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Fri, 14 Feb 2020 13:47:37 -0800
Message-ID: <CA+PiJmT_8EzyFO283_E62+UC6vtCGOJXKHAFqnH3QM9LA+PHAw@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] unicode: Add utf8_casefold_iter
To:     Eric Biggers <ebiggers@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 7:38 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Indirect function calls are expensive these days for various reasons, including
> Spectre mitigations and CFI.  Are you sure it's okay from a performance
> perspective to make an indirect call for every byte of the pathname?
>
> > +typedef int (*utf8_itr_actor_t)(struct utf8_itr_context *, int byte, int pos);
>
> The byte argument probably should be 'u8', to avoid confusion about whether it's
> a byte or a Unicode codepoint.
>
> - Eric

Gabriel, what do you think here? I could change it to either exposing
the things necessary to do the hashing in libfs, or instead of the
general purpose iterator, just have a hash function inside of unicode
that will compute the hash given a seed value.
-Daniel
