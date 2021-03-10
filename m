Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ABB333F60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 14:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhCJNgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 08:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhCJNgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:36:43 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D120C061760;
        Wed, 10 Mar 2021 05:36:43 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id b10so17876348ybn.3;
        Wed, 10 Mar 2021 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2aYptJ+Gov2C+oARQmlRLopxW2URRuwXw1AKwLGZv1E=;
        b=lpoFJtg+RfBaF3k+0slfbJr1UD9yvARkoMbBl9MWr5rmcJvOHNz8P65bPDF0DzSKLZ
         A3QopQpfSEcP9hG6NFxwAymzBtPvh9QtuREgkj9DQjN9L8S9GwxojaVH5XTEDnVF4bQA
         sMnKkKxuoVoJRr9q12QkvPO1QPeOriCBtg4BBD7uVIji+3DiHwzqJJj7m+b17VLR6Y0I
         q9ykpG9dwvTB05YeMwCb59uPHELbo+jaZKbPrWda81m5JAPQL+ZZ1OluKZ7IDbefl91g
         9ceIqeicNGysV//j//GKZJRSGU2l1tIS6W2s+tKKgHsfQeKrQgjbRQJws2xtrkEhX9Kt
         ZXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2aYptJ+Gov2C+oARQmlRLopxW2URRuwXw1AKwLGZv1E=;
        b=nZOWR/QPiTGVea/EBlLrzpvp8b9/nkppZ1c5SnlM5WJI0cIfCNvgqeYezlgKCMfNus
         I2kXb2Ut4St+Ki/UtQo8YZ5Qwq5a2p8Gf/R7ST4xIrWCozXaVN20EOhX/BOpk3BNwC3U
         JpowUd0RKAqW7Tbssj4PnHJztcfNMIFafH8U+vMufSAxIXMnnMBExWw4iHRI9Ysuqyy0
         +5F0SMAUQKXroPVBtif9/jG2/3hxstPpnLmDZVj+LjcOSft5q9Xs8OYqqOyQdsOK2meT
         19TAe1poSv6kdo7dBZAVeNiZSxohylGuANybLT2uudSfggChTnhlKu0raRxVPno32HD2
         v17A==
X-Gm-Message-State: AOAM532OTJYJQsn+4NkpqmRs8ikkg8UCGzdZ1Yz5t8/t2UFaRdku/IWA
        oz8D7doCwB/kvoiPOOKfoICakkQAZEDzC1EuBzE=
X-Google-Smtp-Source: ABdhPJz1jxdINaxIIQwiE1/7TJj4kvjkB1loYv97hj60cdpiwpI1AFhO8/qRMCL4/0SP4ps/aG+kQlYilaoS6/0nAb8=
X-Received: by 2002:a25:d8f:: with SMTP id 137mr1981743ybn.47.1615383402310;
 Wed, 10 Mar 2021 05:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com> <20210310130227.GN3479805@casper.infradead.org>
In-Reply-To: <20210310130227.GN3479805@casper.infradead.org>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 10 Mar 2021 08:36:06 -0500
Message-ID: <CAEg-Je-F6ybPPV22-hq9=cuUCA7cw2xAA7Y-97tKhYUX1+fDwg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        darrick.wong@oracle.com, dan.j.williams@intel.com, jack@suse.cz,
        viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 8:02 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > Forgive my ignorance, but is there a reason why this isn't wired up to
> > Btrfs at the same time? It seems weird to me that adding a feature
>
> btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX suppor=
t.
>
> If you think about it, btrfs and DAX are diametrically opposite things.
> DAX is about giving raw access to the hardware.  btrfs is about offering
> extra value (RAID, checksums, ...), none of which can be done if the
> filesystem isn't in the read/write path.
>
> That's why there's no DAX support in btrfs.  If you want DAX, you have
> to give up all the features you like in btrfs.  So you may as well use
> a different filesystem.

So does that mean that DAX is incompatible with those filesystems when
layered on DM (e.g. through LVM)?

Also, based on what you're saying, that means that DAX'd resources
would not be able to use reflinks on XFS, right? That'd put it in
similar territory as swap files on Btrfs, I would think.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
