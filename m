Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9335E78E697
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 08:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbjHaGeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346074AbjHaGd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:33:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E051A4;
        Wed, 30 Aug 2023 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=m7ZNAD+mu1nvLKxN0YL1DZsRCd8xWr1zWeyKm/p/2Kc=; b=quU2UCffpQaWx2E9I3k9a/YyZR
        v/LTBB7/Opl416AqY0SrjDDt813lNCB8bPcyRwjFsk/+MNjUnCw5oI3FnvMPiw6gjrwvHcOkMuiPu
        w+b7g26m5lsG3vacgKbwSrCLEV4wqrMCCokViqTrQg7jEU0ZnZB3O8wp5XSlMdo8uhD66YqeQ2k9l
        j145GPcljm62MFpjeg14YElhOP3Zjfa/GZYjBvashoEK/3q8yWBxVA5/bqHwc5k8h9RIEQt8q5jNJ
        8eTzA9yqc+R1bZG+bXis/ANCvcydii57HprxWx+6SYTFCN9jDXZW6qsDAUU3NhJkY5dUpKImXYHqG
        9LmRBXfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbbFV-002H1W-2w;
        Thu, 31 Aug 2023 06:33:50 +0000
Date:   Thu, 31 Aug 2023 07:33:49 +0100
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
Subject: Re: [PATCH 3/4] selinuxfs: free sb->s_fs_info after shutting down
 the super block
Message-ID: <20230831063349.GF3390869@ZenIV>
References: <20230831053157.256319-1-hch@lst.de>
 <20230831053157.256319-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831053157.256319-4-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:31:56AM +0200, Christoph Hellwig wrote:
> sb->s_fs_info can only be safely freed after generic_shutdown_super was
> called and all access to the super_block has stopped.
> 
> Thus only free the private data after calling kill_litter_super, which
> calls generic_shutdown_super internally.

Same as for ramfs, AFAICS.

> Also remove the duplicate freeing in the sel_fill_super error path given
> that ->kіll_sb is also called on ->fill_super failure.

Reasonable cleanup, that.
