Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892314A8010
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 09:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbiBCIAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 03:00:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51014 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiBCIAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:00:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C8E5617F4;
        Thu,  3 Feb 2022 08:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A34BC340ED;
        Thu,  3 Feb 2022 08:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643875205;
        bh=tcX8LIbHCA4Zk3lFwo+HPnF8LmxHxTVGibknTOr1ThU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ezd3D/jxXPj0WYRF2rsf4Ihiw90Y5Thnu6MBM9qOlMRs/AU5hkWAPwQPNTXh1BlrB
         qDYG9Y9XKNqpv9os+C22n3XXq57LShM6dlI0tYlpp0rAh5NrECoVueX1FVMmotzQz9
         joBtZBf5GuKpWTRMt8Ud7ob4tLUXRSAHpC7582YC1fLd5pOApPHD4iPyugns/L2oXs
         GtQ41GlhfWWrhBT0dkeoQ4G7ZwwAMUtT7zNd6tCmC0T3UL9P8eUF3ROa7zNPURMAro
         YjqRn2Qjefj5mlpCGYOGVgTE15zDzLWmmnI+fC/9mscBBL2200EZEtTHpEZAPNA0ei
         bvYe36yK55R9A==
Received: by mail-yb1-f176.google.com with SMTP id j2so6599423ybu.0;
        Thu, 03 Feb 2022 00:00:05 -0800 (PST)
X-Gm-Message-State: AOAM531lC4FkeXxKoopz5qxCMsSI1yvDe3gys4G+BCJ3pU/aZ3ZFB/GI
        wZZhBhbCHC/8BYp40bu/9EoiBtJUnkvRMqeHusQ=
X-Google-Smtp-Source: ABdhPJzdE2ioIEf1+Sq74wB6EaJWIx20bW1vzF6ga6gxrpgj4ovLmfesnI29lbZesr3w2WZ7lTrS+AXG37YDjn21rmM=
X-Received: by 2002:a25:2fca:: with SMTP id v193mr47317542ybv.475.1643875204587;
 Thu, 03 Feb 2022 00:00:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:b08e:b0:127:3295:9956 with HTTP; Thu, 3 Feb 2022
 00:00:04 -0800 (PST)
In-Reply-To: <YftT5X0s6s5b8DiL@zeniv-ca.linux.org.uk>
References: <YfdCElWBOdOnsH5b@zeniv-ca.linux.org.uk> <CAKYAXd-k=AvMcxsJg1rVsY2PPhsZuRUegqAhEFB2r-qXH3+5-w@mail.gmail.com>
 <YftT5X0s6s5b8DiL@zeniv-ca.linux.org.uk>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 3 Feb 2022 17:00:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-TrY=6p4NAi=0x8+nHvKCemFsa7OFZXNjpz8ZzH-SXrA@mail.gmail.com>
Message-ID: <CAKYAXd-TrY=6p4NAi=0x8+nHvKCemFsa7OFZXNjpz8ZzH-SXrA@mail.gmail.com>
Subject: Re: [ksmbd] racy uses of ->d_parent and ->d_name
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-02-03 13:02 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> On Thu, Feb 03, 2022 at 08:16:21AM +0900, Namjae Jeon wrote:
>
>> > 	Why is so much tied to "open, then figure out where it is" model?
>> > Is it a legacy of userland implementation, or a network fs protocol
>> > that
>> > manages to outsuck NFS, or...?
>> It need to use absolute based path given from request.
>
> Er... yes?  Normal syscalls also have to be able to deal with pathnames;
> the sane way for e.g. unlink() is to traverse everything except the last
> component, then do inode_lock() on the directory you've arrived at, do
> lookup for the final component and do the operation.
>
> What we do not attempt is "walk the entire path, then try to lock the
> parent of whatever we'd arrived at, then do operation".  Otherwise
> we'd have the same kind of headache in all directory-manipulating
> syscalls...
>
> What's the problem with doing the same thing here?  Lack of convenient
> exported helpers for some of those?  Then let's sort _that_ out...
> If there's something else, I'd like to know what exactly it is.
I have fully understood what you point out. if filename_parentat() and
__lookup_hash() can be exported in vfs, they can be used in ksmbd for
this issue.
I'll check it more and get your ack if I need more change in vfs.

Thanks!
>
