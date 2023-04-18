Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233656E584D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 07:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjDRFEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 01:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRFEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:04:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E43ABB;
        Mon, 17 Apr 2023 22:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PoZWwBJh/5v/77nDYw227V6Aepk7GaCrd18vWQ3CjIg=; b=mVHdhVSKgrVP1Evl6IttJlJXfl
        QHeDz68AivEcadg64Uj+ZnmA0OlfdUzxBcMlvMfvXdwOLiRJyf0xwnlPD4J4wRcn97BeiqzYpfhnT
        QVe43UEW//k94PFt40OBb4+mpVEAGl98xqGYbGkd0fvJDsEprXmi3p0o9ERz4/V65aIuG7znHW5Lc
        Uy2mXkNPqkw2EWSrMHZy9V5mvbVfysLu5wBxKkOGECqpzgqBsxgq/AALQxnzv5DwOvlNIy8UUeFYX
        nUecoM/c+0ZdGgj+hCBG087IzTmIIj5oCi5tQSK6II/8BLtRdyO9fYY/kGQAI3H6CjOpk9K0F2T19
        ffGIlSOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1podW1-000rNN-0H;
        Tue, 18 Apr 2023 05:04:29 +0000
Date:   Mon, 17 Apr 2023 22:04:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv5 2/9] fs/buffer.c: Add generic_buffer_fsync
 implementation
Message-ID: <ZD4k3Sp7wDQu4wkU@infradead.org>
References: <20230417110149.mhrksh4owqkfw5pa@quack3>
 <87o7nmivqm.fsf@doe.com>
 <20230417164550.yw6p4ddruutxqqax@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417164550.yw6p4ddruutxqqax@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 06:45:50PM +0200, Jan Kara wrote:
> Hum, I think the difference sync vs fsync is too subtle and non-obvious.

Agreed.

> I can see sensible pairs like:
> 
> 	__generic_buffers_fsync() - "__" indicates you should know what you
> 				are doing when calling this
> 	generic_buffers_fsync()
> 
> or
> 
> 	generic_buffers_fsync()
> 	generic_file_fsync() - difficult at this point as there's name
> 			       clash
> 
> or
> 
> 	generic_buffers_fsync_noflush()
> 	generic_buffers_fsync() - obvious what the default "safe" choice
> 				  is.
> 
> or something like that.

I'd prefer the last option as the most explicit one.
