Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274374EBE74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 12:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbiC3KPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245234AbiC3KPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842C3A5C4;
        Wed, 30 Mar 2022 03:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Agj8zzqvWDpZMOBEEasMzSNfdr1gbrYwMIOAO4LamnI=; b=J1iPv3ZhgUKOquThe2zFhWa0mI
        llIxIKvuAlGogtQY7vnhQNxlFPGw5+bJmgRTsvhvVY9mEsgccHsSxCgxG/KEfmJce7AOCxD4K8Exj
        6kuuBQG9Vmd677+eRtKWzL7lxsm/BUAVy5TLvhjgNUwWD/OJJwZsSVkVkvtreQb502vp/EEi1s2M6
        NFxa5560Tf7Px3KaBClsWI3kzPxxI8mg6BfUY4KMZtYDC1WqQWZChQE1IU3L621fCEbnmNusYLn6O
        ic2aNhKBzSwNA/vY+vElPib2Cj9VgGe3HRjtK6gSH2MAiVwbn6OoSbXgapUMIKTkkBDQssa/py8Dd
        3C47CEBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZVKC-00F9X8-Rh; Wed, 30 Mar 2022 10:13:12 +0000
Date:   Wed, 30 Mar 2022 03:13:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
Message-ID: <YkQtOO/Z3SZ2Pksg@infradead.org>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
 <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
 <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com>
 <YkPtptNljNcJc1g/@infradead.org>
 <15a635d6-2069-2af5-15f8-1c0513487a2f@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a635d6-2069-2af5-15f8-1c0513487a2f@fujitsu.com>
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

On Wed, Mar 30, 2022 at 06:03:01PM +0800, Shiyang Ruan wrote:
> 
> Because I am not sure if the offset between each layer is page aligned.  For
> example, when pmem dirver handles ->memory_failure(), it should subtract its
> ->data_offset when it calls dax_holder_notify_failure().

If they aren't, none of the DAX machinery would work.
