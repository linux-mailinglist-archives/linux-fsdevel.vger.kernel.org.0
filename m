Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB356FFC7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 00:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjEKWAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 18:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbjEKWAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 18:00:48 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F51701
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 15:00:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f38824a025so913931cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683842446; x=1686434446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEnuBFRoeoCUMFkZqOok9vk168rBBPu1XkXprJKNlqs=;
        b=EuTOAJASK3+B5vjp1G5fp4oCLaqBqstFV5xmxZMlYUxLY4Y9iaOjEZaaBdlcUMJoyK
         Rxd9ZhJUgNmNCOYrDQmB/rYzrmzr599ZoTdKdi4lM/nJcZiqeJCLmtMVItEvr8pzShjd
         cla+UzOFyahonvzdiuuSkFkC8Vkz05yeAaUxWrG+89kfFDk4aSrMQsUZ1QrLVOcVN9Hn
         RzCX8FwrGWSCvxWJw5Mu9LPk1XnDDAWiuuUFh5udKk4tTKqIeN+c+H4k0vSrR42I7UIF
         g0M3HzoMVLzfJtHxpGrMdDQIESwD2veYvVSOu3Ex2qW5Kg+wC8Pfpyy8yjTV67vSS5Ro
         XMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842446; x=1686434446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEnuBFRoeoCUMFkZqOok9vk168rBBPu1XkXprJKNlqs=;
        b=N/Gb5Ks55uZttqhnpZlGnFU4FHtrLzbEh/q3gAfOItQjYPckgs3BeQ0pdXMU8fGmR5
         f9VJEAWOSkBsSLkICiciuUfzKQTRbGiDj+NsfKiLq78I6rYxIumM+lw+cEv23yzpyaqD
         9zoRKHC25upbOZvJ6msEq3GR+MiTrhYMS5v6eLbal3A6utD8cIKE/nK2gyfTSs0lVbiC
         1yHYf4/CT05FsIYa+WytCl2TNh2/R8QVFbf3f5mzuisIhmx44y7AE8cwG7akPTjL7sun
         qXkTqjaTjKF7Bv5S2qWOKKL4nBh91oG7XP4Zkcwsd52j35uJTA8EC+ODOvjZZE/xVQay
         NPog==
X-Gm-Message-State: AC+VfDyn/i1gmiRnTwwd17Er7dR/nsOVqhudHWZakOyROSiNbr59JDGw
        ktXBUTwSn517wTNUOhYHwwCGV6FLyt3DnynYgL/KKg==
X-Google-Smtp-Source: ACHHUZ76UIMQRNxt62E19OmIL/umDvVX387jn2iloTd079HNSRy91xM1m1n4PpSK9EnBriiaEHnVjYd84JhsYIBiHUs=
X-Received: by 2002:a05:622a:11cd:b0:3ef:19fe:230d with SMTP id
 n13-20020a05622a11cd00b003ef19fe230dmr5923qtk.17.1683842445770; Thu, 11 May
 2023 15:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
In-Reply-To: <20230511182426.1898675-1-axelrasmussen@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 11 May 2023 15:00:09 -0700
Message-ID: <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11, 2023 at 11:24=E2=80=AFAM Axel Rasmussen
<axelrasmussen@google.com> wrote:
>
> So the basic way to use this new feature is:
>
> - On the new host, the guest's memory is registered with userfaultfd, in
>   either MISSING or MINOR mode (doesn't really matter for this purpose).
> - On any first access, we get a userfaultfd event. At this point we can
>   communicate with the old host to find out if the page was poisoned.
> - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
>   so any future accesses will SIGBUS. Because the pte is now "present",
>   future accesses won't generate more userfaultfd events, they'll just
>   SIGBUS directly.

I want to clarify the SIGBUS mechanism here when KVM is involved,
keeping in mind that we need to be able to inject an MCE into the
guest for this to be useful.

1. vCPU gets an EPT violation --> KVM attempts GUP.
2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
3. KVM finds that GUP failed and returns -EFAULT.

This is different than if GUP found poison, in which case KVM will
actually queue up a SIGBUS *containing the address of the fault*, and
userspace can use it to inject an appropriate MCE into the guest. With
UFFDIO_SIGBUS, we are missing the address!

I see three options:
1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
this is pointless.
2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGBUS
instead of VM_FAULT_RETRY. We will keep getting userfaults on repeated
accesses, just like how we get repeated signals for real poison.
3. Use this in conjunction with the additional KVM EFAULT info that
Anish proposed (the first part of [1]).

I think option 3 is fine. :)

[1]: https://lore.kernel.org/kvm/20230412213510.1220557-1-amoorthy@google.c=
om/


- James
