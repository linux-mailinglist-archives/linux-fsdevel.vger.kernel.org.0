Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44636094E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJWQtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJWQtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:49:01 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222016290E;
        Sun, 23 Oct 2022 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GuzuQhIcB7Yfe4z2AbKUpBq28LkvJC35LhO4Q+pZ32Y=; b=jmF+fva0+Nx5RKXkeUD9TtxFNh
        fAaPggxx1+y2jc39t5752FZxxWz3uSdcYKSo/6UOqlHNzJOaOkzcru8OXGAERJPaOQgOZIAXKuSTV
        raadxOtLixW4xamuhf7Li/Vlz6IWHtHpV3W1GLaiYoSxTqY0Df0RkUtYZF97wHutRIUFeGSeCKTiN
        cFo952krO17YbJUBJYj62ZZGU0Qj09FwAYQ7YjB/X9QK18vXbRXIdmVCNU3TkFIquIwluSTcir40U
        zF4yuc9i1LzlxEA4For8TRFGL0RPfZrS4RS6RM+3iZLAUxc3ffRI/rFxz2o9dsA+Jta9qjvpg2N45
        ue4K80Ng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ome9d-00DBvg-0u;
        Sun, 23 Oct 2022 16:48:53 +0000
Date:   Sun, 23 Oct 2022 17:48:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next 0/5] fs: fix possible null-ptr-deref when parsing
 param
Message-ID: <Y1VwdUYGvDE4yUoI@ZenIV>
References: <20221023163945.39920-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023163945.39920-1-yin31149@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:39:41AM +0800, Hawkins Jiawei wrote:
> According to commit "vfs: parse: deal with zero length string value",
> kernel will set the param->string to null pointer in vfs_parse_fs_string()
> if fs string has zero length.
> 
> Yet the problem is that, when fs parses its mount parameters, it will
> dereferences the param->string, without checking whether it is a
> null pointer, which may trigger a null-ptr-deref bug.
> 
> So this patchset reviews all functions for fs to parse parameters,
> by using `git grep -n "\.parse_param" fs/*`, and adds sanity check
> on param->string if its function will dereference param->string
> without check.

How about reverting the commit in question instead?  Or dropping it
from patch series, depending upon the way akpm handles the pile
these days...
