Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E098116E7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 15:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfLIOED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 09:04:03 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34192 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLIOEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w+I0EPEtqHLR7ymKShrFSTkAIHn9lWvB0M/aTL+G/Zo=; b=j1do1Bugm1qsmfZIaZoCGI3vo
        b8yUgN+ak1ekmf/s/9O/ZcC3Bq9/iXrUKceMT+L2ZbtFLvwkvBMq2O66N1qDLqZuBG6y93k6lOB3C
        ih/TZfMt6L/i16lUou5AjPxCtahEkHHpYiJPvslUzCoIyNbQTud+Z3K51MVPT+M5JVNsgVqjo78sc
        u00cg4DGPV1a9DwsJ4x2Xnhw5DT9HF2/3dPkmbUyZXYKyz0x7HL5bNLnQ6gq41xZqpd/MJu83AR+k
        NnqNVbIViUQsBIRZkewkgN9w+yX0HrVXEov5o3XkTe02ZWhD+xw9QYfDnf3VPxvEltIcDIaTg6ZoK
        XeaxhLBKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50626)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ieJdm-0003Ob-RE; Mon, 09 Dec 2019 14:03:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ieJdm-0003hB-2q; Mon, 09 Dec 2019 14:03:58 +0000
Date:   Mon, 9 Dec 2019 14:03:58 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Vyacheslav Dubeyko <slava@dubeyko.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/41] fs/adfs: inode: update timestamps to centisecond
 precision
Message-ID: <20191209140357.GJ25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
 <E1ieGtm-0004ZY-DD@rmk-PC.armlinux.org.uk>
 <59711cf492815c5bba93d641398011ea2341f635.camel@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59711cf492815c5bba93d641398011ea2341f635.camel@dubeyko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 09, 2019 at 04:54:55PM +0300, Vyacheslav Dubeyko wrote:
> On Mon, 2019-12-09 at 11:08 +0000, Russell King wrote:
> > Despite ADFS timestamps having centi-second granularity, and Linux
> > gaining fine-grained timestamp support in v2.5.48, fs/adfs was never
> > updated.
> > 
> > Update fs/adfs to centi-second support, and ensure that the inode
> > ctime
> > always reflects what is written in underlying media.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  fs/adfs/inode.c | 40 ++++++++++++++++++++--------------------
> >  fs/adfs/super.c |  2 ++
> >  2 files changed, 22 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
> > index 124de75413a5..18a1d478669b 100644
> > --- a/fs/adfs/inode.c
> > +++ b/fs/adfs/inode.c
> > @@ -158,6 +158,8 @@ adfs_mode2atts(struct super_block *sb, struct
> > inode *inode)
> >  	return attr;
> >  }
> >  
> > +static const s64 nsec_unix_epoch_diff_risc_os_epoch =
> > 2208988800000000000LL;
> > +
> >  /*
> >   * Convert an ADFS time to Unix time.  ADFS has a 40-bit centi-
> > second time
> >   * referenced to 1 Jan 1900 (til 2248) so we need to discard
> > 2208988800 seconds
> > @@ -170,8 +172,6 @@ adfs_adfs2unix_time(struct timespec64 *tv, struct
> > inode *inode)
> >  	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
> >  	 * 01 Jan 1900 00:00:00 (RISC OS epoch)
> >  	 */
> > -	static const s64 nsec_unix_epoch_diff_risc_os_epoch =
> > -							220898880000000
> > 0000LL;
> >  	s64 nsec;
> >  
> >  	if (!adfs_inode_is_stamped(inode))
> > @@ -204,24 +204,23 @@ adfs_adfs2unix_time(struct timespec64 *tv,
> > struct inode *inode)
> >  	return;
> >  }
> >  
> > -/*
> > - * Convert an Unix time to ADFS time.  We only do this if the entry
> > has a
> > - * time/date stamp already.
> > - */
> > -static void
> > -adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
> > +/* Convert an Unix time to ADFS time for an entry that is already
> > stamped. */
> > +static void adfs_unix2adfs_time(struct inode *inode,
> > +				const struct timespec64 *ts)
> >  {
> > -	unsigned int high, low;
> > +	s64 cs, nsec = timespec64_to_ns(ts);
> >  
> > -	if (adfs_inode_is_stamped(inode)) {
> > -		/* convert 32-bit seconds to 40-bit centi-seconds */
> > -		low  = (secs & 255) * 100;
> > -		high = (secs / 256) * 100 + (low >> 8) + 0x336e996a;
> > +	/* convert from Unix to RISC OS epoch */
> > +	nsec += nsec_unix_epoch_diff_risc_os_epoch;
> >  
> > -		ADFS_I(inode)->loadaddr = (high >> 24) |
> > -				(ADFS_I(inode)->loadaddr & ~0xff);
> > -		ADFS_I(inode)->execaddr = (low & 255) | (high << 8);
> > -	}
> > +	/* convert from nanoseconds to centiseconds */
> > +	cs = div_s64(nsec, 10000000);
> > +
> > +	cs = clamp_t(s64, cs, 0, 0xffffffffff);
> > +
> > +	ADFS_I(inode)->loadaddr &= ~0xff;
> > +	ADFS_I(inode)->loadaddr |= (cs >> 32) & 0xff;
> > +	ADFS_I(inode)->execaddr = cs;
> >  }
> >  
> >  /*
> > @@ -315,10 +314,11 @@ adfs_notify_change(struct dentry *dentry,
> > struct iattr *attr)
> >  	if (ia_valid & ATTR_SIZE)
> >  		truncate_setsize(inode, attr->ia_size);
> >  
> > -	if (ia_valid & ATTR_MTIME) {
> > -		inode->i_mtime = attr->ia_mtime;
> > -		adfs_unix2adfs_time(inode, attr->ia_mtime.tv_sec);
> > +	if (ia_valid & ATTR_MTIME && adfs_inode_is_stamped(inode)) {
> > +		adfs_unix2adfs_time(inode, &attr->ia_mtime);
> > +		adfs_adfs2unix_time(&inode->i_mtime, inode);
> >  	}
> > +
> >  	/*
> >  	 * FIXME: should we make these == to i_mtime since we don't
> >  	 * have the ability to represent them in our filesystem?
> > diff --git a/fs/adfs/super.c b/fs/adfs/super.c
> > index 65b04ebb51c3..e0eea9adb4e6 100644
> > --- a/fs/adfs/super.c
> > +++ b/fs/adfs/super.c
> > @@ -391,7 +391,9 @@ static int adfs_fill_super(struct super_block
> > *sb, void *data, int silent)
> >  	asb = kzalloc(sizeof(*asb), GFP_KERNEL);
> >  	if (!asb)
> >  		return -ENOMEM;
> > +
> >  	sb->s_fs_info = asb;
> > +	sb->s_time_gran = 10000000;
> 
> I believe it's not easy to follow what this granularity means. Maybe,
> it makes sense to introduce some constant and to add some comment?

Or simply name it "s_time_gran_ns" so the units are in the name.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
