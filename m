Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A35A79EFCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjIMREf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMREd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:04:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1906CE;
        Wed, 13 Sep 2023 10:04:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ECAC433C8;
        Wed, 13 Sep 2023 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694624669;
        bh=7rv3Solh0betRWknM4KbpX2Yzq/6PuTa+8pHyrMJGLA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QVJnA+aBoPDbHvk8YrLqfUO2xt+TBAZSJweq0lY30J46pjlEIWz3WjieCmseON/88
         ylqNWd3Laqfh+ek+uk2rL22H18Z85BL7UfSb2gVDwUXpEVyORdsFZZcEuOMXkrNchE
         G/cYB0p2d05fshkD+v+Em9SVX3aKdTCEriBBlgAAVk5WfLZf2nevRk2F1LYhY0EZtk
         GvD91tOsCEJSP4pnT1hbbFVThhMaOCPNLXIT0xtdBNrW8XZI3VP8+EqiNkKwU1QHTP
         sQmVfyt/mJcyLPUIsIZF/9Uuepm1Ra4kKz6ie5D1prKqWtU41V+f3jHT4Cf3npsv+M
         JClNNDAK/RJng==
Message-ID: <c57b71b5109942d7c66d8466fb26f82211c1a175.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Sep 2023 13:04:27 -0400
In-Reply-To: <20230913-hausbank-wortlaut-b2bb3cee6156@brauner>
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
         <20230913-hausbank-wortlaut-b2bb3cee6156@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-13 at 18:45 +0200, Christian Brauner wrote:
> On Wed, Sep 13, 2023 at 09:33:12AM -0400, Jeff Layton wrote:
> > Nathan reported that he was seeing the new warning in
> > setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> > trying to set the atime and mtime via notify_change without also
> > setting the ctime.
> >=20
> > POSIX states that when the atime and mtime are updated via utimes() tha=
t
> > we must also update the ctime to the current time. The situation with
> > overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
> > notify_change will fill in the value.
> >=20
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
>=20
> Looks good to me,
> Acked-by: Christian Brauner <brauner@kernel.org>
>=20
> So we can wait for ovl to upstream this fix next and then we'll delay
> sending the ctime fixes or we'll take this fixup as well. Just let me
> know what you all prefer.

No preference here.
--=20
Jeff Layton <jlayton@kernel.org>
