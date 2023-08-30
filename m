Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7578DAF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbjH3SiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242854AbjH3JvG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E81B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 02:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D138A60B20
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 09:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BE5C433C7;
        Wed, 30 Aug 2023 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693389063;
        bh=ehF1qeecU8C9Dk3tvvD0cjYP9mJCNsSMX4fo+qTQ0VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENChhhxspR7hLye0MICDkGdbfnt+U6kq3HzpEaKQKcPodnPtQoPoBMQoWkmSmp9e4
         j+KRmCMQ3mNq48zt1xkRmXocFkn87B4WwTO1RLaQrfHKYigEZAfvB3WltkOQhpnPy+
         vIZaZu8BoGwpuwmv+DnVXhLC8EJnla3L5BvY8kwTROR1NyOZMMcfGvlKpuqBAMYNMB
         7HFLqMA0DRf9F9J6/cMy80y8QCB7milHwLHkr9IhWn6Cy+QV7avOdI/FWNe7fMigzn
         Gc08LyC/ECbuGynnX67zKP62MAY1vX1IhmOZhRNT5Fq93t86q0/KNEWu03/U3LQAY8
         VuN1yXscoeeqA==
Date:   Wed, 30 Aug 2023 11:50:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] mtd: switch to keying by dev_t
Message-ID: <20230830-strahl-turnier-8e082a720041@brauner>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I plan on taking this upstream as a fix during the merge window.

Btw, I tested this all with jffs2:

sudo flash_erase -j /dev/mtd0 0 0
sudo mount -t jffs2 mtd0 /mnt

and then some variants with racing umounts and mounts.
