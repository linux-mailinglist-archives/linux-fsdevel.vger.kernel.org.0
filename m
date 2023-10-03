Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FBF7B7270
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 22:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjJCUWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJCUWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA6FAB
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696364507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lGz/zPDmfUe9p/qsYHyjDH/ju5fxgNmRfXXQH4ZGRfQ=;
        b=ItKLWPf5cH6lkXGr/iD2JOZHb9tWQIk0CYO5jCJJ3XMxqV0JJIdHvjK1MJBkzl69GSB0jB
        HvVQtd7FfrosCfBCeIasS9NkeyB8vs2cYUtcC68VR9pD3rUjWPpCJ0eVNiGuA2xlJ/YoDb
        qofBxCcjE50fnFW0GSrm45JDKL8lEj8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-DI7Zo4UHN0efmZ6u8IeSRA-1; Tue, 03 Oct 2023 16:21:46 -0400
X-MC-Unique: DI7Zo4UHN0efmZ6u8IeSRA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77423bb5579so36596985a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 13:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696364505; x=1696969305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGz/zPDmfUe9p/qsYHyjDH/ju5fxgNmRfXXQH4ZGRfQ=;
        b=xKhRa10F1UjoQOY1rJIFl639L/Ewi+yr0LOMZCIQllt0br4of8WnlHkEi2/y+MvG26
         H0YG4SsvKC/JFVjXPDqErBBR1OPemgf0ISXJWpMZCCaAVJM+b/ulGRhAm9GnpJw6NE57
         6/Xlabr+ihxCmG+TQe8g8o66o91Y5Rjd/5Am3nV0iVY/zY1rAOVY4X66R1T4Pe0tvUHv
         NX53yyzFutNbdCTM1kfhUEvEd3WbLS0P6NteYDZb4rKzVZ1HqVXsF+dGRCv8WeG0N/Ho
         Fal1r3j2KytePB3qb6NL888JkVStG/lH4NoDr0dc96AZs0RN3Avw55CYc1Wjf/JKkaP9
         Ph0Q==
X-Gm-Message-State: AOJu0Yw4ckoUs3Zp5TbjsItDVxAKKFQccTR33GbElPPvbgbaJCbDdJUv
        qUbIDl7dKuEvHbL6IWDt+pRndHode3j0VDn0PV46RwNh3dqqenbaTNaz22GQzu3WGVyFn48fF2S
        73u3rSZFH/pWV8OxSM/2+jOEExw==
X-Received: by 2002:a05:620a:1914:b0:773:b634:b05a with SMTP id bj20-20020a05620a191400b00773b634b05amr664272qkb.2.1696364505540;
        Tue, 03 Oct 2023 13:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1us9YsAy4zroBwMwR+GwfiHfM87maalEVWo8Ggo0EdogasY6gSCuj6gjLUHCv5mmQk23vSg==
X-Received: by 2002:a05:620a:1914:b0:773:b634:b05a with SMTP id bj20-20020a05620a191400b00773b634b05amr664260qkb.2.1696364505180;
        Tue, 03 Oct 2023 13:21:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id w13-20020ae9e50d000000b0077407e3d68asm729062qkf.111.2023.10.03.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 13:21:44 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:21:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRx31TKFDGRatoC8@x1n>
References: <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com>
 <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
 <ZRrf8NligMzwqx97@x1n>
 <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
 <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:04:44PM -0700, Suren Baghdasaryan wrote:
> Ok, I think it makes sense to implement the strict remap logic but in
> a way that we can easily add copy fallback if that's needed in the
> future. So, I'll change UFFDIO_REMAP to UFFDIO_MOVE and will return
> some unique error, like EBUSY when the page is not PAE. If we need to
> add a copy fallback in the future, we will add a
> UFFDIO_MOVE_MODE_ALLOW_COPY flag and will implement the copy
> mechanism. Does that sound good?

For the clear failing approach, sounds all good here.

For the name, no strong opinion, but is there any strong one over MOVE?
MOVE is a fine name, however considering UFFDIO_REMAP's long history.. I
tend to prefer keeping it called as REMAP - it still sounds sane, and
anyone who knows REMAP will know this is exactly that.

Thanks,

-- 
Peter Xu

