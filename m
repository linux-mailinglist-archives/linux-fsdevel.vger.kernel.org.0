Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC69033C7CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCOUfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:35:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50766 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhCOUfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:35:02 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by linux.microsoft.com (Postfix) with ESMTPSA id 68C4820B39C5;
        Mon, 15 Mar 2021 13:35:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68C4820B39C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615840502;
        bh=PFdwLFSkPuwOM57gZ2BEzv85ziJRcSCOWcRFEpG9jeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P+W60vTAzH1v5LIl8INhl8akgG5ir/YrliPxeYc+5JUFws81uD540X6DWOsCCFKLL
         zokxDLTfuLgu9IRMphdjImqHuLx3D22t6lZwpdSKn+Y7IuPQ45zft4VRHeYw0AIKLs
         PTVstZ8t8yi5wC6PB3wtT/Yg/RWQlmgC5Ruohv/Q=
Received: by mail-pj1-f51.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so215364pjb.2;
        Mon, 15 Mar 2021 13:35:02 -0700 (PDT)
X-Gm-Message-State: AOAM531IO2NGc358WSe7fB0i5lnYnp3Pv9ZR+e8N+yeYZQiZDiDyfXGk
        SPE79e5wtuLbzxUdKr9EQYOBfMl8p8XFkAgakJY=
X-Google-Smtp-Source: ABdhPJzqcZesrfxHZp348Fs1TyxWSGkz8oWrITTvvw6RyZ6iExivLZrZuLUsNbRYpdRFzbjMksrTAP1Wgn2h5Ze8mjI=
X-Received: by 2002:a17:903:30cd:b029:e6:a1fa:403b with SMTP id
 s13-20020a17090330cdb02900e6a1fa403bmr10966417plc.43.1615840501925; Mon, 15
 Mar 2021 13:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-3-mcroce@linux.microsoft.com> <20210315201331.GA2577561@casper.infradead.org>
In-Reply-To: <20210315201331.GA2577561@casper.infradead.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Mon, 15 Mar 2021 21:34:26 +0100
X-Gmail-Original-Message-ID: <CAFnufp3gLfjKPsq4YaG6XtbsfJHUfVdJ65gmaZ-miNeUE8TLeA@mail.gmail.com>
Message-ID: <CAFnufp3gLfjKPsq4YaG6XtbsfJHUfVdJ65gmaZ-miNeUE8TLeA@mail.gmail.com>
Subject: Re: [PATCH -next 2/5] block: add ioctl to read the disk sequence number
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 9:13 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Mar 15, 2021 at 09:02:39PM +0100, Matteo Croce wrote:
> > +++ b/include/uapi/linux/fs.h
> > @@ -184,6 +184,7 @@ struct fsxattr {
> >  #define BLKSECDISCARD _IO(0x12,125)
> >  #define BLKROTATIONAL _IO(0x12,126)
> >  #define BLKZEROOUT _IO(0x12,127)
> > +#define BLKGETDISKSEQ _IOR(0x12,128,__u64)
> >  /*
> >   * A jump here: 130-131 are reserved for zoned block devices
> >   * (see uapi/linux/blkzoned.h)
>
> Not your bug, but this is now 130-136.
>
> +cc all the people who signed off on the commits that added those ioctl
> numbers without updating this comment.  Perhaps one of them will figure
> out how to stop this happening in future.

Note taken, thanks!

-- 
per aspera ad upstream
