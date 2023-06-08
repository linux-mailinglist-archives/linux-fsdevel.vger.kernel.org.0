Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985937281CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjFHNu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjFHNu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:50:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFFD2712;
        Thu,  8 Jun 2023 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tLQcIVXA+VmehMcxl7Km6RiwNw3579Xc64jVW8S5msc=; b=BoC3xuaI1K/kcDCaD+X3Wra+I9
        fDFiyM9Xnbc6Yumvw7mIdG6RCPr18S81lj+cK15TqjSavm7V24mtrpRqAKQsbMtsIgHZeVWVwmZsd
        Xy2URyEtny5mJrSiGr3xtD1sxiDEyZfzSqEeyUIxWbJEEFsJ5Iedd4CJDizylplWpKBq4W0llu27B
        sj3rRzEwcUlyShAE8CGbuyZWnpdP3IBZyHPtl7cq+HRoyGVARVF5hn3lM+kwRq0loCyOfQyPqwPH4
        082bhClvLqmJGmCG59pbCuKWH64CJY/6IpgrPc+A+GBc1A0XWXWOZpS3PYzkizsvXg4Oc/SMqBSkt
        eVgNAbbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7G2K-009WGF-2v;
        Thu, 08 Jun 2023 13:50:48 +0000
Date:   Thu, 8 Jun 2023 06:50:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, willy@infradead.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, corbet@lwn.net, jake@lwn.net
Subject: Re: [RFC 4/4] bdev: extend bdev inode with it's own super_block
Message-ID: <ZIHcuOLaGvI+vdKo@infradead.org>
References: <20230608032404.1887046-1-mcgrof@kernel.org>
 <20230608032404.1887046-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608032404.1887046-5-mcgrof@kernel.org>
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

On Wed, Jun 07, 2023 at 08:24:04PM -0700, Luis Chamberlain wrote:
> each block device corresponds to one inode on that super_block. This
> implicates sharing one aops operation though,

No, it does not.
