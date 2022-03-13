Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690D84D7272
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 05:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiCMEfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 23:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMEfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 23:35:42 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F810CA;
        Sat, 12 Mar 2022 20:34:35 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTFw9-00AXen-6W; Sun, 13 Mar 2022 04:34:33 +0000
Date:   Sun, 13 Mar 2022 04:34:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Max Kellermann <max.kellermann@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] pipe_fs_i.h: add pipe_buf_init()
Message-ID: <Yi10WZi2TfyvClaG@zeniv-ca.linux.org.uk>
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
 <20220225185431.2617232-4-max.kellermann@gmail.com>
 <Yi1Y99MX7yxD2k6m@zeniv-ca.linux.org.uk>
 <Yi1bakVfs/l6CNE0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi1bakVfs/l6CNE0@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 13, 2022 at 02:48:10AM +0000, Matthew Wilcox wrote:

> That's not equivalent.  I think the better option here is to always
> initialise flags to 0 (and not have a parameter for it):
> 
> 			pipe_buf_init(buf, page, 0, 0, &anon_pipe_buf_ops);
> 			if (is_packetized(filp))
> 				buf->flags = PIPE_BUF_FLAG_PACKET;
> 			else
> 				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;

Not equivalent in which sense?  IDGI...  Your variant is basically

	X = 0;
	if (Y == constant)
		X = 1;
	else
		X = 2;

If gcc can optimize that to 

	X = (Y == constant) ? 1 : 2;

it should be able to do the same to
	X = 1;
	if (Y != constant)
		X = 2;

	What obstacles are there, besides a (false) assumption that
X might alias Y?  Which would apply to both variants...  Granted, I'm
half-asleep right now, so I might be missing something obvious...
