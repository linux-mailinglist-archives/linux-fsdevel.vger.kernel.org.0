Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCEE6B1FB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjCIJQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjCIJQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:16:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AC5DDB26;
        Thu,  9 Mar 2023 01:15:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F05C61AB8;
        Thu,  9 Mar 2023 09:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0240DC4339B;
        Thu,  9 Mar 2023 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678353353;
        bh=G2khEq+xquiNctDpTE3gv/H23UKYmhO6a/sfW3ioaaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rm5M/Ltrh5rGI+dxGGDkPXqaf9hXKgBL6MPy3TJYe4yUj/332R310STmingtOszj8
         O7gC9mqVz0hXafLq6oKKh+Z5SLA3WtBnNnj+E5Gb6Q7bKodHLWWEdpHcHQyhEM370N
         E0KPlv7f9rQ3iwRoDSNfX2tKdnoThKrK3qgfE2Okx4FgIDLD7GUaVRlEhUrtujVQNu
         NsNCMUIAhMPjlPSIJ8bIpX9mpG+DLKKlnafW2XAS8niRJfsWr3eVLizSir7dMqds2Y
         eljOxW8cGVx9B/bCpFo/MQ4yBZAYa92SGE3oq7H+ZXTRqi4dkX8Dq74Rkl5FNa+wcz
         47JmIiMIJVW2w==
From:   Christian Brauner <brauner@kernel.org>
To:     viro@zeniv.linux.org.uk,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] splice: Remove redundant assignment to ret
Date:   Thu,  9 Mar 2023 10:15:46 +0100
Message-Id: <167835324320.766837.2963092716601467524.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
References: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=381; i=brauner@kernel.org; h=from:subject:message-id; bh=z0KOVDen5AphwKd/Yz9kCC+VOMYqP+ntsWTYZqj+778=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRwLt6+3XhxhNJihnZXpdv6h3gmnfKN6bw6javtWQ/rqXtr 3/5k6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI26mMDB9uXYpSrJjaeHvT6k3Jr7 0MZVjT67bz6Ydoc26fzPNkLT8jw375zrQ5C1b8b5woWT7tgdHKnmZJ1eio7nMzVZ9O/db6lQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Tue, 07 Mar 2023 16:49:18 +0800, Jiapeng Chong wrote:
> The variable ret belongs to redundant assignment and can be deleted.
> 
> fs/splice.c:940:2: warning: Value stored to 'ret' is never read.
> 
> 

Thanks for the cleanup. Seems ok to do so I picked this up,

[1/1] splice: Remove redundant assignment to ret
      commit: c3a4aec055ec275c9f860e88d37e97248927d898
