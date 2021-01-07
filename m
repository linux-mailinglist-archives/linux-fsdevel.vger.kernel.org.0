Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E999A2ED495
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbhAGQoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 11:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGQoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:44:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99231C0612F5;
        Thu,  7 Jan 2021 08:43:28 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id s21so4183385pfu.13;
        Thu, 07 Jan 2021 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wlIZkPGKoQxUHBPSASacN9V2y3esHgkn8bU6DGmdh/U=;
        b=AdHaxLcS2e+H/EbRu2XgBJ2Q4XhNpzAE7sZFJLuDSeU33L8QmXXbyUoms1kmMAmLDQ
         NOomoUrvCpPmmaVU/m+hCT2xeKSdt5EHRRJLAF0rA5i4+1mJp2uvBGOISeZjQ9SKfAjS
         rcv2CkBLhyee7O5jHF8CVBlp3ub1JvClNRww2NYHQ9+omUQENnastCI7NNuaXckA4GPs
         vMYdvMOxO+omN3qD/1QoN38HTCPOnlUN9TQzn+eSU9YVSfOFQQO+bSNIRmg+pwiXUX4A
         HrOcHM4/G0Mng8xc4rNTVE4N5qYSj81xm4ts5v55aTltkLhNALa4dssrt6UKfv3SUz6e
         hf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wlIZkPGKoQxUHBPSASacN9V2y3esHgkn8bU6DGmdh/U=;
        b=PqazPwGICa0vdedcv5TIMgOv8vfrD5tyKGu9w4nUmoc65qLaVS/rh4malcGr1OjmVD
         VXe4ldiuj4XxLUCMDDuhKIMgyKH6TuyPrQWtPgk8YLFLsgtlCc+Gai05mnPJJp7f6yB1
         wvP3fIxqm6L4rk+n94oKx3z5KvW80JOXWmOXZKd3YJTzzS05DA2N3+orCprk4ofM4m/J
         wTb3eYT99MXJwzG3mp2lLihE+Zj0M9BfXAyUxFKLA/QhzDaeOEfh8VfvWjhQS//L+VIb
         yjzGCVt3SOXRfsD2/GD38DnGLHg6H5eiOr30E/QnY0p9LQxQD1y6IhiiNJCph5ij75j+
         oyEg==
X-Gm-Message-State: AOAM530UterfOIzRIugPlfytScGpqZImQbU3wfUwEoiY+GaBHdo/uAS4
        2hawxw1OCFd4LoyvE+cLm1c=
X-Google-Smtp-Source: ABdhPJyPiXtEd0GEQuaVCHAy2JP1TMLyh1OHWw65ZEzPXICZAme/iC9QnXymWl68ojN2928hSS4cJw==
X-Received: by 2002:a63:4c4b:: with SMTP id m11mr2690509pgl.20.1610037808072;
        Thu, 07 Jan 2021 08:43:28 -0800 (PST)
Received: from [127.0.0.1] (89.208.248.183.16clouds.com. [89.208.248.183])
        by smtp.gmail.com with ESMTPSA id mj5sm2591568pjb.20.2021.01.07.08.43.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:43:27 -0800 (PST)
From:   Mingkai Dong <mingkaidong@gmail.com>
X-Google-Original-From: Mingkai Dong <MinGKaiDong@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: Expense of read_iter
In-Reply-To: <20210107151125.GB5270@casper.infradead.org>
Date:   Fri, 8 Jan 2021 00:43:20 +0800
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, sunrise_l@sjtu.edu.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

We have also discovered the expense of `->read_iter` in our study on =
Ext4-DAX.
In single-thread 4K-reads, the `->read` version could outperform =
`->read_iter`
by 41.6% in terms of throughput.

According to our observation and evaluation, at least for Ext4-DAX, the =
cost
also comes from the invocation of `->iomap_begin` (`ext4_iomap_begin`),
which might not be simply avoided by adding a new iter_type.
The slowdown is more significant when multiple threads reading different =
files
concurrently, due to the scalability issue (grabbing a read lock to =
check the
status of the journal) in `ext4_iomap_begin`.

In our solution, we implemented the `->read` and `->write` interfaces =
for
Ext4-DAX. Thus, we also think it would be good if both `->read` and =
`->read_iter`
could exist.

By the way, besides the implementation of `->read` and `->write`, we =
have
some other optimizations for Ext4-DAX and would like to share them once =
our
patches are prepared.

Thanks,
Mingkai


> On Jan 7, 2021, at 23:11, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
>> I'd like to ask about this piece of code in __kernel_read:
>> 	if (unlikely(!file->f_op->read_iter || file->f_op->read))
>> 		return warn_unsupported...
>> and __kernel_write:
>> 	if (unlikely(!file->f_op->write_iter || file->f_op->write))
>> 		return warn_unsupported...
>>=20
>> - It exits with an error if both read_iter and read or write_iter and=20=

>> write are present.
>>=20
>> I found out that on NVFS, reading a file with the read method has 10%=20=

>> better performance than the read_iter method. The benchmark just =
reads the=20
>> same 4k page over and over again - and the cost of creating and =
parsing=20
>> the kiocb and iov_iter structures is just that high.
>=20
> Which part of it is so expensive?  Is it worth, eg adding an iov_iter
> type that points to a single buffer instead of a single-member iov?
>=20
> +++ b/include/linux/uio.h
> @@ -19,6 +19,7 @@ struct kvec {
>=20
> enum iter_type {
>        /* iter types */
> +       ITER_UBUF =3D 2,
>        ITER_IOVEC =3D 4,
>        ITER_KVEC =3D 8,
>        ITER_BVEC =3D 16,
> @@ -36,6 +36,7 @@ struct iov_iter {
>        size_t iov_offset;
>        size_t count;
>        union {
> +               void __user *buf;
>                const struct iovec *iov;
>                const struct kvec *kvec;
>                const struct bio_vec *bvec;
>=20
> and then doing all the appropriate changes to make that work.
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

