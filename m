Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066F16E85F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 01:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjDSXcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 19:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjDSXcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:32:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333935A3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 16:32:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63d4595d60fso3235689b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681947167; x=1684539167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XVPu+f8UpKVdX5LhOFNZNUccbpjEUaJMQwYn4eLNppI=;
        b=sgqFjkz74tih5s3kSz9L2uAbFEJqj34+Q/Z2A7BAaNmARaNR+Qzw8OcuMtLHF9beSs
         RxCFsRAeyUI05/ReeU84siBy3V/xA9JgHXUeV79M6YCgzhhIrhjLGikNO+Elq8L4e85f
         3mRXjZwCUCFB5/i0dhSPmxYektdRUsgh2agz0e9rp8VvmfpxXBDJr46SmA3Nx09vMTw0
         dfb+c+dGLj2v+cVoGkJlZ55Wd6VpY1Gg0lGZCMh35Pr7Epjr/1+t70VPUwnRk+RaNMZg
         mG+jgQmR1HLDEQb+/3twq5UdzflC9YrbD0N+t9o7dE9Ik/yTFpDf1f9FQSapiopyIT1W
         hnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681947167; x=1684539167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVPu+f8UpKVdX5LhOFNZNUccbpjEUaJMQwYn4eLNppI=;
        b=gKthOjjRDXqYbbfrggFtJPUb8fFajEYrOFSJXRD5r+BRqcp6+v9bjDNjTFojm04kFn
         iVu8G9jaHcdr7yBBrFqHTgWkEoheY+uSqMJGIGcqqsx9FIsSIfUmn4be4WsfDri49GJT
         sj7YK4WJL87u9my+5VAHKMFypZd7EmTC07YYuGewLOCcmAiVedlYUaJ1S+JyS/XUfgBv
         RWVuISy0eZMuxlb781nwiNOrFaSfV6UQHpF+fCJz1kAVSgCfKPbMXVSCOcffTQrvZ+Ch
         XurFnK/jW6iFirl2Qozoyby/oKNbPvJu+3HlBI4VJMC4vGzNXNhgWAAfrsMi+2GaMtVP
         CDgQ==
X-Gm-Message-State: AAQBX9ernluSWnXHgSuRS1VsHLn5rJogbPsLz5PcNlQlfMQrXV0+F4CQ
        GIRnqzt6qWMXwRIGhv1ziRxmHQ==
X-Google-Smtp-Source: AKy350ZxXpDEylBrVNZD3esB0oOUwFConbodE061zkY7YRJA5nYoyCngPUn2ADOo904yyypEDZekrQ==
X-Received: by 2002:a17:90a:9e5:b0:246:aeee:e61c with SMTP id 92-20020a17090a09e500b00246aeeee61cmr4269732pjo.11.1681947166775;
        Wed, 19 Apr 2023 16:32:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902bd4300b001a67eace820sm32035plx.3.2023.04.19.16.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 16:32:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ppHI3-005Rde-DU; Thu, 20 Apr 2023 09:32:43 +1000
Date:   Thu, 20 Apr 2023 09:32:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jeff Layton <jlayton@kernel.org>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Message-ID: <20230419233243.GM447837@dread.disaster.area>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
 <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
 <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
 <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
 <20230416233758.GD447837@dread.disaster.area>
 <A23409BB-9BA1-44E5-96A8-C080B417CCB5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A23409BB-9BA1-44E5-96A8-C080B417CCB5@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 01:51:12PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 16, 2023, at 7:37 PM, Dave Chinner <david@fromorbit.com> wrote:
> > 
> > On Sun, Apr 16, 2023 at 07:51:41AM -0400, Jeff Layton wrote:
> >> On Sun, 2023-04-16 at 08:21 +0900, Tetsuo Handa wrote:
> >>> On 2023/04/16 3:40, Jeff Layton wrote:
> >>>> On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
> >>>>> On 2023/04/16 1:13, Chuck Lever III wrote:
> >>>>>>> On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >>>>>>> 
> >>>>>>> Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP_NOFS
> >>>>>>> does not make sense. Drop __GFP_FS flag in order to avoid deadlock.
> >>>>>> 
> >>>>>> The server side threads run in process context. GFP_KERNEL
> >>>>>> is safe to use here -- as Jeff said, this code is not in
> >>>>>> the server's reclaim path. Plenty of other call sites in
> >>>>>> the NFS server code use GFP_KERNEL.
> >>>>> 
> >>>>> GFP_KERNEL memory allocation calls filesystem's shrinker functions
> >>>>> because of __GFP_FS flag. My understanding is
> >>>>> 
> >>>>>  Whether this code is in memory reclaim path or not is irrelevant.
> >>>>>  Whether memory reclaim path might hold lock or not is relevant.
> >>>>> 
> >>>>> . Therefore, question is, does nfsd hold i_rwsem during memory reclaim path?
> >>>>> 
> >>>> 
> >>>> No. At the time of these allocations, the i_rwsem is not held.
> >>> 
> >>> Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
> >>> via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) allocation.
> >>> That's why
> >>> 
> >>> /*
> >>>  * We're holding i_rwsem - use GFP_NOFS.
> >>>  */
> >>> 
> >>> is explicitly there in nfsd_listxattr() side.
> > 
> > You can do GFP_KERNEL allocations holding the i_rwsem just fine.
> > All that it requires is the caller holds a reference to the inode,
> > and at that point inode will should skip the given inode without
> > every locking it.
> 
> This suggests that the fix is to replace "GFP_KERNEL | GFP_NOFS"
> with "GFP_KERNEL" /and/ ensure those paths are holding an
> appropriate inode reference.

If the code that provided the inode to nfsd_listxattr() did not
already have an active inode reference in the first place then there
are much, much bigger UAF problems to worry about than simple
memory reclaim deadlocks.

That said, nfsd_listxattr() does:

        dentry = fhp->fh_dentry;
        inode = d_inode(dentry);
        *lenp = 0;

        inode_lock_shared(inode);

        len = vfs_listxattr(dentry, NULL, 0);

Given that a dentry pointing to an inode *must* hold an active
reference to that inode, I don't see how it is possible this code
path could be using an unreferenced inode.

nfsd_getxattr() has a similar code fragment to obtain the inode as
well, so same goes for that...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
