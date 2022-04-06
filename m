Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6014F6C38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 23:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiDFVL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiDFVLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:11:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7041BA475;
        Wed,  6 Apr 2022 12:54:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9A8A31C18; Wed,  6 Apr 2022 15:54:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9A8A31C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1649274864;
        bh=Rt/iDV6EXUzjhwai4+nVYIWPX2bQ4Ifas1W7er0iKRo=;
        h=Date:To:Cc:Subject:From:From;
        b=j67En+ImzlF00eIN0Hv6GQEzbKR0I622OhPDfoMCV7WYsU49i75QUVE5k+zillHVf
         fJ13baWhnVNrpkkqP8iVeQ5JM7v4by+QFpxMxo3I2z6WMzloOmAhWLQPEhQxHzv+TY
         GKIvJqjm4vcgteTZa3JFDCNGY7q1BCzOs+z2Fo9I=
Date:   Wed, 6 Apr 2022 15:54:24 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: sporadic hangs on generic/186
Message-ID: <20220406195424.GA1242@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the last couple days I've started getting hangs on xfstests
generic/186 on upstream.  I also notice the test completes after 10+
hours (usually it takes about 5 minutes).  Sometimes this is accompanied
by "nfs: RPC call returned error 12" on the client.

Test description is:

# Ensuring that copy on write in buffered mode works when free space
# is heavily fragmented.
#   - Create two files
#   - Reflink the odd blocks of the first file into a third file.
#   - Reflink the even blocks of the second file into the third file.
#   - Try to fragment the free space by allocating a huge file and
#     punching out every other block.
#   - CoW across the halfway mark.
#   - Check that the files are now different where we say they're
#   different.

so maybe it's really some xfs change, I don't know.  Or maybe it's a
problem with my particular test filesystem (which doesn't get recreated
for each test run).

The problem doesn't reproduce easily enough to bisect.

I may just turn off that test for now.

--b.
