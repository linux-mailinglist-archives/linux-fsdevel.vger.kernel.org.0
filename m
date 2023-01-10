Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699AD665003
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjAJXnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 18:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjAJXnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:43:33 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA03E0FE
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 15:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W3ZIpVdTPX3uo77cEGhgztBtjLlt/vMR9+vGIt2PYug=; b=sw48sNZupubq8zIpLZkJ8tVAwX
        KaTJTKi3WfxpTchXpomLLz98TCRd/orUvZUWLjt+0tVsBfKY0C71hWOQqmT9zl6JYRpy7IQ4Hr7+f
        WpqaSaiDXkoyySf/Ec1Vm0zNKgLzT8GbF3YX4rgg9zY7ddSilCHgjAgCrqFHgdf30jPKElxlH8pN8
        n/ov3VVsAsgAZXtzBjmR3pMvf1dKMdWjXjNxfs2iYpvP/91sVoFyTRG4X8TcHBHxL1fatbRx+jdBg
        1Qqv5SSkn2ER8zTu7YHmDeCgNLofsBlVRiWKXSW78Mp/R9Y9nuAITax3wgroxk3r7gVcg+dnNy+Vk
        8O4Xv/rg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFOHD-0015VV-0i;
        Tue, 10 Jan 2023 23:43:31 +0000
Date:   Tue, 10 Jan 2023 23:43:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        hch@infradead.org, john.johansen@canonical.com, dhowells@redhat.com
Subject: Re: [RFC 2/3] fs: use SB_NOUSER on path_mount() instead of
 deprecated MS_NOUSER
Message-ID: <Y734Iz9pwBy4pbrx@ZenIV>
References: <20230110022554.1186499-1-mcgrof@kernel.org>
 <20230110022554.1186499-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110022554.1186499-3-mcgrof@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 06:25:53PM -0800, Luis Chamberlain wrote:
> The goal behind 462ec50cb5 ("VFS: Differentiate mount flags (MS_*) from
> internal superblock flags") was to phase out MS_* users for internal
> uses. But we can't remove the old MS_* until we have all users out so
> just use the SB_* helper for this check.

No.  The goal had been to separate the places where we deal with
mount(2) argument encoding from those where we are deal with superblock
flags.  path_mount() is very much in the former class.
