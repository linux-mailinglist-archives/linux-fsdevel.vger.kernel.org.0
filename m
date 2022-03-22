Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DFF4E3AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiCVIpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 04:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiCVIpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:45:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49F22AE3B;
        Tue, 22 Mar 2022 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QAMnkCbPUARhn8PReqsuR28ofrVR9sa+6IKI9MA59uc=; b=YYeEAtVT0hh7A0ZXZQf1G7Cmvm
        kigmRFo8HKuqBMYwA3Pgh7PbkRRCntyglV30cb1JjhwP6+IyYU+qCgliuVyXnT8Q1Y2HNicRqK2u7
        k4TcBXLdR+3l3Iy+EM0cfVbYOgUbpcVIlMIc8aLtK/HpGgB1aaZoqrooGTbw97vl4rehTa8X7PWbZ
        PZ13nq9X6pfiy+HThwMfgTE/5YiMX3RfulLBRxnJ4AeCy3yYSnGW248GMzg9Kkcv70zjj1cWfOlaN
        V+S8qt2mRg4M2b+Y5/66GG64uUPj6NkgM/HhLTDsCaqhdkl4RnhFfTm8eX0GlgmWry4cLaAy1BmK+
        kjn9ABQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWa7e-00ASlo-Ri; Tue, 22 Mar 2022 08:44:10 +0000
Date:   Tue, 22 Mar 2022 01:44:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 3/6] mce: fix set_mce_nospec to always unmap the whole
 page
Message-ID: <YjmMWvDRUHE08T+a@infradead.org>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-4-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319062833.3136528-4-jane.chu@oracle.com>
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

On Sat, Mar 19, 2022 at 12:28:30AM -0600, Jane Chu wrote:
> Mark poisoned page as not present, and to reverse the 'np' effect,
> restate the _PAGE_PRESENT bit. Please refer to discussions here for
> reason behind the decision.
> https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/

I think it would be good to summarize the conclusion here instead of
just linking to it.

> +static int _set_memory_present(unsigned long addr, int numpages)
> +{
> +	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
> +}

What is the point of this trivial helper with a single caller?

