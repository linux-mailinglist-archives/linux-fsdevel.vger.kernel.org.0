Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666FE6F003E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242752AbjD0Evx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 00:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjD0Evw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 00:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F503A92
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 21:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682571065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2s/RO9FptogVncj3HgpgSA6ipdhLtPAA7dorEW4s5iM=;
        b=hDxa60X+j3agqjp+pUM1NRQ+mFqb9QiG7RvbQkNh274EB7kXgTdSi8V04pRQHS9jXPs7i7
        IvFbsFBsDrM586Y3sclx/laCytBcpgcZD432ONRCKBYckED0S2rKIEpNW+TTxWBiyCBEOE
        S13PRw53HGPif/WTQT+NXQXZEk2CizU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-07epsV5EOGqN665UvC9buQ-1; Thu, 27 Apr 2023 00:51:00 -0400
X-MC-Unique: 07epsV5EOGqN665UvC9buQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 237DF2812940;
        Thu, 27 Apr 2023 04:51:00 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 569C1C15BA0;
        Thu, 27 Apr 2023 04:50:52 +0000 (UTC)
Date:   Thu, 27 Apr 2023 12:50:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        ming.lei@redhat.com
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZEny7Izr8iOc/23B@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEny7Izr8iOc/23B@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew,

On Thu, Apr 27, 2023 at 04:58:36AM +0100, Matthew Wilcox wrote:
> On Thu, Apr 27, 2023 at 10:20:28AM +0800, Ming Lei wrote:
> > Hello Guys,
> > 
> > I got one report in which buffered write IO hangs in balance_dirty_pages,
> > after one nvme block device is unplugged physically, then umount can't
> > succeed.
> 
> That's a feature, not a bug ... the dd should continue indefinitely?

Can you explain what the feature is? And not see such 'issue' or 'feature'
on xfs.

The device has been gone, so IMO it is reasonable to see FS buffered write IO
failed. Actually dmesg has shown that 'EXT4-fs (nvme0n1): Remounting
filesystem read-only'. Seems these things may confuse user.

> 
> balance_dirty_pages() is sleeping in KILLABLE state, so kill -9 of
> the dd process should succeed.

Yeah, dd can be killed, however it may be any application(s), :-)

Fortunately it won't cause trouble during reboot/power off, given
userspace will be killed at that time.



Thanks,
Ming

