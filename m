Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1035878B05F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjH1Mb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjH1Mbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA3189;
        Mon, 28 Aug 2023 05:31:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7706A61414;
        Mon, 28 Aug 2023 12:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBDDC433C8;
        Mon, 28 Aug 2023 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693225846;
        bh=T9DfSbmWQGLkXxxawCTqh4iy6bnZSsXXChHmtZR5SvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRbbO/TIyio+cPX7Pp68MCWNSqs6AILAUjVcwJJsGCI0lYRaQE4+LNbRiDcg15ySX
         H4L6cOyeCfDogNV/R7zflpINPktSWynphtaZ2ePSYsqxTFzYYHlMTvGpZCebGUjtfT
         8V6Q1anGqsBdB/OgMuTelmiWFLcYEBoKcnqbM8tTFVUZOPjfG60KS0576heHHjd5ZL
         T4kcCsMlUULMPuGAGDubE0wgpGjJbVM1ZEBUfWOCf/CJx8KgXGNM99YuatbAzNTCpp
         0fdSw+muVyTQPaq5vAp2Z4p6A8chvo2679l+UcPh7PBKUGyRrHi4a1AIeA8MrRlraI
         RbqRdGOqS4dpg==
Date:   Mon, 28 Aug 2023 14:30:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: use helpers for calling f_op->{read,write}_iter()
 in read_write.c
Message-ID: <20230828-alarm-entzug-923f1f8cc109@brauner>
References: <20230828155056.4100924-1-shikemeng@huaweicloud.com>
 <ZOyMZO2i3rKS/4tU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOyMZO2i3rKS/4tU@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:00:36AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 28, 2023 at 11:50:56PM +0800, Kemeng Shi wrote:
> > use helpers for calling f_op->{read,write}_iter() in read_write.c
> > 
> 
> Why?  We really should just remove the completely pointless wrappers
> instead.

Especially because it means you chase this helper to figure out what's
actually going on. If there was more to it then it would make sense but
not just as a pointless wrapper.
