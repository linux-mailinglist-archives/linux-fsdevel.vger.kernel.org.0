Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9E1325830
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 22:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhBYU4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 15:56:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230201AbhBYUyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614286374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTyh/njbTvxGBCwzrRyX2EiAfSR949VElesvFbgeey4=;
        b=I4+eJrNl60ZNQ4sVaWcm1ZtqVLJOIh4RhIqMVply79I2akK/lzqX+L+eX2hQiMATT6xhM0
        m6f7ME32cw5N/Gse4FZO7wuoqK7qUbPf4pWJ61sTV4ufYmcrF3+RYxTnmkYD7T3Zo+hJ5j
        kdwDXe/lOcHiqWKZhWWPW25l/dH5lNI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-JsqsyEU7MYiErRpL9QnWRQ-1; Thu, 25 Feb 2021 15:52:52 -0500
X-MC-Unique: JsqsyEU7MYiErRpL9QnWRQ-1
Received: by mail-qv1-f71.google.com with SMTP id er16so5196565qvb.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 12:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fTyh/njbTvxGBCwzrRyX2EiAfSR949VElesvFbgeey4=;
        b=mkErcsHImqC/fzvNHuoBUAvfh7uXpKv9T6ymWoEPYCD/RhsVPoUxW+3l+II+BQNyTN
         UnoQCk6PIQUlpb/+38Zjg1iL/Udmwe6mCVwfKfCu6ZIwXPNMeF4cMYC2JlVk8UByfQUB
         Ovn+623rNbPmqgAOfEaSvcO7tMFTTj9AT0zGHWgUN/eogyGR/e+tg+jk6cKCfIXm+mJS
         eWUvXv1WksBVJGZQaO8866N0TYpghkRkztbTtkPk+QNWAtgrBJ6JDJJmZ0vQjqM+kW+P
         0pUUJiCYWxNfTHosoPDO0L26TAhgJXxNXRbQ60Bg0WTW8qap1/C+H6SH9wE+C0ziItxZ
         6TDg==
X-Gm-Message-State: AOAM530nF1BJAqYOxROcMT2E1S6p9HEjC2zEHWRrajj6kxjX3fzD/8bC
        ieyiZudKo+il8o/7iLcDyS0Ti8sdErkGyWztWasQ9rdWcjzIbNMdYeMEs8ywWbIE2FyHrIU5f1Y
        wahPk5GTMpJjd4kVj79r7o8BZ7Q==
X-Received: by 2002:a0c:aa44:: with SMTP id e4mr4666452qvb.49.1614286372231;
        Thu, 25 Feb 2021 12:52:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCLajWQUkxvgpgD7t4awfHzseijCI18Fdo3q4NvLoomSopF09Ho/6jtHG7arGIFZ+5QeJm7g==
X-Received: by 2002:a0c:aa44:: with SMTP id e4mr4666419qvb.49.1614286372014;
        Thu, 25 Feb 2021 12:52:52 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id w20sm4787394qki.102.2021.02.25.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:52:51 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:52:49 -0500
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
Subject: Re: [PATCH v8 5/6] userfaultfd: update documentation to describe
 minor fault handling
Message-ID: <20210225205249.GB261488@xz-x1>
References: <20210225002658.2021807-1-axelrasmussen@google.com>
 <20210225002658.2021807-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225002658.2021807-6-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:26:57PM -0800, Axel Rasmussen wrote:
> Reword / reorganize things a little bit into "lists", so new features /
> modes / ioctls can sort of just be appended.
> 
> Describe how UFFDIO_REGISTER_MODE_MINOR and UFFDIO_CONTINUE can be used
> to intercept and resolve minor faults. Make it clear that COPY and
> ZEROPAGE are used for MISSING faults, whereas CONTINUE is used for MINOR
> faults.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

