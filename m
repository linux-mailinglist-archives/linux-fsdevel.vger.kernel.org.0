Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1668180B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 18:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjA3Ryq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 12:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjA3Ryp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:54:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A59B444;
        Mon, 30 Jan 2023 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1okjyKF2ix7j6bdWf0qg2w/0HuZ/ds03N9/CsqxSESI=; b=NAt8AAsNlBGY3eO9dlBHXrOWkA
        BM7mVrO8ZW7Tfrmqkr0ia0QhTAKVScABx3c+Df0KGO0YVCfTM0/5rqs7L+lnFYWIKWSFR8fApO95+
        /HPjzSODuMFaX6E0V2OSH3TKHNpS5fQlw1I9Wu36XEJSgIst1K4wWInPU7bSJUA1f2PaY0IKIogOC
        tOCHVtmlUh3CGlyoUoy+cVt8Ojtb9RDC5qMIktstA++K0IIAzFykCS76RE+/3iTM2lR/kELhoKkfu
        xeDso91XIGxeSNvVwed+7Ue5g4jfJc8J2WSFNSflhO7RSOwF5Q7hDlf4/pEflEeNcT+5FlGS5ObCG
        18KGywbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMYMb-00AZ23-Lv; Mon, 30 Jan 2023 17:54:41 +0000
Date:   Mon, 30 Jan 2023 17:54:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <Y9gEYUVuK24IpLMt@casper.infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 09:44:13PM +0530, Ritesh Harjani (IBM) wrote:
> On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
> filesystem blocksize, this patch should improve the performance by doing
> only the subpage dirty data write.
> 
> This should also reduce the write amplification since we can now track
> subpage dirty status within state bitmaps. Earlier we had to
> write the entire 64k page even if only a part of it (e.g. 4k) was
> updated.
> 
> Performance testing of below fio workload reveals ~16x performance
> improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> 
> <test_randwrite.fio>
> [global]
> 	ioengine=psync
> 	rw=randwrite
> 	overwrite=1
> 	pre_read=1
> 	direct=0
> 	bs=4k
> 	size=1G
> 	dir=./
> 	numjobs=8
> 	fdatasync=1
> 	runtime=60
> 	iodepth=64
> 	group_reporting=1
> 
> [fio-run]

You really need to include this sentence from the cover letter in this
patch:

2. Also our internal performance team reported that this patch improves there
   database workload performance by around ~83% (with XFS on Power)

because that's far more meaningful than "Look, I cooked up an artificial
workload where this makes a difference".
