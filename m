Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AFE75FC5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGXQkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGXQkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:40:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AF81981;
        Mon, 24 Jul 2023 09:40:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B5B967373; Mon, 24 Jul 2023 18:40:18 +0200 (CEST)
Date:   Mon, 24 Jul 2023 18:40:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, hch@lst.de,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/read_write: Enable copy_file_range for block device.
Message-ID: <20230724164017.GC26430@lst.de>
References: <CGME20230724060655epcas5p24f21ce77480885c746b9b86d27585492@epcas5p2.samsung.com> <20230724060336.8939-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724060336.8939-1-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  {
> -	struct inode *inode_in = file_inode(file_in);
> -	struct inode *inode_out = file_inode(file_out);
> +	struct inode *inode_in = file_in->f_mapping->host;
> +	struct inode *inode_out = file_out->f_mapping->host;

This doesn't directly have anything to do with block devices, as regular
files can also have a f_mapping that's different.  None of the file
systems actually supporting copy offload right now do, but changing
the dereference here is a correctness thing totally independent of
block device support.
