Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC146151DAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 16:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBDPwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 10:52:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38354 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBDPwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:52:51 -0500
Received: by mail-ed1-f67.google.com with SMTP id p23so20256652edr.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 07:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d0fJd2kqJOBxIhDrO5YQ550FVzvPHsXp/LZedW7iYo=;
        b=jV+b0Pt2SFxKxAS8cj1UQHfhP4u6Is0Ked6engWmcGC4Vi3TiaYTuMDEDShbyo/W7Z
         1G3Z0cM0PQWOg38Z+JVqucnhUkVnrOHTg50fin3WAGhZgHIYgSQ19+fPt7zs5oVqfJea
         pFWTF/n1Y213SSzHRtw5+jlUvJShRGJ7FhRpHhM1nAXcPW2m+/YHt61prqobroLuGOGk
         Y1CQM8QgSJwCyjxAesY/KCzkHfxFaZvogMV+xmE/W9owG68Y6pOv1plJSjhJiJzmsdiF
         xLMebzV4Z6XBRCCVQYgqj7kXbOFpljAZJuaOraWTomEviTzwCFj9906EhFb5Yal9kDuO
         Yt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d0fJd2kqJOBxIhDrO5YQ550FVzvPHsXp/LZedW7iYo=;
        b=Pjjd4H5Le3G9MMsYehUMJuVM0RToy6xT/KVuvK6p2VKGeunqdYZA0UAKzIZFcSMrqN
         OjJSnT78bO0zlf62SYVn/dyj9fCROS4CrQyFG4bzD7vj6ITqtMqOShD6Rn+ulIKUcT/v
         fJtweyYaul/yRNN1kwJ8yvRQmAqWf3z3HUFDvPTHfNKLqzymOClVwGvW0fytCuZNSpIU
         SKlGSYuwiOSAw41t5sFlre8rZN9CrLG/xiilrwWtHb5pyhlMqjhRU7G6uNPhtwss81V/
         oi9jEKrNRHpftDojdvhBmHTbel70tMYrNeQfIfF3fHdw4cbb0D1WxlEyMJHH3xojS2WX
         hIDw==
X-Gm-Message-State: APjAAAXW30XK3dhAX/3Y1HsGySvKGODgBglWbJqP26ZCDo+wnaRLXMze
        ldURk/gdtr1mUCUlwdjXSMC65tMMsI+KT873HsUC
X-Google-Smtp-Source: APXvYqw+zYvw6F4Umt3lSDJsc2lvOiKELPOHsE6Als0Io7phWfq8MkukCyGdnY7at8Qo98R48gqGhqoNt5voV/XvnH4=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr26062018eja.77.1580831567900;
 Tue, 04 Feb 2020 07:52:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <5238532.OiMyN8JqPO@x2>
 <20200204131944.esnzcqvnecfnqgbi@madcap2.tricolour.ca> <3665686.i1MIc9PeWa@x2>
In-Reply-To: <3665686.i1MIc9PeWa@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 4 Feb 2020 10:52:36 -0500
Message-ID: <CAHC9VhRHfjuv5yyn+nQ2LbHtcezBcjKtOQ69ssYrXOiExuCjBw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 13/16] audit: track container nesting
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 10:47 AM Steve Grubb <sgrubb@redhat.com> wrote:
> On Tuesday, February 4, 2020 8:19:44 AM EST Richard Guy Briggs wrote:
> > > The established pattern is that we print -1 when its unset and "?" when
> > > its totalling missing. So, how could this be invalid? It should be set
> > > or not. That is unless its totally missing just like when we do not run
> > > with selinux enabled and a context just doesn't exist.
> >
> > Ok, so in this case it is clearly unset, so should be -1, which will be a
> > 20-digit number when represented as an unsigned long long int.
> >
> > Thank you for that clarification Steve.
>
> It is literally a  -1.  ( 2 characters)

Well, not as Richard has currently written the code, it is a "%llu".
This was why I asked the question I did; if we want the "-1" here we
probably want to special case that as I don't think we want to display
audit container IDs as signed numbers in general.

-- 
paul moore
www.paul-moore.com
