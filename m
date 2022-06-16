Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF754E1B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376631AbiFPNRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbiFPNRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB500255BD
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jun 2022 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655385463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i5RADxigDcqh0YvPeRXWIXmEeyc1rLKtSi/HgTqXy+8=;
        b=iHdYKAiu/fLf69USyVajgWjOhADN5LPPR0sdkPC7Ph6GITIz3JB6Lpy9cC0SxhE9zKs+Xs
        lLfkSA2Ah/2dFBwnx4MXZz4oYe+dD0HzfDPM1fsADRo5PKC4sE+urJJ86nxP7dYWFtFIO4
        uBYRkwVxrKvW5yyfxKa+s/U5syQtyjA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-Vaa9Q1p_O2qKExQL9JnB_Q-1; Thu, 16 Jun 2022 09:17:40 -0400
X-MC-Unique: Vaa9Q1p_O2qKExQL9JnB_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06ABA811E76;
        Thu, 16 Jun 2022 13:17:40 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED6B02026985;
        Thu, 16 Jun 2022 13:17:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A8F0E2209F9; Thu, 16 Jun 2022 09:17:39 -0400 (EDT)
Date:   Thu, 16 Jun 2022 09:17:39 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 1/1] Allow non-extending parallel direct writes on the
 same file.
Message-ID: <Yqstc/0F8y+vvVMd@redhat.com>
References: <20220605072201.9237-1-dharamhans87@gmail.com>
 <20220605072201.9237-2-dharamhans87@gmail.com>
 <Yp/CYjONZHoekSVA@redhat.com>
 <34dd96b3-e253-de4e-d5d3-a49bc1990e6f@ddn.com>
 <Yp/KnF0oSIsk0SYd@redhat.com>
 <3d189ccc-437e-d9c0-e9f1-b4e0d2012e3c@ddn.com>
 <YqH7PO7KtoiXkmVH@redhat.com>
 <CAJfpegsbNPuy3YmGZ1prUyir_h_5noGZLN8R__o0=iz8n4Y9og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsbNPuy3YmGZ1prUyir_h_5noGZLN8R__o0=iz8n4Y9og@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:01:59AM +0200, Miklos Szeredi wrote:
> On Thu, 9 Jun 2022 at 15:53, Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > Right. If user space is relying on kernel lock for thread synchronization,
> > it can not enable parallel writes.
> >
> > But if it is not relying on this, it should be able to enable parallel
> > writes. Just keep in mind that ->i_size check is not sufficient to
> > guarantee that you will not get "two extnding parallel writes". If
> > another client on a different machine truncated the file, it is
> > possible this client has old cached ->i_size and it will can
> > get multiple file extending parallel writes.
> 
> There are two cases:
> 
> 1. the filesystem can be changed only through a single fuse instance
> 
> 2. the filesystem can be changed externally.
> 
> In case 1 the fuse client must ensure that data is updated
> consistently (as defined by e.g. POSIX).  This is what I'm mostly
> worried about.
> 
> Case 2 is much more difficult in the general case, and network
> filesystems often have a relaxed consistency model.
> 
> 
> > So if fuse daemon enables parallel extending writes, it should be
> > prepared to deal with multiple extending parallel writes.
> >
> > And if this is correct assumption, I am wondering why to even try
> > to do ->i_size check and try to avoid parallel extending writes
> > in fuse kernel. May be there is something I am not aware of. And
> > that's why I am just raising questions.
> 
> We can probably do that, but it needs careful review of where i_size
> is changed and where i_size is used so we can never get into an
> inconsistent state.

Ok. Agreed that non-extending parallel writes are safer option. Atleast
for the case 1) above. For case 2) we can get multiple parallel extending
writes with these patches if another client on another machine truncates
file.

So I don't have any objections to these patches. I just wanted to
understand it better.

Thanks
Vivek

