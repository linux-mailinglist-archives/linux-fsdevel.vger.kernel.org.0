Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2359B83D6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 00:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfHFWlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 18:41:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37769 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfHFWlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:41:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so9528701pgp.4;
        Tue, 06 Aug 2019 15:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Krm6tVfFrmclyOThqXDjtWpVvkd2Mius4pmoB2cTG5M=;
        b=FD7DVVu68EbUDQk0H3l1kzkl3ITOXhVuXLOcFMruqkxwq/TxmXssQIM1Yu+ftDR6gy
         csHttpHp3+uA34h5y+p78MFxvY9Cq/C2/bapOpsaO3aeLiWXKjJfAfFtkLn55fNbtwi+
         YS6bKGhQPWZJVqX67v5TV2B559E0qYeR1o5BsgjU6CclSD6nvUe3PAnIanPJm05xmgfV
         Xl27q9XADbO6BvIDgTk43Li2BGN3uU7B0fUFiACFKfYiviBh4kxtjK6EHBqkORinzdKI
         bYsCjqfd+LXWajkRPyCx61uuTOnP0nVKuFU08qRq7daglIoy6maqVKAVb45jqaV/TleR
         JarQ==
X-Gm-Message-State: APjAAAV8wlkMQu0/kRG4QyuFojTd/kQoNtiOXq4UTj8b03s5p74I8M9/
        nE/tXVdDgJNKoY0dU6BjSjw=
X-Google-Smtp-Source: APXvYqxY3KbWh/v+BHv/FmrtMkDg7pRj74CDhVv2Z7b/AsGHkSjC6aL7/tYVuKG7XPRnwuk81fbePA==
X-Received: by 2002:a17:90b:94:: with SMTP id bb20mr5543489pjb.16.1565131300901;
        Tue, 06 Aug 2019 15:41:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 124sm91321581pfw.142.2019.08.06.15.41.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:41:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B4B3D4025E; Tue,  6 Aug 2019 22:41:38 +0000 (UTC)
Date:   Tue, 6 Aug 2019 22:41:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190806224138.GW30113@42.do-not-panic.com>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
 <20190805151258.GD7129@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805151258.GD7129@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 08:12:58AM -0700, Darrick J. Wong wrote:
> On Mon, Aug 05, 2019 at 12:27:30PM +0200, Carlos Maiolino wrote:
> > On Fri, Aug 02, 2019 at 08:14:00AM -0700, Darrick J. Wong wrote:
> > > On Fri, Aug 02, 2019 at 11:19:39AM +0200, Carlos Maiolino wrote:
> > > > Hi Darrick.
> > > > 
> > > > > > +		return error;
> > > > > > +
> > > > > > +	block = ur_block;
> > > > > > +	error = bmap(inode, &block);
> > > > > > +
> > > > > > +	if (error)
> > > > > > +		ur_block = 0;
> > > > > > +	else
> > > > > > +		ur_block = block;
> > > > > 
> > > > > What happens if ur_block > INT_MAX?  Shouldn't we return zero (i.e.
> > > > > error) instead of truncating the value?  Maybe the code does this
> > > > > somewhere else?  Here seemed like the obvious place for an overflow
> > > > > check as we go from sector_t to int.
> > > > > 
> > > > 
> > > > The behavior should still be the same. It will get truncated, unfortunately. I
> > > > don't think we can actually change this behavior and return zero instead of
> > > > truncating it.
> > > 
> > > But that's even worse, because the programs that rely on FIBMAP will now
> > > receive *incorrect* results that may point at a different file and
> > > definitely do not point at the correct file block.
> > 
> > How is this worse? This is exactly what happens today, on the original FIBMAP
> > implementation.
> 
> Ok, I wasn't being 110% careful with my words.  Delete "will now" from
> the sentence above.
> 
> > Maybe I am not seeing something or having a different thinking you have, but
> > this is the behavior we have now, without my patches. And we can't really change
> > it; the user view of this implementation.
> > That's why I didn't try to change the result, so the truncation still happens.
> 
> I understand that we're not generally supposed to change existing
> userspace interfaces, but the fact remains that allowing truncated
> responses causes *filesystem corruption*.
> 
> We know that the most well known FIBMAP callers are bootloaders, and we
> know what they do with the information they get -- they use it to record
> the block map of boot files.  So if the IPL/grub/whatever installer
> queries the boot file and the boot file is at block 12345678901 (a
> 34-bit number), this interface truncates that to 3755744309 (a 32-bit
> number) and that's where the bootloader will think its boot files are.
> The installation succeeds, the user reboots and *kaboom* the system no
> longer boots because the contents of block 3755744309 is not a bootloader.
> 
> Worse yet, grub1 used FIBMAP data to record the location of the grub
> environment file and installed itself between the MBR and the start of
> partition 1.  If the environment file is at offset 1234578901, grub will
> write status data to its environment file (which it thinks is at
> 3755744309) and *KABOOM* we've just destroyed whatever was in that
> block.
> 
> Far better for the bootloader installation script to hit an error and
> force the admin to deal with the situation than for the system to become
> unbootable.  That's *why* the (newer) iomap bmap implementation does not
> return truncated mappings, even though the classic implementation does.
> 
> The classic code returning truncated results is a broken behavior.

How long as it been broken for? And if we do fix it, I'd just like for
a nice commit lot describing potential risks of not applying it. *If*
the issue exists as-is today, the above contains a lot of information
for addressing potential issues, even if theoretical.

  Luis
