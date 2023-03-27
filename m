Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC56C9D3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 10:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjC0IK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjC0IKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A011F3A9D;
        Mon, 27 Mar 2023 01:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3282CB80E9E;
        Mon, 27 Mar 2023 08:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A3EC433EF;
        Mon, 27 Mar 2023 08:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679904618;
        bh=34GlLDZs9xsU4X4y4jbYBxVIqRQaa6Vbkw23VwWqaPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIPL6BBKkJIYhsOUboOvRHYUY3tZtipRkEiDjhTVRxLiWsOZxj+IVkxiz7MwBLon4
         m4FJOemnyf/A9BrbEkNzQA9MHzX4Z6sHAwH6RMWv2ZPc4ITVki0je/2iSdyzvbz9YD
         rCGgU4oicSOBwPHk5C35kqNITu7VgO6hBmxBBU6QhklIdJsugksmi7Q9ifD05qZKJJ
         V7i7gUZSN677Q6WDFXiEQGPrz4DP6BqyAkDgNar/pZBa3utJNzwSz22JQDap9UqVeG
         ca+nYVu70w2MebtZEcoZ1YvuZaG7IHFN9Ae02uRte4hw3Tr4vECLcazD4RSVIkoDPX
         uKwxurMORyxsQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/buffer: Remove redundant assignment to err
Date:   Mon, 27 Mar 2023 10:10:10 +0200
Message-Id: <167990444020.1656778.1662705570875208111.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
References: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=410; i=brauner@kernel.org; h=from:subject:message-id; bh=oMDp8p5UWqaXqXrCVnyKq2CByfK3S1lZJOB7Oy9si+o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQo+sfyyMx7L/yvdWn5QQmLYzkKsqn32G90e7d9XKTufPf9 uc1sHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJXsnI8DUn/86RWZzp/K7mT6T+JJ WetDsopnXXQ/oJ46nZEQ0rlzD8d/jzO7DXM/0K2+e8xHWN8nMYXz/i2nTo35GkXQ5ra8vUOQA=
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


On Thu, 23 Mar 2023 10:32:59 +0800, Jiapeng Chong wrote:
> Variable 'err' set but not used.
> 
> fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.
> 
> 

Applied to

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc
[1/1] fs/buffer: Remove redundant assignment to err
      commit: dc7cb2d29805fe4fa4000fc0b09740fc24c93408

Thanks!
Christian
