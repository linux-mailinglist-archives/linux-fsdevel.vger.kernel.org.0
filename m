Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0FFDA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfD3QQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 12:16:11 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:52278 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfD3QQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:16:11 -0400
Received: by mail-it1-f180.google.com with SMTP id x132so5591412itf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7vha2sHMjrOUYPXWIWZ5r9+BQnrS0i2CpGkGubXy9c=;
        b=ZEvdr6d2+xG0yFqb8iyxrYut8QGgl1yzTRo7Ow5Vhy3IMx37a+DFMc0lnlKsNqOEyh
         QfEnblICo9oXNPzKDKbn1EkJaP/hdE7bbewTFezSBWSNvQwty7TvYsr12iOw2YYBVCuP
         la57aMu8L/5bKdx24NXSPUU/kI7ud0lQqKualXqmGSg63pBdzObacOlkHEqsOZjBpiay
         QQtckT0qJ7Wqvq/aN+CZBi02U6Jco2A7k7V2nDIU7ex0Ne5FJPYzSB8yLdKO1NaYpIbs
         ilkZSqXC+az16c77RXYrGtRfMLMrzpM/XzBDXOihzs+S7WLlPflrS70Jay48fo2t/T4/
         7DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7vha2sHMjrOUYPXWIWZ5r9+BQnrS0i2CpGkGubXy9c=;
        b=AWRDPQ8ARawIgQ/DIaAxQfrOOEKH7W7vPv5ZQXYteh/lXk1EfneVqDq1BJi4FzRhDv
         R/ZcBk8c6LbRQyT5FugLb5lNaAE8DWTBHggj6i9vDvua6pN+uBqFMLyn35yaMP5/CIaX
         03DxfcLYQH+WDvkG6nj8vDq9EkN76qyAg3H34Ktq5HvLaItMxcfDet3gKTdwEye4TUhP
         xO5rhab4ydIZs3FtItz5G/s3jieDhl66qq8P/A4ekE1Mu/kJVJbkSBUcsubbW94bkt/u
         qwdMiNVeMRL7REYoS4eVyMjd4/UgNuMMyKoNXoBRbrSK0dGp/OYLAQhRD+80KLEhgmNy
         wsTw==
X-Gm-Message-State: APjAAAU2WDWmtZBB5tupKL3Fys0BlqEGIsxGuhajRxDFbzvj1Ko2gZWb
        TIc6IFZZXet9VX9DGSoDP0mVPEVc4sPSk540SkM=
X-Google-Smtp-Source: APXvYqxGmNhS7O0WYezZ5KKWcc7qENQZPHTzvK4iRd2jiksYSG3ib+sPBWVyqkn+Y5lNBSxxbI1mNOxM3EPGGfmqec0=
X-Received: by 2002:a24:ac3:: with SMTP id 186mr4260160itw.16.1556640970373;
 Tue, 30 Apr 2019 09:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190429220934.10415-1-agruenba@redhat.com> <20190429220934.10415-6-agruenba@redhat.com>
 <20190430153256.GF5200@magnolia> <CAHc6FU5hHFWeGM8+fhfaNs22cSG+wtuTKZcMMKbfeetg1CK4BQ@mail.gmail.com>
 <20190430154707.GG5200@magnolia>
In-Reply-To: <20190430154707.GG5200@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 30 Apr 2019 18:15:58 +0200
Message-ID: <CAHpGcMKVE2=6xpUdWyDo8=tyyCWGYaO=Ni0+B_fGJRXiqwdt5g@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] gfs2: Fix iomap write page reclaim deadlock
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        =?UTF-8?B?RWR3aW4gVMO2csO2aw==?= <edvin.torok@citrix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 30. Apr. 2019 um 17:48 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> Ok, I'll take the first four patches through the iomap branch and cc you
> on the pull request.

Ok great, thanks.

Andreas
