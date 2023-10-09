Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B167BEDF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378748AbjJIWC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 18:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378321AbjJIWC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:02:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8916F9E
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 15:02:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so3692686b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696888976; x=1697493776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbRz1UHmb7XUmCqoAt2aiODWlREyMNkavGrCa5bn36A=;
        b=MZMZEj7zdsBoJQlEqyQ7v1u73ywMatHnYxtzMTLOIChOW5Fj5hbsue8BCDnwZxtqcQ
         Kg+DivpcL9YfAptxhH8yBJ1QRQvqUx0k4LOax7iqK/dELisMRFbtBkUqtrtY47lZ+ofy
         DGm8KhkoYBL5jytjoP/T80KHYkA5DyDw0wbhfOBiZ74IUgR7mwfVq35XMRjYwhfdJeTb
         O0MlsmOH5kEpAoBcmicazdkPWXfIlXgrE+3XEi02pKf0KPAfCQ7//DufBBPsRP1ceV4x
         h9xi5Hslq6LovCeR5XflppE5Ctm7zCmejNMN3aBsgvGKiAd9KCHi9Q0hwBn+IFLL63fB
         Rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888976; x=1697493776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbRz1UHmb7XUmCqoAt2aiODWlREyMNkavGrCa5bn36A=;
        b=fiP+9q3qG6tuaudA3fIrD8DOsbhxlRMdqNs3cst/4XMWC5d/6Z1Qzk4/ClVMkzU0Fa
         A0ZrxyOT8ZeZ4Fi0WA/R7RenVAVrktW/JKLDjdYggI9IKZssJN+zjyheSoUFVu+9bLsm
         1wmL3k5SFTBsbkpPqjWPqGMqzAHvtPgNJhrA3vxPmzldl952zmycdKPDFyjUa5wmxIkJ
         SePnoGdn2DUnck6vxfIHmS+pZP0akNh4rg4GT8LtcSgtJ8GWKeuHe6zDtUNaFEcnmDj7
         /CC5QpwSMAv6M/vUwg8RmPDn5Duzuyi5QCI5GWwFOTxgLWcd5SRUTlUG7EHzq4+5VIZW
         I98g==
X-Gm-Message-State: AOJu0YzjiFy5DGLO0HGBHb57v1qh5V9Vu0acnh0IoeXVd3i7losqa9nt
        t2xMaSS1STvegngSuJIJ6XOY0Q==
X-Google-Smtp-Source: AGHT+IEpkt3G98AV4FGoCDMDB+5clUh7WiyyCdUTYHTZBvPKYhyU/1ce58WV9ik5NuXYhsQyrBkPyg==
X-Received: by 2002:a05:6a20:734b:b0:166:6582:a7d5 with SMTP id v11-20020a056a20734b00b001666582a7d5mr16692295pzc.3.1696888976074;
        Mon, 09 Oct 2023 15:02:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b00682868714fdsm7023146pfn.95.2023.10.09.15.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:02:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpyKz-00BhaC-06;
        Tue, 10 Oct 2023 09:02:53 +1100
Date:   Tue, 10 Oct 2023 09:02:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeremy Bongio <jbongio@google.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 04/21] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for
 atomic write support
Message-ID: <ZSR4jeSKlppLWjQy@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-5-john.g.garry@oracle.com>
 <CAOvQCn6zeHGiyfC_PH_Edop-JsMh1gUD8WL84R9oPanxOaxrsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvQCn6zeHGiyfC_PH_Edop-JsMh1gUD8WL84R9oPanxOaxrsA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 11:15:11AM -0700, Jeremy Bongio wrote:
> What is the advantage of using write flags instead of using an atomic
> open flag (O_ATOMIC)? With an open flag, write, writev, pwritev would
> all be supported for atomic writes. And this would potentially require
> less application changes to take advantage of atomic writes.

Atomic writes are not a property of the file or even the inode
itself, they are an attribute of the specific IO being issued by
the application.

Most applications that want atomic writes are using it as a
performance optimisation. They are likely already using DIO with
either AIO, pwritev2 or io_uring and so are already using the
interfaces that support per-IO attributes. Not every IO to every
file needs to be atomic, so a per-IO attribute makes a lot of sense
for these applications.

Add to that that implementing atomic IO semantics in the generic IO
paths (e.g. for buffered writes) is much more difficult. It's
not an unsolvable problem (especially now with high-order folio
support in the page cache), it's just way outside the scope of this
patchset.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
