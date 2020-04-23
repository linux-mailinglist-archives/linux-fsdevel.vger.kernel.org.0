Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3D1B5CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgDWNwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 09:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726926AbgDWNwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:52:08 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768DAC08ED7D
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:52:08 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e8so5567266ilm.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0kiSpJdpt5NzjR2rc87lSUDGTW+J0mkXavjC7NX4h0=;
        b=URkDANZ18i7l8EMTaDnbsvv9CKA6pBNYrsSuVcozBJdAlFu+Fm88JzkvHTwro//ZXr
         s4VnlFHqww7tuoLrRodMANhPeZYIS3CaqJqrlssyMUUIeKf7badVaQEllGFc3uO/0ovb
         OgW4aNCG2x/2w2XaDfybOCC65I9HMeKWIYYMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0kiSpJdpt5NzjR2rc87lSUDGTW+J0mkXavjC7NX4h0=;
        b=KzyF/vO/sihud1NSHVqBvFDorlsdiwxWZXMTeLuqbAWiPK3g/lcXp70NZGP/dXhDuF
         xBRW3SWD10XwH/CiLZXwCx6rYhYFTMtPuRG4/u2mdENrjpRuQ+c2PtNDNczYjI/Tb6+K
         dM8XkcS7bYW6MYNF5kQ/UCabCI4as8pJH9kR/yHdqhzM93LyPsKh+NxIIDp8qBZSxu3g
         cqgEgxb8MCsGTPK5omlsSSiV37+ZmXJ02HqnXnNuyzYmB6koni9WZNlbkfnykFiRJqLX
         SW2OgCms0YQaoGa9kwJ+EtY8GjADbWKCBpa4RILkNLsvsvMBXwVtSMEgqGghodCGjTv9
         2Hkw==
X-Gm-Message-State: AGi0PuYOZE6Bvnbil81D4rQLJsO1/5kfxPrgaB12hJvEvzAGN/d4jkwM
        Dl/rqKXEUTsRpck2scOyLtooWpldrGpA56YSrvgGbQ==
X-Google-Smtp-Source: APiQypJE+c0suQ0XLykWP3NEC/rlj/rHRfrunXiI2/nKj47l8PHG5g0xmK+UP5b30nEX3sMv8Tw6exgnCYtYG1Q7RoI=
X-Received: by 2002:a92:3509:: with SMTP id c9mr1052016ila.262.1587649927663;
 Thu, 23 Apr 2020 06:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200423044050.162093-1-joel@joelfernandes.org>
 <20200423114008.GB13910@bombadil.infradead.org> <CAEXW_YTwHApBgUBS1-GBUQ4i7iNHde1k5CxVVEqHPQfAV+51HQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTwHApBgUBS1-GBUQ4i7iNHde1k5CxVVEqHPQfAV+51HQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Apr 2020 09:51:56 -0400
Message-ID: <CAEXW_YQp3vRoZbsgkhm4PmPaXW+ePdAKV6m5+eXxkGcYjQTLXA@mail.gmail.com>
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in fsnotify
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 9:20 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> There's one improvement (although probably verys small) that the paper mentions:
> Also according to the paper you referenced, the instruction cache is
> what would also benefit. Those spinlock and hlist initialization
> instructions wouldn't cost L1 I-cache footprint for every allocation.

Just to add to my statement: Obviously, this benefit gives diminishing
returns in this code path considering that the allocations here are
infrequent. But I just mentioned it here for completeness sake.

Thanks,

 - Joel
