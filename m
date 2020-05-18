Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C5F1D872B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 20:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgERSbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 14:31:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41153 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgERSa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 14:30:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so5343701pfy.8;
        Mon, 18 May 2020 11:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MNvGxXH70pUk2rUMUm7OX5VYVn/vSKKSqC8ibxkcQ+c=;
        b=LkgTRMtFHTuflen9VfDx0gPUZ9vaone1bh8mAUpu1gCsvBMvO7vynQe5RiwSNx4uL4
         Y/+KW7FeLOehpsAxoQ7jetQPVmJe9YkEJgIYpzthLIkEkmuraEsGm31hy+g/Tp7A+VtA
         6T8GMFygIOGfB47pjBC9E3AU6eGuwd9bJFQAy68qFT+bjSfT8OSK5ko2y0MW8VlTCXQB
         vyBrc0oZcMTXVQUFZrtNlEAi69UaIPvrRuyspeWQs4MBPerj05vKyomXYM2z5MwkOVVE
         gTse/ka6xx3uoQk9O6R6ATUtwG7fad5SvTSvFV68xtLUZ+WK98eUtitPeg0Cib6cTmAC
         JI0w==
X-Gm-Message-State: AOAM531/5eBfGFBw4+M5mS9nbkTzVs0wB4QmCQc0KAZBs2NgR58ymepJ
        It5tidZ9VAPV5uvINJ/Y5cI=
X-Google-Smtp-Source: ABdhPJxbvrW+K08SVhBUxVXXcUph4FjFiKVCfMGxgL5mBKoSOvhTiXC3EzL18F1ArNzKTIDwUMUidQ==
X-Received: by 2002:a63:3d7:: with SMTP id 206mr16076823pgd.45.1589826657018;
        Mon, 18 May 2020 11:30:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gt10sm204901pjb.30.2020.05.18.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:30:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3B5A8404B0; Mon, 18 May 2020 18:30:55 +0000 (UTC)
Date:   Mon, 18 May 2020 18:30:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Kitt <steve@sk2.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: const-ify ngroups_max
Message-ID: <20200518183055.GN11244@42.do-not-panic.com>
References: <20200518155727.10514-1-steve@sk2.org>
 <202005180908.C016C44D2@keescook>
 <20200518172509.GM11244@42.do-not-panic.com>
 <202005181117.BB74974@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005181117.BB74974@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 11:17:47AM -0700, Kees Cook wrote:
> On Mon, May 18, 2020 at 05:25:09PM +0000, Luis Chamberlain wrote:
> > On Mon, May 18, 2020 at 09:08:22AM -0700, Kees Cook wrote:
> > > On Mon, May 18, 2020 at 05:57:27PM +0200, Stephen Kitt wrote:
> > > > ngroups_max is a read-only sysctl entry, reflecting NGROUPS_MAX. Make
> > > > it const, in the same way as cap_last_cap.
> > > > 
> > > > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > > 
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Kees, since there is quite a bit of sysctl cleanup stuff going on and I
> > have a fs sysctl kitchen cleanup, are you alright if I carry this in a
> > tree and send this to Andrew once done? This would hopefully avoid
> > merge conflicts between these patches.
> > 
> > I have to still re-spin my fs sysctl stuff, but will wait to do that
> > once Xiaoming bases his series on linux-next.
> 
> Yeah, totally. I don't technically have a sysctl tree (I've always just
> had akpm take stuff), so go for it. I'm just doing reviews. :)

Oh, I don't want a tree either, it was just that I can imagine these
series can easily create conflcits, so I wanted to avoid that before
passing them on to Andrew.

  Luis
