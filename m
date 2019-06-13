Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7244980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 19:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFMRSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 13:18:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33194 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfFMRSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:18:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id x2so22548541qtr.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ECRuDs1AAJXccME5fjhnIagUHhl7wP1zzfkz6zfy+gs=;
        b=lpafWUUxvoz6cw8t6bvxhkbpKx1MuDJC/6+rsfIk9kELesUHNICDeurjA/f9ZuoaJv
         lKvrldgcxc6rNvpGlf+9lPT2riW0RE1+HuS2OqxKuK9J/UHHXstRF22tdIYHVfy+KlvT
         LRXs02nEuzM/Fk4kx+1bbgAFr8bE6dMuPmxEyYZicAywAmS5YuFqquENcwoxV3ALaTJr
         wrm1jUeHUGOSNU/aAA8xVX35TgozP9YEYH5RVAbReFiyARjThtZ1Rs+sS5w3QP1kXXnb
         Bg53NxX8LuVo7QxF8lvDT58SoxeM97wjJy7wRjhtAvG+RnkgIyeQxLZquacOghksiJH/
         /FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ECRuDs1AAJXccME5fjhnIagUHhl7wP1zzfkz6zfy+gs=;
        b=PcQUsE7Q5TeXCxRgI16igjgNfTbGfuoz1bEPk9yhSqXHNmSE+cYuTgoPwHy5z4WyXq
         nIFJ4Si9N4EvlwsWm7frjCUQk47019wPMi6v+23amqY6oO30DXfrhNvQlBtqk2GeWDeA
         ox3JhtkX1NW/8ARbepEllVgc/+5gnU9HA+HkAGzL1slCUTEudY1FVOWhO9mMavoydQQK
         W4pi3PNULKJd15akhwjsBe8Y7lHkkxScyKfGlFJbCUmSD9QjPYmGr3D6kcsc/Fx4q3tQ
         IunuotV8TiBC+EFklrGSHpBc3z6FZY4SsxEwOVKV1g2ay+gBS+wdKXMy2J/7bNsjCiow
         nnfw==
X-Gm-Message-State: APjAAAV/9HBEv8dvTYA1+ArEGfYKQSX7aTVcBOC/yCS9I0CvrAmmSvJU
        Yi2I3VN5l2SdkSqKZ9+1erR4Tg==
X-Google-Smtp-Source: APXvYqxo9wZDsL+u9xxF1oR9luzN2plR83tNtwXpM5LjZTCeK+hD6TjhoexGVCwTWwyvS0UUHoLRyg==
X-Received: by 2002:aed:3686:: with SMTP id f6mr53799960qtb.30.1560446315300;
        Thu, 13 Jun 2019 10:18:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l3sm76969qkd.49.2019.06.13.10.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 10:18:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbTMw-000325-3P; Thu, 13 Jun 2019 14:18:34 -0300
Date:   Thu, 13 Jun 2019 14:18:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613171834.GE22901@ziepe.ca>
References: <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca>
 <20190612120907.GC14578@quack2.suse.cz>
 <20190612191421.GM3876@ziepe.ca>
 <20190612221336.GA27080@iweiny-DESK2.sc.intel.com>
 <CAPcyv4gkksnceCV-p70hkxAyEPJWFvpMezJA1rEj6TEhKAJ7qQ@mail.gmail.com>
 <20190612233324.GE14336@iweiny-DESK2.sc.intel.com>
 <CAPcyv4jf19CJbtXTp=ag7Ns=ZQtqeQd3C0XhV9FcFCwd9JCNtQ@mail.gmail.com>
 <20190613151354.GC22901@ziepe.ca>
 <CAPcyv4hZsxd+eUrVCQmm-O8Zcu16O5R1d0reTM+JBBn7oP7Uhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hZsxd+eUrVCQmm-O8Zcu16O5R1d0reTM+JBBn7oP7Uhw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 09:25:54AM -0700, Dan Williams wrote:
> On Thu, Jun 13, 2019 at 8:14 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Jun 12, 2019 at 06:14:46PM -0700, Dan Williams wrote:
> > > > Effectively, we would need a way for an admin to close a specific file
> > > > descriptor (or set of fds) which point to that file.  AFAIK there is no way to
> > > > do that at all, is there?
> > >
> > > Even if there were that gets back to my other question, does RDMA
> > > teardown happen at close(fd), or at final fput() of the 'struct
> > > file'?
> >
> > AFAIK there is no kernel side driver hook for close(fd).
> >
> > rdma uses a normal chardev so it's lifetime is linked to the file_ops
> > release, which is called on last fput. So all the mmaps, all the dups,
> > everything must go before it releases its resources.
> 
> Oh, I must have missed where this conversation started talking about
> the driver-device fd. 

In the first paragraph above where Ira is musing about 'close a
specific file', he is talking about the driver-device fd.

Ie unilaterally closing /dev/uverbs as a punishment for an application
that used leases wrong: ie that released its lease with the RDMA is
still ongoing. 

Jason
