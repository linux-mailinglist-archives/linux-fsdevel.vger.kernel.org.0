Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16D75C830
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGUNth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGUNtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FD52736
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689947327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+59IsCifznfcjfYMwQ8rMA4IccTRHGWrePtCutftbmo=;
        b=gkgmZPI9LqQMIt8kbUMsDsKNrd3KSrxc84a13PedmKyqwPP785jVfmWdwOZYK3qhtJnH9u
        6hIT19FB8K62cCXG4Gwow/UKCwI8GFAuzWb7g2EXxPDhDV5jaT4dmBj7i9zN5QfCVTOH+A
        OkLmJDTUYt1OU2aMUd76P/W6x1FaZi4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-_7G0T2gjOm2_EVha-4a6RQ-1; Fri, 21 Jul 2023 09:48:42 -0400
X-MC-Unique: _7G0T2gjOm2_EVha-4a6RQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 092A93815EEE;
        Fri, 21 Jul 2023 13:48:42 +0000 (UTC)
Received: from localhost (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FE16492B03;
        Fri, 21 Jul 2023 13:48:40 +0000 (UTC)
Date:   Fri, 21 Jul 2023 21:48:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHc2fm+9daF6cgCE@krava>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jiri,

On 05/31/23 at 01:58pm, Jiri Olsa wrote:
> On Thu, Mar 23, 2023 at 10:15:16AM +0000, Lorenzo Stoakes wrote:
> > Commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")
> > introduced the use of a bounce buffer to retrieve kernel text data for
> > /proc/kcore in order to avoid failures arising from hardened user copies
> > enabled by CONFIG_HARDENED_USERCOPY in check_kernel_text_object().
> > 
> > We can avoid doing this if instead of copy_to_user() we use _copy_to_user()
> > which bypasses the hardening check. This is more efficient than using a
> > bounce buffer and simplifies the code.
> > 
> > We do so as part an overall effort to eliminate bounce buffer usage in the
> > function with an eye to converting it an iterator read.
> > 
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> hi,
> sorry for late feedback, but looks like this one breaks reading
> /proc/kcore with objdump for me:
> 
>   # cat /proc/kallsyms | grep ksys_read
>   ffffffff8150ebc0 T ksys_read
>   # objdump -d  --start-address=0xffffffff8150ebc0 --stop-address=0xffffffff8150ebd0 /proc/kcore 
> 
>   /proc/kcore:     file format elf64-x86-64
> 
>   objdump: Reading section load1 failed because: Bad address
> 
> reverting this makes it work again

I met this too when I executed below command to trigger a kcore reading.
I wanted to do a simple testing during system running and got this.

  makedumpfile --mem-usage /proc/kcore

Later I tried your above objdump testing, it corrupted system too.

Is there any conclusion about this issue you reported? I could miss
things in the discussion or patch posting to fix this.

Thanks
Baoquan

> 
> 
> > ---
> >  fs/proc/kcore.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > index 71157ee35c1a..556f310d6aa4 100644
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> > @@ -541,19 +541,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  		case KCORE_VMEMMAP:
> >  		case KCORE_TEXT:
> >  			/*
> > -			 * Using bounce buffer to bypass the
> > -			 * hardened user copy kernel text checks.
> > +			 * We use _copy_to_user() to bypass usermode hardening
> > +			 * which would otherwise prevent this operation.
> >  			 */
> > -			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> > -				if (clear_user(buffer, tsz)) {
> > -					ret = -EFAULT;
> > -					goto out;
> > -				}
> > -			} else {
> > -				if (copy_to_user(buffer, buf, tsz)) {
> > -					ret = -EFAULT;
> > -					goto out;
> > -				}
> > +			if (_copy_to_user(buffer, (char *)start, tsz)) {
> > +				ret = -EFAULT;
> > +				goto out;
> >  			}
> >  			break;
> >  		default:
> > -- 
> > 2.39.2
> > 
> 

