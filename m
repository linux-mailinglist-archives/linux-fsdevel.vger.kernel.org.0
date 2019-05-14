Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69C61CD53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfENQ6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 12:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENQ6q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 12:58:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D9CF20862;
        Tue, 14 May 2019 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557853124;
        bh=vZrVtbCUX6dggZK1MCKb1QmhR0TnG8X/jC10a/jknoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWfQx6BhQXYOtHcudh8WJOkO1ZtPTYbINPokZvBCiDuqpvZaM8BbafSL5z9yQSGBJ
         Elkq32ligc7tetyF6G61dglAdlmJaNJe/2KCVtw6b2KBUetm2GXhAfR7eGNS+upOPe
         /R35Ntnpn9dI6tUlz6gIHsvS5XLKuHKVlurDj7qY=
Date:   Tue, 14 May 2019 18:58:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190514165842.GC28266@kroah.com>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <9357cb32-3803-2a7e-4949-f9e4554c1ee9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9357cb32-3803-2a7e-4949-f9e4554c1ee9@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 06:33:29PM +0200, Roberto Sassu wrote:
> On 5/14/2019 5:19 PM, Andy Lutomirski wrote:
> > On Mon, May 13, 2019 at 5:47 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> > > 
> > > On 5/13/2019 11:07 AM, Rob Landley wrote:
> > > > 
> > > > 
> > > > On 5/13/19 2:49 AM, Roberto Sassu wrote:
> > > > > On 5/12/2019 9:43 PM, Arvind Sankar wrote:
> > > > > > On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
> > > > > > > On 5/12/19 7:52 AM, Mimi Zohar wrote:
> > > > > > > > On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
> > > > > > > > > On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
> > > > > > > > > > This proposal consists in marshaling pathnames and xattrs in a file called
> > > > > > > > > > .xattr-list. They are unmarshaled by the CPIO parser after all files have
> > > > > > > > > > been extracted.
> > > > > > > > > 
> > > > > > > > > Couldn't this parsing of the .xattr-list file and the setting of the xattrs
> > > > > > > > > be done equivalently by the initramfs' /init? Why is kernel involvement
> > > > > > > > > actually required here?
> > > > > > > > 
> > > > > > > > It's too late.  The /init itself should be signed and verified.
> > > > > > > 
> > > > > > > If the initramfs cpio.gz image was signed and verified by the extractor, how is
> > > > > > > the init in it _not_ verified?
> > > > > > > 
> > > > > > > Ro
> > > > > > 
> > > > > > Wouldn't the below work even before enforcing signatures on external
> > > > > > initramfs:
> > > > > > 1. Create an embedded initramfs with an /init that does the xattr
> > > > > > parsing/setting. This will be verified as part of the kernel image
> > > > > > signature, so no new code required.
> > > > > > 2. Add a config option/boot parameter to panic the kernel if an external
> > > > > > initramfs attempts to overwrite anything in the embedded initramfs. This
> > > > > > prevents overwriting the embedded /init even if the external initramfs
> > > > > > is unverified.
> > > > > 
> > > > > Unfortunately, it wouldn't work. IMA is already initialized and it would
> > > > > verify /init in the embedded initial ram disk.
> > > > 
> > > > So you made broken infrastructure that's causing you problems. Sounds unfortunate.
> > > 
> > > The idea is to be able to verify anything that is accessed, as soon as
> > > rootfs is available, without distinction between embedded or external
> > > initial ram disk.
> > > 
> > > Also, requiring an embedded initramfs for xattrs would be an issue for
> > > systems that use it for other purposes.
> > > 
> > > 
> > > > > The only reason why
> > > > > opening .xattr-list works is that IMA is not yet initialized
> > > > > (late_initcall vs rootfs_initcall).
> > > > 
> > > > Launching init before enabling ima is bad because... you didn't think of it?
> > > 
> > > No, because /init can potentially compromise the integrity of the
> > > system.
> > 
> > I think Rob is right here.  If /init was statically built into the
> > kernel image, it has no more ability to compromise the kernel than
> > anything else in the kernel.  What's the problem here?
> 
> Right, the measurement/signature verification of the kernel image is
> sufficient.
> 
> Now, assuming that we defer the IMA initialization until /init in the
> embedded initramfs has been executed, the problem is how to handle
> processes launched with the user mode helper or files directly read by
> the kernel (if it can happen before /init is executed). If IMA is not
> yet enabled, these operations will be performed without measurement and
> signature verification.

If you really care about this, don't launch any user mode helper
programs (hint, you have the kernel option to control this and funnel
everything into one, or no, binaries).  And don't allow the kernel to
read any files either, again, you have control over this.

Or start IMA earlier if you need/want/care about this.

thanks,

greg k-h
