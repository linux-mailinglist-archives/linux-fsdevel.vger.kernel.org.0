Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 275678E546
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 09:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfHOHNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 03:13:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfHOHNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s7gG3ZpsP4dO4NIGyfUN06iVGjBc+Ro9bg5y7V77wj4=; b=bA/mBW0cQr4A50cImC/3Q+U2S
        VG37f095zb/3WNwVJ+lWlK1NjVZKkGcMbrYVmF9pDdFawt7e7INbevb5+hup1I/1j9iwVl5IKW7Aq
        PC/l5VNH+x6tKOmzwr3nM1zRRzbESH8AZ1qEVuntIzcJUFjw5sdvWNT1JWrXpunLoM6JdtSdK/kjm
        ZKBz4knotnxkL4+42LlVXhCa85Y12sNJzwWXgjGAs82IeSODBIdCj0Vyb73REbDxwMmvBFtC1YgU8
        06OJWtg22qj/Y2eRG8teJ6xg5Je81X9M0YucDePBgJ3dUbk5Rog6QWVnRfedimU9jA6L8xTuGaLFO
        Oyb/4RvYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hy9wg-00038j-LP; Thu, 15 Aug 2019 07:13:14 +0000
Date:   Thu, 15 Aug 2019 00:13:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
Message-ID: <20190815071314.GA6960@infradead.org>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814213753.GP6129@dread.disaster.area>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 07:37:53AM +1000, Dave Chinner wrote:
> > @@ -576,7 +576,7 @@ xfs_file_compat_ioctl(
> >  	case XFS_IOC_SCRUB_METADATA:
> >  	case XFS_IOC_BULKSTAT:
> >  	case XFS_IOC_INUMBERS:
> > -		return xfs_file_ioctl(filp, cmd, p);
> > +		return xfs_file_ioctl(filp, cmd, (unsigned long)arg);
> 
> I don't really like having to sprinkle special casts through the
> code because of this.

True.  But the proper fix is to not do the indirection through
xfs_file_ioctl but instead to call xfs_ioc_scrub_metadata,
xfs_ioc_bulkstat, etc directly which all take a void __user
arguments already.
