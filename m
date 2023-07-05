Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFF748B19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjGER5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjGER5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:57:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F75F7
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 10:57:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9939fbb7191so192849966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688579820; x=1691171820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1wTgUxJXx3tp0kUBGY4xdI7MU5ro+vhiugocM4n1ss=;
        b=qzpbmri+UAarope3gQY8JCaH976L2B+n68ws9721gs3jJNB+eNzjn0eF9ZfrEJNMmv
         8+WaC+vezGnY6DZqbBVhreJI15TtRVagcdiZqkWT+ln6ShhA3zqC3zFFt+N1Y2UASrAy
         mkn7DAU2ZiscOT4R9jHsDoHNIs2sqmtiptgyZbEg07lqi7M4nbMzRv6PkOSGkx1vZ14W
         5BF6Aeyx2PjsYG5xUCvhhiSQnc/umzUHMm2GUPnWLyhGNdflfghzdmGXv6yquBA9uf59
         rNgaUPJjDb4BldD4ttWdUyQVVED83+ru/yq4dlnsF2LWTFXkkpg+UcbCQisk+j4kdPQZ
         wXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688579820; x=1691171820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1wTgUxJXx3tp0kUBGY4xdI7MU5ro+vhiugocM4n1ss=;
        b=JpJjfIQNNNVCLJaREO/5hyVfE8fJ/u69rlUy6U5PGvUkvKNRA9OeDFFs7DbBZm05lt
         +MSllB4+v5dgzZ9+JchqBM873fW1t3FdhGi6d8bXk6YiYdQ+TlvqmaacHaC7GbjIc8Cg
         3U4W71Usey3SkSx6cHwsglYSNO1NwxAKb+CHqTxfhe13WgJiR6lBMlMYe8UZvuWbYce2
         tT5NXljmzxrNJvFgbztkWXx2owgfE9lYm3RpdrzKUISKNseKKJAzm+T3nW7ZBkpajBiQ
         N0s16qdhH+jrH7c+xl9/GxLoWh3lOVL2pdbra017wgbEN7LOqzmn4obayIAIHWogDNkP
         wpYg==
X-Gm-Message-State: ABy/qLbd4eEhszAG1KF/uKH2Asq4NwZdn9cMI+FkmVvSU8BxTEbAhh/7
        Irl8ZdxrUUHFqoDUqY8Tgrs5yfFGgz8SkMNE+u8ppg==
X-Google-Smtp-Source: APBJJlGhNDfk+A5cRCar/5QRGBPxgKX45i6W5UnrxH4GqLaWcyJzVDKBTBgap4g7/sAKGatltVc8+OINzu7yY35sZ1o=
X-Received: by 2002:a17:906:648e:b0:992:6d73:5696 with SMTP id
 e14-20020a170906648e00b009926d735696mr2934926ejm.5.1688579819676; Wed, 05 Jul
 2023 10:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <ZKSDLogLASaZgKCP@x1n> <CADrL8HXp-P44VxTXdJMkzSgPC8r_b0T21_cuPCTNy6Ub2PFBKA@mail.gmail.com>
 <ZKWXGnSKcOdnaeJw@x1n> <CADrL8HWO8g2-YdUtyLM6e+f1VJq6YV-b1_rj-beEh2C84kAgEw@mail.gmail.com>
 <ZKWcgD1hFFUxeQHg@x1n>
In-Reply-To: <ZKWcgD1hFFUxeQHg@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 5 Jul 2023 10:56:23 -0700
Message-ID: <CAJHvVcjNDazqnopjcqx2LLcmQf_4QUeGBSvSJxwGh40e78uhCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm: userfaultfd: add new UFFDIO_POISON ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 5, 2023 at 9:38=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jul 05, 2023 at 09:27:15AM -0700, James Houghton wrote:
> > On Wed, Jul 5, 2023 at 9:15=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Wed, Jul 05, 2023 at 09:09:19AM -0700, James Houghton wrote:
> > > > > > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > > > > > index 4c932cb45e0b..8259fee32421 100644
> > > > > > --- a/include/linux/swapops.h
> > > > > > +++ b/include/linux/swapops.h
> > > > > > @@ -394,7 +394,8 @@ typedef unsigned long pte_marker;
> > > > > >
> > > > > >  #define  PTE_MARKER_UFFD_WP                  BIT(0)
> > > > > >  #define  PTE_MARKER_SWAPIN_ERROR             BIT(1)
> > > > > > -#define  PTE_MARKER_MASK                     (BIT(2) - 1)
> > > > > > +#define  PTE_MARKER_UFFD_POISON                      BIT(2)
> > > > >
> > > > > One more tab.
> > > > >
> > > > > Though I remembered the last time we discussed IIRC we plan to re=
name
> > > > > SWAPIN_ERROR and reuse it, could you explain why a new bit is sti=
ll needed?
> > > > >
> > > > > I think I commented this but I'll do it again: IIUC any existing =
host
> > > > > swapin errors for guest pages should be reported as MCE too, afai=
ct,
> > > > > happened in kvm context.
> > > >
> > > > I think swapin errors are treated differently than poison. Swapin
> > > > errors get VM_FAULT_SIGBUS, and poison gets VM_FAULT_HWPOISON, so
> > > > UFFDIO_POISON should also get VM_FAULT_HWPOISON (so that's what Axe=
l
> > > > has implemented). And I think that needs a separate PTE marker.
> > >
> > > My question was, should we also make SWAPIN_ERROR return VM_FAULT_HWP=
OISON
> > > always?
> > >
> > > Just to recap from what I already commented above - if a guest page g=
ot
> > > error in swapin due to block sector failures, it should be treated as
> > > VM_FAULT_HWPOISON too, IMHO.  IOW, I think current SWAPIN_ERROR is wr=
ong
> > > when in kvm context and we should fix it first.
> >
> > Oh! Yes, I agree, though I'm not familiar enough with the users of
> > SWAPIN_ERROR to know if we can actually make this change.

Sorry I missed this, I'll take another pass looking at existing
SWAPIN_ERROR uses, and see if this can be done.

Thanks for the thorough review Peter, I'll address this comment and
the others in a v3. :)

>
> Miaohe initially proposed this swapin error facility, let's see whether h=
e
> can comment; he's already in the cc list.
>
> AFAICT that's the right thing to do, and it shouldn't affect any existing
> user of swapin error if there is.
>
> Or say, VM_FAULT_HWPOISON should be the same as VM_FAULT_SIGBUS when not =
in
> kvm context, so shouldn't change a thing in !kvm, while changing that
> should fix kvm from crashing a guest where we shouldn't need to.
>
> --
> Peter Xu
>
