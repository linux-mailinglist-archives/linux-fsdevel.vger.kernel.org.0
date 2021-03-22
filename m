Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA7E34514F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCVVBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 17:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhCVVAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616446836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6WtZIP3Pv8Sts2xBUJYEw6AY7dI8VFWAi8J8oYd58g=;
        b=aHAjZepqA7I5BBs6Q5u4Z7d0hYxhzXlhqTusvxNG6+2NutssQADo0dbQ6NrTu6V/bIxjBe
        G06s/cEpJHTQtoU8EZ14teFNILgCeTUO1q9DREuOHR0eq29CjGvEZ2nhgPrmPeo+QzqyXh
        caMLr+3RWz94/VtPmfySqrXuLmnye3g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-d5TFu6qSOLSsSYYd97w71Q-1; Mon, 22 Mar 2021 17:00:35 -0400
X-MC-Unique: d5TFu6qSOLSsSYYd97w71Q-1
Received: by mail-qk1-f200.google.com with SMTP id v136so445205qkb.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 14:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c6WtZIP3Pv8Sts2xBUJYEw6AY7dI8VFWAi8J8oYd58g=;
        b=py7GLh+riwwqKlLP2lGFzDlVmne3Vfx5jrFAtzSufKIhozajvInUsHtbyTAlub6v1i
         QwWudfrGQxBPdJopqUdr/YKhSHwzj1P9POtQsKsuxs1vKUkjQSDyAvwiemprQ0ZIy3JQ
         Ck3Of3lTk1GEU8hm5+gIFk5Q5WPPZSqMW9c8J4HqDudPomgELL47BjwSGgRrNlOw8sGe
         SzGd2QnPk9/0eYkLUeLtbpZP2aczSFGAhBunZ6ERF/U3ZfYg+7vU6VKKC3KigIp/ws/9
         biAmak4uzuSbtxNxnaUjLTXpuyUXiABDTkNE9z89uRdKkqaCqf8lVvLk8BWReaqO2QBu
         jH+w==
X-Gm-Message-State: AOAM533DLE9nWC0OZqwAAiE4Hp122GajOeg2CWShAwA8zfCsvWQ7dzdi
        hdh3U3k5zc8mzKYfG3tOGmy5TZvdg1UMQS0LinMw61vqLSbC+c98/O2uTfpkz+UuwP03qPRW9EC
        UYiNOshnBLLSZDLQfiYcPcJ/97Q==
X-Received: by 2002:a37:b07:: with SMTP id 7mr1967528qkl.437.1616446834812;
        Mon, 22 Mar 2021 14:00:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQd0PhyYegD6z3hStlomrWz7fldh8CLfj/9QsIxn62XAVmyQ2p22XQ5XNwdBsS8CuH5dU6Lg==
X-Received: by 2002:a37:b07:: with SMTP id 7mr1967476qkl.437.1616446834557;
        Mon, 22 Mar 2021 14:00:34 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id b17sm9688484qtp.73.2021.03.22.14.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:00:34 -0700 (PDT)
Date:   Mon, 22 Mar 2021 17:00:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] userfaultfd/shmem: fix minor fault page leak
Message-ID: <20210322210031.GH16645@xz-x1>
References: <20210322204836.1650221-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322204836.1650221-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:48:35PM -0700, Axel Rasmussen wrote:
> This fix is analogous to Peter Xu's fix for hugetlb [0]. If we don't
> put_page() after getting the page out of the page cache, we leak the
> reference.
> 
> The fix can be verified by checking /proc/meminfo and running the
> userfaultfd selftest in shmem mode. Without the fix, we see MemFree /
> MemAvailable steadily decreasing with each run of the test. With the
> fix, memory is correctly freed after the test program exits.
> 
> Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

