Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252524328B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 23:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhJRVCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhJRVCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:02:52 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C85C06161C;
        Mon, 18 Oct 2021 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vLA6NvpHs1ov/wgNN4Rab4l5sS4rboEGv0iuEduXVbY=; b=iUT+DG6cCvFIzIKucTso+2Ougp
        Fci5S7Y/smV3JigsBicWZK0xeRpcI0OObnF6g0WWc4B90SGX4LIhfXUwenB0aVXby+l49+dXLF0Dp
        KJTFNdTn4rj3s5hDGrqfrqx7K3aRt8iTDHGmd8Dp9VNzxR/YxLcTXztzNhHdRycaM7YJfx0qyUasX
        02Mwvp+athQKKv2q4XM4+nh9VaH7SzfFarj6DgGueWM7XYQt0DrGsYYqduGiVSLEAgEHwG1aonf+q
        ZRfB6QtXUYxQl81R1uHKAoF3AepcMFJoyMh1Wl4c21KEts26bAZO5XgZJU2GqkmXPkdcgJ51qXadc
        /0NTPxBA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcZk9-00HG7q-8A; Mon, 18 Oct 2021 21:00:25 +0000
Date:   Mon, 18 Oct 2021 14:00:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/14] firmware_loader: add built-in firmware kconfig
 entry
Message-ID: <YW3gae4HoUd9izyj@bombadil.infradead.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
 <20210917182226.3532898-5-mcgrof@kernel.org>
 <YVxhbhmNd7tahLV7@kroah.com>
 <YWR16e/seTx/wxE+@bombadil.infradead.org>
 <YWR4XKrC2Bkr4qKQ@kroah.com>
 <YWS7ABDdBIpdt/84@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWS7ABDdBIpdt/84@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 03:30:24PM -0700, Luis Chamberlain wrote:
> On Mon, Oct 11, 2021 at 07:46:04PM +0200, Greg KH wrote:
> > >   o By default we now always skip built-in firmware even if a FW_LOADER=y
> > 
> > I do not understand, why would we ever want to skip built-in firmware?
> 
> Because it is done this way today only implicitly because
> EXTRA_FIRMWARE is empty. Using a kconfig entry makes this
> more obvious.

Greg,

The fact that it was not obvious to you we were effectively disabling
the built-in firmware functionality by default using side kconfig
symbols is a good reason to clarify this situation with its own kconfig
symbol.

And consider what I started below as well.

Please let me know why on the other hand we should *not* add this new
kconfig symbol?

> > >   o This also lets us make it clear that the EXTRA_FIRMWARE_DIR
> > >     kconfig entry is only used for built-in firmware
> > 
> > How was it ever used for anything else?  :)
> 
> Well later this patch set also renames this to something more
> sensible, and so that change is clearer through this patch.
> 
> > I can not take this as-is, so yes :)
> 
> Well please let me know again once you read the above explanations.
> 
> I think the new kconfig is very well justified given the above.
> 
>   Luis
