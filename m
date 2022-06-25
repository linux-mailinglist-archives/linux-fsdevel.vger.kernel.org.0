Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B184755AA51
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiFYNHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYNHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:07:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1861CFFD;
        Sat, 25 Jun 2022 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7u6xQCmDQPyPVMk+dsNlnkmpa5+oPFDuRd2hFSFH4Ok=; b=z12Js+i0dzj7rL8Nr5PC+Iqxhi
        NImcGYLW/4fBudL/nfCThERdDdWiPGrj+wOtI11u4CKR1DQIoIBT8+voxFUA0gng8killVhRf1KXC
        XVyU459RwiJJunYonuGtp3J3gMoVT3G7xoL0XMdcqxTbb98bIXBYOfOpq/Bw1pGA+hUxwFZ217xox
        ogAfsYirWfx4b1BCnB1gESszcJcy43KPuoj+z6HMNqvHCZG2D5reXFJuJPNRlP77dhqEPlxz6Wgbu
        xhzRnTO0h6s03m43frCGalkmvLzxrYphOlIAypVwSLceSCXBZ5L5jLCZ+xKj9R8W/3cp8iBJi5RWc
        rIV9bN2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o55Vp-0067SI-Vo; Sat, 25 Jun 2022 13:07:46 +0000
Date:   Sat, 25 Jun 2022 06:07:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] fs: clear or set FMODE_LSEEK based on llseek
 function
Message-ID: <YrcIoaluGx+2TzfM@infradead.org>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625110115.39956-4-Jason@zx2c4.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 25, 2022 at 01:01:10PM +0200, Jason A. Donenfeld wrote:
> This helps unify a longstanding wart where FMODE_LSEEK hasn't been
> uniformly unset when it should be.

I think we could just remove FMODE_LSEEK after the previous patch
as we can just check for the presence of a ->llseek method instead.
