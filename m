Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B4601FEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 02:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJRAxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 20:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJRAxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:53:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E099B816B6;
        Mon, 17 Oct 2022 17:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60096B80DAC;
        Tue, 18 Oct 2022 00:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D01C433C1;
        Tue, 18 Oct 2022 00:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666054366;
        bh=uxY/367ILC9MijFRSeHxRt+n73GNDXQPlO80EctYxss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kF4b9k+Mcf6aXpz1PsDID2GTUSxrQRRM8AWedfKXS8oxhNkqV8+uw+gZtNT8uHraO
         XLXGdljsHj/psr7KaN/AJcGD1tUu+UPhzuFvaF48thXts3ZA0b8o46p0pBTPYmd+w2
         W+IIxWVUq10RZ/t+9FbOg2vuG1ZeuldZCftPTHYGljPoFdtCCt4bQ7dZ7vCF2c7y2+
         Ici8JFR3U1QZ2QAyLMaCCWVLi1nVo3MvHSMU7k4Fi7K1BtZBLDkCK6JixE0v3p8mrB
         KlieMCL+ETjbB9LKMpeIbgM9jBtfvtsyMsUUaoq6AsaZ77v6CqreajiIVj1TtOaX9Y
         JRjtvjFMfV7kA==
Date:   Mon, 17 Oct 2022 17:52:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+104c2a89561289cec13e@syzkaller.appspotmail.com
Subject: Re: [PATCH] fscrypt: fix keyring memory leak on mount failure
Message-ID: <Y0343O5W7ehNUDP8@sol.localdomain>
References: <0000000000009aad5e05eac85f36@google.com>
 <20221011213838.209879-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011213838.209879-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:38:38PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
> fscrypt_master_key") moved the keyring destruction from __put_super() to
> generic_shutdown_super() so that the filesystem's block device(s) are
> still available.  Unfortunately, this causes a memory leak in the case
> where a mount is attempted with the test_dummy_encryption mount option,
> but the mount fails after the option has already been processed.
> 
> To fix this, attempt the keyring destruction in both places.
> 
> Reported-by: syzbot+104c2a89561289cec13e@syzkaller.appspotmail.com
> Fixes: d7e7b9af104c ("fscrypt: stop using keyrings subsystem for fscrypt_master_key")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied to fscrypt.git#for-stable for 6.1.

As usual, I'd greatly appreciate reviews though...

- Eric
