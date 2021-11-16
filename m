Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468E7452672
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 03:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbhKPCFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 21:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343985AbhKPCCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 21:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637027959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcHmUdloBDYBnO1Vfa9QPmbf+FFF2gIjnC+Yb39rMoE=;
        b=NR7IrsoUp+JhUxKhS47X95j2zq045L71EoOFHsA8f21AbGJItUfHuGp//f+7EroCzH6C0G
        iMgA5ooLAntq7/9B+4TmHEj0hVEwjLpoWz6mW8Oaqkh6wSOW7QUqdzjHjVzcApxrROulUE
        9ReHRb/27OORfqYdtVtkLu9e6lidozg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-cpjf7-OhOrqiUnDnFsMw6w-1; Mon, 15 Nov 2021 20:59:18 -0500
X-MC-Unique: cpjf7-OhOrqiUnDnFsMw6w-1
Received: by mail-pf1-f199.google.com with SMTP id w2-20020a627b02000000b0049fa951281fso10926516pfc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 17:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcHmUdloBDYBnO1Vfa9QPmbf+FFF2gIjnC+Yb39rMoE=;
        b=FADnOQB+DX6hUBsiRSibe+LNddVu3owxPfuCgcUxbpDVxomp9TpLG1s4LvSn5cpRVU
         Ve88k3TH04DB9+XZAXEw0TZhgRNqfLZfWEvXb335HB0Gp/PjrA/bY5FStHTeb1WwjBYl
         Et/WOyeq6GHAhm0mQlOURHdU1gKCmtn0JmP6O0AYNum8D1F068RGnxgi1bC6jT71cuRl
         myO9zmgL6dVoZ0zmOlwYEq5qa1qJbfloBP+fCATSp7xL6mZm/09tpnCwpPN3WZhpeZMc
         lYJSj/Ry8RvmC8RtMz2YwG49Ab4+3n9kbxuwjOg/vWElkOY+DY0ZU/HUH9Cji5qAo1KR
         bIjw==
X-Gm-Message-State: AOAM5329MiiFUfJghTVifJgWjDXicj0H+YL/EOzWLZI28PWEpCABsqMO
        +Jhgylh4Ajom6frmfhBgNy0boWBkqlh7O5ymXoMaaluQ9zI4MWI1s67UHdASLoJPBNO2Yu1DovH
        Fno6C8rvZ/oF6vScapqvQP3iCdg==
X-Received: by 2002:a17:902:6b47:b0:142:82e1:6cf5 with SMTP id g7-20020a1709026b4700b0014282e16cf5mr40927402plt.28.1637027957543;
        Mon, 15 Nov 2021 17:59:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKM0irZy6MEENYIUeb4VgibHSWGI1JDBHGPOY88s77OFBFd8XKwQnOpry9mxgunT5NjmEyBw==
X-Received: by 2002:a17:902:6b47:b0:142:82e1:6cf5 with SMTP id g7-20020a1709026b4700b0014282e16cf5mr40927373plt.28.1637027957285;
        Mon, 15 Nov 2021 17:59:17 -0800 (PST)
Received: from xz-m1.local ([191.101.132.59])
        by smtp.gmail.com with ESMTPSA id lx12sm546013pjb.5.2021.11.15.17.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 17:59:16 -0800 (PST)
Date:   Tue, 16 Nov 2021 09:59:10 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-ID: <YZMQbiV9JQWd0EM+@xz-m1.local>
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s>
 <CAHS8izP9zJYfqmDouA1otnD-CsQtWJSta0KhOQq81qLSTOHB4Q@mail.gmail.com>
 <YY4bFPkfUhlpUqvo@xz-m1.local>
 <CAHS8izP7_BBH9NGz3XoL2=xVniH6REor=biqDSZ4wR=NaFS-8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHS8izP7_BBH9NGz3XoL2=xVniH6REor=biqDSZ4wR=NaFS-8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 02:50:26PM -0800, Mina Almasry wrote:
> PM_THP_MAPPED sounds good to me.
> 
> TBH I think I still prefer this approach because it's a very simple 2
> line patch which addresses the concrete use case I have well. I'm not
> too familiar with the smaps code to be honest but I think adding a
> range-based smaps API will be a sizeable patch to add a syscall,
> handle a stable interface, and handle cases where the memory range
> doesn't match a VMA boundary. I'm not sure the performance benefit
> would justify this patch and I'm not sure the extra info from smaps
> would be widely useful. However if you insist and folks believe this
> is the better approach I can prototype a range-based smaps and test
> its performance to see if it works for us as well, just let me know
> what kind of API you're envisioning.

Yeah indeed I haven't yet thought enough on such a new interface, it's just
that I think it'll be something that solves a broader range of requests
including the thp-aware issue, so I raised it up.

That shouldn't require a lot code change either afaiu, as smap_gather_stats()
already takes a "start" and I think what's missing is another end where we just
pass in 0 when we want the default vma->vm_end as the end of range.

I don't have a solid clue on other use case to ask for that more generic
interface, so please feel free to move on with it.  If you'll need a repost to
address the comment from Andrew on removing the debugging lines, please also
consider using the shorter PM_THP_MAPPED then it looks good to me too.

Thanks!

-- 
Peter Xu

