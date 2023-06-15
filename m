Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532AC730BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 02:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjFOAI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 20:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjFOAI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:08:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359241FC3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 17:08:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fbb3a013dso5288504a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 17:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686787703; x=1689379703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2+kH0s1munFi4XxoHaTia/Ij2UiOHjvg/T1/0hNqMc=;
        b=Zng/IOokNIWKyi0vRvue6dXwqSrBmzan9gr5cB2suQ4UEfHK1ADQStkmaDO7rU/oka
         NYd63ySP2OUp6tL4c19Sa+8sKejI//ieEE7f0ozKmUvfoLbnkcI9+KkSHQ8KL+WvnJBm
         eHERA+runumexDhq1EKFS/0+kF6Impcq+gtIrqvy8LGMWamkV1bXs8LUvHeHtTE70wG5
         KJpCMMVIxZnwKfrNKnxJDhd5SmMApoEmtxSWC7tXGKZPp8pWka6cN8j5pe0snAGImR4A
         rJFv/kVjiPJTqT53QZOPkM+xqnSi4YtlXc25keJJFa8gv9QcEHNAyctxveWT4gOmBUPK
         IVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686787703; x=1689379703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2+kH0s1munFi4XxoHaTia/Ij2UiOHjvg/T1/0hNqMc=;
        b=RuLnJoiyEZxOPPFgrZ2lwmAuglxngR7tmCIOBerIb753+arBRXd40zpCBcQ3l5rMJZ
         8vi8+QmjzCHcXNNON9M3TZq02jqrAO4BjGJ633a8MR4RwuSmkOnoUK420NCaR0uuUBhZ
         Ez5z7AkD9TqJxYDYKoLmqijitJVtIH4eEEc6JoFC5oD/n0R9HioIidh3RMH6dOYsd4xh
         H0M8hAmOlIpqYwVpbJb24+/hxOgAVO5hn/kHFCzkz3CzXvOM5mz08qRfkuW3vv2KNby8
         OVw57mial5aSF4Q5D+cOT4vWpZpmtjtChai19g7XIZFmdRzqu5S4kHmGf3xkNyesYd+W
         ZUFw==
X-Gm-Message-State: AC+VfDwNdRyXUgp2O1nZIjZX0htm5URrdzJSOCVn+NUi38cW3zt0nK3B
        qlse/Oha3mA5tilJAi8njBmI2A==
X-Google-Smtp-Source: ACHHUZ7Ye25QG4SYqhApZpBstZCJPXI5i6ojpI0XsxJqF0PxrT4mRz5+aVdkULcDqyMYFFQvL4DwjA==
X-Received: by 2002:a17:903:50d:b0:1ae:14d:8d0a with SMTP id jn13-20020a170903050d00b001ae014d8d0amr14125505plb.29.1686787703650;
        Wed, 14 Jun 2023 17:08:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00198d7b52eefsm12682775plh.257.2023.06.14.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 17:08:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9aXE-00Brst-28;
        Thu, 15 Jun 2023 10:08:20 +1000
Date:   Thu, 15 Jun 2023 10:08:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        corbet@lwn.net, snitzer@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, willy@infradead.org,
        dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
Message-ID: <ZIpWdIBPm4NKehLo@dread.disaster.area>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
 <ZIjsywOtHM5nIhSr@dread.disaster.area>
 <ZIldkb1pwhNsSlfl@infradead.org>
 <733f591e-0e8f-8668-8298-ddb11a74df81@veeam.com>
 <ZInJlD70tMKoBi7T@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZInJlD70tMKoBi7T@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 07:07:16AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 14, 2023 at 11:26:20AM +0200, Sergei Shtepa wrote:
> > This code worked quite successfully for the veeamsnap module, on the
> > basis of which blksnap was created. Indeed, such an allocation of an
> > area on a block device using a file does not look safe.
> > 
> > We've already discussed this with Donald Buczek <buczek@molgen.mpg.de>.
> > Link: https://github.com/veeam/blksnap/issues/57#issuecomment-1576569075
> > And I have planned work on moving to a more secure ioctl in the future.
> > Link: https://github.com/veeam/blksnap/issues/61
> > 
> > Now, thanks to Dave, it becomes clear to me how to solve this problem best.
> > swapfile is a good example of how to do it right.
> 
> I don't actually think swapfile is a very good idea, in fact the Linux
> swap code in general is not a very good place to look for inspirations
> :)

Yeah, the swapfile implementation isn't very nice, I was really just
using it as an example of how we can implement the requirements of
block mapping delegation in a safe manner to a kernel subsystem.

I think the important part is the swapfile inode flag, because that
is what keeps userspace from being able to screw with the file while
the kernel is using it and allows us to do read/write IO to
unwritten extents without converting them to written...

> IFF the usage is always to have a whole file for the diff storage the
> over all API is very simple - just pass a fd to the kernel for the area,
> and then use in-kernel direct I/O on it.

Yeah, I was thinking a fd is a better choice for the UAPI as it
frees up the kernel implementation, and it doesn't need us to pass a
separate bdev identifier in the ioctl. It also means we can pass a
regular file or a block device and the kernel code doesn't need to
care that they are different.

If you think direct IO is a better idea, then I have no objection to
that - I haven't looked into the implementation that deeply at this
point. I wanted to get an understanding of how all the pieces went
together first, so all I've read is the documentation and looked at
the UAPI.

I made a leap from that: the documentation keeps talking about using
files a the filesystem for the difference storage, but the only UAPI
for telling the kernel about storage regions it can use is this
physical bdev LBA mapping ioctl. Hence if file storage is being
used....

> Now if that file should also
> be able to reside on the same file system that the snapshot is taken
> of things get a little more complicated, because writes to it also need
> to automatically set the BIO_REFFED flag.  I have some ideas for that
> and will share some draft code with you.

Cool, I look forward to the updates; I know of a couple of
applications that could make use of this functionality right
away....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
