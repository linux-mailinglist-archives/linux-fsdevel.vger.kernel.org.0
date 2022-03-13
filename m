Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06074D722E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 03:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiCMCiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 21:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiCMCiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 21:38:52 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74135278;
        Sat, 12 Mar 2022 18:37:45 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTE75-00AVXc-Tm; Sun, 13 Mar 2022 02:37:43 +0000
Date:   Sun, 13 Mar 2022 02:37:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Kellermann <max.kellermann@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] pipe_fs_i.h: add pipe_buf_init()
Message-ID: <Yi1Y99MX7yxD2k6m@zeniv-ca.linux.org.uk>
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
 <20220225185431.2617232-4-max.kellermann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225185431.2617232-4-max.kellermann@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:54:31PM +0100, Max Kellermann wrote:

>  			/* Insert it into the buffer array */
>  			buf = &pipe->bufs[head & mask];
> -			buf->page = page;
> -			buf->ops = &anon_pipe_buf_ops;
> -			buf->offset = 0;
> -			buf->len = 0;
> -			if (is_packetized(filp))
> -				buf->flags = PIPE_BUF_FLAG_PACKET;
> -			else
> -				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
> +			pipe_buf_init(buf, page, 0, 0,
> +				      &anon_pipe_buf_ops,
> +				      is_packetized(filp) ? PIPE_BUF_FLAG_PACKET : PIPE_BUF_FLAG_CAN_MERGE);

*cringe*
FWIW, packetized case is very rare, so how about turning that into
			pipe_buf_init(buf, page, 0, 0,
				      &anon_pipe_buf_ops,
				      PIPE_BUF_FLAG_CAN_MERGE);
			if (unlikely(is_packetized(filp)))
				buf->flags = PIPE_BUF_FLAG_PACKET;
Your pipe_buf_init() is inlined, so it shouldn't be worse from the optimizer
POV - it should be able to start with calculating that value and then storing
that, etc.
