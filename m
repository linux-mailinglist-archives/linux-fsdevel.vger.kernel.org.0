Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B68314478
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 01:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhBIAFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 19:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229615AbhBIAFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612829030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/210rAGZW9oY/7ReROP+ZQtbzjSdBlXTBZzdVvnx9Q=;
        b=UajDRtt1i5UP0frzVxqFS0PaOQKkIakCSjW+j4Af1HgDhhB8all5obX6rJRabdC1p3i6+i
        gs8PeyFCun1fvcm8TPE+/fAf4f7ntKq8MFXZLZcXn9B+KcmjQ4WligIjL6wnoRXMHQu1M1
        HzJrarW2Vphs6+C71uTEBJU1S4QAFpw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-AmDbORUhPNizh2OUb_17Gg-1; Mon, 08 Feb 2021 19:03:46 -0500
X-MC-Unique: AmDbORUhPNizh2OUb_17Gg-1
Received: by mail-qt1-f198.google.com with SMTP id d10so10925238qtx.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 16:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/210rAGZW9oY/7ReROP+ZQtbzjSdBlXTBZzdVvnx9Q=;
        b=MyRAcewTMctls38F1ywFiTY5w7cuAE6mPXZssc1acsAxtnFZhzaeEJ5xHbsA5Wu6j6
         gm+zKY8xMmmIFvaEpYedfN0mMef3mvaIy+o9ybBNeK0TkmJyUrAIxHMfne+fdO2yzU3g
         nabMLpOQaad15RH+u/DhLIIvDv7NYScOdcdvWlHRK4qmJIV1Myw8KKjDC959ADFr1S3u
         I0dQBoWDQvA9uZUnSe6LWlVvUJvg02EznVHm1yjXw2cusTSwz8KdjIyevDy6tbUzAzE+
         BHLkgFe7+WNiURRm2CFZPgfvShm33ElV9AH54F3/lQnwmnWA2Jd0s6M02Kz3GhL0zTg4
         3LxA==
X-Gm-Message-State: AOAM532LvD4/cnnfAjehr8RKk9mPNFqdRZwCknjZBAeFX3YX1X5LJdR5
        IDhPiadbTraGM1f645wPwI19SDRgphRHy55HpG1Eel2cFiX1LRZXp1xqukXmPntpkZxy8TFbHn/
        wurTs9VbJdeV6QgQODZ6x3vKSKg==
X-Received: by 2002:ac8:dc5:: with SMTP id t5mr18134039qti.246.1612829026162;
        Mon, 08 Feb 2021 16:03:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPXRlqyvo1iWsQesrmGcyiNU77GkMdEeHUd2qzG4pOkPk2ElaC1WwV8jpBuKPqeQ2Y4bQm3A==
X-Received: by 2002:ac8:dc5:: with SMTP id t5mr18134008qti.246.1612829025991;
        Mon, 08 Feb 2021 16:03:45 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id r17sm15494684qta.78.2021.02.08.16.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 16:03:45 -0800 (PST)
Date:   Mon, 8 Feb 2021 19:03:43 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 00/10] userfaultfd: add minor fault handling
Message-ID: <20210209000343.GB78818@xz-x1>
References: <20210204183433.1431202-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204183433.1431202-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:34:23AM -0800, Axel Rasmussen wrote:
> - Split out adding #ifdef CONFIG_USERFAULTFD to a separate patch (instead of
>   lumping it together with adding UFFDIO_CONTINUE). Also, extended it to make
>   the same change for shmem as well as suggested by Hugh Dickins.

It seems you didn't extend it to shmem yet. :) But I think it's fine - it can
always be done as a separate patch then when you work on shmem, or even post it
along.  Thanks,

-- 
Peter Xu

