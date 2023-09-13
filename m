Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05A879EF3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjIMQr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjIMQre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:47:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F11F2D5B;
        Wed, 13 Sep 2023 09:45:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8823FC433C7;
        Wed, 13 Sep 2023 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694623507;
        bh=HobAkM29rx8Gfvxd/6qv1vbDG0f2vYW8jT23Uqkvcxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FK4SqG7nEC+kxqYGM6WUizs/TU8PQPvEKFIMJhEKheQ5nEDdCrYDY2bVi5wOic6tB
         fApwJS26mOBT9LweldFSfQ/dRc2Su5tD5pfbtbcTBS7qvoeZZJHU+N4p2tmPUZGnZV
         DjDz0Wxg3VrOOWnut8BR9Rjmrfl3LakaGiM6CUIZ9pn7HpqlgmPItDJMTLxdib1T19
         1nbNrD6nhb3dzpj+LAQ3tiAkMN/8z5HTOwGwztyZEBovyEC0q5jc8eWgBxgnj9BdO7
         Iuf0seqyRuUNgaVQ/uMUQhiMwbEnlgV+y+NqpmldKJr93uxGEMVbMsL7gYXQzjy0Gm
         rtY2f1TBgKbyQ==
Date:   Wed, 13 Sep 2023 18:45:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
Message-ID: <20230913-hausbank-wortlaut-b2bb3cee6156@brauner>
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:33:12AM -0400, Jeff Layton wrote:
> Nathan reported that he was seeing the new warning in
> setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> trying to set the atime and mtime via notify_change without also
> setting the ctime.
> 
> POSIX states that when the atime and mtime are updated via utimes() that
> we must also update the ctime to the current time. The situation with
> overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
> notify_change will fill in the value.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

So we can wait for ovl to upstream this fix next and then we'll delay
sending the ctime fixes or we'll take this fixup as well. Just let me
know what you all prefer.
