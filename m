Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8384E68AF91
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 12:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBELmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 06:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBELma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:42:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58222007D;
        Sun,  5 Feb 2023 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oaSp1uDrEJSreK2BT15lm8D1/ywHnOELmkze9J1/9gs=; b=uHl/kG336RTMsqPHsblbXTQ2Z7
        N7KGy95S/8cHu6nmIqYAl1avvNVI8mS1yV0V4Vfhz+9MMF+GgwOa1N5sXrtr5VlqJnnQ8KtIeh6Gl
        C8dgU4wNjoG1CZkCLpvIakxfqaIKWavXC13nKWJqFeTENtN5r/490eaMim0kN3DCJA9If2qXKkgvd
        MZidgWXWOn1baMT8+mFy8pU4dqnFvWMX8c06sVQy26YM1P0TWiTyRwDGoidsqjvaIYnfHFoXeXJeS
        V6lTCQc1N8uhmT3bohmKWqGTo/NbpWaCnNA4ebDIwcZpbYRewkh9Z9RA7Wts1LRbGRZY2KRv/h/QU
        0SiYGRrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOdPa-00Fsbl-0T; Sun, 05 Feb 2023 11:42:22 +0000
Date:   Sun, 5 Feb 2023 11:42:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v9 1/3] xfs: fix the calculation of length and end
Message-ID: <Y9+WHXyA2GufLWpw@casper.infradead.org>
References: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1675522718-88-2-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675522718-88-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 04, 2023 at 02:58:36PM +0000, Shiyang Ruan wrote:
> @@ -222,8 +222,8 @@ xfs_dax_notify_failure(
>  		len -= ddev_start - offset;
>  		offset = 0;
>  	}
> -	if (offset + len > ddev_end)
> -		len -= ddev_end - offset;
> +	if (offset + len - 1 > ddev_end)
> +		len -= offset + len - 1 - ddev_end;

This _looks_ wrong.  Are you sure it shouldn't be:

		len = ddev_end - offset + 1;

