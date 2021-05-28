Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7139454C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhE1Po2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 11:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235072AbhE1Po1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 11:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622216572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sC/4mqGVwjGmarPwyWnSGWMjis6RsnduR1OTuOfsgPQ=;
        b=fNck41KMsnfRon9k5u2SYW5M+8HovxeN6A94+qedbZ2JoVyaxV0u209EdJ3Iex41R37ru2
        NoyiTCQWW3eNXs+UHfQB1TR/fQ03WKVOxqES4gXJVRxdG+FSysPpvlOaYM7LS+kurX229E
        YOwu7wVhk9IORWSm8YcbkNXFGeXyKD8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-ffZQzZj0OGCeytG3kU5Rkg-1; Fri, 28 May 2021 11:42:50 -0400
X-MC-Unique: ffZQzZj0OGCeytG3kU5Rkg-1
Received: by mail-ed1-f69.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so2343570edd.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 08:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sC/4mqGVwjGmarPwyWnSGWMjis6RsnduR1OTuOfsgPQ=;
        b=XQq11SrWEXD4V7JJcj/BRi8+msiG+1XxyqQdTtAgOVTNqELgjloeZYP5GLpBya1AQJ
         47Nz46Noz8O6CduaO7foXWIu2xq3UxE9OesaO1IPlSQ9JSNDQGdCMjqqF0QtOd1KjHk/
         vHmjgZYoyut+h6qMVqDkH1MJ6vRGKS7Te6Sj8YfFMX8hdwVySXZANlUExqoF4Ks9sia0
         Tj/Pufl2qmO9/G+TrlEO231xoSEeAy4Klm8RwJ4+rrqlrbebOlUzzLgWA7oFrxF63dZJ
         tqKtQGKQ8Ec7sPb5pEWm1drNdn5FpzqVYIAha3hBVGTzd8LZ4eHHaSjQj2XibxcNaVWQ
         N+mw==
X-Gm-Message-State: AOAM531wBQOxWfZdK/GqPkKYqLCrCvnatfArL3UBLr7Gel3aqFzxteGF
        k/ZO3CjUtBmHQi9Ep78UDBkOoYZHhSlpfjy1TncAIfj9ZcS6jw6RkGVz1bBAIXkHLvnh92j7vgy
        ph+68xn666d2/9j1fdeW17URb0w==
X-Received: by 2002:a50:d589:: with SMTP id v9mr10813399edi.126.1622216569044;
        Fri, 28 May 2021 08:42:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyh7puphKWIHAhTU3NrGDcpIPKc1l/cTOKXvbBu9zHj9YOh1870e+pFMIR14K/Zqb2VV4uAA==
X-Received: by 2002:a50:d589:: with SMTP id v9mr10813361edi.126.1622216568644;
        Fri, 28 May 2021 08:42:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v24sm2839644eds.19.2021.05.28.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 08:42:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 86A4A180720; Fri, 28 May 2021 17:42:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
In-Reply-To: <YLEIKk7IuWu6W4Sy@casper.infradead.org>
References: <YH2hs6EsPTpDAqXc@mit.edu>
 <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <YLEIKk7IuWu6W4Sy@casper.infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 May 2021 17:42:47 +0200
Message-ID: <87im32g8zs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, May 28, 2021 at 07:58:10AM -0700, James Bottomley wrote:
>> On Thu, 2021-05-27 at 15:29 +0200, Greg KH wrote:
>> > On Thu, May 27, 2021 at 03:23:03PM +0200, Christoph Lameter wrote:
>> > > On Fri, 30 Apr 2021, Theodore Ts'o wrote:
>> > > 
>> > > > I know we're all really hungry for some in-person meetups and
>> > > > discussions, but at least for LPC, Kernel Summit, and
>> > > > Maintainer's Summit, we're going to have to wait for another
>> > > > year,
>> > > 
>> > > Well now that we are vaccinated: Can we still change it?
>> > > 
>> > 
>> > Speak for yourself, remember that Europe and other parts of the world
>> > are not as "flush" with vaccines as the US currently is :(
>> 
>> The rollout is accelerating in Europe.  At least in Germany, I know
>> people younger than me are already vaccinated.  I think by the end of
>> September the situation will be better ... especially if the EU and US
>> agree on this air bridge (and the US actually agrees to let EU people
>> in).
>> 
>> One of the things Plumbers is thinking of is having a meetup at what
>> was OSS EU but which is now in Seattle.  The Maintainer's summit could
>> do the same thing.  We couldn't actually hold Plumbers in Seattle
>> because the hotels still had masks and distancing requirements for
>> events that effectively precluded the collaborative aspects of
>> microconferences, but evening events will be governed by local
>> protocols, rather than the Hotel, which are already more relaxed.
>
> Umm.  Let's remember that the vaccines are 33-93% effective [1],
> which means that there's approximately a 100% certainty that at least
> one person arriving at the event from a trans-atlantic flight has been
> exposed to someone who has the virus.  I'm not convinced that holding a
> "more relaxed protocol" event is a great idea.

Not to mention the fact that this would exclude everyone from parts of
the world that do not have a high vaccine coverage or a cosy "air
bridge" type relationship with the US (whatever that means); aren't we
supposed to be an international community? :/

-Toke

