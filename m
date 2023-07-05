Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9574895A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjGEQjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 12:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGEQjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F63F1700
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688575108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtdlmeuUvVV5AoG6i2ieA0Vy+QvgXsh2syFJ86sdKyc=;
        b=Y0e6AiZ/c+MsCLGcSjlJStGzpWQyzBAHbpTcihLAussMioXbDB7KsFi5ATHvGtRsr0sF6I
        VP4TSDDgxMY9JHHK4UZZhGsmq+JLp5eM/3wSYqH4WUICsJarPQhN6ZFcdK5TEag5hRNVQD
        mFfOM0flpB5AlJBJiq7ijK9tvdNZFsw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-PVD_RvZqN-KdhNvNqlfHdA-1; Wed, 05 Jul 2023 12:38:27 -0400
X-MC-Unique: PVD_RvZqN-KdhNvNqlfHdA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-403838e9f4dso707881cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 09:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688575107; x=1691167107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtdlmeuUvVV5AoG6i2ieA0Vy+QvgXsh2syFJ86sdKyc=;
        b=HJTE8rjW7t83D/OfSFIPcwYCXJpTZBXxSQcJGfLG0vGoyZ6HKUO1TzTR+opk/jyw7t
         kKGYnO8krhVIXQ65AlBrzKEpyNgrdUdHIaVT3FJxyM6TM3w1gVakV0GI12yhQH3fAtXy
         dFUKhLI2UzzAA/nT7fmTdPBT8RSpNvWyCxR/TWGZAfj1Vjr4Q98fS68ZrfdRU4OL93bs
         nVi0s9HAla6d/q8rAyjAgZD0bOM8LHN7GkIxtlDY79lk44vs+ByGxzH30PAmj1doJwOg
         XzC957jDy0nkat2fHQLWsMu1hvWnKribZqGEuKexkJ0HzCP0AuFCFfwgixODkrLvWNXm
         XAcQ==
X-Gm-Message-State: AC+VfDyPT+E8TRdNVe4cIzqoeFc/Sn86j3mV1pp3K7KQZGf477dur3cF
        GvMW9yhzB4wlngl3sLaapb7E0Dj7ul3OPAYu2m7XjSqWcoqc0aCJPwhPxBg2ynFuUPi8HQmW9m1
        XByTXEvaQlDKVD/XwS4OKOec6fw==
X-Received: by 2002:a05:622a:1649:b0:3fd:e953:74ee with SMTP id y9-20020a05622a164900b003fde95374eemr23330965qtj.2.1688575106970;
        Wed, 05 Jul 2023 09:38:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ihy+ZtuZ+x6vBvXVoM3TZ2NbZyY/aD/dUpJ9fV+DBZTHo+GqAbnJh/h9W5pIXBTG6F2oj7A==
X-Received: by 2002:a05:622a:1649:b0:3fd:e953:74ee with SMTP id y9-20020a05622a164900b003fde95374eemr23330935qtj.2.1688575106709;
        Wed, 05 Jul 2023 09:38:26 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ew5-20020a05622a514500b00400a760cbfdsm12611511qtb.17.2023.07.05.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:38:26 -0700 (PDT)
Date:   Wed, 5 Jul 2023 12:38:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm: userfaultfd: add new UFFDIO_POISON ioctl
Message-ID: <ZKWcgD1hFFUxeQHg@x1n>
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <ZKSDLogLASaZgKCP@x1n>
 <CADrL8HXp-P44VxTXdJMkzSgPC8r_b0T21_cuPCTNy6Ub2PFBKA@mail.gmail.com>
 <ZKWXGnSKcOdnaeJw@x1n>
 <CADrL8HWO8g2-YdUtyLM6e+f1VJq6YV-b1_rj-beEh2C84kAgEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HWO8g2-YdUtyLM6e+f1VJq6YV-b1_rj-beEh2C84kAgEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 05, 2023 at 09:27:15AM -0700, James Houghton wrote:
> On Wed, Jul 5, 2023 at 9:15 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Jul 05, 2023 at 09:09:19AM -0700, James Houghton wrote:
> > > > > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > > > > index 4c932cb45e0b..8259fee32421 100644
> > > > > --- a/include/linux/swapops.h
> > > > > +++ b/include/linux/swapops.h
> > > > > @@ -394,7 +394,8 @@ typedef unsigned long pte_marker;
> > > > >
> > > > >  #define  PTE_MARKER_UFFD_WP                  BIT(0)
> > > > >  #define  PTE_MARKER_SWAPIN_ERROR             BIT(1)
> > > > > -#define  PTE_MARKER_MASK                     (BIT(2) - 1)
> > > > > +#define  PTE_MARKER_UFFD_POISON                      BIT(2)
> > > >
> > > > One more tab.
> > > >
> > > > Though I remembered the last time we discussed IIRC we plan to rename
> > > > SWAPIN_ERROR and reuse it, could you explain why a new bit is still needed?
> > > >
> > > > I think I commented this but I'll do it again: IIUC any existing host
> > > > swapin errors for guest pages should be reported as MCE too, afaict,
> > > > happened in kvm context.
> > >
> > > I think swapin errors are treated differently than poison. Swapin
> > > errors get VM_FAULT_SIGBUS, and poison gets VM_FAULT_HWPOISON, so
> > > UFFDIO_POISON should also get VM_FAULT_HWPOISON (so that's what Axel
> > > has implemented). And I think that needs a separate PTE marker.
> >
> > My question was, should we also make SWAPIN_ERROR return VM_FAULT_HWPOISON
> > always?
> >
> > Just to recap from what I already commented above - if a guest page got
> > error in swapin due to block sector failures, it should be treated as
> > VM_FAULT_HWPOISON too, IMHO.  IOW, I think current SWAPIN_ERROR is wrong
> > when in kvm context and we should fix it first.
> 
> Oh! Yes, I agree, though I'm not familiar enough with the users of
> SWAPIN_ERROR to know if we can actually make this change.

Miaohe initially proposed this swapin error facility, let's see whether he
can comment; he's already in the cc list.

AFAICT that's the right thing to do, and it shouldn't affect any existing
user of swapin error if there is.

Or say, VM_FAULT_HWPOISON should be the same as VM_FAULT_SIGBUS when not in
kvm context, so shouldn't change a thing in !kvm, while changing that
should fix kvm from crashing a guest where we shouldn't need to.

-- 
Peter Xu

