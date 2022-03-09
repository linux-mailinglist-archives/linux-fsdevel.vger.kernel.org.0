Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7A4D3BB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 22:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiCIVJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 16:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiCIVJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A692CD86
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 13:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646860126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MglxRBPyUbTeRJGcxsoUAZ8JhFWGp4eKx23qba031D0=;
        b=cny3deX1OaE+qYcb1ZRxME5EKNcgZPGkziSg2RTj46zo5RLRHu7+DuCnhGy2jQoXBjZvwV
        M0NZ4THlUgcCCcigfQIc39cr1+aeZcAnQufhjY1VgI5HDGy6PWUvH9MxhHPMSbSRKSD3d1
        Ab2/W5b7h3PFDP4oVuk/Fj98Mo2ObYw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-MPR9ba1hNUOdapdCvIUW9w-1; Wed, 09 Mar 2022 16:08:45 -0500
X-MC-Unique: MPR9ba1hNUOdapdCvIUW9w-1
Received: by mail-wm1-f71.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so1413917wmo.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 13:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MglxRBPyUbTeRJGcxsoUAZ8JhFWGp4eKx23qba031D0=;
        b=NEjHaQ1O2ZpCVWwKwMaSIBzx+WCQUI3t5vkMt7+Sqwn4kuMAfeGPqCm8+N0OBznrQu
         T4fT/ho2FDMcWZkKTTg7ofObns4suR37BAq8EXqGyZveuUky+3AjTlSQM9UpsN/z765f
         3We0hgnzZm8rSnOyLQF5J+0lC/Nihf0FgFvIOUWHduBRp+fVXrkY97+1Pz/8Wq6+Nt1u
         SMuDFckoy+2XOow1SmNsEW8Rjqk2hWR9G717PAXKb2LaThbBt9I1ccx2QQTMZknwMASb
         kb3JI2TjUq20oLmXPmv1Q7dRIbILeamdDZg5pkzfGQCRRgmuxrgVvkjzM33VQgGUbDwb
         0K2g==
X-Gm-Message-State: AOAM531Szzx0ew98OW5+zfex7Aqr6oS/rh6tUTaqEwF6MFrKi7MTasuR
        dN7NxMRFQDz0AIeJ5A2NBOsLoIK8xm36CcHPlVKUh+PS7pLLku6uIynbmuBpxzELPr/E6Lw8HBx
        SGoGOD2onLKTcTauMaahJzQ0XaohAWBBStM5A2H0a3A==
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id 13-20020a05600c22cd00b00389c99a45a4mr1031357wmg.38.1646860124209;
        Wed, 09 Mar 2022 13:08:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7hkfjg0Oh5K+Q1w3HaqTFk5Ml3O3uxREayIyKT3hnlocfDzkhydhZe8v9YaMY9wEWxhSnFZjIW2JyrmqXnrw=
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id
 13-20020a05600c22cd00b00389c99a45a4mr1031343wmg.38.1646860123956; Wed, 09 Mar
 2022 13:08:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
 <20220309184238.1583093-1-agruenba@redhat.com> <CAHk-=wgBOFg3brJbo-gcaPM+fxjzHwC4efhcM8tCKK3YUhYUug@mail.gmail.com>
In-Reply-To: <CAHk-=wgBOFg3brJbo-gcaPM+fxjzHwC4efhcM8tCKK3YUhYUug@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Mar 2022 22:08:32 +0100
Message-ID: <CAHc6FU5+AgDcoXE4Qfh_9hpn9d_it4aFyhoS=TKpqrBPe4GP+w@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 9, 2022 at 8:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 9, 2022 at 10:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > With a large enough buffer, a simple malloc() will return unmapped
> > pages, and reading into such a buffer will result in fault-in.  So page
> > faults during read() are actually pretty normal, and it's not the user's
> > fault.
>
> Agreed. But that wasn't the case here:
>
> > In my test case, the buffer was pre-initialized with memset() to avoid
> > those kinds of page faults, which meant that the page faults in
> > gfs2_file_read_iter() only started to happen when we were out of memory.
> > But that's not the common case.
>
> Exactly. I do not think this is a case that we should - or need to -
> optimize for.
>
> And doing too much pre-faulting is actually counter-productive.
>
> > * Get rid of max_size: it really makes no sense to second-guess what the
> >   caller needs.
>
> It's not about "what caller needs". It's literally about latency
> issues. If you can force a busy loop in kernel space by having one
> unmapped page and then do a 2GB read(), that's a *PROBLEM*.
>
> Now, we can try this thing, because I think we end up having other
> size limitations in the IO subsystem that means that the filesystem
> won't actually do that, but the moment I hear somebody talk about
> latencies, that max_size goes back.

Thanks, this puts fault_in_safe_writeable() in line with
fault_in_readable() and fault_in_writeable().

There currently are two users of
fault_in_safe_writeable()/fault_in_iov_iter_writeable(): gfs2 and
btrfs.
In gfs2, we cap the size at BIO_MAX_VECS pages (256). I don't see an
explicit cap in btrfs; adding Filipe.

Andreas

