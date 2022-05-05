Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0751C9CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 21:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385512AbiEEUCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 16:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383706AbiEEUCv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 16:02:51 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 681CB5EBE7
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651780749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBYz8oIHOIDYp4BEZnUrEb3KsOkemOKPjddPARtaHag=;
        b=iFfRxCVSfNER4noyTLIZVy6A0Cm+dozrPtnDUDTWB9L4G+vJVwk5Fo7dExmbPzuG0h2hly
        WvRrD9wUPhXqLPDiIpeXMeR+uTXE8aK57RSVFzMjf/j9yqc0JpKetz4NRJinDHF9RJ89wz
        azooleHzAmwD25xa5yP6FeKwrJij+Z0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-04jmGuanPTOPvZVvO1TW4g-1; Thu, 05 May 2022 15:59:08 -0400
X-MC-Unique: 04jmGuanPTOPvZVvO1TW4g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C54A299E76A;
        Thu,  5 May 2022 19:59:07 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 650B241616B;
        Thu,  5 May 2022 19:59:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1FAFB220463; Thu,  5 May 2022 15:59:07 -0400 (EDT)
Date:   Thu, 5 May 2022 15:59:07 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Hans <dharamhans87@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Message-ID: <YnQsizX5Q1sMnlI2@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com>
 <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
 <YnPI6f2fRZUXbCFP@redhat.com>
 <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 05:13:00PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/5/22 14:54, Vivek Goyal wrote:
> > On Thu, May 05, 2022 at 11:42:51AM +0530, Dharmendra Hans wrote:
> > > Here are the numbers I took last time. These were taken on tmpfs to
> > > actually see the effect of reduced calls. On local file systems it
> > > might not be that much visible. But we have observed that on systems
> > > where we have thousands of clients hammering the metadata servers, it
> > > helps a lot (We did not take numbers yet as  we are required to change
> > > a lot of our client code but would be doing it later on).
> > > 
> > > Note that for a change in performance number due to the new version of
> > > these patches, we have just refactored the code and functionality has
> > > remained the same since then.
> > > 
> > > here is the link to the performance numbers
> > > https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/
> > 
> > There is a lot going in that table. Trying to understand it.
> > 
> > - Why care about No-Flush. I mean that's independent of these changes,
> >    right?  I am assuming this means that upon file close do not send
> >    a flush to fuse server. Not sure how bringing No-Flush into the
> >    mix is helpful here.
> 
> 
> It is a basically removing another call from kernel to user space. The calls
> there are, the lower is the resulting percentage for atomic-open.

Ok. You want to get rid of FUSE_FLUSH call so that % of FUSE_LOOKUP calls
go up and that will effectively show higher % of improvement due to
this. 

> 
> 
> > 
> > - What is "Patched Libfuse"? I am assuming that these are changes
> >    needed in libfuse to support atomic create + atomic open. Similarly
> >    assuming "Patched FuseK" means patched kernel with your changes.
> 
> Yes, I did that to ensure there is no regression with the patches, when the
> other side is not patched.
> 
> > 
> >    If this is correct, I would probably only be interested in
> >    looking at "Patched Libfuse + Patched FuseK" numbers to figure out
> >    what's the effect of your changes w.r.t vanilla kernel + libfuse.
> >    Am I understanding it right?
> 
> Yes.
> 
> > 
> > - I am wondering why do we measure "Sequential" and "Random" patterns.
> >    These optimizations are primarily for file creation + file opening
> >    and I/O pattern should not matter.
> 
> bonnie++ does this automatically and it just convenient to take the bonnie++
> csv value and to paste them into a table.
> 
> In our HPC world mdtest is more common, but it has MPI as requirement - make
> it harder to run. Reproducing the values with bonnie++ should be rather easy
> for you.
> 
> Only issue with bonnie++ is that bonnie++ by default does not run
> multi-threaded and the old 3rd party perl scripts I had to let it run with
> multiple processes and to sum up the values don't work anymore with recent
> perl versions. I need to find some time to fix that.
> 
> 
> > 
> > - Also wondering why performance of Read/s improves. Assuming once
> >    file has been opened, I think your optimizations get out of the
> >    way (no create, no open) and we are just going through data path of
> >    reading file data and no lookups happening. If that's the case, why
> >    do Read/s numbers show an improvement.
> 
> That is now bonnie++ works. It creates the files, closes them (which causes
> the flush) and then re-opens for stat and read - atomic open comes into the
> picture here. Also read() is totally skipped when the files are empty -
> which is why one should use something like 1B files.
> 
> If you have another metadata benchmark - please let us know.

Once I was pointed at smallfile.

https://github.com/distributed-system-analysis/smallfile

I ran this when I was posting the patches for virtiofs.

https://patchwork.kernel.org/project/linux-fsdevel/cover/20181210171318.16998-1-vgoyal@redhat.com/

See if this is something interesting to you.


> 
> > 
> > - Why do we measure "Patched Libfuse". It shows performance regression
> >    of 4-5% in table 0B, Sequential workoad. That sounds bad. So without
> >    any optimization kicking in, it has a performance cost.
> 
> Yes, I'm not sure yet. There is not so much code that has changed on the
> libfuse side.
> However the table needs to be redone with fixed libfuse - limiting the
> number of threads caused a permanent libfuse thread creation and destruction
> 
> https://github.com/libfuse/libfuse/pull/652
> 
> The numbers in table are also with paththrough_ll, which has its own issue
> due to linear inode search. paththrough_hp uses a C++ map and avoids that. I
> noticed too late when I started to investigate why there are regressions....
> 
> Also the table made me to investigate/profile all the fuse operations, which
> resulted in my waitq question. Please see that thread for more details https://lore.kernel.org/lkml/9326bb76-680f-05f6-6f78-df6170afaa2c@fastmail.fm/T/
> 
> Regarding atomic-open/create with avoiding lookup/revalidate, our primary
> goal is to reduce network calls. A file system that handles it locally only
> reduces the number of fuse kernel/user space crossing. A network file system
> that fully supports it needs to do the atomic open (or in old terms
> lookup-intent-open) on the server side of the network and needs to transfer
> attributes together with the open result.

Oh, I have no issues with the intent. I will like to see cut in network
traffic too (if we can do this without introducing problems). My primary
interest is that this kind of change should benefit virtiofs as well.

I am just trying to understand how much performance improvement is
actually there. And also trying to improve the quality of implementation.
Frankly speaking, it all seems very twisted and hard to read (and
hence maintain) code at this point fo time.

That's why I am going into the details to understand and suggest some
improvements.

Thanks
Vivek

> 
> Lustre does this, although I cannot easily point you to the right code. It
> all started almost two decades ago:
> https://groups.google.com/g/lucky.linux.fsdevel/c/iYNFIIrkJ1s
> 
> 
> BeeGFS does this as well
> https://git.beegfs.io/pub/v7/-/blob/master/client_module/source/filesystem/FhgfsOpsInode.c
> See for examaple FhgfsOps_atomicOpen() and FhgfsOps_createIntent()
> 
> (FhGFS is the old name when I was still involved in the project.)
> 
> From my head I'm not sure if NFS does it over the wire, maybe v4.
> 
> 
> Thanks,
> Bernd
> 
> 
> 
> 
> 
> 

