Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49775B66FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 06:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiIMEfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 00:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiIMEer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:34:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849CC5C367
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZTMtUkgOe+xClHc7nhaK/Fg+uFK6rSJqEDnEZ7m/dxQ=; b=fxrJoyaPjbV9muBewxkWvuZiZD
        /f5L8M5Kb9bDpgqFhrZrtbiexgZg3lM86ZAgHiCfE8mAs27096/BVIOOG/IPCWcqbVuIo7xMTvI4t
        zjA041Ip29TY4WXKiboDZqnU5fAVXQdHDs2tlj2G33eBcaMRcO+nWz5uD9GflFtsZfPQ9Ymg1Crc7
        G/bjaBf1Dz+qTV/nKsYL7W8csbfPRpMz+CmSp62aGknks5JWCYrkjfiLquRtLwrhw/KSQ4xge+w3R
        crd8b/RnryDpOLTTGcbTeuz3vAHC0ApoXBy/yWOkVkehutHkeU9g154sDTFyf0Szn2pHLJg39X18p
        J9nVv40A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oXxXi-00Fjcu-1a;
        Tue, 13 Sep 2022 04:29:02 +0000
Date:   Tue, 13 Sep 2022 05:29:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
Message-ID: <YyAHDsGiaA/0ksX8@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>
 <Yx/lIWoLCWHwM6DO@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx/lIWoLCWHwM6DO@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 03:04:17AM +0100, Al Viro wrote:
> On Mon, Feb 21, 2022 at 09:20:02AM +0100, Miklos Szeredi wrote:
> 
> [digging through the old piles of mail]
> 
> Eyes-watering control flow in do_linkat() aside (it's bound to rot; too
> much of it won't get any regression testing and it's convoluted enough
> to break easily), the main problem I have with that is the DoS potential.
> 
> You have a system-wide lock, and if it's stuck you'll get every damn
> rename(2) stuck as well.  Sure, having it taken only upon the race
> with rename() (or unlink(), for that matter) make it harder to get
> stuck with lock held, but that'll make the problem harder to reproduce
> and debug...

FWIW, how much trouble would we have if link(2) would do the following?

	find the parent of source
	lock it
	look the child up
	verify it's a non-directory
	bump child's i_nlink
		all failure exits past that point decrement child's i_nlink
	unlock the parent
	find the parent of destination
	lock it
	look the destination up
	call vfs_link
	decrement child's i_nlink - vfs_link has bumped it
	unlock the parent of destination

I do realize it can lead to leaked link count on a crash, obviously...
