Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28DE6D3E16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 09:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjDCH3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 03:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjDCH3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5F483FC;
        Mon,  3 Apr 2023 00:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A71BA6155B;
        Mon,  3 Apr 2023 07:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D8FC433D2;
        Mon,  3 Apr 2023 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680506975;
        bh=lQcjagvQW5vaKjYm9FM3pRh642wat0HtPZnNd6xz+c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7io5QkHpEI2QN6UpD2VmiAswDOIIp1DM7o4nOxJKwqIDAZT6vBS4OEc9QGsbHx6/
         eWglYVbCgvn9waOVIPUg/kEKy8loKzgK8uZusMUHNcYzyrc3fPfSBzBU/kLfe1rQrd
         B4hmSlx83bj2+Zbd8lVv18yjY3c6lkZ5jSRYwDfK4GUKosy/1QbvXsMXaxnn3F9MC+
         Ioz9AMty2OOYXwGdWvefIrreav4Xiq5BTZ+9BV5NA1fqje3ZmNv1NWvhSQ8MjQLBpG
         jOTno9/vlsHwGv/8M7RrhvuXKxRlrBYNDqKYxG7o5JiTvEsYAetBWzjHWQb7k7w7r0
         D4NnRDCqPgUOQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: consolidate duplicate dt_type helpers
Date:   Mon,  3 Apr 2023 09:28:07 +0200
Message-Id: <20230403-zealous-refusal-b811eb5e1cdf@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330104144.75547-1-jlayton@kernel.org>
References: <20230330104144.75547-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=560; i=brauner@kernel.org; h=from:subject:message-id; bh=g7myO4zItbTFXcpfnu52zRNrXg6NcZ41DX48kuLxQ7o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRo1T9/Ejv77vLS841zEjJjrzBVuqu/OWR8ateJIwttVLQy PotM6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI0yRGhl8LcxlEbDJUJ+xl3J+6KT bt9q9j99YtDPhyrnV60M5nvvUM/xT7krZFGW014ZkX/rJe9Xeo0DTx7e3TDXlqDD0WCnruZQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu, 30 Mar 2023 06:41:43 -0400, Jeff Layton wrote:
> There are three copies of the same dt_type helper sprinkled around the
> tree. Convert them to use the common fs_umode_to_dtype function instead,
> which has the added advantage of properly returning DT_UNKNOWN when
> given a mode that contains an unrecognized type.
> 
> 

I've picked this up now,

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc
[1/1] fs: consolidate duplicate dt_type helpers
      commit: 364595a6851bf64e1c38224ae68f5dd6651906d1
