Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27396B1FF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCIJ0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCIJ0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:26:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D438CE250F;
        Thu,  9 Mar 2023 01:26:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 653BDB81EAC;
        Thu,  9 Mar 2023 09:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF4AC4339B;
        Thu,  9 Mar 2023 09:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678353961;
        bh=jpVo/qb7UamQHfPQh9Ec34d8qof4tu675UL+rAU13MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0gjc++yZqNvNq5iWUsJQ1uYW1YFqo1HVHDWrCldx60+/6+CRkdv+3Mi4U9yPmLfj
         kRO9XYGTsljZSLeimRALXBkFzp6s9LNtKZCKiNo7c3YATB1Puw/bOzTeFfm4GrfT9/
         SUvsO8aqfwqHJqSG4fqrLbiz3KM26vV+GWQsvOc5UT9qVc281LZvrvZCdznnrqsLpc
         ZVtSpaCk1ONCnABx0iSl63ZtAFpYOkrnfegdtOZHey81Ub9eXMxG36OV1qANh+Snyz
         7Wx9Y38M8Oeg1nBWhdMoY9UHXCmNdmK0i7uX7tQK/C4DIT12U/H9yXbnT1pf/O419T
         EoF47sdBi2ayQ==
From:   Christian Brauner <brauner@kernel.org>
To:     jlayton@kernel.org, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] fs/locks: Remove redundant assignment to cmd
Date:   Thu,  9 Mar 2023 10:25:47 +0100
Message-Id: <167835349787.767856.6018396733410513369.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308071316.16410-1-jiapeng.chong@linux.alibaba.com>
References: <20230308071316.16410-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=473; i=brauner@kernel.org; h=from:subject:message-id; bh=iTC8S6rIDjoS1mT+A981RU0H8andjK2LQ6RdfBW8NmI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRwLhO+uUV6268DEfsTkytDNS/rLHz71PfiFqbcze+2z8r7 rc8b21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRv8EM/7RN182wPtassHPeZfm+jt rq5rwUszvTZ1rxbN2cv5dRYxIjw70/B/nyV9m8CFjL4nX1eoZ/RW9tl8TPKynezxV0hNOP8AAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Wed, 08 Mar 2023 15:13:16 +0800, Jiapeng Chong wrote:
> Variable 'cmd' set but not used.
> 
> fs/locks.c:2428:3: warning: Value stored to 'cmd' is never read.
> 
> 

Seems unused for quite a while. I've picked this up since there's a few other
trivial fixes I have pending. But I'm happy to drop this if you prefer this
goes via the lock tree, Jeff.

[1/1] fs/locks: Remove redundant assignment to cmd
      commit: dc592190a5543c559010e09e8130a1af3f9068d3
