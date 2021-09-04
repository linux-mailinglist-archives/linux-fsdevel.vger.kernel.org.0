Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98EB400C47
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 19:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhIDRfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Sep 2021 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbhIDRff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:35:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26CC061575
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Sep 2021 10:34:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p38so4914063lfa.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Sep 2021 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1/lHCDC58EpZAP3lSL5HIsZ7t+vVs/gedrU1qbfjC0=;
        b=g5E0A7pKVAwqmS28GONd127aSSuVA2rRCo0KFjrdmCpo6rlWVPKyBE1s+a1I99PChg
         pjdcRsvnYRVw/J0kgR4KTYtC7JHVyybTqboHqN+10p/hmcbHYK/1Q7FFPkYWSLmMWBLR
         6+tIcgDsIrGGM3fiRmY2IlkJv2zcOqPBLJ1BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1/lHCDC58EpZAP3lSL5HIsZ7t+vVs/gedrU1qbfjC0=;
        b=GxJdYm3bGRF4PS5xAG3HariW35+o2p+yySfolg/GYDuEAqZiaxGeLKP1DWirAOMpVg
         kkm9ZCY98b4/UCILrV8F14Mk6GRcbgZA+i97Fo7K3Ux6yxz2oeyZalk3QaFNAjtAkoos
         BEGkBV+7MEpJU+Celt7nfcVYVJB1+iZYEALDvsMpJuLWHPii2qSL2r/irSCABHlvJpLP
         PN2j/I4AOhCWdXPlyp01+eqGnpbI5loYumVmh4DY59OebzFElNtwLXoP54DLfg//gEbG
         0hu8l3NXLRGsUWJpV4cxzeh+bRKLgkfZGs4DcXKu8iA4G2xQuCsP+9LJEDcqOHzCcRm2
         VoJw==
X-Gm-Message-State: AOAM531pX0r5vnKoUandenJe/Ms1+YZllbRQP/Xp9unts0Qw/tcIZ4RJ
        0pIZne3XCLzN+8O4gofuz5ahhOPDvkimR/iT
X-Google-Smtp-Source: ABdhPJweIu5xNI6bZlLtuycTSXCdcLnZQQ0b7KppT1evl2L1D/I3UBMlkbPCDRqqFB8EkszMU7IYjA==
X-Received: by 2002:a19:494f:: with SMTP id l15mr3407154lfj.572.1630776871549;
        Sat, 04 Sep 2021 10:34:31 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id d18sm303828ljq.110.2021.09.04.10.34.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 10:34:30 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id z2so4860757lft.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Sep 2021 10:34:30 -0700 (PDT)
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr3646341lfu.280.1630776870597;
 Sat, 04 Sep 2021 10:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com>
In-Reply-To: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Sep 2021 10:34:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFAkqwGSNXqeN4KfNwXeCzp9-uoy69_mLExEydTajvGw@mail.gmail.com>
Message-ID: <CAHk-=whFAkqwGSNXqeN4KfNwXeCzp9-uoy69_mLExEydTajvGw@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: new NTFS driver for 5.15
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 3, 2021 at 8:19 AM Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
>   https://github.com/Paragon-Software-Group/linux-ntfs3.git master

Oh, I didn't notice this until now, as I was lining up to actually pull this.

I probably forgot to say this originally:

For github accounts (or really, anything but kernel.org where I can
just trust the account management), I really want the pull request to
be a signed tag, not just a plain branch.

In a perfect world, it would be a PGP signature that I can trace
directly to you through the chain of trust, but I've never actually
required that.

So while I prefer to see a full chain of trust, I realize that isn't
always easy to set up, and so at least I want to see an "identity"
that stays constant so that I can see that pulls come from the same
consistent source that controls that key.

(We've also had situations where the chain of trust just didn't exist
_yet_, but then later on it can be established as a developer ends up
becoming more integral in the community)

Signed tags are easy to use - the hardest part is having any pgp key
setup at all, then git makes using the keys trivial with "git tag -s
.."

              Linus
