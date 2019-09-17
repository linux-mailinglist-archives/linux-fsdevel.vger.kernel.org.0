Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E109B5384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfIQRA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 13:00:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36640 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfIQRA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:00:27 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so9372733iof.3;
        Tue, 17 Sep 2019 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jYOweZ0rxhmnePFS/llmJp6Yh57JUIF1QJ4NdPTHKc=;
        b=i7LwZ+TZgy4D0p+LAMp/b+wOQq+OYg2GFxXN5CelsgKEF+LTWdvdkN4749rpGZWezr
         PDB7k67WMJ4+m+5x+qrpyfSVCsClClnJn2KgwK8Lk7ys34QiyRfZ0z/oitNPVPavm7XB
         bt/IMad9eypF8gsnBk4wDxWzsB3xhC9tZsi70VSU1R0PMDEtYWaDrua/Rv8TAcjFOMBp
         GHWq8QzAmtjT4mhsCtr043YJqJPIAnLeFdT7kwIkLfuiRLzSZdZ//mjKfxy23+ESOWnv
         av+hxvjlT1jThH9l3eQI83atxhcV1YpE9E1uxxhYCWaXb+EUyQMP+eHGCwY5PW1uGy9l
         Zwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jYOweZ0rxhmnePFS/llmJp6Yh57JUIF1QJ4NdPTHKc=;
        b=mI2SoQWeOAZtWrVpp2NGQTIFTO3D5PJIyh2g5NxHfYfENRWpksP+cOEvHQHkrQBcsB
         V66v6hSQkO802DbJK9qpIg680dOBDc7+BzsruvOSFzUdS7URnDZIuRDRagxjwtpACxCr
         eZ5m8+IkK+mvCWgDyX77IW817AtnBHwyV7wLqTPurb10Vp+IF+OYxvznIM7IsX5Tt7U+
         rqlH+W8kgLnOhHfxOIBvLuOHrpJB7ryvSUw0sCJGHi87EjF3EWVPiJ+V3FKSO3Gj1lLD
         cMEvGHbISqezUbOAF9YLteZAwmWj1ARYczXHusdEwRUGQEU6AdcgMU4k0+CO9B1qQ0/7
         CtFg==
X-Gm-Message-State: APjAAAUk8/4b/MHYNP8gDnaBPuV+xH6hA6kfvbTpUzhnU2F6VTAWiPoT
        rIcq2F983StFLBrk1fQduYYKm7TSC/AJz/3BcS4=
X-Google-Smtp-Source: APXvYqwKM6SdU9pGL9bgr8f7lfYvkQ/QNu7816qRonOBvZDfzA6ZKaMg3vH/1tnIKeRYqzuP/Kn4dabouI9piHD9YmM=
X-Received: by 2002:a5d:8b87:: with SMTP id p7mr4763235iol.50.1568739626836;
 Tue, 17 Sep 2019 10:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190829161155.GA5360@magnolia> <20190830210603.GB5340@magnolia>
 <20190905034244.GL5340@magnolia> <CAHpGcM+iYfqniKugC-enWnx+S3KT=8-YtY9RRcr4bVhG8GtkOA@mail.gmail.com>
 <20190917164605.GM5340@magnolia>
In-Reply-To: <20190917164605.GM5340@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 17 Sep 2019 19:00:15 +0200
Message-ID: <CAHpGcMKfiygNKD0s2MMyQnkKu+0GVANCejVpNESspTszeUy4Tw@mail.gmail.com>
Subject: Re: [PATCH v2] splice: only read in as much information as there is
 pipe buffer space
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 17. Sept. 2019 um 18:46 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> > Is this going to go in via the xfs tree?
>
> I'll let it soak in -next for a few days and send a single-patch pull
> request for it.
>
> (I'm sending out pull requests today for the things that have been
> ready to go for the last couple of weeks.)

Okay, works for me.

Thanks,
Andreas
