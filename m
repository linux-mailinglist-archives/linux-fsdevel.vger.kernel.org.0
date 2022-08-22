Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8250C59C1D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 16:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiHVOqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiHVOpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:45:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97882248C2;
        Mon, 22 Aug 2022 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x9nBUo0+hZpdGfurRQeuyioQwpYpr7z6L1SJHhD4mc0=; b=srfxE/Q6nHF+9wd/VdS0IGeBqk
        kf2royYp/fC6OyojYMvfqw8KVCd2y2ud1/MytJk1LfII+B1JXMgEsLbOtJAH2Qx7kdmcwytRDwhad
        5DaqW4FqdAmCuqWK4x7aEb7eCfZn2Ki9VSP2o9lgDZ9M92V9cdJx5ySmGrnI5VjRZ/3eE7/Gx4Uq5
        9BPikQCIB35OtKoIZvkJdpjcsQifNaRqMycBMQ5BDX4IfY+YW28krSeF/amGzTnMuKHBs2+o++7gI
        pyBoej4IqhLuCmY/8HwCEkgp0G6MtY5GaTyCsz4Lh4jwWQWFocaZPJnLT+EMuLxxzewm1fNg8LYtq
        4kRO/eSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ8gD-00EMmb-0K; Mon, 22 Aug 2022 14:45:29 +0000
Date:   Mon, 22 Aug 2022 15:45:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     david@fromorbit.com, djwong@kernel.org, fgheet255t@gmail.com,
        hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in iomap_iter
Message-ID: <YwOWiDKhVxm7m0fa@casper.infradead.org>
References: <182c028abf0.2dc6f7c973088.2963173753499991828@siddh.me>
 <20220821114816.24193-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821114816.24193-1-code@siddh.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 21, 2022 at 05:18:16PM +0530, Siddh Raman Pant wrote:
> @@ -979,9 +979,15 @@ loop_set_status_from_info(struct loop_device *lo,
>  
>  	lo->lo_offset = info->lo_offset;
>  	lo->lo_sizelimit = info->lo_sizelimit;
> +	lo->lo_flags = info->lo_flags;
> +
> +	/* loff_t/int vars are assigned __u64/__u32 vars (respectively) */
> +	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0 || lo->lo_flags < 0)
> +		return -EOVERFLOW;

Why would you check lo_flags?  That really, really should be an unsigned
type.
