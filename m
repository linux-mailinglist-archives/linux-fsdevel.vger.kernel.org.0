Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68AFE100E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 04:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfJWCf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 22:35:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38822 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733183AbfJWCf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:35:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id c13so699078pfp.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 19:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hn8L3oufJuO1A6sNs5ADzt9tjxwA8pxlkCKXiS57bAM=;
        b=T9W+tN14oYrXYM4Wve7v7M4yAYnFKzjT6mNxo7aM+IsPxMNEYQMzoe0JwOvQqik5BL
         GPGQOsJ9NuZXOC3x73WNHtr/9ubotCB4cjMbAYG6a2Uf0KRlsVrgOLux5bzWhil9tt3N
         RdneeIbutQqNBIyBS9JWAF4zsRoLQwuSVSt1Btnti65jn0cX0s+N81+kqnnOKFas6h4b
         7QDff7Rfy+MHffN+sZVjlRCM8ACrOKZTjai2VrsRv3FPzAwmDE710HsHaWa/yIZb4akY
         AFEqbv/4ns3eZ34S/Q5UJE65tQOEBzqGWt/1M3b/uBXy0CjV+nP5y8HbLarSSBQkRM6g
         9k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hn8L3oufJuO1A6sNs5ADzt9tjxwA8pxlkCKXiS57bAM=;
        b=r+k0J2RjW3yBvoH7ThS9HLftme699SJt2kq8rmvDF0Ri7iVzkXZq5GdIbQrCUQMlSi
         axjDWmO9bs/2/x/iqtmftzV7xZ9zQDB70mGYQo++dNycyOSWBecT1AW9Thnv4Xl8SuHo
         znn6Afcx2FADR/n9k/AwSRa5P+1Jy7/sYmrfihEid3uMsmfnSGjfgwIVUDoBgLJMovfC
         E0zEjceBRhPI3Vc9T2RNEQUu9L/vuqlzbolGP8earScNwUK9qNfIO+FXrtFfk2H6GNl5
         Bc+zLkzBynafeMV8NEevWuT2Gb/qgG8FjUwzrbw2wglwtL88dT7+C5tmeWcAXFrZQE1M
         OqKw==
X-Gm-Message-State: APjAAAW7XUXeJo8P/BHDNLFRHNXL4T9gyKs7DYJ9UDN/bE3HybqiuTu2
        Dv2LwG5dgXFy7kZsqFuaiumQ
X-Google-Smtp-Source: APXvYqxP3lixxl949FFKhXtjPG6Mp4r8GAkhkrIx1SnKHRsGq4Eq9YXZ9Y1zUEwQQDyRpBDL1BHYfg==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr6404347pfl.165.1571798126573;
        Tue, 22 Oct 2019 19:35:26 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id s90sm6037643pjc.2.2019.10.22.19.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 19:35:25 -0700 (PDT)
Date:   Wed, 23 Oct 2019 13:35:19 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191023023519.GA16505@bobrowski>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <20191021133111.GA4675@mit.edu>
 <20191021194330.GJ25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021194330.GJ25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:43:30PM +0200, Jan Kara wrote:
> On Mon 21-10-19 09:31:12, Theodore Y. Ts'o wrote:
> > Hi Matthew, thanks for your work on this patch series!
> > 
> > I applied it against 4c3, and ran a quick test run on it, and found
> > the following locking problem.  To reproduce:
> > 
> > kvm-xfstests -c nojournal generic/113
> > 
> > generic/113		[09:27:19][    5.841937] run fstests generic/113 at 2019-10-21 09:27:19
> > [    7.959477] 
> > [    7.959798] ============================================
> > [    7.960518] WARNING: possible recursive locking detected
> > [    7.961225] 5.4.0-rc3-xfstests-00012-g7fe6ea084e48 #1238 Not tainted
> > [    7.961991] --------------------------------------------
> > [    7.962569] aio-stress/1516 is trying to acquire lock:
> > [    7.963129] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: __generic_file_fsync+0x3e/0xb0
> > [    7.964109] 
> > [    7.964109] but task is already holding lock:
> > [    7.964740] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: ext4_dio_write_iter+0x15b/0x430
> 
> This is going to be a tricky one. With iomap, the inode locking is handled
> by the filesystem while calling generic_write_sync() is done by
> iomap_dio_rw(). I would really prefer to avoid tweaking iomap_dio_rw() not
> to call generic_write_sync(). So we need to remove inode_lock from
> __generic_file_fsync() (used from ext4_sync_file()). This locking is mostly
> for legacy purposes and we don't need this in ext4 AFAICT - but removing
> the lock from __generic_file_fsync() would mean auditing all legacy
> filesystems that use this to make sure flushing inode & its metadata buffer
> list while it is possibly changing cannot result in something unexpected. I
> don't want to clutter this series with it so we are left with
> reimplementing __generic_file_fsync() inside ext4 without inode_lock. Not
> too bad but not great either. Thoughts?

So, I just looked at this on my lunch break and I think the simplest approach
would be to just transfer the necessary chunks of code from within
__generic_file_fsync() into ext4_sync_file() for !journal cases, minus the
inode lock, and minus calling into __generic_file_fsync(). I don't forsee this
causing any issues, but feel free to correct me if I'm wrong.

If this is deemed to be OK, then I will go ahead and include this as a
separate patch in my series.

--<M>--
