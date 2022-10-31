Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E56138F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 15:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiJaO2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 10:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiJaO2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:28:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2083FDFF8
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ij49W4+dw/YR9hMaCEKWyvPrm0Y/PTlYocnpMTqRJug=; b=AyYD0WrOSkjxXxPRhmovt0fX+U
        0rClPkvVrRX4COeIMD0vmThia3JrMyJDllaxFb0HHz2etEZj/K0DhDxGrsD7/6OegVHXYYkupFa8q
        gN+H4+i/5DRze5VQEFV8xS243et/OYlnC3jfRpsa/OToFMpfV5aLZ16Q/4eDysnjR5UZT+WrhMrU5
        fZSaqkiwG3LYFQu6kmbQpVa8Qu6iNnFedlKNHvdcfgfYRzhcwXfHuqvjcPfjpGceEQfvPrnWt55uo
        9/qtIRqx4g4vFtUco6kgNpJyfRD2Wi+pky7a/vldBfQ6V1zTQ8MLjx+ZpOZoWGOUOXD1Q78LiA+9E
        AO4EZBlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opVlo-003k8n-Pz; Mon, 31 Oct 2022 14:28:08 +0000
Date:   Mon, 31 Oct 2022 14:28:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: fix undefined behavior in bit shift for SB_NOUSER
Message-ID: <Y1/beLrf1gr3/b2u@casper.infradead.org>
References: <20221031142621.194389-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031142621.194389-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:26:21PM +0800, Gaosheng Cui wrote:
> Shifting signed 32-bit value by 31 bits is undefined, so changing most
> significant bit to unsigned, and mark all of the flags as unsigned so
> that we don't mix types. The UBSAN warning calltrace like below:
> 
> UBSAN: shift-out-of-bounds in fs/namespace.c:2330:33
> left shift of 1 by 31 places cannot be represented in type 'int'
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x7d/0xa5
>  dump_stack+0x15/0x1b
>  ubsan_epilogue+0xe/0x4e
>  __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
>  graft_tree+0x36/0xf0
>  do_add_mount+0x98/0x100
>  path_mount+0xbd6/0xd50
>  init_mount+0x6a/0xa3
>  devtmpfs_setup+0x47/0x7e
>  devtmpfsd+0x1a/0x50
>  kthread+0x126/0x160
>  ret_from_fork+0x1f/0x30
>  </TASK>
> 
> Fixes: e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
