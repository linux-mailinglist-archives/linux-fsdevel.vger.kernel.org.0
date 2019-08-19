Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B292100
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfHSKKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 06:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfHSKKP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:10:15 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2A47CA36F
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 10:10:14 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id d65so375733wmd.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 03:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=VRKFfBref80hOnkkTdfeT0QDM8EowtXF0wFUUWsyeww=;
        b=DMLGUt4VcoyO1e5ZOZPn3Eu5ki9VbnE+pXwGThZ8uozleX+e4CqhY40m1YUpRsLzV4
         leyhwZ5TS+vJRaZch8zSwfNQmHWRuiQFCMj2i2PW4hHy+f0k4SCe+niZOlBnUNbwo+TD
         ZmWh07lfxbK1yi9C8Q1ffpUNDn11Z1gpZ0NmBIUUrl25BNHFbHR8NoQ6F2xijIBDKDTJ
         lSfwqAuvplqPH3fk3KxZMousmcAjF/HsXj6FgWStbeePoP1e+nItO3PpK6zM9IDJD/XI
         SgrpsJdvXO74/5zbEHEWPToARkbS6bM0XL6nyAer6SPrC2U/RR7C8BLgbewyRgMH7Fit
         3ZUg==
X-Gm-Message-State: APjAAAWxyr8YI40kSAQ73I/6s/wmwh9bxjRUc5PdIpK6NXfEnkc4ecX0
        WZO56r4KXRiJlLZIcDoEz1Dn7jdnF5L2lTdXe0vDm1B9Juef3+Zasg1zZylz2gy+d/6tzITFTfM
        kcc0S/j52oVFBdgCo1YOdy1TcPQ==
X-Received: by 2002:adf:db49:: with SMTP id f9mr26483895wrj.112.1566209412376;
        Mon, 19 Aug 2019 03:10:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybRYq3mT8yCsurUsJitMkgUf3MuqwUb4K0TwZpp4tQrjtqbcH6q3Nn9AU5+z43ML1zF1BMKw==
X-Received: by 2002:adf:db49:: with SMTP id f9mr26483857wrj.112.1566209412143;
        Mon, 19 Aug 2019 03:10:12 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id i18sm15619200wrp.91.2019.08.19.03.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 03:10:11 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:10:09 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, rpeterso@redhat.com,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190819101007.ou5jthy6zlqpmw2w@pegasus.maiolino.io>
Mail-Followup-To: Andreas Dilger <adilger@dilger.ca>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, rpeterso@redhat.com,
        linux-xfs <linux-xfs@vger.kernel.org>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
 <20190805151258.GD7129@magnolia>
 <20190806224138.GW30113@42.do-not-panic.com>
 <20190808071257.ufbk5i35xpkf4byh@pegasus.maiolino.io>
 <69E22C32-5EDC-4507-9407-A1622BC31560@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69E22C32-5EDC-4507-9407-A1622BC31560@dilger.ca>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Meh... Sorry andreas, your reply became disconnected from the thread, and I
think I didn't reply.

On Thu, Aug 08, 2019 at 12:53:25PM -0600, Andreas Dilger wrote:
> On Aug 8, 2019, at 1:12 AM, Carlos Maiolino <cmaiolino@redhat.com> wrote:
> > 
> >>> 
> >>>> Maybe I am not seeing something or having a different thinking you have, but
> >>>> this is the behavior we have now, without my patches. And we can't really change
> >>>> it; the user view of this implementation.
> >>>> That's why I didn't try to change the result, so the truncation still happens.
> >>> 
> >>> I understand that we're not generally supposed to change existing
> >>> userspace interfaces, but the fact remains that allowing truncated
> >>> responses causes *filesystem corruption*.
> >>> 
> >>> We know that the most well known FIBMAP callers are bootloaders, and we
> >>> know what they do with the information they get -- they use it to record
> >>> the block map of boot files.  So if the IPL/grub/whatever installer
> >>> queries the boot file and the boot file is at block 12345678901 (a
> >>> 34-bit number), this interface truncates that to 3755744309 (a 32-bit
> >>> number) and that's where the bootloader will think its boot files are.
> >>> The installation succeeds, the user reboots and *kaboom* the system no
> >>> longer boots because the contents of block 3755744309 is not a bootloader.
> >>> 
> >>> Worse yet, grub1 used FIBMAP data to record the location of the grub
> >>> environment file and installed itself between the MBR and the start of
> >>> partition 1.  If the environment file is at offset 1234578901, grub will
> >>> write status data to its environment file (which it thinks is at
> >>> 3755744309) and *KABOOM* we've just destroyed whatever was in that
> >>> block.
> >>> 
> >>> Far better for the bootloader installation script to hit an error and
> >>> force the admin to deal with the situation than for the system to become
> >>> unbootable.  That's *why* the (newer) iomap bmap implementation does not
> >>> return truncated mappings, even though the classic implementation does.
> >>> 
> >>> The classic code returning truncated results is a broken behavior.
> >> 
> >> How long as it been broken for? And if we do fix it, I'd just like for
> >> a nice commit lot describing potential risks of not applying it. *If*
> >> the issue exists as-is today, the above contains a lot of information
> >> for addressing potential issues, even if theoretical.
> >> 
> > 
> > It's broken since forever. This has always been the FIBMAP behavior.
> 
> It's been broken since forever, but only for filesystems larger than 4TB or
> 16TB (2^32 blocks), which are only becoming commonplace for root disks recently.
> Also, doesn't LILO have a limit on the location of the kernel image, in the
> first 1GB or similar?
> 
> So maybe this is not an issue that FIBMAP users ever hit in practise anyway,
> but I agree that it doesn't make sense to return bad data (32-bit wrapped block
> numbers) and 0 should be returned in such cases.
> 

Thanks for the input, but TBH I don't use LILO for a long time, and I don't
remember exactly how it works.

Anyway, I have 2 bugs to fix in this code, after I can get this series in, one
is the overflow we'll probably need kernel-api approval, and another one is the
acceptance of negative values into FIBMAP, which we have no protection at all.
I'll fix both once I can get the main series in.

Cheers


> 
> Cheers, Andreas
> 
> 
> 
> 
> 



-- 
Carlos
