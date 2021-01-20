Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB72FD5A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404043AbhATQ2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 11:28:55 -0500
Received: from verein.lst.de ([213.95.11.211]:56613 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404036AbhATQ2v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:28:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2B6768B02; Wed, 20 Jan 2021 17:28:06 +0100 (CET)
Date:   Wed, 20 Jan 2021 17:28:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Raphael Carvalho <raphael.scarv@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 02/11] xfs: make xfs_file_aio_write_checks
 IOCB_NOWAIT-aware
Message-ID: <20210120162806.GA20331@lst.de>
References: <20210118193516.2915706-1-hch@lst.de> <20210118193516.2915706-3-hch@lst.de> <CACz=WeeaqMrGM53pJF0C_Wt2JuavTOnOV26-osPviYLUpqUmFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACz=WeeaqMrGM53pJF0C_Wt2JuavTOnOV26-osPviYLUpqUmFw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:33:37AM -0300, Raphael Carvalho wrote:
> >          * No fallback to buffered IO after short writes for XFS, direct
> > I/O
> > @@ -632,7 +648,8 @@ xfs_file_dax_write(
> >                 error = xfs_setfilesize(ip, pos, ret);
> >         }
> >  out:
> > -       xfs_iunlock(ip, iolock);
> > +       if (iolock)
> > +               xfs_iunlock(ip, iolock);
> >
> 
> Not familiar with the code but looks like you're setting *iolock to zero on
> error and perhaps you want to dereference it here instead

In this function iolock is a scalar value, not a pointer.
xfs_file_aio_write_checks gets it passed by reference and clears it,
and here we check that the iolock is locked at all.
