Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C2C40D2AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 06:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhIPEtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 00:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhIPEtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 00:49:23 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D222C061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 21:48:01 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQjJX-004aql-D1; Thu, 16 Sep 2021 04:47:59 +0000
Date:   Thu, 16 Sep 2021 04:47:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCHSET v3 0/3] Add ability to save/restore iov_iter state
Message-ID: <YULMf13OXvU70zV+@zeniv-ca.linux.org.uk>
References: <20210915162937.777002-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915162937.777002-1-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Jens, may I politely inquire why is struct io_rw playing
these games with overloading ->rw.addr, instead of simply having
struct io_buffer *kbuf in it?

	Another question: what the hell are the rules for
REQ_F_BUFFER_SELECT?  The first time around io_iov_buffer_select()
will
	* read iovec from ->rw.addr
	* replace iovec.iov_base with value derived from
->buf_index
	* cap iovec.iov_len with value derived from ->buf_index
Next time around it will use the same base *AND* replace the
length with the value used to cap the original.
	Is that deliberate?
