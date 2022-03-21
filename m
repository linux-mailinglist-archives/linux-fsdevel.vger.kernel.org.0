Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A648E4E1F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 04:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbiCUD4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 23:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiCUD4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36EEF13EB5
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 20:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647834899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MEC5W64mg/dChPmSON3+rx/2O3+zfOyzeqWukrfjHaE=;
        b=UhK0TEdFoY19+49qHdVGXN0WVXurJPqOOIWy6eahW6Qq4zVZNQr0NcrF7L66/sr+Kxq5Np
        Kbl5jj1fF4r07XCuuLVb5N4f3OWWlD7HL9XedAWYF05gP0EVIdQ2OIpsZoBo/ohlwsJAkO
        heUwlfBvHdh6sxDxbS3MjZ6nWOVSzQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-d0wMJBzJPc23XLU06H5n6Q-1; Sun, 20 Mar 2022 23:54:55 -0400
X-MC-Unique: d0wMJBzJPc23XLU06H5n6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50332802C16;
        Mon, 21 Mar 2022 03:54:55 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B9E02166B2D;
        Mon, 21 Mar 2022 03:54:53 +0000 (UTC)
Date:   Mon, 21 Mar 2022 11:54:50 +0800
From:   'Baoquan He' <bhe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "amit.kachhap@arm.com" <amit.kachhap@arm.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
Message-ID: <Yjf3CivCFMNE/Hbs@MiWiFi-R3L-srv>
References: <20220318093706.161534-1-bhe@redhat.com>
 <20220318093706.161534-5-bhe@redhat.com>
 <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On 03/18/22 at 01:48pm, David Laight wrote:
> From: Baoquan He
> > Sent: 18 March 2022 09:37
> > 
> > To replace open coded iter->count. This makes code cleaner.
> ...
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 4cbb8db7c507..ed58a7edc821 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -319,21 +319,21 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
> >  	u64 start;
> >  	struct vmcore *m = NULL;
> > 
> > -	if (iter->count == 0 || *fpos >= vmcore_size)
> > +	if (!iov_iter_count(iter) || *fpos >= vmcore_size)
> 
> For some definition of 'cleaner' :-)
> 
> iter->count is clearly a simple, cheap structure member lookup.
> OTOH iov_iter_count(iter) might be an expensive traversal of
> the vector (or worse).
> 
> So a quick read of the code by someone who isn't an expert
> in the iov functions leaves them wondering what is going on
> or having to spend time locating the definition ...

Thanks for reviewing and looking into this.

People may have the same feeling as you when looking at codes at the
first glance. While usually we all use editor to explore codes, so.

Basically, I noticed putting open code into wrapper is a tendency, see a
lot of patches to clean up open code in sub component. About the extra
cost of wrapper, I believe it does have. It should be one of reasons
in some places open code is necessary. However, in fs/proc/vmcore, I
don't have the worry since it's very tiny and can be ignorable.

Thanks
Baoquan

