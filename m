Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DF1E5D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 01:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfENXyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 19:54:15 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53400 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfENXyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 19:54:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 58BE08EE109;
        Tue, 14 May 2019 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557878054;
        bh=j9GFywY1HLyNTdpWDqU6DRZqFaBO1GawDh8yt+cMaqU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dZV9RO/IA1wL58RbfktzvhF4K1xZl/4zGz3TLRxcm5GlTLjC8covABFSucBWREaS9
         OSBPyqqim2IdYRtdQFIEyy2fzVtY/Vq9MwU3Jngf6/fjS6Z38hRGtcegh99WZyvLSm
         aWkuGylJdngUC4YlL6U49VhosDHd1xpTt5qV56rc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id woy7T4AMZn2a; Tue, 14 May 2019 16:54:14 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9FDBB8EE0ED;
        Tue, 14 May 2019 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557878054;
        bh=j9GFywY1HLyNTdpWDqU6DRZqFaBO1GawDh8yt+cMaqU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dZV9RO/IA1wL58RbfktzvhF4K1xZl/4zGz3TLRxcm5GlTLjC8covABFSucBWREaS9
         OSBPyqqim2IdYRtdQFIEyy2fzVtY/Vq9MwU3Jngf6/fjS6Z38hRGtcegh99WZyvLSm
         aWkuGylJdngUC4YlL6U49VhosDHd1xpTt5qV56rc=
Message-ID: <1557878052.2873.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Rob Landley <rob@landley.net>, Andy Lutomirski <luto@kernel.org>
Cc:     Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org
Date:   Tue, 14 May 2019 16:54:12 -0700
In-Reply-To: <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
         <20190512194322.GA71658@rani.riverdale.lan>
         <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
         <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
         <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
         <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
         <1557861511.3378.19.camel@HansenPartnership.com>
         <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-05-14 at 18:39 -0500, Rob Landley wrote:
> On 5/14/19 2:18 PM, James Bottomley wrote:
> > > I think Rob is right here.  If /init was statically built into
> > > the kernel image, it has no more ability to compromise the kernel
> > > than anything else in the kernel.  What's the problem here?
> > 
> > The specific problem is that unless you own the kernel signing key,
> > which is really untrue for most distribution consumers because the
> > distro owns the key, you cannot build the initrd statically into
> > the kernel.  You can take the distro signed kernel, link it with
> > the initrd then resign the combination with your key, provided you
> > insert your key into the MoK variables as a trusted secure boot
> > key, but the distros have been unhappy recommending this as
> > standard practice.
> > 
> > If our model for security is going to be to link the kernel and the
> > initrd statically to give signature protection over the aggregate
> > then we need to figure out how to execute this via the distros.  If
> > we accept that the split model, where the distro owns and signs the
> > kernel but the machine owner builds and is responsible for the
> > initrd, then we need to explore split security models like this
> > proposal.
> 
> You can have a built-in and an external initrd? The second extracts
> over the first? (I know because once upon a time conflicting files
> would append. It sounds like the desired behavior here is O_EXCL fail
> and move on.)

Technically yes, because the first initrd could find the second by some
predefined means, extract it to a temporary directory and do a
pivot_root() and then the second would do some stuff, find the real
root and do a pivot_root() again.  However, while possible, wouldn't it
just add to the rendezvous complexity without adding any benefits? even
if the first initrd is built and signed by the distro and the second is
built by you, the first has to verify the second somehow.  I suppose
the second could be tar extracted, which would add xattrs, if that's
the goal?

James

