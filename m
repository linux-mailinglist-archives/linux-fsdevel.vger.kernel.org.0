Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682F7176F81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 07:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgCCGeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 01:34:04 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34332 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCGeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:34:04 -0500
Received: by mail-ot1-f42.google.com with SMTP id j16so1957864otl.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 22:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nd/TEeW4LQOvJMaEt1rZVabT2kTJB3dRDcejupbt5xY=;
        b=RT+Kea4iOHlH9H/H9pNH1Sk5JZ4dns1gAbgYhpwbXqqZbzVX5jEh1et1qoLilG5wVs
         oO2JK/0A0BWeTpwrk38qIZ6XZ4P3iBdLicT+oqLeMT/lp5vTN+FuRTu9OOkmhkC8cJca
         VNnFYWcAPZnYcrYLsnEGl2OTcQKWgZgulNDfrJbAPifq7V9ST4c9TsnqL5L3xl31itA7
         zTqGIMx5oodNwYKcTa39nYsVUZd9viLRjg7pyd6NoVpKZ1KakGNLr2ZMf2jo0YkKKo7G
         qZSY6uQZE16aoTg0ZtnBdaWfz1YWULza/Pk+PtsfaW25hJEnjirgGc/h7Hl4hMWxRARM
         8K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nd/TEeW4LQOvJMaEt1rZVabT2kTJB3dRDcejupbt5xY=;
        b=GhtzSdv/l6wpyQ1JB7hFmpMk4tMwrYWrkwXSUGhuPWhjHlYYtlj0x3WdI/kA0aOryG
         aA1QpD0cii689gqYmBKRFMImfSzU9w7PcQvf9pRU8k33JmSeTG/Ob2lT612tNGwIO5dV
         Gbst70HxkdJe4eUL8AnPeMhjFxzn1xcbQKvHQtcB4Da29KFHa0TLVOye21SyhEm8Q9Tm
         7/WPWYe7TGDo47QmjUAWgqhRx5wlDZaJGI5DZfMzDhNgved5FAoSf18U54V8h6+sbGcU
         Hl2oyvmieH9QN6+yD2wq8e2nmBMreHIgM5R5qTVZNxTfAfDLJSy2Oq0/k/Ijl81eZlNs
         Y1RQ==
X-Gm-Message-State: ANhLgQ0e3zXYR2OVg8CHdaS15Iyay5YZ2H1Mm9Z7TbL7pTYZOaG/6rTg
        9W0khxRIVHmQvg/OOvKkpu9syQ==
X-Google-Smtp-Source: ADFU+vt+oiBRDRmtU/BlPEpanrfpTiCQDOW8t3tex0y3+5iv9DRGttD0LyFJlWuDDjetCc5tLiQDxw==
X-Received: by 2002:a05:6830:1203:: with SMTP id r3mr2352162otp.230.1583217243235;
        Mon, 02 Mar 2020 22:34:03 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z10sm7243729oih.1.2020.03.02.22.34.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Mar 2020 22:34:02 -0800 (PST)
Date:   Mon, 2 Mar 2020 22:34:00 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Anshuman Khandual <anshuman.khandual@arm.com>
cc:     linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hugh Dickins <hughd@google.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 3/3] mm/vma: Introduce some more VMA flag wrappers
In-Reply-To: <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
Message-ID: <alpine.LSU.2.11.2003022212090.1344@eggly.anvils>
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com> <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 Mar 2020, Anshuman Khandual wrote:

> This adds the following new VMA flag wrappers which will replace current
> open encodings across various places. This should not have any functional
> implications.
> 
> vma_is_dontdump()
> vma_is_noreserve()
> vma_is_special()
> vma_is_locked()
> vma_is_mergeable()
> vma_is_softdirty()
> vma_is_thp()
> vma_is_nothp()

Why?? Please don't. I am not at all keen on your 1/3 and 2/3 (some
of us actually like to see what the VM_ flags are where they're used,
without having to chase through scattered wrappers hiding them),
but this 3/3 particularly upset me.

There is a good reason for the (hideously named) is_vm_hugetlb_page(vma):
to save "#ifdef CONFIG_HUGETLB_PAGE"s all over (though I suspect the
same could have been achieved much more nicely by #define VM_HUGETLB 0);
but hiding all flags in vma_is_whatever()s is counter-productive churn.

Improved readability? Not to my eyes.

Hugh
