Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C26CFC0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 08:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjC3G5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjC3G5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:57:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B465B7;
        Wed, 29 Mar 2023 23:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8CD7B82600;
        Thu, 30 Mar 2023 06:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B54C433EF;
        Thu, 30 Mar 2023 06:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680159429;
        bh=dRxto1nKOBv47Hgtnxtl36FhSOrP9QavSk0iDsliXGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzvXgy54cpqTFF1OzYug+6fWtlmk7w3vi8ZPTWfSO5aqM06+zhuEpJowQ4PjFF576
         BvvZYWv4gPtoKeg36pw9+5G9LXf/2i6liGdcDKLpkaaWlfPXxTO16yCYSEegweYl1S
         Nqxg1bd79bYgaINS/UY+6GgDNIH9fWcrPw1dGjBhhzEOFLJyB2Y9eu2Ytqpgch4SFY
         kPBhCm/I5QvXEO4EzCUQyIWrLLZGx64O8DVocq/91Ou/U8yhXkdv2aqoV2bhY+sVod
         hOHG5LjD3aYLuZda3gtkvLlcieDjJlAW6uzZYm/U/EkiaB1NQ2clhNSLNWxT08k6MU
         uK4SXFjwKIIYQ==
Date:   Thu, 30 Mar 2023 08:57:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfs: use vfs setgid helper
Message-ID: <20230330-nifty-radiator-fffd92d2b2fa@brauner>
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yNyLgGjEDjRE400I25HPN4HDcYoV0hPW9uuPEycb/yU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSoGlX/vN1e7ViiwuXzxm2/t8SSXb8+9tufFT+R15Jna13v
 npzRUcLCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJF/Kxj+6a2wrU24n5jM1WEy97dLWP
 2mA/IPuIrDjkTblU49lTrFg+G7+4klAXcPcLgHGB77fp0xTFtavO3344W/n9/VETrV684HAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
References: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Tue, 14 Mar 2023 12:51:10 +0100, Christian Brauner wrote:
> We've aligned setgid behavior over multiple kernel releases. The details
> can be found in the following two merge messages:
> cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2')
> 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0')
> Consistent setgid stripping behavior is now encapsulated in the
> setattr_should_drop_sgid() helper which is used by all filesystems that
> strip setgid bits outside of vfs proper. Switch nfs to rely on this
> helper as well. Without this patch the setgid stripping tests in
> xfstests will fail.
> 
> [...]

So I've picked this up now,

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc
[1/1] nfs: use vfs setgid helper
      commit: 4f704d9a8352f5c0a8fcdb6213b934630342bd44

Thanks!
Christian
