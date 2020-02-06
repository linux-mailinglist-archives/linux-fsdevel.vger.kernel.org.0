Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA9154CDD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBFUWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 15:22:33 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43101 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgBFUWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:22:33 -0500
Received: by mail-il1-f196.google.com with SMTP id o13so6323260ilg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 12:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTt4TREhBQwktDZl/Fhr33XwLEJcbMC6jpNysh0XydY=;
        b=Wewgdxzv4Mn9YiFHsK4lZA8db8lBMLkxef08cWIpvSj8ZPWC9Rc5ixriYwPPegymN0
         uj2sZyK1VDD4T6FwUS0YTsSGxA2HPZzlGQnGmpbbfjLDrADESWNenN+CHd4gSRfkaC1W
         t5n7h34AFoSW8hX7zj0B5dUZt+lQFnPE5q5ZbXPAJC9RB/7IT0ZG14WzWTR2KxeT8q4w
         sydHKbIFI2l7udSnf4fyjtjak7e2Hseaf+tsp4CUIf1oED4ujFuMK0/8gJRDA2+E+E+n
         D4cpSpQF//jZ/etT/Qwm8XazFUzIUX8W0L1KM0y6x9kqnvRm1ueTFXRn2it1SiZ1QKnt
         eXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTt4TREhBQwktDZl/Fhr33XwLEJcbMC6jpNysh0XydY=;
        b=k81yLdIHYwX9Dib7/mYe3Od4pj9FgU3s2/btop9F1h03cUeRRo44iuCEAAI2NfRu5b
         iWK6sTiWVrEJAFzQ7pTtwoow5bZL3LHL5NGH2h5uOrRPaZuDOlqeeykA/luBQbw1UPra
         MXpuvIve0hTIA3YRVWa+4U0Ne5jeCnAgqTQu/0kUwOpPlcPvyzajmVehrZspxWxzhj41
         KPE/t7j3i2sUe4fw0YfqERqE5l04NbF+N4l7VPERwyOE7kUH/NU7zwMpL5/oA38xbSxJ
         ATIUTHCuB/uSkw4+++LHtErxBK1O6rvdkO7vseTtPxjsBw5VuSg2Ojwffts5D4JzZV5R
         GRqg==
X-Gm-Message-State: APjAAAVRioSH6UZ3dd8UXSx3h/PWpHDss02SZyA5VEEUyCqp4slSPaKd
        4yj6CPvR9jpoN/zpj+nZYByHqAmZO0iURkXAJLg=
X-Google-Smtp-Source: APXvYqyzHmeEvKG2J32sCWH7kB00E309ojwP26IZBXFGY6dkRHrCCK+yVLrASG2C1hDWK9pz7NN6SPPR61V2hVmvCDk=
X-Received: by 2002:a92:8656:: with SMTP id g83mr5990276ild.9.1581020552723;
 Thu, 06 Feb 2020 12:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20200126220800.32397-1-amir73il@gmail.com> <20200127173002.GD115624@pick.fieldses.org>
 <CAOQ4uxhqO5DtSwAtO950oGcnWVaVG+Vcdu6TYDfUKawVNGWEiA@mail.gmail.com> <20200127211757.GA122687@pick.fieldses.org>
In-Reply-To: <20200127211757.GA122687@pick.fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 6 Feb 2020 22:22:21 +0200
Message-ID: <CAOQ4uxiXceNbL6jPW9LSH_ijftwHd8NzUACG6w7raZhSoeR1Ew@mail.gmail.com>
Subject: Re: [PATCH] exportfs: fix handling of rename race in reconnect_one()
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:18 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Mon, Jan 27, 2020 at 08:38:00PM +0200, Amir Goldstein wrote:
> > > > Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> > > > warning") changes this behavior from always returning success,
> > > > regardless if dentry was reconnected by somoe other task, to always
> > > > returning a failure.
> > >
> > > I wonder whether it might be safest to take the out_reconnected case on
> > > any error, not just -ENOENT.
> > >
> >
> > I wondered that as well, but preferred to follow the precedent.
>
> I can live with that.

Will you take this patch through your tree,
or do you want me to re-post to Al?
With your Reviewed-by?

Thanks,
Amir.
