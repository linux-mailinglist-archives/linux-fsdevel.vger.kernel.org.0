Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4F595EAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiHPO77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiHPO7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:59:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B454F689
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BhZBrrOYrqgdPz+uF6w+/TpBRHbyZL6ggu1VjgRP3ro=; b=ObrNpli8YrWk8fJfEc0up7Zaik
        9brQt3u2DtstwvbQ1R4HsoehVPusDiUUlRDrm65g5acAUo52zj2Lkx7kLeKbl+yDdavjUygZrfu+u
        GoSOuDIrAtYZ57TjfyNz+wCcZvm3iXFKiZibmBOxdHhiTJxme0uS+FSOSRxPXJYhCyrPejy61aqsJ
        ZZuTimzMbq8UYkiIo3ZgG1mzaqlsIjVVzkZ9eraqWFi9W7PrOH0n41WBv/DfphrI2rSiKzfnOXw01
        T4i2ECjP2FWrAo/7Erb4oes+GkxnXEu3xelzNvcd+57Ui85r9iIKM8VPs8CN5ZFwrcMXANTDCV7KU
        jekdWLbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNy2C-0055W1-4o;
        Tue, 16 Aug 2022 14:59:12 +0000
Date:   Tue, 16 Aug 2022 15:59:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] locks: fix TOCTOU race when granting write lease
Message-ID: <YvuwwMS+lZ6VMLHg@ZenIV>
References: <20220816145317.710368-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816145317.710368-1-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:53:17PM +0300, Amir Goldstein wrote:
> Thread A trying to acquire a write lease checks the value of i_readcount
> and i_writecount in check_conflicting_open() to verify that its own fd
> is the only fd referencing the file.
> 
> Thread B trying to open the file for read will call break_lease() in
> do_dentry_open() before incrementing i_readcount, which leaves a small
> window where thread A can acquire the write lease and then thread B
> completes the open of the file for read without breaking the write lease
> that was acquired by thread A.
> 
> Fix this race by incrementing i_readcount before checking for existing
> leases, same as the case with i_writecount.
> 
> Use a helper put_file_access() to decrement i_readcount or i_writecount
> in do_dentry_open() and __fput().
> 
> Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write lease")
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Applied.
