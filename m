Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF5C60444D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJSMBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 08:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiJSL7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:59:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E4E129741;
        Wed, 19 Oct 2022 04:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEA90B82325;
        Wed, 19 Oct 2022 11:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D96C433B5;
        Wed, 19 Oct 2022 11:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666179397;
        bh=1u/C5nVuSOViooeK4YNtQMbHDMKvy++Dv8cZcqjakKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyJciBHE0mwnlIMcQaBjaTLKgXRF17XAqgSXsHGdJ+0l+Iu9MNcw3H5ZSeTbywpx0
         T9CK7VrK7thyRppIrbhkVhHvfh/4xd+HaJw4SZny9adchpWxMrwAGO6GQY364GlVA4
         Jp5QLyLkWOk7Bpq660A6CA1aihyFZuob4DDdMVpw4SC4Cr3Wy6GGcMZKIeIK8aFbfL
         6lP1BdIE5ZBfftNPedtJ81CdECx6vUu7vHhRSm3OFpRwmzbJIA99qHcdIf408ExSRC
         Clga2oTETymK9UUcuoAmuY7JkUyAQHzWsFAywSyCGo63BfPSDHL/wHHITyMJ02MNH7
         adRfXyuR+aJ+w==
Date:   Wed, 19 Oct 2022 13:36:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+104c2a89561289cec13e@syzkaller.appspotmail.com
Subject: Re: [PATCH] fscrypt: fix keyring memory leak on mount failure
Message-ID: <20221019113633.jt6khltk6nsy666p@wittgenstein>
References: <0000000000009aad5e05eac85f36@google.com>
 <20221011213838.209879-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
