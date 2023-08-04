Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BCE770398
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjHDOyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHDOyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C6AC;
        Fri,  4 Aug 2023 07:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F356202B;
        Fri,  4 Aug 2023 14:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923CDC433C7;
        Fri,  4 Aug 2023 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691160848;
        bh=/A3qS41Wbg0RJTKLzWIKOhvA9E5C5Eirh8hdQs8lvD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gn/4lcbKDD8CK/J/jQjQifgr4sKQVpXQDkRtMiztsFC3EnM1y52AJDoCU7rO7heYX
         bXNm1j4dSQkKbfrV/la/TCWgiBCoPDhR/fJDI0C+5tM/d5WA5wTCxqN71ECdO8ysft
         tHm/2LN1RYouF4qBn3PwY2v/3mrEY6cW0HRcdxU+g1t1uqo3+m3VhMveBlVWDKcrGB
         9jeWh4z2yc7AJ781ROdN6l4R7O4+dVWSJCVJSy4LU6rCTvdfDKYmx9kW0z3z1yLp/f
         hBXUqstV9DgRJLJc+YRbiJ4qOjcE7sJ1FgnG62Bd1AccRso7W+mq4PR+UYZWgRtCbS
         M7+z5GbUrI9XA==
Date:   Fri, 4 Aug 2023 16:54:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     xiubli@redhat.com, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/12] ceph: add enable_unsafe_idmap module parameter
Message-ID: <20230804-erdtrabanten-mitunter-12aa02867edc@brauner>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
 <20230804084858.126104-5-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804084858.126104-5-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:48:50AM +0200, Alexander Mikhalitsyn wrote:
> This parameter is used to decide if we allow
> to perform IO on idmapped mount in case when MDS lacks
> support of CEPHFS_FEATURE_HAS_OWNER_UIDGID feature.
> 
> In this case we can't properly handle MDS permission
> checks and if UID/GID-based restrictions are enabled
> on the MDS side then IO requests which go through an
> idmapped mount may fail with -EACCESS/-EPERM.
> Fortunately, for most of users it's not a case and
> everything should work fine. But we put work "unsafe"
> in the module parameter name to warn users about
> possible problems with this feature and encourage
> update of cephfs MDS.
> 
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Suggested-by: Stéphane Graber <stgraber@ubuntu.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Seems good enough,
Acked-by: Christian Brauner <brauner@kernel.org>
