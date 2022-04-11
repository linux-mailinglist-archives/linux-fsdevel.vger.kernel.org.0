Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1664B4FBB5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 13:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiDKLzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 07:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDKLzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 411033150B
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649677972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NcVwl4hk2osdz0nnxgjdlNsnOYwO3zBKACakreX4P+I=;
        b=GuSvmRqwk7CYQsFwQTthPZ1evh5myIBrzasUoZPuLWnYsRg6XhdBr4RzPM3r3HO1XyYj5n
        JwuP5g24J2KZHHCeh5xqt2M45O3SOfLDbbQAAR1UlcmyHv8JZXHCmDV6PEN3xmLW2gG+i6
        IT2unlzWx/uRA1dIf4VAtegEqsnl+hE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-2q6WbjbZNiC3RMmMR8ep5A-1; Mon, 11 Apr 2022 07:52:49 -0400
X-MC-Unique: 2q6WbjbZNiC3RMmMR8ep5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBF1E29ABA2E;
        Mon, 11 Apr 2022 11:52:48 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0EA5C35993;
        Mon, 11 Apr 2022 11:52:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 66DC1220079; Mon, 11 Apr 2022 07:52:48 -0400 (EDT)
Date:   Mon, 11 Apr 2022 07:52:48 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Message-ID: <YlQWkGl1YQ+ioDas@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
 <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
 <YlAlR0xVDqQzl98w@redhat.com>
 <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:10:23AM +0800, JeffleXu wrote:
> 
> 
> On 4/8/22 8:06 PM, Vivek Goyal wrote:
> > On Fri, Apr 08, 2022 at 07:50:55PM +0800, JeffleXu wrote:
> >>
> >>
> >> On 4/8/22 7:25 PM, Vivek Goyal wrote:
> >>> On Fri, Apr 08, 2022 at 10:36:40AM +0800, JeffleXu wrote:
> >>>>
> >>>>
> >>>> On 4/7/22 10:10 PM, Vivek Goyal wrote:
> >>>>> On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
> >>>>>> Move dmap free worker kicker inside the critical region, so that extra
> >>>>>> spinlock lock/unlock could be avoided.
> >>>>>>
> >>>>>> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
> >>>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >>>>>
> >>>>> Looks good to me. Have you done any testing to make sure nothing is
> >>>>> broken.
> >>>>
> >>>> xfstests -g quick shows no regression. The tested virtiofs is mounted
> >>>> with "dax=always".
> >>>
> >>> I think xfstests might not trigger reclaim. You probably will have to
> >>> run something like blogbench with a small dax window like 1G so that
> >>> heavy reclaim happens.
> >>
> >>
> >> Actually, I configured the DAX window to 8MB, i.e. 4 slots when running
> >> xfstests. Thus I think the reclaim path is most likely triggered.
> >>
> >>
> >>>
> >>> For fun, I sometimes used to run it with a window of just say 16 dax
> >>> ranges so that reclaim was so heavy that if there was a bug, it will
> >>> show up.
> >>>
> >>
> >> Yeah, my colleague had ever reported that a DAX window of 4KB will cause
> >> hang in our internal OS (which is 4.19, we back ported virtiofs to
> >> 4.19). But then I found that this issue doesn't exist in the latest
> >> upstream. The reason seems that in the upstream kernel,
> >> devm_memremap_pages() called in virtio_fs_setup_dax() will fail directly
> >> since the dax window (4KB) is not aligned with the sparse memory section.
> > 
> > Given our default chunk size is 2MB (FUSE_DAX_SHIFT), may be it is not
> > a bad idea to enforce some minimum cache window size. IIRC, even one
> > range is not enough. Minimum 2 are required for reclaim to not deadlock.
> 
> Curiously, why minimum 1 range is not adequate? In which case minimum 2
> are required?

Frankly speaking, right now I don't remember. I have vague memories
of concluding in the past that 1 range is not sufficient. But if you
like dive deeper, and try with one range and see if you can introduce
deadlock.

Thanks
Vivek

