Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDFB3D1C64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhGVCox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 22:44:53 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:49966 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhGVCox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:44:53 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6PIp-002m8c-Fl; Thu, 22 Jul 2021 03:23:15 +0000
Date:   Thu, 22 Jul 2021 03:23:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC] what exactly prevents io_iopoll_try_reap_events() triggering
 io_queue_async_work()?
Message-ID: <YPjkoxhLBGulYVXz@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	I really hope that we can't hit io_iopoll_try_reap_events() ->
io_do_iopoll() -> io_iopoll_complete() -> io_queue_async_work() call
chain (if we _can_, there's a lot of nasty stuff possible), but I don't
see any robust proof that it'll never happen.

	Sure, there's that percpu_ref_is_dying(&ctx->refs) test in
io_rw_should_reissue(), but what's to guarantee that it had been
called after the matching percpu_ref_kill(&ctx->refs)?  For that
matter, what about the call from io_uring_cancel_generic() <-
__io_uring_cancel() <- io_uring_files_cancel() <- do_exit()?

	What am I missing here?
