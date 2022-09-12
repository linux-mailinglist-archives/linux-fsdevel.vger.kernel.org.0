Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB05B5B04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiILNVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiILNU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06783220E7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662988858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcJ4hYnOykjT5bKhT2L+jboPTMLweg9s7FN9sWH8lgs=;
        b=QmnG0huODhbYx2QvPv3nl2Et0bZ1beO11qK4k9XLnlDwnMcz6w8Jxh4G+NbDV8FOxOwpAb
        KXd7VZ6wvp4IBXXwVTt+FgsZhKAEPz5H82Xl8bE2+xWuUpITWCCZeWC8rSVDFBGaNPJdm/
        EOaGlxn1PYGjV2xDOuDKpV38McGSXtg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-L4qFUPMqPwu7x2MEi03oxQ-1; Mon, 12 Sep 2022 09:20:54 -0400
X-MC-Unique: L4qFUPMqPwu7x2MEi03oxQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62D7529ABA1F;
        Mon, 12 Sep 2022 13:20:53 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE4249BB60;
        Mon, 12 Sep 2022 13:20:48 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
References: <166259786233.30452.5417306132987966849@noble.neil.brown.name>
        <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
        <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
        <20220908155605.GD8951@fieldses.org>
        <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
        <20220908182252.GA18939@fieldses.org>
        <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
        <20220909154506.GB5674@fieldses.org>
        <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
        <20220910145600.GA347@fieldses.org>
        <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
        <87a67423la.fsf@oldenburg.str.redhat.com>
        <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
Date:   Mon, 12 Sep 2022 15:20:46 +0200
In-Reply-To: <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org> (Jeff
        Layton's message of "Mon, 12 Sep 2022 08:55:04 -0400")
Message-ID: <875yhs20gh.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeff Layton:

> On Mon, 2022-09-12 at 14:13 +0200, Florian Weimer wrote:
>> * Jeff Layton:
>>=20
>> > To do this we'd need 2 64-bit fields in the on-disk and in-memory=20
>> > superblocks for ext4, xfs and btrfs. On the first mount after a crash,
>> > the filesystem would need to bump s_version_max by the significant
>> > increment (2^40 bits or whatever). On a "clean" mount, it wouldn't need
>> > to do that.
>> >=20
>> > Would there be a way to ensure that the new s_version_max value has ma=
de
>> > it to disk? Bumping it by a large value and hoping for the best might =
be
>> > ok for most cases, but there are always outliers, so it might be
>> > worthwhile to make an i_version increment wait on that if necessary.=20
>>=20
>> How common are unclean shutdowns in practice?  Do ex64/XFS/btrfs keep
>> counters in the superblocks for journal replays that can be read easily?
>>=20
>> Several useful i_version applications could be negatively impacted by
>> frequent i_version invalidation.
>>=20
>
> One would hope "not very often", but Oopses _are_ something that happens
> occasionally, even in very stable environments, and it would be best if
> what we're building can cope with them.

I was wondering if such unclean shutdown events are associated with SSD
=E2=80=9Cunsafe shutdowns=E2=80=9D, as identified by the SMART counter.  I =
think those
aren't necessarily restricted to oopses or various forms of powerless
(maybe depending on file system/devicemapper configuration)?

I admit it's possible that the file system is shut down cleanly before
the kernel requests the power-off state from the firmware, but the
underlying SSD is not.

Thanks,
Florian

