Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB5D70752B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEQWN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 18:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEQWN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 18:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98EB35A9
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684361558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQ4eY+QHN6MZUcecmxgnEyYB8n0iVk8zO1FGyd+f7WY=;
        b=R3MX0oJn9H9G41E2Gje1hRqidLaP8ta9/FbOj46F0Ggf8u9hqWADsqElrrRTxFHIHPEkfV
        0SQoiLOZR1TgTSGOnj9ZeqxZre31UCf2LVTWQhBZ3eY86hntccW17pzcETOcCITnwsTM06
        34wL4eEvR/uhEkhz/TGWgV8g3dajrQI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-NOlb93GmP-O-1U7gMDXD-g-1; Wed, 17 May 2023 18:12:36 -0400
X-MC-Unique: NOlb93GmP-O-1U7gMDXD-g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61b636b5f90so2494086d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 15:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684361556; x=1686953556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ4eY+QHN6MZUcecmxgnEyYB8n0iVk8zO1FGyd+f7WY=;
        b=azSY2AOZLIo/+K45YRP4oBybjwV1mzgYe058U1kJL38ARKdcqnuhoQd1a4jTQsVtFc
         uHJTsNwBjzZ+1o8molkqjQ7HpsovXO/K4vaIkB0r9pHP2iu09C3mqgiFG57odPxKwrtA
         JaKibVtD6sNeBYLzRTMN3cdGCt/h8+i2dHBbXSl1gM3rjVGXIc7zbp9JfBp5aliv7XL3
         o/tlShgjuXfRDhGHVvsCpCqZOfdg7zgvnnO7Kg+uXQ1mC2YlAhJ317/l0/nUNJmeaHdp
         uVIXGmCUUcAVg5qCKddFwq/VMIaSxV7k7nUftT8urGKGXHC0EojSBXlgw13MwPjybTmx
         rhog==
X-Gm-Message-State: AC+VfDx+51Me6tPHsxWn6VFXQz7JeIXh2Z0KY7JZfwJR3xcM3TST9Aep
        fAaS2okam86kx1EfXxlXTva/BGtG5OcYoUWmOcY6ATmEn8YbnP4224US6RL4mfeKfLQaIIZQMvv
        SdorijpRMSa+sJa5aJ9v1vRZImw==
X-Received: by 2002:a05:6214:21a7:b0:616:73d9:b9d8 with SMTP id t7-20020a05621421a700b0061673d9b9d8mr7954296qvc.3.1684361556022;
        Wed, 17 May 2023 15:12:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4IBdp4rAChvSgr7/T0wB6VEVMyIOGDgFjPF/1CWdQad7Ykw0oUGaxhyHzwZBHh/W1zQHQi7A==
X-Received: by 2002:a05:6214:21a7:b0:616:73d9:b9d8 with SMTP id t7-20020a05621421a700b0061673d9b9d8mr7954268qvc.3.1684361555684;
        Wed, 17 May 2023 15:12:35 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id mk1-20020a056214580100b0061b5a3d1d54sm54453qvb.87.2023.05.17.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:12:35 -0700 (PDT)
Date:   Wed, 17 May 2023 18:12:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
Message-ID: <ZGVRUeCWr8209m8d@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
> On Thu, May 11, 2023 at 11:24 AM Axel Rasmussen
> <axelrasmussen@google.com> wrote:
> >
> > So the basic way to use this new feature is:
> >
> > - On the new host, the guest's memory is registered with userfaultfd, in
> >   either MISSING or MINOR mode (doesn't really matter for this purpose).
> > - On any first access, we get a userfaultfd event. At this point we can
> >   communicate with the old host to find out if the page was poisoned.
> > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
> >   so any future accesses will SIGBUS. Because the pte is now "present",
> >   future accesses won't generate more userfaultfd events, they'll just
> >   SIGBUS directly.
> 
> I want to clarify the SIGBUS mechanism here when KVM is involved,
> keeping in mind that we need to be able to inject an MCE into the
> guest for this to be useful.
> 
> 1. vCPU gets an EPT violation --> KVM attempts GUP.
> 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
> 3. KVM finds that GUP failed and returns -EFAULT.
> 
> This is different than if GUP found poison, in which case KVM will
> actually queue up a SIGBUS *containing the address of the fault*, and
> userspace can use it to inject an appropriate MCE into the guest. With
> UFFDIO_SIGBUS, we are missing the address!
> 
> I see three options:
> 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
> this is pointless.
> 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
> UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGBUS
> instead of VM_FAULT_RETRY. We will keep getting userfaults on repeated
> accesses, just like how we get repeated signals for real poison.
> 3. Use this in conjunction with the additional KVM EFAULT info that
> Anish proposed (the first part of [1]).
> 
> I think option 3 is fine. :)

Or... option 4) just to use either MADV_HWPOISON or hwpoison-inject? :)

Besides what James mentioned on "missing addr", I didn't quickly see what's
the major difference comparing to the old hwpoison injection methods even
without the addr requirement. If we want the addr for MCE then it's more of
a question to ask.

I also didn't quickly see why for whatever new way to inject a pte error we
need to have it registered with uffd.  Could it be something like
MADV_PGERR (even if MADV_HWPOISON won't suffice) so you can inject even
without an userfault context (but still usable when uffd registered)?

And it'll be alawys nice to have a cover letter too (if there'll be a new
version) explaining the bits.

Thanks,

-- 
Peter Xu

