Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F10F1EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 20:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKFTel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 14:34:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727208AbfKFTel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573068880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qEO1LlS+wx20cugYICVdXzykrKwgfNh8MhubhOzG8Ws=;
        b=MwbE77lFngTG6Dsq8xUz5kzfSbOyaNWI3YESv3YJL4sbCdWKUr7KaYe9RJzW4b9nWkYECq
        PvSB6W4Jz8AZVsHBV7udsYf0py6B/Rm7YWVV+3HAuM1QEaPxviSNufmIIuO+7alMo2dFr4
        gNoKNTkSvKyL/tHwQgGqwxBzB4suK9k=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-n2WeGt1rMsyUAFGR3ttzkw-1; Wed, 06 Nov 2019 14:34:39 -0500
Received: by mail-ot1-f70.google.com with SMTP id z2so10847300otm.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2019 11:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+4oqdhQ7XrescyUouTmBb2WkDtFgojtFKKsRM3EtqU=;
        b=OFxAOgkjBPHZKAjo5qFs54aJ49SWRzmNns1YvKWwW07smpuey/H1miqmEkEcgPTKyz
         dVo4M0fEs+k8T2khWVXzxS8RfZltY8jd+Mt3Pu3b3zneycNZn9SfYsz9feUIa9SWt92M
         DFtPxBmO/htHsRTscb4MZYFzx4B6MdaxSiPfMrC3kVW6Y46mfkOAzd7JOlIRZq9G6os/
         +TAyQZ02pDxexXB2HQQ/8YIA4w0PKIEwK0piBfccIWaHps3BPmO2pEyhgIpcj4S/dHl0
         /KhymJKIWqzn41BZvaQPR8KQbpHXAtvPzkJjCd3IJjMnvvEdqjG23Rhs78N8aEntpHfK
         UHYA==
X-Gm-Message-State: APjAAAU0quTseRq6j3y4fOr14LdNXYaFbSGy4TasvH52A+Qqhy/DrN3n
        YLqP0nmTgL0vB1VOqPdN/9fOZffZj07+/alYvxrxV6E1shqTKEEzCVFusXyDN1WWm/tuFuKDrog
        D4dqSMTYkvl344R7PK1De7QpOSHl5K3Pa+kA+bUefpA==
X-Received: by 2002:a05:6808:1cf:: with SMTP id x15mr3807579oic.147.1573068878066;
        Wed, 06 Nov 2019 11:34:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPzYD92f6MsHAshLnXaaJ+RPJgHkX6+wC94uNc+LizG8qwMH31bwK+IWqpoAuDU814qf9pItQs92dqpJwrbxw=
X-Received: by 2002:a05:6808:1cf:: with SMTP id x15mr3807551oic.147.1573068877746;
 Wed, 06 Nov 2019 11:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20191106190400.20969-1-agruenba@redhat.com> <20191106191656.GC15212@magnolia>
In-Reply-To: <20191106191656.GC15212@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 6 Nov 2019 20:34:26 +0100
Message-ID: <CAHc6FU4BXZ7fiLa_tVhZWZmqoXNCJWQwUvb7UPzGrWt_ZBBvxQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: Fix overflow in iomap_page_mkwrite
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
X-MC-Unique: n2WeGt1rMsyUAFGR3ttzkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 6, 2019 at 8:17 PM Darrick J. Wong <darrick.wong@oracle.com> wr=
ote:
> On Wed, Nov 06, 2019 at 08:04:00PM +0100, Andreas Gruenbacher wrote:
> > On architectures where ssize_t is wider than pgoff_t, the expression
>
> ssize_t?  But you're changing @offset, which is loff_t.   I'm confused.

Oops, should have been loff_t instead of ssize_t.

> Also, which architectures are you talking about here?

From the kernel headers:

#define pgoff_t unsigned long
typedef long long __kernel_loff_t;
typedef __kernel_loff_t loff_t;

So for example, sizeof(loff_t) > sizeof(pgoff_t) on x86.

Thanks,
Andreas

