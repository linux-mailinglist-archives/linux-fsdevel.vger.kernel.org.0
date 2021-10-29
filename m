Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD743FFC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJ2PpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhJ2PpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:45:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C9CC061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 08:42:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e65so10263000pgc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkrK8/+uwUhU1+ibCc9sihgvRMe3oeCDEJlEEAsQMNY=;
        b=6wmVMWLAKN8exE8XR8wv/iFYhudFZm/xaEJpNEZmOxWSzGBAVEn+M6ckTQFipGdRJT
         yb6PYTTcKIVqTXGsV3bkPy2TCiq4+HLgRy2cRXBAvM33znfROc4XjMNFzIfr4UE69rdj
         4eISFf7aFEyAHo2Sf/MANtuSqjdRnwdAyb7h0RnbdOmg2MrJVd+mPCxh87qxZR21UV1T
         Jo7MDmjd0zsp2/1yCw8PZ5/EZTwQNFNoOJVWhez881Nf3OlrTKHfCKrLAxk43DLXDdPH
         n00SPDakiTsjm+voDnH7pSuvR7gHcdocX6KbBQemE5xaUaALVKmTKfT7gJVRpb96WLOa
         Bfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkrK8/+uwUhU1+ibCc9sihgvRMe3oeCDEJlEEAsQMNY=;
        b=uIBLaSFO72n55LaJmUyJqOvdB9zbVTre5JyxEkm3OTCylnvWyfzOTVkQYhzMHGNw16
         0ABGG587b2N6lEyPVYntK89HKoVkmhhF/Jj+BPehpJMLfewnPv4BlNZr6J4YDiyGJG1U
         5NZsjvNWtdbLwvE+Z5T/ebaQIqYfcVp/+SziI5uxpquTVWouGAIZKeRcfTM+PTGHkYLy
         oLqFP2ZZAA+dkztookn01CedYZYq9lTx1rcm9xE3O/0oxTY98qVBsK3bP7txbqR2weyb
         m4ZPzj1D2sZcpeMfcAjNS4BOtR0Ff7TzbTJ0c21JnqcFzN1Z6uOs8sKwos9HT53p/YhX
         o+dw==
X-Gm-Message-State: AOAM533u4pdDrxUMWQAvk5SoGvpVRagcq/ij5kK8zrs8PL605rg26PSs
        0lBYpmR6Cq3I0xiZ65invPZMid2m/5vw4faMV36k8A==
X-Google-Smtp-Source: ABdhPJwscYMJBcsf4QuT7rFuYsL/BYYBLAhJeu/07ZB2t6F9Qexmb3kIziq0UAiLr3A7UbGhuhxXArjTEfzlR4kAptU=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr11616698pfu.61.1635522160977; Fri, 29
 Oct 2021 08:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
 <20211029105139.1194bb7f@canb.auug.org.au>
In-Reply-To: <20211029105139.1194bb7f@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 08:42:29 -0700
Message-ID: <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > My merge resolution is here [1]. Christoph, please have a look. The
> > rebase and the merge result are both passing my test and I'm now going
> > to review the individual patches. However, while I do that and collect
> > acks from DM and EROFS folks, I want to give Stephen a heads up that
> > this is coming. Primarily I want to see if someone sees a better
> > strategy to merge this, please let me know, but if not I plan to walk
> > Stephen and Linus through the resolution.
>
> It doesn't look to bad to me (however it is a bit late in the cycle :-(
> ).  Once you are happy, just put it in your tree (some of the conflicts
> are against the current -rc3 based version of your tree anyway) and I
> will cope with it on Monday.

Christoph, Darrick, Shiyang,

I'm losing my nerve to try to jam this into v5.16 this late in the
cycle. I do want to get dax+reflink squared away as soon as possible,
but that looks like something that needs to build on top of a
v5.16-rc1 at this point. If Linus does a -rc8 then maybe it would have
enough soak time, but otherwise I want to take the time to collect the
acks and queue up some more follow-on cleanups to prepare for
block-less-dax.
