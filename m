Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DACB802B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbfISRl5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 13:41:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39787 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390909AbfISRlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:41:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so3074560ljj.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FiZz07Z/205AAVNujcqJzuj2VRlA1gVyITjZ2X3S9P0=;
        b=LUgHYlFO2ivHWXkjIMWHXKro3f62RmlbsjtZDM3aN1lBnbF/0enyMjBYRqw1bvQU+o
         WjuX6sn56vnQRYqFCSVxl5+izbPmn5JthFgQ1CVdOhSEm0KaDtohrjU8sSopQtoAQ4n6
         i+xMWyf0WARK8PenV7l026IzYlve6DXyQGV3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FiZz07Z/205AAVNujcqJzuj2VRlA1gVyITjZ2X3S9P0=;
        b=dytWKFibYFxl6ScpicbfIBQ860JcGgc8uhtRzGH5cWKThNnlSJEPGK9YR5OB83i7oZ
         PdaHuGxpP0mqHLskdIi5VgLcsyu0B7DUZa90BzXcR2BTc1V4DBAymFKTh6jHeB+uRmlo
         BgeN022wz3Sd0tsFH8fTXDHb6RMHooo2M6PniilRW7s1b/Rhk2bk3RYwOsqHhsyrquoM
         APcnGaxrJ1+GFXgHpc95U5S5VkoRMz76DnbvBxyBp2GlG9j3jKc0N3K6hnYBJ5m+f7UI
         ZezRm0ksJyc6CnxqS9CfRtWEp8OfE37ixGs95WZDtltojpXsSJLZfnQvulNVyetI1U9Y
         wsCA==
X-Gm-Message-State: APjAAAXFi6Lqz/XA6X2ROokoirMnbbZinNMMW8xn1jRBZDZTyF+pbbC7
        XiB55s1trYvAWCopoLVhYcSCbH5MrKY=
X-Google-Smtp-Source: APXvYqxry87741ZmKOwoEGbFKeT1v2dXj2Cqs2qeHIHytXBZ/AytSJ0ujlD+DH2YXz5jZ2JhSIMeww==
X-Received: by 2002:a2e:9e8f:: with SMTP id f15mr1042793ljk.212.1568914911939;
        Thu, 19 Sep 2019 10:41:51 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i17sm1700629lfj.35.2019.09.19.10.41.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:41:50 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id r134so2974114lff.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 10:41:50 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr5665094lfm.170.1568914909864;
 Thu, 19 Sep 2019 10:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
 <20190919034502.GJ2229799@magnolia> <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
 <20190919170711.GA9065@lst.de>
In-Reply-To: <20190919170711.GA9065@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 10:41:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK7+TtDRbSAmcM5ihBDxF4eCg7zAXDkrNm7DOg+RtzyA@mail.gmail.com>
Message-ID: <CAHk-=wgK7+TtDRbSAmcM5ihBDxF4eCg7zAXDkrNm7DOg+RtzyA@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I personally surived with it, but really hated writing the open coded
> list_for_each_entry + list_del or while list_first_entry_or_null +
> =E2=94=90ist_del when I could have a nice primitive for it.  I finally de=
cided
> to just add that helper..

You realize that the list helper is even mis-named?

Generally a "pop()" should pop the last entry, not the first one. Or
course, which one is last and which one is first is entirely up to you
since you can add at the tail or the beginning. So even the name is
ambiguous.

So I really think the whole thing was badly implemented (and yes, part
of that was the whole implementation thing).

Doing list_del() by hand also means that you can actually decide if
you want list_del_init() or not. So it's

But again - keep that helper if you want it. Just don't put a badly
implemented and badly named "helper" it in a global header file that
_everybody_ has to look at.

                   Linus
