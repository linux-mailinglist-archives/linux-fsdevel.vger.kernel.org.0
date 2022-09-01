Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEA95A9CC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiIAQMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiIAQMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F0A5F11B
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662048762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHmYOlxrBiaepineueJ+BA2NniHKUIf3ILRk7FlgVfY=;
        b=RNGOhtRH/3VpensV9IssdAWKcOStK3ETAmCknBdl6XFhcibLGEThYjIgRWehavWp0ZNFLS
        paUCmU2HuGOb4O2+XdS2sDydCf2kW8Mt3ksp7liSP0pVI02RW85IzSLtCyTqBdLXjAGz/o
        W+62DR3vNYMtbP6i+g/gPfzlCkHtoqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-Du0mSLDPMe-xNlqIJu9UJw-1; Thu, 01 Sep 2022 12:12:40 -0400
X-MC-Unique: Du0mSLDPMe-xNlqIJu9UJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8FEF80A0AE;
        Thu,  1 Sep 2022 16:12:39 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 301FE40CF8F2;
        Thu,  1 Sep 2022 16:12:34 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH v2] statx, inode: document the new STATX_INO_VERSION
 field
References: <20220901121714.20051-1-jlayton@kernel.org>
Date:   Thu, 01 Sep 2022 18:12:33 +0200
In-Reply-To: <20220901121714.20051-1-jlayton@kernel.org> (Jeff Layton's
        message of "Thu, 1 Sep 2022 08:17:14 -0400")
Message-ID: <874jxrqdji.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeff Layton:

> @@ -411,6 +413,21 @@ and corresponds to the number in the first field in one of the records in
>  For further information on the above fields, see
>  .BR inode (7).
>  .\"
> +.TP
> +.I stx_ino_version
> +The inode version, also known as the inode change attribute. This
> +value must change any time there is an inode status change. Any
> +operation that would cause the
> +.I stx_ctime
> +to change must also cause
> +.I stx_ino_version
> +to change, even when there is no apparent change to the
> +.I stx_ctime
> +due to coarse timestamp granularity.
> +.IP
> +An observer cannot infer anything about the nature or magnitude of the change
> +from the value of this field. A change in this value only indicates that
> +there has been an explicit change in the inode.

What happens if the file system does not support i_version?

> diff --git a/man7/inode.7 b/man7/inode.7
> index 9b255a890720..d5e0890a52c0 100644
> --- a/man7/inode.7
> +++ b/man7/inode.7
> @@ -184,6 +184,18 @@ Last status change timestamp (ctime)
>  This is the file's last status change timestamp.
>  It is changed by writing or by setting inode information
>  (i.e., owner, group, link count, mode, etc.).
> +.TP
> +Inode version (i_version)
> +(not returned in the \fIstat\fP structure); \fIstatx.stx_ino_version\fP
> +.IP
> +This is the inode change attribute. Any operation that would result in a change
> +to \fIstatx.stx_ctime\fP must result in a change to this value. The value must
> +change even in the case where the ctime change is not evident due to coarse
> +timestamp granularity.
> +.IP
> +An observer cannot infer anything from the returned value about the nature or
> +magnitude of the change. If the returned value is different from the last time
> +it was checked, then something has made an explicit change to the inode.

What is the wraparound behavior for i_version?  Does it use the full
64-bit range?

If the system crashes without flushing disks, is it possible to observe
new file contents without a change of i_version?

Thanks,
Florian

