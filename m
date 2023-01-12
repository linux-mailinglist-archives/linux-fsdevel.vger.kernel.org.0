Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB85667DD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbjALSU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 13:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbjALSU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:20:29 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A95FAE6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 09:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f56vuQLtzJ4HjXUqPZJrw8+5aN9XP/CxFdEBKWzUBpQ=; b=ApeNTnwdZN8Hh9FmiF2moXFjdP
        dSC2GOwBLyJXlRaPRpRZBrl4R8a/k9jaxYKTbY66wxvl/G5tVNuNTnOE4qqnZ+uZzv4MWbDu+z/Lz
        ery9yywxg75eBUqXUzfKT6GkdZTjnmctrzjfvvDuqYybmKw1EIzuvqKk8yw+np2tR0OLlJbPtWqos
        idp2PQO4uPbgHXt7gskExRS4YiBuU9y3Zwr1Hxw1kwtX1Tq53eyv4zoRjIPnT2IwnUu1ZlAolYqYn
        EzzXFkZM0IlRSniZ6Uj+qXr19UHFNvko9AfOg6SnDKgVmdg2szCQ7Tvlz1KEtsXn/zGqyo1Ms9rbs
        pBDK1tEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pG1mP-001WNf-0h;
        Thu, 12 Jan 2023 17:54:21 +0000
Date:   Thu, 12 Jan 2023 17:54:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Josef Bacik <josef@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: Introduce { freeze, thaw }_active_super functions
Message-ID: <Y8BJTczjx5yQeTXf@ZenIV>
References: <20221129230736.3462830-1-agruenba@redhat.com>
 <20221129230736.3462830-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129230736.3462830-3-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:07:34AM +0100, Andreas Gruenbacher wrote:

> -int freeze_super(struct super_block *sb)
> +int freeze_active_super(struct super_block *sb)
>  {
>  	int ret;
>  
> -	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
>  	if (sb->s_writers.frozen != SB_UNFROZEN) {
>  		deactivate_locked_super(sb);

Not fond of the calling conventions, to be honest...  "On success return 0;
on failure return -E... *and* drop an active reference passed by the caller"?

If you go that way, at least take the deactivate_locked_super() into the
caller and I would argue that ->s_umount handling also belongs in the caller,
both grabbing and dropping it.
