Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789DC719B1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 13:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFALqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjFALqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F3134
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685619946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7ULdJ4Ab2b47vEWN486zFKO2o/CmnOZmXp0dkx+i0c=;
        b=dPJVOOm9cuD8q7B7sAqiPCE/SqUbMlrBDhBT3CbZwM99LB98okg+pYD2cY52kPMz/vw/fz
        SJJv6qIx55Bq+6Jif+mFUH5LJPmBP1vPC/FrBEU1KGpoMzU/m46lWRycSFzslBl9fTdXBH
        lYe2VRscchbWvF0s7OdtH/ix1ceCLcs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-mMIuAwj2MKiKI-pxk9nXWA-1; Thu, 01 Jun 2023 07:45:32 -0400
X-MC-Unique: mMIuAwj2MKiKI-pxk9nXWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 873C0802355;
        Thu,  1 Jun 2023 11:45:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2BD8C154D7;
        Thu,  1 Jun 2023 11:45:31 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
        id 5EE5716F1EC; Thu,  1 Jun 2023 07:45:31 -0400 (EDT)
Date:   Thu, 1 Jun 2023 07:45:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        gerry@linux.alibaba.com, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] fuse: fix return value of inode_inline_reclaim_one_dmap
 in error path
Message-ID: <ZHiE2zkFJKBl9GZ+@redhat.com>
References: <20230424123250.125404-1-jefflexu@linux.alibaba.com>
 <ZHeoIFrp303f0E8d@redhat.com>
 <33fd8e03-7c99-c12d-255d-b7190612379b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fd8e03-7c99-c12d-255d-b7190612379b@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:45:52AM +0800, Jingbo Xu wrote:
> 
> 
> On 6/1/23 4:03 AM, Vivek Goyal wrote:
> > On Mon, Apr 24, 2023 at 08:32:50PM +0800, Jingbo Xu wrote:
> >> When range already got reclaimed by somebody else, return NULL so that
> >> the caller could retry to allocate or reclaim another range, instead of
> >> mistakenly returning the range already got reclaimed and reused by
> >> others.
> >>
> >> Reported-by: Liu Jiang <gerry@linux.alibaba.com>
> >> Fixes: 9a752d18c85a ("virtiofs: add logic to free up a memory range")
> >> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > 
> > Hi Jingbo,
> > 
> > This patch looks correct to me.
> > 
> > Are you able to reproduce the problem? Or you are fixing it based on
> > code inspection?
> 
> It's spotted by Liu Jiang during code review.  Not tested yet.
> 
> > 
> > How are you testing this? We don't have virtiofsd DAX implementation yet
> > in rust virtiofsd yet. 
> > 
> > I am not sure how to test this chagne now. We had out of tree patches
> > in qemu and now qemu has gotten rid of C version of virtiofsd so these
> > patches might not even work now.
> 
> Yeah this exception path may not be so easy to be tested as it is only
> triggered in the race condition.  I have the old branch (of qemu) with
> support for DAX, and maybe I could try to reproduce the exception path
> by configuring limited DAX window and heavy IO workload.

That would be great. Please test it with really small DAX window size.
Also put some pr_debug() statements to make sure you are hitting this
particular path during testing.

Thanks
Vivek

