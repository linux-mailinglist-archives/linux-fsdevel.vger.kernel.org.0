Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C798A764FB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 11:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjG0J2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 05:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjG0J2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803F1FCF;
        Thu, 27 Jul 2023 02:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D58F61DE4;
        Thu, 27 Jul 2023 09:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216E1C433C7;
        Thu, 27 Jul 2023 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690449496;
        bh=7AOX6GceYFRKfymaMBDSBPhRIqlYLcp4TjwIXpl6PLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIfc5G3xBBL25OGjqn0XHlbtbZ9nB53ZI3gGFv7vkgVOsz7lUxi4qOcjfn7lK5Mgh
         wwoT3V5gYlWddJKTHNmMczMWwdGL99/ijGE69xGsXtxS3+RAML/zIeCBq/o1fUlDjC
         JEMh3asevxuEd3nvrPET5trnD9C4OR/SOLoi4f8iabslbQnf4FNiURYHKqF1kbeBo9
         wAT0TJLMg6L/YPgfaWR/E5OxB4t3eNjPdIM+eeNAlxltgHf4zBUO4Py9mXR/b1HBM4
         yhV5NDe9jUIgoHn7yi3TMH5zIC5BY1q0bEK2PYRbnI2HQfRhuy2PmUDxgoW89ASQJ4
         hJuCqbyXaLuFQ==
Date:   Thu, 27 Jul 2023 11:18:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: disable per-CPU buffer_head cache for
 isolated CPUs
Message-ID: <20230727-obsiegen-gelandet-641048c042f4@brauner>
References: <ZJtBrybavtb1x45V@tpad>
 <ZMEuPoKQ0cb+iMtl@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMEuPoKQ0cb+iMtl@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:31:26AM -0300, Marcelo Tosatti wrote:
> 
> Ping, apparently there is no objection to this patch...
> 
> Christian, what is the preferred tree for integration?

It'd be good if we could get an Ack from someone familiar with isolated
cpus for this; or just in general from someone who can ack this.
