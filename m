Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB965C7C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 20:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjACTyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjACTyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:54:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250A5140B5
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jan 2023 11:54:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d9so2222796wrp.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jan 2023 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxwQtp+mIoEoCmpBAjD17aoq2HWLP3++GrG0ABFdOrA=;
        b=mgjTiM6+jaHOLzUHkjqOmI7bSAIp8wsc4DSTorCIbyK/KlQvYnhe18WKVpdK58hVba
         UxF0QjpgNBXwfJyGRONiHdYbEShv4w4tCEOdaB+Ye2Hx1ikTLQ4c2rHrhmQf36y8ZS5j
         Xt+rQdbi+HoaCRv3bnfkpqrAY86zd1uA/9c2/2n03NqbLi36JqgIRyCnaMq5KR5ZvA0N
         af2g4rjTIhxwdRjb6yU8seukGzQw9hKx8dv2JQ+owyd9TB+hOzS50OkuliezMghPeaCz
         tLWXi5Fr07W5154WdyFx49ALFAJKbrhI1TFCUsRChA9lq6MlMfHKBqYBtxqiJf35gXk+
         hoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxwQtp+mIoEoCmpBAjD17aoq2HWLP3++GrG0ABFdOrA=;
        b=a766xSdIqTlxKzhxCeE2mu5RNr9EsZx/OuBBJdMZVojMXezvhAvLFp+SBssqdURJ5u
         V0DYA2CfPDANNNCdafAuXrGV/sGrU1fTXY6Z6/pepXLkN3hkuBKxGrLOmEX3+Z3ZaGA+
         TxSarz2u880UAh/lKVChdnPY5ZSeRJPdZZF2/tZCdWExLo8TrU9hvMlF0LjqVBXJGg0p
         R2qa5ElvXHjdeobL2OE0hw/Yu2mHqhbgk5B/83H4IB+jI5ScqWkcV2CZ3Va2OSKF5P48
         0lQxsONbxS0v+0ffRiUNkv0FMcJqtg2ysf46VlXgK3TBpK1JPFsFxqJWHwvLj35Tb6FV
         1EXQ==
X-Gm-Message-State: AFqh2krKgoAbEJ1rkv3zDGmWZJsPj/DBPMgSIL/gqjlqTOw0Q9PhOiRy
        Qkhpjo/ysqlQqXPA2oDT98FNM5qDlQXy3mAeNFvd3A==
X-Google-Smtp-Source: AMrXdXvpwM2fYYhnaH4hpGj+cUKmpT4BxVdoiQS9zeBc1ccet5YOeOsvjGtxJep4pMZXaFrmg3ojYV23nCyVkP5eFFA=
X-Received: by 2002:a5d:6381:0:b0:285:a49e:b114 with SMTP id
 p1-20020a5d6381000000b00285a49eb114mr868121wru.246.1672775650517; Tue, 03 Jan
 2023 11:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20221228194249.170354-1-surenb@google.com> <6ddb468a-3771-92a1-deb1-b07a954293a3@redhat.com>
In-Reply-To: <6ddb468a-3771-92a1-deb1-b07a954293a3@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Jan 2023 11:53:57 -0800
Message-ID: <CAJuCfpGUpPPoKjAAmV7UK2H2o2NqsSa+-_M6JwesCfc+VRY2vw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 2, 2023 at 4:00 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 28.12.22 20:42, Suren Baghdasaryan wrote:
> > free_anon_vma_name() is missing a check for anonymous shmem VMA which
> > leads to a memory leak due to refcount not being dropped. Fix this by
> > adding the missing check.
> >
> > Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
> > Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   include/linux/mm_inline.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index e8ed225d8f7c..d650ca2c5d29 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -413,7 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
> >        * Not using anon_vma_name because it generates a warning if mmap_lock
> >        * is not held, which might be the case here.
> >        */
> > -     if (!vma->vm_file)
> > +     if (!vma->vm_file || vma_is_anon_shmem(vma))
> >               anon_vma_name_put(vma->anon_name);
>
> Wouldn't it be me more consistent to check for "vma->anon_name"?
>
> That's what dup_anon_vma_name() checks. And it's safe now because
> anon_name is no longer overloaded in vm_area_struct.

Thanks for the suggestion, David. Yes, with the recent change that
does not overload anon_name, checking for "vma->anon_name" would be
simpler. I think we can also drop anon_vma_name() function now
(https://elixir.bootlin.com/linux/v6.2-rc2/source/mm/madvise.c#L94)
since vma->anon_name does not depend on vma->vm_file anymore, remove
the last part of this comment:
https://elixir.bootlin.com/linux/v6.2-rc2/source/include/linux/mm_types.h#L584
and use vma->anon_name directly going forward. If all that sounds
good, I'll post a separate patch implementing all these changes.
So, for this patch I would suggest keeping it as is because
functionally it is correct and will change this check along with other
corrections I mentioned above in a separate patch. Does that sound
good?


-     if (!vma->vm_file)
+     if (!vma->vm_file || vma_is_anon_shmem(vma))

>
> --
> Thanks,
>
> David / dhildenb
>
