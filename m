Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073E70753D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 00:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjEQWV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 18:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEQWV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 18:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E9469B
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684362038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcaEZoDJHfgt+J9YnbNiKZBp9/Lub2+teMXBeGVG5MA=;
        b=USomMHhVhO69hrPJE7QFl+fBzn1oiUdUIm9YAtH0hh+L+mkImFfXq4nGwXUl9pP++w9TqE
        C6Xvf2N5Ps6h2THRBazMT/T7V2HUkingfX/eIyQlsn3uVGzaF37qZBLdEQu+wlBtcCfZuR
        XmfNe0QhNlAAVuDP5lOUBStXahVRc1E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-vZF0kDpzPWmNs2l6Su32tQ-1; Wed, 17 May 2023 18:20:37 -0400
X-MC-Unique: vZF0kDpzPWmNs2l6Su32tQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f5099edb1cso2029191cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 15:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684362037; x=1686954037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcaEZoDJHfgt+J9YnbNiKZBp9/Lub2+teMXBeGVG5MA=;
        b=fFmK4V3hXWUxAUYX2S/LgvyLOlfBPHcSUouxTa98oHMdIN59YkCgCnb550MkDEVgUV
         E4xMmAZAxTZwhPSmMf7z543sJlta7GtutNRMoY57CQJ4PEuAUbzjhgFoyoe0lY6QBnfJ
         RqxvaJKYJR5Ds1fY+QViyv2I9iW+B3aR/IrzyG7Qe4KE0Ac3zzvOsZztBhti3zWt0S9u
         zw/9ftanNmL89YKybCTwr41TljungJmjzeNHNWEUsVnkYCfF5oCoXqPre2zhMWLsYv7x
         VuOmvDpERdor4Bs5SwVsXiqXIsf3pjuISOmZLa4xe2XGNaXe94E0nL/FlkQzg6wVNcIK
         LPdA==
X-Gm-Message-State: AC+VfDxtM8wkpRrfkHoUIY01pmnkqN6s4HnSSMsrlfubbQg5+jzktK8q
        9MoPvKNqF7XbzmekwCpgTAZnyJmqSy1jwUteXRKqpCKsPChgxu6SHR/h8hw4WtEM58ZvGx7f6Vv
        yx1Yj5Ba4kWSJWWfc5XBc4pq+kA==
X-Received: by 2002:a05:622a:1a27:b0:3f3:9680:c51d with SMTP id f39-20020a05622a1a2700b003f39680c51dmr8042880qtb.0.1684362037289;
        Wed, 17 May 2023 15:20:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51qVMVRnjdvCvS7y5TEkZzxFBB4mc/MDlORK64EYFltlS9Fb1BPgf2+NDqPVLOw0qxDZ9JXw==
X-Received: by 2002:a05:622a:1a27:b0:3f3:9680:c51d with SMTP id f39-20020a05622a1a2700b003f39680c51dmr8042857qtb.0.1684362037020;
        Wed, 17 May 2023 15:20:37 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a15cf00b0075784a8f13csm937274qkm.96.2023.05.17.15.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:20:36 -0700 (PDT)
Date:   Wed, 17 May 2023 18:20:34 -0400
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
Message-ID: <ZGVTMnVKNcQDM0x4@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGVRUeCWr8209m8d@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 06:12:33PM -0400, Peter Xu wrote:
> On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
> > On Thu, May 11, 2023 at 11:24 AM Axel Rasmussen
> > <axelrasmussen@google.com> wrote:
> > >
> > > So the basic way to use this new feature is:
> > >
> > > - On the new host, the guest's memory is registered with userfaultfd, in
> > >   either MISSING or MINOR mode (doesn't really matter for this purpose).
> > > - On any first access, we get a userfaultfd event. At this point we can
> > >   communicate with the old host to find out if the page was poisoned.
> > > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
> > >   so any future accesses will SIGBUS. Because the pte is now "present",
> > >   future accesses won't generate more userfaultfd events, they'll just
> > >   SIGBUS directly.
> > 
> > I want to clarify the SIGBUS mechanism here when KVM is involved,
> > keeping in mind that we need to be able to inject an MCE into the
> > guest for this to be useful.
> > 
> > 1. vCPU gets an EPT violation --> KVM attempts GUP.
> > 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
> > 3. KVM finds that GUP failed and returns -EFAULT.
> > 
> > This is different than if GUP found poison, in which case KVM will
> > actually queue up a SIGBUS *containing the address of the fault*, and
> > userspace can use it to inject an appropriate MCE into the guest. With
> > UFFDIO_SIGBUS, we are missing the address!
> > 
> > I see three options:
> > 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
> > this is pointless.
> > 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
> > UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGBUS
> > instead of VM_FAULT_RETRY. We will keep getting userfaults on repeated
> > accesses, just like how we get repeated signals for real poison.
> > 3. Use this in conjunction with the additional KVM EFAULT info that
> > Anish proposed (the first part of [1]).
> > 
> > I think option 3 is fine. :)
> 
> Or... option 4) just to use either MADV_HWPOISON or hwpoison-inject? :)

I just remember Axel mentioned this in the commit message, and just in case
this is why option 4) was ruled out:

        They expect that once poisoned, pages can never become
        "un-poisoned". So, when we live migrate the VM, we need to preserve
        the poisoned status of these pages.

Just to supplement on this point: we do have unpoison (echoing to
"debug/hwpoison/hwpoison_unpoison"), or am I wrong?

> 
> Besides what James mentioned on "missing addr", I didn't quickly see what's
> the major difference comparing to the old hwpoison injection methods even
> without the addr requirement. If we want the addr for MCE then it's more of
> a question to ask.
> 
> I also didn't quickly see why for whatever new way to inject a pte error we
> need to have it registered with uffd.  Could it be something like
> MADV_PGERR (even if MADV_HWPOISON won't suffice) so you can inject even
> without an userfault context (but still usable when uffd registered)?
> 
> And it'll be alawys nice to have a cover letter too (if there'll be a new
> version) explaining the bits.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu

