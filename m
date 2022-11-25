Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB80638322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 05:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKYEcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 23:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKYEcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:32:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0BEB7F5
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 20:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nXIjkNO7JBdHCwcuE82cTWAA9Yx6jdLEmr2MbksGCUA=; b=EOU3lsiA7ENNCud4kgkjBJw/4f
        nUCA/lolnU4TxJ8sUCEJS5AH44RwNSIKiLDgP+20+trXc6UwepRMArbyisf/mIDoTGFpS4flqEKrz
        WJhK3DzLZKuN3US89SPXOU3Equ1TpCSobMfrypv81LXw9r/qrIZ8r0/hcrJxOg/h8ZTXp9KF0coEY
        g55mXLcRekcyL54BmcmuxVWr7HR3oHOdfVxRUYw1nCVokQIXlE0Gat5XgQLeg0QFsY941AaZsp/pN
        Nlea5E6UTsfLZHA9A3hKnopFYY1Y2DdKe0hwxMaw3NfyipGhYfPF4hhAJqFx94h8Fp0Y1qiSGNQjZ
        VPCvmERQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyQOC-006ai3-29;
        Fri, 25 Nov 2022 04:32:36 +0000
Date:   Fri, 25 Nov 2022 04:32:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: simplify vfs_get_super
Message-ID: <Y4BFZEBT6eDZfYPu@ZenIV>
References: <20221031124626.381838-1-hch@lst.de>
 <20221121075032.GA24804@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121075032.GA24804@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:50:32AM +0100, Christoph Hellwig wrote:
> On Mon, Oct 31, 2022 at 01:46:26PM +0100, Christoph Hellwig wrote:
> > Remove the pointless keying argument and associated enum and pass the
> > fill_super callback and a "bool reconf" instead.  Also mark the function
> > static given that there are no users outside of super.c.
> 
> Al, can you pick this one up?

Applied, even though I want to see if we can lift sget_fc() out of that
thing and turn it into something that would just handle the "here's
a superblock, here's fc, here's fill_super callback, do the right
thing" part and hopefully might be reused in bdev part...
