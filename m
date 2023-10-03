Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC2C7B7340
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbjJCVVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FBCC4
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696368062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+XSL7VlvFYRrMrr8EONFGdSlHsYIN60PHKmifU4UPQ=;
        b=ESLkzcfl5hpZnmmYq063IKoeUg9Wq+Y0jbkMoZon3zO+nIm1xW2aHz8Hl11DdWeuOxFSlu
        5r+fdfeznOG5ZnrCB5gYL5DETQ0zQTmnaTA+XOeRDqOzoa2Z98asjuFWd9q/IXroOuCGzM
        O1JRl11lj17/3Uv0T0hn+26+m02SpnI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-5lP8NwvxMVeiVw-bS5Y3yQ-1; Tue, 03 Oct 2023 17:21:00 -0400
X-MC-Unique: 5lP8NwvxMVeiVw-bS5Y3yQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-774292de453so31176485a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 14:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696368059; x=1696972859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+XSL7VlvFYRrMrr8EONFGdSlHsYIN60PHKmifU4UPQ=;
        b=PyuPfls1NO4niCPVfOfbO0uGUvBZ3MpGEEKhepXg5Eul/UzF9vJRqFTcDOjIDXHKol
         A/SUzZ3rW9/ZWkOa9kI8ZBX4Keu8S+Nm5k/OxsxAR6mnQ16oSKY++iG+pfueNrqT9jQZ
         gkyGJR7LOhcgIFKHvkCtC8zYeJ55tIEd7RgA8K7Q1psKrmhyP/z3nups8E4/icFgbqwn
         iSDWXHkbrH5qEt5tUWcb5t6SpSVDViQuLQLdgXbTZ0AUqY2PsiDUusU/crq7uH/ZTXTQ
         kZuHHcnb7M3W8kRsddVVxZD7MuswRai0Dl5YLtAldk8Byz7ASI4z1Jbnimu3W9uyBJG+
         LY2A==
X-Gm-Message-State: AOJu0YzzCAb2konqfkapsqrUAEFqRpCgx/6zlHn+ktFHujN6ynJVs5tl
        Jd+SzH9P2sV6rU0XzXeVZJHFVe7gazegodFb5AGL1Ni9ph3NsQZ7PsVqqvtNtXALpMNOZ8oykve
        s391e2rgb1Hr5xt5AbqvaxJLRkg==
X-Received: by 2002:a05:6214:d44:b0:668:def9:f762 with SMTP id 4-20020a0562140d4400b00668def9f762mr571446qvr.1.1696368059562;
        Tue, 03 Oct 2023 14:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0KMm0dgldH1KekAKurLb2lRbKa+t2ucH0FmqnvjvHEyA2nUXYNWWQVKF6NmeiS8vZXluBgw==
X-Received: by 2002:a05:6214:d44:b0:668:def9:f762 with SMTP id 4-20020a0562140d4400b00668def9f762mr571429qvr.1.1696368059264;
        Tue, 03 Oct 2023 14:20:59 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id u6-20020a0cb406000000b00641899958efsm799188qve.130.2023.10.03.14.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:20:58 -0700 (PDT)
Date:   Tue, 3 Oct 2023 17:20:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
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
Message-ID: <ZRyFnurIgVFVD8hd@x1n>
References: <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
 <ZRrf8NligMzwqx97@x1n>
 <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
 <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
 <ZRx31TKFDGRatoC8@x1n>
 <c837fc02-3dbd-ba88-dacb-cf150272a4c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c837fc02-3dbd-ba88-dacb-cf150272a4c4@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:08:07PM +0200, David Hildenbrand wrote:
> Sorry I have to ask: has this ever been discussed on the list? I don't see
> any pointers. If not, then probably the number of people that know about the
> history can be counted with my two hands and that shouldn't be the basis for
> making decisions.

For example:

https://lore.kernel.org/all/1425575884-2574-21-git-send-email-aarcange@redhat.com/

-- 
Peter Xu

