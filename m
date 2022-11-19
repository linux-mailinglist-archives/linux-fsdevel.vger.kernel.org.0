Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB9630BED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 05:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKSEqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 23:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKSEqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 23:46:22 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8DA2883;
        Fri, 18 Nov 2022 20:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SJWklytu4XN4G6PI77eHjQA+9EaF4oxISWvc8B/9PuE=; b=oCkXTzhw0EUfCL14MWFML46AZV
        RE4mrm4fRCV9t6PtQOuGnHYAqPP44npCEm4xsdp08/fgRHrS/EhUI4Y7M/RXLGioE8o+jIlXJt3QL
        9Cak56NJSdR6EUQ5KVecxQaxBRchw4GS5i+u00Kh5YgPaZouRRneVNCk2E7m7MBfAVQvbgNv81apC
        F+tRUd/YkK8nrakQmNUJs+0dOyU+Pml3zRuWJP74o6gSgJe45ePBi+iEQDpnztXBA2Ip3T6hexmVW
        fEhnzuD8z/r6DkGB8Gg5KVNa5BfKgsnSd8wIn60/pff3Ml0K5h5/uqpG8KS2Zsa1w7DnstegOLiXw
        +7Xm7ipw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1owFk9-004zAW-2t;
        Sat, 19 Nov 2022 04:46:17 +0000
Date:   Sat, 19 Nov 2022 04:46:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coredump: Use vmsplice_to_pipe() for pipes in
 dump_emit_page()
Message-ID: <Y3hfmYF6b5T35Xqi@ZenIV>
References: <20221029005147.2553-1-yepeilin.cs@gmail.com>
 <20221031210349.3346-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031210349.3346-1-yepeilin.cs@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:03:49PM -0700, Peilin Ye wrote:

> +	n = vmsplice_to_pipe(file, &iter, 0);
> +	if (n == -EBADF)
> +		n = __kernel_write_iter(cprm->file, &iter, &pos);

Yuck.  If anything, I would rather put a flag into coredump_params
and check it instead; this check for -EBADF is both unidiomatic and
brittle.  Suppose someday somebody looks at vmsplice(2) and
decides that it would make sense to lift the "is it a pipe" check
into e.g. vmsplice_type().  There's no obvious reasons not to,
unless one happens to know that coredump relies upon that check done
in vmsplice_to_pipe().  It's asking for trouble several years down
the road.

Make it explicit and independent from details of error checking
in vmsplice(2).
