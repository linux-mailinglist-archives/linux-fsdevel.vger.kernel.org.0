Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A815465E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiFJLjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349058AbiFJLi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:38:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C482179
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 04:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4AF4B8346F
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 11:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C67EC3411D;
        Fri, 10 Jun 2022 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654861111;
        bh=5fGIjil6fh7KZBlHpIHwqsqbU1qaqlN3L2t7auBx5UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2EtPJyDPd/8kulu8Cpy1WuJCR9xjlaeJIhuzU4JrqdwN50kRbwgv8h7z8+cq0Ddj
         mSVyCdhmBDpdbuxXGgG2x/DmAlPGTr2lKSJhaZqckSxNSYgz5oZGOOvt09YPQUTnhS
         455f3bc1ysmsjop3LPjc/PfwUoAiUVBzbN7BMSSBMlcRREZG58bJsILGz7C8uMDIY/
         imAFZrRiH+WjqbDDXHqwy7vJXf1eVrFCO7CXqYybZsO3o6vNF4KySdGdDmX0QRlZMk
         6kduv7rDBkTCnyuthh2UnsdsH+3Ecz77HcodF+ba9hEyBoybdoGTMvbzBf3J12eLE8
         Rm0B+uuuTF+ZQ==
Date:   Fri, 10 Jun 2022 13:38:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 02/10] teach iomap_dio_rw() to suppress dsync
Message-ID: <20220610113822.6jo62kjtisnm5qpp@wittgenstein>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
 <20220607233143.1168114-2-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607233143.1168114-2-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:31:35PM +0000, Al Viro wrote:
> New flag, equivalent to removal of IOCB_DSYNC from iocb flags.
> This mimics what btrfs is doing (and that's what btrfs will
> switch to).  However, I'm not at all sure that we want to
> suppress REQ_FUA for those - all btrfs hack really cares about
> is suppression of generic_write_sync().  For now let's keep
> the existing behaviour, but I really want to hear more detailed
> arguments pro or contra.
> 
> [folded brain fix from willy]
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
