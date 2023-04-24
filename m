Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11D66ECBF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjDXMYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 08:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXMYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:24:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09B42D48;
        Mon, 24 Apr 2023 05:24:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f917585b26so4009331f8f.0;
        Mon, 24 Apr 2023 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682339041; x=1684931041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9JPB0GklpBQlKrjPHy6vp/0sbrD8fwt4RwTkZmksDdw=;
        b=MpbmRdOjwrELouTgY8GUq9LxMaeMBPHKir7+SHb6NJ6MSfT2N3+1F98Y4iwkfNChLK
         fb5xTQ6o6rgiNps/OlljdNmMSxi7u7YUJ4EYCTeYWLj29F5dI+yplOV8xJ0Zn24yh0y0
         bIKFPaw88PQ0JqzyFXKnWw97TdDumbe5fvtIZaOfJsPSRVEUvl5YVSIvOF9ni9lORwo0
         WzVVjMjavCDTw1kqO8CP54ES94/3cyOFflusjOnXik9zQpvEwU5nY722rQK4/6J5jmQj
         HdYRYXrqSvSG0o9K4m2BssbiW3Q5mHWLgSO8RRHWU+nbcDCiD1EEPybU98c7ZEXAIqiL
         DaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682339041; x=1684931041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JPB0GklpBQlKrjPHy6vp/0sbrD8fwt4RwTkZmksDdw=;
        b=UTmUvWUMs7ykkHHhJaeAm7vV9dhqJmbfeJYlgwqDmikOQobWVaUqnmRWVLs6v+BAAr
         vB6jxYYDFwnQ+DdxWRKHAmOdavlAhBr3YlmNCdBgPs/7y0gZyQTr8deelIOUj5cwUwJs
         eQt0VEVKd59SwdbYv6i1yJ3tGz+0QIDeny/Tn2sqxMuhBCR47TY4Diig8EWXlV0LNh7R
         ysDh1gpBotkpmf/6eB5DJEXP/7Cw1HRr5RMKRn23T1WDH4qZCT4Wx4G/oISoCadFfvpw
         7LeyIiqwGNfVCSUYIPvd6dPLUQ41YzAYQxH4iRUsAH07Wsstf5HsxRWNdBVXNu+lzWrX
         WgMA==
X-Gm-Message-State: AAQBX9d+1ci5lOl6oGpL7Vx9eh/zuOnzIQ4imgtJ1yEese/wZCmJkbk2
        T/oDa+Bv4GkSzp0qmH9e1Dk=
X-Google-Smtp-Source: AKy350YYt5GFR3Zroi/O1GdhfbNtv34k83vpHgqOeHlMCioTCatt1FyZN68v9PGyurIvxLluScsn/g==
X-Received: by 2002:a05:6000:12c1:b0:2db:bca:ac7d with SMTP id l1-20020a05600012c100b002db0bcaac7dmr9146698wrx.67.1682339041014;
        Mon, 24 Apr 2023 05:24:01 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id b5-20020a056000054500b002e5ff05765esm10752214wrf.73.2023.04.24.05.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 05:24:00 -0700 (PDT)
Date:   Mon, 24 Apr 2023 13:23:59 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 0/3] permit write-sealed memfd read-only shared
 mappings
Message-ID: <990a5367-c1ba-4451-856e-be81792e0dba@lucifer.local>
References: <cover.1680560277.git.lstoakes@gmail.com>
 <20230421090126.tmem27kfqamkdaxo@quack3>
 <b18577f5-86fe-4093-9058-07ba899f7dd6@lucifer.local>
 <20230424121936.lwgqty6hifs7eecp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424121936.lwgqty6hifs7eecp@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 02:19:36PM +0200, Jan Kara wrote:
> On Fri 21-04-23 22:23:12, Lorenzo Stoakes wrote:
> > On Fri, Apr 21, 2023 at 11:01:26AM +0200, Jan Kara wrote:
> > > Hi!
> > >
> > > On Mon 03-04-23 23:28:29, Lorenzo Stoakes wrote:
> > > > This patch series is in two parts:-
> > > >
> > > > 1. Currently there are a number of places in the kernel where we assume
> > > >    VM_SHARED implies that a mapping is writable. Let's be slightly less
> > > >    strict and relax this restriction in the case that VM_MAYWRITE is not
> > > >    set.
> > > >
> > > >    This should have no noticeable impact as the lack of VM_MAYWRITE implies
> > > >    that the mapping can not be made writable via mprotect() or any other
> > > >    means.
> > > >
> > > > 2. Align the behaviour of F_SEAL_WRITE and F_SEAL_FUTURE_WRITE on mmap().
> > > >    The latter already clears the VM_MAYWRITE flag for a sealed read-only
> > > >    mapping, we simply extend this to F_SEAL_WRITE too.
> > > >
> > > >    For this to have effect, we must also invoke call_mmap() before
> > > >    mapping_map_writable().
> > > >
> > > > As this is quite a fundamental change on the assumptions around VM_SHARED
> > > > and since this causes a visible change to userland (in permitting read-only
> > > > shared mappings on F_SEAL_WRITE mappings), I am putting forward as an RFC
> > > > to see if there is anything terribly wrong with it.
> > >
> > > So what I miss in this series is what the motivation is. Is it that you need
> > > to map F_SEAL_WRITE read-only? Why?
> > >
> >
> > This originated from the discussion in [1], which refers to the bug
> > reported in [2]. Essentially the user is write-sealing a memfd then trying
> > to mmap it read-only, but receives an -EPERM error.
> >
> > F_SEAL_FUTURE_WRITE _does_ explicitly permit this but F_SEAL_WRITE does not.
> >
> > The fcntl() man page states:
> >
> >     Furthermore, trying to create new shared, writable memory-mappings via
> >     mmap(2) will also fail with EPERM.
> >
> > So the kernel does not behave as the documentation states.
> >
> > I took the user-supplied repro and slightly modified it, enclosed
> > below. After this patch series, this code works correctly.
> >
> > I think there's definitely a case for the VM_MAYWRITE part of this patch
> > series even if the memfd bits are not considered useful, as we do seem to
> > make the implicit assumption that MAP_SHARED == writable even if
> > !VM_MAYWRITE which seems odd.
>
> Thanks for the explanation! Could you please include this information in
> the cover letter (perhaps in a form of a short note and reference to the
> mailing list) for future reference? Thanks!
>
> 								Honza
>

Sure, apologies for not being clear about that :)

I may respin this as a non-RFC (with updated description of course) as its
received very little attention as an RFC and I don't think it's so
insane/huge a concept as to warrant remaining one.

> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
