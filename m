Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C492C72F7DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbjFNIaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjFNIai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E1811F;
        Wed, 14 Jun 2023 01:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 489D163EEB;
        Wed, 14 Jun 2023 08:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3A5C433C8;
        Wed, 14 Jun 2023 08:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686731436;
        bh=5sOkTNkkHBdbRw2JX2dJi2tKIH7ENjxXYhVFqEgiEpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRZqPUqU0BwUN9jHEoglWuy0xEgoYyag/Ebn+rb0Vkv1pU4YIEbzbp79ipCyUrtxh
         uu5SSmyKUoI1KIaFNYpCGmYHIXb2asmRHSE1NzBkLRpCt3Lk6SOguRjQnw2e7R7/RE
         3jA20kzbdthCOfDkyHAr2RIu4FsSLyLI6XH8DA2HcU29jUMoC2mD9jrm9rg2mkUfCC
         fiHIUATN1wcmkhYcliwSeMfAeYVI8hK2mr8m3NIMM3pMKtWaDqvzxe5VRX3IwZIRDp
         k6p3K+ytT5NuIM6/QXPL9ncD1YxYtMcfr5ZIYEUleDDbnRtoLwM75vc9NwENqU3Y1d
         e+ig0BIIgMwMg==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
Subject: Re: (subset) [PATCH v2 3/8] autofs: set ctime as well when mtime changes on a dir
Date:   Wed, 14 Jun 2023 10:30:13 +0200
Message-Id: <20230614-marmeladen-blechnapf-873c26e176cb@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612104524.17058-4-jlayton@kernel.org>
References: <20230612104524.17058-1-jlayton@kernel.org> <20230612104524.17058-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=brauner@kernel.org; h=from:subject:message-id; bh=5sOkTNkkHBdbRw2JX2dJi2tKIH7ENjxXYhVFqEgiEpg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0VvWrXuWb1qASt//kd4FHqU18By+ppS/RFud89ejpqjjT Z+/1O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby5Bgjw7qZ1+/qxD5ZFinJah7vuf 6TQM5RjfV3nHf+b3iWcMttHxfDb9bHk9/X5L+18DmgM//eoU3cO9eIMDluPBbqbjtNMHa/Fg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Jun 2023 06:45:19 -0400, Jeff Layton wrote:
> When adding entries to a directory, POSIX generally requires that the
> ctime also be updated alongside the mtime.
> 
> 

Can't find a tree for this patch, so picking this patch up unless told otherwise.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[3/8] autofs: set ctime as well when mtime changes on a dir
      https://git.kernel.org/vfs/vfs/c/9b37b3342a98
