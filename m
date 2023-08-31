Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916CD78E6A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 08:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbjHaGhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 02:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346104AbjHaGhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:37:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988B8B4;
        Wed, 30 Aug 2023 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=StCt6YBb7i1NCyKxwkQD7nTyORJ+B47XG+LIL5Hkia0=; b=nd7vzvZeEd68QgDJRKtnYoJGKS
        WIfnyqnu9CX728xmHLqlCcA5R88g2kDzwCTpcZNswGM0ly018v5mtT2siHjwsWelBPS90aj/qwwsa
        U0Ouz24fYw+zV16sy/kefkAsOfCUtL5t2oqZhIezzXVHN+LVNoIiTHcAO3UQMIhb1/mPIdowikqLX
        unApY75eE+Z4iXxmVvjryzCoLo8lh+Quo1nHKICnHcM3zsSz/9vd9/ghO2ZvAmDmGDVw93lgv/tfy
        lsYbPJPN3xZnDTE3BKXLTWGe1Nb/JmEHeafybDDaNOb/h2Sq5/AfdXDxTCbfrZm2M65oKfV6IWBl9
        ulbUDXow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbbIk-002H3j-2o;
        Thu, 31 Aug 2023 06:37:11 +0000
Date:   Thu, 31 Aug 2023 07:37:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 4/4] hypfs: free sb->s_fs_info after shutting down the
 super block
Message-ID: <20230831063710.GG3390869@ZenIV>
References: <20230831053157.256319-1-hch@lst.de>
 <20230831053157.256319-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831053157.256319-5-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:31:57AM +0200, Christoph Hellwig wrote:
> sb->s_fs_info can only be safely freed after generic_shutdown_super was
> called and all access to the super_block has stopped.
> 
> Thus only free the private data after calling kill_litter_super, which
> calls generic_shutdown_super internally.

Same as for ramfs.  We *do* use ->s_fs_info there, but only for
operations that require an active reference.  They can't overlap
with ->kill_sb().
