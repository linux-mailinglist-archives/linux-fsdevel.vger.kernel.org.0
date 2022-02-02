Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C664A712E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 14:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiBBNDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 08:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBBNDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:03:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4FFC061714;
        Wed,  2 Feb 2022 05:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uNf3Kf4hoy55VBNw3wt44AdzBNehHt9KaUoihC4mBrw=; b=W8q5WAMDiFJsaQjVwzcQNYhbFB
        TUhEzkTsfxRSEKGdxNARH2VlcVdcDdmFCApVXE9/uC4L1PKTd/4fDCVqDlGkYFs7klpelGPcvudIJ
        NEgSsM8r4n/YaIyXsDAGkOHaZ7tQwwjKTOvOR47fupgUC8GEiYmGWhp8TGEZeE1FNXpEMCCAMpnbN
        N2XuOsGW3/8gzyPMEyQ+qS/aLLq0rg7FtFaei4DUI040ACtXkXQbyPXYvgaC6aYcHjsue/OEJjwkc
        ie50CMyIAVekefGX5lBW/LEbynfRsGGMK7nXRLjyC6DZYwKaY2N50/9G4sf9VdU2OSOCoPYUH+Iao
        F+JpOpdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFFIV-00FIEL-Kt; Wed, 02 Feb 2022 13:03:43 +0000
Date:   Wed, 2 Feb 2022 05:03:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v10 1/9] dax: Introduce holder for dax_device
Message-ID: <YfqBLxjr5zz1TU91@infradead.org>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
 <20220127124058.1172422-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127124058.1172422-2-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:40:50PM +0800, Shiyang Ruan wrote:
> +void dax_register_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops)
> +{
> +	if (!dax_alive(dax_dev))
> +		return;
> +
> +	dax_dev->holder_data = holder;
> +	dax_dev->holder_ops = ops;

This needs to return an error if there is another holder already.  And
some kind of locking to prevent concurrent registrations.

Also please add kerneldoc comments for the new exported functions.

> +void *dax_get_holder(struct dax_device *dax_dev)
> +{
> +	if (!dax_alive(dax_dev))
> +		return NULL;
> +
> +	return dax_dev->holder_data;
> +}
> +EXPORT_SYMBOL_GPL(dax_get_holder);

get tends to imply getting a reference.  Maybe just dax_holder()?
That being said I can't see where we'd even want to use the holder
outside of this file.
