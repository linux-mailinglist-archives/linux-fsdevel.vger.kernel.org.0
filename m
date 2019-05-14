Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98A1CFBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfENTSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 15:18:35 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48764 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbfENTSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 15:18:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EEA368EE109;
        Tue, 14 May 2019 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557861514;
        bh=kEo/SVpo1ALfduxjBL6j4BgvcDYrykkEFotN47vMdpo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FYrdoogoLnISQM1Gna4zR8dFz0m1XqoyYVy6MoFrTEVnU1hi7m7DSZV3h/A2XZcZK
         HsqRkNweLASCPrYAmWtU/51Zax8vrUpzjyu751TcYxE1QZc61MAVSntV/NhaZG+E5j
         phj1QTEdYcMFyulxVm8BeM7Q6aZReGPxpRKST4Lk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QdQKJpAzFTsY; Tue, 14 May 2019 12:18:33 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4F2438EE0ED;
        Tue, 14 May 2019 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557861513;
        bh=kEo/SVpo1ALfduxjBL6j4BgvcDYrykkEFotN47vMdpo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JeEEo+NfnkowNE+9caNm6hsbGtn0T6bU8NF+hBTf94ux0+YI/Yfe8OsASW6MhvDb3
         wtySyGjG0MToAmT+lQFezolyaeD/lHNHpWchGwk0XgpylgDu2zsE3rXzmufIdJJEXa
         ko7T09bgCGxuMzfgUSW2rrqIqCefgkntCBg38DTI=
Message-ID: <1557861511.3378.19.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org
Date:   Tue, 14 May 2019 12:18:31 -0700
In-Reply-To: <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
         <20190512194322.GA71658@rani.riverdale.lan>
         <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
         <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
         <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
         <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-05-14 at 08:19 -0700, Andy Lutomirski wrote:
> On Mon, May 13, 2019 at 5:47 AM Roberto Sassu <roberto.sassu@huawei.c
> om> wrote:
> > On 5/13/2019 11:07 AM, Rob Landley wrote:
[...]
> > > > The only reason why opening .xattr-list works is that IMA is
> > > > not yet initialized (late_initcall vs rootfs_initcall).
> > > 
> > > Launching init before enabling ima is bad because... you didn't
> > > think of it?
> > 
> > No, because /init can potentially compromise the integrity of the
> > system.
> 
> I think Rob is right here.  If /init was statically built into the
> kernel image, it has no more ability to compromise the kernel than
> anything else in the kernel.  What's the problem here?

The specific problem is that unless you own the kernel signing key,
which is really untrue for most distribution consumers because the
distro owns the key, you cannot build the initrd statically into the
kernel.  You can take the distro signed kernel, link it with the initrd
then resign the combination with your key, provided you insert your key
into the MoK variables as a trusted secure boot key, but the distros
have been unhappy recommending this as standard practice.

If our model for security is going to be to link the kernel and the
initrd statically to give signature protection over the aggregate then
we need to figure out how to execute this via the distros.  If we
accept that the split model, where the distro owns and signs the kernel
but the machine owner builds and is responsible for the initrd, then we
need to explore split security models like this proposal.

James

