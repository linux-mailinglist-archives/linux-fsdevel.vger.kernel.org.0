Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CCF33AF35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCOJrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhCOJq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:46:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74DCC061762
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:46:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mm21so64958625ejb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCH3VsMvUSEqRY0D77ObQA6OJaIvmvlJ89ZGUx/CcXM=;
        b=KBdJN57ZQ8VQz1uCDRBPHQrOXwItBmwEOFNPq9ozYMbd8bVSP9hZj0v9/leZLxc2v+
         bnEIog66c/xVxrJaQAQDSfaN+5ON+6/yYsZ8IdtMtK+aTlx4uX2mxihZsNBRUez/do4+
         1KvtRI7pNUOjnhjQuA0DVTja0OSZL+D2vVMQuDfYKe+dQbply48UC3cv2rlAidtOomQs
         k1BP33T2HNlfsNTa9+WA72vbFKmtOzfthLV8yRt2Y3aDsU1xaHrDx2k0biUGtA/628u1
         XwtKg+gHWjT467qCsHWkew3z6+raHVfH7JAGoUlxnPeVEVkdXSpctfKubCK/DjB1C3Uf
         K5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCH3VsMvUSEqRY0D77ObQA6OJaIvmvlJ89ZGUx/CcXM=;
        b=oWldQ5kkjbSUl1/SWPhTBSi00wKdsfJSn09jK2HrA/AmpV+CNZHF95v9VACa73TRhH
         MKnInMXQ7vKRRPwoBwrT324WoalX2Vo8KylMsIPsPtQLCxXjlCPTvU/0py+98dDc3lnS
         rO8dXun66Em567WWPACf4Rg0KdVRHt0QOU0LQbMKTb5GbWc39JwWrNdpHkzXxPN+AxHr
         73CsIPjZn5klw44E+jdDI6MP8f2pZ1cQbiNzc5wQGAsrWvWsmjrnm1cnd+HEHIJJEC9a
         MGlBbmBsptN7w1Jt8/bT1Rq9P84e/mFVGT7bUykfg8r59Qapbe4KclTdxoRiTtjg4chk
         6xRQ==
X-Gm-Message-State: AOAM533vhvOMFUhYjXwtgNK1MYxuoQwjvkYY3p9lKT+00+ZpqxFjYbe1
        PZ08bUZt+AxVCuNozwU/EztZ+rXbhlMIzfBiHOrm
X-Google-Smtp-Source: ABdhPJwfPpbGsW1NwziEvCm+pu9W0AYA2Ip5t3r5CSavHkGCI1g9/KIycGHrq/KBYUgnQfbZQ1cImKEpNMiBrV1NXz0=
X-Received: by 2002:a17:906:311a:: with SMTP id 26mr22439640ejx.395.1615801614537;
 Mon, 15 Mar 2021 02:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210315053721.189-1-xieyongji@bytedance.com> <20210315053721.189-2-xieyongji@bytedance.com>
 <20210315090822.GA4166677@infradead.org>
In-Reply-To: <20210315090822.GA4166677@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 15 Mar 2021 17:46:43 +0800
Message-ID: <CACycT3vrHOExXj6v8ULvUzdLcRkdzS5=TNK6=g4+RWEdN-nOJw@mail.gmail.com>
Subject: Re: Re: [PATCH v5 01/11] file: Export __receive_fd() to modules
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 5:08 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 15, 2021 at 01:37:11PM +0800, Xie Yongji wrote:
> > Export __receive_fd() so that some modules can use
> > it to pass file descriptor between processes.
>
> I really don't think any non-core code should do that, especilly not
> modular mere driver code.

Do you see any issue? Now I think we're able to do that with the help
of get_unused_fd_flags() and fd_install() in modules. But we may miss
some security stuff in this way. So I try to export __receive_fd() and
use it instead.

Thanks,
Yongji
