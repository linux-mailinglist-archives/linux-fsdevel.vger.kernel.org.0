Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB2B7F98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 19:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfISRFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 13:05:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37028 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732051AbfISRFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:05:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so2930105lff.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cG/q3cFRYsyXfs7WGIDIqxPhNH59Y8kVxp4a4QrtYec=;
        b=E2cDdbP2/fhgtUxeWn9F/GPtmg03tInrSSBmBjgzSx2QzM61s/GaEXUloJz81ijobL
         PDNb7lDrr/uWOWaQGMcZ/bzgSkg2A+IktHmv0xZxrybAdkgVOGCSAErBYug47C0mIo+0
         3rMkP4xNaakXDWOWhasJcY2phrxijQ6+lzNPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cG/q3cFRYsyXfs7WGIDIqxPhNH59Y8kVxp4a4QrtYec=;
        b=KoSlmpmOdd43bL/+srVvIIpAQGfeVCsjBR4rtOTQRgNRklYhyWm49Sh/RVz0eQHclz
         RSoFznIppVbym4qOgzrkOx3bJnv5kKKbYfBz7tPnoHeojxZmgLTcGcrr9wG4Alf+k9IA
         qWvOn1Cscg8c+WHHDTo8feaUY/FH30JgzMFyjqO1kSfWp5/nF96jsuIZo2wyRbPtg6ZD
         NF2k4T6CieRnzIZU8l9+Tm+pAsnuWD292mYskqTkpL+PCEiRmZ1LMR/ZL5KODUK7RovM
         XOwLX8Pn0wYLYghP5CltiYJABibBIzIiBMMXClAlXCJ9+ljBQxtgSTREBGTKADWpkQxw
         HhTQ==
X-Gm-Message-State: APjAAAUeLlgmV/v57TVoWn/aSPwZGZukM+Zj8vSBTrT3kb4MG3/PIfVi
        CdDBePYZ+Nhu3jLrP/yH9O2z4DeBlRY=
X-Google-Smtp-Source: APXvYqzt8UFWgiHcd1w5OSnSHbCZTxyE5QqWHwe5zGJcqJbXuLlx9Veu58VviMOKN4+obx0MnvQm2g==
X-Received: by 2002:a19:488f:: with SMTP id v137mr5398709lfa.26.1568912701542;
        Thu, 19 Sep 2019 10:05:01 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id l3sm1666777lfc.31.2019.09.19.10.05.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:05:00 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id r22so2934153lfm.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 10:05:00 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr5615990lfp.134.1568912700141;
 Thu, 19 Sep 2019 10:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
 <20190919034502.GJ2229799@magnolia> <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
In-Reply-To: <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 10:04:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS25dNe=zj8s8w0ppGoL33JQczQWdF406ubnkJHQ9izg@mail.gmail.com>
Message-ID: <CAHk-=wjS25dNe=zj8s8w0ppGoL33JQczQWdF406ubnkJHQ9izg@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:03 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So inside of xfs, that "pop ioend from the list" model really may make
> perfect sense, and you could just do
>
>     static inline struct xfs_ioend *xfs_pop_ioend(struct list_head *head)

Note that as usual, my code in emails is written in the MUA, entirely
untested, and may be completely broken.

So take it just as a "maybe something like this works for you".

             Linus
