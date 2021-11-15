Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27758451196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 20:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbhKOTKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243407AbhKOTIG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:08:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58532C06EDDD;
        Mon, 15 Nov 2021 09:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MkQmNnWorQXmyvdRrfkGhZFoHmndUW6YwurWpJlwk+M=; b=r4x2VN6R6qBR+zBOJ/yx5EQHd3
        V/u/BEExj7qrCqc9z/pZuu6OSMqbP/6DR1d1xqHewY5Sk7b10EYSAu/j4fcIXbTIQM4akT/sd38Vk
        YUMRjVxjdNb4KOU57MlNgMf6ghubwtAb+VazFz6lcdTTjcQrbrk12zDzl8+GDzAuYNM2IKx51GD43
        PxkMHnN8EScCcFoMxn8C3QEotSxG7K2Ep1S06w4xxZrr3F3DJw9Jp47bWjjLEKkgdqMH1WFWQ1YJt
        st6/s1vUxUrA5MGuinkDKzdBnHqEbZ7GXW1ZQHw5oLlyIgDsEhYv5yn1PhQ6Ic/wvmvhOx74KogLX
        hBVco44A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmgF5-00Gc7F-Up; Mon, 15 Nov 2021 17:58:07 +0000
Date:   Mon, 15 Nov 2021 09:58:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jubin Zhong <zhongjubin@huawei.com>
Cc:     viro@zeniv.linux.org.uk, wangfangpeng1@huawei.com,
        kechengsong@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix truncate never updates m/ctime
Message-ID: <YZKfr5ZIvNBmKDQI@infradead.org>
References: <1636974018-31285-1-git-send-email-zhongjubin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636974018-31285-1-git-send-email-zhongjubin@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 07:00:18PM +0800, Jubin Zhong wrote:
> From: zhongjubin <zhongjubin@huawei.com>
> 
> Syscall truncate() never updates m/ctime even if the file size is
> changed. However, this is incorrect according to man file:
> 
>   truncate (2):
>   If  the  size  changed, then the st_ctime and st_mtime fields
>   (respectively, time of last status change and time of last modification;
>   see stat(2)) for the file are updated, and the set-user-ID and
>   set-group-ID mode bits may be cleared.
> 
> Check file size before do_truncate() to fix this.

Please try to actually reproduce your alleged "bug".  And maybe also
look at the actual setattr implementations.  Hint: The XFS one even
has extensive comments.
