Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C937314F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhEDUWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 16:22:14 -0400
Received: from mx-out.tlen.pl ([193.222.135.145]:11227 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhEDUWN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 16:22:13 -0400
Received: (wp-smtpd smtp.tlen.pl 27422 invoked from network); 4 May 2021 22:21:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1620159674; bh=iGXP3EbGVsgBPRHWGw2VfIcF7R50zDLEimoFYAGOcao=;
          h=From:To:Cc:Subject;
          b=Q3s1wwCzi6/6a2mE9Zsr9Omz53sZqfUEmEsXqC1iZMUVOK/KDjUy+3GIy81WjX0Ak
           3UMR0y6cvSwJpGb0xsd76YSdhWtjKVb5YUPaY9sNL/+y7wTMkCliTiAS3NCNhh2dG+
           VFQajAkQ7z6ZyXBvLpKumk11yygT09UPJ4ysdXsw=
Received: from 89-64-47-21.dynamic.chello.pl (HELO swift.dev.arusekk.pl) (arek_koz@o2.pl@[89.64.47.21])
          (envelope-sender <arek_koz@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <torvalds@linux-foundation.org>; 4 May 2021 22:21:14 +0200
From:   Arusekk <arek_koz@o2.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] proc: Use seq_read_iter for /proc/*/maps
Date:   Tue, 04 May 2021 22:23:20 +0200
Message-ID: <1777114.atdPhlSkOF@swift.dev.arusekk.pl>
In-Reply-To: <CAHk-=whEjY7eOqPg2Ndw=iM2Mih0BC9LVyX9c6Uc_W=wmwnkkA@mail.gmail.com>
References: <YIqFcHj3O2t+JJak@kroah.com> <20210504115358.20741-1-arek_koz@o2.pl> <CAHk-=whEjY7eOqPg2Ndw=iM2Mih0BC9LVyX9c6Uc_W=wmwnkkA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-WP-MailID: 9eed0ce6127d49d4a8d64fa6b82a7ea7
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000005 [IaaQ]                               
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We wtorek, 4 maja 2021 18:01:33 CEST Linus Torvalds pisze:
> it's one of the reasons I didn't feel like doing splice() on
> everything should be encouraged.

This is why I agreed to change only /proc/*/maps.

> The only reason to do this is basically for nefarious purposes,

No real exploit I can think of needs to send this specific file, there are 
better candidates in procfs already.  It only helps inspecting memory mappings 
off-line more reliably than LD_TRACE_LOADED_OBJECTS=1 in as little bytes as 
possible.
Or maybe should it be discouraged on regular ext4 files as well?

> Yes, yes, I'm sure pwntools can be used by white hats, but honestly,
> that seems to be an almost secondary purpose.

You got me.  But honestly, I disagree, I have already seen pwntools used by 
malware analysts and python fans.

> Why should the kernel _encourage_ and make it easy to do things like
> this? What are the actual advantages for us to do this?

Keeping it the way it is for the sake of security of userspace applications 
looks more like security through obscurity to me. 
I still agree that it may increase attack surface of the kernel.  I did not 
try racing misaligned splices, nor mmapping files with strange names.

Pwntools need to be adapted anyway in order to support 5.10-5.13 kernels;
I just thought that this is a kind of a regression in the kernel, so I felt 
obliged to contribute a fix here, especially after I realized how simple the fix 
was.
I heard that patches and their descriptions must really be top quality, but I 
was not prepared for justifying the change with anything more than 'it used to 
work, but is broken now, this patch brings it back'.

-- 
Arusekk


