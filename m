Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B228814A458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgA0NAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 08:00:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33221 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgA0NAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:00:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so6132617lfl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZJNzprftu5dcU/szZB/Ubowobleex8rerW+4xWJyt/M=;
        b=VoO+O8oliDEu27wte/68JQesstuhw1JLi9F499LFmln4kg2fnU80g+Hy939slqwayM
         6X4kQsHF3iGoWNUylpAMzFOkSDlcyP5/xyc0nU7I/ZTTBqifEIlQVkwwEbO747yLu+pJ
         1djgkjWksVX3uhDMrT2nQ3tRFxpQRSNk75/8zCqkaGcvS3EmE66VBYCGeeGKoS8z8VJT
         mKJuWPfApbN4BycDPeyoUqzdZk5e0nyZKMhHLxkO4pkhpTozPbRLOhmheKxVubOO/98R
         Nq34lzm5O1uV00jxqCWfyoHMsxuubjaSAkl9vEG10D5/2xyp98i8Xb+VDazvAENA75Qi
         OF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZJNzprftu5dcU/szZB/Ubowobleex8rerW+4xWJyt/M=;
        b=E9QMPkSXY6zearTUF833JuUqVAXTTla6W1zNYVy5WjDJQH643wsWu81igvfeKjugwc
         2TdBKSYPt84SERoP3ec0X6nqPgVQO0bWgL8mWcp0Jlb+btQw3fRDrNrJROaiz2HuloZY
         LSqBUWs4JB+zIJxxj+Ru08E2lrtXMc7cvNg1xi3qkbnpFSWSu9KhoX0AMV3dr5H4c4yX
         1/550JpG7Le5xWARnX/PorqJ3Tlb/kZjPa8es/EIuxbzPQuuiS+M9aGYrOaIboShJrCB
         nrqSunecV9E0Fwu10AylXoMmneGY8VQTetSBb/eVO/71BvortejiS1HNTVLNxTO/PT5t
         Nw5w==
X-Gm-Message-State: APjAAAWaIx25EQrT59okxK5ywQB8NksBNWJSOmPN8qFfuh76SIXKudOj
        t5obtIPvFo2Lsb/fEVFTb3ZZGw==
X-Google-Smtp-Source: APXvYqysAoofMf7LQ5awnT1fddVOicFrSd53w1Fmy5Kunrv9ngQonmVjbMl/JL3C6VYXCdPDTAql6w==
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr7959464lfn.95.1580130014394;
        Mon, 27 Jan 2020 05:00:14 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b4sm8138667lfo.48.2020.01.27.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:00:13 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5ED20100AD0; Mon, 27 Jan 2020 16:00:20 +0300 (+03)
Date:   Mon, 27 Jan 2020 16:00:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/3] mm/gup: track FOLL_PIN pages
Message-ID: <20200127130020.4p56lh32twui5563@box>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
 <20200125021115.731629-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125021115.731629-2-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 06:11:13PM -0800, John Hubbard wrote:
>  12 files changed, 577 insertions(+), 171 deletions(-)

Can we get it split? There's too much going on to give meaningful review.

-- 
 Kirill A. Shutemov
