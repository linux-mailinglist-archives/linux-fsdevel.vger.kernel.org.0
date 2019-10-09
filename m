Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17948D0E08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfJILxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 07:53:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33568 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbfJILxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:53:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so1495112pfl.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zzhnx6i2Ij7tp/wfRn9f5sRpzqICe1PLMcHczxwafc4=;
        b=Gn5Lf7m3C9N/46jxCOTu8TyUBD4P4TTjesK63Amnqeb8JID20neEClNxplXTGIVaaE
         espOfoLXtRENG1fpMwtbHxNxU91VHZhMQ8j3prEJE9YI21RobIjTaQ7WsvBoLpmhszh+
         CANd9mH6IRgDiSUOFbyPkQ/83P/pVCyXAdj9ntYraLQ4qdb40ZxyXbbRUwXdutQsgT6B
         EvV1Qur96oXTLvKAFj4Ev3XJ6dKai5Fe17HFTGx83OmbD1rpm7ezontgVwyJSIQvicwV
         aZvw+Ku91BUxd8M06OQqfREU8avWGUdqz1ChsTt/UYu3f4nxoRrPBVxwZ2GmvrqxoqJw
         hSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zzhnx6i2Ij7tp/wfRn9f5sRpzqICe1PLMcHczxwafc4=;
        b=fn2OtLHBcjg9xazfdViBKBifdvQR6dshgmAszdW3eboelTCzNcg9VSwoo0bzlsWyO0
         hCkmaAR/0+aH5a/kuqpwzlYG7P2GBKsk6l6fdKZok8a7hpokG96NvnjJ2t3YmCZCcnuC
         FkrhSvEDHKJqZhkleu2igd8yN3kPr5RjWnRqMeCZ0307j3mMe7IPDcw8PtO0dzrNYX2F
         fRuEvvnSAz2q472OiC2NfI+bv4pX7WE1UMJh4qQdKoL7GC2gS0Yw4eaQynKlRldjgVO4
         wkTidT9WTNif3SITKuzhBNySPwPoYy+H/shk+sFIPdo3+kgaC++f6he3vG4EWTJvEK/p
         cy1g==
X-Gm-Message-State: APjAAAWIij5LxY3xwRbRWkiLWNPnA73rovKU6Uyl581WYSszwvhYUC0P
        9QO/FPVDr2tcp4WyFhvnK6ux
X-Google-Smtp-Source: APXvYqzkdFV7H7pqGAziEqknHM0vmG2o1CBzdEWeSdPVJw9eHLR9X4TuRqRupOmcFKFQwRkD+oSVwQ==
X-Received: by 2002:a65:418b:: with SMTP id a11mr3915898pgq.23.1570622016713;
        Wed, 09 Oct 2019 04:53:36 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id x9sm2074819pje.27.2019.10.09.04.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 04:53:34 -0700 (PDT)
Date:   Wed, 9 Oct 2019 22:53:28 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 8/8] ext4: introduce direct I/O write path using iomap
 infrastructure
Message-ID: <20191009115326.GG14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <9ef408b4079d438c0e6071b862c56fc8b65c3451.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008151238.GK5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008151238.GK5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:12:38PM +0200, Jan Kara wrote:
> On Thu 03-10-19 21:35:05, Matthew Bobrowski wrote:
> > Any blocks
> > that have been allocated in preparation for direct I/O write will be
> > reused by buffered I/O, so there's no issue with leaving allocated
> > blocks beyond EOF.
> 
> This actually is not true as ext4_truncate_failed_write() will trim blocks
> beyond EOF. Also this would not be 100% reliable as if we crash between DIO
> short write succeeding and buffered write happening, we would leave inode
> with blocks beyond EOF. So I'd just remove this sentence.

OK.

> > Existing direct I/O write buffer_head code has been removed as it's
> > now redundant.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ...
> > +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> > +                                int error, unsigned int flags)
> > +{
> > +       loff_t offset = iocb->ki_pos;
> > +       struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +       if (!error && (flags & IOMAP_DIO_UNWRITTEN))
> > +               error = ext4_convert_unwritten_extents(NULL, inode, offset,
> > +                                                      size);
> > +       return ext4_handle_inode_extension(inode, offset, error ? : size,
> > +                                          size);
> > +}
> 
> I was pondering about this and I don't think we have it quite correct.
> Still :-|. The problem is that iomap_dio_complete() will pass dio->size as
> 'size', which is the amount of submitted IO but not necessarily the amount
> of blocks that were mapped (that can be larger). Thus
> ext4_handle_inode_extension() can miss the fact that there are blocks
> beyond EOF that need to be trimmed. And we have no way of finding that out
> inside our ->end_io handler. Even iomap_dio_complete() doesn't have that
> information so we'd need to add 'original length' to struct iomap_dio and
> then pass it do ->end_io.

Yes, I remember having a discussion around this in the past. The
answer to this problem at the time was that any blocks that may have
been allocated in preparation for the direct I/O write and we're not
used would in fact be reused when we fell back to buffered I/O. The
case that you're describing above, based on my understanding, would
have to be a result of short write?

> Seeing how difficult it is when a filesystem wants to complete the iocb
> synchronously (regardless whether it is async or sync) and have all the
> information in one place for further processing, I think it would be the
> easiest to provide iomap_dio_rw_wait() that forces waiting for the iocb to
> complete *and* returns the appropriate return value instead of pretty
> useless EIOCBQUEUED. It is actually pretty trivial (patch attached). With
> this we can then just call iomap_dio_rw_sync() for the inode extension case
> with ->end_io doing just the unwritten extent processing and then call
> ext4_handle_inode_extension() from ext4_direct_write_iter() where we would
> have all the information we need.

This could also work, nicely. But, if this isn't an option for
whatever reason then we could go with what you suggested above? After
all, I think it would make sense to pass such information about the
write all the way through to the end, especially the ->end_io handler,
seeing as though that's we're clean up should be performed in the
instance of a failure, or a short write.

However, note that:

a) likely(my understanding may be wrong)

b) Someone a lot smarter than I has probably already thought this
   through and there's a real good reason why we don't cram such
   information about the write within the iomap structures and have
   them passed all the way through to the end...

:)

--<M>--
