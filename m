Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A904A53532E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245254AbiEZSOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiEZSO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 14:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E9D9AFAFF
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653588866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+/f5rCCX5O2YnIFMqX5A6PQPJ8kjAWayKsnZFb/i6I=;
        b=Uu0+kDK0Ej9YaO3wgUTS+dn51UR+8kbSq49nhxyn1pdKl6Ponwm7HA4ZgWh4g6dBndgT44
        EWAJvUL8NMZL81KjxGaer00pmTgu5I/JvxwDZ/5FRjL6LxZ6oDIhxn9qqFDv6jB5IJlrGm
        qbIEB50j+QkyxfnEyi+GTMJHg8oPM0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-QGQMv57xNBOCTKB7phssCw-1; Thu, 26 May 2022 14:14:24 -0400
X-MC-Unique: QGQMv57xNBOCTKB7phssCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5631E801228;
        Thu, 26 May 2022 18:14:24 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 285D2400F3E8;
        Thu, 26 May 2022 18:14:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D98762208FA; Thu, 26 May 2022 14:14:23 -0400 (EDT)
Date:   Thu, 26 May 2022 14:14:23 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v3 1/1] FUSE: Allow non-extending parallel direct writes
 on the same file.
Message-ID: <Yo/DfzU7IXZbADK5@redhat.com>
References: <20220520043443.17439-1-dharamhans87@gmail.com>
 <20220520043443.17439-2-dharamhans87@gmail.com>
 <Yo6SBoEgGgnNQv8W@redhat.com>
 <3350e4e2-bad5-7f2f-2b09-c1807815a29c@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3350e4e2-bad5-7f2f-2b09-c1807815a29c@ddn.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 10:49:49PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/25/22 22:31, Vivek Goyal wrote:
> > On Fri, May 20, 2022 at 10:04:43AM +0530, Dharmendra Singh wrote:
> > > From: Dharmendra Singh <dsingh@ddn.com>
> > > 
> > > In general, as of now, in FUSE, direct writes on the same file are
> > > serialized over inode lock i.e we hold inode lock for the full duration
> > > of the write request. I could not found in fuse code a comment which
> > > clearly explains why this exclusive lock is taken for direct writes.
> > > Our guess is some USER space fuse implementations might be relying
> > > on this lock for seralization and also it protects for the issues
> > > arising due to file size assumption or write failures.  This patch
> > > relaxes this exclusive lock in some cases of direct writes.
> > 
> > I have this question as well. My understanding was that in general,
> > reads can do shared lock while writes have to take exclusive lock.
> > And I assumed that extends to both buffered as well as direct
> > writes.
> > 
> > I would also like to understand what's the fundamental restriction
> > and why O_DIRECT is special that this restriction does not apply.
> > 
> > Is any other file system doing this as well?
> > 
> > If fuse server dir is shared with other fuse clients, it is possible
> > that i_size in this client is stale. Will that be a problem. I guess
> > if that's the problem then, even a single write will be a problem
> > because two fuse clients might be trying to write.
> > 
> > Just trying to make sure that it is safe to allow parallel direct
> > writes.
> 
> I think missing in this series is to add a comment when this lock is needed
> at all. Our network file system is log structured - any parallel writes to
> the same file from different remote clients are handled through addition of
> fragments on the network server side - lockless safe due to byte level
> accuracy. With the exception of conflicting writes - last client wins -
> application is then doing 'silly' things - locking would not help either.
> And random parallel writes from the same (network) client are even an ideal
> case for us, as that is handled through shared blocks for different
> fragments (file offset + len). So for us shared writes are totally safe.
> 
> When Dharmendra and I discussed about the lock we came up with a few write
> error handling cases where that lock might be needed - I guess that should
> be added as comment.

Right, please add the changelogs to make thought process clear.

So there are no restrictions on the fuse client side from parallelism
point of view on direct write path? 

Why file extending writes are not safe? Is this a restriction from
fuse client point of view or just being safe from server point of view.
If fuse user space is talking to another filesystem, I guess then it
is not problem because that filesystem will take care of locking as
needed.

I see ext4 is allowing parallel direct writes for certain cases. And
where they can't allow it, they have documented it in comments.
(ext4_dio_write_checks()). I think we need similar rationalization,
especially from fuse client's perspective and have comments in code
and specify when it is ok to have parallel direct writes and when it
is not ok and why. This will help people when they are looking at
the code later.

Thanks
Vivek

