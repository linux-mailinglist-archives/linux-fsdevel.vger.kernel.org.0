Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A62604477
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 14:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiJSMGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 08:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiJSMGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:06:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1E2A736;
        Wed, 19 Oct 2022 04:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FB63B8232F;
        Wed, 19 Oct 2022 11:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DE2C433D6;
        Wed, 19 Oct 2022 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666178003;
        bh=gwWQYsR0cFT+Zg0Jf4VUsE9sbimCLeyihcb3NxLQ1bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkxpNMtg/ua1pzhePdDJ0iGKaywwzRgyDRItzUlReJKLluskVPzhcFMDrozMIWxnj
         wMFF2fDxagUDmCy0O73ZsUaW6Bf9IlElbH/Oq0baglYcv29qrWk6sEKcw1zI/1AVDI
         ioUtRU9IYCsQfTz9O7NpLJxD2EjKrTUSLNwqY4CaT+HUzGS+AMcI/UI+NhIJp+nqZO
         Wyqa2AIfbTVj7dtopzyG1xoeLP4Js4x2B4VhzcfPIJmCnBqyuIvyVS1YsYz4Inpsok
         5683FsxRZnmNM/v0kb1C9nbosQn6pyzrsWMFUm6tJ+QILcAUGrLK+mOCGwTpOD12Me
         6RK5CvIgp6+nw==
Date:   Wed, 19 Oct 2022 13:13:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 0/9] fs: clean up handling of i_version counter
Message-ID: <20221019111315.hpilifogyvf3bixh@wittgenstein>
References: <20221017105709.10830-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221017105709.10830-1-jlayton@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:57:00AM -0400, Jeff Layton wrote:
> This patchset is intended to clean up the handling of the i_version
> counter by nfsd. Most of the changes are to internal interfaces.
> 
> This set is not intended to address crash resilience, or the fact that
> the counter is bumped before a change and not after. I intend to tackle
> those in follow-on patchsets.
> 
> My intention is to get this series included into linux-next soon, with
> an eye toward merging most of it during the v6.2 merge window. The last
> patch in the series is probably not suitable for merge as-is, at least
> until we sort out the semantics we want to present to userland for it.

Over the course of the series I struggled a bit - and sorry for losing
focus - with what i_version is supposed to represent for userspace. So I
would support not exposing it to userspace before that. But that
shouldn't affect your other changes iiuc.
