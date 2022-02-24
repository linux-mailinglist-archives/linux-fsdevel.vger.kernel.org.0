Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4811E4C3835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 22:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiBXVxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 16:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiBXVw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:52:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15E7011B5F7
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645739544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7C/VNCLxi2m6BpK/5znlmSIklDnXHXKYOG0purixHNw=;
        b=LArYO9/zQ+aEI9w8I1m0B/kMCLc5P8va8IF7BbOLbcFSrb/72owYNVShfEZthegRRwpDSA
        VuVKse6+bw1pPhg4Uz+vJsbCHZ9+mOHIAA6OAQ1X2qWrOhJ/N+pBXm8viabShv28lUzdt/
        GUH9Ucjv9yJb6aNisFcttv3caHnMvb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-rXgXQ81VOvCJtuyblKFViQ-1; Thu, 24 Feb 2022 16:52:23 -0500
X-MC-Unique: rXgXQ81VOvCJtuyblKFViQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 035A4800482;
        Thu, 24 Feb 2022 21:52:22 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D85E44CEFB;
        Thu, 24 Feb 2022 21:52:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5FF872237E9; Thu, 24 Feb 2022 16:52:21 -0500 (EST)
Date:   Thu, 24 Feb 2022 16:52:21 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>
Subject: Re: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
Message-ID: <Yhf+FemcQQToB5x+@redhat.com>
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:16:33PM -0600, Steve French wrote:
> Currently only local events can be waited on with the current notify
> kernel API since the requests to wait on these events is not passed to
> the filesystem.   Especially for network and cluster filesystems it is
> important that they be told that applications want to be notified of
> these file or directory change events.
> 
> A few years ago, discussions began on the changes needed to enable
> support for this.   Would be timely to finish those discussions, as
> waiting on file and directory change events to network mounts is very
> common for other OS, and would be valuable for Linux to fix.
> 

This sounds like which might have some overlap with what we are trying
to do.

Currently inotify/fanotify only work for local filesystems. We were
thinking is it possible to extend it for remote filesystems as well. My
interest primarily was to make notifications work on virtiofs. So I
asked Ioannis (an intern with us) to try to prototype it and see what are
the challenges and roadblocks.

He posted one version of patches just as proof of concept and only tried
to make remote inotify work. One primary feedback from Amir was that
this is too specific to inotify and if you are extending fsnotify, then
it should have some support for fanotify as well. There is bunch of
other feedback too. So Ioannis is trying to rework his patches now.

https://lore.kernel.org/linux-fsdevel/20211025204634.2517-1-iangelak@redhat.com/

Anyway, you had pointed to following commit.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/cifs/ioctl.c?id=d26c2ddd33569667e3eeb577c4c1d966ca9192e2

So looks like application calls this cifs specific ioctl and blocks and
unblocks when notifications comes, IIUC.

I don't know about SMB and what kind of other notifications does it
support. With this proposal, you are trying to move away from cifs
specific ioctl? What will user use to either block or poll for the
said notification.

Sorry, I might be just completely off the mark. Just trying to find out
if there is any overlap in what you are looking for and what we are
trying to do. 

Thanks
Vivek

> -- 
> Thanks,
> 
> Steve
> 

