Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232CC217EFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 07:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgGHFO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 01:14:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34773 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHFO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:14:58 -0400
Received: by mail-pj1-f68.google.com with SMTP id cv18so1685275pjb.1;
        Tue, 07 Jul 2020 22:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OqVVW0oBTFGuooK5mpqIGnPNuH2j0inEUm18D/YWITE=;
        b=C+5XmQ4DjwLm6uKyKMliNV9QR10t19L42Y4ymLbtfroZ91vOCM3zSAy/1VSRAdXBsd
         4MGX8Rtz1BSXDDJ4Tjtq3QugK/DNNkwkgXinlwx1OjyXhS8Gf6THuuIhASNrYTXnc8o3
         4akC8DQdnwm8Ba0bha5jHB7EUgEHwmvKobw0PWVSyeLHlJOTJENZvGauM9NeSNkZW/pp
         SmNbQgYRC9LlyO7bLVmVefZivO/El9/oiEk2X8bBOUhiyO10veTsjlig2hVG19GKURUa
         lULsj7bCkoLs3LbqPFv3WkdupWoQGcbMBSPQ7HztHU35gXjpJvSWjaiCg8aerchCChQe
         S93Q==
X-Gm-Message-State: AOAM530lBa+PGKnezy6ELfbJ318WNeuMJirruvc09rfiuOsjr7RqJYqS
        xJOWLxkeQRSjw1tF30EYXYc=
X-Google-Smtp-Source: ABdhPJyQx8ZMpcO8bKNNbg4mSfCGoBKklHKtFUJJ+PqPd/73lutAhh1K9WLnEPfuPOJBEPM1jMtFNA==
X-Received: by 2002:a17:902:778d:: with SMTP id o13mr46710940pll.247.1594185297748;
        Tue, 07 Jul 2020 22:14:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b18sm4120429pju.10.2020.07.07.22.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 22:14:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BEAB7400DB; Wed,  8 Jul 2020 05:14:55 +0000 (UTC)
Date:   Wed, 8 Jul 2020 05:14:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200708051455.GA4332@42.do-not-panic.com>
References: <20200624162901.1814136-1-hch@lst.de>
 <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de>
 <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com>
 <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:33:03AM -0700, Linus Torvalds wrote:
> The real problem with
> "set_fs()" has been that we've occasionally had bugs where we ended up
> running odd paths that we really didn't _intend_ to run with kernel
> pointers. The classic example is the SCSI "write as ioctl" example,
> where a write to a SCSI generic device would do various odd things and
> follow pointers and what-not. Then you get into real trouble when
> "splice()" ends up truiong to write a kernel buffer, and because of
> "set_fs()" suddenly the sg code started accessing kernel memory
> willy-nilly.

So the semantics of this interface can create chaos fast if not used
carefully and conservatively.

Christoph, it would be great if you're future series can include some
version of a verbiage for the motivation for the culling of set_fs().
Maybe it was just me, but the original motivation wasn't clear at first
and took some thread digging to get it.

  Luis
