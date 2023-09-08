Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491917983ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbjIHIWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjIHIWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:22:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77EF1BDA;
        Fri,  8 Sep 2023 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6D470cIvCGiPdXU/MnoROZejPxD2v9P20lFztg+Jwq0=; b=matuwfW8dn31iALbrcQUfwHKmQ
        ofRmFp2j8cU+9E8L6S0FJlFRqUDjYfAp7CEiRgGXCdxYyKk++82wEu/qGJ+ZS80/8OrgxnKQYc7ZI
        6eCMFjzC8/QELDt6mPdK5yaRS+4/bTZ/hvktWfYzcLt5vnTPiPhEokGlj/O1h/DOc3lbPnUOJ2w4S
        pOL3/vwPka8Jl+JGdZTkvixyZXVmgoeEPa2vomSP6k+guVN/5/ORjA9jHMbqmkpPvXxSg0cvd0ArY
        HYrOfISvkJANWVFq3B/GRAnuI7Vq2SwlPBF2W0ECtpyYOhLkRJiKOBZaEJvbx52vsGogzYXZ+bZSd
        qS940VGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qeWkh-00DJNE-2U;
        Fri, 08 Sep 2023 08:22:07 +0000
Date:   Fri, 8 Sep 2023 01:22:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-btrfs@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: file_remove_privs needs an exclusive lock
Message-ID: <ZPrZr4PEwnyYCPpC@infradead.org>
References: <20230906155903.3287672-1-bschubert@ddn.com>
 <20230906155903.3287672-2-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906155903.3287672-2-bschubert@ddn.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:59:03PM +0200, Bernd Schubert wrote:
> file_remove_privs might call into notify_change(), which
> requires to hold an exclusive lock.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

FYI, I'd be really curious about benchmarking this against you version
that checks xattrs for shared locked writes on files that have xattrs
but not security ones or setuid bits.  On the one hand being able to
do the shared lock sounds nice, on the other hand even just looking up
the xattrs will probably make it slower at least for smaller I/O.
