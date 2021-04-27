Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC436BD1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 04:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhD0CHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 22:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhD0CG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:06:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F616C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 19:06:17 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id m13so58341862oiw.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 19:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RjRLRjt6DksoCv/KudQEO4D/bl6V4MEpJxlivb+MQoM=;
        b=jdV/vIAUyUYepkvyJNWXc3rT8qZiyIJAwkvhMcd+315lRZ7zAiBI7zwh312YsV9EWr
         CXUhCmMf29fQrxt9oEQW12yvBYikgQKfnLYZjsmv4T3T70UD2SIFDZp6Uh9YjgSjL6iR
         BKktWs8jn3BGR8MX0WOfS8ty3VTSKAVdrLfiWt2aiA0DzKIAh198wP4KlIP9bk3MXU3z
         iJwMo0CcJSeuAn5Wss+Ccq74lMS4hQSKoRxRT5LU8/Oq36/JBdHBNdFRwWRnJ8u9kw0M
         bMjeV7ArPu4oPxPVf26HVS+tLLLMO9J8yPnkGZYKmouGME+1P7qPmik3YycN6FtwOWcY
         QIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RjRLRjt6DksoCv/KudQEO4D/bl6V4MEpJxlivb+MQoM=;
        b=caY+jUdGA2G5jhzmseUzXq8J4ZglbgQC+phJHttYrhIoMj6b2s1Q97jDNihtZ/vfyC
         HmjyugklMp4C0D3y9AR+1V2D0zAowtbt1pXsu8a6N/NbvF/fhj4ej/V5jikhO++d5E9F
         PQvWu4xbvw9kTFBk3aL2jCI7o/qsnIY39jjrcMxRFxdLFyeyqAP66scWPjWH1bSaxqsY
         rnviE/smh7G0CAFhDYw4A7OSLHoideBd5Hh6gWq/UzJP5hv4XPq4AuWe+1OCUAhgxw9i
         gH5vXCPDKCRZ5hm5tOtlsxxCvGVW3JA5TjSEcA2Cpn0HJXzp5tdJ4vZqyPa9yeIp+qjD
         Ug2Q==
X-Gm-Message-State: AOAM530GkVYRf+xA+s2fzjzA/T3r9u4T/vgtP1/fSp+qzMML32prv2hZ
        3OzZlFZCTg2Dz8nVJJ5xtFMh9Q==
X-Google-Smtp-Source: ABdhPJymXV9swDliPd/VmVska6RbWioEMytEv11iIxTdOsGriU6E6s+aROVttE2bhkJcD8ehfB9fIA==
X-Received: by 2002:aca:90b:: with SMTP id 11mr1437534oij.77.1619489176268;
        Mon, 26 Apr 2021 19:06:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h28sm404479oof.47.2021.04.26.19.06.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 26 Apr 2021 19:06:15 -0700 (PDT)
Date:   Mon, 26 Apr 2021 19:05:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 01/10] userfaultfd/hugetlbfs: avoid including
 userfaultfd_k.h in hugetlb.h
In-Reply-To: <20210420220804.486803-2-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104261858130.2998@eggly.anvils>
References: <20210420220804.486803-1-axelrasmussen@google.com> <20210420220804.486803-2-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Apr 2021, Axel Rasmussen wrote:

> Minimizing header file inclusion is desirable. In this case, we can do
> so just by forward declaring the enumeration our signature relies upon.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  include/linux/hugetlb.h | 4 +++-
>  mm/hugetlb.c            | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
