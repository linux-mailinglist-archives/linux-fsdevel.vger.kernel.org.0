Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC16D447C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 14:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjDCMeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjDCMeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91656197
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 05:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5838161A40
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 12:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B79C433EF;
        Mon,  3 Apr 2023 12:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680525243;
        bh=A4yxim+Df4LNcC7uLPEDuZHC4+/karCiWJvO1YmRups=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjI3mp4B9bQ1qB7DeHCmg3yBmNfjd6LEl1XpM4ntZPrGwA3QJU9Pp0OPl+w+8yRA7
         XfpTmZleIcA8jD9NLRQ88Q2xlbUK32msHUSyIjM7QNjNiG28u8rIL5KCn55Z/GqxL0
         9PqkjWTnT0YjbJsJs1i2ODRIza6x/NgVZn1CjXuBm7PUBFMkbYkk39lTwW+B/+/Xfv
         xk7uESauqWMvy3iIBlQP7mWIO/RI3seNOxwRVgDV8FajJ7YOm1qiBkw5+oBoMW21k3
         hLPJKidNi7n1hkk1GclEz+5stt0k84mHXFMUicUIs429FP0EY9lRIa/MXe+z3XU8HX
         yidGz/Z/tAi0Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Chung-Chiang Cheng <cccheng@synology.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, shepjeng@gmail.com,
        kernel@cccheng.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] splice: report related fsnotify events
Date:   Mon,  3 Apr 2023 14:31:41 +0200
Message-Id: <20230403-albatross-unusable-75d4f6bdaa92@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322062519.409752-1-cccheng@synology.com>
References: <20230322062519.409752-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=383; i=brauner@kernel.org; h=from:subject:message-id; bh=Uo3NwmZtWGB7lTFo2b/P8BkGigwKI8wmQRjU5P1P59A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRoHRcttFOZ2/bCabdK1okOVdd1VxYuKpix6JdnlvTSuApp 35TkjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkE/GL4H9pxQ2XJj5UPFSYqT/T3kQ o5I/PwtUzCl8fflos1lPfNmMPI8G19scqBqJR8T1Ydq/OTA0rW1t7O3uCzIlz2sJLg/fe/eAE=
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


On Wed, 22 Mar 2023 14:25:19 +0800, Chung-Chiang Cheng wrote:
> The fsnotify ACCESS and MODIFY event are missing when manipulating a file
> with splice(2).
> 
> 

I've picked this up,

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc
[1/1] splice: report related fsnotify events
      commit: 4f61a69edcf33a66269f65500434b584ee8d405e
