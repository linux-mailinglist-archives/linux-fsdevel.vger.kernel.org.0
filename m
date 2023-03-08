Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39876B04EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 11:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCHKsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 05:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjCHKsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:48:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FCA2ED67
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 02:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B0F4ECE1F0D
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 10:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD887C433D2;
        Wed,  8 Mar 2023 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678272482;
        bh=qxNoCraFJ5yovgheOm7XmgzRBTLRL5Siv4nfldmQb5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlViI7xOq3av/dNTXeudELbSS1YXEkAluPvPxduxSYHaE95j8CuZpFTbp4oXmYYnK
         4CrkBTuPtNMD4JsPv1t0qC+3Lfo+cfyh51dDOPo+l/m26MtPSPgCKPcZZFvvf9szOa
         3jX6PJu40PnE8jxcaVcRxjuczalpx8tjXFDBMeaavO2Q/X4EIfo3fihs0b8KmKB+de
         Y3ockSM9DJLwMBtmAkivDHR+nNpLsY/m691olbKm1V6kDNu7Dv0N8/pnwBqOZdBCqN
         oLu7VWOwYNF4/GGwnOJbXD0HOFMQmrdNtQq37k0LtK1DudQOTcctFX0FZSScDmWSSl
         nNQqqrH30bPzQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        David Disseldorp <ddiss@suse.de>
Cc:     Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] watch_queue: fix IOC_WATCH_QUEUE_SET_SIZE alloc error paths
Date:   Wed,  8 Mar 2023 11:47:55 +0100
Message-Id: <167827232250.714110.2196458192251440824.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307152106.6899-1-ddiss@suse.de>
References: <20230307152106.6899-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=605; i=brauner@kernel.org; h=from:subject:message-id; bh=Qn0J5j2g+fixlcfGVUxT5TxOPwBM+m4RXniRJx2hTPw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRwpG98mra40EuAR2GbueayZKFXhT5RpTEvtq199KRv6Z+q I4cCO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai+5CRYaXvk/vH2uv0/yhs/hBRdZ y59u3XQjFj3TfXEt9mXSi4JMfwz0A+eMm8kPDKQz61s44EhjNMO7v1grDH+QWnNwQ/dl2/hQkA
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


On Tue, 07 Mar 2023 16:21:06 +0100, David Disseldorp wrote:
> The watch_queue_set_size() allocation error paths return the ret value
> set via the prior pipe_resize_ring() call, which will always be zero.
> 
> As a result, IOC_WATCH_QUEUE_SET_SIZE callers such as "keyctl watch"
> fail to detect kernel wqueue->notes allocation failures and proceed to
> KEYCTL_WATCH_KEY, with any notifications subsequently lost.
> 
> [...]

Unless someone got to it before me, I've now picked this up:

[1/1] watch_queue: fix IOC_WATCH_QUEUE_SET_SIZE alloc error paths
      commit: 03e1d60e177eedbd302b77af4ea5e21b5a7ade31

Thanks!
Christian
