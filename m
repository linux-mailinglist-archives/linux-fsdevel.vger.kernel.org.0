Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8658589F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jul 2022 06:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiG3Ela (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jul 2022 00:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiG3El2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jul 2022 00:41:28 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7653369F08
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 21:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=UTOgnLJPV0orVDpWE/X5YqNrEqhSq7Y0/RU8n+QbPG8=; b=AMwdFEmpVe/nYgT+4kR7GR6TcI
        HOwbQTxobz/1moeDXAoAe8L2z48YqmAFBLG5Bsjk7gpIqez9L6DLZjAtTgCfcXBAAKrQJDExf0dMz
        ss27cNCXrd2vqP/hwMsx92syOMXV1YKX3yyI+ZwgUGk+wAZ+amswwUn+FvgLNgWBYaBMpadThFW0B
        ai0GsUyaa1LP7+A532o94IDSPXGyXclH+/6kbdsG5NPqOf4tBj4z4Zl0CScxlMKZdi75Unuy+NbWe
        VLyhOY0l7YFjI6JcFU/KCq2xJJ+KlomtMdsE67/Mp9f2hFiaQewwJJYjSO8uNGCPA3vKeYu3VcXnc
        cL7SmFGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oHeI1-00HFp3-Ra;
        Sat, 30 Jul 2022 04:41:25 +0000
Date:   Sat, 30 Jul 2022 05:41:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4 v2] fs/dcache: Resolve the last RT woes.
Message-ID: <YuS2dYPtfed+lHji@ZenIV>
References: <20220727114904.130761-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220727114904.130761-1-bigeasy@linutronix.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 27, 2022 at 01:49:00PM +0200, Sebastian Andrzej Siewior wrote:
> This is v2 of the series, v1 is available at
>    https://https://lkml.kernel.org/r/.kernel.org/all/20220613140712.77932-1-bigeasy@linutronix.de/
> 
> v1…v2:
>    - Make patch around Al's description of a bug in d_add_ci(). I took
>      the liberty to make him Author and added his signed-off-by since I
>      sinmply added a patch-body around his words.
> 
>    - The reasoning of why delaying the wakeup is reasonable has been
>      replaced with Al's analysis of the code.
> 
>    - The split of wake up has been done differently (and I hope this is
>      what Al meant). First the wake up has been pushed to the caller and
>      then delayed to end_dir_add() after preemption has been enabled.
> 
>    - There is still __d_lookup_unhash(), __d_lookup_unhash_wake() and
>      __d_lookup_done() is removed.
>      __d_lookup_done() is removed because it is exported and the return
>      value changes which will affect OOT users which are not aware of
>      it.
>      There is still d_lookup_done() which invokes
>      __d_lookup_unhash_wake(). This can't remain in the header file due
>      to cyclic depencies which in turn can't resolve wake_up_all()
>      within the inline function.

Applied, with slightly different first commit (we only care about
d_lookup_done() if d_splice_alias() returns non-NULL).

See vfs.git#work.dcache.
