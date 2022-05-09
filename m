Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276C51F511
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 09:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiEIHDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 03:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiEIGuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 02:50:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAAA15352F;
        Sun,  8 May 2022 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NXqU/aWXlEJRQ0qJPG0UDAA6ajCwUtVVCzntAHnRaiA=; b=A8UyI3dyR0UMChql8GiSRtDrdG
        NhJfAe8bZH5q0+JtAhELL8B6mM1KMBMh03KRjiYG5iWh35ecaxA6qSZP3pTY6niEKlwyBnya+MRXu
        OUcmmFXOWKfCfS5i5npygLP/dSdE18dckI+xdIpn3rTI/IYtG26eLZDQV83aXUe75HcLkeDy0UVTj
        J6OfGdbhAtTdw9BhztJGloZTOnWLDblt/Sflv6pSpQyHZhHsiAjq22JQnfVXrj7V/KV3WDFZGeGEN
        YkVyvD5JYbkNfqoVw+2qJcYI6KWi9izviBWZG2wlla30ZffNX9zqiIqSurWHjxvL6BuZ5PFkyFsrq
        7ImMYZqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnxAQ-00CkUE-D3; Mon, 09 May 2022 06:46:50 +0000
Date:   Sun, 8 May 2022 23:46:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jing Xia <jing.xia@unisoc.com>
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz, jing.xia.mail@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: Avoid skipping inode writeback
Message-ID: <Yni42sWLMFITtfmz@infradead.org>
References: <20220505134731.5295-1-jing.xia@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505134731.5295-1-jing.xia@unisoc.com>
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

On Thu, May 05, 2022 at 09:47:31PM +0800, Jing Xia wrote:
>  	if (!(inode->i_state & I_DIRTY_ALL))
>  		inode_cgwb_move_to_attached(inode, wb);
> +	else if (!(inode->i_state & I_SYNC_QUEUED) && (inode->i_state & I_DIRTY))

Please turn this into

	else if ((inode->i_state & I_DIRTY) &&
	         !(inode->i_state & I_SYNC_QUEUED))

to keep it a little more readable.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
