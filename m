Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0F6026B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 10:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiJRIXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJRIXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:23:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75597EE0;
        Tue, 18 Oct 2022 01:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64F45B81CF5;
        Tue, 18 Oct 2022 08:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CAAC433C1;
        Tue, 18 Oct 2022 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666081407;
        bh=as9MNqUMNCq1qKnJdcipQlMZmCmn8gYjpbIwciJC+Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNMWUGQSooEvophmAkrlPkAV3PWJ9KeN/qlS1WgAJxW0SVServCVLO26QXy0+OwVi
         /WRNrCsWh1BbI5MZqOKGLzbrVd89B2Z+LSrnVOaTBWgJZjZqxTKN0M/hh938YdzUxE
         dSsBkvoKXvbcqoo+spefFkwBdYK1KBWn41sJCD9WpiEGsjxWsErU70IU5dswyizKkF
         ySZ6eImodTw3UjKtWatzMhV4hqPrkHi8CYNql9Dj+fNcibGGmH9eY/Z6k+1Fx+Y1lY
         bPhNnSNkN1bzoNSZ+LZVcTXwayLu0dWdAHzJzEYfJqlOaTgfNnRwQMxxRoujW9ELW4
         Wi8m/Y14y3/nw==
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] fs: improve setgid stripping consistency even more
Date:   Tue, 18 Oct 2022 10:23:19 +0200
Message-Id: <166608119375.133411.9449517018139699237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017150640.112577-1-brauner@kernel.org>
References: <20221017150640.112577-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=brauner@kernel.org; h=from:subject:message-id; bh=IFb4/lUl7ETN6ADW8OY+Cy8jew7Axe5AazE6Z37+OPk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7JRXviV+z2XH9BU6n0uWJ866s3DxFjd/b34TxxuOQ3aL3 HnCu7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIMR/D/8yyGbq9iy85bA+fGsfsVi S5u37rOUF23WOb/ll9vjTvigDD/9Lnu6L+b1m+J7lhytm52kY3jy88EubiYmLOJcmuYVXFyw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>

On Mon, 17 Oct 2022 17:06:33 +0200, Christian Brauner wrote:
> From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> 
> Hey everyone,
> 
> A long while ago I found a few setgid inheritance bugs in overlayfs in
> certain conditions. Amir recently picked this back up in
> https://lore.kernel.org/linux-fsdevel/20221003123040.900827-1-amir73il@gmail.com
> and I jumped on board to fix this more generally. This series should
> make setgid stripping more consistent and fix the related overlayfs bugs.
> 
> [...]

Moving this into a branch for some -next exposure:

[1/6] attr: add in_group_or_capable()
      commit: 11c2a8700cdcabf9b639b7204a1e38e2a0b6798e
[2/6] fs: move should_remove_suid()
      commit: e243e3f94c804ecca9a8241b5babe28f35258ef4
[3/6] attr: add setattr_should_drop_sgid()
      commit: 72ae017c5451860443a16fb2a8c243bff3e396b8
[4/6] attr: use consistent sgid stripping checks
      commit: ed5a7047d2011cb6b2bf84ceb6680124cc6a7d95
[5/6] ovl: remove privs in ovl_copyfile()
      commit: b306e90ffabdaa7e3b3350dbcd19b7663e71ab17
[6/6] ovl: remove privs in ovl_fallocate()
      commit: 23a8ce16419a3066829ad4a8b7032a75817af65b

Thank you for commenting and reviewing!
Christian Brauner (Microsoft) <brauner@kernel.org>
