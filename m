Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1936CAD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbhD0SEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 14:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238333AbhD0SEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619546600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uxq6LnPiTdql8TXSE99+fcYiPX1sdJEySNHvDoQFyd4=;
        b=SKhB7exCvRRzgTjbfIbZovSy+ZRh3bNfNB9xomIZaflGLM7Zx4oUBV1+hmLD72PDTSwVe+
        cX1JHmDX7XJgxcwEzgEjP7NY3elVF6JWmrAVWdkFzz5GFX3G6C8qMn4HSXn5cg0R+I8SGE
        YHfxGWnWtN/pFuFCMXkbst2Bf4+H/KQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-znLQDhfuMMi3s6sTo6XNqw-1; Tue, 27 Apr 2021 14:03:18 -0400
X-MC-Unique: znLQDhfuMMi3s6sTo6XNqw-1
Received: by mail-qk1-f197.google.com with SMTP id v7-20020a05620a0a87b02902e02f31812fso23531963qkg.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 11:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxq6LnPiTdql8TXSE99+fcYiPX1sdJEySNHvDoQFyd4=;
        b=TJwmIq9xjRKRTIzovLwXor8fT/u5tIdw//6vYa4SmEFA53ooPTqgeRU1dDCIaAYgH1
         WzGGLQSgn6B/1uHZKrocT4k06UZtl8JnQFxmp+R6bAT7SYyg1TvrPAEKPXI7mv879Tj9
         5VfsiZhSXeEQL95trhgQhOTyg0ETOJ0ePtSVOtv10dJ2supgGmT6ew56Xa/AZMgMQqfM
         SO8h5+srp70KBSl2484RDQXFQZCEQpf69+rNlp6QkaNKR+iPIKSXCY2C6CHMGXpqouRc
         3piF5Dl5F9wRjjZx8EQkwzZKXRSzVRRKZJkklTf/wE5UGrJ2v/iXl/tQO2ht3rj3QEsN
         c4Ow==
X-Gm-Message-State: AOAM530HXRpTcHmNR1POVBtFnyhmggmVBAn++9MAdd0K8h4Hp+YAhMa7
        u7jx7HbrX1rADBSugnE+C6pz/1h9GIWr71nBSF1SaSWAf0JrLWRnkKyiji9hMa5BQqOFciE+rEN
        eOh9kzOg/612nrSb/clM7VdHXtQ==
X-Received: by 2002:a05:620a:f:: with SMTP id j15mr24057462qki.307.1619546597724;
        Tue, 27 Apr 2021 11:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztCC+XrZldYdKF/5ItbBDWFXLnijjmmS8bfVQi6TI1Vej0NaMb+NFRcFob5jVc3TcuhD2/Iw==
X-Received: by 2002:a05:620a:f:: with SMTP id j15mr24057430qki.307.1619546597418;
        Tue, 27 Apr 2021 11:03:17 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id q26sm1313209qkn.81.2021.04.27.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 11:03:16 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:03:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
Message-ID: <20210427180314.GD6820@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
 <20210427155414.GB6820@xz-x1>
 <CAJHvVciNrE_F0B0nu=Mib6LhcFhL8+qgO-yiKNsJuBjOMkn5+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciNrE_F0B0nu=Mib6LhcFhL8+qgO-yiKNsJuBjOMkn5+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:57:16AM -0700, Axel Rasmussen wrote:
> I'd prefer to keep them separate, as they are not tiny patches (they
> are roughly +200/-150 each). And, they really are quite independent -
> at least in the sense that I can reorder them via rebase with no
> conflicts, and the code builds at each commit in either orientation. I
> think this implies they're easier to review separately, rather than
> squashed.
> 
> I don't have a strong feeling about the order. I slightly prefer
> swapping them compared to this v4 series: first introduce minor
> faults, then introduce CONTINUE.
> 
> Since Peter also has no strong opinion, and Hugh it sounds like you
> prefer it the other way around, I'll swap them as we had in some
> previous version of this series: first introduce minor faults, then
> introduce CONTINUE.

Yes I have no strong opinion, but that's probably the least I prefer. :-)

Because you'll declare UFFD_FEATURE_MINOR_SHMEM and enable this feature without
the feature being completely implemented (without UFFDIO_CONTINUE, it's not
complete since no one will be able to resolve that minor fault).

Not a big deal anyway, but since we're at it... Basically I think three things
to do for minor shmem support:

  (1) UFFDIO_CONTINUE (resolving path)
  (2) Handle fault path for shmem minor fault (faulting path)
  (3) Enablement of UFFD_FEATURE_MINOR_SHMEM (from which point, user can detect
      and enable it)

I have no preference on how you'd like to merge these steps (right now you did
1 first, then 2+3 later; or as Hugh suggested do 1+2+3 together), but I'd still
hope item 3 should always be the last, if possible...

Thanks,

-- 
Peter Xu

