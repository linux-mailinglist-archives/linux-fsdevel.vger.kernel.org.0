Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E264A67F3B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 02:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjA1BbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 20:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjA1BbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:31:10 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B87F694;
        Fri, 27 Jan 2023 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4UdI0XLVZ+STvP+c7ZuGr7ODso1LLN/6ZSJUkV3i9tA=; b=sksjE6pMkxVQZbaHtq2cKdbt2B
        jb1NGYiEx84rXXn/PwhDaVMea+PUDvdQxoyRruIFbHq73TnKh6TPqjufn6w2m2K80P26UNRqewifW
        ndDB69F0r0qnBFCBPejd1l5JQCF1c2VuEp/cbhPViFyfUzzuC6ELwN5cWRSVCPJ+25oN4JYpotviT
        vwGypy1Wn70M0NOuVEdiN3Pn7ag1fez4A9GEaI4etAFwIOnxIsCCyhAZyLOaB9ozTKHQjUr7z6a15
        mOdgJVUK+uCAUwNAfMOxLsdxfuCCh7GsZjzMw0Do4uxUTWALRnqPhCaQlBi07iyJOJ+s/Xy3G9/ol
        O4JnVY5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLa3Z-004aAh-1P;
        Sat, 28 Jan 2023 01:31:01 +0000
Date:   Sat, 28 Jan 2023 01:31:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-fsdevel@vger.kernel.org, gscrivan@redhat.com
Subject: Re: [PATCH v3 0/2] ipc,namespace: fix free vs allocation race
Message-ID: <Y9R61R1ChfpcYWgS@ZenIV>
References: <20230127184651.3681682-1-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127184651.3681682-1-riel@surriel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 01:46:49PM -0500, Rik van Riel wrote:
> The IPC namespace code frees ipc_namespace structures asynchronously,
> via a work queue item. This results in ipc_namespace structures being
> freed very slowly, and the allocation path getting false failures
> since the to-be-freed ipc_namespace structures have not been freed
> yet.
> 
> Fix that by having the allocator wait when there are ipc_namespace
> structures pending to be freed.
> 
> Also speed up the freeing of ipc_namespace structures. We had some
> discussions about this last year, and ended up trying out various
> "nicer" ideas that did not work, so I went back to the original,
> with Al Viro's suggestion for a helper function:
> 
> https://lore.kernel.org/all/Yg8StKzTWh+7FLuA@zeniv-ca.linux.org.uk/
> 
> This series fixes both the false allocation failures, and the slow
> freeing of ipc_namespace structures.
> 
> v3: remove mq_put_mnt (thank you Giuseppe)
> v2: a few more fs/namespace.c cleanups suggested by Al Viro (thank you!)

Applied (#work.namespace)
