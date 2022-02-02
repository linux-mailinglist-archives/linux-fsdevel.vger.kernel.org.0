Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B04A7172
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbiBBNXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 08:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiBBNXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:23:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB0AC061714;
        Wed,  2 Feb 2022 05:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=az6kboJE3mFyY36gmE38vP7/KWYCb2+HOse48wBjN30=; b=kJ/lrRzjPlsjblsRRL2zqRYXJB
        +oU2VHVwqN3s2KJH9a4X4NkDQjetDteWEZXyAslmjd90P8P4LYaFstb8kKiMToioWHNtNZ9eqUaD7
        l7ArUEF8GoI8guGIGipA/UBL74ymUHgzKQnnfTHqGz0Jq6F9n6cB+QJ7h96vlMItODbuAlej2wUIv
        R8pSsqGLZYwb7h225s7k3bYekjlD2Daf0fwexVewXd2RhTU+1zlXChBTNJa7ydZ39h7shA2wpSINL
        Lk4zIQkP0fSBw3S4uXEe2cCPWnyiSyq2ZjAE5YJUOsdoBTTxyxNVdDg3tUaQP4iYF7uSblobm0FED
        6KTciqLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFFbF-00FLX5-Ie; Wed, 02 Feb 2022 13:23:05 +0000
Date:   Wed, 2 Feb 2022 05:23:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
Message-ID: <YfqFuUsvuUUUWKfu@infradead.org>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128213150.1333552-3-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:31:45PM -0700, Jane Chu wrote:
> +int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr)
> +{
> +	if (dax_recovery_capable(dax_dev)) {
> +		set_bit(DAXDEV_RECOVERY, (unsigned long *)kaddr);
> +		return 0;
> +	}
> +	return -EINVAL;

Setting a random bit on a passed in memory address looks a little
dangerous to me.

Also I'd return early for the EINVAL case to make the flow a little
more clear.
