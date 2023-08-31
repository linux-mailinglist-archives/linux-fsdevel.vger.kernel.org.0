Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5247C78E67C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjHaG0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 02:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbjHaG03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:26:29 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220ACB9;
        Wed, 30 Aug 2023 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LwdSnI9S0JYXWh+eL2hyD3GQiufQtnb92hxiHRk+1vw=; b=L6dWyFlpRzqYRnFQAVYG3e9SiL
        JRG/DI3XsRLLiJ999EWYCTrQKKBdAJcWKcQJzzVXmqfpmvn87nQefmL0/EVzo0uDTb3CNpirDXD7S
        UiSrBZDMzpFg/+OiJt4gN+iZ9UGm5+cKBKv0K0WMEAc7mGZ95VtdPLDuNYnjQRiuF8uRFfidG4lmx
        POCt0DcNYKm6kaZ3KIzfYQC1acQ5Vq1BJC260/UqAIWYhjtfd9BFZpbsT5uFOu7tlLkmT4fnM9KtQ
        rWvf1vBs9tGki++8hRvgEfKskqWydvW05L+k2+WR+kYZW8qHGsexV18cXEtkylfDG/UGh+VZ6DKBB
        eWnEJlKQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbb7R-002Gtw-1A;
        Thu, 31 Aug 2023 06:25:29 +0000
Date:   Thu, 31 Aug 2023 07:25:29 +0100
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
Subject: Re: [PATCH 1/4] ramfs: free sb->s_fs_info after shutting down the
 super block
Message-ID: <20230831062529.GD3390869@ZenIV>
References: <20230831053157.256319-1-hch@lst.de>
 <20230831053157.256319-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831053157.256319-2-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:31:54AM +0200, Christoph Hellwig wrote:
> sb->s_fs_info can only be safely freed after generic_shutdown_super was
> called and all access to the super_block has stopped.
> 
> Thus only free the private data after calling kill_litter_super, which
> calls generic_shutdown_super internally.

Take a look at what ramfs uses that thing for.  Remount and ->show_options().
Neither is an issue in ->kill_sb().  I don't really hate that patch, but
commit message is flat-out incorrect in this case.
