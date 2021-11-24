Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE1545B316
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 05:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhKXE1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 23:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhKXE1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 23:27:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC426C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 20:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rb3Kpyd2YBsGfOg22Yvh86fEzaEHWDKx9UmYRlAHfSA=; b=oiOnpw1mu00N/PZX60L/kuEChu
        0ScvhPoQ+eKgj8sahtj4kPl3xHG2ddfLsMloX7Mh7QElZehjpxc6ICVlkUokzMkK6KZjwKzdORL/w
        CxX716pOw7Uqrqa21cvyVzDSL6TJU1XvpDjFiGiXL5P2lcWdA3PAiHpB1ifinoRSaQYNU1W69cy4E
        BlJtUFrXc518d3EVz2eL5HuVTQVVRvZ9YXvrJahurpt2QxUVrESEQAdL2XLyBewfnULoWTDySnxlT
        FZ/iAIL80pUeThi4ULfji83hTccFoTlnzuV2Va05A3WXxjw0BWw6jBpnnOBpOoKigCAOeTRHMjLkZ
        nS4V9/ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpjpZ-0009tK-AD; Wed, 24 Nov 2021 04:24:25 +0000
Date:   Wed, 24 Nov 2021 04:24:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] hugetlbfs: avoid overflow in hugetlbfs_fallocate
Message-ID: <YZ2+ecB1dDOdY+gp@casper.infradead.org>
References: <20211124040818.2219374-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124040818.2219374-1-yangerkun@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:08:18PM +0800, yangerkun wrote:
>  	start = offset >> hpage_shift;
> -	end = (offset + len + hpage_size - 1) >> hpage_shift;
> +	end = ((unsigned long long)offset + len + hpage_size - 1)
> +		>> hpage_shift;

+	end = DIV_ROUND_UP_ULL(offset + len, hpage_size);
