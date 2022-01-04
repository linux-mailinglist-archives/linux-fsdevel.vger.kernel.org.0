Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E5B484AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiADW4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 17:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiADW4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:56:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93128C061785
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 14:56:05 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 200so33934818pgg.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDrla7Rgv/PbJy5q1B/gTLicO7LUJ4Uh87OcS/ewnKE=;
        b=UnQWpQr21b08H9CCzMDJ58NV59i32gSxpHT+QzAwkrO4OAmJ//j0XPMmeqp9ezNcVD
         wc+LG30An/agayNvl+NJHt6YBjXm6O408MGhsYl9h7mvor6IRClKKERwR+G7NA4rrrxD
         YEhHssP/S9/5wHZr2A6Ly4Y41OVCTab/vh3T/47v9/0Zl1rBfzSzhFxVXZwEhpw+OAlb
         lHdxMEYtx8koB4EsWoqsmItGdKo9eHAhy8j0Jf078FeDyQ6lYITt2LM67Tetu3wYlKWG
         m/cVqQ6dQgccJh3/k7W1YuPpUIzvCRVDDwWPDHRnOkQXBz8LQPfn4BPfDg0xP1ivy5we
         53Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDrla7Rgv/PbJy5q1B/gTLicO7LUJ4Uh87OcS/ewnKE=;
        b=Kb5CR59eOah4kddstVRYGx/+xytJOkT5+PL9D5S5ipWyS4cP9Gg6VWQ96rZGe81dMC
         at6y9D2+/gNwk0R2b6t0lrDqFnXk4XpNwYtr77oKY9DdaVP982a0MD2Awq2dSXdlpgy8
         XnnvTDLyRBhs/O7j3K+CJNwlztybwVDDA6wtj5xuWERxaLPtM3IIDygx6MbM/GEzpRA8
         kMd78XJv0+fd4cocOBHhVZvuWLG1FagqlAW+0xSZAR41zgv0o+6DTW/MeU+9W3jcDJdl
         DGZnNO7GtK4sFt2idlAqIhtPmqOqsbtfunmZNN5BO0YZQccOWsddOVxhC8m8z8DL/pMc
         fwbw==
X-Gm-Message-State: AOAM530JnJ+lrpc1CyRX5yQYEp3RyCNlkTgK0sH9kyYko2yep3n6MkFd
        HyxbkkX5iyWLdb3a6Tl8ajL4kFi0UhQ5Fv/qnX58VQ==
X-Google-Smtp-Source: ABdhPJw+Vos8Ml12UKdWDConJMoM6GI2KsSQYifbyzS1cJDllpf9uH/RB9uuvuXF/vjErHmErkc/FI0EcnSktAhTHJQ=
X-Received: by 2002:a63:79c2:: with SMTP id u185mr904600pgc.74.1641336965053;
 Tue, 04 Jan 2022 14:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com> <20211226143439.3985960-7-ruansy.fnst@fujitsu.com>
In-Reply-To: <20211226143439.3985960-7-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Jan 2022 14:55:54 -0800
Message-ID: <CAPcyv4jVDfpHb1DCW+NLXH2YBgLghCVy8o6wrc02CXx4g-Bv7Q@mail.gmail.com>
Subject: Re: [PATCH v9 06/10] fsdax: Introduce dax_lock_mapping_entry()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 26, 2021 at 6:35 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> The current dax_lock_page() locks dax entry by obtaining mapping and
> index in page.  To support 1-to-N RMAP in NVDIMM, we need a new function
> to lock a specific dax entry corresponding to this file's mapping,index.
> And output the page corresponding to the specific dax entry for caller
> use.

Is this necessary? The point of dax_lock_page() is to ensure that the
fs does not destroy the address_space, or remap the pfn while
memory_failure() is operating on the pfn. In the notify_failure case
control is handed to the fs so I expect it can make those guarantees
itself, no?
