Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC904EBA70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 07:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243052AbiC3Fx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 01:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiC3FxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:53:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE2193D3;
        Tue, 29 Mar 2022 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yCZ5d17EFD2aEB3EGnA7ZMwaYGzMjCaqvwamMb8/d/A=; b=FATsTjusksvtlMN1pOJstU1ijI
        IMnbWlp05UKcwa3gWEEqTw6N8GcV5QSf6C1y/3IqRg5rAxSuHtGDN19cfAmfLDTqTHXhVqoa51SPr
        p1X8tLumGNCsMQaxn9Mz5I3Akb7d4fs8GLRIrTjiUWcYH6FQTO4kK+0LMJuxRQj63nI/fJB8uR3hN
        z/j4J39qan+FX7gHBjxu6JEBpIbAzspjMkOE9bFCMTYA9Xl8fnJrkGdNbWYw2IFRd5EUbDItvuZhK
        0jbOcmIegmH+WknmWMSTnY4jhygaaKjh65GyKkfllEuIZPk6hetptPV+FmBF21A/G91xtA0uQAblX
        f6EVCdYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZRF4-00ENLP-Ne; Wed, 30 Mar 2022 05:51:38 +0000
Date:   Tue, 29 Mar 2022 22:51:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v11 6/8] mm: Introduce mf_dax_kill_procs() for fsdax case
Message-ID: <YkPv6ntRlQxDdvBn@infradead.org>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227120747.711169-7-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 27, 2022 at 08:07:45PM +0800, Shiyang Ruan wrote:
> This function is called at the end of RMAP routine, i.e. filesystem
> recovery function, to collect and kill processes using a shared page of
> DAX file.

I think just throwing RMAP inhere is rather confusing.

> The difference with mf_generic_kill_procs() is, it accepts
> file's (mapping,offset) instead of struct page because different files'
> mappings and offsets may share the same page in fsdax mode.
> It will be called when filesystem's RMAP results are found.

So maybe I'd word the whole log as something like:

This new function is a variant of mf_generic_kill_procs that accepts
a file, offset pair instead o a struct to support multiple files sharing
a DAX mapping.  It is intended to be called by the file systems as
part of the memory_failure handler after the file system performed
a reverse mapping from the storage address to the file and file offset.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> index 9b1d56c5c224..0420189e4788 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3195,6 +3195,10 @@ enum mf_flags {
>  	MF_SOFT_OFFLINE = 1 << 3,
>  	MF_UNPOISON = 1 << 4,
>  };
> +#if IS_ENABLED(CONFIG_FS_DAX)
> +int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> +		      unsigned long count, int mf_flags);
> +#endif /* CONFIG_FS_DAX */

No need for the ifdef here, having the stable declaration around is
just fine.

> +#if IS_ENABLED(CONFIG_FS_DAX)

No need for the IS_ENABLED as CONFIG_FS_DAX can't be modular.
A good old #ifdef will do it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
