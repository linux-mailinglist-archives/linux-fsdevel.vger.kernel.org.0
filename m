Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542323E2B5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 15:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbhHFN3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 09:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243990AbhHFN3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:29:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE595C061798;
        Fri,  6 Aug 2021 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PHNxu6/Kl0DC7lcu+1Gt0L58EXa9kH4/ZVb+vNkOLVA=; b=l9yljubBx1fxZLnpIoEV7PXJhb
        QD4vjiNzw/vf1GMDlcI7LzoYLaHKy/mv/6fcaxP3cuPRO5s3C2SbpuxvNPqPJ0BKFGu1JUWA9BY0w
        eQ+vYyEG0yWvN9gYG+ot6hXXi6BzG82FEc4EqzcCdOWNmzv0VzVsPmGWaW+E1pca4VLmBttuxip90
        PyfoGe0+CNNDovkvjOizic1ZGd4dkNF2epriubUCPfi9Ht9eYM72HrN/jKGbEJ3mgGhdPGz1wMbJM
        faJYoaGie2E5PQviFh9G9h0i/aobouqpKnVi4D+cf+fngqbAwfRbGE0GMKh2ykM/w01cJ/dlVY2N0
        MafUlmEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBztl-008Dkf-0i; Fri, 06 Aug 2021 13:28:44 +0000
Date:   Fri, 6 Aug 2021 14:28:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: optimise generic_write_check_limits()
Message-ID: <YQ04/NFn8b6cykPQ@casper.infradead.org>
References: <dc92d8ac746eaa95e5c22ca5e366b824c210a3f4.1628248828.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc92d8ac746eaa95e5c22ca5e366b824c210a3f4.1628248828.git.asml.silence@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 06, 2021 at 12:22:10PM +0100, Pavel Begunkov wrote:
> Even though ->s_maxbytes is used by generic_write_check_limits() only in
> case of O_LARGEFILE, the value is loaded unconditionally, which is heavy
> and takes 4 indirect loads. Optimise it by not touching ->s_maxbytes,
> if it's not going to be used.

Is this "optimisation" actually worth anything?  Look at how
force_o_largefile() is used.  I would suggest that on the vast majority
of machines, O_LARGEFILE is always set.
