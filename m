Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5775274B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 01:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiENXdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 19:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiENXdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 19:33:04 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D604819C17
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 May 2022 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hCmQoewDGGP0FZ5+2bIz27jx7CnuoEVXktKo7tGR5u4=; b=WA3bPBRcoAEi4VG0bCgVZCDt5C
        QzFrVO5lG9AfzLHeWsPX/cAhPkAv8bA2yYDL2punqLT5Ub4Cc+fop3VswgdyiviJMq9L452qoDNwl
        g5B5mbAI9Vf5x1ay8dJsq2+Lb4CBJ/WExeN9RXBxFrVKMLXVaP6kWACNzs+RJKmbroPpvc/JkiTOI
        TZz0g+I06V9M8Ob95hHDdbCZcfK+ZTos7gp8yL4PKa4zTgiVGaMT+hgch5snGkAgmBq6HgYYmc6qb
        W1eWKN/EagckKHYxJjNFM940d3zki2Oo25tSwz79ujhAiW5bRXgqdN/OSiXBeskoHKoN5Sd+tCYSa
        uM2jIxnA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nq1Ft-00EzvL-40; Sat, 14 May 2022 23:33:01 +0000
Date:   Sat, 14 May 2022 23:33:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Todd Kjos <tkjos@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [RFC] unify the file-closing stuff in fs/file.c
Message-ID: <YoA8LSXfYTITfnKm@zeniv-ca.linux.org.uk>
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
 <20220513105218.6feck5rqd7igipj2@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513105218.6feck5rqd7igipj2@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 12:52:18PM +0200, Christian Brauner wrote:

> 	Context: Caller must hold files_lock.

Done and force-pushed to #work.fd
 
> Also, there's a bunch of regression tests I added in:
> 
> tools/testing/selftests/core/close_range_test.c
> 
> including various tests for issues reported by syzbot. Might be worth
> running to verify we didn't regress anything.

# PASSED: 7 / 7 tests passed.
# Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
