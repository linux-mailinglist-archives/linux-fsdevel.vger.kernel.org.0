Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D961C0CF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 05:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEAD6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 23:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgEAD6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 23:58:22 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B2C035494;
        Thu, 30 Apr 2020 20:58:22 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUMoe-00FaSo-R2; Fri, 01 May 2020 03:58:21 +0000
Date:   Fri, 1 May 2020 04:58:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
Message-ID: <20200501035820.GH23230@ZenIV.linux.org.uk>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
> also check for IOCB_NOWAIT for whether or not we should handle this read
> or write in a non-blocking fashion. If we don't, then we will block on
> data or space for iocbs that explicitly asked for non-blocking
> operation. This messes up callers that explicitly ask for non-blocking
> operations.

Why does io_uring allow setting IOCB_NOWAIT without FMODE_NOWAIT, anyway?
