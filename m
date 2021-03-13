Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92A8339F15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 17:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhCMQYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 11:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhCMQYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 11:24:38 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BCBC061574;
        Sat, 13 Mar 2021 08:24:38 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id u3so28716383ybk.6;
        Sat, 13 Mar 2021 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXi6zxmykvKGGuEUIknBGQuu/CrpF+OFk8aqg1g8+Js=;
        b=Hv71HUzmf0Lv3L07Y9vPI88fr2tkUa/1JbFZGy51jjbh9n4cRQ+P6rLbvPAhZMLbg5
         ixsUkRYdDUhei4YCiRy0287CIkP8b3Jg9TpHICyCGV2xDgcQFoYiRrPDp0LcPbNyPobt
         e2mB8WjIyZJjUgnIK3eEg9rREEgBthIupmC5k7TJkMd1BdMNglR5MTBljFc4WnZL0Tv/
         2A5yFWAf2SP7q2tspr8wPFHgGP1dhWKjLEJrKe1jxyEujMO/6QhrAuiX6efY9Q0tZhFG
         jbv3PaYMyafnqAK7BZW4C9hHl2HDt27Z0jCW48yq0cRe9cKlFDPeNt9KBY4Z6kTHjtIk
         4+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXi6zxmykvKGGuEUIknBGQuu/CrpF+OFk8aqg1g8+Js=;
        b=RWpJp9ontZOvRMncYQydzhgd/kmxrCW8sA2Ss7LRhtcfOdDRN05N0BMdgwxBp9lcqV
         9RisfygBqY7VUHuBXgutd6LSgESo5NHywEPfFqyIquxFfPd60o++gNEwYxYFPqUgzt2J
         /UBPjHmaNb1A5kaNZIqtdN9YU5HjXDwaWNIpUkzVH9RUW8JzOB2p9ByW3gi6kjp9LKzQ
         gkPddsfWFIbCzF42F35daAAkB1Oxww0Jkh7Oi7QtNzGDLvMXoBptAcY0TuqUD9XMv06s
         Pj9of01etDCrGKMA4YkZgIMK308rmtskcCeS8WK0OO8A1KJvBQYuWzCGyi00TOUl80Jq
         2nWw==
X-Gm-Message-State: AOAM533KP5HXB3hBoclYsfK8ZYpxe/wiTlfCU/uEShCW3vneppsIz5/b
        oyTaM5gkLl9XCr50q3SQAOIr+c+Bg32n0WP3kms=
X-Google-Smtp-Source: ABdhPJwtKc3ckDh1wM2gREfAQUcazj9bOTqT8gJ/CC1jACL5d+N8mbIM5sD/vFtR/QEb1ipgGC33qgcC6cjdF7XgPjg=
X-Received: by 2002:a25:424f:: with SMTP id p76mr27228411yba.109.1615652676401;
 Sat, 13 Mar 2021 08:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org> <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org> <YEy4+SPUvQkL44PQ@angband.pl>
In-Reply-To: <YEy4+SPUvQkL44PQ@angband.pl>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sat, 13 Mar 2021 11:24:00 -0500
Message-ID: <CAEg-Je-JCW5xa6w5Z9n7+UNnLju251SmqnXiReA2v41fFaXAtw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 8:09 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> On Wed, Mar 10, 2021 at 02:26:43PM +0000, Matthew Wilcox wrote:
> > On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> > > DAX on btrfs has been attempted[1]. Of course, we could not
> >
> > But why?  A completeness fetish?  I don't understand why you decided
> > to do this work.
>
> * xfs can shapshot only single files, btrfs entire subvolumes
> * btrfs-send|receive
> * enumeration of changed parts of a file
>

XFS cannot do snapshots since it lacks metadata COW. XFS reflinking is
primarily for space efficiency.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
