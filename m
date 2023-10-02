Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132FE7B566C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbjJBPWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 11:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbjJBPWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08FDB3
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696260107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QlAybfgmV/uY/HzoMoKn7tEAOtApMgJqX5rJGiOaxmY=;
        b=dD6VpKjIT5hGJD8885XzJNUy/J6HcXjgafHyZg0Ck2BrUTSR13Cc935PNtA875pGEi02tc
        a8VX1w7N+e15Dr8nFPewSiXINZZnxGlgQNSUprxIy2iPM7gbK5AGcXFR6hK8oxo3mPSybd
        CoD5RXfgspV+/iY43ETWykzO1d9xric=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-AxzSls8_MvikNFZCjFzNgQ-1; Mon, 02 Oct 2023 11:21:24 -0400
X-MC-Unique: AxzSls8_MvikNFZCjFzNgQ-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7a82b0a9d2cso1341828241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 08:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260084; x=1696864884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlAybfgmV/uY/HzoMoKn7tEAOtApMgJqX5rJGiOaxmY=;
        b=o0yGer5qc/fQy98aKv15wbM8KHJLQkLDHbDjIiEyZlJBciuygLbE8DLQyIBkaXYIsz
         V5tu4S7fZtBuO3dHj8B7FKg80j3HO8oMPP9RL4oNxjjwWrLW74R3rfdiTnjuBKMIxdLj
         067uEphU5Ok0yWSGBjp2Z8OdJRBt3pvlsqB5ynVNNgu77hK50eUl+djG5kcbzoW7ZIcg
         r3UxoOU3VdZKCtpp0C5maMcnelDIJc8uGzGutuHdWDJ9LiwA7dIHSkyvwYr5LdH1yIiq
         KuoJRRG999gWmypg4w0/zAFiMGQ6oQBS53Z115isHO1qMJEbfLkoMbDTwR0kt8gcoXY3
         npiw==
X-Gm-Message-State: AOJu0YxYiHOm/JPmirapYtfIsZBjOx7c02mF+HpJclAZn/sDBayH+Meb
        RA1T4cmiB3xuX/ZX9YcZpgAXb3/D7DYbXMoWAPWMv5jQVRRi5GULpeaWD+uIOtvF8bxQ8C4HPnt
        BTHfGiJLltpY3baXImHtRZ/EICQ==
X-Received: by 2002:a05:6102:358e:b0:452:67eb:43cc with SMTP id h14-20020a056102358e00b0045267eb43ccmr5101345vsu.2.1696260084345;
        Mon, 02 Oct 2023 08:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn8glcUatTtqxL6ORAuKISgs+lhCwObGpl8dZ1+0G3Dbu/BgHizje+srQxQLZctE7w0kbPpw==
X-Received: by 2002:a05:6102:358e:b0:452:67eb:43cc with SMTP id h14-20020a056102358e00b0045267eb43ccmr5101323vsu.2.1696260084067;
        Mon, 02 Oct 2023 08:21:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id f5-20020a0cf3c5000000b0065cfec43097sm4215956qvm.39.2023.10.02.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:21:23 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:21:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRrf8NligMzwqx97@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
 <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com>
 <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com>
 <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
> In case we cannot simply remap the page, the fallback sequence (from the
> cover letter) would be triggered.
> 
> 1) UFFDIO_COPY
> 2) MADV_DONTNEED
> 
> So we would just handle the operation internally without a fallback.

Note that I think there will be a slight difference on whole remap
atomicity, on what happens if the page is modified after UFFDIO_COPY but
before DONTNEED.

UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, threads
can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lost
during movement, and it will generate a missing event after moved, with
latest data showing up on dest.

I'm not sure that means such a fallback is a problem, Suren may know
better with the use case.

Thanks,

-- 
Peter Xu

