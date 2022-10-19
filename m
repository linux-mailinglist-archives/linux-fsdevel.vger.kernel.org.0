Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211C16045EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiJSMwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiJSMv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2515A18B770;
        Wed, 19 Oct 2022 05:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E80D61856;
        Wed, 19 Oct 2022 12:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0384CC433C1;
        Wed, 19 Oct 2022 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666181899;
        bh=NFx7T5AV9TikRajerIi5olcWAo+wSsuF+tytHODHH38=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nOo1Jz+UyXwVHHtW++IKcWZBt19vd6ZBVFIaSn8D07FUWrQEve3Bf++KiBzlELiSt
         Q8S+ehdSo69noRSLSnbT4trkoSrnL8euyTk3Wr2nrYrEQ5SvCg3QJ2llYolCkH2hTx
         lGns8jIcYH7eMaRVK78MIsvy0Pgbolv+g3nHIL3d281e+0qtfI43S+mTE2EMhRL0DG
         JhD6qd6L2dnklpO27Dbf3UjVLfOgKMoL8yTX1HJ/xjgIAilk+QbpvBjGA9FGiUPCyJ
         5u1Rq8HsOG7WWUWGvPVxIVIJUj5AdHiiGWfRRKPrP2rAB5iAXA8F3dUhnC7jNV/MY2
         MOwKXym29YQwg==
Message-ID: <2b167dd9bda17f1324e9c526d868cc0d995dc660.camel@kernel.org>
Subject: Re: [PATCH v7 0/9] fs: clean up handling of i_version counter
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Wed, 19 Oct 2022 08:18:15 -0400
In-Reply-To: <20221019111315.hpilifogyvf3bixh@wittgenstein>
References: <20221017105709.10830-1-jlayton@kernel.org>
         <20221019111315.hpilifogyvf3bixh@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-10-19 at 13:13 +0200, Christian Brauner wrote:
> On Mon, Oct 17, 2022 at 06:57:00AM -0400, Jeff Layton wrote:
> > This patchset is intended to clean up the handling of the i_version
> > counter by nfsd. Most of the changes are to internal interfaces.
> >=20
> > This set is not intended to address crash resilience, or the fact that
> > the counter is bumped before a change and not after. I intend to tackle
> > those in follow-on patchsets.
> >=20
> > My intention is to get this series included into linux-next soon, with
> > an eye toward merging most of it during the v6.2 merge window. The last
> > patch in the series is probably not suitable for merge as-is, at least
> > until we sort out the semantics we want to present to userland for it.
>=20
> Over the course of the series I struggled a bit - and sorry for losing
> focus - with what i_version is supposed to represent for userspace. So I
> would support not exposing it to userspace before that. But that
> shouldn't affect your other changes iiuc.

Thanks Christian,

It has been a real struggle to nail this down, and yeah I too am not
planning to expose this to userland until we have this much better
defined.=A0Patch #9 is just to give you an idea of what this would
ultimately look like. I intend to re-post the first 8 patches with an
eye toward merge in v6.2, once we've settled on the naming. On that
note...

I believe you had mentioned that you didn't like STATX_CHANGE_ATTR for
the name, and suggested STATX_I_VERSION (or something similar), which I
later shortened to STATX_VERSION.

Dave C. objected to STATX_VERSION, as "version" fields in a struct
usually refer to the version of the struct itself rather than the
version of the thing it describes. It also sort of implies a monotonic
counter, and I'm not ready to require that just yet.

What about STATX_CHANGE for the name (with corresponding names for the
field and other flags)? That drops the redundant "_ATTR" postfix, while
being sufficiently vague to allow for alternative implementations in the
future.

Do you (or anyone else) have other suggestions for a name?
--=20
Jeff Layton <jlayton@kernel.org>
