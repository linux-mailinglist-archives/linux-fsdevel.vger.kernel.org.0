Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC38E226DBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgGTSGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 14:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgGTSGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:06:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05EBC061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 11:06:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so21203997ljg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uI8ot/2J0X8mcn9Zfp2J49mB1lp08I2jN3wbAeSC/Pw=;
        b=Cz61HqTwOZ6IEwVnpU+vIjJ2UVZP/Mu4fKA2ydp8JL2VDpMC+nUU4axsRhH+TxIuMT
         7h9Jetot2Q2oMe1da303RP61HjMA+kS64YBC7m4CKaPJ6ZkKqgFan1xJh394/xLoayCV
         YJQKJ0gYeeODtQeM9+onNI6euuT5xsMXV1y1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uI8ot/2J0X8mcn9Zfp2J49mB1lp08I2jN3wbAeSC/Pw=;
        b=dv5/OEL3vcgHV+q2fAZidhkzt05GIk6qZ4RbUe9ffmcdAXLY1FwTlH5bObxM0Kupsb
         zTqs7+LPPOic7GPVH/6Ucf4TqU8uuz5LHR1DC9KKBRf9U3Z21ZhKjoyG4W1lSKCdlkpn
         609ZRUM5bAHwuhr7xmWsonMl03FLdaHFfdnieaI2uajWdzuFMG4czEgFaEfCbBnoagJF
         BC5ULfyupprGtigSaYPlC6Lmx8Yc8P9uU0o/YT+R6q5Ny4cSXk8lVOg2QvYcqmbWydEL
         vDdW871hwCEFVUa0XIsq+KekzDAi5bAeDXJlncq6yz+E07kVLLKnv42a2AksXnMOraXi
         7spw==
X-Gm-Message-State: AOAM531pVC+T8ousaUinkjVL7HuYRIENMKAk8EPpNPvsntNSANtxZjp6
        kOrEBKkEZdqbCc6FkMYJlChyHnPl+/g=
X-Google-Smtp-Source: ABdhPJzCZ0hyPiZC2w5iULPOZolnm1P7Gz+AUajSycgBjtOAeLBiHNB2dUSRvpyu/ucOXn+V1uTVMg==
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr10095608ljo.74.1595268368880;
        Mon, 20 Jul 2020 11:06:08 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 16sm3315619ljw.127.2020.07.20.11.06.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 11:06:07 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id o4so10233355lfi.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 11:06:07 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr2412004lfr.142.1595268366796;
 Mon, 20 Jul 2020 11:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200720155902.181712-1-hch@lst.de> <20200720155902.181712-5-hch@lst.de>
In-Reply-To: <20200720155902.181712-5-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jul 2020 11:05:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimKMPiGP6n_HQUJ1rQ_6cT6hZH5rjQa_nfAgjB1mug+A@mail.gmail.com>
Message-ID: <CAHk-=wimKMPiGP6n_HQUJ1rQ_6cT6hZH5rjQa_nfAgjB1mug+A@mail.gmail.com>
Subject: Re: [PATCH 04/24] fs: move the putname from filename_create to the callers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 8:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This allows reusing the struct filename for retries, and will also allow
> pushing the getname up the stack for a few places to allower for better
> handling of kernel space filenames.

I find this _very_ confusing.

Now the rule is that filename_create() does the putname() if it fails,
but not if it succeeds.

That's just all kinds of messed up.

It was already slightly confusing how "getname()" was paired with
"putname()", and how you didn't need to check for errors, but at least
it was easy to explain: "filename_create() will  check errors and use
the name we got".

That slightly confusing calling convention made the code much more
compact, and nobody involved needed to do error checks on the name
etc.

Now that "slightly confusing" convention has gone from "slightly" to
"outright", and the whole advantage of the interface has completely
gone away, because now you not only need to do the putname() in the
caller, you need to do it _conditionally_.

So please don't do this.

The other patches also all make it *really* hard to follow when
putname() is done - because depending on the context, you have to do
it when returning an error, or when an error was not returned.

I really think this is a huge mistake. Don't do it this way. NAK NAK NAK.

Please instead of making this all completely messy and completely
impossible to follow the rule about exactly who does "putname()" and
under what conditions, just leave the slight duplication in place.

Duplicating simple helper routines is *good*. Complex and
hard-to-understand and non-intuitive rules are *bad*.

You're adding badness.

                 Linus
