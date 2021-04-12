Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B151F35D2C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 23:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343534AbhDLVzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 17:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238235AbhDLVzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 17:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618264486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSg/4g7S1VAs0BEe21c6JFZm2CbvqXRaPJMkscjjUzQ=;
        b=GWm+8HZ4cyIx+R7YkiCmMziBlQDlLZAzCcIfYD3il8keAMGkqJxTFl4GYWEmVu/iZZjapz
        7N9MtYm+hqJhQ4bG91zh1e/pYwMIHWoohLyR+tpiQ755s3KNihqpg1FzauJyjszqvZo0N+
        dFBqdUqddWPv/KEVwV2N+QcVCwheX3s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-O5_CEdXYOfW6HwteGFPsSQ-1; Mon, 12 Apr 2021 17:54:42 -0400
X-MC-Unique: O5_CEdXYOfW6HwteGFPsSQ-1
Received: by mail-qv1-f69.google.com with SMTP id j10so8835788qvp.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 14:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rSg/4g7S1VAs0BEe21c6JFZm2CbvqXRaPJMkscjjUzQ=;
        b=Dh7Or8f9l2Tnxpy9i95fGIU1Z8nj/V6j0g7d/2Yv3vsQL1EQMklCC/D9ZcaYkgIdqa
         I8TDalkTUi8ezxyBkmCpVWHOq7TpWsPp7ZEvdB0jPupNVbl+bwoWygQ8SJ+aOsoXwkoG
         qvkBNOuJ7yvBvW8/sYu0h6kC0eGRxpkOd/vNucqlgdI5o0Vz7YRQ/VlB4AAS/iL58QDr
         tThkMt5NU+/Mo/b/CnyYu8gcG1KIyS0/oPn5WO1kD6Gtq62xlA8YueSekbvz0Lb7f7de
         psoQiuRd1uSdpODzsNw2QnPU4xToEtW9guG6kcts87N87trrJu2An7ZVVOucWVTR6+lJ
         v1wg==
X-Gm-Message-State: AOAM533p88xFbuGVrdDdRX09HmHCA00RoffHo1YdY8g99dJv/uA5R0o6
        iVBr4HIVL/rOchrRgW/4Q3VcQJrUhVXVT7g81Dd47QEGxV56T5liu7ekFxyiWCC/A0+9wGfKwXG
        cYiDmNJEujk/voLCsvNRB+HWjeg==
X-Received: by 2002:a05:6214:14b4:: with SMTP id bo20mr4943798qvb.20.1618264482036;
        Mon, 12 Apr 2021 14:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbD4DC7OMtAMwjp3Zq2ZGY5AAvdzECr9OQOYMWUawBpI5JNBVDfUwjpTZGyULdEUCkWeV3/g==
X-Received: by 2002:a05:6214:14b4:: with SMTP id bo20mr4943769qvb.20.1618264481785;
        Mon, 12 Apr 2021 14:54:41 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id z18sm3501170qkg.42.2021.04.12.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:54:40 -0700 (PDT)
Date:   Mon, 12 Apr 2021 17:54:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE behavior
Message-ID: <20210412215437.GA1001332@xz-x1>
References: <20210401183701.1774159-1-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104062307110.14082@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104062307110.14082@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Hugh,

On Tue, Apr 06, 2021 at 11:14:30PM -0700, Hugh Dickins wrote:
> > +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +				     struct vm_area_struct *dst_vma,
> > +				     unsigned long dst_addr, struct page *page,
> > +				     enum mcopy_atomic_mode mode, bool wp_copy)
> > +{

[...]

> > +	if (writable) {
> > +		_dst_pte = pte_mkdirty(_dst_pte);
> > +		if (wp_copy)
> > +			_dst_pte = pte_mkuffd_wp(_dst_pte);
> > +		else
> > +			_dst_pte = pte_mkwrite(_dst_pte);
> > +	} else if (vm_shared) {
> > +		/*
> > +		 * Since we didn't pte_mkdirty(), mark the page dirty or it
> > +		 * could be freed from under us. We could do this
> > +		 * unconditionally, but doing it only if !writable is faster.
> > +		 */
> > +		set_page_dirty(page);
> 
> I do not remember why Andrea or I preferred set_page_dirty() here to
> pte_mkdirty(); but I suppose there might somewhere be a BUG_ON(pte_dirty)
> which this would avoid.  Risky to change it, though it does look odd.

Is any of the possible BUG_ON(pte_dirty) going to trigger because the pte has
write bit cleared?  That's one question I was not very sure, e.g., whether one
pte is allowed to be "dirty" if it's not writable.

To me it's okay, it's actually very suitable for UFFDIO_COPY case, where it is
definitely dirty data (so we must never drop it) even if it's installed as RO,
however to achieve that we can still set the dirty on the page rather than the
pte as what we do here.  It's just a bit awkward as you said.

Meanwhile today I just noticed this in arm64 code:

static inline pte_t pte_wrprotect(pte_t pte)
{
	/*
	 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
	 * clear), set the PTE_DIRTY bit.
	 */
	if (pte_hw_dirty(pte))
		pte = pte_mkdirty(pte);

	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
	return pte;
}

So arm64 will explicitly set the dirty bit (from the HW dirty bit) when
wr-protect.  It seems to prove that at least for arm64 it's very valid to have
!write && dirty pte.

Thanks,

-- 
Peter Xu

