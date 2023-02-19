Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6A69C2BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Feb 2023 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjBSVge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Feb 2023 16:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjBSVgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:36:33 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4AF777;
        Sun, 19 Feb 2023 13:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=PBokiqXsXo5Pc5WAkqYLqOvdwovmwqM/9idLauPogmA=; b=O5exEZ/p8bozHp6ym76iYZQ713
        KO5khgWDNlQrjiYPNFuK284H6gkgu8iQQ+t906HUom2/+GqSMXsYKeXegrb6wGm86ptgopOBmHC7g
        x3XvoiZWka4eLlWO1Wx6CD0D/3rYqmGgIWRTFZie/MdIr+osue5//0thK2gTCPRWBSyrVBTKq9SjP
        CznCGYXM5k+YBEJ4b5t59xVuXCZnfKKjuzUx9g4PRQnXwk0VAJ6vXG4H798xXBvynLkFb+cXfKG7j
        9547wmBr+3mlt30K7Gj/227nqnePt03wD2MDap/Y61yK7JvnOG/J0d/pnjgg9PJjfK7K8baj/up6y
        U1iDQjuC2EOm4R9h8MiOsX4hPtN3KX2wRxdrumC5VB7SKH0tfSPgfE8J+WvY1Guy7YWiTm7ycNkBS
        d0i8MT3OVGC4ztil7gMT6WLl+L3jtcJ5O2hEeDc/yReW1+UDrh3fooEgrt5K7VwVQk1El9O6fvaQ9
        8svY8lwQQ8Cd+8hCp7vavdEGWBIieBlFmnleOYyI/hvcWyf+07F8F5dOGOwN0Zwr8DiaYvmk6iRUU
        wGyErymXlHT/eKUcv5gejBlvTozbQjQquxk+Cyoe6ZzJgkBBdUMyuJPKglBRY2NvirU0qpiisGT+v
        40ESyxInEUEliLcWxDbm6ieNhGhBFYHrGo0OunTKU=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <ericvh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH v4 00/11] Performance fixes for 9p filesystem
Date:   Sun, 19 Feb 2023 22:36:20 +0100
Message-ID: <12241224.W6qpu7VSM5@silver>
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday, February 18, 2023 1:33:12 AM CET Eric Van Hensbergen wrote:
> This is the fourth version of a patch series which adds a number
> of features to improve read/write performance in the 9p filesystem.
> Mostly it focuses on fixing caching to help utilize the recently
> increased MSIZE limits and also fixes some problematic behavior
> within the writeback code.
> 
> All together, these show roughly 10x speed increases on simple
> file transfers over no caching for readahead mode.  Future patch
> sets will improve cache consistency and directory caching, which
> should benefit loose mode.
> 
> This iteration of the patch incorporates an important fix for
> writeback which uses a stronger mechanism to flush writeback on
> close of files and addresses observed bugs in previous versions of
> the patch for writeback, mmap, and loose cache modes.
> 
> These patches are also available on github:
> https://github.com/v9fs/linux/tree/ericvh/for-next
> and on kernel.org:
> https://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
> 
> Tested against qemu, cpu, and diod with fsx, dbench, and postmark
> in every caching mode.
> 
> I'm gonna definitely submit the first couple patches as they are
> fairly harmless - but would like to submit the whole series to the
> upcoming merge window.  Would appreciate reviews.

I tested this version thoroughly today (msize=512k in all tests). Good news 
first: the previous problems of v3 are gone. Great! But I'm still trying to 
make sense of the performance numbers I get with these patches.

So when doing some compilations with 9p, performance of mmap, writeback and 
readahead are basically all the same, and only loose being 6x faster than the 
other cache modes. Expected performance results? No errors at least. Good!

Then I tested simple linear file I/O. First linear writing a 12GB file
(time dd if=/dev/zero of=test.data bs=1G count=12):

writeback    3m10s [this series - v4]
readahead    0m11s [this series - v4]
mmap         0m11s [this series - v4]
mmap         0m11s [master]
loose        2m50s [this series - v4]
loose        2m19s [master]

That's a bit surprising. Why is loose and writeback slower?

Next linear reading a 12GB file
(time cat test.data > /dev/null):

writeback    0m24s [this series - v4]
readahead    0m25s [this series - v4]
mmap         0m25s [this series - v4]
mmap         0m9s  [master]
loose        0m24s [this series - v4]
loose        0m24s [master]

mmap degredation sticks out here, and no improvement with the other modes?

I always performed a guest reboot between each run BTW.



