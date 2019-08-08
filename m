Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7985B50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 09:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfHHHND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 03:13:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45764 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfHHHND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:13:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so3519407wrj.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 00:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=09eS3B5YsAIGDdz72NdEnBFq0HGw3rd9RYxiiux5kKQ=;
        b=VovOdaNrRLTVjwCQx8FLF1isC25V2kUzFO4DEK6rcsLtB/LIbTDWDPrqwBNKRP32R/
         RieTmfNDdVtZ0kJfZ+4NyrSSttTsThd3a6VtwIay3ihagisvhd5BxYOrJH3zIq8F7ORQ
         TJAnQMClkBn3jo9ggyBZhjX48+67dh42hMIndkA6FX/Q0Xi7MW7zv6hGgrQf2e8T+NQp
         VeAOLXtiaBThnai1Uxi+uO+gHyqzXic2x9LZRsrTVc5vbFLjzl1sQwFPl6cITTi26s1q
         rKe+eTtKjoITYDlS27RRIHfitjYyhshiZDLwxmZ069mwEmuGNmJ/Sh6knNq4g6ocbK6Q
         mbAA==
X-Gm-Message-State: APjAAAUU8j/roPvtdJlRuJ+ePov/BM6V0u99SsEIdFL0zWvSiGIUVjj6
        ZDExlgDXEH1Qc40W6V2eZ2sCJw==
X-Google-Smtp-Source: APXvYqx55fTYFIWx4y8CMX/mAs6x+m8zJCQLUEoqfwSf8FquZ6xBhJXCxbBFo9YaWa3MNeJyHK3GYw==
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr14745465wrv.146.1565248380893;
        Thu, 08 Aug 2019 00:13:00 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id i66sm2802240wmi.11.2019.08.08.00.12.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:13:00 -0700 (PDT)
Date:   Thu, 8 Aug 2019 09:12:58 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190808071257.ufbk5i35xpkf4byh@pegasus.maiolino.io>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
 <20190805151258.GD7129@magnolia>
 <20190806224138.GW30113@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806224138.GW30113@42.do-not-panic.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > 
> > > Maybe I am not seeing something or having a different thinking you have, but
> > > this is the behavior we have now, without my patches. And we can't really change
> > > it; the user view of this implementation.
> > > That's why I didn't try to change the result, so the truncation still happens.
> > 
> > I understand that we're not generally supposed to change existing
> > userspace interfaces, but the fact remains that allowing truncated
> > responses causes *filesystem corruption*.
> > 
> > We know that the most well known FIBMAP callers are bootloaders, and we
> > know what they do with the information they get -- they use it to record
> > the block map of boot files.  So if the IPL/grub/whatever installer
> > queries the boot file and the boot file is at block 12345678901 (a
> > 34-bit number), this interface truncates that to 3755744309 (a 32-bit
> > number) and that's where the bootloader will think its boot files are.
> > The installation succeeds, the user reboots and *kaboom* the system no
> > longer boots because the contents of block 3755744309 is not a bootloader.
> > 
> > Worse yet, grub1 used FIBMAP data to record the location of the grub
> > environment file and installed itself between the MBR and the start of
> > partition 1.  If the environment file is at offset 1234578901, grub will
> > write status data to its environment file (which it thinks is at
> > 3755744309) and *KABOOM* we've just destroyed whatever was in that
> > block.
> > 
> > Far better for the bootloader installation script to hit an error and
> > force the admin to deal with the situation than for the system to become
> > unbootable.  That's *why* the (newer) iomap bmap implementation does not
> > return truncated mappings, even though the classic implementation does.
> > 
> > The classic code returning truncated results is a broken behavior.
> 
> How long as it been broken for? And if we do fix it, I'd just like for
> a nice commit lot describing potential risks of not applying it. *If*
> the issue exists as-is today, the above contains a lot of information
> for addressing potential issues, even if theoretical.
> 

It's broken since forever. This has always been the FIBMAP behavior.


>   Luis

-- 
Carlos
