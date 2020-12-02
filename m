Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9D2CC826
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 21:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389418AbgLBUnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 15:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389324AbgLBUnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:43:08 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA8DC0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 12:42:27 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f24so5334081ljk.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3btiNSHm6jRc+pdBtMLFUAxRzWlf/wPyv3Pzid5Qtc=;
        b=Z11LEqV8wdrsHfKnZ1gN+6MxuQLN4JBrl/ZQBEaq6vQOuLOGiyyvqkeCcPCYRhQDIv
         ZPmJT1ekDNw917/6qDlUXjz9Xu/yQOcMPNWuaxXaYoEorXu9QNfEuCP35vSG8m9tWndO
         8uCAyKVBZS5tHpQHBWAexF8LHzVQcFWUxGxD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3btiNSHm6jRc+pdBtMLFUAxRzWlf/wPyv3Pzid5Qtc=;
        b=NVA52tzvPz6W3NSlMHe7Q6thcG6ZowMYhfEjqe8AoS1gA7x5izygF5fmdUMG9kC1XW
         Q4305x5stUgCvStucqMwp1nsNJNv5r0NbzIKVQClSRs/ebLvUKXdqdsskSVOnnofG3bN
         zPdbRnhXdEpR152hryHHkwc1bCbPpr27tTENuK6B9jzBtMQm9rV6/Hy8Dh1QUtWBuIMx
         vfdqXYRPXZoYoPWezdJCULLKFy7VCYOH9uI03YYeSE6iGDyF/cbsKnwjTry1z+28zMZk
         ewzDsoSG4InRC8MlkEeEJGTB9qoyHtK3NsmvKWzkdDv+t00ySeFVMnmz0xyTZVHZK5pC
         nhqQ==
X-Gm-Message-State: AOAM530Xg0FwBfdGrhBVcTiDPICWYVRqcMG/Q51Uy0unNqVL6LqGfB1s
        s5QMIobEqhUZ9m4r50L/Wbn+h0AnBk7uLQ==
X-Google-Smtp-Source: ABdhPJyKFGKPD5VBSqL5Puku752Hh2JiloyH7z/gKzXulB6ideXraoqqfeAQdSemHGtSGwltRT0g9g==
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr1852931ljj.174.1606941745675;
        Wed, 02 Dec 2020 12:42:25 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z20sm898816ljm.138.2020.12.02.12.42.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 12:42:24 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id l11so6917240lfg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 12:42:24 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr1907270lfy.352.1606941744281;
 Wed, 02 Dec 2020 12:42:24 -0800 (PST)
MIME-Version: 1.0
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com> <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Dec 2020 12:42:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com>
Message-ID: <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com>
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:16 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> This will force a change to xfstests at a minimum.  And I do know of users who
> have been using this value.  But I have gotten inquires about using the feature
> so there are users out there.

If it's only a few tests that fail, I wouldn't worry about it, and the
tests should just be updated.

But if there are real user concerns, we may need to have some kind of
compat code. Because of the whole "no regressions" thing.

What would the typical failure cases be in practice?

            Linus
