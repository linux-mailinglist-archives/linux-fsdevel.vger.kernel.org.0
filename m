Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A48146262
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 08:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgAWHQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 02:16:47 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34338 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgAWHQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:16:46 -0500
Received: from dread.disaster.area (pa49-195-162-125.pa.nsw.optusnet.com.au [49.195.162.125])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D0CEB3A2854;
        Thu, 23 Jan 2020 18:16:40 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iuWjH-0002Dt-I3; Thu, 23 Jan 2020 18:16:39 +1100
Date:   Thu, 23 Jan 2020 18:16:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200123071639.GA7216@dread.disaster.area>
References: <20200117202219.GB295250@vader>
 <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader>
 <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader>
 <20200118022032.GR8904@ZenIV.linux.org.uk>
 <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader>
 <20200123034745.GI23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123034745.GI23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=eqEhQ2W7mF93FbYHClaXRw==:117 a=eqEhQ2W7mF93FbYHClaXRw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=agfXOARqqYv4CNyIZKwA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:47:45AM +0000, Al Viro wrote:
> On Wed, Jan 22, 2020 at 02:10:03PM -0800, Omar Sandoval wrote:
> 
> > > Sorry for not reading all the thread again, some API questions:
> > > - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
> > 
> > I wasn't planning on having that restriction. It's not too much effort
> > for filesystems to support it for normal files, so I wouldn't want to
> > place an artificial restriction on a useful primitive.
> 
> I'm not sure; that's how we ended up with the unspeakable APIs like
> rename(2), after all...

Yet it is just rename(2) with the serial numbers filed off -
complete with all the same data vs metadata ordering problems that
rename(2) comes along with. i.e. it needs fsync to guarantee data
integrity of the source file before the linkat() call is made.

If we can forsee that users are going to complain that
linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
leaves zero length files behind after a crash just like rename()
does, then we haven't really improved anything at all...

And, really, I don't think anyone wants another API that requires
multiple fsync calls to use correctly for crash-safe file
replacement, let alone try to teach people who still cant rename a
file safely how to use it....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
