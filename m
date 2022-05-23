Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1D531058
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiEWLFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiEWLFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 07:05:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA8117E33;
        Mon, 23 May 2022 04:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4726AB80F1A;
        Mon, 23 May 2022 11:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4DFC385A9;
        Mon, 23 May 2022 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653303935;
        bh=EdLcKfbCVThSAKV/Z0YYk7oUaXDqnxKSmBb3mVYsWUE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LAHnKRPIkbkfMVNjbAyfzyBGCdi2KgHR9Hk21uKh5rihEuvZS73c5L0mfGt0ucm7C
         cueg4jQS56PHv16C855VGL/+3WwpoUBquCXt/dM9L8motbs7R1uZAzh2zvBQ5Z4tNM
         ehS3+qSQ+H2QZvBJdHf+Rexpb+vkHupp9+p90ctoOrXkv5V0UBeLy7zNpI2WYGj5m8
         ICzukBSSGbTSVoiy6SRD/xP4usqk3sQEppvYkY04GvA7MTr/O3kezVFU9SI5n7x8KQ
         n1LoOx7Ete/Rb6ZvfbwaHETb2AY7VCyQdaiRjgwYv6Xza70EnVloWYW5X/zxQOScwN
         BZA0HmWFceqrw==
Message-ID: <e4fcdf88a9b35a9f1ca6e75fdf75ad469f824380.camel@kernel.org>
Subject: Re: [PATCH v2] netfs: Fix gcc-12 warning by embedding vfs inode in
 netfs_i_context
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     keescook@chromium.org, Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <smfrench@gmail.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 07:05:31 -0400
In-Reply-To: <658391.1653302817@warthog.procyon.org.uk>
References: <1b5daa4695b62795b617049e32c784052deabad4.camel@kernel.org>
         <165305805651.4094995.7763502506786714216.stgit@warthog.procyon.org.uk>
         <658391.1653302817@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-05-23 at 11:46 +0100, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
>=20
> >=20
> > Note that there are some conflicts between this patch and some of the
> > patches in the current ceph-client/testing branch. Depending on the
> > order of merge, one or the other will need to be fixed.
>=20
> Do you think it could be taken through the ceph tree?
>=20
> David
>=20

Since this touches a lot of non-ceph code, it may be best to just plan
to merge it ASAP, and we'll just base our merge branch on top of it.

Ilya/Xiubo, do you have an opinion here?
=20
--=20
Jeff Layton <jlayton@kernel.org>
